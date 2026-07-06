<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="com.securepay.model.Loan"%>

<%
List<Loan> loanList =
(List<Loan>)request.getAttribute("loanList");

if(loanList==null){
    loanList = new ArrayList<>();
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">

<title>My Loans | SecurePAY</title>

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
  --debit:#B23A2E;
  --muted:#6B7280;
  --radius:18px;
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
color:#fff;
min-height:100vh;
}

.container{
width:92%;
max-width:1100px;
margin:44px auto 70px;
}

.header{
display:flex;
justify-content:space-between;
align-items:center;
flex-wrap:wrap;
gap:14px;
margin-bottom:26px;
}

.header h2{
font-family:'Fraunces',serif;
font-weight:600;
font-size:28px;
display:flex;
align-items:center;
gap:12px;
}

.header h2 i{
width:46px;height:46px;border-radius:12px;
background:linear-gradient(155deg,#1a3663,#0e2145);
border:1px solid rgba(201,164,76,.35);
color:var(--gold);
display:flex;align-items:center;justify-content:center;font-size:18px;
}

.back{
text-decoration:none;
font-weight:600;
font-size:13.5px;
color:var(--gold-soft);
padding:10px 18px;
border:1px solid rgba(201,164,76,.35);
border-radius:10px;
transition:.2s;
}
.back:hover{background:rgba(201,164,76,.12);color:var(--gold)}

/* ---------- Toolbar ---------- */
.toolbar{
display:flex;justify-content:space-between;flex-wrap:wrap;gap:14px;
margin-bottom:20px;
}
.toolbar input,.toolbar select{
padding:11px 14px;border-radius:10px;
border:1px solid rgba(255,255,255,.15);
background:rgba(255,255,255,.06);
color:#fff;font-size:13.5px;min-width:200px;
font-family:'Inter',sans-serif;
}
.toolbar input::placeholder{color:rgba(255,255,255,.45)}
.toolbar input:focus,.toolbar select:focus{outline:2px solid var(--gold-soft);outline-offset:1px}
.toolbar select option{color:#111}

/* ---------- Loan entries (ledger style) ---------- */
.loan-card{
background:var(--paper);
color:var(--ledger-ink);
padding:26px 28px;
border-radius:var(--radius);
margin-bottom:18px;
box-shadow:0 18px 40px rgba(0,0,0,.25);
position:relative;
display:grid;
grid-template-columns:56px 1fr;
gap:20px;
}

.entry-no{
font-family:'IBM Plex Mono',monospace;
font-size:12px;color:var(--muted);
display:flex;flex-direction:column;align-items:center;
padding-top:2px;
}
.entry-no span{
font-size:10px;letter-spacing:1px;text-transform:uppercase;margin-bottom:4px;
}
.entry-no b{
font-family:'Fraunces',serif;font-size:22px;color:var(--ink);font-weight:600;
}

.entry-body .top-row{
display:flex;justify-content:space-between;align-items:flex-start;flex-wrap:wrap;gap:10px;
margin-bottom:16px;padding-bottom:14px;
border-bottom:1px dashed var(--paper-line);
}
.entry-body .top-row h3{
font-family:'Fraunces',serif;font-size:19px;font-weight:600;color:var(--ink);
}
.entry-body .top-row .applied{
font-family:'IBM Plex Mono',monospace;font-size:12.5px;color:var(--muted);
}

.stamp{
border:2px solid;
padding:6px 15px;
border-radius:8px;
font-family:'IBM Plex Mono',monospace;
font-weight:700;font-size:11.5px;letter-spacing:1.5px;text-transform:uppercase;
transform:rotate(-4deg);
white-space:nowrap;
}
.pending{border-color:var(--gold);color:#8a6a1f;background:rgba(201,164,76,.1)}
.approved{border-color:var(--credit);color:var(--credit);background:rgba(30,123,77,.08)}
.rejected{border-color:var(--debit);color:var(--debit);background:rgba(178,58,46,.08)}

.details{
display:grid;
grid-template-columns:repeat(4,1fr);
gap:16px;
}
.details .d h4{
font-size:11px;letter-spacing:1px;text-transform:uppercase;color:var(--muted);font-weight:600;
}
.details .d p{
font-family:'IBM Plex Mono',monospace;font-size:15px;font-weight:600;margin-top:6px;color:var(--ledger-ink);
}

.remark{
margin-top:16px;padding:12px 14px;
background:#fff;border:1px dashed var(--paper-line);border-radius:10px;
font-size:13px;color:var(--muted);
}
.remark b{color:var(--ledger-ink)}

/* ---------- Empty state ---------- */
.empty{
background:var(--paper);color:var(--ledger-ink);
padding:70px 40px;
text-align:center;
border-radius:var(--radius);
box-shadow:0 20px 45px rgba(0,0,0,.3);
}
.empty i{
font-size:56px;color:var(--gold);margin-bottom:18px;
}
.empty h2{font-family:'Fraunces',serif;font-size:22px;margin-bottom:8px;color:var(--ink)}
.empty p{color:var(--muted);font-size:14px}

@media(max-width:800px){
.container{width:94%}
.loan-card{grid-template-columns:1fr;padding:22px 20px}
.entry-no{flex-direction:row;gap:8px}
.entry-no span{margin-bottom:0}
.details{grid-template-columns:1fr 1fr}
}

</style>

<script>
function searchLoans(){
 let f=document.getElementById("search").value.toLowerCase();
 document.querySelectorAll(".loan-card").forEach(c=>{
  c.style.display=c.innerText.toLowerCase().includes(f)?"":"none";
 });
}
function filterStatus(){
 let v=document.getElementById("statusFilter").value;
 document.querySelectorAll(".loan-card").forEach(c=>{
  c.style.display=(v==="All"||c.dataset.status===v)?"":"none";
 });
}
</script>

</head>

<body>

<div class="container">

<div class="header">
<h2><i class="fa-solid fa-building-columns"></i>My Loan Applications</h2>
<a href="Dashboard.jsp" class="back">← Dashboard</a>
</div>

<%
if(!loanList.isEmpty()){
%>
<div class="toolbar">
<input id="search" onkeyup="searchLoans()" placeholder="Search loan type, date...">
<select id="statusFilter" onchange="filterStatus()">
<option value="All">All Statuses</option>
<option value="pending">Pending</option>
<option value="approved">Approved</option>
<option value="rejected">Rejected</option>
</select>
</div>
<%
}

if(loanList.isEmpty()){

%>

<div class="empty">
<i class="fa-solid fa-file-circle-xmark"></i>
<h2>No Loan Applications</h2>
<p>You haven't applied for any loan yet.</p>
</div>

<%

}else{

int index=1;
for(Loan loan : loanList){

String status = loan.getStatus();
String css = "pending";

if(status.equalsIgnoreCase("Approved")){
css = "approved";
}
if(status.equalsIgnoreCase("Rejected")){
css = "rejected";
}
%>

<div class="loan-card" data-status="<%=css%>">

<div class="entry-no">
<span>Entry</span>
<b><%=String.format("%02d",index)%></b>
</div>

<div class="entry-body">

<div class="top-row">
<div>
<h3><%=loan.getLoanType()%></h3>
<div class="applied">Applied <%=loan.getAppliedDate()%></div>
</div>
<span class="stamp <%=css%>"><%=loan.getStatus()%></span>
</div>

<div class="details">
<div class="d">
<h4>Loan Amount</h4>
<p>₹ <%=loan.getLoanAmount()%></p>
</div>
<div class="d">
<h4>Duration</h4>
<p><%=loan.getDuration()%> Months</p>
</div>
<div class="d">
<h4>Monthly Income</h4>
<p>₹ <%=loan.getMonthlyIncome()%></p>
</div>
<div class="d">
<h4>Status</h4>
<p><%=loan.getStatus()%></p>
</div>
</div>

<div class="remark">
<b>Admin Remark:</b> <%=loan.getAdminRemark()==null?"Waiting for Review":loan.getAdminRemark()%>
</div>

</div>
</div>

<%
index++;
}
}
%>

</div>

</body>

</html>
