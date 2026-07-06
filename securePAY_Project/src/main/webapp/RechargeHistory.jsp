<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.securepay.model.Recharge"%>
<%!
private String esc(Object val){
    if(val==null) return "";
    String s=String.valueOf(val);
    StringBuilder sb=new StringBuilder(s.length());
    for(int i=0;i<s.length();i++){
        char c=s.charAt(i);
        switch(c){
            case '&': sb.append("&amp;"); break;
            case '<': sb.append("&lt;"); break;
            case '>': sb.append("&gt;"); break;
            case '"': sb.append("&quot;"); break;
            case '\'': sb.append("&#39;"); break;
            default: sb.append(c);
        }
    }
    return sb.toString();
}
private String money(double amt){
    return String.format("%,.2f", amt);
}
private String id4(long id){
    return String.format("%04d", id);
}
%>
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Recharge History | SecurePAY</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Special+Elite&family=IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{
--counter:#14181c;
--counter-2:#191e24;
--paper:#f1ecde;
--paper-2:#e9e3d1;
--ink:#26241e;
--ink-faded:#77715f;
--rule:#c9c2ac;
--stamp-green:#2f6e4e;
--stamp-red:#a73b2e;
--stamp-amber:#8a5a12;
--radius:2px;
}
*{margin:0;padding:0;box-sizing:border-box}
body{
font-family:'IBM Plex Sans',Arial,sans-serif;
background:var(--counter);
background-image:radial-gradient(ellipse at 50% -10%, var(--counter-2), var(--counter) 65%);
min-height:100vh;
padding:56px 20px 80px;
color:var(--ink);
}
.wordmark{
text-align:center;
margin-bottom:26px;
}
.wordmark .brand{
font-family:'Special Elite',monospace;
font-size:26px;
letter-spacing:3px;
color:#d9d4c4;
}
.wordmark .sub{
font-family:'IBM Plex Mono',monospace;
font-size:11px;
letter-spacing:4px;
color:#5c6570;
margin-top:6px;
text-transform:uppercase;
}
.receipt-frame{
max-width:560px;
margin:0 auto;
filter:drop-shadow(0 24px 40px rgba(0,0,0,.5));
}
.tear{
height:14px;
background-image:
linear-gradient(-45deg,var(--paper) 8px,transparent 0),
linear-gradient(45deg,var(--paper) 8px,transparent 0);
background-size:16px 16px;
background-position:left top;
background-repeat:repeat-x;
}
.tear.bottom{transform:scaleY(-1)}
.receipt{
background:var(--paper);
padding:34px 36px 30px;
}
.masthead{
text-align:center;
padding-bottom:18px;
}
.masthead .name{
font-family:'Special Elite',monospace;
font-size:30px;
letter-spacing:2px;
}
.masthead .tag{
font-size:13px;
color:var(--ink-faded);
margin-top:6px;
}
.masthead .meta{
font-family:'IBM Plex Mono',monospace;
font-size:11px;
color:var(--ink-faded);
margin-top:10px;
letter-spacing:1px;
text-transform:uppercase;
}
.rule{
border:none;
border-top:1.5px dashed var(--rule);
margin:18px 0;
}
.summary-line{
display:flex;
align-items:baseline;
font-family:'IBM Plex Mono',monospace;
font-size:13px;
letter-spacing:.5px;
padding:4px 0;
}
.summary-line .label{
text-transform:uppercase;
color:var(--ink-faded);
white-space:nowrap;
}
.summary-line .leader{
flex:1;
border-bottom:1px dotted var(--rule);
margin:0 8px 3px;
}
.summary-line .value{
font-weight:600;
white-space:nowrap;
}
.search-row input{
width:100%;
padding:12px 14px;
border:1.5px solid var(--ink);
background:#fbf9f2;
color:var(--ink);
font-family:'IBM Plex Mono',monospace;
font-size:12px;
letter-spacing:1px;
text-transform:uppercase;
outline:none;
border-radius:var(--radius);
}
.search-row input::placeholder{color:#a49d87}
.search-row input:focus{
box-shadow:0 0 0 3px rgba(38,36,30,.15);
}
.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse}
thead th{
font-family:'IBM Plex Mono',monospace;
font-size:10px;
letter-spacing:1.5px;
text-transform:uppercase;
color:var(--ink-faded);
text-align:left;
padding:0 6px 10px;
border-bottom:1.5px solid var(--ink);
white-space:nowrap;
}
thead th.num{text-align:right}
tbody td{
padding:14px 6px;
border-bottom:1px dotted var(--rule);
font-size:13px;
vertical-align:top;
}
tbody td.mono{font-family:'IBM Plex Mono',monospace}
tbody td.num{text-align:right;font-family:'IBM Plex Mono',monospace;font-weight:600}
tbody .cust-line{display:block}
tbody .service-line{display:block;font-weight:600}
tbody .provider-line{display:block;color:var(--ink-faded);font-size:12px}
tbody tr:hover td{background:var(--paper-2)}
.stamp{
display:inline-block;
font-family:'Special Elite',monospace;
font-size:11px;
letter-spacing:1.5px;
text-transform:uppercase;
padding:4px 9px;
border:2px solid currentColor;
border-radius:3px;
transform:rotate(-7deg);
white-space:nowrap;
}
.stamp-green{color:var(--stamp-green)}
.stamp-red{color:var(--stamp-red)}
.stamp-amber{color:var(--stamp-amber)}
.empty{
text-align:center;
padding:50px 10px;
}
.empty .stamp{
transform:rotate(-8deg);
font-size:16px;
padding:10px 20px;
color:var(--stamp-red);
margin-bottom:14px;
}
.empty p{
font-family:'IBM Plex Mono',monospace;
font-size:12px;
letter-spacing:1px;
color:var(--ink-faded);
text-transform:uppercase;
}
.barcode{
height:34px;
margin:22px 0 6px;
background:repeating-linear-gradient(90deg,var(--ink) 0 2px,transparent 2px 5px,var(--ink) 5px 6px,transparent 6px 11px,var(--ink) 11px 14px,transparent 14px 16px);
opacity:.8;
}
.footer-row{
text-align:center;
padding-top:6px;
}
.back-link{
display:inline-block;
font-family:'IBM Plex Mono',monospace;
font-size:11px;
letter-spacing:1.5px;
text-transform:uppercase;
color:var(--ink);
text-decoration:none;
border-bottom:1px dotted var(--ink);
padding-bottom:2px;
}
.back-link:hover{color:var(--stamp-red);border-color:var(--stamp-red)}
.back-link:focus-visible,.search-row input:focus-visible{
outline:2px solid var(--stamp-green);
outline-offset:2px;
}
@media(max-width:600px){
body{padding:36px 10px 60px}
.receipt{padding:26px 18px 22px}
.masthead .name{font-size:24px}
tbody td{padding:12px 4px;font-size:12px}
}
</style>
</head>
<body>

<div class="wordmark">
<div class="brand">SECUREPAY</div>
<div class="sub">Payments Ledger</div>
</div>

<div class="receipt-frame">
<div class="tear"></div>
<div class="receipt">

<div class="masthead">
<div class="name">Recharge History</div>
<div class="tag">Record of every recharge run through your account</div>
<div class="meta">Customer copy &middot; printed <%= new SimpleDateFormat("dd MMM yyyy, HH:mm").format(new java.util.Date()) %></div>
</div>

<hr class="rule">

<div class="summary-line">
<span class="label">Transactions printed</span>
<span class="leader"></span>
<span class="value"><%= rechargeList==null?0:rechargeList.size() %></span>
</div>
<div class="summary-line">
<span class="label">Total value</span>
<span class="leader"></span>
<span class="value">&#8377; <%= money(totalAmount) %></span>
</div>
<div class="summary-line">
<span class="label">Successful</span>
<span class="leader"></span>
<span class="value"><%= successCount %></span>
</div>

<hr class="rule">

<div class="search-row">
<input type="text" id="search" placeholder="Search provider, service or number">
</div>

<hr class="rule">

<% if(rechargeList!=null && !rechargeList.isEmpty()){ %>
<div class="table-wrap">
<table id="historyTable">
<thead>
<tr>
<th>ID</th>
<th>Service</th>
<th>Customer</th>
<th class="num">Amount</th>
<th>Status</th>
<th>Date</th>
</tr>
</thead>
<tbody>
<% for(Recharge recharge : rechargeList){
    String status = recharge.getStatus()==null ? "" : recharge.getStatus();
    String statusUpper = status.toUpperCase();
    String stampClass;
    String stampLabel;
    if("SUCCESS".equals(statusUpper)){
        stampClass="stamp-green"; stampLabel="Paid";
    } else if("FAILED".equals(statusUpper)){
        stampClass="stamp-red"; stampLabel="Failed";
    } else {
        stampClass="stamp-amber"; stampLabel=esc(status);
    }
%>
<tr>
<td class="mono">#<%= id4(recharge.getId()) %></td>
<td>
<span class="service-line"><%= esc(recharge.getServiceType()) %></span>
<span class="provider-line"><%= esc(recharge.getProvider()) %></span>
</td>
<td class="mono"><%= esc(recharge.getCustomerNumber()) %></td>
<td class="num">&#8377; <%= money(recharge.getAmount()) %></td>
<td><span class="stamp <%= stampClass %>"><%= stampLabel %></span></td>
<td class="mono"><%= esc(recharge.getRechargeDate()) %></td>
</tr>
<% } %>
</tbody>
</table>
</div>
<% } else { %>
<div class="empty">
<span class="stamp">Void</span>
<p>No recharge history found</p>
</div>
<% } %>

<hr class="rule">

<div class="barcode" aria-hidden="true"></div>

<div class="footer-row">
<a href="Dashboard.jsp" class="back-link">&larr; Return to dashboard</a>
</div>

</div>
<div class="tear bottom"></div>
</div>

<script>
document.getElementById("search").addEventListener("keyup",function(){
var filter=this.value.toLowerCase();
var rows=document.querySelectorAll("#historyTable tbody tr");
rows.forEach(function(row){
row.style.display=row.innerText.toLowerCase().includes(filter)?"":"none";
});
});
</script>
</body>
</html>
