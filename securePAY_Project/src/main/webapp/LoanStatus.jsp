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

<title>My Loans | SecurePAY</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Segoe UI,sans-serif;
}

body{

background:#f5f7fb;

}

.container{

width:92%;

max-width:1100px;

margin:40px auto;

}

.header{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:30px;

}

.header h2{

color:#2563eb;

}

.back{

text-decoration:none;

font-weight:bold;

color:#2563eb;

}

.loan-card{

background:white;

padding:25px;

border-radius:15px;

margin-bottom:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

transition:.3s;

}

.loan-card:hover{

transform:translateY(-5px);

}

.row{

display:flex;

justify-content:space-between;

margin:12px 0;

}

.label{

font-weight:bold;

color:#666;

}

.value{

font-weight:bold;

}

.badge{

padding:6px 14px;

border-radius:20px;

font-size:14px;

font-weight:bold;

}

.pending{

background:#fff3cd;

color:#856404;

}

.approved{

background:#d4edda;

color:#155724;

}

.rejected{

background:#f8d7da;

color:#721c24;

}

.empty{

background:white;

padding:70px;

text-align:center;

border-radius:15px;

box-shadow:0 8px 20px rgba(0,0,0,.08);

}

.empty i{

font-size:70px;

color:#2563eb;

margin-bottom:20px;

}

</style>

</head>

<body>

<div class="container">

<div class="header">

<h2>

<i class="fa-solid fa-building-columns"></i>

My Loan Applications

</h2>

<a href="Dashboard.jsp" class="back">

← Dashboard

</a>

</div>

<%

if(loanList.isEmpty()){

%>

<div class="empty">

<i class="fa-solid fa-file-circle-xmark"></i>

<h2>No Loan Applications</h2>

<p>

You haven't applied for any loan yet.

</p>

</div>

<%

}else{

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

<div class="loan-card">

<div class="row">

<span class="label">

Loan Type

</span>

<span class="value">

<%=loan.getLoanType()%>

</span>

</div>

<div class="row">

<span class="label">

Loan Amount

</span>

<span class="value">

₹ <%=loan.getLoanAmount()%>

</span>

</div>

<div class="row">

<span class="label">

Duration

</span>

<span class="value">

<%=loan.getDuration()%> Months

</span>

</div>

<div class="row">

<span class="label">

Monthly Income

</span>

<span class="value">

₹ <%=loan.getMonthlyIncome()%>

</span>

</div>

<div class="row">

<span class="label">

Applied Date

</span>

<span class="value">

<%=loan.getAppliedDate()%>

</span>

</div>

<div class="row">

<span class="label">

Status

</span>

<span class="badge <%=css%>">

<%=loan.getStatus()%>

</span>

</div>

<div class="row">

<span class="label">

Admin Remark

</span>

<span class="value">

<%=loan.getAdminRemark()==null?"Waiting for Review":loan.getAdminRemark()%>

</span>

</div>

</div>

<%

}

}

%>

</div>

</body>

</html>