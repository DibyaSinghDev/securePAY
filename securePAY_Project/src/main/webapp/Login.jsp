<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SecurePAY | Login</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,500;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">

<style>

/* ============ Tokens (shared with dashboard / landing) ============ */
:root{
  --bg:#F5F6F8;
  --surface:#FFFFFF;
  --ink:#101521;
  --ink-soft:#59616F;
  --ink-faint:#94A0AF;
  --border:#E4E7EC;
  --border-soft:#EEF0F3;

  --accent:#155C43;
  --accent-dark:#0D4432;
  --accent-soft:#E5F1EC;

  --gold:#96792F;
  --gold-soft:#F5EEDE;

  --danger:#B3261E;
  --danger-soft:#FBEAEA;

  --radius-lg:26px;
  --radius-md:14px;

  --shadow-card:0 1px 2px rgba(16,21,31,.04), 0 10px 28px rgba(16,21,31,.06);
  --shadow-pop:0 30px 70px rgba(13,17,25,.35);
}

*{margin:0;padding:0;box-sizing:border-box;}
body{
  font-family:'Inter',sans-serif;
  min-height:100vh;
  display:flex;
  justify-content:center;
  align-items:center;
  padding:28px;
  background:var(--bg);
  color:var(--ink);
  -webkit-font-smoothing:antialiased;
}
.num,.mono{font-family:'IBM Plex Mono',monospace;}

.container{
  width:100%;
  max-width:1080px;
  display:flex;
  background:var(--surface);
  border-radius:var(--radius-lg);
  overflow:hidden;
  border:1px solid var(--border);
  box-shadow:var(--shadow-pop);
}

/* ================= LEFT (brand panel) ================= */
.left{
  flex:1;
  padding:54px;
  color:#EDEFF3;
  background:linear-gradient(160deg,#0D1119 0%,#1B2434 100%);
  position:relative;
  overflow:hidden;
}
.left::before{
  content:"";
  position:absolute;
  width:280px;height:280px;
  border-radius:50%;
  background:radial-gradient(circle,rgba(21,92,67,.35),transparent 70%);
  right:-100px;top:-100px;
}

.logo{
  display:flex;
  align-items:center;
  gap:12px;
  position:relative;
}
.logo .mark{
  width:38px;height:38px;
  border-radius:10px;
  background:var(--accent);
  display:flex;align-items:center;justify-content:center;
  flex-shrink:0;
}
.logo .mark svg{width:20px;height:20px;stroke:#EAF3EE;fill:none;}
.logo .name{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:22px;
  letter-spacing:.2px;
}

.heading{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:46px;
  line-height:1.15;
  margin-top:34px;
  position:relative;
}
.heading em{font-style:italic;color:#7FC9A9;}

.desc{
  margin-top:16px;
  color:#9BA6B5;
  font-size:15px;
  position:relative;
}

.feature-list{
  margin-top:28px;
  display:flex;
  flex-direction:column;
  gap:12px;
  position:relative;
}
.feature{
  display:flex;
  align-items:center;
  gap:12px;
  font-size:14px;
  color:#C7CCD6;
}
.feature .icon-dot{
  width:30px;height:30px;
  border-radius:9px;
  background:rgba(21,92,67,.35);
  display:flex;align-items:center;justify-content:center;
  flex-shrink:0;
}
.feature .icon-dot svg{width:15px;height:15px;stroke:#8FD4B2;fill:none;}

.card-wrapper{
  width:340px;
  height:206px;
  margin-top:36px;
  perspective:1200px;
  position:relative;
}
.card-inner{
  width:100%;height:100%;
  position:relative;
  transform-style:preserve-3d;
  transition:1s;
}
.card-wrapper:hover .card-inner{transform:rotateY(180deg);}
.card-front,.card-back{
  position:absolute;
  width:100%;height:100%;
  border-radius:20px;
  backface-visibility:hidden;
  border:1px solid rgba(255,255,255,.08);
}
.card-front{
  background:linear-gradient(160deg,#12182A 0%,#222D42 100%);
  padding:24px;
  color:#EDEFF3;
}
.card-front::before{
  content:"";
  position:absolute;
  width:34px;height:34px;
  border:1.5px solid rgba(255,255,255,.3);
  border-radius:50%;
  top:22px;left:22px;
}
.card-back{
  background:linear-gradient(160deg,#0D1119 0%,#1B2434 100%);
  transform:rotateY(180deg);
}
.visa{position:absolute;right:24px;top:22px;font-size:14px;font-weight:700;letter-spacing:2px;}
.number{margin-top:56px;font-family:'IBM Plex Mono',monospace;font-size:18px;letter-spacing:3px;}
.name{position:absolute;left:24px;bottom:20px;font-size:12px;letter-spacing:1px;color:#9BA6B5;text-transform:uppercase;}
.strip{height:44px;background:#05070C;margin-top:26px;}
.cvv{margin:22px;background:#EDEFF3;color:var(--ink);padding:10px 14px;border-radius:8px;text-align:right;font-family:'IBM Plex Mono',monospace;font-size:13px;}

/* ================= RIGHT (form panel) ================= */
.right{
  width:420px;
  padding:52px 46px;
  flex-shrink:0;
}
.title{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:30px;
  color:var(--ink);
}
.sub{
  color:var(--ink-faint);
  font-size:13.5px;
  margin-top:6px;
  margin-bottom:26px;
}

.error-box{
  background:var(--danger-soft);
  color:var(--danger);
  border:1px solid #F0C9C6;
  padding:13px 16px;
  border-radius:var(--radius-md);
  margin-bottom:18px;
  font-size:13.5px;
  font-weight:500;
}

.security{
  padding:12px 16px;
  background:var(--accent-soft);
  color:var(--accent-dark);
  border:1px solid #CDE4D9;
  border-radius:var(--radius-md);
  text-align:center;
  margin-bottom:22px;
  font-size:13px;
  font-weight:600;
  display:flex;
  align-items:center;
  justify-content:center;
  gap:8px;
}
.security svg{width:15px;height:15px;stroke:var(--accent-dark);fill:none;flex-shrink:0;}

.input-box{margin-bottom:14px;}
.input-box label{
  display:block;
  font-size:12.5px;
  font-weight:600;
  color:var(--ink-soft);
  margin-bottom:6px;
}
.input-box input{
  width:100%;
  padding:14px 16px;
  border-radius:12px;
  border:1px solid var(--border);
  background:var(--bg);
  color:var(--ink);
  outline:none;
  font-size:14px;
  font-family:'Inter',sans-serif;
  transition:.15s;
}
.input-box input::placeholder{color:var(--ink-faint);}
.input-box input:focus{
  border-color:var(--accent);
  background:var(--surface);
  box-shadow:0 0 0 3px var(--accent-soft);
}

.options{
  display:flex;
  justify-content:space-between;
  align-items:center;
  color:var(--ink-soft);
  font-size:13px;
  margin-bottom:22px;
}
.options label{display:flex;align-items:center;gap:7px;}
.options input[type="checkbox"]{accent-color:var(--accent);width:15px;height:15px;}
.options a{color:var(--accent-dark);text-decoration:none;font-weight:600;}
.options a:hover{text-decoration:underline;}

.login-btn,.register-btn,.admin-btn{
  position:relative;
  overflow:hidden;
  transition:.25s ease;
  font-weight:600;
  font-family:'Inter',sans-serif;
}
.login-btn{
  width:100%;
  padding:15px;
  border:none;
  border-radius:13px;
  background:var(--accent);
  color:#fff;
  cursor:pointer;
  font-size:14.5px;
}
.login-btn:hover{background:var(--accent-dark);transform:translateY(-2px);}

.action-buttons{display:flex;gap:10px;margin-top:16px;}
.register-btn,.admin-btn{
  flex:1;
  padding:13px;
  border-radius:12px;
  text-decoration:none;
  text-align:center;
  font-size:13.5px;
}
.register-btn{
  background:var(--surface);
  color:var(--ink);
  border:1px solid var(--border);
}
.register-btn:hover{border-color:var(--accent);color:var(--accent-dark);}
.admin-btn{
  background:var(--ink);
  color:#F4F6F8;
}
.admin-btn:hover{background:#262C39;}
.register-btn:hover,.admin-btn:hover{transform:translateY(-2px);}

.footer{
  text-align:center;
  color:var(--ink-faint);
  margin-top:24px;
  font-size:12px;
}

@media(max-width:1000px){
  .container{flex-direction:column;}
  .right{width:100%;}
  .left{text-align:center;}
  .logo{justify-content:center;}
  .feature-list{align-items:center;}
  .card-wrapper{margin:32px auto 0;}
  .heading{font-size:34px;}
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

<div class="logo">
<div class="mark">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="6" width="18" height="14" rx="2"></rect><circle cx="12" cy="13" r="2.4"></circle><path d="M7 6V5a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1"></path></svg>
</div>
<div class="name">SecurePAY</div>
</div>

<div class="heading">Bank smarter.<br><em>Live better.</em></div>
<div class="desc">Secure, fast and modern digital banking.</div>

<div class="feature-list">
<div class="feature">
<div class="icon-dot"><svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3l4 4-4 4M21 7H7M7 21l-4-4 4-4M3 17h14"></path></svg></div>
Instant money transfer
</div>
<div class="feature">
<div class="icon-dot"><svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="9" rx="2"></rect><path d="M8 11V7a4 4 0 0 1 8 0v4"></path></svg></div>
Advanced security
</div>
<div class="feature">
<div class="icon-dot"><svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M4 6h16M4 12h16M4 18h10"></path></svg></div>
Spending analytics
</div>
<div class="feature">
<div class="icon-dot"><svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2 4 14h6l-1 8 9-12h-6l1-8Z"></path></svg></div>
Real-time transactions
</div>
</div>

<div class="card-wrapper">
<div class="card-inner">
<div class="card-front">
<div class="visa">VISA</div>
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
<h2 class="title">Welcome back</h2>
<p class="sub">Sign in to your SecurePAY account</p>

<%
String error=(String)request.getAttribute("error");
if(error!=null){
%>
<div class="error-box">
<%= error %>
</div>
<% } %>

<div class="security">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="9" rx="2"></rect><path d="M8 11V7a4 4 0 0 1 8 0v4"></path></svg>
Protected by 256-bit SSL encryption
</div>

<form action="LoginServlet" method="post">
<div class="input-box">
<label>Email address</label>
<input type="email" name="email" placeholder="you@example.com" required>
</div>

<div class="input-box">
<label>Password</label>
<input type="password" id="password" name="password" placeholder="Enter your password" required>
</div>

<div class="options">
<label><input type="checkbox"> Remember me</label>
<a href="ForgotPassword.jsp">Forgot password?</a>
</div>

<button type="submit" class="login-btn">Login securely</button>
</form>

<div class="action-buttons">
<a href="Register.jsp" class="register-btn">Register</a>
<a href="AdminLogin.jsp" class="admin-btn">Admin login</a>
</div>

<div class="footer">© 2026 SecurePAY Digital Banking System</div>
</div>
</div>
</body>
</html>
