<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.securepay.model.User"%>
<%
User user=(User)session.getAttribute("user");
if(user==null){
 response.sendRedirect("Login.jsp");
 return;
}
String error=(String)request.getAttribute("error");
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
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>SecurePAY | Deposit Funds</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">
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
  --debit:#B23A2E;
  --muted:#6B7280;
  --radius:18px;
}
*{margin:0;padding:0;box-sizing:border-box;font-family:'Inter',sans-serif}
body{
  background:
    radial-gradient(ellipse at top left, rgba(201,164,76,.10), transparent 55%),
    linear-gradient(160deg,var(--ink) 0%,var(--ink-2) 55%,#0d2044 100%);
  color:#fff;min-height:100vh;
}

/* ---------- Navbar ---------- */
.navbar{
  background:rgba(11,27,51,.75);
  backdrop-filter:blur(16px);
  border-bottom:1px solid rgba(201,164,76,.25);
  padding:18px 44px;
  position:sticky;top:0;z-index:10;
}
.navbar-top{display:flex;justify-content:space-between;align-items:center}
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
  text-decoration:none;color:#fff;background:var(--debit);
  padding:10px 18px;border-radius:10px;font-family:'Inter',sans-serif;
  font-weight:600;font-size:13.5px;transition:.2s;
}
.logout:hover{background:#961f16}
.navbar-menu{display:flex;justify-content:center;gap:12px;flex-wrap:wrap;margin-top:18px}
.navbar-menu a{
  text-decoration:none;color:rgba(255,255,255,.85);
  padding:10px 20px;background:rgba(255,255,255,.06);
  border:1px solid rgba(255,255,255,.08);
  border-radius:10px;font-size:13.5px;font-weight:500;
  transition:.2s;
}
.navbar-menu a:hover{background:rgba(201,164,76,.16);border-color:rgba(201,164,76,.35);color:var(--gold-soft)}

.container{width:92%;max-width:900px;margin:40px auto 70px}

.header .eyebrow{
  font-family:'IBM Plex Mono',monospace;font-size:12px;letter-spacing:2px;
  text-transform:uppercase;color:var(--gold-soft);
}
.header h1{font-family:'Fraunces',serif;font-size:38px;font-weight:600;margin-top:8px}
.header p{color:rgba(255,255,255,.6);margin-top:8px;font-size:14.5px}

/* ---------- Balance ---------- */
.balance-card{
  margin-top:28px;padding:32px 36px;border-radius:var(--radius);
  background:linear-gradient(155deg,#0e2145,#1a3663 60%,#0e2145);
  border:1px solid rgba(201,164,76,.35);
  box-shadow:0 25px 50px rgba(0,0,0,.35);
  position:relative;overflow:hidden;
}
.balance-card::before{
  content:"";position:absolute;inset:0;
  background:repeating-linear-gradient(115deg, rgba(255,255,255,.03) 0 2px, transparent 2px 26px);
  pointer-events:none;
}
.balance-card h4{
  font-size:12px;letter-spacing:1.5px;text-transform:uppercase;
  color:rgba(255,255,255,.55);font-weight:600;
}
.balance-card .amount{
  font-family:'Fraunces',serif;font-size:48px;font-weight:600;
  margin-top:8px;font-variant-numeric:tabular-nums;
}

/* ---------- Deposit panel ---------- */
.deposit-panel{
  margin-top:26px;padding:34px 36px;border-radius:var(--radius);
  background:var(--paper);color:var(--ledger-ink);
  box-shadow:0 20px 45px rgba(0,0,0,.3);
}
.panel-title{font-family:'Fraunces',serif;font-size:20px;margin-bottom:22px;color:var(--ink)}
.deposit-panel label{
  display:block;margin-bottom:9px;color:var(--muted);
  font-size:12.5px;font-weight:600;letter-spacing:.6px;text-transform:uppercase;
}
.amount-field{position:relative}
.amount-field .prefix{
  position:absolute;left:16px;top:50%;transform:translateY(-50%);
  font-family:'IBM Plex Mono',monospace;color:var(--muted);font-size:15px;
}
.deposit-panel input{
  width:100%;padding:16px 16px 16px 38px;border-radius:12px;
  border:1px solid #D8D2BC;background:#fff;color:var(--ledger-ink);
  font-family:'IBM Plex Mono',monospace;font-size:15px;
}
.deposit-panel input:focus{border-color:var(--gold);outline:2px solid var(--gold-soft);outline-offset:1px}
.deposit-btn{
  margin-top:22px;width:100%;padding:16px;border:none;border-radius:12px;
  background:var(--ink);color:#fff;font-size:15px;font-weight:600;cursor:pointer;
  transition:.2s;font-family:'Inter',sans-serif;
}
.deposit-btn:hover{background:var(--ink-2)}
.deposit-btn:focus-visible{outline:2px solid var(--gold);outline-offset:2px}

.server{
  background:rgba(30,123,77,.12);color:var(--credit);
  border:1px solid rgba(30,123,77,.3);
  padding:12px 16px;border-radius:10px;margin-bottom:18px;font-size:13.5px;
}

.footer{text-align:center;color:rgba(255,255,255,.35);margin-top:44px;font-size:12.5px;letter-spacing:.4px}

@media(max-width:900px){
  .navbar{padding:16px 20px}
  .container{width:94%}
  .balance-card,.deposit-panel{padding:26px 22px}
  .header h1{font-size:30px}
  .balance-card .amount{font-size:36px}
}
</style>
</head>
<body>
<div class="navbar">
<div class="navbar-top">
<div class="logo"><span class="mark">S</span>SecurePAY</div>
<div class="nav-right">
<span><%=user.getName()%></span>
<a href="LogoutServlet" class="logout">Logout</a>
</div>
</div>
<div class="navbar-menu">
<a href="Dashboard.jsp">Dashboard</a>
<a href="Withdraw.jsp">Withdraw</a>
<a href="Transfer.jsp">Transfer</a>
<a href="TransactionServlet">Transactions</a>
</div>
</div>

<div class="container">
<div class="header">
<div class="eyebrow">Add Funds</div>
<h1>Deposit Funds</h1>
<p>Add money securely to your account.</p>
</div>

<div class="balance-card">
<h4>Current Balance</h4>
<div class="amount">₹ <%=user.getBalance()%></div>
</div>

<div class="deposit-panel">
<div class="panel-title">Enter deposit details</div>
<% if(error!=null){ %>
<div class="server"><%=error%></div>
<% } %>

<form action="DepositServlet" method="post">
<label for="amount">Deposit Amount</label>
<div class="amount-field">
<span class="prefix">₹</span>
<input id="amount" type="number" name="amount" min="1" placeholder="Enter deposit amount" required>
</div>
<button type="submit" class="deposit-btn">Deposit Funds</button>
</form>
</div>

<div class="footer">© 2026 SecurePAY Digital Banking Platform</div>
</div>
</body>
</html>
