
<%@ page import="com.securepay.model.User" %>

<%
User user =
(User)session.getAttribute("user");

if(user == null){

    response.sendRedirect("Login.jsp");
    return;
}

String acctRaw = user.getAccountNumber();
StringBuilder acctSpaced = new StringBuilder();
if(acctRaw != null){
    for(int i=0;i<acctRaw.length();i++){
        if(i>0 && i%4==0) acctSpaced.append(" ");
        acctSpaced.append(acctRaw.charAt(i));
    }
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">

<title>SecurePAY | Profile</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@500;600;700&display=swap" rel="stylesheet">

<style>

:root{
  --ink:#0B1B33;
  --ink-2:#14294c;
  --gold:#C9A44C;
  --gold-soft:#e4c98a;
  --paper:#F7F4EC;
  --paper-line:#E4DFC9;
  --ledger-ink:#1F2A3B;
  --credit:#1E7B4D;
  --muted:#6B7280;
}

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Inter',sans-serif;
}

body{
background:
  radial-gradient(ellipse at top left, rgba(201,164,76,.10), transparent 55%),
  linear-gradient(160deg,var(--ink) 0%,var(--ink-2) 55%,#0d2044 100%);
color:white;
min-height:100vh;
overflow-x:hidden;
}

/* ---------- Navbar ---------- */
.navbar{
display:flex;justify-content:space-between;align-items:center;
padding:20px 48px;
background:rgba(11,27,51,.75);
backdrop-filter:blur(16px);
border-bottom:1px solid rgba(201,164,76,.25);
position:sticky;top:0;z-index:10;
}
.logo{
font-family:'Fraunces',serif;font-size:24px;font-weight:700;
display:flex;align-items:center;gap:10px;
}
.logo .mark{
width:32px;height:32px;border-radius:50%;
border:1.5px solid var(--gold);
display:flex;align-items:center;justify-content:center;
font-size:15px;color:var(--gold);
}
.nav-right{display:flex;align-items:center;gap:18px;font-family:'IBM Plex Mono',monospace;font-size:13.5px}
.nav-right span{color:rgba(255,255,255,.75)}
.logout{
text-decoration:none;color:white;padding:10px 18px;
background:#B23A2E;border-radius:10px;transition:.2s;
font-family:'Inter',sans-serif;font-weight:600;font-size:13.5px;
}
.logout:hover{background:#8f2d21}

/* ---------- Main ---------- */
.container{
width:92%;max-width:1000px;
margin:0 auto;
padding:44px 0 70px;
}

.header h1{
font-family:'Fraunces',serif;font-size:36px;font-weight:600;
}
.header p{color:rgba(255,255,255,.6);margin-top:8px;font-size:14.5px}

/* ---------- Signature element: flip bank card ---------- */
.card-wrap{
margin:34px auto 0;
max-width:420px;
}
.card-hint{
text-align:center;font-size:12px;color:var(--gold-soft);
font-family:'IBM Plex Mono',monospace;letter-spacing:.5px;
margin-bottom:12px;display:flex;align-items:center;justify-content:center;gap:8px;
}
.card-hint svg{width:14px;height:14px}

.scene{perspective:1600px}
.flip{
position:relative;width:100%;aspect-ratio:1.586/1;
transform-style:preserve-3d;
transition:transform .7s cubic-bezier(.4,.2,.2,1);
cursor:pointer;
}
.flip.flipped{transform:rotateY(180deg)}
.flip:focus-visible{outline:2px solid var(--gold);outline-offset:4px}

.face{
position:absolute;inset:0;
backface-visibility:hidden;
border-radius:20px;
border:1px solid rgba(201,164,76,.4);
padding:26px 28px;
overflow:hidden;
box-shadow:0 25px 55px rgba(0,0,0,.4);
}

.front{
background:linear-gradient(135deg,#16305c,#0b1b33 55%,#081428);
display:flex;flex-direction:column;justify-content:space-between;
}
.front::after{
content:"";position:absolute;top:-60%;left:-20%;width:70%;height:220%;
background:linear-gradient(115deg, rgba(255,255,255,.10) 0%, transparent 40%);
transform:rotate(20deg);
pointer-events:none;
}

.front-top{display:flex;justify-content:space-between;align-items:flex-start}
.chip{
width:42px;height:32px;border-radius:6px;
background:linear-gradient(135deg,var(--gold-soft),var(--gold));
position:relative;
}
.chip::before,.chip::after{
content:"";position:absolute;left:6px;right:6px;height:1px;background:rgba(11,27,51,.4);
}
.chip::before{top:10px}
.chip::after{top:20px}
.brand{
font-family:'Fraunces',serif;font-weight:700;font-size:16px;
color:var(--gold-soft);letter-spacing:.5px;
}
.acct-type{
font-family:'IBM Plex Mono',monospace;font-size:10.5px;color:rgba(255,255,255,.5);
letter-spacing:1.5px;text-transform:uppercase;margin-top:2px;
}

.card-number{
font-family:'IBM Plex Mono',monospace;font-size:20px;letter-spacing:3px;
color:#fff;text-shadow:0 1px 0 rgba(255,255,255,.15);
margin:8px 0;
}

.front-bottom{display:flex;justify-content:space-between;align-items:flex-end}
.holder-label,.since-label{
font-size:9.5px;letter-spacing:1.5px;text-transform:uppercase;color:rgba(255,255,255,.45);
margin-bottom:4px;
}
.holder-name{
font-family:'Inter',sans-serif;font-weight:600;font-size:15px;letter-spacing:.5px;
text-transform:uppercase;
}
.mini-mark{
width:26px;height:26px;border-radius:50%;
border:1.5px solid var(--gold);color:var(--gold);
display:flex;align-items:center;justify-content:center;font-size:11px;
}

.back{
background:linear-gradient(135deg,#0b1b33,#16305c);
transform:rotateY(180deg);
display:flex;flex-direction:column;
}
.magstripe{
height:38px;background:#08111f;margin:2px -28px 18px;
}
.back-row{
display:flex;justify-content:space-between;align-items:center;
padding:10px 0;border-bottom:1px dashed rgba(255,255,255,.15);
}
.back-row:last-of-type{border-bottom:none}
.back-row span{font-size:10.5px;letter-spacing:1px;text-transform:uppercase;color:rgba(255,255,255,.45)}
.back-row b{font-family:'IBM Plex Mono',monospace;font-size:14px;color:#fff}
.back-foot{
margin-top:auto;text-align:center;font-size:10px;color:rgba(255,255,255,.35);
font-family:'IBM Plex Mono',monospace;letter-spacing:1px;
}

/* ---------- Info grid ---------- */
.info-grid{
margin-top:40px;
display:grid;grid-template-columns:repeat(2,1fr);gap:16px;
}
.info-card{
background:var(--paper);color:var(--ledger-ink);
padding:22px 24px;border-radius:16px;
box-shadow:0 15px 35px rgba(0,0,0,.25);
border-left:3px solid var(--gold);
}
.info-card h4{
font-size:11px;letter-spacing:1px;text-transform:uppercase;color:var(--muted);font-weight:600;
}
.info-card p{
font-family:'IBM Plex Mono',monospace;font-size:17px;font-weight:600;margin-top:8px;
}

/* ---------- Actions ---------- */
.actions{
display:grid;grid-template-columns:repeat(2,1fr);gap:16px;margin-top:30px;
}
.btn{
text-decoration:none;text-align:center;padding:16px;border-radius:12px;
font-weight:600;font-size:14.5px;transition:.2s;color:#fff;
display:flex;align-items:center;justify-content:center;gap:8px;
}
.dashboard{background:var(--ink);border:1px solid rgba(201,164,76,.35)}
.dashboard:hover{background:var(--ink-2)}
.password{background:transparent;border:1.5px solid var(--gold);color:var(--gold-soft)}
.password:hover{background:rgba(201,164,76,.12)}

.footer{margin-top:44px;text-align:center;color:rgba(255,255,255,.35);font-size:12.5px}

@media(max-width:900px){
.navbar{padding:16px 20px}
.container{padding:32px 0 50px}
.header h1{font-size:28px}
.info-grid,.actions{grid-template-columns:1fr}
}

</style>

</head>

<body>

<div class="navbar">
<div class="logo"><span class="mark">S</span>SecurePAY</div>
<div class="nav-right">
<span><%= user.getName() %></span>
<a href="LogoutServlet" class="logout">Logout</a>
</div>
</div>

<div class="container">

<div class="header">
<h1>My Profile</h1>
<p>Manage your account information securely.</p>
</div>

<div class="card-wrap">
<div class="card-hint">
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 3a2.83 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/></svg>
Tap the card to flip
</div>
<div class="scene">
<div class="flip" id="bankCard" tabindex="0" role="button" aria-label="Flip account card">
<div class="face front">
<div class="front-top">
<div>
<div class="brand">SecurePAY</div>
<div class="acct-type">Savings Account</div>
</div>
<div class="chip"></div>
</div>
<div class="card-number"><%= acctSpaced.length()==0 ? "---- ---- ----" : acctSpaced.toString() %></div>
<div class="front-bottom">
<div>
<div class="holder-label">Card Holder</div>
<div class="holder-name"><%= user.getName() %></div>
</div>
<div class="mini-mark">S</div>
</div>
</div>

<div class="face back">
<div class="magstripe"></div>
<div class="back-row"><span>Email</span><b><%= user.getEmail() %></b></div>
<div class="back-row"><span>Available Balance</span><b>₹ <%= user.getBalance() %></b></div>
<div class="back-row"><span>Account No.</span><b><%= user.getAccountNumber() %></b></div>
<div class="back-foot">SECUREPAY DIGITAL BANKING PLATFORM</div>
</div>
</div>
</div>
</div>

<div class="info-grid">
<div class="info-card">
<h4>Full Name</h4>
<p><%= user.getName() %></p>
</div>
<div class="info-card">
<h4>Email Address</h4>
<p><%= user.getEmail() %></p>
</div>
<div class="info-card">
<h4>Account Number</h4>
<p><%= user.getAccountNumber() %></p>
</div>
<div class="info-card">
<h4>Available Balance</h4>
<p>₹ <%= user.getBalance() %></p>
</div>
</div>

<div class="actions">
<a href="DashboardServlet" class="btn dashboard">Back To Dashboard</a>
<a href="ChangePassword.jsp" class="btn password">Change Password</a>
</div>

<div class="footer">© 2026 SecurePAY Digital Banking Platform</div>

</div>

<script>
const card=document.getElementById('bankCard');
function toggleFlip(){card.classList.toggle('flipped');}
card.addEventListener('click',toggleFlip);
card.addEventListener('keydown',function(e){
 if(e.key==='Enter'||e.key===' '){e.preventDefault();toggleFlip();}
});
</script>

</body>

</html>
