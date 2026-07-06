<%@ page import="java.util.List" %>
<%@ page import="com.securepay.model.Transaction" %>
<%@ page import="com.securepay.model.User" %>

<%
User user =
(User)session.getAttribute("user");

if(user == null){

    response.sendRedirect("Login.jsp");
    return;
}

List<Transaction> transactions =
(List<Transaction>)
request.getAttribute("transactions");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>SecurePAY | Transaction History</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,500;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">

<style>

/* ============ Tokens (shared across SecurePAY) ============ */
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

  --radius-lg:22px;
  --radius-md:14px;

  --shadow-card:0 1px 2px rgba(16,21,31,.04), 0 10px 28px rgba(16,21,31,.06);
}

*{margin:0;padding:0;box-sizing:border-box;}
body{
  font-family:'Inter',sans-serif;
  background:var(--bg);
  color:var(--ink);
  min-height:100vh;
  overflow-x:hidden;
  -webkit-font-smoothing:antialiased;
}
.num,.mono{font-family:'IBM Plex Mono',monospace;}

/* Navbar */
.navbar{
  display:flex;
  justify-content:space-between;
  align-items:center;
  padding:20px 50px;
  background:rgba(245,246,248,.85);
  backdrop-filter:blur(16px);
  border-bottom:1px solid var(--border);
  position:sticky;
  top:0;
  z-index:100;
}
.logo{
  display:flex;
  align-items:center;
  gap:12px;
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
}

.nav-right{
  display:flex;
  align-items:center;
  gap:18px;
}
.nav-right span{
  font-size:14px;
  font-weight:600;
  color:var(--ink-soft);
}
.logout{
  text-decoration:none;
  color:var(--ink);
  padding:11px 20px;
  background:var(--ink);
  color:#F4F6F8;
  border-radius:12px;
  transition:.2s;
  font-size:13.5px;
  font-weight:600;
}
.logout:hover{background:#262C39;}

/* Main */
.container{padding:36px 56px 60px;max-width:1320px;margin:auto;}

/* Header */
.header{
  display:flex;
  justify-content:space-between;
  align-items:flex-end;
  margin-bottom:26px;
}
.header h1{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:34px;
}
.header p{
  color:var(--ink-faint);
  margin-top:6px;
  font-size:14px;
}

/* Summary Cards */
.summary{
  display:grid;
  grid-template-columns:repeat(3,1fr);
  gap:16px;
  margin-bottom:26px;
}
.card{
  padding:24px;
  border-radius:var(--radius-lg);
  background:var(--surface);
  border:1px solid var(--border);
  box-shadow:var(--shadow-card);
  position:relative;
  overflow:hidden;
}
.card::before{
  content:"";
  position:absolute;
  left:0;top:0;bottom:0;
  width:4px;
}
.card h4{
  color:var(--ink-faint);
  margin-bottom:10px;
  font-size:12.5px;
  text-transform:uppercase;
  letter-spacing:1px;
  font-weight:600;
}
.card h2{
  font-family:'Fraunces',serif;
  font-size:26px;
  font-weight:600;
}
.deposit-card::before{background:var(--accent);}
.deposit-card h2{color:var(--accent-dark);}
.withdraw-card::before{background:var(--danger);}
.withdraw-card h2{color:var(--danger);}
.transfer-card::before{background:var(--gold);}
.transfer-card h2{color:var(--gold);}

/* Table */
.table-container{
  background:var(--surface);
  border:1px solid var(--border);
  box-shadow:var(--shadow-card);
  border-radius:var(--radius-lg);
  padding:28px;
  overflow-x:auto;
}

table{width:100%;border-collapse:collapse;min-width:720px;}

th{
  padding:14px 16px;
  text-align:left;
  font-size:11.5px;
  text-transform:uppercase;
  letter-spacing:1px;
  color:var(--ink-faint);
  font-weight:600;
  border-bottom:1px solid var(--border);
}

td{
  padding:16px;
  text-align:left;
  border-bottom:1px solid var(--border-soft);
  font-size:14px;
}
td.mono{font-family:'IBM Plex Mono',monospace;}

tr:last-child td{border-bottom:none;}
tbody tr:hover{background:#FAFBFC;}

/* Type Colors */
.deposit,.withdraw,.transfer{
  display:inline-flex;
  align-items:center;
  gap:7px;
  padding:6px 13px;
  border-radius:50px;
  font-weight:600;
  font-size:12.5px;
}
.deposit::before,.withdraw::before,.transfer::before{content:"";width:6px;height:6px;border-radius:50%;}
.deposit{background:var(--accent-soft);color:var(--accent-dark);}
.deposit::before{background:var(--accent);}
.withdraw{background:var(--danger-soft);color:var(--danger);}
.withdraw::before{background:var(--danger);}
.transfer{background:var(--gold-soft);color:var(--gold);}
.transfer::before{background:var(--gold);}

/* Empty */
.empty{
  padding:50px;
  text-align:center;
  color:var(--ink-faint);
  font-size:14.5px;
}

/* Actions */
.actions{
  display:grid;
  grid-template-columns:repeat(4,1fr);
  gap:16px;
  margin-top:26px;
}
.actions a{
  text-decoration:none;
  color:var(--ink);
  padding:16px;
  text-align:center;
  border-radius:14px;
  background:var(--surface);
  border:1px solid var(--border);
  box-shadow:var(--shadow-card);
  transition:.2s;
  font-size:14px;
  font-weight:600;
}
.actions a:hover{
  border-color:var(--accent);
  color:var(--accent-dark);
  transform:translateY(-3px);
}

/* Footer */
.footer{
  margin-top:36px;
  text-align:center;
  color:var(--ink-faint);
  font-size:12.5px;
}

/* Mobile */
@media(max-width:900px){

.container,
.navbar{
padding:20px;
}

.summary{
grid-template-columns:1fr;
}

.actions{
grid-template-columns:1fr 1fr;
}

}

@media(max-width:600px){

.actions{
grid-template-columns:1fr;
}

.navbar{
flex-direction:column;
gap:15px;
}

}

</style>

</head>

<body>

<div class="navbar">

<div class="logo">
<div class="mark">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="6" width="18" height="14" rx="2"></rect><circle cx="12" cy="13" r="2.4"></circle><path d="M7 6V5a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1"></path></svg>
</div>
<div class="name">SecurePAY</div>
</div>

<div class="nav-right">

<span>

<%= user.getName() %>

</span>

<a href="LogoutServlet"
class="logout">

Logout

</a>

</div>

</div>

<div class="container">

<div class="header">

<div>

<h1>

Transaction History

</h1>

<p>

View and manage all account transactions

</p>

</div>

</div>

<!-- Summary Cards -->

<div class="summary">

<div class="card deposit-card">

<h4>

Deposits

</h4>

<h2>

Active

</h2>

</div>

<div class="card withdraw-card">

<h4>

Withdrawals

</h4>

<h2>

Active

</h2>

</div>

<div class="card transfer-card">

<h4>

Transfers

</h4>

<h2>

Active

</h2>

</div>

</div>

<!-- Transaction Table -->

<div class="table-container">

<table>

<tr>

<th>ID</th>

<th>Sender</th>

<th>Receiver</th>

<th>Amount</th>

<th>Type</th>

<th>Date & Time</th>

</tr>

<%

if(transactions != null &&
!transactions.isEmpty()){

for(Transaction t : transactions){
%>

<tr>

<td class="mono">
<%= t.getTransactionId() %>
</td>

<td class="mono">
<%= t.getSenderAccount() %>
</td>

<td class="mono">
<%= t.getReceiverAccount() %>
</td>

<td class="mono">

 <%= t.getAmount() %>

</td>

<td>

<%

String type =
t.getTransactionType();

if("DEPOSIT".equalsIgnoreCase(type)){
%>

<span class="deposit">

<%= type %>

</span>

<%
}
else if("WITHDRAW".equalsIgnoreCase(type)){
%>

<span class="withdraw">

<%= type %>

</span>

<%
}
else{
%>

<span class="transfer">

<%= type %>

</span>

<%
}
%>

</td>

<td class="mono">

<%= t.getTransactionDate() %>

</td>

</tr>

<%
}
}
else{
%>

<tr>

<td colspan="6"
class="empty">

No transactions available

</td>

</tr>

<%
}
%>

</table>

</div>

<!-- Quick Actions -->

<div class="actions">

<a href="Dashboard.jsp">

Dashboard

</a>

<a href="Deposite.jsp">

Deposit

</a>

<a href="Withdraw.jsp">

Withdraw

</a>

<a href="Transfer.jsp">

Transfer

</a>

</div>

<div class="footer">

© 2026 SecurePAY Digital Banking Platform

</div>

</div>

</body>

</html>
