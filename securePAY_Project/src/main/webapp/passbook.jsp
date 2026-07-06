<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.securepay.model.Transaction"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SecurePAY Passbook</title>
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
*{margin:0;padding:0;box-sizing:border-box}
body{
  font-family:'Inter',sans-serif;
  background:
    radial-gradient(ellipse at top left, rgba(201,164,76,.10), transparent 55%),
    linear-gradient(160deg,var(--ink) 0%,var(--ink-2) 55%,#0d2044 100%);
  color:#fff;
  min-height:100vh;
}

/* ---------- Header : passbook cover ---------- */
.header{
  display:flex;justify-content:space-between;align-items:center;
  padding:20px 48px;
  border-bottom:1px solid rgba(201,164,76,.25);
  position:sticky;top:0;
  background:rgba(11,27,51,.75);
  backdrop-filter:blur(14px);
  z-index:10;
}
.logo{
  font-family:'Fraunces',serif;
  font-size:26px;font-weight:700;letter-spacing:.3px;
  display:flex;align-items:center;gap:10px;
}
.logo .mark{
  width:34px;height:34px;border-radius:50%;
  border:1.5px solid var(--gold);
  display:flex;align-items:center;justify-content:center;
  font-size:16px;color:var(--gold);
}
.user{font-size:14px;color:rgba(255,255,255,.75);font-family:'IBM Plex Mono',monospace}

.container{width:92%;max-width:1320px;margin:40px auto 70px}

/* ---------- Hero ---------- */
.hero{display:grid;grid-template-columns:1.5fr 1fr;gap:22px}

.cover-card{
  background:linear-gradient(155deg,#0e2145,#1a3663 60%,#0e2145);
  border:1px solid rgba(201,164,76,.35);
  border-radius:var(--radius);
  padding:34px 36px;
  position:relative;
  overflow:hidden;
  box-shadow:0 25px 50px rgba(0,0,0,.35);
}
.cover-card::before{
  content:"";
  position:absolute;inset:0;
  background:repeating-linear-gradient(115deg, rgba(255,255,255,.03) 0 2px, transparent 2px 26px);
  pointer-events:none;
}
.eyebrow{
  font-family:'IBM Plex Mono',monospace;
  font-size:12px;letter-spacing:2px;text-transform:uppercase;
  color:var(--gold-soft);
}
.balance-label{font-size:14px;color:rgba(255,255,255,.65);margin-top:16px}
.balance{
  font-family:'Fraunces',serif;
  font-size:46px;font-weight:600;
  margin-top:6px;
  font-variant-numeric:tabular-nums;
}
.acct-row{
  display:flex;gap:36px;margin-top:22px;
  font-family:'IBM Plex Mono',monospace;font-size:13px;color:rgba(255,255,255,.8);
}
.acct-row div span{display:block;color:rgba(255,255,255,.5);font-size:11px;letter-spacing:1px;text-transform:uppercase;margin-bottom:4px}

.stamp{
  position:absolute;top:28px;right:34px;
  border:2px solid var(--gold);
  color:var(--gold);
  padding:8px 16px;
  border-radius:8px;
  font-family:'IBM Plex Mono',monospace;
  font-weight:600;font-size:12px;letter-spacing:2px;
  transform:rotate(-8deg);
  opacity:.9;
}

.side-card{
  background:var(--paper);
  color:var(--ledger-ink);
  border-radius:var(--radius);
  padding:30px 32px;
  box-shadow:0 20px 40px rgba(0,0,0,.25);
  display:flex;flex-direction:column;justify-content:center;
}
.side-card h2{font-family:'Fraunces',serif;font-size:21px;margin-bottom:10px}
.side-card p{font-size:14px;line-height:1.7;color:#4b5563}

/* ---------- Stat strip ---------- */
.grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin:26px 0}
.stat{
  background:var(--paper);color:var(--ledger-ink);
  border-radius:14px;padding:20px 22px;
  border-left:3px solid var(--gold);
}
.stat h4{font-size:12px;letter-spacing:1px;text-transform:uppercase;color:var(--muted);font-weight:600}
.stat p{font-family:'IBM Plex Mono',monospace;font-size:24px;font-weight:600;margin-top:8px;font-variant-numeric:tabular-nums}

/* ---------- Ledger panel ---------- */
.panel{
  background:var(--paper);
  color:var(--ledger-ink);
  margin-top:28px;
  border-radius:var(--radius);
  box-shadow:0 20px 45px rgba(0,0,0,.3);
  overflow:hidden;
}
.stub{
  display:flex;gap:9px;
  padding:14px 32px 0;
}
.stub i{
  width:9px;height:9px;border-radius:50%;
  background:var(--ink-2);opacity:.15;
}
.panel-body{padding:10px 32px 28px}

.toolbar{
  display:flex;justify-content:space-between;flex-wrap:wrap;gap:14px;
  padding:16px 0 20px;
  border-bottom:1px dashed var(--paper-line);
  margin-bottom:6px;
}
.toolbar .left{display:flex;gap:10px;flex-wrap:wrap}
input,select{
  padding:11px 14px;border-radius:10px;
  border:1px solid #D8D2BC;background:#fff;
  font-family:'Inter',sans-serif;font-size:13.5px;
  min-width:200px;color:var(--ledger-ink);
}
input:focus,select:focus{outline:2px solid var(--gold-soft);outline-offset:1px}
button{
  padding:11px 18px;border:none;border-radius:10px;
  background:var(--ink);color:#fff;font-weight:600;font-size:13.5px;
  cursor:pointer;transition:.2s;
}
button:hover{background:var(--ink-2)}
button:focus-visible{outline:2px solid var(--gold);outline-offset:2px}

table{width:100%;border-collapse:collapse}
th{
  text-align:left;font-size:11px;letter-spacing:1.2px;text-transform:uppercase;
  color:var(--muted);font-weight:600;
  padding:12px 14px;border-bottom:2px solid var(--paper-line);
}
td{
  padding:15px 14px;
  border-bottom:1px solid var(--paper-line);
  font-family:'IBM Plex Mono',monospace;font-size:13.5px;
}
tbody tr{transition:background .15s}
tbody tr:hover{background:#EFEADA}
.credit{color:var(--credit);font-weight:600}
.debit{color:var(--debit);font-weight:600}
.status{
  background:rgba(30,123,77,.12);color:var(--credit);
  padding:5px 13px;border-radius:20px;
  font-size:11.5px;font-weight:700;letter-spacing:.4px;
  font-family:'Inter',sans-serif;
}
.empty{text-align:center;padding:50px 0;color:var(--muted);font-family:'Inter',sans-serif}

@media(max-width:900px){
  .hero,.grid{grid-template-columns:1fr}
  .header{padding:16px 20px}
  .container{width:94%}
  .panel-body{padding:8px 18px 22px}
  .stub{padding:12px 18px 0}
}
</style>
<script>
function searchTx(){
 let f=document.getElementById("search").value.toLowerCase();
 document.querySelectorAll("#txTable tbody tr").forEach(r=>{
  if(r.dataset.empty) return;
  r.style.display=r.innerText.toLowerCase().includes(f)?"":"none";
 });
}
function filterType(){
 let v=document.getElementById("typeFilter").value;
 document.querySelectorAll("#txTable tbody tr").forEach(r=>{
  if(r.dataset.empty) return;
  r.style.display=(v==="All"||r.dataset.type===v)?"":"none";
 });
}
</script>
</head>
<body>

<div class="header">
<div class="logo"><span class="mark">S</span>SecurePAY Passbook</div>
<div class="user">
Welcome, <%=session.getAttribute("name")==null?"Customer":session.getAttribute("nameS")%>
</div>
</div>

<div class="container">

<div class="hero">

<div class="cover-card">
<div class="stamp">ACTIVE</div>
<div class="eyebrow">Savings Account</div>
<div class="balance-label">Available balance</div>
<div class="balance">₹ <%=request.getAttribute("balance")==null?"0.00":request.getAttribute("balance")%></div>
<div class="acct-row">
<div><span>Account No.</span><%=request.getAttribute("accountNumber")%></div>
<div><span>IFSC</span>SECURE0001234</div>
</div>
</div>

<div class="side-card">
<h2>Digital Passbook</h2>
<p>Every entry, dated and stamped. Search, filter and print your statement, or export it as a keepsake PDF.</p>
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
<div class="stat"><h4>Total Credit</h4><p style="color:var(--credit)">₹ <%=String.format("%.2f",credit)%></p></div>
<div class="stat"><h4>Total Debit</h4><p style="color:var(--debit)">₹ <%=String.format("%.2f",debit)%></p></div>
<div class="stat"><h4>Total Transactions</h4><p><%=list==null?0:list.size()%></p></div>
<div class="stat"><h4>Available Balance</h4><p>₹ <%=request.getAttribute("balance")%></p></div>
</div>

<div class="panel">
<div class="stub">
<% for(int i=0;i<28;i++){ %><i></i><% } %>
</div>
<div class="panel-body">

<div class="toolbar">
<div class="left">
<input id="search" onkeyup="searchTx()" placeholder="Search transaction...">
<select id="typeFilter" onchange="filterType()">
<option value="All">All Transactions</option>
<option value="Credit">Credit</option>
<option value="Debit">Debit</option>
</select>
</div>

<div>
<button onclick="window.print()">Print statement</button>
<button onclick="alert('Connect OpenPDF/iText to download PDF.')">Download PDF</button>
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

<tr data-type="<%=t.getTransactionType()%>">
<td><%=t.getTransactionDate()%></td>
<td class="<%=c?"credit":"debit"%>"><%=t.getTransactionType()%></td>
<td>₹ <%=String.format("%.2f",t.getAmount())%></td>
<td><span class="status">Completed</span></td>
</tr>

<%
}
}else{
%>
<tr data-empty="true"><td colspan="4" class="empty">No transactions found.</td></tr>
<% } %>

</tbody>
</table>

</div>
</div>

</div>

</body>
</html>
