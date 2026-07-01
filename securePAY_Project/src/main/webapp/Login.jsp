<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SecurePAY Premium Login V2</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif}
body{
min-height:100vh;
display:flex;
justify-content:center;
align-items:center;
padding:20px;
background:linear-gradient(135deg,#020617,#0f172a,#1e3a8a,#2563eb);
overflow:hidden;
}
.container{
width:100%;
max-width:1200px;
display:flex;
background:rgba(255,255,255,.06);
backdrop-filter:blur(20px);
border-radius:30px;
overflow:hidden;
box-shadow:0 20px 60px rgba(0,0,0,.5);
}
.left{flex:1;padding:50px;color:#fff}
.logo{font-size:42px;font-weight:700}
.heading{font-size:58px;line-height:1.1;margin-top:20px}
.heading span{color:#38bdf8}
.desc{margin-top:15px;color:#cbd5e1}
.feature{margin-top:15px}
.card-wrapper{width:360px;height:220px;margin-top:35px;perspective:1000px}
.card-inner{width:100%;height:100%;position:relative;transform-style:preserve-3d;transition:1s}
.card-wrapper:hover .card-inner{transform:rotateY(180deg)}
.card-front,.card-back{position:absolute;width:100%;height:100%;border-radius:25px;backface-visibility:hidden}
.card-front{background:linear-gradient(135deg,#0047ff,#001d5c);padding:25px;color:white}
.card-back{background:linear-gradient(135deg,#111827,#1e293b);transform:rotateY(180deg)}
.chip{width:55px;height:40px;background:gold;border-radius:8px}
.visa{position:absolute;right:25px;top:20px;font-size:32px;font-weight:700}
.number{margin-top:40px;font-size:24px;letter-spacing:3px}
.name{position:absolute;left:25px;bottom:20px}
.strip{height:50px;background:black;margin-top:20px}
.cvv{margin:20px;background:white;color:black;padding:10px;border-radius:6px;text-align:right}
.right{width:430px;padding:40px;background:rgba(0,0,0,.15)}
.title{text-align:center;color:white;font-size:34px}
.sub{text-align:center;color:#cbd5e1;margin-bottom:20px}
.security{padding:12px;background:rgba(37,99,235,.15);color:white;border-radius:12px;text-align:center;margin-bottom:20px}
.input-box{margin-bottom:15px}
.input-box input{
width:100%;padding:16px;border-radius:14px;border:1px solid rgba(255,255,255,.15);
background:rgba(255,255,255,.05);color:white;outline:none;
}
.input-box input:focus{border-color:#38bdf8;box-shadow:0 0 20px rgba(56,189,248,.25)}
.options{display:flex;justify-content:space-between;color:white;font-size:14px;margin-bottom:20px}
.options a{color:#60a5fa;text-decoration:none}

.login-btn,.register-btn,.admin-btn{
position:relative;overflow:hidden;transition:.35s ease;font-weight:600
}
.login-btn{
width:100%;padding:16px;border:none;border-radius:14px;
background:linear-gradient(135deg,#38bdf8,#2563eb);color:white;cursor:pointer;
}
.login-btn:hover,.register-btn:hover,.admin-btn:hover{
transform:translateY(-4px);
}
.login-btn:hover{box-shadow:0 12px 30px rgba(56,189,248,.45)}
.register-btn:hover{box-shadow:0 12px 30px rgba(6,182,212,.45)}
.admin-btn:hover{box-shadow:0 12px 30px rgba(147,51,234,.45)}
.login-btn:before,.register-btn:before,.admin-btn:before{
content:'';position:absolute;top:0;left:-120%;width:60%;height:100%;
background:linear-gradient(90deg,transparent,rgba(255,255,255,.3),transparent);
transition:.7s;
}
.login-btn:hover:before,.register-btn:hover:before,.admin-btn:hover:before{left:140%}

.action-buttons{display:flex;gap:10px;margin-top:15px}
.register-btn,.admin-btn{
flex:1;padding:14px;border-radius:14px;text-decoration:none;color:white;text-align:center;
}
.register-btn{background:linear-gradient(135deg,#06b6d4,#0891b2)}
.admin-btn{background:linear-gradient(135deg,#9333ea,#7e22ce)}
.footer{text-align:center;color:#94a3b8;margin-top:20px;font-size:13px}

@media(max-width:1000px){
.container{flex-direction:column}
.right{width:100%}
.left{text-align:center}
.card-wrapper{margin:30px auto 0}
.heading{font-size:42px}
}
</style>

<script>
function togglePassword(){
let p=document.getElementById("password");
p.type=p.type==="password"?"text":"password";
}
</script>
</head>
<body>

<div class="container">
<div class="left">
<div class="logo">🛡 SecurePAY</div>
<div class="heading">Bank Smarter.<br><span>Live Better.</span></div>
<div class="desc">Secure, fast and modern digital banking.</div>

<div class="feature">💸 Instant Money Transfer</div>
<div class="feature">🔒 Advanced Security</div>
<div class="feature">📊 Spending Analytics</div>
<div class="feature">⚡ Real-Time Transactions</div>

<div class="card-wrapper">
<div class="card-inner">
<div class="card-front">
<div class="visa">VISA</div>
<div class="chip"></div>
<div class="number">4589 1234 5678 9012</div>
<div class="name">SECUREPAY USER</div>
</div>
<div class="card-back">
<div class="strip"></div>
<div class="cvv">123</div>
</div>
</div>
</div>
</div>

<div class="right">
<h2 class="title">Welcome Back</h2>
<p class="sub">Sign in to your SecurePAY account</p>

<%
String error=(String)request.getAttribute("error");
if(error!=null){
%>
<div style="background:#dc2626;color:white;padding:12px;border-radius:12px;margin-bottom:15px;">
<%= error %>
</div>
<% } %>

<div class="security">🔐 Protected by 256-bit SSL Encryption</div>

<form action="LoginServlet" method="post">
<div class="input-box">
<input type="email" name="email" placeholder="Email Address" required>
</div>

<div class="input-box">
<input type="password" id="password" name="password" placeholder="Password" required>
</div>

<div class="options">
<label><input type="checkbox"> Remember Me</label>
<a href="ForgotPassword.jsp">Forgot Password?</a>
</div>

<button type="submit" class="login-btn">Login Securely</button>
</form>

<div class="action-buttons">
<a href="Register.jsp" class="register-btn">Register</a>
<a href="AdminLogin.jsp" class="admin-btn">Admin Login</a>
</div>

<div class="footer">© 2026 SecurePAY Digital Banking System</div>
</div>
</div>
</body>
</html>
