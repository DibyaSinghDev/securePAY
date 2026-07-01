<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if(session.getAttribute("user")==null){
    response.sendRedirect("Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Electricity Bill Payment | SecurePAY</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{
background:linear-gradient(135deg,#ff9966,#ff5e62);
display:flex;
justify-content:center;
align-items:center;
height:100vh;
}

.container{
width:520px;
background:#fff;
padding:35px;
border-radius:20px;
box-shadow:0 20px 40px rgba(0,0,0,.25);
}

h2{
text-align:center;
color:#ff5e62;
margin-bottom:25px;
}

.input-group{
margin-bottom:20px;
}

label{
display:block;
margin-bottom:8px;
font-weight:bold;
}

input,select{
width:100%;
padding:14px;
border:1px solid #ddd;
border-radius:10px;
font-size:16px;
}

button{
width:100%;
padding:15px;
background:#ff5e62;
color:white;
border:none;
border-radius:10px;
font-size:18px;
cursor:pointer;
transition:.3s;
}

button:hover{
background:#e64a19;
}

.back{
display:block;
text-align:center;
margin-top:20px;
text-decoration:none;
font-weight:bold;
color:#ff5e62;
}

</style>

</head>

<body>

<div class="container">

<h2>💡 Electricity Bill Payment</h2>

<form action="RechargeServlet" method="post">

<input type="hidden"
name="serviceType"
value="Electricity Bill">

<div class="input-group">

<label>Electricity Provider</label>

<select name="provider" required>

<option value="">Select Provider</option>

<option>BESCOM</option>
<option>MESCOM</option>
<option>HESCOM</option>
<option>CESCOM</option>
<option>GESCOM</option>
<option>TNEB</option>
<option>WBSEDCL</option>

</select>

</div>

<div class="input-group">

<label>Consumer Number</label>

<input
type="text"
name="customerNumber"
placeholder="Enter Consumer Number"
required>

</div>

<div class="input-group">

<label>Bill Amount (₹)</label>

<input
type="number"
name="amount"
placeholder="Enter Bill Amount"
required>

</div>

<button type="submit">

Pay Electricity Bill

</button>

</form>

<a href="Recharge.jsp" class="back">

← Back

</a>

</div>

</body>

</html>