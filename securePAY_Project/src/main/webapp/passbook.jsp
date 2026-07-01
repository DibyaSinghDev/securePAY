<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.securepay.model.Transaction"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SecurePAY Premium Passbook</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',sans-serif}
body{
background:linear-gradient(135deg,#081b4b,#0f3ea8,#2b6fff);
min-height:100vh;
color:#fff;
}
.header{
display:flex;justify-content:space-between;align-items:center;
padding:22px 50px;
background:rgba(255,255,255,.08);
backdrop-filter:blur(16px);
position:sticky;top:0;
}
.logo{font-size:32px;font-weight:700;letter-spacing:1px}
.user{font-size:18px}
.container{width:92%;max-width:1400px;margin:35px auto}
.hero{
display:grid;
grid-template-columns:2fr 1fr;
gap:25px;
}
.card{
background:rgba(255,255,255,.12);
backdrop-filter:blur(18px);
border:1px solid rgba(255,255,255,.18);
border-radius:24px;
padding:30px;
box-shadow:0 20px 45px rgba(0,0,0,.25);
}
.balance{font-size:42px;font-weight:700;margin:15px 0}
.badge{display:inline-block;background:#22c55e;padding:7px 16px;border-radius:50px;font-weight:600}
.grid{
display:grid;
grid-template-columns:repeat(4,1fr);
gap:18px;
margin:28px 0;
}
.stat{
background:#fff;color:#111827;border-radius:18px;padding:22px;
box-shadow:0 10px 20px rgba(0,0,0,.15)
}
.stat h4{color:#64748b;font-size:14px}
.stat p{font-size:28px;font-weight:700;margin-top:8px}
.panel{
background:#fff;
color:#111827;
margin-top:30px;
border-radius:24px;
padding:25px;
box-shadow:0 15px 35px rgba(0,0,0,.2);
}
.toolbar{
display:flex;
justify-content:space-between;
flex-wrap:wrap;
gap:15px;
margin-bottom:20px;
}
input,select{
padding:12px 15px;
border-radius:12px;
border:1px solid #d1d5db;
min-width:220px;
}
button{
padding:12px 20px;
border:none;
border-radius:12px;
background:#2563eb;
color:#fff;
font-weight:600;
cursor:pointer;
transition:.3s;
}
button:hover{transform:translateY(-2px);background:#1d4ed8}
table{width:100%;border-collapse:collapse}
th{
background:#1d4ed8;
color:#fff;
padding:16px;
}
td{
padding:15px;
border-bottom:1px solid #e5e7eb;
}
tbody tr:hover{
background:#eff6ff;
transform:scale(1.005);
transition:.25s;
}
.credit{color:#16a34a;font-weight:700}
.debit{color:#dc2626;font-weight:700}
.status{
background:#dcfce7;
color:#15803d;
padding:6px 14px;
border-radius:30px;
font-size:13px;
font-weight:700;
}
@media(max-width:900px){
.hero,.grid{grid-template-columns:1fr}
.header{padding:18px 20px}
}
</style>
<script>
function searchTx(){
 let f=document.getElementById("search").value.toLowerCase();
 document.querySelectorAll("#txTable tbody tr").forEach(r=>{
  r.style.display=r.innerText.toLowerCase().includes(f)?"":"none";
 });
}
</script>
</head>
<body>

<div class="header">
<div class="logo">🏦 SecurePAY Passbook</div>
<div class="user">
Welcome,
<%=session.getAttribute("name")==null?"Customer":session.getAttribute("nameS")%>
</div>
</div>

<div class="container">

<div class="hero">

<div class="card">
<h2>Savings Account</h2>
<div class="balance">
₹ <%=request.getAttribute("balance")==null?"0.00":request.getAttribute("balance")%>
</div>
<p><b>Account:</b> <%=request.getAttribute("accountNumber")%></p>
<p><b>IFSC:</b> SECURE0001234</p>
<br>
<span class="badge">ACTIVE ACCOUNT</span>
</div>

<div class="card">
<h2>Digital Passbook</h2>
<p style="margin-top:18px;line-height:1.8">
Securely view all your transactions, print your passbook and download statements.
</p>
</div>

</div>

<%
List<Transaction> list=(List<Transaction>)request.getAttribute("transaction");
double credit=0,debit=0;
if(list!=null){
for(Transaction t:list){
if(t.getTransactionType().equalsIgnoreCase("Credit"))
credit+=t.getAmount();
else
debit+=t.getAmount();
}
}
%>

<div class="grid">
<div class="stat"><h4>Total Credit</h4><p style="color:#16a34a">₹ <%=String.format("%.2f",credit)%></p></div>
<div class="stat"><h4>Total Debit</h4><p style="color:#dc2626">₹ <%=String.format("%.2f",debit)%></p></div>
<div class="stat"><h4>Total Transactions</h4><p><%=list==null?0:list.size()%></p></div>
<div class="stat"><h4>Available Balance</h4><p>₹ <%=request.getAttribute("balance")%></p></div>
</div>

<div class="panel">

<div class="toolbar">
<div>
<input id="search" onkeyup="searchTx()" placeholder="Search transaction...">
<select>
<option>All Transactions</option>
<option>Credit</option>
<option>Debit</option>
</select>
</div>

<div>
<button onclick="window.print()">🖨 Print</button>
<button onclick="alert('Connect OpenPDF/iText to download PDF.')">📄 PDF</button>
</div>
</div>

<table id="txTable">
<thead>
<tr>
<th>Date</th>
<th>Type</th>
<th>Amount</th>
<th>Status</th>
</tr>
</thead>
<tbody>

<%
if(list!=null){
for(Transaction t:list){
boolean c=t.getTransactionType().equalsIgnoreCase("Credit");
%>

<tr>
<td><%=t.getTransactionDate()%></td>
<td class="<%=c?"credit":"debit"%>"><%=t.getTransactionType()%></td>
<td>₹ <%=String.format("%.2f",t.getAmount())%></td>
<td><span class="status">Completed</span></td>
</tr>

<%
}
}else{
%>
<tr><td colspan="4" style="text-align:center;padding:40px">No transactions found.</td></tr>
<% } %>

</tbody>
</table>

</div>

</div>

</body>
</html>
