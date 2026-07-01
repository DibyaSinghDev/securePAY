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

<title>Loan Application Submitted | SecurePAY</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{

background:#f5f7fb;

display:flex;

justify-content:center;

align-items:center;

height:100vh;

}

.card{

width:520px;

background:white;

padding:45px;

border-radius:20px;

box-shadow:0 15px 40px rgba(0,0,0,.12);

text-align:center;

animation:slide .7s ease;

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

.check{

width:120px;

height:120px;

margin:auto;

border-radius:50%;

background:#22c55e;

display:flex;

justify-content:center;

align-items:center;

animation:pop .8s ease;

}

.check i{

font-size:60px;

color:white;

}

@keyframes pop{

0%{

transform:scale(0);

}

70%{

transform:scale(1.2);

}

100%{

transform:scale(1);

}

}

h1{

margin-top:25px;

color:#22c55e;

}

p{

margin-top:18px;

font-size:17px;

color:#555;

line-height:28px;

}

.status{

margin-top:30px;

background:#eefaf1;

padding:18px;

border-radius:12px;

border-left:6px solid #22c55e;

}

.status h3{

color:#16a34a;

margin-bottom:10px;

}

.info{

margin-top:25px;

text-align:left;

background:#f8fafc;

padding:20px;

border-radius:12px;

}

.info p{

margin:12px 0;

font-size:16px;

}

.buttons{

margin-top:35px;

display:flex;

gap:15px;

}

.btn{

flex:1;

padding:15px;

text-decoration:none;

border-radius:10px;

font-weight:bold;

transition:.3s;

text-align:center;

}

.dashboard{

background:#2563eb;

color:white;

}

.dashboard:hover{

background:#1d4ed8;

}

.statusBtn{

background:#22c55e;

color:white;

}

.statusBtn:hover{

background:#16a34a;

}

.footer{

margin-top:25px;

font-size:14px;

color:#888;

}

</style>

</head>

<body>

<div class="card">

<div class="check">

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

Pending Approval

</div>

<div class="info">

<p>

<b>✔ Loan application received</b>

</p>

<p>

<b>✔ Verification in progress</b>

</p>

<p>

<b>✔ Admin will review your request</b>

</p>

<p>

<b>✔ You will receive a notification after approval/rejection</b>

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