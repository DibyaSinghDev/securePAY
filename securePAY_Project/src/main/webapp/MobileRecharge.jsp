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
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>SecurePAY - Mobile Recharge</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@500;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{
  --ink:#151831;
  --muted:#6b7280;
  --line:#e7e9f2;
  --surface:#ffffff;
  --bg:#f2f4fb;
  --p1:#6366f1;
  --p2:#8b5cf6;
}
*{margin:0;padding:0;box-sizing:border-box;font-family:'Inter',sans-serif}
body{
  background:
    radial-gradient(circle at 8% 8%, rgba(139,92,246,.16), transparent 40%),
    radial-gradient(circle at 95% 15%, rgba(99,102,241,.14), transparent 40%),
    radial-gradient(circle at 85% 90%, rgba(236,72,153,.08), transparent 40%),
    var(--bg);
  min-height:100vh;
  color:var(--ink);
  display:flex;justify-content:center;align-items:center;
  padding:40px 16px;
}
.container{
  width:100%;max-width:640px;
  background:var(--surface);
  border:1px solid var(--line);
  border-radius:24px;
  padding:34px;
  box-shadow:0 20px 45px rgba(30,30,60,.08);
  animation:fade .5s ease;
}
@keyframes fade{from{opacity:0;transform:translateY(18px)}to{opacity:1;transform:translateY(0)}}

.header{display:flex;align-items:center;gap:16px;margin-bottom:28px}
.icon{
  width:58px;height:58px;border-radius:16px;
  background:linear-gradient(135deg,var(--p1),var(--p2));
  color:#fff;
  display:flex;align-items:center;justify-content:center;
  font-size:24px;
  box-shadow:0 10px 24px rgba(99,102,241,.35);
}
.header h2{font-family:'Manrope',sans-serif;font-weight:800;font-size:24px}
.header p{color:var(--muted);margin-top:4px;font-size:14px}

.group{margin-bottom:20px}
label{display:block;font-weight:600;margin-bottom:8px;font-size:13px;color:var(--ink)}
input,select{
  width:100%;
  padding:14px 15px;
  border:1px solid var(--line);
  border-radius:12px;
  font-size:15px;
  background:#fbfbfe;
  transition:.2s;
  color:var(--ink);
}
input:focus,select:focus{
  outline:none;
  border-color:var(--p1);
  background:#fff;
  box-shadow:0 0 0 4px rgba(99,102,241,.12);
}

.plan-grid{
  display:grid;
  grid-template-columns:repeat(2,1fr);
  gap:12px;
  margin-top:10px;
}
.plan{
  padding:16px;
  border:1px solid var(--line);
  border-radius:14px;
  cursor:pointer;
  text-align:center;
  transition:.2s;
  background:#fbfbfe;
}
.plan .amt{font-family:'Manrope',sans-serif;font-weight:800;font-size:18px;color:var(--ink)}
.plan small{color:var(--muted);font-size:12px}
.plan:hover{transform:translateY(-3px);box-shadow:0 12px 24px rgba(30,30,60,.12);border-color:transparent}
.plan.active{
  background:linear-gradient(135deg,var(--p1),var(--p2));
  border-color:transparent;
  transform:translateY(-3px);
  box-shadow:0 12px 26px rgba(99,102,241,.35);
}
.plan.active .amt,.plan.active small{color:#fff}

.actions{
  display:flex;
  justify-content:space-between;
  align-items:center;
  margin-top:26px;
  gap:16px;
}
a.back-link{
  text-decoration:none;color:var(--muted);font-weight:600;font-size:14px;
  display:flex;align-items:center;gap:8px;
}
a.back-link:hover{color:var(--ink)}
button{
  padding:15px 28px;
  border:none;
  border-radius:12px;
  background:linear-gradient(135deg,var(--p1),var(--p2));
  color:#fff;
  font-weight:700;
  font-size:15px;
  cursor:pointer;
  transition:.2s;
  display:flex;align-items:center;gap:9px;
  box-shadow:0 12px 26px rgba(99,102,241,.3);
}
button:hover{transform:translateY(-2px);box-shadow:0 16px 32px rgba(99,102,241,.4)}

@media(max-width:700px){
  .container{padding:24px}
  .actions{flex-direction:column-reverse;align-items:stretch}
  button{justify-content:center;width:100%}
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
<div class="plan" onclick="choosePlan(199,this)"><span class="amt">₹199</span><br><small>28 Days</small></div>
<div class="plan" onclick="choosePlan(299,this)"><span class="amt">₹299</span><br><small>2GB/Day</small></div>
<div class="plan" onclick="choosePlan(399,this)"><span class="amt">₹399</span><br><small>Unlimited</small></div>
<div class="plan" onclick="choosePlan(749,this)"><span class="amt">₹749</span><br><small>90 Days</small></div>
</div>
</div>

<div class="group">
<label>Recharge Amount (₹)</label>
<input id="amount" type="number" name="amount" placeholder="Enter amount" required>
</div>

<div class="actions">
<a href="Recharge.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back</a>
<button type="submit"><i class="fa-solid fa-bolt"></i> Recharge Now</button>
</div>

</form>
</div>
</body>
</html>
