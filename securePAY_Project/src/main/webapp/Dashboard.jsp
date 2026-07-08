<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.securepay.model.User"%>
<%@ page import="java.util.List"%>
<%@ page import="com.securepay.model.Transaction"%>

<%
User user=(User)session.getAttribute("user");
if(user==null){
response.sendRedirect("Login.jsp");
return;
}
%>
<%
Boolean transferSuccess =
(Boolean)session.getAttribute("transferSuccess");

Integer rewardCoins =
(Integer)session.getAttribute("rewardCoins");

Double transferAmount =
(Double)session.getAttribute("transferAmount");
%>
<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

if(session.getAttribute("user")==null){
    response.sendRedirect("Login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SecurePAY | Dashboard</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,500;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">

<style>

/* ============ Tokens ============ */
:root{
  --bg:#F5F6F8;
  --surface:#FFFFFF;
  --ink:#101521;
  --ink-soft:#59616F;
  --ink-faint:#94A0AF;
  --border:#E4E7EC;
  --border-soft:#EEF0F3;

  --accent:#155C43;
  --accent-dark:#0D4432;
  --accent-soft:#E5F1EC;

  --gold:#96792F;
  --gold-soft:#F5EEDE;

  --danger:#B3261E;
  --danger-soft:#FBEAEA;
  --warn:#9C6B14;
  --warn-soft:#FBF2E2;

  --sidebar-bg:#0D1119;
  --sidebar-ink:#B7BFCB;
  --sidebar-ink-active:#F4F6F8;
  --sidebar-border:#1C2230;

  --radius-lg:22px;
  --radius-md:14px;
  --radius-sm:10px;

  --shadow-card:0 1px 2px rgba(16,21,31,.04), 0 10px 28px rgba(16,21,31,.06);
  --shadow-pop:0 30px 80px rgba(0,0,0,.35);
}

*{margin:0;padding:0;box-sizing:border-box;}
html,body{height:100%;}
body{
  background:var(--bg);
  color:var(--ink);
  font-family:'Inter',sans-serif;
  display:flex;
  min-height:100vh;
  -webkit-font-smoothing:antialiased;
}
a{color:inherit;}
.num, .mono{font-family:'IBM Plex Mono',monospace;}

/* ============ Sidebar ============ */
.sidebar{
  width:264px;
  flex-shrink:0;
  background:var(--sidebar-bg);
  padding:28px 18px;
  display:flex;
  flex-direction:column;
  gap:26px;
}
.logo{
  display:flex;
  align-items:center;
  gap:12px;
  padding:0 8px;
}
.logo .mark{
  width:34px;height:34px;
  border-radius:9px;
  background:var(--accent);
  display:flex;align-items:center;justify-content:center;
  flex-shrink:0;
}
.logo .mark svg{width:18px;height:18px;stroke:#EAF3EE;fill:none;}
.logo .name{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:19px;
  letter-spacing:.2px;
  color:#F4F6F8;
}
.logo .name span{color:var(--sidebar-ink);font-weight:400;font-family:'Inter',sans-serif;font-size:11px;display:block;letter-spacing:1.5px;text-transform:uppercase;margin-top:1px;}

.menu{
  display:flex;
  flex-direction:column;
  gap:2px;
  overflow-y:auto;
}
.menu-label{
  font-size:11px;
  letter-spacing:1.2px;
  text-transform:uppercase;
  color:#5B6373;
  padding:14px 10px 6px;
}
.menu a{
  display:flex;
  align-items:center;
  gap:12px;
  padding:11px 12px;
  color:var(--sidebar-ink);
  text-decoration:none;
  border-radius:10px;
  font-size:14.5px;
  font-weight:500;
  border:1px solid transparent;
  transition:.15s ease;
  position:relative;
}
.menu a svg{width:17px;height:17px;stroke:currentColor;fill:none;flex-shrink:0;opacity:.85;}
.menu a:hover{
  background:#161C29;
  color:var(--sidebar-ink-active);
  border-color:var(--sidebar-border);
}
.menu a.primary{
  background:var(--accent-soft);
  color:var(--accent-dark);
  margin-top:6px;
}
.menu a.primary:hover{background:#D8ECE3;}

/* Chat unread badge on Support chat link */
.chat-badge{
  position:absolute;
  top:8px;
  right:10px;
  min-width:19px;
  height:19px;
  padding:0 5px;
  background:var(--danger);
  color:#fff;
  border-radius:50px;
  display:flex;
  align-items:center;
  justify-content:center;
  font-size:10.5px;
  font-weight:700;
  border:2px solid var(--sidebar-bg);
  font-family:'Inter',sans-serif;
  animation:chatPulse 1.6s ease-in-out infinite;
}

@keyframes chatPulse{
  0%,100%{ transform:scale(1); }
  50%{ transform:scale(1.12); }
}

@media(prefers-reduced-motion: reduce){
  .chat-badge{ animation:none; }
}

/* ============ Main ============ */
.main{flex:1;padding:30px 38px 60px;max-width:1280px;}

.topbar{
  display:flex;
  justify-content:space-between;
  align-items:flex-start;
  margin-bottom:26px;
  gap:20px;
}
.topbar h1{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:26px;
  letter-spacing:.1px;
}
.topbar p{
  color:var(--ink-faint);
  font-size:13.5px;
  margin-top:4px;
}
.topbar-actions{
  display:flex;
  align-items:center;
  gap:14px;
}

.notification{
  position:relative;
  display:inline-flex;
  align-items:center;
  justify-content:center;
  width:42px;height:42px;
  background:var(--surface);
  border:1px solid var(--border);
  border-radius:12px;
  text-decoration:none;
  box-shadow:var(--shadow-card);
  transition:.15s;
}
.notification svg{width:18px;height:18px;stroke:var(--ink-soft);fill:none;}
.notification:hover{border-color:var(--accent);}
.notification:hover svg{stroke:var(--accent-dark);}
.badge{
  position:absolute;
  top:-6px;right:-6px;
  min-width:19px;height:19px;
  padding:0 5px;
  background:var(--danger);
  color:#fff;
  border-radius:50px;
  display:flex;align-items:center;justify-content:center;
  font-size:10.5px;font-weight:700;
  border:2px solid var(--bg);
}
.logout{
  padding:11px 20px;
  background:var(--ink);
  color:#F4F6F8;
  text-decoration:none;
  border-radius:12px;
  font-size:14px;
  font-weight:600;
  transition:.15s;
}
.logout:hover{background:#262C39;}

/* ============ Announcement ============ */
.announcement{
  padding:14px 20px;
  border-radius:var(--radius-md);
  background:var(--accent-soft);
  border:1px solid #CDE4D9;
  color:var(--accent-dark);
  margin-bottom:24px;
  font-size:13.5px;
  font-weight:600;
  display:flex;
  align-items:center;
  gap:10px;
}
.announcement .dot{width:6px;height:6px;border-radius:50%;background:var(--accent);flex-shrink:0;}

/* ============ Balance hero + cards ============ */
.cards{
  display:grid;
  grid-template-columns:1.5fr 1fr 1fr 1fr;
  gap:16px;
}
.card{
  position:relative;
  padding:24px;
  border-radius:var(--radius-lg);
  background:var(--surface);
  border:1px solid var(--border);
  box-shadow:var(--shadow-card);
  overflow:hidden;
}
.card .eyebrow{
  font-size:11.5px;
  letter-spacing:1px;
  text-transform:uppercase;
  color:var(--ink-faint);
  font-weight:600;
  margin-bottom:10px;
}
.card .value{
  font-family:'Fraunces',serif;
  font-size:30px;
  font-weight:600;
  color:var(--ink);
}
.card.balance{background:var(--ink);border-color:var(--ink);}
.card.balance .eyebrow{color:#9BA6B5;}
.card.balance .value{color:#F4F6F8;font-size:34px;}
.card.balance::after{
  content:"";
  position:absolute;
  right:-40px;top:-40px;
  width:140px;height:140px;
  border-radius:50%;
  background:radial-gradient(circle,rgba(21,92,67,.55),transparent 70%);
}
.card .subtext{margin-top:8px;font-size:12px;color:var(--ink-faint);}
.card.balance .subtext{color:#7C8798;}

.card.reward .value{color:var(--gold);}
.card.reward{background:var(--gold-soft);border-color:#EADFC2;}
.card.reward .eyebrow{color:#8A7133;}

.card.status .pill{
  display:inline-flex;
  align-items:center;
  gap:6px;
  padding:6px 14px;
  border-radius:50px;
  background:var(--accent-soft);
  color:var(--accent-dark);
  font-size:13px;
  font-weight:700;
}
.card.status .pill::before{content:"";width:6px;height:6px;border-radius:50%;background:var(--accent);}

/* ============ Promo grid ============ */
.promo-grid{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
  gap:16px;
  margin-top:18px;
}
.promo-card{
  padding:22px;
  border-radius:var(--radius-md);
  border:1px solid var(--border);
  background:var(--surface);
  box-shadow:var(--shadow-card);
}
.promo-card .tag{
  font-size:11px;
  letter-spacing:1px;
  text-transform:uppercase;
  font-weight:700;
  padding:4px 9px;
  border-radius:6px;
  display:inline-block;
  margin-bottom:12px;
}
.promo-card h2{font-family:'Fraunces',serif;font-size:18px;font-weight:600;margin-bottom:6px;}
.promo-card p{font-size:13px;color:var(--ink-soft);line-height:1.45;}
.promo-card.offer .tag{background:var(--accent-soft);color:var(--accent-dark);}
.promo-card.loan .tag{background:#EDEAF7;color:#4B3F91;}
.promo-card.rewardoffer .tag{background:var(--gold-soft);color:#8A7133;}

/* ============ Shop & Order ============ */
.shop-section{
  margin-top:24px;
}
.shop-section-head{
  display:flex;
  justify-content:space-between;
  align-items:baseline;
  margin-bottom:14px;
}
.shop-section-head h2{
  font-family:'Fraunces',serif;
  font-size:20px;
  font-weight:600;
}
.shop-section-head p{
  font-size:12.5px;
  color:var(--ink-faint);
}

.shop-grid{
  display:grid;
  grid-template-columns:repeat(4,1fr);
  gap:14px;
}

.shop-card{
  position:relative;
  display:flex;
  flex-direction:column;
  justify-content:space-between;
  padding:20px;
  border-radius:var(--radius-md);
  text-decoration:none;
  color:#fff;
  min-height:130px;
  overflow:hidden;
  box-shadow:var(--shadow-card);
  transition:transform .15s ease;
}
.shop-card:hover{transform:translateY(-3px);}

.shop-card .shop-icon{
  width:38px;height:38px;
  border-radius:10px;
  background:rgba(255,255,255,.18);
  display:flex;align-items:center;justify-content:center;
  margin-bottom:auto;
}
.shop-card .shop-icon svg{width:19px;height:19px;stroke:#fff;fill:none;}

.shop-card .shop-name{
  font-family:'Fraunces',serif;
  font-size:16px;
  font-weight:600;
  margin-top:14px;
}
.shop-card .shop-tag{
  font-size:11.5px;
  opacity:.85;
  margin-top:2px;
}

.shop-card.flipkart{background:linear-gradient(135deg,#2874F0,#1a56c4);}
.shop-card.amazon{background:linear-gradient(135deg,#232F3E,#0d1117);}
.shop-card.amazon .shop-tag{color:#FF9900;opacity:1;font-weight:600;}
.shop-card.zomato{background:linear-gradient(135deg,#E23744,#b71c2b);}
.shop-card.swiggy{background:linear-gradient(135deg,#FC8019,#d4650f);}

@media(max-width:980px){
  .shop-grid{grid-template-columns:repeat(2,1fr);}
}
@media(max-width:560px){
  .shop-grid{grid-template-columns:1fr;}
}

/* ============ Content: card + quick actions ============ */
.content{
  display:grid;
  grid-template-columns:1.1fr .9fr;
  gap:18px;
  margin-top:24px;
  align-items:start;
}

.bank-card{
  height:200px;
  border-radius:var(--radius-lg);
  padding:26px;
  background:linear-gradient(160deg,#0D1119 0%,#1B2434 100%);
  position:relative;
  color:#EDEFF3;
  overflow:hidden;
  box-shadow:var(--shadow-card);
}
.bank-card::before{
  content:"";
  position:absolute;
  width:38px;height:38px;
  border:1.5px solid rgba(255,255,255,.35);
  border-radius:50%;
  top:26px;left:26px;
}
.bank-card::after{
  content:"";
  position:absolute;
  width:24px;height:24px;
  border:1.5px solid rgba(255,255,255,.25);
  border-radius:50%;
  top:36px;left:36px;
}
.visa{
  position:absolute;
  right:26px;
  top:24px;
  font-size:15px;
  font-weight:700;
  letter-spacing:2px;
  color:#EDEFF3;
}
.bank-card h2{font-family:'Fraunces',serif;font-size:18px;font-weight:600;margin-top:30px;}
.bank-card h3{font-family:'IBM Plex Mono',monospace;font-size:16px;letter-spacing:2px;margin-top:26px;color:#C9CEDA;}
.bank-card h4{font-size:13px;margin-top:14px;letter-spacing:.6px;color:#9BA3B2;text-transform:uppercase;}

.ad-banner{
  margin-top:16px;
  padding:22px;
  border-radius:var(--radius-md);
  background:var(--surface);
  border:1px solid var(--border);
  box-shadow:var(--shadow-card);
}
.ad-banner h2{font-family:'Fraunces',serif;font-size:16px;font-weight:600;margin-bottom:6px;}
.ad-banner p{font-size:13px;color:var(--ink-soft);}

.feature-card{
  background:var(--surface);
  border:1px solid var(--border);
  border-radius:var(--radius-lg);
  padding:26px;
  box-shadow:var(--shadow-card);
}
.feature-card .icon{
  width:52px;height:52px;
  border-radius:14px;
  background:var(--accent-soft);
  display:flex;align-items:center;justify-content:center;
  margin-bottom:16px;
}
.feature-card .icon svg{width:24px;height:24px;stroke:var(--accent-dark);fill:none;}
.feature-card h3{font-family:'Fraunces',serif;font-size:18px;font-weight:600;margin-bottom:8px;}
.feature-card p{color:var(--ink-soft);font-size:13.5px;margin-bottom:20px;line-height:1.5;}

.actions{
  display:grid;
  grid-template-columns:repeat(2,1fr);
  gap:10px;
  margin-top:16px;
}
.actions a{
  text-decoration:none;
  color:var(--ink);
  padding:12px;
  background:var(--bg);
  border:1px solid var(--border);
  text-align:center;
  border-radius:10px;
  font-size:13px;
  font-weight:600;
}
.actions a:hover{border-color:var(--accent);color:var(--accent-dark);}

.btn{
  display:inline-block;
  padding:12px 22px;
  background:var(--accent);
  color:#fff;
  border-radius:11px;
  text-decoration:none;
  font-size:13.5px;
  font-weight:600;
  transition:.15s;
}
.btn:hover{background:var(--accent-dark);}

/* ============ Transactions (ledger) ============ */
.transactions{
  margin-top:28px;
  background:var(--surface);
  border:1px solid var(--border);
  border-radius:var(--radius-lg);
  padding:30px;
  box-shadow:var(--shadow-card);
}
.transactions-head{
  display:flex;
  justify-content:space-between;
  align-items:baseline;
  margin-bottom:22px;
}
.transactions h2{
  font-family:'Fraunces',serif;
  font-size:22px;
  font-weight:600;
}
.transactions-head a{
  font-size:13px;
  font-weight:600;
  color:var(--accent-dark);
  text-decoration:none;
  border-bottom:1px solid #CDE4D9;
}

table{width:100%;border-collapse:collapse;}

.transactions th{
  text-align:left;
  color:var(--ink-faint);
  text-transform:uppercase;
  letter-spacing:1.1px;
  font-size:11.5px;
  font-weight:600;
  padding:0 16px 12px;
  border-bottom:1px solid var(--border);
}
.transactions td{
  padding:16px;
  font-size:14.5px;
  border-bottom:1px solid var(--border-soft);
}
.transactions tbody tr:last-child td{border-bottom:none;}
.transactions tbody tr:hover{background:#FAFBFC;}

.type{display:flex;align-items:center;gap:14px;font-weight:600;}
.icon-box{
  width:40px;height:40px;
  border-radius:11px;
  display:flex;justify-content:center;align-items:center;
  background:var(--accent-soft);
  flex-shrink:0;
}
.icon-box svg{width:18px;height:18px;stroke:var(--accent-dark);fill:none;}

.amount{font-family:'IBM Plex Mono',monospace;font-weight:600;font-size:14.5px;text-align:left;}

.status-pill{
  display:inline-flex;
  align-items:center;
  gap:7px;
  padding:6px 14px;
  border-radius:50px;
  font-weight:600;
  font-size:12.5px;
}
.status-pill::before{content:"";width:6px;height:6px;border-radius:50%;}
.success{background:var(--accent-soft);color:var(--accent-dark);}
.success::before{background:var(--accent);}

.empty-row td{
  text-align:center;
  color:var(--ink-faint);
  padding:34px 16px;
  font-size:13.5px;
}

@media(max-width:980px){
  body{flex-direction:column;}
  .sidebar{width:100%;flex-direction:row;flex-wrap:wrap;}
  .content{grid-template-columns:1fr;}
  .cards{grid-template-columns:repeat(2,1fr);}
}

/* ============ Reward popup ============ */
.reward-popup{
  display:none;
  position:fixed;
  top:0;left:0;
  width:100%;height:100%;
  background:rgba(10,13,20,.72);
  justify-content:center;
  align-items:center;
  z-index:9999;
}
.reward-box{
  width:480px;
  max-width:90vw;
  padding:44px 36px;
  border-radius:26px;
  background:var(--surface);
  text-align:center;
  position:relative;
  overflow:hidden;
  box-shadow:var(--shadow-pop);
  border:1px solid var(--border);
}
.reward-title{
  font-family:'Fraunces',serif;
  font-size:26px;
  font-weight:600;
  color:var(--accent-dark);
  margin-bottom:6px;
}
.reward-box h2{
  font-family:'Fraunces',serif;
  font-size:32px;
  font-weight:600;
  color:var(--ink);
  margin-top:10px;
}
.reward-coins{
  font-family:'IBM Plex Mono',monospace;
  font-size:22px;
  font-weight:600;
  color:var(--gold);
  margin-top:18px;
  background:var(--gold-soft);
  display:inline-block;
  padding:10px 20px;
  border-radius:50px;
}
.check-mark{
  width:56px;height:56px;
  border-radius:50%;
  background:var(--accent-soft);
  display:flex;align-items:center;justify-content:center;
  margin:0 auto 16px;
}
.check-mark svg{width:26px;height:26px;stroke:var(--accent-dark);fill:none;}

.coin{position:absolute;font-size:34px;bottom:-80px;animation:coinFly 3s linear infinite;opacity:.9;}
.c1{left:8%;}
.c2{left:28%;animation-delay:.5s;}
.c3{left:50%;animation-delay:1s;}
.c4{left:70%;animation-delay:1.5s;}
.c5{left:88%;animation-delay:2s;}

@keyframes coinFly{
0%{transform:translateY(0) rotate(0deg);opacity:0;}
20%{opacity:.9;}
100%{transform:translateY(-460px) rotate(720deg);opacity:0;}
}

</style>
</head>

<body>

<div id="rewardPopup" class="reward-popup">
<div class="reward-box">

<div class="check-mark">
<svg viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
</div>

<h1 class="reward-title">Transfer Successful</h1>

<h2>₹ <%= transferAmount != null ? transferAmount : 0 %> Transferred</h2>

<div class="reward-coins">
🪙 +<%= rewardCoins != null ? rewardCoins : 0 %> Reward Coins
</div>

<div class="coin c1">🪙</div>
<div class="coin c2">🪙</div>
<div class="coin c3">🪙</div>
<div class="coin c4">🪙</div>
<div class="coin c5">🪙</div>

</div>
</div>

<script>

window.onload=function(){

<%
if(Boolean.TRUE.equals(transferSuccess)){
%>

document.getElementById(
"rewardPopup")
.style.display="flex";

setTimeout(function(){

document.getElementById(
"rewardPopup")
.style.display="none";

},5000);

<%
session.removeAttribute("transferSuccess");
session.removeAttribute("rewardCoins");
session.removeAttribute("transferAmount");
}
%>

};

</script>
<script>
let balanceHidden = false;

function toggleBalance(){
  const el = document.getElementById('balanceValue');
  const icon = document.getElementById('eyeIcon');
  balanceHidden = !balanceHidden;

  if(balanceHidden){
    el.textContent = '₹ ••••••';
    icon.innerHTML = '<path d="M17.94 17.94A10.94 10.94 0 0 1 12 20c-7 0-11-8-11-8a20.3 20.3 0 0 1 4.22-5.94M9.9 4.24A10.94 10.94 0 0 1 12 4c7 0 11 8 11 8a20.3 20.3 0 0 1-2.44 3.44M1 1l22 22M9.5 9.5a3 3 0 0 0 4.24 4.24"></path>';
  } else {
    const val = el.getAttribute('data-balance');
    el.textContent = '₹ ' + val;
    icon.innerHTML = '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8Z"></path><circle cx="12" cy="12" r="3"></circle>';
  }
}
</script>

<div class="sidebar">

<div class="logo">
<div class="mark">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="6" width="18" height="14" rx="2"></rect><circle cx="12" cy="13" r="2.4"></circle><path d="M7 6V5a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1"></path></svg>
</div>
<div class="name">SecurePAY<span>Banking</span></div>
</div>

<div class="menu">

<div class="menu-label">Overview</div>
<a href="Dashboard.jsp">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M3 11l9-8 9 8"></path><path d="M5 10v10h14V10"></path></svg>
Dashboard
</a>
<a href="TransactionServlet">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M4 6h16M4 12h16M4 18h10"></path></svg>
Transactions
</a>
<a href="PassbookServlet">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M4 5a2 2 0 0 1 2-2h9l5 5v11a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2Z"></path><path d="M9 12h6M9 16h6"></path></svg>
Passbook
</a>

<div class="menu-label">Move money</div>
<a href="Deposite.jsp">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 19V5M5 12l7-7 7 7"></path></svg>
Deposit
</a>
<a href="Withdraw.jsp">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 5v14M5 12l7 7 7-7"></path></svg>
Withdraw
</a>
<a href="Transfer.jsp">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3l4 4-4 4M21 7H7M7 21l-4-4 4-4M3 17h14"></path></svg>
Transfer
</a>
<a href="LoanApplication.jsp">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="16" rx="2"></rect><path d="M7 9h10M7 13h6"></path></svg>
Loan
</a>

<div class="menu-label">Bills &amp; recharge</div>
<a href="RechargeServlet">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2 4 14h6l-1 8 9-12h-6l1-8Z"></path></svg>
Recharge
</a>
<a href="MobileRecharge.jsp">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="7" y="2" width="10" height="20" rx="2"></rect><path d="M11 18h2"></path></svg>
Mobile recharge
</a>
<a href="ElectricityRecharge.jsp">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2 4 14h6l-1 8 9-12h-6l1-8Z"></path></svg>
Electricity bill
</a>
<a href="RechargeHistoryServlet">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"></circle><path d="M12 7v5l3 3"></path></svg>
Recharge history
</a>

<div class="menu-label">Account</div>
<a href="Profile.jsp">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"></circle><path d="M4 21c1.5-4 5-6 8-6s6.5 2 8 6"></path></svg>
Profile
</a>
<a href="ChangePassword.jsp">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="9" rx="2"></rect><path d="M8 11V7a4 4 0 0 1 8 0v4"></path></svg>
Password
</a>
<a href="NotificationServlet">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8a6 6 0 0 0-12 0c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.7 21a2 2 0 0 1-3.4 0"></path></svg>
Notifications
</a>
<%
Integer unreadChatCount = (Integer) session.getAttribute("unreadChatCount");
%>
<a href="chatbot.jsp" class="primary">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-8.5 8.4 8.5 8.5 0 0 1-4-1L3 21l1.1-5.5A8.4 8.4 0 0 1 12.5 3a8.38 8.38 0 0 1 8.5 8.5Z"></path></svg>
Support chat
<%
if(unreadChatCount != null && unreadChatCount > 0){
%>
<span class="chat-badge"><%= unreadChatCount > 9 ? "9+" : unreadChatCount %></span>
<%
}
%>
</a>

</div>
</div>

<div class="main">

<div class="topbar">
<div>
<h1>Welcome back, <%= user.getName() %></h1>
<p><%= user.getEmail() %></p>
</div>
<div class="topbar-actions">
<a href="NotificationServlet" class="notification">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8a6 6 0 0 0-12 0c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.7 21a2 2 0 0 1-3.4 0"></path></svg>
<%
Integer unreadCount=(Integer)session.getAttribute("unreadCount");
if(unreadCount!=null && unreadCount>0){
%>
<span class="badge"><%= unreadCount %></span>
<%
}
%>
</a>
<a href="LogoutServlet" class="logout">Logout</a>
</div>
</div>

<div class="announcement">
<span class="dot"></span>
Special offer: get ₹100 cashback on your first transfer today.
</div>

<div class="cards">

<div class="card balance">
<div class="eyebrow">Available balance</div>
<div style="display:flex;align-items:center;gap:10px;">
<div class="value num" id="balanceValue" data-balance="<%= user.getBalance() %>">₹ <%= user.getBalance() %></div>
<button type="button" id="toggleBalanceBtn" onclick="toggleBalance()" aria-label="Toggle balance visibility" style="background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.18);border-radius:8px;width:32px;height:32px;display:flex;align-items:center;justify-content:center;cursor:pointer;flex-shrink:0;padding:0;">
<svg id="eyeIcon" viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" stroke="#C9CEDA" fill="none" width="16" height="16">
<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8Z"></path>
<circle cx="12" cy="12" r="3"></circle>
</svg>
</button>

</div>
<div class="subtext">Updated just now</div>
</div>

<div class="card reward">
<div class="eyebrow">Reward coins</div>
<div class="value num">🪙 450</div>
</div>

<div class="card">
<div class="eyebrow">Account number</div>
<div class="value num" style="font-size:20px;letter-spacing:.5px;"><%= user.getAccountNumber() %></div>
</div>

<div class="card status">
<div class="eyebrow">Account status</div>
<span class="pill">Active</span>
</div>

</div>

<div class="promo-grid">

<div class="promo-card offer">
<span class="tag">Cashback</span>
<h2>Cashback festival</h2>
<p>Get 10% cashback on UPI payments above ₹500.</p>
</div>

<div class="promo-card loan">
<span class="tag">Credit</span>
<h2>Instant loan</h2>
<p>Loans up to ₹5,00,000 with instant approval.</p>
</div>

<div class="promo-card rewardoffer">
<span class="tag">Rewards</span>
<h2>Reward bonus</h2>
<p>Earn double reward coins this weekend.</p>
</div>

</div>

<div class="shop-section">
  <div class="shop-section-head">
    <h2>Shop &amp; order</h2>
    <p>Partner offers · opens in a new tab</p>
  </div>

  <div class="shop-grid">

    <a href="https://www.flipkart.com" target="_blank" rel="noopener" class="shop-card flipkart">
      <div class="shop-icon">
        <svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M6 6h15l-1.5 9h-12z"></path><circle cx="9" cy="20" r="1"></circle><circle cx="18" cy="20" r="1"></circle><path d="M6 6L4 3H2"></path></svg>
      </div>
      <div>
        <div class="shop-name">Flipkart</div>
        <div class="shop-tag">Shop electronics &amp; more</div>
      </div>
    </a>

    <a href="https://www.amazon.in" target="_blank" rel="noopener" class="shop-card amazon">
      <div class="shop-icon">
        <svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M6 6h15l-1.5 9h-12z"></path><circle cx="9" cy="20" r="1"></circle><circle cx="18" cy="20" r="1"></circle><path d="M6 6L4 3H2"></path></svg>
      </div>
      <div>
        <div class="shop-name">Amazon</div>
        <div class="shop-tag">Today's deals</div>
      </div>
    </a>

    <a href="https://www.zomato.com" target="_blank" rel="noopener" class="shop-card zomato">
      <div class="shop-icon">
        <svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8h1a4 4 0 0 1 0 8h-1"></path><path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4Z"></path><line x1="6" y1="1" x2="6" y2="4"></line><line x1="10" y1="1" x2="10" y2="4"></line><line x1="14" y1="1" x2="14" y2="4"></line></svg>
      </div>
      <div>
        <div class="shop-name">Zomato</div>
        <div class="shop-tag">Order food nearby</div>
      </div>
    </a>

    <a href="https://www.swiggy.com" target="_blank" rel="noopener" class="shop-card swiggy">
      <div class="shop-icon">
        <svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8h1a4 4 0 0 1 0 8h-1"></path><path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4Z"></path><line x1="6" y1="1" x2="6" y2="4"></line><line x1="10" y1="1" x2="10" y2="4"></line><line x1="14" y1="1" x2="14" y2="4"></line></svg>
      </div>
      <div>
        <div class="shop-name">Swiggy</div>
        <div class="shop-tag">Fast delivery, hot food</div>
      </div>
    </a>

  </div>
</div>

<div class="content">

<div>
<div class="bank-card">
<div class="visa">VISA</div>
<h2>SecurePAY Platinum</h2>
<h3>**** **** **** 4589</h3>
<h4><%= user.getName() %></h4>
</div>

<div class="ad-banner">
<h2>SecurePAY Platinum Card</h2>
<p>Airport lounge access, cashback and premium rewards.</p>
</div>
</div>

<div class="feature-card">
<div class="icon">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2 4 14h6l-1 8 9-12h-6l1-8Z"></path></svg>
</div>
<h3>Recharge &amp; bills</h3>
<p>Mobile, electricity, DTH, water, gas and broadband — all in one place.</p>
<a href="RechargeServlet" class="btn">Recharge now</a>

<div class="actions">
<a href="MobileRecharge.jsp">Mobile</a>
<a href="ElectricityRecharge.jsp">Electricity</a>
<a href="RechargeHistoryServlet">History</a>
<a href="LoanApplication.jsp">Loan</a>
</div>
</div>

</div>

<div class="transactions">

<div class="transactions-head">
<h2>Recent transactions</h2>
<a href="TransactionServlet">View all</a>
</div>

<table>
<thead>
<tr>
<th>Type</th>
<th>Amount</th>
<th>Status</th>
</tr>
</thead>
<tbody>

<%
List<Transaction> recentTransactions=(List<Transaction>)request.getAttribute("recentTransactions");

if(recentTransactions!=null && !recentTransactions.isEmpty()){
for(Transaction t:recentTransactions){
%>
<tr>
<td>
<div class="type">
<div class="icon-box">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3l4 4-4 4M21 7H7M7 21l-4-4 4-4M3 17h14"></path></svg>
</div>
<%= t.getTransactionType() %>
</div>
</td>
<td class="amount">₹ <%= t.getAmount() %></td>
<td><span class="status-pill success">Success</span></td>
</tr>
<%
}
}else{
%>
<tr class="empty-row"><td colspan="3">No recent transactions yet.</td></tr>
<%
}
%>

</tbody>
</table>

</div>

</div>

</body>
</html>