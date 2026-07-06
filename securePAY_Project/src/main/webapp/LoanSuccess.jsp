<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if(session.getAttribute("user")==null){
    response.sendRedirect("Login.jsp");
    return;
}

String message=(String)session.getAttribute("loanSuccess");

if(message==null){
    message="Your loan application has been submitted successfully.";
}

session.removeAttribute("loanSuccess");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">

<title>Loan Application Submitted | SecurePAY</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
  --muted:#6B7280;
}

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Inter',sans-serif;
}

body{
background:
  radial-gradient(ellipse at top left, rgba(201,164,76,.10), transparent 55%),
  linear-gradient(160deg,var(--ink) 0%,var(--ink-2) 55%,#0d2044 100%);
display:flex;
justify-content:center;
align-items:center;
min-height:100vh;
padding:30px;
}

.card{
width:540px;
max-width:100%;
background:var(--paper);
color:var(--ledger-ink);
padding:44px 42px;
border-radius:22px;
box-shadow:0 25px 55px rgba(0,0,0,.35);
text-align:center;
animation:slide .7s ease;
border:1px solid rgba(201,164,76,.25);
}

@keyframes slide{
from{
opacity:0;
transform:translateY(40px);
}
to{
opacity:1;
transform:translateY(0);
}
}

.seal{
width:104px;
height:104px;
margin:auto;
border-radius:50%;
background:linear-gradient(155deg,#1a3663,#0e2145);
border:2px solid var(--gold);
display:flex;
justify-content:center;
align-items:center;
animation:pop .8s ease;
}

.seal i{
font-size:44px;
color:var(--gold-soft);
}

@keyframes pop{
0%{
transform:scale(0);
}
70%{
transform:scale(1.15);
}
100%{
transform:scale(1);
}
}

h1{
margin-top:24px;
font-family:'Fraunces',serif;
font-weight:600;
font-size:26px;
color:var(--ink);
}

.card > p{
margin-top:14px;
font-size:15px;
color:var(--muted);
line-height:1.7;
}

.status{
margin-top:28px;
background:#fff;
padding:16px 18px;
border-radius:12px;
border-left:4px solid var(--gold);
text-align:left;
display:flex;
justify-content:space-between;
align-items:center;
}

.status h3{
font-family:'Inter',sans-serif;
font-size:13px;
letter-spacing:.5px;
text-transform:uppercase;
color:var(--muted);
font-weight:600;
display:flex;
align-items:center;
gap:8px;
}

.status h3 i{color:var(--gold)}

.status-pill{
background:rgba(201,164,76,.15);color:#8a6a1f;
padding:5px 14px;border-radius:20px;font-size:12.5px;font-weight:700;
letter-spacing:.4px;
}

.info{
margin-top:22px;
text-align:left;
background:#fff;
border:1px dashed var(--paper-line);
padding:20px 22px;
border-radius:14px;
}

.info p{
margin:0;
padding:10px 0;
font-size:14px;
color:var(--ledger-ink);
border-bottom:1px solid var(--paper-line);
display:flex;
align-items:center;
gap:10px;
}
.info p:last-child{border-bottom:none}
.info p i{color:var(--credit);font-size:13px}

.buttons{
margin-top:30px;
display:flex;
gap:14px;
}

.btn{
flex:1;
padding:14px;
text-decoration:none;
border-radius:12px;
font-weight:600;
font-size:14.5px;
transition:.2s;
text-align:center;
display:flex;
align-items:center;
justify-content:center;
gap:8px;
}

.dashboard{
background:var(--ink);
color:#fff;
}

.dashboard:hover{
background:var(--ink-2);
}

.statusBtn{
background:transparent;
color:var(--ink);
border:1.5px solid var(--gold);
}

.statusBtn:hover{
background:rgba(201,164,76,.12);
}

.footer{
margin-top:24px;
font-size:12.5px;
color:var(--muted);
}

@media(max-width:600px){
.card{padding:32px 24px}
.buttons{flex-direction:column}
}

</style>

</head>

<body>

<div class="card">

<div class="seal">
<i class="fa-solid fa-check"></i>
</div>

<h1>Application Submitted</h1>

<p>
<%=message%>
</p>

<div class="status">
<h3>
<i class="fa-solid fa-clock"></i>
Current Status
</h3>
<span class="status-pill">Pending Approval</span>
</div>

<div class="info">

<p>
<i class="fa-solid fa-circle-check"></i>
Loan application received
</p>

<p>
<i class="fa-solid fa-circle-check"></i>
Verification in progress
</p>

<p>
<i class="fa-solid fa-circle-check"></i>
Admin will review your request
</p>

<p>
<i class="fa-solid fa-circle-check"></i>
You will receive a notification after approval/rejection
</p>

</div>

<div class="buttons">

<a href="Dashboard.jsp" class="btn dashboard">
<i class="fa-solid fa-house"></i>
Dashboard
</a>

<a href="LoanStatusServlet" class="btn statusBtn">
<i class="fa-solid fa-file-lines"></i>
Loan Status
</a>

</div>

<div class="footer">
Thank you for choosing <b>SecurePAY Bank</b>
</div>

</div>

</body>

</html>
