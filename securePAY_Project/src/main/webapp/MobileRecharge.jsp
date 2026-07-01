<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("user")==null){
    response.sendRedirect("Login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SecurePAY - Mobile Recharge</title>
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
padding:36px;
box-shadow:0 10px 30px rgba(0,0,0,.08);
animation:fade .5s ease;
}
@keyframes fade{
from{opacity:0;transform:translateY(18px)}
to{opacity:1;transform:translateY(0)}
}
.header{display:flex;align-items:center;gap:16px;margin-bottom:28px}
.icon{
width:60px;height:60px;border-radius:14px;
background:#eef4ff;color:#2563eb;
display:flex;align-items:center;justify-content:center;
font-size:28px;
}
.header h2{font-size:28px}
.header p{color:#6b7280;margin-top:4px}
.group{margin-bottom:18px}
label{display:block;font-weight:600;margin-bottom:8px;font-size:14px}
input,select{
width:100%;
padding:13px;
border:1px solid #d1d5db;
border-radius:10px;
font-size:15px;
transition:.25s;
}
input:focus,select:focus{
outline:none;
border-color:#2563eb;
box-shadow:0 0 0 4px rgba(37,99,235,.12);
}
.plan-grid{
display:grid;
grid-template-columns:repeat(2,1fr);
gap:12px;
margin-top:10px;
}
.plan{
padding:16px;
border:1px solid #dbe4ff;
border-radius:12px;
cursor:pointer;
text-align:center;
transition:.25s;
background:#fafcff;
}
.plan:hover,.plan.active{
background:#2563eb;
color:#fff;
transform:translateY(-2px);
}
.actions{
display:flex;
justify-content:space-between;
align-items:center;
margin-top:25px;
}
button{
padding:14px 28px;
border:none;
border-radius:10px;
background:#2563eb;
color:#fff;
font-weight:600;
font-size:16px;
cursor:pointer;
transition:.25s;
}
button:hover{background:#1d4ed8}
a{text-decoration:none;color:#2563eb;font-weight:600}
@media(max-width:700px){
.container{margin:18px;padding:24px}
.plan-grid{grid-template-columns:1fr}
.actions{flex-direction:column;gap:15px}
button{width:100%}
}
</style>
<script>
function choosePlan(amount,el){
 document.getElementById("amount").value=amount;
 document.querySelectorAll(".plan").forEach(p=>p.classList.remove("active"));
 el.classList.add("active");
}
</script>
</head>
<body>
<div class="container">
<div class="header">
<div class="icon"><i class="fa-solid fa-mobile-screen-button"></i></div>
<div>
<h2>Mobile Recharge</h2>
<p>Recharge your prepaid or postpaid mobile number.</p>
</div>
</div>

<form action="RechargeServlet" method="post">
<input type="hidden" name="serviceType" value="Mobile Recharge">

<div class="group">
<label>Mobile Number</label>
<input type="text" name="customerNumber" maxlength="10" placeholder="Enter mobile number" required>
</div>

<div class="group">
<label>Operator</label>
<select name="provider" required>
<option value="">Select Operator</option>
<option>Jio</option>
<option>Airtel</option>
<option>Vi</option>
<option>BSNL</option>
</select>
</div>

<div class="group">
<label>Popular Recharge Plans</label>
<div class="plan-grid">
<div class="plan" onclick="choosePlan(199,this)">₹199<br><small>28 Days</small></div>
<div class="plan" onclick="choosePlan(299,this)">₹299<br><small>2GB/Day</small></div>
<div class="plan" onclick="choosePlan(399,this)">₹399<br><small>Unlimited</small></div>
<div class="plan" onclick="choosePlan(749,this)">₹749<br><small>90 Days</small></div>
</div>
</div>

<div class="group">
<label>Recharge Amount (₹)</label>
<input id="amount" type="number" name="amount" placeholder="Enter amount" required>
</div>

<div class="actions">
<a href="Recharge.jsp"><i class="fa-solid fa-arrow-left"></i> Back</a>
<button type="submit"><i class="fa-solid fa-bolt"></i> Recharge Now</button>
</div>

</form>
</div>
</body>
</html>
