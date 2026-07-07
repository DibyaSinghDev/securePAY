<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SecurePAY Admin Portal</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600&family=Manrope:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">

<style>

:root{
    --charcoal:#151210;
    --panel:#1c1814;
    --line:#332c22;
    --brass:#c9a227;
    --brass-bright:#e6c14d;
    --ivory:#f6f2e8;
    --ivory-dim:#c9c2b0;
    --gray:#8b8577;
    --alert:#c0503f;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

html,body{ height:100%; }

body{
    font-family:'Manrope',sans-serif;
    background:var(--charcoal);
    display:flex;
    color:var(--ivory);
}

::selection{ background:var(--brass); color:var(--charcoal); }

/* ---------- Left: the vault ---------- */

.vault{
    flex:1.3;
    position:relative;
    padding:64px;
    display:flex;
    flex-direction:column;
    justify-content:center;
    overflow:hidden;
    background:
        radial-gradient(circle at 78% 50%, #221d17 0%, var(--charcoal) 62%);
    border-right:1px solid var(--line);
}

/* concentric dial, offset to the right like a vault door */
.dial{
    position:absolute;
    right:-220px;
    top:50%;
    transform:translateY(-50%);
    width:640px;
    height:640px;
    pointer-events:none;
}

.dial svg{ width:100%; height:100%; }

.dial .ticks line{ stroke:var(--line); stroke-width:2; }
.dial .ticks line.major{ stroke:var(--brass); stroke-opacity:.55; }
.dial .ring{ fill:none; stroke:var(--line); }
.dial .needle{
    stroke:var(--brass-bright);
    stroke-width:3;
    stroke-linecap:round;
    transform-origin:320px 320px;
    animation:sweep 14s ease-in-out infinite;
}

@keyframes sweep{
    0%,100%{ transform:rotate(-8deg); }
    50%{ transform:rotate(14deg); }
}

.eyebrow{
    font-family:'JetBrains Mono',monospace;
    font-size:12px;
    letter-spacing:3px;
    color:var(--brass);
    text-transform:uppercase;
    margin-bottom:22px;
    position:relative;
    z-index:2;
}

h1.title{
    font-family:'Fraunces',serif;
    font-weight:600;
    font-size:60px;
    line-height:1.05;
    letter-spacing:-.5px;
    margin-bottom:20px;
    position:relative;
    z-index:2;
}

.lede{
    font-size:16.5px;
    line-height:1.8;
    color:var(--ivory-dim);
    max-width:460px;
    margin-bottom:52px;
    position:relative;
    z-index:2;
}

.layers{
    display:flex;
    flex-direction:column;
    gap:0;
    position:relative;
    z-index:2;
    max-width:480px;
}

.layer{
    display:flex;
    gap:22px;
    padding:20px 0;
    border-top:1px solid var(--line);
}

.layer:last-child{ border-bottom:1px solid var(--line); }

.layer .num{
    font-family:'JetBrains Mono',monospace;
    font-size:12px;
    color:var(--brass);
    padding-top:3px;
    flex-shrink:0;
}

.layer h3{
    font-size:15.5px;
    font-weight:600;
    margin-bottom:4px;
}

.layer p{
    font-size:13.5px;
    color:var(--gray);
    line-height:1.6;
}

/* ---------- Right: deposit slip ---------- */

.access{
    width:460px;
    flex-shrink:0;
    background:var(--ivory);
    display:flex;
    align-items:center;
    justify-content:center;
    padding:40px;
    position:relative;
}

.card{
    width:100%;
    max-width:340px;
    color:var(--charcoal);
}

.card-top{
    display:flex;
    justify-content:space-between;
    align-items:flex-start;
    margin-bottom:6px;
}

.card h2{
    font-family:'Fraunces',serif;
    font-weight:600;
    font-size:30px;
}

.seal{
    width:58px;
    height:58px;
    border-radius:50%;
    background:var(--charcoal);
    color:var(--brass-bright);
    display:flex;
    align-items:center;
    justify-content:center;
    flex-direction:column;
    flex-shrink:0;
    position:relative;
}

.seal::before{
    content:"";
    position:absolute;
    inset:-5px;
    border-radius:50%;
    border:1px dashed var(--brass);
    opacity:.6;
}

.seal span{
    font-family:'JetBrains Mono',monospace;
    font-size:8.5px;
    letter-spacing:.5px;
}

.seal b{
    font-family:'Fraunces',serif;
    font-size:15px;
}

.card > p.sub{
    color:#6b6455;
    font-size:14px;
    line-height:1.6;
    margin:14px 0 34px;
}

.alert{
    display:flex;
    gap:10px;
    background:#f6e4e0;
    border:1px solid #e3b3a8;
    color:#8a3527;
    font-size:13px;
    line-height:1.5;
    padding:12px 14px;
    border-radius:4px;
    margin-bottom:22px;
}

.field{ margin-bottom:22px; }

.field label{
    display:block;
    font-size:11.5px;
    font-weight:700;
    letter-spacing:1.2px;
    text-transform:uppercase;
    color:#6b6455;
    margin-bottom:9px;
}

.field input{
    width:100%;
    padding:12px 2px;
    background:transparent;
    border:none;
    border-bottom:2px solid #d8d0bd;
    font-family:'Manrope',sans-serif;
    font-size:15.5px;
    color:var(--charcoal);
    transition:border-color .15s;
}

.field input::placeholder{ color:#b8af9a; }

.field input:focus{
    outline:none;
    border-color:var(--brass);
}

button{
    width:100%;
    padding:15px;
    border:none;
    border-radius:2px;
    background:var(--charcoal);
    color:var(--brass-bright);
    font-size:14.5px;
    font-weight:700;
    letter-spacing:1px;
    text-transform:uppercase;
    font-family:'Manrope',sans-serif;
    cursor:pointer;
    transition:background .18s, color .18s;
    margin-top:10px;
}

button:hover{ background:#241f18; }
button:focus-visible{ outline:2px solid var(--brass); outline-offset:3px; }

.stamp-row{
    margin-top:28px;
    padding-top:18px;
    border-top:1px solid #e4ddc9;
    display:flex;
    justify-content:space-between;
    font-family:'JetBrains Mono',monospace;
    font-size:10.5px;
    color:#a89f89;
}

@media(prefers-reduced-motion: reduce){
    .needle{ animation:none; transform:rotate(0deg); }
}

@media(max-width:900px){
    body{ flex-direction:column-reverse; height:auto; min-height:100vh; }
    .vault{ display:none; }
    .access{ width:100%; padding:48px 24px; }
}

</style>
</head>

<body>

<div class="vault">

    <div class="dial">
        <svg viewBox="0 0 640 640">
            <circle class="ring" cx="320" cy="320" r="290" />
            <circle class="ring" cx="320" cy="320" r="230" />
            <g class="ticks">
                <!-- generated tick marks every 6 degrees -->
                <g transform="translate(320,320)">
                    <script type="text/plain" id="tickdata"></script>
                </g>
            </g>
            <line class="needle" x1="320" y1="320" x2="320" y2="70" />
            <circle cx="320" cy="320" r="10" fill="#c9a227" />
        </svg>
    </div>

    <div class="eyebrow">Admin console · Restricted</div>
    <h1 class="title">The vault<br>has layers.</h1>
    <p class="lede">
        Every credential, hold, and permission change passes through
        the same controls that protect the accounts themselves.
    </p>

    <div class="layers">
        <div class="layer">
            <div class="num">01</div>
            <div>
                <h3>Outer door — Monitoring</h3>
                <p>Every session and request watched in real time.</p>
            </div>
        </div>
        <div class="layer">
            <div class="num">02</div>
            <div>
                <h3>Inner door — Transaction control</h3>
                <p>Holds, releases, and limits enforced before funds move.</p>
            </div>
        </div>
        <div class="layer">
            <div class="num">03</div>
            <div>
                <h3>Deposit box — User management</h3>
                <p>Access scoped per admin, per action, per account.</p>
            </div>
        </div>
    </div>

</div>

<div class="access">

    <div class="card">

        <div class="card-top">
            <h2>Admin<br>sign in</h2>
            <div class="seal"><span>SECURE</span><b>SP</b></div>
        </div>

        <p class="sub">Enter your credentials to access the administration console.</p>

        <form action="AdminLoginServlet" method="post">

            <div class="field">
                <label for="username">Username</label>
                <input id="username" type="text" name="username" placeholder="j.martinez" required autocomplete="username">
            </div>

            <div class="field">
                <label for="password">Password</label>
                <input id="password" type="password" name="password" placeholder="••••••••••••" required autocomplete="current-password">
            </div>

            <button type="submit">Sign In</button>

        </form>

        <div class="stamp-row">
            <span>ENCRYPTED SESSION</span>
            <span>PORTAL v1.0</span>
        </div>

    </div>

</div>

<script>
// Build tick marks around the dial (every 6°, major every 30°)
const ns = "http://www.w3.org/2000/svg";
const group = document.querySelector('.ticks g');
const cx = 0, cy = 0;
for(let deg = 0; deg < 360; deg += 6){
    const rad = deg * Math.PI / 180;
    const isMajor = deg % 30 === 0;
    const rOuter = 290, rInner = isMajor ? 262 : 275;
    const x1 = cx + rOuter * Math.sin(rad);
    const y1 = cy - rOuter * Math.cos(rad);
    const x2 = cx + rInner * Math.sin(rad);
    const y2 = cy - rInner * Math.cos(rad);
    const line = document.createElementNS(ns, 'line');
    line.setAttribute('x1', x1); line.setAttribute('y1', y1);
    line.setAttribute('x2', x2); line.setAttribute('y2', y2);
    if(isMajor) line.setAttribute('class','major');
    group.appendChild(line);
}
</script>

</body>
</html>