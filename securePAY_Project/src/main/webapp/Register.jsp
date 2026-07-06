<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>SecurePAY | Create Account</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,500;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">

<style>

/* ============ Tokens (shared with dashboard / landing / login) ============ */
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

  --radius-lg:26px;
  --radius-md:14px;

  --shadow-card:0 1px 2px rgba(16,21,31,.04), 0 10px 28px rgba(16,21,31,.06);
  --shadow-pop:0 30px 70px rgba(13,17,25,.35);
}

*{margin:0;padding:0;box-sizing:border-box;}
body{
  font-family:'Inter',sans-serif;
  min-height:100vh;
  background:var(--bg);
  color:var(--ink);
  display:flex;
  justify-content:center;
  align-items:center;
  padding:28px;
  position:relative;
  -webkit-font-smoothing:antialiased;
}
.num,.mono{font-family:'IBM Plex Mono',monospace;}

/* Background */
.shape{
  position:absolute;
  border-radius:50%;
  filter:blur(60px);
  opacity:.55;
  animation:float 9s ease-in-out infinite;
  z-index:0;
}
.shape1{width:300px;height:300px;top:-100px;left:-100px;background:radial-gradient(circle,var(--accent-soft),transparent 70%);}
.shape2{width:240px;height:240px;bottom:-80px;right:-80px;background:radial-gradient(circle,var(--gold-soft),transparent 70%);}
@keyframes float{50%{transform:translateY(-22px);}}

/* Main Container */
.container{
  width:1150px;
  max-width:95vw;
  max-height:92vh;
  display:flex;
  border-radius:var(--radius-lg);
  overflow:hidden;
  background:var(--surface);
  border:1px solid var(--border);
  box-shadow:var(--shadow-pop);
  z-index:10;
}

/* Left Side */
.left{
  flex:1;
  padding:52px;
  display:flex;
  flex-direction:column;
  justify-content:center;
  overflow-y:auto;
  color:#EDEFF3;
  background:linear-gradient(160deg,#0D1119 0%,#1B2434 100%);
  position:relative;
}
.left::before{
  content:"";
  position:absolute;
  width:260px;height:260px;
  border-radius:50%;
  background:radial-gradient(circle,rgba(21,92,67,.35),transparent 70%);
  right:-90px;top:-90px;
}

.logo{
  width:52px;
  height:52px;
  border-radius:13px;
  background:var(--accent);
  display:flex;
  align-items:center;
  justify-content:center;
  position:relative;
}
.logo svg{width:26px;height:26px;stroke:#EAF3EE;fill:none;}

.left h1{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:44px;
  margin-top:26px;
  position:relative;
}

.left p{
  margin-top:16px;
  font-size:15px;
  line-height:1.75;
  color:#9BA6B5;
  max-width:440px;
  position:relative;
}

.features{
  margin-top:30px;
  display:flex;
  flex-direction:column;
  gap:10px;
  position:relative;
}

.feature{
  display:flex;
  align-items:center;
  gap:14px;
  padding:15px 16px;
  border-radius:14px;
  background:rgba(255,255,255,.03);
  border:1px solid rgba(255,255,255,.08);
  transition:.25s;
  font-size:14px;
  color:#DCE0E7;
  font-weight:500;
}
.feature .icon-dot{
  width:32px;height:32px;
  border-radius:9px;
  background:rgba(21,92,67,.35);
  display:flex;align-items:center;justify-content:center;
  flex-shrink:0;
}
.feature .icon-dot svg{width:16px;height:16px;stroke:#8FD4B2;fill:none;}
.feature:hover{
  transform:translateX(6px);
  background:rgba(255,255,255,.06);
  border-color:rgba(255,255,255,.14);
}

/* Right Side */
.right{
  width:430px;
  padding:44px 42px;
  background:var(--surface);
  border-left:1px solid var(--border);
  display:flex;
  flex-direction:column;
  justify-content:center;
  overflow-y:auto;
}

.form-title{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:30px;
  text-align:center;
  color:var(--ink);
}

.subtitle{
  text-align:center;
  color:var(--ink-faint);
  margin-top:8px;
  margin-bottom:28px;
  font-size:13.5px;
}

/* Inputs */
.input-group{margin-bottom:15px;}
.input-group label{
  display:block;
  font-size:12.5px;
  font-weight:600;
  color:var(--ink-soft);
  margin-bottom:6px;
}
.input-group input{
  width:100%;
  padding:14px 16px;
  border-radius:12px;
  border:1px solid var(--border);
  background:var(--bg);
  color:var(--ink);
  font-size:14px;
  font-family:'Inter',sans-serif;
  outline:none;
  transition:.15s;
}
.input-group input::placeholder{color:var(--ink-faint);}
.input-group input:focus{
  border-color:var(--accent);
  background:var(--surface);
  box-shadow:0 0 0 3px var(--accent-soft);
}

/* Button */
.register-btn{
  width:100%;
  padding:15px;
  border:none;
  border-radius:13px;
  background:var(--accent);
  color:#fff;
  font-size:14.5px;
  font-weight:600;
  cursor:pointer;
  transition:.2s;
  font-family:'Inter',sans-serif;
}
.register-btn:hover{
  background:var(--accent-dark);
  transform:translateY(-2px);
}

/* Login */
.login-link{
  margin-top:20px;
  text-align:center;
  color:var(--ink-faint);
  font-size:13.5px;
}
.login-link a{
  color:var(--accent-dark);
  text-decoration:none;
  font-weight:600;
}
.login-link a:hover{text-decoration:underline;}

/* Security */
.security{
  margin-top:24px;
  padding:14px 16px;
  border-radius:var(--radius-md);
  background:var(--accent-soft);
  border:1px solid #CDE4D9;
  color:var(--accent-dark);
  font-size:13px;
  text-align:center;
  line-height:1.6;
  display:flex;
  align-items:center;
  gap:10px;
}
.security svg{width:18px;height:18px;stroke:var(--accent-dark);fill:none;flex-shrink:0;}

/* Footer */
.footer{
  margin-top:20px;
  text-align:center;
  color:var(--ink-faint);
  font-size:12px;
}

/* Mobile */
@media(max-width:900px){
  body{padding:0;}
  .container{
    width:100%;
    height:100vh;
    max-width:100%;
    max-height:100vh;
    border-radius:0;
    flex-direction:column;
  }
  .left{padding:34px;text-align:center;align-items:center;}
  .left h1{font-size:34px;}
  .right{width:100%;padding:34px;border-left:none;border-top:1px solid var(--border);}
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
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="6" width="18" height="14" rx="2"></rect><circle cx="12" cy="13" r="2.4"></circle><path d="M7 6V5a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1"></path></svg>
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
<div class="icon-dot"><svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3l4 4-4 4M21 7H7M7 21l-4-4 4-4M3 17h14"></path></svg></div>
Instant money transfers
</div>

<div class="feature">
<div class="icon-dot"><svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="9" rx="2"></rect><path d="M8 11V7a4 4 0 0 1 8 0v4"></path></svg></div>
Banking grade security
</div>

<div class="feature">
<div class="icon-dot"><svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"></circle><path d="M12 7v5l3 3"></path></svg></div>
24×7 secure access
</div>

<div class="feature">
<div class="icon-dot"><svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M4 6h16M4 12h16M4 18h10"></path></svg></div>
Smart financial management
</div>

</div>

</div>

<!-- Right Section -->

<div class="right">

<h2 class="form-title">
Create account
</h2>

<p class="subtitle">
Start your SecurePAY journey today
</p>

<form action="RegisterServlet"
method="post">

<div class="input-group">
<label>Full name</label>
<input
type="text"
name="name"
placeholder="Enter your full name"
required>
</div>

<div class="input-group">
<label>Email address</label>
<input
type="email"
name="email"
placeholder="you@example.com"
required>
</div>

<div class="input-group">
<label>Password</label>
<input
type="password"
name="password"
placeholder="Create a password"
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

Sign in

</a>

</div>

<div class="security">
<svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="9" rx="2"></rect><path d="M8 11V7a4 4 0 0 1 8 0v4"></path></svg>
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
