<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String transactionId = (String) session.getAttribute("transactionId");
String successMessage = (String) session.getAttribute("successMessage");

if(transactionId == null){
    response.sendRedirect("Recharge.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recharge Successful</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
}

body{
    background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
}

.card{

    width:450px;
    background:white;
    border-radius:20px;
    padding:40px;
    text-align:center;
    box-shadow:0 20px 40px rgba(0,0,0,.3);

}

.check{

    width:100px;
    height:100px;
    margin:auto;
    border-radius:50%;
    background:#28a745;
    color:white;
    font-size:55px;
    display:flex;
    justify-content:center;
    align-items:center;

}

h1{

    margin-top:20px;
    color:#28a745;

}

.info{

    margin-top:25px;
    text-align:left;

}

.info p{

    padding:12px 0;
    border-bottom:1px solid #ddd;

}

.btn{

    margin-top:30px;
    display:inline-block;
    padding:14px 35px;
    background:#0d6efd;
    color:white;
    text-decoration:none;
    border-radius:8px;

}

.btn:hover{

    background:#084298;

}

</style>

</head>

<body>

<div class="card">

<div class="check">
✓
</div>

<h1>Recharge Successful</h1>

<h3 style="margin-top:10px;">
<%=successMessage%>
</h3>

<div class="info">

<p>
<b>Transaction ID :</b>
<%=transactionId%>
</p>

<p>
<b>Status :</b>
SUCCESS
</p>

<p>
<b>Date :</b>
<%=new java.util.Date()%>
</p>

</div>

<a href="Dashboard.jsp" class="btn">
Back to Dashboard
</a>

</div>

</body>
</html>