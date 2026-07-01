<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.securepay.model.Recharge"%>
<%
List<Recharge> rechargeList=(List<Recharge>)request.getAttribute("rechargeList");
double totalAmount=0;
int successCount=0;
if(rechargeList!=null){
    for(Recharge r:rechargeList){
        totalAmount+=r.getAmount();
        if(r.getStatus()!=null && r.getStatus().equalsIgnoreCase("SUCCESS")) successCount++;
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recharge History | SecurePAY</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',Arial,sans-serif}
body{
background:linear-gradient(135deg,#0f172a,#1e293b,#0f172a);
min-height:100vh;
padding:40px;
color:#fff;
}
.container{
max-width:1400px;
margin:auto;
background:rgba(30,41,59,.88);
backdrop-filter:blur(14px);
border:1px solid rgba(255,255,255,.08);
border-radius:22px;
padding:35px;
box-shadow:0 20px 45px rgba(0,0,0,.35);
}
.header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:25px;
flex-wrap:wrap;
}
.header h2{
font-size:34px;
background:linear-gradient(90deg,#60a5fa,#22d3ee);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
}
.header p{color:#cbd5e1}
.stats{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
gap:18px;
margin:25px 0;
}
.card{
padding:22px;
border-radius:18px;
background:linear-gradient(135deg,#2563eb,#1d4ed8);
transition:.3s;
}
.card:hover{transform:translateY(-6px)}
.card h4{font-size:15px;opacity:.9}
.card h1{margin-top:10px;font-size:32px}
.search{
margin:25px 0;
}
.search input{
width:100%;
padding:15px;
border:none;
border-radius:12px;
background:#0f172a;
color:#fff;
font-size:16px;
outline:none;
}
.table-wrap{
overflow-x:auto;
border-radius:16px;
}
table{
width:100%;
border-collapse:collapse;
background:#111827;
overflow:hidden;
}
th{
background:#2563eb;
padding:16px;
}
td{
padding:16px;
text-align:center;
border-bottom:1px solid rgba(255,255,255,.08);
}
tr:hover{background:#1f2937}
.amount{color:#22c55e;font-weight:bold}
.status{
display:inline-block;
padding:7px 15px;
border-radius:20px;
background:#22c55e;
font-weight:700;
}
.empty{
padding:60px;
text-align:center;
font-size:22px;
color:#cbd5e1;
border:2px dashed #334155;
border-radius:18px;
}
.back{
display:inline-block;
margin-top:30px;
padding:14px 24px;
background:linear-gradient(135deg,#2563eb,#1d4ed8);
color:#fff;
text-decoration:none;
border-radius:12px;
font-weight:600;
}
.back:hover{opacity:.9}
@media(max-width:768px){
body{padding:15px}
.header h2{font-size:28px}
}
</style>
</head>
<body>
<div class="container">
<div class="header">
<div>
<h2>Recharge History</h2>
<p>View all your successful recharge transactions.</p>
</div>
</div>

<div class="stats">
<div class="card"><h4>Total Recharges</h4><h1><%= rechargeList==null?0:rechargeList.size() %></h1></div>
<div class="card"><h4>Total Amount</h4><h1>₹ <%= String.format("%.2f",totalAmount) %></h1></div>
<div class="card"><h4>Successful</h4><h1><%= successCount %></h1></div>
</div>

<div class="search">
<input type="text" id="search" placeholder="Search by provider, service or number...">
</div>

<% if(rechargeList!=null && !rechargeList.isEmpty()){ %>
<div class="table-wrap">
<table id="historyTable">
<thead>
<tr>
<th>ID</th>
<th>Service</th>
<th>Provider</th>
<th>Customer Number</th>
<th>Amount</th>
<th>Status</th>
<th>Date</th>
</tr>
</thead>
<tbody>
<% for(Recharge recharge:rechargeList){ %>
<tr>
<td><%= recharge.getId() %></td>
<td><%= recharge.getServiceType() %></td>
<td><%= recharge.getProvider() %></td>
<td><%= recharge.getCustomerNumber() %></td>
<td class="amount">₹ <%= recharge.getAmount() %></td>
<td><span class="status"><%= recharge.getStatus() %></span></td>
<td><%= recharge.getRechargeDate() %></td>
</tr>
<% } %>
</tbody>
</table>
</div>
<% } else { %>
<div class="empty">
No Recharge History Found.
</div>
<% } %>

<a href="Dashboard.jsp" class="back">← Back to Dashboard</a>
</div>

<script>
document.getElementById("search").addEventListener("keyup",function(){
let filter=this.value.toLowerCase();
let rows=document.querySelectorAll("#historyTable tbody tr");
rows.forEach(function(row){
row.style.display=row.innerText.toLowerCase().includes(filter)?"":"none";
});
});
</script>
</body>
</html>
