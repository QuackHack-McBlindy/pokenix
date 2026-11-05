(function() {
  'use strict';

  const DATA = window.POKENIX_DATA || {};

  const CRY = new Audio();
  CRY.preload = 'none';
  let cryInFlight = null;

  document.addEventListener('click', ev => {
    const el = ev.target.closest('.cell-sprite[data-cry]');
    if (!el) return;
    if (window.getSelection()?.toString()) return;
    if (document.body.classList.contains('pk-edit-mode')) {
      ev.preventDefault();
      ev.stopPropagation();
    }
    const url = el.dataset.cry;
    if (!url) return;
    if (cryInFlight) {
      try { CRY.pause(); CRY.currentTime = 0; } catch (_) {}
      cryInFlight = null;
    }
    CRY.src = url;
    CRY.currentTime = 0;
    const p = CRY.play();
    if (p && p.catch) p.catch(() => {});
    cryInFlight = el;
    el.classList.remove('cry-pulse');
    void el.offsetWidth;
    el.classList.add('cry-pulse');
    setTimeout(() => el.classList.remove('cry-pulse'), 400);
  }, true);

  (function setupSearch() {
    const input = document.getElementById('search-input');
    const box   = document.getElementById('search-results');
    if (!input || !box) return;

    const INDEX = window.POKENIX_INDEX || {};
    const CATEGORIES = [
      { key: 'breedables', label: 'Breedables' },
      { key: 'shiny',      label: 'Shiny living' },
      { key: 'events',     label: 'Events' },
      { key: 'specials',   label: 'Specials' },
    ];

    const all = [];
    for (const cat of CATEGORIES) {
      for (const item of (INDEX[cat.key] || [])) {
        all.push({ ...item, cat });
      }
    }

    const currentPage = location.pathname.split('/').pop() || 'index.html';
    let results   = [];
    let activeIdx = -1;

    function normalize(s) { return String(s || '').toLowerCase().trim(); }

    function score(item, q) {
      const name = normalize(item.name);
      const key  = normalize(item.key);
      const dex  = String(item.dex || '');
      if (name === q || key === q) return 100;
      if (name.startsWith(q))      return 80;
      if (key.startsWith(q))       return 70;
      if (dex  && dex.startsWith(q)) return 60;
      if (name.includes(q))        return 50;
      if (key.includes(q))         return 40;
      return -1;
    }

    function run(q) {
      q = normalize(q);
      if (!q) { results = []; activeIdx = -1; return; }
      const matches = [];
      for (const item of all) {
        const s = score(item, q);
        if (s > 0) matches.push({ item, s });
      }
      matches.sort((a, b) => {
        if (a.s !== b.s) return b.s - a.s;
        const da = a.item.dex ?? 99999;
        const db = b.item.dex ?? 99999;
        if (da !== db) return da - db;
        return a.item.name.localeCompare(b.item.name);
      });
      results   = matches.slice(0, 50).map(m => m.item);
      activeIdx = results.length ? 0 : -1;
    }

    function render() {
      if (!results.length) {
        if (!input.value.trim()) {
          box.classList.remove('open');
          box.innerHTML = '';
          return;
        }
        box.classList.add('open');
        box.innerHTML = '<div class="sr-empty">No matches</div>';
        return;
      }
      box.classList.add('open');
      const grouped = {};
      for (const r of results) (grouped[r.cat.key] ||= []).push(r);
      const html = [];
      for (const cat of CATEGORIES) {
        const list = grouped[cat.key];
        if (!list) continue;
        html.push(`<div class="sr-category">${cat.label}</div>`);
        for (const item of list) {
          const idx = results.indexOf(item);
          const pad = String(item.dex || 0).padStart(3, '0');
          html.push(`<div class="sr-item${idx === activeIdx ? ' active' : ''}" data-idx="${idx}">
            <span class="sr-dex">#${pad}</span>
            <span class="sr-name">${item.name}</span>
          </div>`);
        }
      }
      box.innerHTML = html.join('');
    }

    function scrollActiveIntoView() {
      const el = box.querySelector('.sr-item.active');
      if (el) el.scrollIntoView({ block: 'nearest' });
    }

    function go(item) {
      box.classList.remove('open');
      input.value = item.name;
      input.blur();
      if (item.page === currentPage) {
        const el = document.getElementById('pk-' + item.key);
        if (el) {
          el.open = true;
          el.classList.add('highlight');
          el.scrollIntoView({ behavior: 'smooth', block: 'center' });
          setTimeout(() => el.classList.remove('highlight'), 1600);
        }
        return;
      }
      location.href = item.page + '#pk-' + encodeURIComponent(item.key);
    }

    input.addEventListener('input', () => { run(input.value); render(); });
    input.addEventListener('focus', () => {
      if (input.value.trim() && results.length) { box.classList.add('open'); render(); }
    });
    input.addEventListener('keydown', ev => {
      if (ev.key === 'Escape') { box.classList.remove('open'); input.blur(); return; }
      if (ev.key === 'ArrowDown') {
        ev.preventDefault();
        if (!results.length) return;
        activeIdx = (activeIdx + 1) % results.length;
        render(); scrollActiveIntoView();
        return;
      }
      if (ev.key === 'ArrowUp') {
        ev.preventDefault();
        if (!results.length) return;
        activeIdx = (activeIdx - 1 + results.length) % results.length;
        render(); scrollActiveIntoView();
        return;
      }
      if (ev.key === 'Enter' && activeIdx >= 0 && results[activeIdx]) {
        ev.preventDefault();
        go(results[activeIdx]);
      }
    });
    box.addEventListener('mousemove', ev => {
      const item = ev.target.closest('.sr-item');
      if (!item) return;
      const idx = parseInt(item.dataset.idx, 10);
      if (idx !== activeIdx) { activeIdx = idx; render(); }
    });
    box.addEventListener('click', ev => {
      const item = ev.target.closest('.sr-item');
      if (!item) return;
      const idx = parseInt(item.dataset.idx, 10);
      if (!Number.isNaN(idx) && results[idx]) go(results[idx]);
    });
    document.addEventListener('click', ev => {
      if (!input.contains(ev.target) && !box.contains(ev.target)) box.classList.remove('open');
    });

    function honorFragment() {
      const m = location.hash.match(/^#pk-(.+)$/);
      if (!m) return;
      const key = decodeURIComponent(m[1]);
      const el  = document.getElementById('pk-' + key);
      if (!el) return;
      setTimeout(() => {
        el.open = true;
        el.classList.add('highlight');
        el.scrollIntoView({ behavior: 'smooth', block: 'center' });
        setTimeout(() => el.classList.remove('highlight'), 1600);
      }, 50);
    }
    honorFragment();
    window.addEventListener('hashchange', honorFragment);
  })();

  const PAGE = document.body.dataset.page;
  const COLLECTION = { shiny: 'shiny', events: 'events', specials: 'specials' }[PAGE];
  const IS_EDITABLE = COLLECTION != null || PAGE === 'breedables' || PAGE === 'trainer';
  if (!IS_EDITABLE) return;

  const STATS    = ['hp','atk','def','spa','spd','spe'];
  const SPECIES  = (DATA.speciesList  || []).map(s => s.toLowerCase());
  const VALID    = new Set((DATA.speciesValid || []).map(s => s.toLowerCase()));
  const META     = DATA.speciesMeta || {};
  const BALLS    = DATA.ballSprites || {};
  const NATURES  = DATA.natures || [];
  const IS_SHINY      = COLLECTION === 'shiny';
  const IS_BREEDABLES = PAGE === 'breedables';
  const IS_TRAINER    = PAGE === 'trainer';

  const STORAGE_KEY = 'pokenix-edit-v1';
  const SELECTION_KEY = 'pokenix-ball-selection';
  const COPY_HINT_DEFAULT = 'selected: CTRL + C to copy as list';

  const EDIT = {
    shiny:      JSON.parse(JSON.stringify(DATA.shiny         || {})),
    events:     JSON.parse(JSON.stringify(DATA.events        || {})),
    specials:   JSON.parse(JSON.stringify(DATA.specials      || {})),
    breedables: JSON.parse(JSON.stringify(DATA.breedablesFull || {})),
    trainer:    JSON.parse(JSON.stringify(DATA.trainer       || {})),
  };
  const ORIGINAL = {
    shiny:      DATA.shiny         || {},
    events:     DATA.events        || {},
    specials:   DATA.specials      || {},
    breedables: DATA.breedablesFull|| {},
    trainer:    DATA.trainer       || {},
  };

  try {
    const saved = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
    for (const coll of ['shiny','events','specials','breedables']) {
      if (saved[coll]) {
        for (const [k, v] of Object.entries(saved[coll])) EDIT[coll][k] = v;
      }
    }
    if (saved.trainer) Object.assign(EDIT.trainer, saved.trainer);
    if (Object.keys(saved).length) {
      console.log('[PokeNix] loaded saved edits:', saved);
    }
  } catch (e) {
    console.warn('[PokeNix] failed to load saved edits:', e);
  }

  function persist() {
    try {
      const delta = {};
      for (const coll of ['shiny','events','specials','breedables']) {
        const orig = ORIGINAL[coll];
        const curr = EDIT[coll] || {};
        const diff = {};
        for (const k of Object.keys(curr)) {
          if (JSON.stringify(curr[k]) !== JSON.stringify(orig[k])) {
            diff[k] = curr[k];
          }
        }
        if (Object.keys(diff).length) delta[coll] = diff;
      }
      const tDiff = {};
      for (const k of Object.keys(EDIT.trainer || {})) {
        if (EDIT.trainer[k] !== ORIGINAL.trainer[k]) tDiff[k] = EDIT.trainer[k];
      }
      if (Object.keys(tDiff).length) delta.trainer = tDiff;
      const json = JSON.stringify(delta);
      console.log('[PokeNix] persist:', json.length, 'bytes');
      localStorage.setItem(STORAGE_KEY, json);
    } catch (e) {
      console.error('[PokeNix] persist FAILED:', e.name, e.message);
    }
  }

  let selectedBalls = new Set();
  try {
    selectedBalls = new Set(JSON.parse(sessionStorage.getItem(SELECTION_KEY) || '[]'));
  } catch (_) {}

  function saveSel() {
    try { sessionStorage.setItem(SELECTION_KEY, JSON.stringify([...selectedBalls])); } catch (_) {}
  }

  function ballId(el) {
    return el.dataset.pokemon + '::' + el.dataset.ball;
  }

  function updateCopyHint() {
    const hint = document.getElementById('copy-hint');
    if (!hint) return;
    if (hint.dataset.copying === '1') return;
    hint.textContent = selectedBalls.size === 0
      ? COPY_HINT_DEFAULT
      : selectedBalls.size + ' selected: CTRL + C to copy';
  }

  function toggleBallSelection(el) {
    const st = el.dataset.state;
    if (st === 'unavailable' || st === 'missing') return;
    const id = ballId(el);
    if (selectedBalls.has(id)) {
      selectedBalls.delete(id);
      el.classList.remove('selected');
    } else {
      selectedBalls.add(id);
      el.classList.add('selected');
    }
    saveSel();
    updateCopyHint();
  }

  function applySelectionOnLoad() {
    document.querySelectorAll('.balls .ball[data-pokemon]').forEach(ballEl => {
      if (selectedBalls.has(ballId(ballEl))) ballEl.classList.add('selected');
      else ballEl.classList.remove('selected');
    });
    updateCopyHint();
  }

  let editMode = false;
  let datalistsInstalled = false;
  let hasExported = false;

  function installDatalists() {
    if (datalistsInstalled) return;
    datalistsInstalled = true;
    const dl = document.createElement('datalist');
    dl.id = 'pk-dl-species';
    SPECIES.forEach(s => { const o = document.createElement('option'); o.value = s; dl.appendChild(o); });
    document.body.appendChild(dl);
  }

  function normalizeSpecies(raw) {
    const v = String(raw || '').trim().toLowerCase();
    if (!v) return { ok: true, value: null, meta: null };
    if (VALID.has(v)) return { ok: true, value: v, meta: META[v] || null };
    const base = v.split('-')[0];
    if (VALID.has(base)) return { ok: true, value: v, meta: META[v] || META[base] || null };
    return { ok: false, value: null, meta: null };
  }

  let openDropdown = null;
  function closeAnyDropdown() {
    if (openDropdown) { openDropdown.remove(); openDropdown = null; }
  }
  document.addEventListener('click', closeAnyDropdown);

  let _pkHarvestTimer = null;
  function scheduleHarvest() {
    clearTimeout(_pkHarvestTimer);
    _pkHarvestTimer = setTimeout(() => { harvestAll(); }, 400);
  }
  document.addEventListener('input', ev => {
    if (!editMode) return;
    if (!ev.target.closest('.pk-edit-input, .pk-stat-edit input, .pk-edit-check')) return;
    scheduleHarvest();
  }, true);
  document.addEventListener('change', ev => {
    if (!editMode) return;
    if (!ev.target.closest('.pk-edit-input, .pk-stat-edit input, .pk-edit-check')) return;
    scheduleHarvest();
  }, true);

  function makeBallField(rec, k) {
    const wrap = document.createElement('span');
    wrap.className = 'pk-ball-field';
    wrap.dataset.value = rec[k] || '';

    const preview = document.createElement('span');
    preview.className = 'pk-ball-preview';
    preview.title = 'click to pick ball';

    function renderPreview() {
      preview.innerHTML = '';
      const v = wrap.dataset.value;
      if (v && BALLS[v]) {
        const img = document.createElement('img');
        img.src = BALLS[v]; img.alt = v;
        preview.appendChild(img);
      } else {
        preview.textContent = '—';
      }
    }

    preview.addEventListener('click', ev => {
      ev.preventDefault();
      ev.stopPropagation();
      if (openDropdown) { closeAnyDropdown(); return; }

      const dropdown = document.createElement('div');
      dropdown.className = 'pk-ball-dropdown';
      Object.keys(BALLS).sort().forEach(b => {
        const btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'pk-ball-option';
        btn.dataset.ball = b;
        btn.title = b;
        if (b === wrap.dataset.value) btn.classList.add('active');
        const img = document.createElement('img');
        img.src = BALLS[b]; img.alt = b;
        btn.appendChild(img);
        btn.addEventListener('click', ev2 => {
          ev2.preventDefault();
          ev2.stopPropagation();
          wrap.dataset.value = b;
          rec[k] = b;
          renderPreview();
          closeAnyDropdown();
          persist();
        });
        dropdown.appendChild(btn);
      });
      document.body.appendChild(dropdown);
      const r = preview.getBoundingClientRect();
      dropdown.style.position = 'fixed';
      dropdown.style.top  = (r.bottom + 4) + 'px';
      dropdown.style.left = Math.min(r.left, window.innerWidth - 300) + 'px';
      openDropdown = dropdown;
    });

    renderPreview();
    wrap.appendChild(preview);
    return wrap;
  }

  function inp(el) { el.className = 'pk-edit-input'; return el; }

  function makeText(rec, k, opts = {}) {
    const i = inp(document.createElement('input'));
    i.type = 'text';
    if (opts.list) i.setAttribute('list', opts.list);
    if (opts.placeholder) i.placeholder = opts.placeholder;
    const v = rec[k];
    i.value = v == null ? '' : (Array.isArray(v) ? v.join(' ') : String(v));
    return i;
  }
  function makeNum(rec, k, opts = {}) {
    const i = inp(document.createElement('input'));
    i.type = 'number';
    if (opts.min != null) i.min = opts.min;
    if (opts.max != null) i.max = opts.max;
    i.value = rec[k] == null ? '' : String(rec[k]);
    i.addEventListener('input', () => {
      let n = parseInt(i.value, 10);
      if (Number.isNaN(n)) return;
      if (opts.min != null && n < opts.min) { n = opts.min; i.value = n; }
      if (opts.max != null && n > opts.max) { n = opts.max; i.value = n; }
    });
    return i;
  }
  function makeSel(rec, k, values) {
    const s = inp(document.createElement('select'));
    const cur = rec[k] || '';
    if (cur && !values.includes(cur)) {
      const o = document.createElement('option'); o.value = cur; o.textContent = cur; s.appendChild(o);
    }
    const blank = document.createElement('option'); blank.value = ''; blank.textContent = '—'; s.appendChild(blank);
    values.forEach(v => { const o = document.createElement('option'); o.value = v; o.textContent = v; s.appendChild(o); });
    s.value = cur;
    return s;
  }
  function makeChk(rec, k) {
    const c = document.createElement('input');
    c.type = 'checkbox'; c.className = 'pk-edit-check'; c.checked = !!rec[k];
    return c;
  }
  function put(cell, el) { cell.innerHTML = ''; cell.appendChild(el); }

  function cleanLabel(txt) { return (txt || '').replace(/^\w+\s*[·:]\s*/, '').trim(); }
  function detailKey(label) {
    return ({
      'Level': 'level', 'Nature': 'nature', 'Ability': 'ability',
      'Held Item': 'heldItem', 'Tera Type': 'teraType',
      'Moves': 'moves', 'Marks': 'marks', 'Ribbons': 'ribbons',
      'OT': 'ot', 'Obtained': 'obtained', 'Region': 'region',
      'ID': 'id', 'Proof': 'proof', 'Trade History': 'tradeHistory',
      'Notes': 'notes', 'Event / Notes': 'notes',
    })[label] || null;
  }

  function wireDetails(row, rec) {
    row.querySelectorAll('.detail').forEach(d => {
      const label = cleanLabel(d.querySelector('.detail-label')?.textContent);
      const key = detailKey(label);
      if (!key) return;
      const val = d.querySelector('.detail-value');
      if (!val) return;
      if (key === 'nature')      put(val, makeSel(rec, key, NATURES));
      else if (key === 'level')  put(val, makeNum(rec, key, { min: 1, max: 100 }));
      else if (key === 'id')     put(val, makeNum(rec, key));
      else                       put(val, makeText(rec, key));
    });

    ['IVs','EVs'].forEach(statKey => {
      const isIv = statKey === 'IVs';
      const key  = isIv ? 'ivs' : 'evs';
      const max  = isIv ? 31 : 252;
      row.querySelectorAll('.detail').forEach(d => {
        if (d.querySelector('.detail-label')?.textContent.trim() !== statKey) return;
        const val = d.querySelector('.detail-value');
        if (!val) return;
        val.innerHTML = '';
        STATS.forEach(s => {
          const lbl = document.createElement('label');
          lbl.className = 'pk-stat-edit';
          lbl.textContent = s;
          const i = inp(document.createElement('input'));
          i.type = 'number'; i.min = 0; i.max = max;
          i.style.width = '48px';
          i.dataset.stat = s; i.dataset.group = key;
          i.value = (rec[key] || {})[s] ?? '';
          i.addEventListener('input', () => {
            let n = parseInt(i.value, 10);
            if (Number.isNaN(n)) return;
            if (n < 0)   { n = 0;   i.value = n; }
            if (n > max) { n = max; i.value = n; }
          });
          lbl.appendChild(i);
          val.appendChild(lbl);
        });
      });
    });
  }

  function wireShinyRow(row, key) {
    const rec = EDIT.shiny[key] || {};
    EDIT.shiny[key] = rec;
    const ball = row.querySelector('summary .event-ball-slot');
    if (ball) put(ball, makeBallField(rec, 'ball'));
    const notes = row.querySelector('summary .shiny-notes');
    if (notes) put(notes, makeText(rec, 'notes'));
    const ot = row.querySelector('summary .check[title="OT"]');
    if (ot) put(ot, makeChk(rec, 'ot'));
    const egg = row.querySelector('summary .check[title="Egg obtained"]');
    if (egg) put(egg, makeChk(rec, 'egg'));
    const style = row.querySelector('summary .shiny-style');
    if (style) put(style, makeSel(rec, 'style', ['star', 'square']));
    wireDetails(row, rec);
  }

  function wireEventRow(row, key) {
    const rec = EDIT[COLLECTION][key] || {};
    EDIT[COLLECTION][key] = rec;
    const ball = row.querySelector('summary .event-ball-slot');
    if (ball) put(ball, makeBallField(rec, 'ball'));
    const name = row.querySelector('summary .event-name');
    if (name) {
      const el = makeText(rec, 'species', { list: 'pk-dl-species', placeholder: 'species' });
      el.addEventListener('input',  () => autofillSpecies(row, el.value, rec));
      el.addEventListener('change', () => autofillSpecies(row, el.value, rec));
      put(name, el);
    }
    const shiny = row.querySelector('summary .check[title="shiny"]');
    if (shiny) put(shiny, makeChk(rec, 'shiny'));
    const self = row.querySelector('summary .check[title="self obtained"]');
    if (self) put(self, makeChk(rec, 'selfObtained'));

    const fields = row.querySelectorAll('summary .event-field');
    if (COLLECTION === 'events') {
      if (fields[0]) put(fields[0], makeNum(rec, 'year'));
      if (fields[1]) put(fields[1], makeText(rec, 'ot'));
      if (fields[2]) put(fields[2], makeText(rec, 'region'));
    } else {
      if (fields[0]) put(fields[0], makeNum(rec, 'level', { min: 1, max: 100 }));
      if (fields[1]) put(fields[1], makeSel(rec, 'nature', NATURES));
    }
    wireDetails(row, rec);
  }

  function autofillSpecies(row, raw, rec) {
    const { ok, value, meta } = normalizeSpecies(raw);
    if (!ok || !value || !meta) return;
    if (meta.dex != null) {
      rec.dex = meta.dex;
      const pad = String(meta.dex).padStart(3, '0');
      row.dataset.dex = pad;
      const dexEl = row.querySelector('summary .event-dex');
      if (dexEl) dexEl.textContent = '#' + pad;
      const svgText = row.querySelector('summary .cell-sprite svg text');
      if (svgText) svgText.textContent = '#' + pad;
    }
    if (meta.name && rec.name == null) rec.name = meta.name;
    if (Array.isArray(meta.types) && meta.types.length) {
      const typeCell = row.querySelector('summary .event-type');
      if (typeCell) {
        typeCell.innerHTML = meta.types.map(t =>
          `<span class="type-badge type-${t.toLowerCase()}" title="${t}">${t}</span>`
        ).join('');
      }
    }
  }

  function harvestDetails(row, rec) {
    row.querySelectorAll('.detail').forEach(d => {
      const label = cleanLabel(d.querySelector('.detail-label')?.textContent);
      const key = detailKey(label);
      if (!key) return;
      const i = d.querySelector('.detail-value input, .detail-value select');
      if (!i) return;
      let v;
      if (i.type === 'number') { const n = parseInt(i.value, 10); v = Number.isNaN(n) ? null : n; }
      else if (i.type === 'checkbox') v = i.checked;
      else v = i.value.trim();
      if (key === 'moves' || key === 'marks' || key === 'ribbons') {
        v = (typeof v === 'string' && v) ? v.split(/\s+/) : [];
      }
      if (v === '' || v == null || (Array.isArray(v) && !v.length)) delete rec[key];
      else rec[key] = v;
    });
    ['ivs','evs'].forEach(statKey => {
      const any = row.querySelector(`.detail input[data-group="${statKey}"]`);
      if (!any) return;
      const out = {};
      STATS.forEach(s => {
        const i = row.querySelector(`.detail input[data-group="${statKey}"][data-stat="${s}"]`);
        if (!i) return;
        const n = parseInt(i.value, 10);
        if (!Number.isNaN(n)) out[s] = n;
      });
      if (Object.keys(out).length) rec[statKey] = out;
      else delete rec[statKey];
    });
  }

  function harvestRow(row) {
    const key = row.id.replace(/^pk-/, '');
    const isNew = key.startsWith('new-');
    let rec;

    if (IS_SHINY && !isNew) {
      rec = EDIT.shiny[key] || {};
      const bf = row.querySelector('summary .event-ball-slot .pk-ball-field');
      if (bf) rec.ball = bf.dataset.value || null;
      const notes = row.querySelector('summary .shiny-notes input');
      if (notes) rec.notes = notes.value.trim() || null;
      const ot = row.querySelector('summary .check[title="OT"] input');
      if (ot) rec.ot = ot.checked || false;
      const egg = row.querySelector('summary .check[title="Egg obtained"] input');
      if (egg) rec.egg = egg.checked || false;
      const style = row.querySelector('summary .shiny-style select');
      if (style) rec.style = style.value || null;
      harvestDetails(row, rec);
      EDIT.shiny[key] = rec;
    } else {
      rec = EDIT[COLLECTION][key] || {};
      const bf = row.querySelector('summary .event-ball-slot .pk-ball-field');
      if (bf) rec.ball = bf.dataset.value || null;
      const sp = row.querySelector('summary .event-name input');
      if (sp) rec.species = sp.value.trim() || null;
      const sh = row.querySelector('summary .check[title="shiny"] input');
      if (sh) rec.shiny = sh.checked || false;
      const se = row.querySelector('summary .check[title="self obtained"] input');
      if (se) rec.selfObtained = se.checked || false;
      const fields = row.querySelectorAll('summary .event-field');
      if (COLLECTION === 'events') {
        if (fields[0]) { const n = parseInt(fields[0].querySelector('input')?.value, 10); rec.year = Number.isNaN(n) ? null : n; }
        if (fields[1]) rec.ot = fields[1].querySelector('input')?.value.trim() || null;
        if (fields[2]) rec.region = fields[2].querySelector('input')?.value.trim() || null;
      } else {
        if (fields[0]) { const n = parseInt(fields[0].querySelector('input')?.value, 10); rec.level = Number.isNaN(n) ? null : n; }
        if (fields[1]) rec.nature = fields[1].querySelector('select')?.value || null;
      }
      harvestDetails(row, rec);
      EDIT[COLLECTION][key] = rec;
    }
  }

  function harvestAll() {
    document.querySelectorAll('details[data-dex]').forEach(row => {
      if (row.querySelector('.pk-ball-field, input, select')) harvestRow(row);
    });
    if (editMode && IS_TRAINER) harvestTrainerInputs();
    persist();
  }

  function enterEdit() {
    editMode = true;
    hasExported = false;
    document.body.classList.add('pk-edit-mode');
    installDatalists();

    if (IS_TRAINER) {
      enterTrainerEdit();
    } else if (IS_BREEDABLES) {
      enterBreedablesEdit();
    } else {
      document.querySelectorAll('details[data-dex]').forEach(row => {
        if (!row._pkOrigHtml) row._pkOrigHtml = row.innerHTML;
        const key = row.id.replace(/^pk-/, '');
        if (IS_SHINY && !key.startsWith('new-')) wireShinyRow(row, key);
        else if (!IS_SHINY) wireEventRow(row, key);
      });
      if (COLLECTION && !IS_SHINY) document.getElementById('pk-edit-new')?.removeAttribute('hidden');
    }

    const btn = document.getElementById('pk-edit-toggle');
    if (btn) { btn.classList.add('active'); btn.textContent = '✓ Done'; }
  }

  function renderNewRow(row, rec) {
    const spec = COLLECTION === 'specials';
    const pad  = String(rec.dex || 0).padStart(3, '0');
    const dexDisplay = rec.dex ? '#' + pad : '#---';
    const ballHtml = rec.ball && BALLS[rec.ball]
      ? `<span class="event-ball-slot"><img src="${BALLS[rec.ball]}" alt="${rec.ball}"></span>`
      : `<span class="event-ball-slot empty"></span>`;
    const meta  = META[rec.species] || {};
    const types = meta.types || rec.types || [];
    const typeBadges = types.map(t =>
      `<span class="type-badge type-${t.toLowerCase()}" title="${t}">${t}</span>`
    ).join('');
    const spriteSvg = `<svg class="sprite placeholder" viewBox="0 0 32 32"><rect width="32" height="32" fill="#2a2a2a"/><text x="16" y="21" font-size="9" text-anchor="middle" fill="#666">${dexDisplay}</text></svg>`;

    const summaryFields = spec
      ? `<span class="event-field">${rec.level ?? '—'}</span>
         <span class="event-field">${rec.nature ?? '—'}</span>
         <span class="event-ribbon-strip ribbon-header-spacer" aria-hidden="true"></span>`
      : `<span class="event-field">${rec.year ?? '—'}</span>
         <span class="event-field">${rec.ot ?? '—'}</span>
         <span class="event-field">${rec.region ?? '—'}</span>`;

    const statRows = spec
      ? `<div class="detail detail-wide"><span class="detail-label">EVs</span><span class="detail-value">${rec.evs ? Object.entries(rec.evs).map(([k,v])=>`${k.toUpperCase()}:${v}`).join(' ') : '—'}</span></div>
         <div class="detail detail-wide"><span class="detail-label">IVs</span><span class="detail-value">${rec.ivs ? Object.entries(rec.ivs).map(([k,v])=>`${k.toUpperCase()}:${v}`).join(' ') : '—'}</span></div>`
      : '';

    const dr = (f, val) =>
      `<div class="detail"><span class="detail-label">${f}</span><span class="detail-value">${val ?? '—'}</span></div>`;

    row.innerHTML = `
      <summary class="event-row${spec ? ' special-row' : ''}">
        <span class="event-dex">${dexDisplay}</span>
        <span class="cell-sprite">${spriteSvg}</span>
        ${ballHtml}
        <span class="event-name" title="${rec.species || ''}">${rec.species || '—'}</span>
        <span class="event-type">${typeBadges}</span>
        <span class="check ${rec.shiny ? 'yes shiny-mark' : 'no'}" title="shiny">${rec.shiny ? '✨' : ''}</span>
        <span class="check ${rec.selfObtained ? 'yes' : 'no'}" title="self obtained">${rec.selfObtained ? '✓' : ''}</span>
        ${summaryFields}
        <span class="event-chevron">▸</span>
      </summary>
      <div class="event-details${spec ? ' special-details' : ''}">
        ${statRows}
        ${dr('Level', rec.level)}
        ${dr('Nature', rec.nature)}
        ${dr('Ability', rec.ability)}
        ${dr('Held Item', rec.heldItem)}
        ${dr('Tera Type', rec.teraType)}
        <div class="detail detail-wide"><span class="detail-label">Moves</span><span class="detail-value">${(rec.moves || []).join(' · ') || '—'}</span></div>
        <div class="detail detail-wide"><span class="detail-label">Marks</span><span class="detail-value">${(rec.marks || []).join(' · ') || '—'}</span></div>
        <div class="detail detail-wide"><span class="detail-label">Ribbons</span><span class="detail-value">${(rec.ribbons || []).join(' · ') || '—'}</span></div>
        ${dr('OT', rec.ot)}
        ${dr('ID', rec.id)}
        ${dr('Region', rec.region)}
        ${dr('Obtained', rec.obtained)}
        ${dr('Proof', rec.proof)}
        ${dr('Trade History', rec.tradeHistory)}
        ${dr('Notes', rec.notes)}
      </div>`;

    if (rec.dex) row.dataset.dex = pad;
    if (rec.species) row.dataset.name = rec.species;
  }

  const BALL_CYCLE = ['possible', 'caught', 'ha', 'em'];
  const BALL_STATE_LABEL = {
    possible: 'not caught',
    caught:   'caught',
    ha:       'caught · HA',
    em:       'caught · HA + egg moves',
  };

  function enterBreedablesEdit() { }
  function exitBreedablesEdit()  { }

  function cycleBallState(ballEl) {
    const cur = ballEl.dataset.state;
    if (cur === 'unavailable' || cur === 'missing') return;
    const idx  = BALL_CYCLE.indexOf(cur);
    const next = BALL_CYCLE[(idx + 1) % BALL_CYCLE.length];

    ballEl.dataset.state = next;
    BALL_CYCLE.forEach(s => ballEl.classList.remove(s));
    ballEl.classList.add(next);
    ballEl.title = `${ballEl.dataset.ball} — ${BALL_STATE_LABEL[next]}`;

    const row = ballEl.closest('.breedable-row');
    if (!row) return;
    const rowKey = row.id.replace(/^pk-/, '');
    const species = EDIT.breedables?.[rowKey];
    if (!species) return;
    species.captured = species.captured || {};
    if (next === 'possible') {
      delete species.captured[ballEl.dataset.ball];
    } else {
      const entry = { ball: true };
      if (next === 'ha' || next === 'em') entry.ha = true;
      if (next === 'em') entry.eggMoves = true;
      species.captured[ballEl.dataset.ball] = entry;
    }

    const summary = row.querySelector('summary.entry');
    if (summary) {
      const anyCaught = Object.keys(species.captured || {}).length > 0;
      summary.classList.toggle('untouched', !anyCaught);
    }

    persist();
  }

  function copyText(text) {
    if (navigator.clipboard && navigator.clipboard.writeText) {
      return navigator.clipboard.writeText(text).then(() => true).catch(() => false);
    }
    try {
      const ta = document.createElement('textarea');
      ta.value = text;
      ta.style.position = 'fixed';
      ta.style.opacity = '0';
      document.body.appendChild(ta);
      ta.select();
      const ok = document.execCommand('copy');
      document.body.removeChild(ta);
      return Promise.resolve(ok);
    } catch (_) {
      return Promise.resolve(false);
    }
  }

  document.addEventListener('click', ev => {
    if (!IS_BREEDABLES) return;
    const ballEl = ev.target.closest('.balls .ball');
    if (!ballEl) return;
    ev.preventDefault();
    ev.stopPropagation();
    if (editMode) {
      cycleBallState(ballEl);
    } else {
      toggleBallSelection(ballEl);
    }
  }, true);

  document.addEventListener('keydown', ev => {
    if (!(ev.ctrlKey || ev.metaKey) || (ev.key !== 'c' && ev.key !== 'C')) return;
    if (!IS_BREEDABLES || editMode) return;
    if (selectedBalls.size === 0) return;
    if (window.getSelection()?.toString()) return;
    const tag = ev.target.tagName;
    if (tag === 'INPUT' || tag === 'TEXTAREA' || tag === 'SELECT') return;
    ev.preventDefault();

    const byPokemon = {};
    for (const id of selectedBalls) {
      const sep = id.indexOf('::');
      const pkmn = id.substring(0, sep);
      const ball = id.substring(sep + 2);
      (byPokemon[pkmn] = byPokemon[pkmn] || []).push(ball);
    }

    const lines = Object.entries(byPokemon)
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([p, balls]) => {
        const parts = balls.sort().map(ball => {
          const el = document.querySelector(
            '.balls .ball[data-pokemon="' + CSS.escape(p) + '"][data-ball="' + CSS.escape(ball) + '"]'
          );
          const st = el?.dataset.state || 'caught';
          const suffix = st === 'ha' ? ' (HA)' : st === 'em' ? ' (HA+EM)' : st === 'possible' ? ' (want)' : '';
          return ball + suffix;
        });
        return p + ' — ' + parts.join(', ');
      });

    const text = lines.join('\n');

    copyText(text).then(ok => {
      const hint = document.getElementById('copy-hint');
      if (!hint) return;
      hint.dataset.copying = '1';
      hint.textContent = ok ? '✓ copied!' : '✗ copy failed';
      setTimeout(() => {
        delete hint.dataset.copying;
        updateCopyHint();
      }, 1500);
    });
  });

  const TRAINER_FIELD_MAP = {
    'Region': 'region', 'Timezone': 'timezone', 'Contact': 'contact',
    'Friend Code': 'friendCode', 'Switch': 'switchName',
    'Trainer ID': 'trainerId', 'Secret ID': 'secretId',
  };
  const TRAINER_MISSING = [
    ['githubUsername', 'GitHub Username', 'text'],
    ['githubRepo',     'GitHub Repo',     'text'],
    ['shinyDexType',   'Shiny Dex Type',  'select'],
  ];

  function enterTrainerEdit() {
    const card = document.querySelector('.trainer-card');
    if (!card) return;

    const mkText = (key, val, extra = {}) => {
      const i = document.createElement('input');
      i.className = 'pk-edit-input';
      i.type = 'text';
      i.dataset.trainer = key;
      i.value = val ?? '';
      Object.assign(i.style, extra);
      return i;
    };

    const nameEl = card.querySelector('.trainer-name');
    if (nameEl) {
      const i = mkText('name', EDIT.trainer.name,
        { textAlign: 'center', fontSize: '24px', width: '100%' });
      nameEl.replaceWith(i);
    }

    const aboutEl = card.querySelector('.trainer-about');
    if (aboutEl) {
      const ta = document.createElement('textarea');
      ta.className = 'pk-edit-input';
      ta.dataset.trainer = 'about';
      ta.rows = 3;
      ta.value = EDIT.trainer.about ?? '';
      ta.style.textAlign = 'center';
      ta.style.width = '100%';
      aboutEl.replaceWith(ta);
    }

    card.querySelectorAll('.trainer-field').forEach(field => {
      const label = field.querySelector('.trainer-field-label')?.textContent.trim();
      const key = TRAINER_FIELD_MAP[label];
      if (!key) return;
      const valEl = field.querySelector('.trainer-field-value');
      if (!valEl) return;
      valEl.innerHTML = '';
      valEl.appendChild(mkText(key, EDIT.trainer[key]));
    });

    const tfs = card.querySelector('.trainer-fields');
    if (tfs) {
      const existing = new Set(
        Array.from(card.querySelectorAll('[data-trainer]')).map(e => e.dataset.trainer)
      );
      for (const [key, label, type] of TRAINER_MISSING) {
        if (existing.has(key)) continue;
        const field = document.createElement('div');
        field.className = 'trainer-field';
        field.dataset.added = '1';
        field.innerHTML = `<span class="trainer-field-label">${label}</span>
          <span class="trainer-field-value"></span>`;
        const valEl = field.querySelector('.trainer-field-value');
        if (type === 'select' && key === 'shinyDexType') {
          const s = document.createElement('select');
          s.className = 'pk-edit-input';
          s.dataset.trainer = key;
          for (const v of ['gender-diff','national']) {
            const o = document.createElement('option');
            o.value = v; o.textContent = v;
            if ((EDIT.trainer[key] ?? 'gender-diff') === v) o.selected = true;
            s.appendChild(o);
          }
          valEl.appendChild(s);
        } else {
          valEl.appendChild(mkText(key, EDIT.trainer[key]));
        }
        tfs.appendChild(field);
      }
    }

    const picWrap = card.querySelector('.trainer-pic-wrap');
    if (picWrap && !card.querySelector('[data-pic-note]')) {
      const note = document.createElement('p');
      note.dataset.picNote = '1';
      note.style.cssText = 'font-size:11px;color:var(--fg-3);text-align:center;margin:8px 0 0';
      note.textContent = 'Picture can only be changed by editing ./profile-picture.png in your Nix config.';
      picWrap.after(note);
    }
  }

  function harvestTrainerInputs() {
    const card = document.querySelector('.trainer-card');
    if (!card) return;
    card.querySelectorAll('[data-trainer]').forEach(el => {
      const key = el.dataset.trainer;
      const v = (el.value || '').trim();
      if (key === 'shinyDexType') EDIT.trainer[key] = v || 'gender-diff';
      else EDIT.trainer[key] = v || null;
    });
  }

  function exitTrainerEdit() {
    const card = document.querySelector('.trainer-card');
    if (!card) return;
    harvestTrainerInputs();

    const nameInp = card.querySelector('input[data-trainer="name"]');
    if (nameInp) {
      const h = document.createElement('h2');
      h.className = 'trainer-name';
      h.textContent = EDIT.trainer.name ?? '';
      nameInp.replaceWith(h);
    }
    const aboutTa = card.querySelector('textarea[data-trainer="about"]');
    if (aboutTa) {
      const p = document.createElement('p');
      p.className = 'trainer-about';
      p.textContent = EDIT.trainer.about ?? '';
      aboutTa.replaceWith(p);
    }
    card.querySelectorAll('.trainer-field').forEach(field => {
      const ctrl = field.querySelector('[data-trainer]');
      if (!ctrl) return;
      const span = document.createElement('span');
      span.className = 'trainer-field-value';
      span.textContent = ctrl.value || '—';
      ctrl.replaceWith(span);
    });
    card.querySelector('[data-pic-note]')?.remove();
  }

  function exitEdit() {
    if (IS_TRAINER) exitTrainerEdit();
    else if (IS_BREEDABLES) exitBreedablesEdit();
    else exitCollectionEdit();

    editMode = false;
    document.body.classList.remove('pk-edit-mode');
    document.getElementById('pk-edit-new')?.setAttribute('hidden', '');
    const btn = document.getElementById('pk-edit-toggle');
    if (btn) { btn.classList.remove('active'); btn.textContent = '✎ Edit'; }
    persist();
  }

  function exitCollectionEdit() {
    harvestAll();

    document.querySelectorAll('details[data-dex][id^="pk-new-"]').forEach(row => {
      const key = row.id.replace(/^pk-/, '');
      const rec = EDIT[COLLECTION]?.[key];
      if (!rec || !rec.species) {
        delete EDIT[COLLECTION][key];
        row.remove();
      }
    });

    document.querySelectorAll('details[data-dex][id^="pk-new-"]').forEach(row => {
      const key = row.id.replace(/^pk-/, '');
      const rec = EDIT[COLLECTION]?.[key];
      if (rec) renderNewRow(row, rec);
    });

    document.querySelectorAll('details[data-dex]:not([id^="pk-new-"])').forEach(row => {
      if (!row._pkOrigHtml) return;
      row.innerHTML = row._pkOrigHtml;
      delete row._pkOrigHtml;
    });
    applyEditsOnLoad();
  }

  function refreshEditButton() {
    const btn = document.getElementById('pk-edit-toggle');
    if (!btn || editMode) return;
    try {
      const saved = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
      const has = ['shiny','events','specials','breedables','trainer'].some(k =>
        saved[k] && Object.keys(saved[k]).length);
      btn.textContent = has ? '✎ Edit ●' : '✎ Edit';
      btn.title = has ? 'You have saved changes from a previous session' : 'Toggle inline edit mode';
    } catch (e) {}
  }
  refreshEditButton();

  function addNewRow() {
    if (IS_SHINY) return;
    const key = 'new-' + Date.now();
    EDIT[COLLECTION][key] = {};
    const spec = COLLECTION === 'specials';
    const row = document.createElement('details');
    row.id = 'pk-' + key;
    row.dataset.dex = '000';
    row.dataset.name = '';
    row.open = true;
    row.className = spec ? 'event special' : 'event';
    row.innerHTML = `
      <summary class="event-row${spec ? ' special-row' : ''}">
        <span class="event-dex">#---</span>
        <span class="cell-sprite"><svg class="sprite placeholder" viewBox="0 0 32 32"><rect width="32" height="32" fill="#2a2a2a"/><text x="16" y="21" font-size="9" text-anchor="middle" fill="#666">#---</text></svg></span>
        <span class="event-ball-slot empty"></span>
        <span class="event-name"></span>
        <span class="event-type"></span>
        <span class="check no" title="shiny"></span>
        <span class="check no" title="self obtained"></span>
        <span class="event-field"></span><span class="event-field"></span><span class="event-field"></span>
        <span class="event-chevron">▸</span>
      </summary>
      <div class="event-details${spec ? ' special-details' : ''}">
        ${spec ? `<div class="detail detail-wide"><span class="detail-label">EVs</span><span class="detail-value"></span></div><div class="detail detail-wide"><span class="detail-label">IVs</span><span class="detail-value"></span></div>` : ''}
        ${['Level','Nature','Ability','Held Item','Tera Type'].map(f => `<div class="detail"><span class="detail-label">${f}</span><span class="detail-value"></span></div>`).join('')}
        <div class="detail detail-wide"><span class="detail-label">Moves</span><span class="detail-value"></span></div>
        <div class="detail detail-wide"><span class="detail-label">Marks</span><span class="detail-value"></span></div>
        <div class="detail detail-wide"><span class="detail-label">Ribbons</span><span class="detail-value"></span></div>
        ${['OT','ID','Region','Obtained','Proof','Trade History','Notes'].map(f => `<div class="detail"><span class="detail-label">${f}</span><span class="detail-value"></span></div>`).join('')}
      </div>`;
    (document.querySelector('.event-list') || document.body).prepend(row);
    wireEventRow(row, key);
  }

  document.addEventListener('blur', ev => {
    if (!editMode) return;
    const inp = ev.target;
    if (!inp.matches('input[list="pk-dl-species"]')) return;
    const { ok, value } = normalizeSpecies(inp.value);
    if (!inp.value.trim()) { inp.style.borderColor = ''; return; }
    if (ok) { inp.value = value; inp.style.borderColor = ''; }
    else    { inp.style.borderColor = 'var(--accent-red)'; }
  }, true);

  document.addEventListener('click', ev => {
    if (!editMode) return;
    const slot = ev.target.closest('.event-ball-slot');
    if (!slot) return;
    const preview = slot.querySelector('.pk-ball-preview');
    if (!preview) return;
    if (ev.target === preview || preview.contains(ev.target)) return;
    ev.preventDefault();
    preview.click();
  }, true);

  function nixStr(s) {
    return '"' + String(s)
      .replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\$/g, '\\$')
      .replace(/\n/g, '\\n').replace(/\r/g, '').replace(/\t/g, '\\t') + '"';
  }
  function nixKey(k) { return /^[A-Za-z_][A-Za-z0-9_'-]*$/.test(k) ? k : nixStr(k); }
  function nixVal(v, d) {
    const pad = '  '.repeat(d);
    if (v == null) return 'null';
    if (typeof v === 'boolean') return v ? 'true' : 'false';
    if (typeof v === 'number')  return String(v);
    if (typeof v === 'string')  return nixStr(v);
    if (Array.isArray(v)) return v.length === 0 ? '[ ]' : '[ ' + v.map(x => nixVal(x, 0)).join(' ') + ' ]';
    const keys = Object.keys(v).filter(k => !k.startsWith('_') && v[k] !== undefined && v[k] !== null);
    if (!keys.length) return '{ }';
    return '{\n' + keys.map(k => pad + '  ' + nixKey(k) + ' = ' + nixVal(v[k], d + 1) + ';').join('\n') + '\n' + pad + '}';
  }

  function buildBreedablesNix() {
    const src = EDIT.breedables || {};
    const out = {};
    for (const [species, info] of Object.entries(src)) {
      const captured = info.captured || {};
      const clean = {};
      for (const [ball, st] of Object.entries(captured)) {
        const entry = {};
        if (st.eggMoves)      entry.eggMoves = true;
        else if (st.ha)       entry.ha       = true;
        else if (st.ball)     entry.ball     = true;
        else                  continue;
        clean[ball] = entry;
      }
      if (Object.keys(clean).length) out[species] = clean;
    }
    return out;
  }

  function buildTrainerNix() {
    const t = EDIT.trainer || {};
    const keys = [
      'name','about','region','timezone','contact','friendCode',
      'switchName','trainerId','secretId','githubUsername','githubRepo','shinyDexType',
    ];
    const parts = [];
    for (const k of keys) {
      const v = t[k];
      if (v == null || v === '') continue;
      parts.push(`    ${k} = ${nixStr(String(v))};`);
    }
    const comment =
      '    # picture is preserved from your existing config — the browser editor does not modify it\n';
    return '{\n' + comment + parts.join('\n') + '\n  }';
  }

  function buildNix() {
    harvestAll();
    const breedables = buildBreedablesNix();
    const parts = [
      '# GENERATED BY PokéNix WEB EDITOR · ' + new Date().toISOString().slice(0, 10),
      '# ★ ─────────────────────────────────────────────────────────────────────── ★',
      '#             »  ★ PokéNix ★ «',
      '#  »  ★ Your Pokémon Collection Builder ★ «',
      '#  ⮞ https://github.com/quackhack-mcblindy/pokenix',
      '# ★ ─────────────────────────────────────────────────────────────────────── ★',
      '{ lib, ... }: {',
    ];
    parts.push('  pokenix.breedables = ' + nixVal(breedables, 1) + ';');
    parts.push('  pokenix.trainer = ' + buildTrainerNix() + ';');
    for (const coll of ['shiny','events','specials']) {
      parts.push('  pokenix.' + coll + ' = ' + nixVal(EDIT[coll] || {}, 1) + ';');
    }
    parts.push('}');
    return parts.join('\n') + '\n';
  }

  function openExport(afterClose) {
    const text = buildNix();
    const gh = DATA.githubUrl ? DATA.githubUrl + '/edit/main/my-pokemon.nix' : null;
    const m = document.createElement('div');
    m.className = 'pk-modal-backdrop';
    m.innerHTML = `
      <div class="pk-modal pk-modal-wide">
        <h2>Export collection to your GitHub</h2>
        <p class="pk-modal-hint">You need to copy the code below and paste it into your GitHub fork for your changes to take effect. Remember to press "Commit Changes" on GitHub - or else your changes will be lost!</p>
        <textarea id="pk-export-text" rows="30" spellcheck="false"></textarea>
        <div class="pk-modal-actions">
          <button id="pk-dl">Download</button>
          <button id="pk-copy">Copy</button>
          ${gh ? `<a href="${gh}" target="_blank" rel="noopener" class="pk-github-btn">Paste on GitHub!</a>` : ''}
          <button id="pk-close" class="primary">Close</button>
        </div>
      </div>`;
    document.body.appendChild(m);
    m.querySelector('#pk-export-text').value = text;

    m.querySelector('#pk-close').onclick = () => {
      m.remove();
      if (typeof afterClose === 'function') afterClose();
    };
    m.querySelector('#pk-copy').onclick = () => {
      navigator.clipboard.writeText(text);
      m.querySelector('#pk-copy').textContent = '✓ Copied';
    };
    m.querySelector('#pk-dl').onclick = () => {
      const a = document.createElement('a');
      a.href = URL.createObjectURL(new Blob([text], { type: 'text/plain' }));
      a.download = 'my-pokemon.nix';
      a.click();
    };
  }

  function requestExit() {
    if (hasExported) { exitEdit(); return; }

    const m = document.createElement('div');
    m.className = 'pk-modal-backdrop';
    m.innerHTML = `
      <div class="pk-modal">
        <h2 style="color:var(--accent-red);margin-bottom:12px">⚠ WARNING!</h2>
        <p style="margin-bottom:16px;line-height:1.6">
          You need to export your collection to GitHub before exit or your changes will be
          <strong>LOST!</strong><br><br>Commit now?
        </p>
        <div class="pk-modal-actions">
          <button id="pk-warn-yes"
                  style="background:var(--accent-green);border-color:var(--accent-green);color:#fff">
            Yes
          </button>
          <button id="pk-warn-later"
                  style="background:var(--accent-red);border-color:var(--accent-red);color:#fff">
            Later!
          </button>
        </div>
      </div>`;
    document.body.appendChild(m);
    m.querySelector('#pk-warn-yes').onclick = () => {
      m.remove();
      openExport(() => { hasExported = true; exitEdit(); });
    };
    m.querySelector('#pk-warn-later').onclick = () => { m.remove(); exitEdit(); };
  }

  function applyEditsOnLoad() {
    if (IS_SHINY) {
      document.querySelectorAll('details[data-dex]').forEach(row => {
        const key = row.id.replace(/^pk-/, '');
        const rec = EDIT.shiny[key];
        if (!rec) return;
        const slot = row.querySelector('summary .event-ball-slot');
        if (slot) slot.outerHTML = rec.ball && BALLS[rec.ball]
          ? `<span class="event-ball-slot"><img src="${BALLS[rec.ball]}" alt="${rec.ball}"></span>`
          : `<span class="event-ball-slot empty"></span>`;
        const notes = row.querySelector('summary .shiny-notes');
        if (notes && rec.notes != null) {
          const badge = notes.querySelector('.src-badge');
          notes.innerHTML = '';
          if (badge) notes.appendChild(badge);
          if (rec.notes) notes.appendChild(document.createTextNode(' ' + rec.notes));
        }
        const ot = row.querySelector('summary .check[title="OT"]');
        if (ot) { ot.className = 'check ' + (rec.ot ? 'yes' : 'no'); ot.textContent = rec.ot ? '✓' : ''; }
        const egg = row.querySelector('summary .check[title="Egg obtained"]');
        if (egg && !egg.classList.contains('na')) {
          egg.className = 'check ' + (rec.egg ? 'yes' : 'no');
          egg.textContent = rec.egg ? '✓' : '';
        }
        const style = row.querySelector('summary .shiny-style');
        if (style) style.textContent = rec.ball ? (rec.style === 'square' ? '▣' : '★') : '';
        row.classList.toggle('owned', !!rec.ball);
        row.classList.toggle('empty', !rec.ball);
      });
    }

    if (IS_BREEDABLES) {
      document.querySelectorAll('.breedable-row').forEach(row => {
        const key = row.id.replace(/^pk-/, '');
        const species = EDIT.breedables[key];
        if (!species) return;
        const captured = species.captured || {};
        row.querySelectorAll('.balls .ball').forEach(ballEl => {
          const ball = ballEl.dataset.ball;
          if (!ball) return;
          const st = captured[ball];
          const state = !st ? 'possible' : st.eggMoves ? 'em' : st.ha ? 'ha' : 'caught';
          ballEl.dataset.state = state;
          BALL_CYCLE.forEach(s => ballEl.classList.remove(s));
          ballEl.classList.add(state);
          ballEl.title = `${ball} — ${BALL_STATE_LABEL[state]}`;
        });
        const summary = row.querySelector('summary.entry');
        if (summary) summary.classList.toggle('untouched', Object.keys(captured).length === 0);
      });
      applySelectionOnLoad();
    }

    if (COLLECTION && !IS_SHINY) {
      document.querySelectorAll('details[data-dex]').forEach(row => {
        const key = row.id.replace(/^pk-/, '');
        const rec = EDIT[COLLECTION][key];
        if (!rec) return;
        const slot = row.querySelector('summary .event-ball-slot');
        if (slot) slot.outerHTML = rec.ball && BALLS[rec.ball]
          ? `<span class="event-ball-slot"><img src="${BALLS[rec.ball]}" alt="${rec.ball}"></span>`
          : `<span class="event-ball-slot empty"></span>`;
        const shiny = row.querySelector('summary .check[title="shiny"]');
        if (shiny) { shiny.className = 'check ' + (rec.shiny ? 'yes shiny-mark' : 'no'); shiny.textContent = rec.shiny ? '✨' : ''; }
        const self = row.querySelector('summary .check[title="self obtained"]');
        if (self) { self.className = 'check ' + (rec.selfObtained ? 'yes' : 'no'); self.textContent = rec.selfObtained ? '✓' : ''; }
        const fields = row.querySelectorAll('summary .event-field');
        if (COLLECTION === 'events') {
          if (fields[0]) fields[0].textContent = rec.year   ?? '—';
          if (fields[1]) fields[1].textContent = rec.ot     ?? '—';
          if (fields[2]) fields[2].textContent = rec.region ?? '—';
        } else {
          if (fields[0]) fields[0].textContent = rec.level  ?? '—';
          if (fields[1]) fields[1].textContent = rec.nature ?? '—';
        }
      });
    }

    if (IS_TRAINER) {
      if (EDIT.trainer.name != null) {
        const el = document.querySelector('.trainer-name');
        if (el) el.textContent = EDIT.trainer.name;
      }
      if (EDIT.trainer.about != null) {
        const el = document.querySelector('.trainer-about');
        if (el) el.textContent = EDIT.trainer.about;
      }
      const fmap = {
        'Region': 'region', 'Timezone': 'timezone', 'Contact': 'contact',
        'Friend Code': 'friendCode', 'Switch': 'switchName',
        'Trainer ID': 'trainerId', 'Secret ID': 'secretId',
      };
      document.querySelectorAll('.trainer-field').forEach(field => {
        const label = field.querySelector('.trainer-field-label')?.textContent.trim();
        const key = fmap[label];
        if (!key) return;
        const valEl = field.querySelector('.trainer-field-value');
        if (valEl && EDIT.trainer[key] != null) valEl.textContent = EDIT.trainer[key];
      });
    }
  }

  applyEditsOnLoad();
  updateCopyHint();

  document.getElementById('pk-edit-toggle')?.addEventListener('click', () => editMode ? requestExit() : enterEdit());
  document.getElementById('pk-edit-new')?.addEventListener('click', () => { if (editMode && !IS_SHINY) addNewRow(); });
  document.getElementById('export-btn')?.addEventListener('click', openExport);
})();
