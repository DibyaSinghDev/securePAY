
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

<title>SecurePAY | Profile</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{

background:
linear-gradient(
135deg,
#020617,
#0f172a,
#111827);

color:white;

min-height:100vh;

overflow-x:hidden;
}

/* Navbar */

.navbar{

display:flex;

justify-content:space-between;

align-items:center;

padding:25px 50px;

background:
rgba(255,255,255,.04);

backdrop-filter:blur(20px);

border-bottom:
1px solid rgba(255,255,255,.08);
}

.logo{

font-size:30px;

font-weight:700;

color:#38bdf8;
}

.nav-right{

display:flex;

align-items:center;

gap:20px;
}

.logout{

text-decoration:none;

color:white;

padding:12px 20px;

background:#ef4444;

border-radius:12px;

transition:.3s;
}

.logout:hover{

background:#dc2626;
}

/* Main */

.container{

padding:40px 60px;
}

/* Header */

.header h1{

font-size:42px;

margin-bottom:10px;
}

.header p{

color:#94a3b8;
}

/* Profile Card */

.profile-card{

margin-top:30px;

padding:40px;

border-radius:30px;

background:
rgba(255,255,255,.05);

backdrop-filter:blur(20px);

border:
1px solid rgba(255,255,255,.08);

display:flex;

align-items:center;

gap:40px;
}

/* Avatar */

.avatar{

width:150px;
height:150px;

border-radius:50%;

background:
linear-gradient(
135deg,
#2563eb,
#06b6d4);

display:flex;

align-items:center;
justify-content:center;

font-size:55px;

font-weight:700;

color:white;

flex-shrink:0;
}

/* Profile Details */

.profile-details{

flex:1;
}

.profile-details h2{

font-size:32px;

margin-bottom:10px;
}

.profile-details p{

color:#94a3b8;
}

/* Information Grid */

.info-grid{

margin-top:35px;

display:grid;

grid-template-columns:
repeat(2,1fr);

gap:20px;
}

.info-card{

padding:25px;

border-radius:20px;

background:
rgba(255,255,255,.05);

border:
1px solid rgba(255,255,255,.08);
}

.info-card h4{

color:#94a3b8;

margin-bottom:10px;

font-size:14px;
}

.info-card p{

font-size:18px;

font-weight:600;
}

/* Action Buttons */

.actions{

display:grid;

grid-template-columns:
repeat(2,1fr);

gap:20px;

margin-top:35px;
}

.btn{

text-decoration:none;

text-align:center;

padding:18px;

border-radius:15px;

font-weight:600;

transition:.3s;

color:white;
}

.dashboard{

background:
linear-gradient(
135deg,
#2563eb,
#1d4ed8);
}

.password{

background:
linear-gradient(
135deg,
#7c3aed,
#6d28d9);
}

.btn:hover{

transform:
translateY(-4px);
}

/* Footer */

.footer{

margin-top:40px;

text-align:center;

color:#64748b;
}

/* Mobile */

@media(max-width:900px){

.container,
.navbar{
padding:20px;
}

.profile-card{

flex-direction:column;

text-align:center;
}

.info-grid{

grid-template-columns:1fr;
}

.actions{

grid-template-columns:1fr;
}

}

</style>

</head>

<body>

<div class="navbar">

<div class="logo">

SecurePAY

</div>

<div class="nav-right">

<span>

<%= user.getName() %>

</span>

<a href="LogoutServlet"
class="logout">

Logout

</a>

</div>

</div>

<div class="container">

<div class="header">

<h1>

My Profile

</h1>

<p>

Manage your account information securely.

</p>

</div>

<div class="profile-card">

<div class="avatar">

<%= user.getName().substring(0,1).toUpperCase() %>

</div>

<div class="profile-details">

<h2>

<%= user.getName() %>

</h2>

<p>

SecurePAY Banking Customer

</p>

</div>

</div>

<div class="info-grid">

<div class="info-card">

<h4>

Full Name

</h4>

<p>

<%= user.getName() %>

</p>

</div>

<div class="info-card">

<h4>

Email Address

</h4>

<p>

<%= user.getEmail() %>

</p>

</div>

<div class="info-card">

<h4>

Account Number

</h4>

<p>

<%= user.getAccountNumber() %>

</p>

</div>

<div class="info-card">

<h4>

Available Balance

</h4>

<p>

₹ <%= user.getBalance() %>

</p>

</div>

</div>

<div class="actions">

<a href="DashboardServlet"
class="btn dashboard">

Back To Dashboard

</a>

<a href="ChangePassword.jsp"
class="btn password">

Change Password

</a>

</div>

<div class="footer">

© 2026 SecurePAY Digital Banking Platform

</div>

</div>

</body>

</html>

