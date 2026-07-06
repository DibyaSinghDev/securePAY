<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>SecurePAY - Recharge & Bills</title>
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
}
*{margin:0;padding:0;box-sizing:border-box;font-family:'Inter',sans-serif}
body{
  background:
    radial-gradient(circle at 8% 8%, rgba(139,92,246,.16), transparent 40%),
    radial-gradient(circle at 95% 15%, rgba(14,165,233,.14), transparent 40%),
    radial-gradient(circle at 85% 90%, rgba(244,63,94,.10), transparent 40%),
    var(--bg);
  min-height:100vh;
  color:var(--ink);
  padding:40px 16px;
}
.page{max-width:760px;margin:0 auto}

/* ---------- Header ---------- */
.header{
  display:flex;align-items:center;gap:16px;margin-bottom:26px;
}
.icon{
  width:58px;height:58px;border-radius:16px;
  background:linear-gradient(135deg,#6366f1,#ec4899);
  display:flex;align-items:center;justify-content:center;
  font-size:24px;color:#fff;
  box-shadow:0 10px 24px rgba(99,102,241,.35);
}
.header h2{font-family:'Manrope',sans-serif;font-weight:800;font-size:26px}
.header p{color:var(--muted);margin-top:4px;font-size:14px}

/* ---------- Messages ---------- */
.message,.error{
  padding:13px 18px;border-radius:12px;margin-bottom:18px;font-weight:600;font-size:14px;
  display:flex;align-items:center;gap:10px;
}
.message{background:#ecfdf5;color:#15803d}
.error{background:#fef2f2;color:#dc2626}

/* ---------- Card ---------- */
.card{
  background:var(--surface);
  border:1px solid var(--line);
  border-radius:24px;
  padding:32px;
  box-shadow:0 20px 45px rgba(30,30,60,.08);
  animation:fade .5s ease;
}
@keyframes fade{from{opacity:0;transform:translateY(18px)}to{opacity:1;transform:translateY(0)}}

.section-label{
  font-family:'Manrope',sans-serif;font-weight:700;font-size:13px;
  letter-spacing:.4px;color:var(--ink);margin-bottom:14px;
}

/* ---------- Service tiles ---------- */
.tiles{
  display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin-bottom:30px;
}
.tile{
  border:1px solid var(--line);
  border-radius:16px;
  padding:16px 10px;
  text-align:center;
  cursor:pointer;
  transition:.2s;
  background:#fff;
}
.tile i{
  width:40px;height:40px;border-radius:12px;
  display:flex;align-items:center;justify-content:center;
  margin:0 auto 10px;color:#fff;font-size:16px;
}
.tile span{font-size:12.5px;font-weight:600;color:var(--ink);display:block}
.tile:hover{border-color:transparent;transform:translateY(-3px);box-shadow:0 12px 24px rgba(30,30,60,.12)}
.tile.active{border-color:transparent;box-shadow:0 12px 26px rgba(30,30,60,.18)}

.t-mobile i{background:linear-gradient(135deg,#6366f1,#8b5cf6)}
.t-electricity i{background:linear-gradient(135deg,#f59e0b,#f97316)}
.t-dth i{background:linear-gradient(135deg,#ec4899,#f43f5e)}
.t-gas i{background:linear-gradient(135deg,#fb923c,#ef4444)}
.t-water i{background:linear-gradient(135deg,#0ea5e9,#06b6d4)}
.t-broadband i{background:linear-gradient(135deg,#14b8a6,#22c55e)}

.tile.active.t-mobile{background:linear-gradient(135deg,#eef0ff,#f6eeff)}
.tile.active.t-electricity{background:linear-gradient(135deg,#fff7ec,#ffefe2)}
.tile.active.t-dth{background:linear-gradient(135deg,#fff0f6,#ffe9ee)}
.tile.active.t-gas{background:linear-gradient(135deg,#fff3ec,#ffe9e2)}
.tile.active.t-water{background:linear-gradient(135deg,#ecfaff,#e3f6fb)}
.tile.active.t-broadband{background:linear-gradient(135deg,#ecfdf7,#e6fbf0)}

/* ---------- Fields ---------- */
.field{margin-bottom:20px}
label{display:block;font-size:13px;font-weight:600;margin-bottom:8px;color:var(--ink)}
input,select{
  width:100%;padding:14px 15px;border:1px solid var(--line);border-radius:12px;
  font-size:15px;background:#fbfbfe;transition:.2s;color:var(--ink);
}
input:focus,select:focus{
  outline:none;border-color:#6366f1;background:#fff;
  box-shadow:0 0 0 4px rgba(99,102,241,.12);
}

/* ---------- Quick amount chips ---------- */
.chips{display:flex;gap:8px;flex-wrap:wrap;margin-top:10px}
.chip{
  padding:8px 16px;border-radius:20px;border:1px solid var(--line);
  background:#fbfbfe;font-size:13px;font-weight:600;cursor:pointer;transition:.15s;color:var(--ink);
}
.chip:hover,.chip.active{background:#6366f1;border-color:#6366f1;color:#fff}

/* ---------- Actions ---------- */
.actions{
  display:flex;justify-content:space-between;align-items:center;margin-top:28px;gap:16px;
}
.back-link{
  text-decoration:none;color:var(--muted);font-weight:600;font-size:14px;
  display:flex;align-items:center;gap:8px;
}
.back-link:hover{color:var(--ink)}
button{
  flex-shrink:0;padding:15px 26px;border:none;border-radius:12px;
  background:linear-gradient(135deg,#6366f1,#8b5cf6);color:#fff;
  font-size:15px;font-weight:700;cursor:pointer;transition:.2s;
  display:flex;align-items:center;gap:9px;
  box-shadow:0 12px 26px rgba(99,102,241,.3);
}
button:hover{transform:translateY(-2px);box-shadow:0 16px 32px rgba(99,102,241,.4)}

@media(max-width:700px){
  .tiles{grid-template-columns:repeat(3,1fr)}
  .card{padding:22px}
  .actions{flex-direction:column-reverse;align-items:stretch}
  button{justify-content:center}
}
</style>
</head>
<body>

<div class="page">

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
<div class="message"><i class="fa-solid fa-circle-check"></i><%=success%></div>
<%
session.removeAttribute("successMessage");
}

if(error!=null){
%>
<div class="error"><i class="fa-solid fa-circle-exclamation"></i><%=error%></div>
<%
session.removeAttribute("errorMessage");
}
%>

<div class="card">

<form action="RechargeServlet" method="post" id="rechargeForm">

<input type="hidden" name="serviceType" id="serviceType" required>

<div class="section-label">Choose a service</div>
<div class="tiles">
<div class="tile t-mobile" data-value="Mobile Recharge" onclick="selectTile(this)">
<i class="fa-solid fa-mobile-screen-button"></i><span>Mobile</span>
</div>
<div class="tile t-electricity" data-value="Electricity Bill" onclick="selectTile(this)">
<i class="fa-solid fa-bolt"></i><span>Electricity</span>
</div>
<div class="tile t-dth" data-value="DTH Recharge" onclick="selectTile(this)">
<i class="fa-solid fa-tv"></i><span>DTH</span>
</div>
<div class="tile t-gas" data-value="Gas Bill" onclick="selectTile(this)">
<i class="fa-solid fa-fire"></i><span>Gas</span>
</div>
<div class="tile t-water" data-value="Water Bill" onclick="selectTile(this)">
<i class="fa-solid fa-faucet-drip"></i><span>Water</span>
</div>
<div class="tile t-broadband" data-value="Broadband" onclick="selectTile(this)">
<i class="fa-solid fa-wifi"></i><span>Broadband</span>
</div>
</div>

<div class="field">
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

<div class="field">
<label>Mobile / Consumer Number</label>
<input type="text" name="customerNumber" placeholder="Enter mobile or consumer number" required>
</div>

<div class="field">
<label>Amount (₹)</label>
<input type="number" name="amount" id="amount" min="10" placeholder="Enter amount" required>
<div class="chips">
<div class="chip" onclick="setAmount(100,this)">₹100</div>
<div class="chip" onclick="setAmount(200,this)">₹200</div>
<div class="chip" onclick="setAmount(500,this)">₹500</div>
<div class="chip" onclick="setAmount(1000,this)">₹1000</div>
</div>
</div>

<div class="actions">
<a href="Dashboard.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
<button type="submit"><i class="fa-solid fa-circle-check"></i> Proceed Recharge</button>
</div>

</form>

</div>

</div>

<script>
function selectTile(el){
 document.querySelectorAll('.tile').forEach(t=>t.classList.remove('active'));
 el.classList.add('active');
 document.getElementById('serviceType').value=el.dataset.value;
}
function setAmount(v,el){
 document.getElementById('amount').value=v;
 document.querySelectorAll('.chip').forEach(c=>c.classList.remove('active'));
 el.classList.add('active');
}
document.getElementById('rechargeForm').addEventListener('submit',function(e){
 if(!document.getElementById('serviceType').value){
   e.preventDefault();
   alert('Please choose a service type.');
 }
});
</script>

</body>
</html>
