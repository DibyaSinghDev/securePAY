<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
Integer totalUsers =
(Integer)request.getAttribute("totalUsers");

Integer totalTransactions =
(Integer)request.getAttribute("totalTransactions");

Double totalBalance =
(Double)request.getAttribute("totalBalance");

if(totalUsers == null) totalUsers = 0;
if(totalTransactions == null) totalTransactions = 0;
if(totalBalance == null) totalBalance = 0.0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SecurePAY Control Room</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600&family=Manrope:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">

<style>

:root{
    --metal:#1a1613;
    --metal-raised:#242019;
    --metal-deep:#100d0b;
    --line:#3a3227;
    --brass:#c9a227;
    --brass-bright:#e8c765;
    --phosphor:#5eda8e;
    --phosphor-dim:#264534;
    --ivory:#f3ede0;
    --gray:#948c78;
    --lamp-red:#e0554a;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Manrope',sans-serif;
}

body{
    background:
        radial-gradient(circle at 15% 0%, #201b16 0%, var(--metal-deep) 60%);
    min-height:100vh;
    color:var(--ivory);
}

::selection{ background:var(--phosphor); color:#0a1a11; }

/* ---------- Marquee ---------- */

.marquee{
    background:var(--metal-deep);
    border-bottom:1px solid var(--line);
    overflow:hidden;
    white-space:nowrap;
    padding:9px 0;
}

.marquee span{
    display:inline-block;
    font-family:'JetBrains Mono',monospace;
    font-size:12px;
    letter-spacing:1px;
    color:var(--phosphor);
    padding-left:100%;
    animation:scroll 26s linear infinite;
}

@keyframes scroll{
    from{ transform:translateX(0); }
    to{ transform:translateX(-100%); }
}

/* ---------- Layout ---------- */

.wrapper{ display:flex; }

/* ---------- Switch panel (nav) ---------- */

.switchpanel{
    width:210px;
    flex-shrink:0;
    min-height:calc(100vh - 38px);
    background:var(--metal);
    border-right:1px solid var(--line);
    padding:28px 18px;
}

.brand{
    display:flex;
    align-items:center;
    gap:10px;
    margin-bottom:30px;
    padding:0 4px;
}

.brand .seal{
    width:34px; height:34px;
    border-radius:50%;
    border:1px dashed var(--brass);
    display:flex; align-items:center; justify-content:center;
    font-family:'Fraunces',serif; font-weight:600; font-size:12px;
    color:var(--brass-bright);
    flex-shrink:0;
}

.brand span{ font-family:'Fraunces',serif; font-weight:600; font-size:16.5px; }

.switch-row{
    display:flex;
    align-items:center;
    gap:12px;
    text-decoration:none;
    color:var(--ivory);
    padding:10px 8px;
    border-radius:6px;
    margin-bottom:3px;
    font-size:13.5px;
    font-weight:500;
    transition:background .15s;
}

.switch-row:hover{ background:var(--metal-raised); }

.toggle{
    width:30px; height:16px;
    border-radius:9px;
    background:var(--metal-deep);
    border:1px solid var(--line);
    position:relative;
    flex-shrink:0;
}

.toggle::after{
    content:"";
    position:absolute;
    width:10px; height:10px;
    border-radius:50%;
    top:2px; left:2px;
    background:var(--gray);
    transition:.15s;
}

.switch-row.on .toggle{ border-color:var(--phosphor); }
.switch-row.on .toggle::after{
    left:16px;
    background:var(--phosphor);
    box-shadow:0 0 6px var(--phosphor);
}

.divider{
    font-family:'JetBrains Mono',monospace;
    font-size:9.5px;
    letter-spacing:2px;
    text-transform:uppercase;
    color:var(--gray);
    margin:20px 8px 8px;
}

.switchpanel .logout{ color:var(--lamp-red); margin-top:10px; }
.switchpanel .logout .toggle::after{ background:var(--lamp-red); }
.switchpanel .logout .toggle{ border-color:var(--lamp-red); }

/* ---------- Main ---------- */

.main{ flex:1; padding:32px 40px 40px; min-width:0; }

.header{
    display:flex;
    justify-content:space-between;
    align-items:flex-end;
    margin-bottom:26px;
}

.header .eyebrow{
    font-family:'JetBrains Mono',monospace;
    font-size:11px; letter-spacing:2.5px; text-transform:uppercase;
    color:var(--brass); margin-bottom:8px;
}

.header h1{ font-family:'Fraunces',serif; font-weight:600; font-size:30px; }

.op-status{
    font-family:'JetBrains Mono',monospace;
    font-size:12px;
    color:var(--phosphor);
    display:flex; align-items:center; gap:8px;
}

.op-status i{
    width:8px; height:8px; border-radius:50%;
    background:var(--phosphor);
    box-shadow:0 0 8px var(--phosphor);
    animation:blink 2.4s infinite;
}

@keyframes blink{ 0%,100%{opacity:1;} 50%{opacity:.35;} }

/* ---------- Instrument row ---------- */

.instruments{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:20px;
}

.gauge-panel{
    background:var(--metal);
    border:1px solid var(--line);
    border-radius:16px;
    padding:22px;
    text-align:center;
}

.gauge-panel .label{
    font-family:'JetBrains Mono',monospace;
    font-size:11px; letter-spacing:1.3px; text-transform:uppercase;
    color:var(--gray); margin-bottom:6px;
}

.gauge-panel svg{ width:100%; max-width:190px; }

.gauge-panel .readout{
    font-family:'JetBrains Mono',monospace;
    font-weight:700; font-size:22px;
    color:var(--brass-bright);
    margin-top:-6px;
}

.lcd{
    background:var(--metal-deep);
    border:1px solid var(--phosphor-dim);
    border-radius:8px;
    padding:24px 10px;
    margin-top:8px;
}

.lcd .big{
    font-family:'JetBrains Mono',monospace;
    font-size:28px;
    font-weight:700;
    color:var(--phosphor);
    text-shadow:0 0 10px rgba(94,218,142,.5);
}

.lcd .small{
    font-family:'JetBrains Mono',monospace;
    font-size:10px;
    color:var(--phosphor-dim);
    margin-top:6px;
    letter-spacing:1px;
}

/* ---------- Scope ---------- */

.scope-panel{
    margin-top:22px;
    background:var(--metal);
    border:1px solid var(--line);
    border-radius:16px;
    padding:24px;
}

.scope-panel .scope-head{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:14px;
}

.scope-panel h2{ font-family:'Fraunces',serif; font-weight:600; font-size:18px; }

.scope-legend{
    font-family:'JetBrains Mono',monospace;
    font-size:10.5px;
    color:var(--gray);
    display:flex;
    gap:16px;
}

.scope-legend span::before{
    content:"";
    display:inline-block;
    width:8px; height:8px;
    border-radius:50%;
    margin-right:6px;
    background:var(--phosphor);
}

canvas#scope{
    width:100%;
    height:180px;
    background:var(--metal-deep);
    border-radius:8px;
    border:1px solid var(--phosphor-dim);
}

/* ---------- Bottom ---------- */

.bottom{
    margin-top:22px;
    display:grid;
    grid-template-columns:1.6fr 1fr;
    gap:20px;
    align-items:start;
}

/* Receipt tape */

.tape{
    background:var(--ivory);
    color:#26221b;
    border-radius:6px;
    position:relative;
    padding:22px 22px 14px;
    font-family:'JetBrains Mono',monospace;
}

.tape::before{
    content:"";
    position:absolute;
    top:-6px; left:0; right:0; height:12px;
    background:
        radial-gradient(circle at 8px 6px, var(--metal-deep) 5px, transparent 6px) repeat-x;
    background-size:16px 12px;
}

.tape h2{
    font-family:'Fraunces',serif;
    color:#26221b;
    font-size:16px;
    margin-bottom:12px;
    text-align:center;
}

.tape .rule{
    border-top:1px dashed #b9b09a;
    margin:10px 0;
}

.tape-row{
    display:flex;
    justify-content:space-between;
    font-size:12px;
    padding:6px 0;
}

.tape-row .who{ font-weight:700; }
.tape-row .ok{ color:#3f7a56; }

.tape-foot{
    text-align:center;
    font-size:10px;
    color:#8b8272;
    margin-top:10px;
    letter-spacing:1px;
}

/* Patch panel */

.patch{
    background:var(--metal);
    border:1px solid var(--line);
    border-radius:16px;
    padding:22px;
}

.patch h2{ font-family:'Fraunces',serif; font-weight:600; font-size:18px; margin-bottom:16px; }

.jack{
    display:flex;
    align-items:center;
    gap:12px;
    text-decoration:none;
    color:var(--ivory);
    background:var(--metal-raised);
    border:1px solid var(--line);
    padding:12px 14px;
    border-radius:10px;
    margin-bottom:10px;
    font-size:13.5px;
    font-weight:500;
    transition:border-color .15s, transform .15s;
}

.jack:hover{ border-color:var(--brass); transform:translateX(3px); }

.jack .socket{
    width:20px; height:20px;
    border-radius:50%;
    background:var(--metal-deep);
    border:2px solid var(--brass);
    flex-shrink:0;
}

.jack.red .socket{ border-color:var(--lamp-red); }
.jack.red:hover{ border-color:var(--lamp-red); }

.footer{
    margin-top:24px;
    text-align:center;
    font-family:'JetBrains Mono',monospace;
    font-size:10.5px;
    color:var(--gray);
    letter-spacing:.6px;
}

@media(max-width:980px){
    .wrapper{ flex-direction:column; }
    .switchpanel{ width:100%; min-height:auto; }
    .instruments{ grid-template-columns:1fr; }
    .bottom{ grid-template-columns:1fr; }
    .main{ padding:24px 18px; }
}

</style>
</head>

<body>

<div class="marquee"><span>SYS.NOMINAL — VAULT PRESSURE OK — 0 OPEN INCIDENTS — LAST AUDIT 04:12 — SESSION ENCRYPTED — SYS.NOMINAL — VAULT PRESSURE OK — 0 OPEN INCIDENTS — LAST AUDIT 04:12 — SESSION ENCRYPTED —</span></div>

<div class="wrapper">

    <!-- Switch panel -->

    <div class="switchpanel">

        <div class="brand"><div class="seal">SP</div><span>SecurePAY</span></div>

        <div class="divider">Overview</div>
        <a href="#" class="switch-row on"><span class="toggle"></span>Dashboard</a>
        <a href="ViewUsersServlet" class="switch-row"><span class="toggle"></span>View Users</a>
        <a href="TransactionServlet" class="switch-row"><span class="toggle"></span>Transactions</a>
        <a href="DeleteUser.jsp" class="switch-row"><span class="toggle"></span>Delete User</a>

        <div class="divider">Operations</div>
        <a href="AdminLoanServlet" class="switch-row"><span class="toggle"></span>Loan Requests</a>
        <a href="RechargeHistoryServlet" class="switch-row"><span class="toggle"></span>Recharge History</a>
        <a href="NotificationServlet" class="switch-row"><span class="toggle"></span>Notifications</a>

        <div class="divider">Session</div>
        <a href="AdminLogoutServlet" class="switch-row logout"><span class="toggle"></span>Sign out</a>

    </div>

    <!-- Main -->

    <div class="main">

        <div class="header">
            <div>
                <div class="eyebrow">Control room</div>
                <h1>Admin Dashboard</h1>
            </div>
            <div class="op-status"><i></i>ALL SYSTEMS NOMINAL</div>
        </div>

        <!-- Instruments -->

        <div class="instruments">

            <div class="gauge-panel">
                <div class="label">Total Users</div>
                <svg viewBox="0 0 200 120" id="gaugeUsers"></svg>
                <div class="readout" id="userReadout">0</div>
            </div>

            <div class="gauge-panel">
                <div class="label">Total Transactions</div>
                <svg viewBox="0 0 200 120" id="gaugeTxn"></svg>
                <div class="readout" id="txnReadout">0</div>
            </div>

            <div class="gauge-panel">
                <div class="label">Total Balance</div>
                <div class="lcd">
                    <div class="big">₹<%= totalBalance %></div>
                    <div class="small">LIVE LEDGER BALANCE</div>
                </div>
            </div>

        </div>

        <!-- Scope -->

        <div class="scope-panel">
            <div class="scope-head">
                <h2>System Analytics</h2>
                <div class="scope-legend"><span>Live activity trace</span></div>
            </div>
            <canvas id="scope"></canvas>
        </div>

        <!-- Bottom -->

        <div class="bottom">

            <div class="tape">
                <h2>Recent Activity</h2>
                <div class="tape-row"><span class="who">Rahul</span><span>Money Transfer</span><span class="ok">OK</span></div>
                <div class="rule"></div>
                <div class="tape-row"><span class="who">Priya</span><span>Account Created</span><span class="ok">OK</span></div>
                <div class="rule"></div>
                <div class="tape-row"><span class="who">Amit</span><span>Deposit</span><span class="ok">OK</span></div>
                <div class="tape-foot">— END OF PRINTOUT —</div>
            </div>

            <div class="patch">
                <h2>Quick Actions</h2>
                <a href="ViewUsersServlet" class="jack"><span class="socket"></span>View Users</a>
                <a href="ViewTransactionsServlet" class="jack"><span class="socket"></span>Transactions</a>
                <a href="DeleteUser.jsp" class="jack"><span class="socket"></span>Delete User</a>
                <a href="AdminLogoutServlet" class="jack red"><span class="socket"></span>Logout</a>
            </div>

        </div>

        <div class="footer">© 2026 SECUREPAY — ADMIN CONTROL ROOM — PORTAL v3.0</div>

    </div>

</div>

<script>
const totalUsers = <%= totalUsers %>;
const totalTransactions = <%= totalTransactions %>;

/* ---------- Analog gauge builder ---------- */
function buildGauge(svgId, value, maxValue, readoutId){
    const svg = document.getElementById(svgId);
    const ns = "http://www.w3.org/2000/svg";
    const cx = 100, cy = 105, r = 82;
    const startAngle = -220, endAngle = 40; // degrees, sweeping 260°

    function toRad(deg){ return deg * Math.PI / 180; }
    function point(angleDeg, radius){
        const a = toRad(angleDeg);
        return [cx + radius * Math.cos(a), cy + radius * Math.sin(a)];
    }

    // arc track
    const track = document.createElementNS(ns,'path');
    const [sx,sy] = point(startAngle, r);
    const [ex,ey] = point(endAngle, r);
    track.setAttribute('d', `M ${sx} ${sy} A ${r} ${r} 0 1 1 ${ex} ${ey}`);
    track.setAttribute('fill','none');
    track.setAttribute('stroke','#3a3227');
    track.setAttribute('stroke-width','10');
    track.setAttribute('stroke-linecap','round');
    svg.appendChild(track);

    // ticks
    const tickCount = 13;
    for(let i=0;i<=tickCount;i++){
        const ang = startAngle + (endAngle-startAngle+360)%360 * (i/tickCount);
        const [x1,y1] = point(ang, r-14);
        const [x2,y2] = point(ang, r-4);
        const line = document.createElementNS(ns,'line');
        line.setAttribute('x1',x1); line.setAttribute('y1',y1);
        line.setAttribute('x2',x2); line.setAttribute('y2',y2);
        line.setAttribute('stroke', i % 3 === 0 ? '#e8c765' : '#5c5342');
        line.setAttribute('stroke-width', i % 3 === 0 ? 2.5 : 1.5);
        svg.appendChild(line);
    }

    // progress arc (phosphor)
    const pct = Math.min(value / maxValue, 1);
    const sweep = (endAngle - startAngle + 360) % 360;
    const progEnd = startAngle + sweep * pct;
    const [px,py] = point(progEnd, r);
    const largeArc = sweep * pct > 180 ? 1 : 0;
    const prog = document.createElementNS(ns,'path');
    prog.setAttribute('d', `M ${sx} ${sy} A ${r} ${r} 0 ${largeArc} 1 ${px} ${py}`);
    prog.setAttribute('fill','none');
    prog.setAttribute('stroke','#5eda8e');
    prog.setAttribute('stroke-width','10');
    prog.setAttribute('stroke-linecap','round');
    svg.appendChild(prog);

    // needle
    const needleAngle = progEnd;
    const [nx,ny] = point(needleAngle, r-18);
    const needle = document.createElementNS(ns,'line');
    needle.setAttribute('x1',cx); needle.setAttribute('y1',cy);
    needle.setAttribute('x2',nx); needle.setAttribute('y2',ny);
    needle.setAttribute('stroke','#e8c765');
    needle.setAttribute('stroke-width','3');
    needle.setAttribute('stroke-linecap','round');
    svg.appendChild(needle);

    const hub = document.createElementNS(ns,'circle');
    hub.setAttribute('cx',cx); hub.setAttribute('cy',cy); hub.setAttribute('r',6);
    hub.setAttribute('fill','#c9a227');
    svg.appendChild(hub);

    // animated readout count-up
    let start = 0;
    const duration = 1400;
    const step = Math.max(1, Math.ceil(value/60));
    const timer = setInterval(()=>{
        start += step;
        if(start >= value){ start = value; clearInterval(timer); }
        document.getElementById(readoutId).innerText = start;
    }, duration/60);
}

buildGauge('gaugeUsers', totalUsers, Math.max(totalUsers, 10) * 1.2 || 10, 'userReadout');
buildGauge('gaugeTxn', totalTransactions, Math.max(totalTransactions, 10) * 1.2 || 10, 'txnReadout');

/* ---------- Oscilloscope trace ---------- */
const canvas = document.getElementById('scope');
const dpr = window.devicePixelRatio || 1;
function sizeCanvas(){
    canvas.width = canvas.clientWidth * dpr;
    canvas.height = canvas.clientHeight * dpr;
}
sizeCanvas();
window.addEventListener('resize', sizeCanvas);

const gctx = canvas.getContext('2d');
let points = [];
const pointCount = 120;
for(let i=0;i<pointCount;i++) points.push(0);

function tick(){
    const w = canvas.width, h = canvas.height;
    gctx.clearRect(0,0,w,h);

    // grid
    gctx.strokeStyle = 'rgba(94,218,142,0.08)';
    gctx.lineWidth = 1;
    const cols = 12, rows = 6;
    for(let i=0;i<=cols;i++){
        const x = (w/cols)*i;
        gctx.beginPath(); gctx.moveTo(x,0); gctx.lineTo(x,h); gctx.stroke();
    }
    for(let j=0;j<=rows;j++){
        const y = (h/rows)*j;
        gctx.beginPath(); gctx.moveTo(0,y); gctx.lineTo(w,y); gctx.stroke();
    }

    // shift points, add new sample influenced by real totals
    points.shift();
    const base = Math.sin(Date.now()/600) * 0.25;
    const jitter = (Math.random()-0.5) * 0.18;
    const influence = ((totalUsers + totalTransactions) % 10) / 40;
    points.push(base + jitter + influence);

    gctx.beginPath();
    gctx.strokeStyle = '#5eda8e';
    gctx.lineWidth = 2 * dpr;
    gctx.shadowColor = '#5eda8e';
    gctx.shadowBlur = 6;
    points.forEach((p, i)=>{
        const x = (w/(pointCount-1)) * i;
        const y = h/2 - p * h * 0.7;
        if(i===0) gctx.moveTo(x,y); else gctx.lineTo(x,y);
    });
    gctx.stroke();

    requestAnimationFrame(tick);
}
tick();
</script>

</body>
</html>
