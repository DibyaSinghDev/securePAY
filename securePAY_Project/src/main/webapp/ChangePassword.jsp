<%@ page import="com.securepay.model.User" %>

<%
User user =
(User)session.getAttribute("user");

if(user == null){

    response.sendRedirect("Login.jsp");
    return;
}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Change Password</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{

height:100vh;

display:flex;

justify-content:center;

align-items:center;

background:
linear-gradient(
135deg,
#020617,
#0f172a,
#1e293b);
}

.container{

width:450px;

padding:40px;

background:
rgba(255,255,255,0.08);

backdrop-filter:blur(15px);

border-radius:25px;

text-align:center;

color:white;

box-shadow:
0 0 25px rgba(59,130,246,0.3);
}

h2{

margin-bottom:20px;
}

input{

width:100%;

padding:15px;

margin:10px 0;

border:none;

border-radius:10px;
}

.btn{

width:100%;

padding:15px;

margin-top:15px;

background:#2563eb;

border:none;

color:white;

border-radius:10px;

font-size:16px;

cursor:pointer;
}

.btn:hover{

background:#1d4ed8;
}

.back{

display:block;

margin-top:15px;

color:white;

text-decoration:none;
}

</style>

</head>

<body>

<div class="container">

<h2>

🔑 Change Password

</h2>

<form action="ChangePasswordServlet"
method="post">

<input
type="password"
name="oldPassword"
placeholder="Old Password"
required>

<input
type="password"
name="newPassword"
placeholder="New Password"
required>

<input
type="password"
name="confirmPassword"
placeholder="Confirm Password"
required>

<button
type="submit"
class="btn">

Update Password

</button>

</form>

<a href="Dashboard.jsp"
class="back">

🏠 Back To Dashboard

</a>

</div>

</body>

</html>