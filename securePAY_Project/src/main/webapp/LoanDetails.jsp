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
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Loan Details | SecurePAY Admin</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
  --credit-2:#155f3b;
  --debit:#B23A2E;
  --debit-2:#8f2d21;
  --muted:#6B7280;
  --radius:18px;
}
*{margin:0;padding:0;box-sizing:border-box;font-family:'Inter',sans-serif}
body{
  background:
    radial-gradient(ellipse at top left, rgba(201,164,76,.10), transparent 55%),
    linear-gradient(160deg,var(--ink) 0%,var(--ink-2) 55%,#0d2044 100%);
  color:#fff;min-height:100vh;padding:40px 20px;
}
.container{max-width:1000px;margin:auto}

.page-head{margin-bottom:22px}
.page-head .eyebrow{
  font-family:'IBM Plex Mono',monospace;font-size:12px;letter-spacing:2px;
  text-transform:uppercase;color:var(--gold-soft);
}
.page-head h1{font-family:'Fraunces',serif;font-size:28px;font-weight:600;margin-top:6px}

.grid{display:grid;grid-template-columns:1fr 1.2fr;gap:20px}
.card{
  background:var(--paper);color:var(--ledger-ink);
  border-radius:var(--radius);padding:28px;
  box-shadow:0 20px 45px rgba(0,0,0,.3);
}

/* ---------- Applicant card ---------- */
.header{display:flex;align-items:center;gap:16px;margin-bottom:22px}
.avatar{
  width:64px;height:64px;border-radius:50%;
  background:linear-gradient(155deg,#1a3663,#0e2145);
  border:1.5px solid var(--gold);
  color:var(--gold-soft);
  display:flex;align-items:center;justify-content:center;font-size:24px;
}
.header h2{font-family:'Fraunces',serif;font-size:20px;font-weight:600;color:var(--ink)}
.header p{font-size:13px;color:var(--muted);margin-top:3px;font-family:'IBM Plex Mono',monospace}

.row{
  display:flex;justify-content:space-between;align-items:center;
  padding:13px 0;border-bottom:1px solid var(--paper-line);
}
.row:last-child{border-bottom:none}
.row span{font-size:12.5px;color:var(--muted);font-weight:600;letter-spacing:.4px;text-transform:uppercase}
.row b{font-family:'IBM Plex Mono',monospace;font-size:14.5px;color:var(--ledger-ink)}

/* ---------- Loan info card ---------- */
.card h2.title{font-family:'Fraunces',serif;font-size:20px;margin-bottom:16px;color:var(--ink)}

.stamp{
  padding:6px 15px;border-radius:8px;border:2px solid;
  font-family:'IBM Plex Mono',monospace;font-weight:700;font-size:11.5px;
  letter-spacing:1.5px;text-transform:uppercase;transform:rotate(-4deg);display:inline-block;
}
.Pending{border-color:var(--gold);color:#8a6a1f;background:rgba(201,164,76,.1)}
.Approved{border-color:var(--credit);color:var(--credit);background:rgba(30,123,77,.08)}
.Rejected{border-color:var(--debit);color:var(--debit);background:rgba(178,58,46,.08)}

.purpose{
  margin-top:18px;padding:16px 18px;
  background:#fff;border:1px dashed var(--paper-line);border-radius:12px;
}
.purpose b{
  font-size:12px;color:var(--muted);letter-spacing:.5px;text-transform:uppercase;
  display:block;margin-bottom:8px;
}
.purpose p{font-size:14px;color:var(--ledger-ink);line-height:1.6}

label{
  display:block;margin-top:22px;margin-bottom:8px;
  font-size:12.5px;color:var(--muted);font-weight:600;letter-spacing:.5px;text-transform:uppercase;
}
textarea{
  width:100%;padding:14px;border:1px solid #D8D2BC;border-radius:10px;
  background:#fff;color:var(--ledger-ink);resize:vertical;
  font-family:'Inter',sans-serif;font-size:14px;
}
textarea:focus{outline:2px solid var(--gold-soft);outline-offset:1px;border-color:var(--gold)}

.actions{display:flex;gap:14px;margin-top:20px}
button{
  flex:1;padding:14px;border:none;border-radius:10px;color:#fff;
  font-size:14.5px;font-weight:600;cursor:pointer;transition:.2s;
  display:flex;align-items:center;justify-content:center;gap:8px;
}
.approve{background:var(--credit)}
.approve:hover{background:var(--credit-2)}
.reject{background:var(--debit)}
.reject:hover{background:var(--debit-2)}
button:focus-visible{outline:2px solid var(--gold);outline-offset:2px}

.back{
  display:inline-flex;align-items:center;gap:8px;
  margin-top:24px;text-decoration:none;color:var(--gold-soft);
  font-weight:600;font-size:13.5px;
}
.back:hover{color:var(--gold)}

@media(max-width:800px){
  .grid{grid-template-columns:1fr}
  body{padding:24px 16px}
  .card{padding:22px}
}
</style>
</head>
<body>
<div class="container">

<div class="page-head">
<div class="eyebrow">Admin Review</div>
<h1>Loan Application Details</h1>
</div>

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
<h2 class="title">Loan Information</h2>
<div class="row"><span>Loan Type</span><b><%=loan.getLoanType()%></b></div>
<div class="row"><span>Loan Amount</span><b>₹ <%=loan.getLoanAmount()%></b></div>
<div class="row"><span>Duration</span><b><%=loan.getDuration()%> Months</b></div>
<div class="row"><span>Monthly Income</span><b>₹ <%=loan.getMonthlyIncome()%></b></div>
<div class="row"><span>Status</span><span class="stamp <%=loan.getStatus()%>"><%=loan.getStatus()%></span></div>

<div class="purpose">
<b>Purpose</b>
<p><%=loan.getPurpose()%></p>
</div>

<form action="ApproveLoanServlet" method="post">
<input type="hidden" name="loanId" value="<%=loan.getLoanId()%>">

<label for="remark">Admin Remark</label>
<textarea id="remark" rows="4" name="remark" placeholder="Enter approval/rejection remark..." required></textarea>

<div class="actions">
<button class="approve" type="submit">
<i class="fa-solid fa-circle-check"></i> Approve Loan
</button>

<button class="reject" type="submit" formaction="RejectLoanServlet">
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
