
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

<title>SecurePAY | Transaction History</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{

background:
linear-gradient(
135deg,
#020617,
#0f172a,
#111827);

color:white;

min-height:100vh;

overflow-x:hidden;
}

/* Navbar */

.navbar{

display:flex;

justify-content:space-between;

align-items:center;

padding:25px 50px;

background:
rgba(255,255,255,.04);

backdrop-filter:blur(20px);

border-bottom:
1px solid rgba(255,255,255,.08);
}

.logo{

font-size:30px;

font-weight:700;

color:#38bdf8;
}

.nav-right{

display:flex;

align-items:center;

gap:20px;
}

.logout{

text-decoration:none;

color:white;

padding:12px 20px;

background:#ef4444;

border-radius:12px;

transition:.3s;
}

.logout:hover{

background:#dc2626;
}

/* Main */

.container{

padding:40px 60px;
}

/* Header */

.header{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:30px;
}

.header h1{

font-size:42px;
}

.header p{

color:#94a3b8;

margin-top:5px;
}

/* Summary Cards */

.summary{

display:grid;

grid-template-columns:
repeat(3,1fr);

gap:20px;

margin-bottom:30px;
}

.card{

padding:25px;

border-radius:20px;

background:
rgba(255,255,255,.05);

border:
1px solid rgba(255,255,255,.08);

backdrop-filter:blur(20px);
}

.card h4{

color:#94a3b8;

margin-bottom:10px;
}

.card h2{

font-size:30px;
}

.deposit-card{

border-left:
5px solid #10b981;
}

.withdraw-card{

border-left:
5px solid #ef4444;
}

.transfer-card{

border-left:
5px solid #f59e0b;
}

/* Table */

.table-container{

background:
rgba(255,255,255,.05);

border:
1px solid rgba(255,255,255,.08);

backdrop-filter:blur(20px);

border-radius:25px;

padding:25px;

overflow-x:auto;
}

table{

width:100%;

border-collapse:collapse;
}

th{

padding:18px;

background:#2563eb;

font-weight:600;
}

td{

padding:16px;

text-align:center;

border-bottom:
1px solid rgba(255,255,255,.08);
}

tr:hover{

background:
rgba(255,255,255,.03);
}

/* Type Colors */

.deposit{

color:#10b981;

font-weight:600;
}

.withdraw{

color:#ef4444;

font-weight:600;
}

.transfer{

color:#f59e0b;

font-weight:600;
}

/* Empty */

.empty{

padding:40px;

text-align:center;

color:#94a3b8;

font-size:18px;
}

/* Actions */

.actions{

display:grid;

grid-template-columns:
repeat(4,1fr);

gap:20px;

margin-top:30px;
}

.actions a{

text-decoration:none;

color:white;

padding:18px;

text-align:center;

border-radius:15px;

background:
rgba(255,255,255,.05);

border:
1px solid rgba(255,255,255,.08);

transition:.3s;
}

.actions a:hover{

background:#2563eb;

transform:translateY(-4px);
}

/* Footer */

.footer{

margin-top:40px;

text-align:center;

color:#64748b;
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

SecurePAY

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

<td>
<%= t.getTransactionId() %>
</td>

<td>
<%= t.getSenderAccount() %>
</td>

<td>
<%= t.getReceiverAccount() %>
</td>

<td>

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

<td>

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

No Transactions Available

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

