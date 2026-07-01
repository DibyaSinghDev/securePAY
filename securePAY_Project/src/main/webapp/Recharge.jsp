<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SecurePAY - Recharge & Bills</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:"Segoe UI",Arial,sans-serif}
body{
background:#f5f7fb;
display:flex;
justify-content:center;
align-items:center;
min-height:100vh;
color:#1f2937;
}
.container{
width:100%;
max-width:760px;
background:#fff;
border:1px solid #e5e7eb;
border-radius:18px;
padding:38px;
box-shadow:0 10px 30px rgba(0,0,0,.08);
animation:fade .5s ease;
}
@keyframes fade{
from{opacity:0;transform:translateY(20px)}
to{opacity:1;transform:translateY(0)}
}
.header{
display:flex;
align-items:center;
gap:16px;
margin-bottom:28px;
}
.icon{
width:60px;height:60px;border-radius:14px;
background:#eef4ff;
display:flex;align-items:center;justify-content:center;
font-size:28px;color:#2563eb;
}
.header h2{font-size:28px}
.header p{color:#6b7280;margin-top:4px}
.message,.error{
padding:12px 16px;border-radius:10px;margin-bottom:18px;font-weight:600
}
.message{background:#ecfdf5;color:#15803d}
.error{background:#fef2f2;color:#dc2626}
.grid{
display:grid;
grid-template-columns:1fr 1fr;
gap:18px;
}
.group{margin-bottom:18px}
.group.full{grid-column:1/-1}
label{
display:block;
font-size:14px;
font-weight:600;
margin-bottom:8px;
}
input,select{
width:100%;
padding:13px 14px;
border:1px solid #d1d5db;
border-radius:10px;
font-size:15px;
transition:.25s;
background:#fff;
}
input:focus,select:focus{
outline:none;
border-color:#2563eb;
box-shadow:0 0 0 4px rgba(37,99,235,.12);
}
button{
width:100%;
padding:15px;
border:none;
border-radius:10px;
background:#2563eb;
color:#fff;
font-size:16px;
font-weight:600;
cursor:pointer;
transition:.25s;
}
button:hover{
background:#1d4ed8;
transform:translateY(-2px);
}
.actions{
display:flex;
justify-content:space-between;
align-items:center;
margin-top:24px;
}
a{
text-decoration:none;
color:#2563eb;
font-weight:600;
}
@media(max-width:700px){
.grid{grid-template-columns:1fr}
.container{margin:18px;padding:24px}
.actions{flex-direction:column;gap:16px}
}
</style>
</head>
<body>

<div class="container">

<div class="header">
<div class="icon"><i class="fa-solid fa-bolt"></i></div>
<div>
<h2>Recharge & Bill Payment</h2>
<p>Recharge mobile, DTH and pay utility bills securely.</p>
</div>
</div>

<%
String success=(String)session.getAttribute("successMessage");
String error=(String)session.getAttribute("errorMessage");

if(success!=null){
%>
<div class="message"><%=success%></div>
<%
session.removeAttribute("successMessage");
}

if(error!=null){
%>
<div class="error"><%=error%></div>
<%
session.removeAttribute("errorMessage");
}
%>

<form action="RechargeServlet" method="post">

<div class="grid">

<div class="group">
<label>Service Type</label>
<select name="serviceType" required>
<option value="">Select Service</option>
<option value="Mobile Recharge">📱 Mobile Recharge</option>
<option value="Electricity Bill">⚡ Electricity Bill</option>
<option value="DTH Recharge">📺 DTH Recharge</option>
<option value="Gas Bill">🔥 Gas Bill</option>
<option value="Water Bill">🚰 Water Bill</option>
<option value="Broadband">🌐 Broadband</option>
</select>
</div>

<div class="group">
<label>Provider</label>
<select name="provider" required>
<option value="">Select Provider</option>
<option>Jio</option>
<option>Airtel</option>
<option>Vi</option>
<option>BSNL</option>
<option>BESCOM</option>
<option>Tata Play</option>
<option>Dish TV</option>
<option>Sun Direct</option>
</select>
</div>

<div class="group full">
<label>Mobile / Consumer Number</label>
<input type="text" name="customerNumber" placeholder="Enter mobile or consumer number" required>
</div>

<div class="group full">
<label>Amount (₹)</label>
<input type="number" name="amount" min="10" placeholder="Enter amount" required>
</div>

</div>

<div class="actions">
<a href="Dashboard.jsp"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
<button type="submit"><i class="fa-solid fa-circle-check"></i> Proceed Recharge</button>
</div>

</form>

</div>

</body>
</html>
