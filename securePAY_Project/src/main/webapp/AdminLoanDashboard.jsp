<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.securepay.model.Loan"%>
<%
List<Loan> loanList=(List<Loan>)request.getAttribute("loanList");
if(loanList==null) loanList=new ArrayList<>();

int pendingCount=0, approvedCount=0, rejectedCount=0;
for(Loan loan: loanList){
    String s = loan.getStatus();
    if("Pending".equalsIgnoreCase(s)) pendingCount++;
    else if("Approved".equalsIgnoreCase(s)) approvedCount++;
    else if("Rejected".equalsIgnoreCase(s)) rejectedCount++;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SecurePAY Admin - Loan Dashboard</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600&family=Manrope:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">

<style>

:root{
    --metal:#1a1613;
    --metal-raised:#242019;
    --metal-deep:#100d0b;
    --line:#3a3227;
    --brass:#c9a227;
    --brass-bright:#e8c765;
    --phosphor:#5eda8e;
    --phosphor-dim:#264534;
    --amber:#e0a83f;
    --amber-dim:#4a3a1a;
    --lamp-red:#e0554a;
    --lamp-red-dim:#4a2420;
    --ivory:#f3ede0;
    --gray:#948c78;
}

*{ margin:0; padding:0; box-sizing:border-box; font-family:'Manrope',sans-serif; }

body{
    background:radial-gradient(circle at 15% 0%, #201b16 0%, var(--metal-deep) 60%);
    color:var(--ivory);
    min-height:100vh;
}

::selection{ background:var(--phosphor); color:#0a1a11; }

.container{ max-width:1300px; margin:0 auto; padding:36px 28px 50px; }

.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:28px;
}

.header .title{ display:flex; align-items:center; gap:14px; }

.header .seal{
    width:44px; height:44px;
    border-radius:50%;
    border:1px dashed var(--brass);
    display:flex; align-items:center; justify-content:center;
    color:var(--brass-bright); font-size:17px;
    flex-shrink:0;
}

.header .eyebrow{
    font-family:'JetBrains Mono',monospace;
    font-size:11px; letter-spacing:2.5px; text-transform:uppercase;
    color:var(--brass); margin-bottom:4px;
}

.header h1{ font-family:'Fraunces',serif; font-weight:600; font-size:26px; }

.back-link{
    display:flex; align-items:center; gap:10px;
    text-decoration:none;
    color:var(--ivory);
    background:var(--metal-raised);
    border:1px solid var(--line);
    padding:10px 16px;
    border-radius:10px;
    font-size:13.5px;
    font-weight:500;
    transition:border-color .15s;
}

.back-link:hover{ border-color:var(--brass); }

/* ---------- Readout cards ---------- */

.cards{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:16px;
    margin-bottom:26px;
}

.lcd-card{
    background:var(--metal);
    border:1px solid var(--line);
    border-radius:14px;
    padding:20px 22px;
}

.lcd-card .label{
    font-family:'JetBrains Mono',monospace;
    font-size:11px; letter-spacing:1.3px; text-transform:uppercase;
    color:var(--gray);
    display:flex; align-items:center; gap:8px;
    margin-bottom:12px;
}

.lcd-card .lamp{
    width:8px; height:8px; border-radius:50%;
    display:inline-block;
}

.lcd-card.pending .lamp{ background:var(--amber); box-shadow:0 0 7px var(--amber); }
.lcd-card.approved .lamp{ background:var(--phosphor); box-shadow:0 0 7px var(--phosphor); }
.lcd-card.rejected .lamp{ background:var(--lamp-red); box-shadow:0 0 7px var(--lamp-red); }
.lcd-card.total .lamp{ background:var(--brass); box-shadow:0 0 7px var(--brass); }

.lcd-card .value{
    font-family:'JetBrains Mono',monospace;
    font-weight:700;
    font-size:32px;
}

.lcd-card.pending .value{ color:var(--amber); }
.lcd-card.approved .value{ color:var(--phosphor); }
.lcd-card.rejected .value{ color:var(--lamp-red); }
.lcd-card.total .value{ color:var(--brass-bright); }

/* ---------- Toolbar ---------- */

.toolbar{ margin-bottom:20px; }

.search-wrap{
    position:relative;
    max-width:360px;
}

.search-wrap i{
    position:absolute; left:14px; top:50%; transform:translateY(-50%);
    color:var(--gray); font-size:13px;
}

input[type=text]{
    width:100%;
    padding:13px 14px 13px 38px;
    background:var(--metal);
    border:1px solid var(--line);
    border-radius:10px;
    color:var(--ivory);
    font-family:'JetBrains Mono',monospace;
    font-size:13.5px;
    transition:border-color .15s;
}

input[type=text]::placeholder{ color:var(--gray); }
input[type=text]:focus{ outline:none; border-color:var(--brass); }

/* ---------- Table ---------- */

.table-panel{
    background:var(--metal);
    border:1px solid var(--line);
    border-radius:16px;
    overflow:hidden;
}

table{ width:100%; border-collapse:collapse; }

th{
    background:var(--metal-deep);
    color:var(--brass);
    font-family:'JetBrains Mono',monospace;
    font-size:11px;
    letter-spacing:1.2px;
    text-transform:uppercase;
    text-align:left;
    padding:16px 18px;
    border-bottom:1px solid var(--line);
}

td{
    padding:16px 18px;
    border-bottom:1px dashed var(--line);
    text-align:left;
    font-size:14px;
    color:var(--ivory);
}

tbody tr:hover{ background:var(--metal-raised); }
tbody tr:last-child td{ border-bottom:none; }

.badge{
    display:inline-flex;
    align-items:center;
    gap:7px;
    padding:5px 12px;
    border-radius:20px;
    font-size:12px;
    font-weight:600;
    font-family:'JetBrains Mono',monospace;
    letter-spacing:.4px;
}

.badge::before{
    content:"";
    width:7px; height:7px;
    border-radius:50%;
}

.badge.Pending{ background:var(--amber-dim); color:var(--amber); }
.badge.Pending::before{ background:var(--amber); box-shadow:0 0 6px var(--amber); }

.badge.Approved{ background:var(--phosphor-dim); color:var(--phosphor); }
.badge.Approved::before{ background:var(--phosphor); box-shadow:0 0 6px var(--phosphor); }

.badge.Rejected{ background:var(--lamp-red-dim); color:var(--lamp-red); }
.badge.Rejected::before{ background:var(--lamp-red); box-shadow:0 0 6px var(--lamp-red); }

.btn{
    padding:7px 13px;
    border-radius:7px;
    text-decoration:none;
    font-size:12.5px;
    font-weight:600;
    margin:2px;
    display:inline-block;
    border:1px solid transparent;
    transition:transform .12s, opacity .12s;
}

.btn:hover{ transform:translateY(-2px); }

.btn.view{ background:var(--metal-raised); color:var(--brass-bright); border-color:var(--brass); }
.btn.approve{ background:var(--phosphor-dim); color:var(--phosphor); border-color:var(--phosphor); }
.btn.reject{ background:var(--lamp-red-dim); color:var(--lamp-red); border-color:var(--lamp-red); }

.empty-row td{
    text-align:center;
    padding:36px;
    color:var(--gray);
    font-family:'JetBrains Mono',monospace;
    font-size:13px;
}

@media(max-width:900px){
    .cards{ grid-template-columns:repeat(2,1fr); }
    table{ font-size:13px; }
    .container{ padding:24px 16px 40px; }
}

</style>

<script>
function searchLoan(){
 let q=document.getElementById("search").value.toLowerCase();
 document.querySelectorAll("#loanTable tbody tr").forEach(r=>{
   r.style.display=r.innerText.toLowerCase().includes(q)?"":"none";
 });
}
</script>
</head>
<body>
<div class="container">

<div class="header">
    <div class="title">
        <div class="seal"><i class="fa-solid fa-building-columns"></i></div>
        <div>
            <div class="eyebrow">Admin console</div>
            <h1>Loan Management</h1>
        </div>
    </div>
    <a class="back-link" href="AdminDashboard.jsp"><i class="fa-solid fa-arrow-left"></i> Dashboard</a>
</div>

<div class="cards">
    <div class="lcd-card pending">
        <div class="label"><span class="lamp"></span>Pending</div>
        <div class="value"><%=pendingCount%></div>
    </div>
    <div class="lcd-card approved">
        <div class="label"><span class="lamp"></span>Approved</div>
        <div class="value"><%=approvedCount%></div>
    </div>
    <div class="lcd-card rejected">
        <div class="label"><span class="lamp"></span>Rejected</div>
        <div class="value"><%=rejectedCount%></div>
    </div>
    <div class="lcd-card total">
        <div class="label"><span class="lamp"></span>Total Requests</div>
        <div class="value"><%=loanList.size()%></div>
    </div>
</div>

<div class="toolbar">
    <div class="search-wrap">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input id="search" type="text" placeholder="Search applicant..." onkeyup="searchLoan()">
    </div>
</div>

<div class="table-panel">
<table id="loanTable">
<thead>
<tr>
<th>ID</th>
<th>Applicant</th>
<th>Loan Type</th>
<th>Amount</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>
<tbody>
<%
if(loanList.isEmpty()){
%>
<tr class="empty-row"><td colspan="6">No loan requests on file.</td></tr>
<%
} else {
for(Loan loan:loanList){
%>
<tr>
<td><%=loan.getLoanId()%></td>
<td><%=loan.getApplicantName()%></td>
<td><%=loan.getLoanType()%></td>
<td>₹ <%=loan.getLoanAmount()%></td>
<td><span class="badge <%=loan.getStatus()%>"><%=loan.getStatus()%></span></td>
<td>
<a class="btn view" href="LoanDetailsServlet?loanId=<%=loan.getLoanId()%>">View</a>
<% if("Pending".equalsIgnoreCase(loan.getStatus())){ %>
<a class="btn approve" href="ApproveLoanServlet?loanId=<%=loan.getLoanId()%>">Approve</a>
<a class="btn reject" href="RejectLoanServlet?loanId=<%=loan.getLoanId()%>">Reject</a>
<% } %>
</td>
</tr>
<%
}
}
%>
</tbody>
</table>
</div>

</div>
</body>
</html>
