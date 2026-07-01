<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.securepay.model.Loan"%>
<%
List<Loan> loanList=(List<Loan>)request.getAttribute("loanList");
if(loanList==null) loanList=new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SecurePAY Admin - Loan Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Segoe UI,sans-serif}
body{background:#f4f7fb;color:#1f2937}
.container{max-width:1300px;margin:30px auto;padding:20px}
.header{display:flex;justify-content:space-between;align-items:center;margin-bottom:25px}
.cards{display:grid;grid-template-columns:repeat(4,1fr);gap:18px;margin-bottom:25px}
.card{background:#fff;padding:22px;border-radius:16px;box-shadow:0 8px 24px rgba(0,0,0,.08)}
.card h3{font-size:14px;color:#6b7280}
.card p{font-size:30px;font-weight:700;margin-top:8px}
.toolbar{display:flex;justify-content:space-between;margin-bottom:20px}
input[type=text]{padding:12px;width:320px;border:1px solid #d1d5db;border-radius:10px}
table{width:100%;border-collapse:collapse;background:#fff;border-radius:16px;overflow:hidden;box-shadow:0 8px 24px rgba(0,0,0,.08)}
th{background:#2563eb;color:#fff;padding:15px}
td{padding:15px;border-bottom:1px solid #eee;text-align:center}
tr:hover{background:#f8fbff}
.badge{padding:6px 12px;border-radius:20px;font-size:13px;font-weight:600}
.Pending{background:#fff7cc;color:#946200}
.Approved{background:#dcfce7;color:#166534}
.Rejected{background:#fee2e2;color:#b91c1c}
.btn{padding:9px 14px;border-radius:8px;color:#fff;text-decoration:none;font-size:14px;margin:2px;display:inline-block}
.view{background:#2563eb}
.approve{background:#16a34a}
.reject{background:#dc2626}
@media(max-width:900px){
.cards{grid-template-columns:repeat(2,1fr)}
table{font-size:13px}
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
<h1><i class="fa-solid fa-building-columns"></i> Loan Management</h1>
<a class="btn view" href="AdminDashboard.jsp">← Dashboard</a>
</div>

<div class="cards">
<div class="card"><h3>Pending</h3><p>🟡</p></div>
<div class="card"><h3>Approved</h3><p>🟢</p></div>
<div class="card"><h3>Rejected</h3><p>🔴</p></div>
<div class="card"><h3>Total Requests</h3><p><%=loanList.size()%></p></div>
</div>

<div class="toolbar">
<input id="search" type="text" placeholder="Search applicant..." onkeyup="searchLoan()">
</div>

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
<% } %>
</tbody>
</table>
</div>
</body>
</html>
