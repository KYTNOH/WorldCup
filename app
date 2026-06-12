<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>World Cup 2026 Game Tracker</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;500;600;700&family=Roboto+Mono:wght@400;600&display=swap');

  :root {
    --bg:       #0a0e1a;
    --surface:  #111827;
    --card:     #1a2235;
    --border:   #2a3650;
    --gold:     #f5c518;
    --gold-dim: #c49b0e;
    --green:    #22c55e;
    --red:      #ef4444;
    --blue:     #3b82f6;
    --sky:      #38bdf8;
    --text:     #e8eaf2;
    --muted:    #8b9ab8;
    --pill-w:   #2563eb;
    --pill-d:   #6b7280;
    --pill-l:   #16a34a;
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'Inter', sans-serif;
    background: var(--bg);
    color: var(--text);
    min-height: 100vh;
  }

  /* ── HEADER ── */
  header {
    background: linear-gradient(135deg, #0a0e1a 0%, #0f1e3d 50%, #0a0e1a 100%);
    border-bottom: 2px solid var(--gold);
    padding: 0 1.5rem;
    position: sticky;
    top: 0;
    z-index: 100;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    min-height: 64px;
  }
  .header-brand {
    display: flex;
    align-items: center;
    gap: 0.75rem;
  }
  .trophy { font-size: 1.8rem; line-height: 1; }
  .header-brand h1 {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 1.7rem;
    letter-spacing: 0.08em;
    color: var(--gold);
    line-height: 1;
  }
  .header-brand span {
    font-size: 0.7rem;
    color: var(--muted);
    letter-spacing: 0.15em;
    text-transform: uppercase;
    display: block;
    margin-top: 1px;
  }
  .header-stats {
    display: flex;
    gap: 1.5rem;
  }
  .hstat { text-align: center; }
  .hstat-val {
    font-family: 'Roboto Mono', monospace;
    font-size: 1.2rem;
    font-weight: 600;
    color: var(--gold);
  }
  .hstat-lbl { font-size: 0.62rem; color: var(--muted); text-transform: uppercase; letter-spacing: 0.1em; }

  /* ── TABS ── */
  .tabs {
    display: flex;
    gap: 0;
    border-bottom: 1px solid var(--border);
    padding: 0 1.5rem;
    background: var(--surface);
    overflow-x: auto;
    scrollbar-width: none;
  }
  .tabs::-webkit-scrollbar { display: none; }
  .tab {
    padding: 0.75rem 1.1rem;
    font-size: 0.8rem;
    font-weight: 600;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    border: none;
    background: none;
    color: var(--muted);
    cursor: pointer;
    border-bottom: 2px solid transparent;
    margin-bottom: -1px;
    white-space: nowrap;
    transition: color 0.15s, border-color 0.15s;
  }
  .tab:hover { color: var(--text); }
  .tab.active { color: var(--gold); border-bottom-color: var(--gold); }

  /* ── LAYOUT ── */
  main { padding: 1.5rem; max-width: 1200px; margin: 0 auto; }
  .page { display: none; }
  .page.active { display: block; }

  /* ── SECTION HEADER ── */
  .section-hdr {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 1.2rem;
    letter-spacing: 0.12em;
    color: var(--gold);
    margin: 1.5rem 0 0.75rem;
    display: flex;
    align-items: center;
    gap: 0.6rem;
  }
  .section-hdr::after {
    content: '';
    flex: 1;
    height: 1px;
    background: var(--border);
  }

  /* ── GROUP GRID ── */
  .groups-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(520px, 1fr));
    gap: 1.25rem;
  }

  /* ── GROUP CARD ── */
  .group-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 8px;
    overflow: hidden;
  }
  .group-card-header {
    background: linear-gradient(90deg, #1e2d50, #162040);
    padding: 0.5rem 1rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    border-bottom: 1px solid var(--border);
  }
  .group-badge {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 1.1rem;
    color: var(--gold);
    letter-spacing: 0.08em;
  }

  /* ── STANDINGS TABLE ── */
  .standings-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.78rem;
  }
  .standings-table th {
    padding: 0.4rem 0.6rem;
    color: var(--muted);
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    font-size: 0.68rem;
    text-align: center;
    border-bottom: 1px solid var(--border);
  }
  .standings-table th.left { text-align: left; }
  .standings-table td {
    padding: 0.45rem 0.6rem;
    text-align: center;
    border-bottom: 1px solid rgba(42,54,80,0.4);
  }
  .standings-table td.team-name {
    text-align: left;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }
  .standings-table tr:last-child td { border-bottom: none; }
  .standings-table tr.qualify-1 { background: rgba(34,197,94,0.07); }
  .standings-table tr.qualify-2 { background: rgba(34,197,94,0.04); }
  .standings-table tr.qualify-3rd { background: rgba(59,130,246,0.05); }
  .pts-cell {
    font-family: 'Roboto Mono', monospace;
    font-weight: 700;
    font-size: 0.9rem;
    color: var(--gold);
  }
  .gd-pos { color: var(--green); }
  .gd-neg { color: var(--red); }
  .pos-num {
    font-size: 0.7rem;
    color: var(--muted);
    width: 16px;
    text-align: right;
  }
  .qualify-dot {
    width: 5px; height: 5px;
    border-radius: 50%;
    flex-shrink: 0;
  }
  .dot-1 { background: var(--green); }
  .dot-2 { background: var(--sky); }
  .dot-3 { background: var(--blue); }

  /* ── MATCHES ── */
  .matches-list { padding: 0.5rem; display: flex; flex-direction: column; gap: 0.4rem; }
  .match-row {
    display: grid;
    grid-template-columns: 1fr auto auto auto 1fr;
    align-items: center;
    gap: 0.5rem;
    padding: 0.45rem 0.5rem;
    border-radius: 5px;
    background: rgba(255,255,255,0.02);
    border: 1px solid transparent;
    transition: border-color 0.15s;
  }
  .match-row:hover { border-color: var(--border); }
  .match-row.played { background: rgba(245,197,24,0.03); }
  .team-home { text-align: right; font-size: 0.8rem; font-weight: 500; }
  .team-away { text-align: left; font-size: 0.8rem; font-weight: 500; }
  .score-area {
    display: flex;
    align-items: center;
    gap: 0.2rem;
  }
  .score-box {
    width: 32px; height: 28px;
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: 4px;
    text-align: center;
    font-family: 'Roboto Mono', monospace;
    font-size: 0.85rem;
    font-weight: 600;
    color: var(--text);
    outline: none;
    transition: border-color 0.15s;
  }
  .score-box:focus { border-color: var(--gold); }
  .score-sep { color: var(--muted); font-size: 0.75rem; }
  .match-date { font-size: 0.65rem; color: var(--muted); text-align: center; }

  /* ── KNOCKOUT PAGE ── */
  .knockout-intro {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 8px;
    padding: 1rem 1.25rem;
    margin-bottom: 1.25rem;
    font-size: 0.82rem;
    color: var(--muted);
    line-height: 1.6;
  }
  .knockout-intro strong { color: var(--text); }

  .round-section { margin-bottom: 2rem; }
  .knockout-games {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
    gap: 0.75rem;
  }
  .ko-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 8px;
    overflow: hidden;
  }
  .ko-card-header {
    padding: 0.4rem 0.75rem;
    background: rgba(30,45,80,0.8);
    font-size: 0.68rem;
    color: var(--muted);
    letter-spacing: 0.08em;
    text-transform: uppercase;
    display: flex;
    justify-content: space-between;
  }
  .ko-match {
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    align-items: center;
    gap: 0.75rem;
    padding: 0.6rem 0.75rem;
  }
  .ko-team {
    font-size: 0.82rem;
    font-weight: 600;
  }
  .ko-team.home { text-align: right; }
  .ko-team.away { text-align: left; }
  .ko-team.tbd { color: var(--muted); font-style: italic; font-weight: 400; }
  .ko-score {
    display: flex;
    align-items: center;
    gap: 0.25rem;
  }
  .ko-score-box {
    width: 34px; height: 30px;
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: 4px;
    text-align: center;
    font-family: 'Roboto Mono', monospace;
    font-size: 0.88rem;
    font-weight: 600;
    color: var(--text);
    outline: none;
    transition: border-color 0.15s;
  }
  .ko-score-box:focus { border-color: var(--gold); }
  .ko-score-box:disabled { opacity: 0.35; cursor: not-allowed; }

  /* ── STANDINGS PAGE ── */
  .all-standings {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(480px, 1fr));
    gap: 1.25rem;
  }

  /* ── SUMMARY CARDS ── */
  .summary-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
    gap: 0.75rem;
    margin-bottom: 1.5rem;
  }
  .summary-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 8px;
    padding: 1rem;
    text-align: center;
  }
  .summary-card .val {
    font-family: 'Roboto Mono', monospace;
    font-size: 1.8rem;
    font-weight: 700;
    color: var(--gold);
    line-height: 1;
  }
  .summary-card .lbl {
    font-size: 0.72rem;
    color: var(--muted);
    text-transform: uppercase;
    letter-spacing: 0.1em;
    margin-top: 0.35rem;
  }

  .top-scorers {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 8px;
    overflow: hidden;
  }
  .scorer-row {
    display: grid;
    grid-template-columns: 32px 1fr auto auto;
    align-items: center;
    padding: 0.5rem 0.75rem;
    border-bottom: 1px solid var(--border);
    font-size: 0.8rem;
    gap: 0.5rem;
  }
  .scorer-row:last-child { border-bottom: none; }
  .scorer-rank {
    font-family: 'Roboto Mono', monospace;
    font-size: 0.75rem;
    color: var(--muted);
    text-align: center;
  }
  .scorer-goals {
    font-family: 'Roboto Mono', monospace;
    font-size: 1rem;
    font-weight: 700;
    color: var(--green);
  }

  /* ── RESULT PILLS ── */
  .result-pill {
    font-size: 0.6rem;
    padding: 1px 5px;
    border-radius: 3px;
    font-weight: 700;
    letter-spacing: 0.05em;
  }
  .pill-w { background: rgba(37,99,235,0.25); color: #93c5fd; }
  .pill-d { background: rgba(107,114,128,0.25); color: #d1d5db; }
  .pill-l { background: rgba(239,68,68,0.15); color: #fca5a5; }

  /* ── FOOTER ── */
  footer {
    text-align: center;
    padding: 1.5rem;
    color: var(--muted);
    font-size: 0.72rem;
    border-top: 1px solid var(--border);
    margin-top: 2rem;
  }

  /* ── RESPONSIVE ── */
  @media (max-width: 640px) {
    .groups-grid { grid-template-columns: 1fr; }
    .all-standings { grid-template-columns: 1fr; }
    .knockout-games { grid-template-columns: 1fr; }
    .header-stats { gap: 0.75rem; }
    .hstat-val { font-size: 1rem; }
    .header-brand h1 { font-size: 1.3rem; }
  }
</style>
</head>
<body>

<header>
  <div class="header-brand">
    <div class="trophy">🏆</div>
    <div>
      <h1>World Cup Game Tracker</h1>
      <span>FIFA World Cup 2026 · USA · Canada · Mexico</span>
    </div>
  </div>
  <div class="header-stats">
    <div class="hstat"><div class="hstat-val" id="h-played">0</div><div class="hstat-lbl">Played</div></div>
    <div class="hstat"><div class="hstat-val" id="h-goals">0</div><div class="hstat-lbl">Goals</div></div>
    <div class="hstat"><div class="hstat-val" id="h-remain">104</div><div class="hstat-lbl">Remaining</div></div>
  </div>
</header>

<div class="tabs">
  <button class="tab active" onclick="showPage('groups')">Group Stage</button>
  <button class="tab" onclick="showPage('standings')">Standings</button>
  <button class="tab" onclick="showPage('knockout')">Knockout</button>
  <button class="tab" onclick="showPage('summary')">Tournament</button>
</div>

<main>

<!-- ════════════════════════════════ GROUP STAGE PAGE ════════════════════════════════ -->
<div class="page active" id="page-groups">
  <div class="groups-grid" id="groups-container"></div>
</div>

<!-- ════════════════════════════════ STANDINGS PAGE ════════════════════════════════ -->
<div class="page" id="page-standings">
  <div style="font-size:0.78rem;color:var(--muted);margin-bottom:1rem;line-height:1.6;">
    Top 2 from each group <span style="color:var(--green)">●</span> advance automatically. 
    Best 8 third-place teams <span style="color:var(--blue)">●</span> also advance. 
    Tiebreakers: Points → GD → GF → Head-to-head.
  </div>
  <div class="all-standings" id="standings-container"></div>
</div>

<!-- ════════════════════════════════ KNOCKOUT PAGE ════════════════════════════════ -->
<div class="page" id="page-knockout">
  <div class="knockout-intro">
    <strong>Round of 32</strong> begins June 28 · <strong>Round of 16</strong> July 4 · 
    <strong>Quarterfinals</strong> July 9 · <strong>Semifinals</strong> July 14–15 · 
    <strong>3rd Place</strong> July 18 · <strong>Final</strong> July 19 at MetLife Stadium, NJ<br>
    Team slots will auto-fill from group standings once all group games are scored. Enter scores for each knockout match.
  </div>
  <div id="knockout-container"></div>
</div>

<!-- ════════════════════════════════ SUMMARY PAGE ════════════════════════════════ -->
<div class="page" id="page-summary">
  <div class="summary-grid" id="summary-cards"></div>
  <div class="section-hdr">Top Scoring Teams</div>
  <div class="top-scorers" id="top-scorers"></div>
  <div class="section-hdr">All Results</div>
  <div id="all-results"></div>
</div>

</main>
<footer>2026 FIFA World Cup Game Tracker · All 104 matches · Data saves automatically in your browser</footer>

<script>
// ══════════════════════════════════════════════════════════
//  DATA
// ══════════════════════════════════════════════════════════

const GROUPS = {
  A: ['Mexico','South Africa','South Korea','Czechia'],
  B: ['Canada','Bosnia and Herzegovina','Switzerland','Qatar'],
  C: ['Brazil','Morocco','Scotland','Haiti'],
  D: ['USA','Paraguay','Australia','Türkiye'],
  E: ['Germany','Ivory Coast','Ecuador','Curaçao'],
  F: ['Netherlands','Japan','Sweden','Tunisia'],
  G: ['Belgium','Egypt','Iran','New Zealand'],
  H: ['Spain','Cape Verde','Saudi Arabia','Uruguay'],
  I: ['France','Senegal','Iraq','Norway'],
  J: ['Argentina','Algeria','Austria','Jordan'],
  K: ['Portugal','Congo DR','Colombia','Uzbekistan'],
  L: ['England','Croatia','Ghana','Panama'],
};

// Each match: [date, home, away, group]
const GROUP_MATCHES = [
  // Group A
  ['Jun 11','Mexico','South Africa','A'],
  ['Jun 11','South Korea','Czechia','A'],
  ['Jun 18','Czechia','South Africa','A'],
  ['Jun 18','Mexico','South Korea','A'],
  ['Jun 24','Mexico','Czechia','A'],
  ['Jun 24','South Korea','South Africa','A'],
  // Group B
  ['Jun 12','Canada','Bosnia and Herzegovina','B'],
  ['Jun 13','Qatar','Switzerland','B'],
  ['Jun 18','Switzerland','Bosnia and Herzegovina','B'],
  ['Jun 18','Canada','Qatar','B'],
  ['Jun 24','Switzerland','Canada','B'],
  ['Jun 24','Bosnia and Herzegovina','Qatar','B'],
  // Group C
  ['Jun 13','Brazil','Morocco','C'],
  ['Jun 13','Haiti','Scotland','C'],
  ['Jun 19','Scotland','Morocco','C'],
  ['Jun 19','Brazil','Haiti','C'],
  ['Jun 24','Brazil','Scotland','C'],
  ['Jun 24','Morocco','Haiti','C'],
  // Group D
  ['Jun 12','USA','Paraguay','D'],
  ['Jun 13','Australia','Türkiye','D'],
  ['Jun 19','USA','Australia','D'],
  ['Jun 19','Türkiye','Paraguay','D'],
  ['Jun 25','USA','Türkiye','D'],
  ['Jun 25','Paraguay','Australia','D'],
  // Group E
  ['Jun 14','Germany','Curaçao','E'],
  ['Jun 14','Ivory Coast','Ecuador','E'],
  ['Jun 20','Germany','Ivory Coast','E'],
  ['Jun 20','Ecuador','Curaçao','E'],
  ['Jun 25','Ecuador','Germany','E'],
  ['Jun 25','Curaçao','Ivory Coast','E'],
  // Group F
  ['Jun 14','Netherlands','Japan','F'],
  ['Jun 14','Tunisia','Sweden','F'],
  ['Jun 20','Netherlands','Sweden','F'],
  ['Jun 20','Tunisia','Japan','F'],
  ['Jun 25','Tunisia','Netherlands','F'],
  ['Jun 25','Japan','Sweden','F'],
  // Group G
  ['Jun 15','Belgium','Egypt','G'],
  ['Jun 15','Iran','New Zealand','G'],
  ['Jun 21','Belgium','Iran','G'],
  ['Jun 21','New Zealand','Egypt','G'],
  ['Jun 27','Belgium','New Zealand','G'],
  ['Jun 27','Egypt','Iran','G'],
  // Group H
  ['Jun 15','Spain','Cape Verde','H'],
  ['Jun 15','Saudi Arabia','Uruguay','H'],
  ['Jun 21','Spain','Saudi Arabia','H'],
  ['Jun 21','Uruguay','Cape Verde','H'],
  ['Jun 27','Uruguay','Spain','H'],
  ['Jun 27','Cape Verde','Saudi Arabia','H'],
  // Group I
  ['Jun 16','France','Senegal','I'],
  ['Jun 16','Iraq','Norway','I'],
  ['Jun 22','France','Iraq','I'],
  ['Jun 22','Norway','Senegal','I'],
  ['Jun 26','Norway','France','I'],
  ['Jun 26','Senegal','Iraq','I'],
  // Group J
  ['Jun 16','Argentina','Algeria','J'],
  ['Jun 16','Austria','Jordan','J'],
  ['Jun 22','Argentina','Austria','J'],
  ['Jun 22','Jordan','Algeria','J'],
  ['Jun 27','Argentina','Jordan','J'],
  ['Jun 27','Algeria','Austria','J'],
  // Group K
  ['Jun 17','Portugal','Congo DR','K'],
  ['Jun 17','Uzbekistan','Colombia','K'],
  ['Jun 23','Portugal','Uzbekistan','K'],
  ['Jun 23','Colombia','Congo DR','K'],
  ['Jun 27','Colombia','Portugal','K'],
  ['Jun 27','Congo DR','Uzbekistan','K'],
  // Group L
  ['Jun 17','England','Croatia','L'],
  ['Jun 17','Ghana','Panama','L'],
  ['Jun 23','England','Ghana','L'],
  ['Jun 23','Panama','Croatia','L'],
  ['Jun 27','England','Panama','L'],
  ['Jun 27','Croatia','Ghana','L'],
];

// Knockout structure
// R32 = 16 games, R16 = 8, QF = 4, SF = 2, 3rd = 1, Final = 1 = 32 total
// Bracket per FIFA 2026 official draw
const KO_ROUNDS = [
  {
    id: 'r32',
    label: 'Round of 32',
    date: 'June 28 – July 3',
    games: [
      {id:'r32_1', date:'Jun 28', home:'1A', away:'3F/G/H'},
      {id:'r32_2', date:'Jun 28', home:'1B', away:'3D/E/J'},
      {id:'r32_3', date:'Jun 29', home:'1C', away:'3G/H/I'},
      {id:'r32_4', date:'Jun 29', home:'1D', away:'3A/B/K'},
      {id:'r32_5', date:'Jun 30', home:'1E', away:'3L/I/J'},
      {id:'r32_6', date:'Jun 30', home:'1F', away:'3A/B/C'},
      {id:'r32_7', date:'Jul 1', home:'1G', away:'2H'},
      {id:'r32_8', date:'Jul 1', home:'1H', away:'2G'},
      {id:'r32_9', date:'Jul 2', home:'1I', away:'2J'},
      {id:'r32_10', date:'Jul 2', home:'1J', away:'2I'},
      {id:'r32_11', date:'Jul 2', home:'1K', away:'2L'},
      {id:'r32_12', date:'Jul 3', home:'1L', away:'2K'},
      {id:'r32_13', date:'Jul 3', home:'2A', away:'2C'},
      {id:'r32_14', date:'Jul 3', home:'2B', away:'2D'},
      {id:'r32_15', date:'Jul 3', home:'2E', away:'2F'},
      {id:'r32_16', date:'Jul 3', home:'3rd team','away':'3rd team'},
    ]
  },
  {
    id: 'r16',
    label: 'Round of 16',
    date: 'July 4–7',
    games: [
      {id:'r16_1', date:'Jul 4', home:'W R32-1', away:'W R32-2'},
      {id:'r16_2', date:'Jul 4', home:'W R32-3', away:'W R32-4'},
      {id:'r16_3', date:'Jul 5', home:'W R32-5', away:'W R32-6'},
      {id:'r16_4', date:'Jul 5', home:'W R32-7', away:'W R32-8'},
      {id:'r16_5', date:'Jul 6', home:'W R32-9', away:'W R32-10'},
      {id:'r16_6', date:'Jul 6', home:'W R32-11', away:'W R32-12'},
      {id:'r16_7', date:'Jul 7', home:'W R32-13', away:'W R32-14'},
      {id:'r16_8', date:'Jul 7', home:'W R32-15', away:'W R32-16'},
    ]
  },
  {
    id: 'qf',
    label: 'Quarterfinals',
    date: 'July 9–10',
    games: [
      {id:'qf_1', date:'Jul 9', home:'W R16-1', away:'W R16-2'},
      {id:'qf_2', date:'Jul 9', home:'W R16-3', away:'W R16-4'},
      {id:'qf_3', date:'Jul 10', home:'W R16-5', away:'W R16-6'},
      {id:'qf_4', date:'Jul 10', home:'W R16-7', away:'W R16-8'},
    ]
  },
  {
    id: 'sf',
    label: 'Semifinals',
    date: 'July 14–15',
    games: [
      {id:'sf_1', date:'Jul 14', home:'W QF-1', away:'W QF-2'},
      {id:'sf_2', date:'Jul 15', home:'W QF-3', away:'W QF-4'},
    ]
  },
  {
    id: 'third',
    label: '3rd Place Match',
    date: 'July 18',
    games: [
      {id:'third_1', date:'Jul 18', home:'L SF-1', away:'L SF-2'},
    ]
  },
  {
    id: 'final',
    label: 'The Final',
    date: 'July 19 · MetLife Stadium, New Jersey',
    games: [
      {id:'final_1', date:'Jul 19', home:'W SF-1', away:'W SF-2'},
    ]
  },
];

// ══════════════════════════════════════════════════════════
//  STATE
// ══════════════════════════════════════════════════════════

let scores = {};  // key: "home_away" -> {home: n, away: n}
let koScores = {}; // key: game id -> {home: n, away: n}

function saveState() {
  localStorage.setItem('wc2026_scores', JSON.stringify(scores));
  localStorage.setItem('wc2026_ko', JSON.stringify(koScores));
}

function loadState() {
  try {
    const s = localStorage.getItem('wc2026_scores');
    const k = localStorage.getItem('wc2026_ko');
    if (s) scores = JSON.parse(s);
    if (k) koScores = JSON.parse(k);
  } catch(e) {}
}

function matchKey(home, away) { return `${home}||${away}`; }

function getScore(home, away) {
  return scores[matchKey(home, away)] || null;
}

// ══════════════════════════════════════════════════════════
//  STANDINGS CALCULATION
// ══════════════════════════════════════════════════════════

function calcGroupStandings(group) {
  const teams = GROUPS[group];
  const stats = {};
  teams.forEach(t => {
    stats[t] = { team:t, mp:0, w:0, d:0, l:0, gf:0, ga:0, gd:0, pts:0 };
  });

  GROUP_MATCHES.filter(m => m[3] === group).forEach(([date, home, away]) => {
    const sc = getScore(home, away);
    if (!sc) return;
    const h = sc.home, a = sc.away;
    stats[home].mp++; stats[away].mp++;
    stats[home].gf += h; stats[home].ga += a;
    stats[away].gf += a; stats[away].ga += h;
    stats[home].gd = stats[home].gf - stats[home].ga;
    stats[away].gd = stats[away].gf - stats[away].ga;
    if (h > a) {
      stats[home].w++; stats[home].pts += 3;
      stats[away].l++;
    } else if (h < a) {
      stats[away].w++; stats[away].pts += 3;
      stats[home].l++;
    } else {
      stats[home].d++; stats[home].pts++;
      stats[away].d++; stats[away].pts++;
    }
  });

  return Object.values(stats).sort((a,b) =>
    b.pts - a.pts || b.gd - a.gd || b.gf - a.gf || a.team.localeCompare(b.team)
  );
}

function allGroupStandings() {
  const result = {};
  Object.keys(GROUPS).forEach(g => { result[g] = calcGroupStandings(g); });
  return result;
}

// ══════════════════════════════════════════════════════════
//  RENDER GROUP STAGE
// ══════════════════════════════════════════════════════════

function renderGroups() {
  const container = document.getElementById('groups-container');
  container.innerHTML = '';

  Object.keys(GROUPS).forEach(group => {
    const standings = calcGroupStandings(group);
    const matches = GROUP_MATCHES.filter(m => m[3] === group);

    const card = document.createElement('div');
    card.className = 'group-card';
    card.innerHTML = `
      <div class="group-card-header">
        <span class="group-badge">Group ${group}</span>
      </div>
      <table class="standings-table">
        <thead>
          <tr>
            <th class="left" colspan="2">Team</th>
            <th>MP</th><th>W</th><th>D</th><th>L</th>
            <th>GF</th><th>GA</th><th>GD</th><th>Pts</th>
          </tr>
        </thead>
        <tbody>
          ${standings.map((t, i) => `
            <tr class="${i===0?'qualify-1':i===1?'qualify-2':i===2?'qualify-3rd':''}">
              <td class="pos-num">${i+1}</td>
              <td class="team-name">
                <span class="qualify-dot ${i===0?'dot-1':i===1?'dot-2':i===2?'dot-3':''}"></span>
                ${t.team}
              </td>
              <td>${t.mp}</td><td>${t.w}</td><td>${t.d}</td><td>${t.l}</td>
              <td>${t.gf}</td><td>${t.ga}</td>
              <td class="${t.gd>0?'gd-pos':t.gd<0?'gd-neg':''}">${t.gd>0?'+':''}${t.gd}</td>
              <td class="pts-cell">${t.pts}</td>
            </tr>`).join('')}
        </tbody>
      </table>
      <div class="matches-list">
        ${matches.map(([date, home, away]) => {
          const sc = getScore(home, away);
          const key = matchKey(home, away);
          return `
            <div class="match-row ${sc?'played':''}">
              <div class="team-home">${home}</div>
              <div class="score-area">
                <input class="score-box" type="number" min="0" max="99"
                  value="${sc ? sc.home : ''}" placeholder="–"
                  onchange="setScore('${key}', 'home', this.value)"
                  oninput="setScore('${key}', 'home', this.value)">
                <span class="score-sep">:</span>
                <input class="score-box" type="number" min="0" max="99"
                  value="${sc ? sc.away : ''}" placeholder="–"
                  onchange="setScore('${key}', 'away', this.value)"
                  oninput="setScore('${key}', 'away', this.value)">
              </div>
              <div class="team-away">${away}</div>
            </div>`;
        }).join('')}
      </div>`;
    container.appendChild(card);
  });
}

function setScore(key, side, val) {
  const v = parseInt(val);
  if (isNaN(v) || v < 0) {
    // remove if both cleared
    if (scores[key]) {
      scores[key][side] = null;
      if (scores[key].home === null && scores[key].away === null) delete scores[key];
    }
  } else {
    if (!scores[key]) scores[key] = {home: null, away: null};
    scores[key][side] = v;
  }
  saveState();
  updateHeader();
  // Only re-render the parts that show standings (not the inputs — avoid losing focus)
  if (document.getElementById('page-standings').classList.contains('active')) renderStandings();
  if (document.getElementById('page-summary').classList.contains('active')) renderSummary();
}

// ══════════════════════════════════════════════════════════
//  RENDER STANDINGS
// ══════════════════════════════════════════════════════════

function renderStandings() {
  const container = document.getElementById('standings-container');
  container.innerHTML = '';
  Object.keys(GROUPS).forEach(group => {
    const standings = calcGroupStandings(group);
    const div = document.createElement('div');
    div.className = 'group-card';
    div.innerHTML = `
      <div class="group-card-header">
        <span class="group-badge">Group ${group}</span>
      </div>
      <table class="standings-table">
        <thead>
          <tr>
            <th class="left" colspan="2">Team</th>
            <th>MP</th><th>W</th><th>D</th><th>L</th>
            <th>GF</th><th>GA</th><th>GD</th><th>Pts</th>
          </tr>
        </thead>
        <tbody>
          ${standings.map((t, i) => `
            <tr class="${i===0?'qualify-1':i===1?'qualify-2':i===2?'qualify-3rd':''}">
              <td class="pos-num">${i+1}</td>
              <td class="team-name">
                <span class="qualify-dot ${i===0?'dot-1':i===1?'dot-2':i===2?'dot-3':''}"></span>
                ${t.team}
              </td>
              <td>${t.mp}</td><td>${t.w}</td><td>${t.d}</td><td>${t.l}</td>
              <td>${t.gf}</td><td>${t.ga}</td>
              <td class="${t.gd>0?'gd-pos':t.gd<0?'gd-neg':''}">
                ${t.gd>0?'+':''}${t.gd}
              </td>
              <td class="pts-cell">${t.pts}</td>
            </tr>`).join('')}
        </tbody>
      </table>`;
    container.appendChild(div);
  });
}

// ══════════════════════════════════════════════════════════
//  RENDER KNOCKOUT
// ══════════════════════════════════════════════════════════

// Determine actual group winners/runners-up for slot labels
function getGroupSlot(slot) {
  // slot like "1A", "2B", "3F/G/H"
  if (/^\d[A-L]$/.test(slot)) {
    const pos = parseInt(slot[0]) - 1;
    const g = slot[1];
    const st = calcGroupStandings(g);
    if (st[pos] && st[pos].mp > 0) return st[pos].team;
  }
  return slot; // TBD
}

function renderKnockout() {
  const container = document.getElementById('knockout-container');
  container.innerHTML = '';

  KO_ROUNDS.forEach(round => {
    const sec = document.createElement('div');
    sec.className = 'round-section';
    const hdr = document.createElement('div');
    hdr.className = 'section-hdr';
    hdr.innerHTML = `${round.label} <span style="font-family:Inter;font-size:0.75rem;color:var(--muted);letter-spacing:0;font-weight:400">${round.date}</span>`;
    sec.appendChild(hdr);

    const grid = document.createElement('div');
    grid.className = 'knockout-games';

    round.games.forEach(game => {
      const sc = koScores[game.id];
      const homeLabel = getGroupSlot(game.home);
      const awayLabel = getGroupSlot(game.away);
      const isTBD = homeLabel === game.home && game.home.startsWith('W');

      const card = document.createElement('div');
      card.className = 'ko-card';
      card.innerHTML = `
        <div class="ko-card-header">
          <span>${game.date}</span>
          <span>${game.id.toUpperCase().replace('_',' ')}</span>
        </div>
        <div class="ko-match">
          <div class="ko-team home ${isTBD?'tbd':''}">${homeLabel}</div>
          <div class="ko-score">
            <input class="ko-score-box" type="number" min="0" max="99"
              value="${sc ? sc.home : ''}" placeholder="–"
              ${isTBD?'disabled':''}
              onchange="setKoScore('${game.id}','home',this.value)"
              oninput="setKoScore('${game.id}','home',this.value)">
            <span class="score-sep">:</span>
            <input class="ko-score-box" type="number" min="0" max="99"
              value="${sc ? sc.away : ''}" placeholder="–"
              ${isTBD?'disabled':''}
              onchange="setKoScore('${game.id}','away',this.value)"
              oninput="setKoScore('${game.id}','away',this.value)">
          </div>
          <div class="ko-team away ${isTBD?'tbd':''}">${awayLabel}</div>
        </div>`;
      grid.appendChild(card);
    });

    sec.appendChild(grid);
    container.appendChild(sec);
  });
}

function setKoScore(id, side, val) {
  const v = parseInt(val);
  if (isNaN(v) || v < 0) {
    if (koScores[id]) {
      koScores[id][side] = null;
      if (koScores[id].home === null && koScores[id].away === null) delete koScores[id];
    }
  } else {
    if (!koScores[id]) koScores[id] = {home: null, away: null};
    koScores[id][side] = v;
  }
  saveState();
  updateHeader();
  if (document.getElementById('page-summary').classList.contains('active')) renderSummary();
}

// ══════════════════════════════════════════════════════════
//  RENDER SUMMARY
// ══════════════════════════════════════════════════════════

function renderSummary() {
  const allScores = Object.values(scores).filter(s => s.home !== null && s.away !== null);
  const koAllScores = Object.values(koScores).filter(s => s.home !== null && s.away !== null);
  const totalPlayed = allScores.length + koAllScores.length;
  const totalGoals = [...allScores, ...koAllScores].reduce((a, s) => a + s.home + s.away, 0);
  const avgGoals = totalPlayed > 0 ? (totalGoals / totalPlayed).toFixed(2) : '—';

  // Team goal totals
  const teamGoals = {};
  GROUP_MATCHES.forEach(([d, home, away]) => {
    const sc = getScore(home, away);
    if (!sc || sc.home === null) return;
    teamGoals[home] = (teamGoals[home]||0) + sc.home;
    teamGoals[away] = (teamGoals[away]||0) + sc.away;
  });

  const topTeams = Object.entries(teamGoals)
    .sort((a,b) => b[1]-a[1])
    .slice(0, 10);

  document.getElementById('summary-cards').innerHTML = `
    <div class="summary-card"><div class="val">${totalPlayed}</div><div class="lbl">Games Played</div></div>
    <div class="summary-card"><div class="val">${104 - totalPlayed}</div><div class="lbl">Remaining</div></div>
    <div class="summary-card"><div class="val">${totalGoals}</div><div class="lbl">Total Goals</div></div>
    <div class="summary-card"><div class="val">${avgGoals}</div><div class="lbl">Goals / Game</div></div>
    <div class="summary-card"><div class="val">${allScores.length}</div><div class="lbl">Group Games</div></div>
    <div class="summary-card"><div class="val">${koAllScores.length}</div><div class="lbl">Knockout Games</div></div>
  `;

  document.getElementById('top-scorers').innerHTML = topTeams.length
    ? topTeams.map(([team, gf], i) => `
        <div class="scorer-row">
          <div class="scorer-rank">${i+1}</div>
          <div>${team}</div>
          <div></div>
          <div class="scorer-goals">${gf}</div>
        </div>`).join('')
    : '<div style="padding:1rem;color:var(--muted);font-size:0.8rem;">No scores entered yet.</div>';

  // Recent results
  const played = GROUP_MATCHES.filter(([d,h,a]) => {
    const sc = getScore(h, a);
    return sc && sc.home !== null && sc.away !== null;
  }).map(([d, home, away, g]) => {
    const sc = getScore(home, away);
    return {date: d, home, away, hg: sc.home, ag: sc.away, group: g};
  }).reverse().slice(0, 20);

  document.getElementById('all-results').innerHTML = played.length
    ? `<div style="display:flex;flex-direction:column;gap:0.4rem;">
        ${played.map(r => `
          <div style="background:var(--card);border:1px solid var(--border);border-radius:6px;
            display:grid;grid-template-columns:60px 1fr auto 1fr 60px;align-items:center;
            padding:0.4rem 0.75rem;gap:0.5rem;font-size:0.8rem;">
            <span style="color:var(--muted);font-size:0.68rem;">${r.date} Grp ${r.group}</span>
            <span style="text-align:right;font-weight:500">${r.home}</span>
            <span style="font-family:'Roboto Mono',monospace;font-weight:700;font-size:0.9rem;
              color:var(--gold);text-align:center;min-width:50px">${r.hg} – ${r.ag}</span>
            <span style="font-weight:500">${r.away}</span>
            <span></span>
          </div>`).join('')}
      </div>`
    : '<div style="color:var(--muted);font-size:0.8rem;padding:1rem;">No results yet.</div>';
}

// ══════════════════════════════════════════════════════════
//  HEADER COUNTERS
// ══════════════════════════════════════════════════════════

function updateHeader() {
  const groupPlayed = Object.values(scores).filter(s => s.home !== null && s.away !== null).length;
  const koPlayed = Object.values(koScores).filter(s => s.home !== null && s.away !== null).length;
  const total = groupPlayed + koPlayed;
  const totalGoals = [...Object.values(scores), ...Object.values(koScores)]
    .filter(s => s.home !== null && s.away !== null)
    .reduce((a, s) => a + s.home + s.away, 0);

  document.getElementById('h-played').textContent = total;
  document.getElementById('h-goals').textContent = totalGoals;
  document.getElementById('h-remain').textContent = 104 - total;
}

// ══════════════════════════════════════════════════════════
//  NAVIGATION
// ══════════════════════════════════════════════════════════

function showPage(id) {
  document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
  document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
  document.getElementById('page-' + id).classList.add('active');
  event.currentTarget.classList.add('active');

  if (id === 'standings') renderStandings();
  if (id === 'knockout') renderKnockout();
  if (id === 'summary') renderSummary();
}

// ══════════════════════════════════════════════════════════
//  INIT
// ══════════════════════════════════════════════════════════

loadState();
renderGroups();
updateHeader();
</script>
</body>
</html>
