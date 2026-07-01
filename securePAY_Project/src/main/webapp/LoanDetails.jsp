<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.securepay.model.Loan"%>
<%
Loan loan=(Loan)request.getAttribute("loan");
if(loan==null){
 response.sendRedirect("AdminLoanServlet");
 return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Loan Details</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Segoe UI,sans-serif}
body{background:#f4f7fb;padding:40px;color:#1f2937}
.container{max-width:1000px;margin:auto}
.grid{display:grid;grid-template-columns:1fr 1fr;gap:20px}
.card{background:#fff;border-radius:18px;padding:25px;box-shadow:0 8px 24px rgba(0,0,0,.08)}
.header{display:flex;align-items:center;gap:15px;margin-bottom:20px}
.avatar{width:70px;height:70px;border-radius:50%;background:#2563eb;color:#fff;display:flex;align-items:center;justify-content:center;font-size:30px}
.row{display:flex;justify-content:space-between;padding:12px 0;border-bottom:1px solid #eee}
.badge{padding:6px 14px;border-radius:20px;font-weight:600}
.Pending{background:#fff3cd;color:#8a6d3b}
.Approved{background:#d1fae5;color:#065f46}
.Rejected{background:#fee2e2;color:#991b1b}
textarea{width:100%;padding:12px;border:1px solid #ccc;border-radius:10px;resize:none}
.actions{display:flex;gap:15px;margin-top:20px}
button{flex:1;padding:14px;border:none;border-radius:10px;color:#fff;font-size:16px;cursor:pointer}
.approve{background:#16a34a}
.reject{background:#dc2626}
.back{display:inline-block;margin-top:20px;text-decoration:none;color:#2563eb;font-weight:600}
@media(max-width:800px){.grid{grid-template-columns:1fr}}
</style>
</head>
<body>
<div class="container">
<div class="grid">

<div class="card">
<div class="header">
<div class="avatar"><i class="fa-solid fa-user"></i></div>
<div>
<h2><%=loan.getApplicantName()%></h2>
<p><%=loan.getEmail()%></p>
</div>
</div>

<div class="row"><span>Account</span><b><%=loan.getAccountNumber()%></b></div>
<div class="row"><span>User ID</span><b><%=loan.getUserId()%></b></div>
<div class="row"><span>Applied Date</span><b><%=loan.getAppliedDate()%></b></div>
</div>

<div class="card">
<h2 style="margin-bottom:15px;">Loan Information</h2>
<div class="row"><span>Loan Type</span><b><%=loan.getLoanType()%></b></div>
<div class="row"><span>Loan Amount</span><b>₹ <%=loan.getLoanAmount()%></b></div>
<div class="row"><span>Duration</span><b><%=loan.getDuration()%> Months</b></div>
<div class="row"><span>Monthly Income</span><b>₹ <%=loan.getMonthlyIncome()%></b></div>
<div class="row"><span>Status</span><span class="badge <%=loan.getStatus()%>"><%=loan.getStatus()%></span></div>
<div style="padding-top:15px">
<b>Purpose</b>
<p style="margin-top:8px"><%=loan.getPurpose()%></p>
</div>

<form action="ApproveLoanServlet" method="post">
<input type="hidden" name="loanId" value="<%=loan.getLoanId()%>">
<div style="margin-top:20px">
<label><b>Admin Remark</b></label>
<textarea rows="4" name="remark" placeholder="Enter approval/rejection remark..." required></textarea>
</div>

<div class="actions">
<button class="approve" type="submit">
<i class="fa-solid fa-circle-check"></i> Approve Loan
</button>

<button class="reject"
type="submit"
formaction="RejectLoanServlet">
<i class="fa-solid fa-circle-xmark"></i> Reject Loan
</button>
</div>
</form>

<a class="back" href="AdminLoanServlet">
<i class="fa-solid fa-arrow-left"></i>
Back to Loan Dashboard
</a>

</div>

</div>
</div>
</body>
</html>