<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String transactionId = (String) session.getAttribute("transactionId");
String successMessage = (String) session.getAttribute("successMessage");

if(transactionId == null){
    response.sendRedirect("Recharge.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Recharge Successful | SecurePAY</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">

<style>

:root{
  --ink:#101828;
  --muted:#667085;
  --line:#e4e7ec;
  --surface:#ffffff;
  --success:#079455;
  --success-bg:#ecfdf3;
  --accent:#1d3557;
}

*{
margin:0;padding:0;box-sizing:border-box;
font-family:'Inter',sans-serif;
}

body{
background:linear-gradient(160deg,#0d1b2a,#1b2f42 60%,#0d1b2a);
min-height:100vh;
display:flex;
justify-content:center;
align-items:center;
padding:40px 16px;
}

.receipt{
width:100%;
max-width:460px;
background:var(--surface);
border-radius:16px;
box-shadow:0 30px 60px rgba(0,0,0,.35);
overflow:hidden;
}

.receipt-head{
padding:36px 40px 28px;
text-align:center;
border-bottom:1px solid var(--line);
}

.check{
width:64px;height:64px;
margin:0 auto 18px;
border-radius:50%;
background:var(--success-bg);
border:1.5px solid rgba(7,148,85,.25);
display:flex;justify-content:center;align-items:center;
}
.check svg{width:28px;height:28px}

.receipt-head h1{
font-size:20px;
font-weight:700;
color:var(--ink);
}

.receipt-head p{
margin-top:8px;
font-size:14px;
color:var(--muted);
line-height:1.6;
}

.status-badge{
display:inline-flex;align-items:center;gap:6px;
margin-top:16px;
padding:5px 14px;
border-radius:20px;
background:var(--success-bg);
color:var(--success);
font-size:12.5px;
font-weight:600;
letter-spacing:.3px;
}
.status-badge .dot{width:6px;height:6px;border-radius:50%;background:var(--success)}

.details{
padding:28px 40px;
}

.details .row{
display:flex;
justify-content:space-between;
align-items:flex-start;
gap:16px;
padding:13px 0;
border-bottom:1px dashed var(--line);
}
.details .row:last-child{border-bottom:none}

.details .label{
font-size:13px;
color:var(--muted);
font-weight:500;
white-space:nowrap;
}

.details .value{
font-family:'IBM Plex Mono',monospace;
font-size:13.5px;
color:var(--ink);
font-weight:600;
text-align:right;
word-break:break-all;
}

.value.success-text{color:var(--success)}

.footer-note{
padding:20px 40px 0;
text-align:center;
font-size:12px;
color:var(--muted);
}

.actions{
padding:28px 40px 36px;
display:flex;
gap:12px;
}

.btn{
flex:1;
text-align:center;
padding:13px;
border-radius:10px;
font-size:14px;
font-weight:600;
text-decoration:none;
cursor:pointer;
transition:.2s;
border:none;
}

.btn-primary{
background:var(--accent);
color:#fff;
}
.btn-primary:hover{background:#142943}

.btn-secondary{
background:#fff;
color:var(--ink);
border:1px solid var(--line);
}
.btn-secondary:hover{background:#f9fafb}

@media(max-width:500px){
.receipt-head,.details,.footer-note,.actions{padding-left:24px;padding-right:24px}
.actions{flex-direction:column}
}

@media print{
body{background:#fff;padding:0}
.actions{display:none}
.receipt{box-shadow:none;max-width:100%}
}

</style>
</head>

<body>

<div class="receipt">

<div class="receipt-head">
<div class="check">
<svg viewBox="0 0 24 24" fill="none" stroke="#079455" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
</div>
<h1>Recharge Successful</h1>
<p><%=successMessage%></p>
<div class="status-badge"><span class="dot"></span>SUCCESS</div>
</div>

<div class="details">
<div class="row">
<span class="label">Transaction ID</span>
<span class="value"><%=transactionId%></span>
</div>
<div class="row">
<span class="label">Status</span>
<span class="value success-text">SUCCESS</span>
</div>
<div class="row">
<span class="label">Date & Time</span>
<span class="value"><%=new java.util.Date()%></span>
</div>
</div>

<div class="footer-note">
This is a system-generated receipt and does not require a signature.
</div>

<div class="actions">
<button type="button" class="btn btn-secondary" onclick="window.print()">Print Receipt</button>
<a href="Dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
</div>

</div>

</body>
</html>
