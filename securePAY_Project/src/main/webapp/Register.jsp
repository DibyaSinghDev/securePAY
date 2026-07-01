
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>SecurePAY | Create Account</title>

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

height:100vh;

background:
linear-gradient(
135deg,
#020617,
#0f172a,
#111827);

overflow:hidden;

display:flex;

justify-content:center;

align-items:center;

padding:20px;

position:relative;
}

/* Background */

.shape{

position:absolute;

border-radius:50%;

background:
rgba(255,255,255,.04);

filter:blur(50px);

animation:float 8s infinite ease-in-out;
}

.shape1{

width:280px;
height:280px;

top:-100px;
left:-100px;
}

.shape2{

width:220px;
height:220px;

bottom:-80px;
right:-80px;
}

@keyframes float{

50%{
transform:
translateY(-20px);
}
}

/* Main Container */

.container{

width:1150px;

max-width:95vw;

height:90vh;

display:flex;

border-radius:30px;

overflow:hidden;

background:
rgba(255,255,255,.04);

backdrop-filter:blur(20px);

border:
1px solid rgba(
255,255,255,.08);

box-shadow:
0 25px 50px rgba(0,0,0,.4);

z-index:10;
}

/* Left Side */

.left{

flex:1;

padding:50px;

display:flex;

flex-direction:column;

justify-content:center;

overflow-y:auto;

color:white;
}

.logo{

width:80px;
height:80px;

border-radius:50%;

background:
linear-gradient(
135deg,
#38bdf8,
#2563eb);

display:flex;

align-items:center;
justify-content:center;

font-size:36px;

font-weight:700;
}

.left h1{

font-size:55px;

margin-top:20px;
}

.left p{

margin-top:15px;

font-size:16px;

line-height:1.8;

color:#94a3b8;
}

.features{

margin-top:35px;
}

.feature{

padding:18px;

margin-bottom:15px;

border-radius:16px;

background:
rgba(255,255,255,.05);

border:
1px solid rgba(
255,255,255,.08);

transition:.3s;
}

.feature:hover{

transform:
translateX(8px);

background:
rgba(255,255,255,.08);
}

/* Right Side */

.right{

width:430px;

padding:40px;

background:
rgba(255,255,255,.03);

border-left:
1px solid rgba(
255,255,255,.08);

display:flex;

flex-direction:column;

justify-content:center;

overflow-y:auto;
}

.form-title{

font-size:34px;

color:white;

text-align:center;
}

.subtitle{

text-align:center;

color:#94a3b8;

margin-top:10px;

margin-bottom:30px;
}

/* Inputs */

.input-group{

margin-bottom:18px;
}

.input-group input{

width:100%;

padding:16px;

border-radius:14px;

border:
1px solid rgba(
255,255,255,.08);

background:
rgba(255,255,255,.05);

color:white;

font-size:15px;

outline:none;
}

.input-group input::placeholder{

color:#cbd5e1;
}

.input-group input:focus{

border-color:#38bdf8;

box-shadow:
0 0 20px rgba(
56,189,248,.2);
}

/* Button */

.register-btn{

width:100%;

padding:16px;

border:none;

border-radius:14px;

background:
linear-gradient(
135deg,
#2563eb,
#1d4ed8);

color:white;

font-size:16px;

font-weight:600;

cursor:pointer;

transition:.3s;
}

.register-btn:hover{

transform:
translateY(-3px);

box-shadow:
0 15px 30px rgba(
37,99,235,.3);
}

/* Login */

.login-link{

margin-top:20px;

text-align:center;

color:#94a3b8;
}

.login-link a{

color:#38bdf8;

text-decoration:none;

font-weight:600;
}

/* Security */

.security{

margin-top:25px;

padding:15px;

border-radius:14px;

background:
rgba(16,185,129,.08);

border:
1px solid rgba(
16,185,129,.15);

color:#cbd5e1;

font-size:14px;

text-align:center;
}

/* Footer */

.footer{

margin-top:20px;

text-align:center;

color:#64748b;

font-size:13px;
}

/* Mobile */

@media(max-width:900px){

body{
padding:0;
}

.container{

width:100%;
height:100vh;

max-width:100%;

border-radius:0;

flex-direction:column;
}

.left{

padding:30px;

text-align:center;

align-items:center;
}

.right{

width:100%;

padding:30px;
}

.left h1{

font-size:40px;
}
}

</style>

</head>

<body>

<div class="shape shape1"></div>
<div class="shape shape2"></div>

<div class="container">

<!-- Left Section -->

<div class="left">

<div class="logo">
S
</div>

<h1>

SecurePAY

</h1>

<p>

Open your digital banking account in minutes.
SecurePAY provides secure transactions,
real-time account management and
enterprise-grade security.

</p>

<div class="features">

<div class="feature">
Instant Money Transfers
</div>

<div class="feature">
Banking Grade Security
</div>

<div class="feature">
24×7 Secure Access
</div>

<div class="feature">
Smart Financial Management
</div>

</div>

</div>

<!-- Right Section -->

<div class="right">

<h2 class="form-title">

Create Account

</h2>

<p class="subtitle">

Start your SecurePAY journey today

</p>

<form action="RegisterServlet"
method="post">

<div class="input-group">

<input
type="text"
name="name"
placeholder="Full Name"
required>

</div>

<div class="input-group">

<input
type="email"
name="email"
placeholder="Email Address"
required>

</div>

<div class="input-group">

<input
type="password"
name="password"
placeholder="Create Password"
required>

</div>

<button
type="submit"
class="register-btn">

Send OTP

</button>

</form>

<div class="login-link">

Already have an account?

<a href="Login.jsp">

Sign In

</a>

</div>

<div class="security">

SecurePAY uses enterprise-grade encryption
and security standards to protect your account.

</div>

<div class="footer">

© 2026 SecurePAY Digital Banking Platform

</div>

</div>

</div>

</body>
</html>

