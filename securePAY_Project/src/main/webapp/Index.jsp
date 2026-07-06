<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>SecurePAY Digital Banking Platform</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,500;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">

<style>

/* ============ Tokens (shared with dashboard) ============ */
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

  --sidebar-bg:#0D1119;

  --radius-lg:22px;
  --radius-md:14px;

  --shadow-card:0 1px 2px rgba(16,21,31,.04), 0 10px 28px rgba(16,21,31,.06);
}

*{margin:0;padding:0;box-sizing:border-box;}
body{
  font-family:'Inter',sans-serif;
  background:var(--bg);
  color:var(--ink);
  overflow-x:hidden;
  -webkit-font-smoothing:antialiased;
}
a{color:inherit;}
.num,.mono{font-family:'IBM Plex Mono',monospace;}

/* ================= NAVBAR ================= */
.navbar{
  position:fixed;
  top:0;left:0;
  width:100%;
  padding:20px 70px;
  display:flex;
  justify-content:space-between;
  align-items:center;
  background:rgba(245,246,248,.85);
  backdrop-filter:blur(16px);
  border-bottom:1px solid var(--border);
  z-index:1000;
}
.logo{
  display:flex;
  align-items:center;
  gap:12px;
}
.logo .mark{
  width:34px;height:34px;
  border-radius:9px;
  background:var(--accent);
  display:flex;align-items:center;justify-content:center;
  flex-shrink:0;
}
.logo .mark svg{width:18px;height:18px;stroke:#EAF3EE;fill:none;}
.logo .name{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:20px;
  letter-spacing:.2px;
  color:var(--ink);
}
.nav-links a{
  text-decoration:none;
  color:var(--ink-soft);
  margin-left:34px;
  font-size:14.5px;
  font-weight:500;
  transition:.2s;
}
.nav-links a:hover{color:var(--accent-dark);}
.nav-links a.admin{
  color:var(--ink);
  padding:9px 18px;
  border:1px solid var(--border);
  border-radius:10px;
  background:var(--surface);
  box-shadow:var(--shadow-card);
}
.nav-links a.admin:hover{border-color:var(--accent);}

/* ================= BACKGROUND ================= */
.shape{
  position:absolute;
  border-radius:50%;
  filter:blur(60px);
  opacity:.5;
  animation:float 11s ease-in-out infinite;
  z-index:0;
}
.shape1{width:380px;height:380px;top:-140px;left:-140px;background:radial-gradient(circle,var(--accent-soft),transparent 70%);}
.shape2{width:280px;height:280px;right:-90px;top:120px;background:radial-gradient(circle,var(--gold-soft),transparent 70%);}
@keyframes float{50%{transform:translateY(-26px);}}

/* ================= HERO ================= */
.hero{
  width:1200px;
  max-width:95%;
  margin:auto;
  min-height:100vh;
  display:flex;
  align-items:center;
  justify-content:space-between;
  position:relative;
  z-index:1;
  padding-top:100px;
}

.left{width:54%;}

.tag{
  display:inline-flex;
  align-items:center;
  gap:8px;
  padding:9px 18px;
  border-radius:50px;
  background:var(--accent-soft);
  color:var(--accent-dark);
  font-size:13px;
  font-weight:600;
  margin-bottom:26px;
}
.tag .dot{width:6px;height:6px;border-radius:50%;background:var(--accent);}

.left h1{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:62px;
  line-height:1.12;
  letter-spacing:-.5px;
}
.left h1 em{
  font-style:italic;
  color:var(--accent-dark);
}

.left p{
  margin-top:24px;
  color:var(--ink-soft);
  font-size:17px;
  line-height:1.75;
  max-width:520px;
}

.hero-buttons{
  margin-top:34px;
  display:flex;
  gap:16px;
}
.btn{
  text-decoration:none;
  padding:15px 28px;
  border-radius:13px;
  font-weight:600;
  font-size:14.5px;
  transition:.2s;
  display:inline-block;
}
.primary{background:var(--accent);color:#fff;}
.primary:hover{background:var(--accent-dark);transform:translateY(-2px);}
.secondary{
  border:1px solid var(--border);
  color:var(--ink);
  background:var(--surface);
  box-shadow:var(--shadow-card);
}
.secondary:hover{border-color:var(--accent);color:var(--accent-dark);transform:translateY(-2px);}

/* ================= RIGHT / CARD ================= */
.right{width:38%;}

.bank-card{
  height:250px;
  padding:30px;
  border-radius:var(--radius-lg);
  background:linear-gradient(160deg,#0D1119 0%,#1B2434 100%);
  border:1px solid rgba(255,255,255,.06);
  box-shadow:0 25px 60px rgba(13,17,25,.35);
  animation:cardFloat 6s ease-in-out infinite;
  position:relative;
  color:#EDEFF3;
  overflow:hidden;
}
.bank-card::before{
  content:"";
  position:absolute;
  width:42px;height:42px;
  border:1.5px solid rgba(255,255,255,.35);
  border-radius:50%;
  top:30px;left:30px;
}
.bank-card::after{
  content:"";
  position:absolute;
  width:26px;height:26px;
  border:1.5px solid rgba(255,255,255,.25);
  border-radius:50%;
  top:40px;left:40px;
}
@keyframes cardFloat{50%{transform:translateY(-14px);}}

.visa{
  position:absolute;
  right:30px;top:28px;
  font-size:15px;
  font-weight:700;
  letter-spacing:2px;
}
.bank-card h3{font-family:'Fraunces',serif;font-size:19px;font-weight:600;margin-top:34px;}
.bank-card p{font-family:'IBM Plex Mono',monospace;margin-top:34px;letter-spacing:3px;font-size:19px;color:#C9CEDA;}
.bank-card span{
  position:absolute;
  bottom:28px;right:30px;
  color:#8A93A3;
  font-size:11.5px;
  letter-spacing:1px;
  text-transform:uppercase;
}

/* ================= STATS ================= */
.stats{
  width:1200px;
  max-width:95%;
  margin:auto;
  display:grid;
  grid-template-columns:repeat(3,1fr);
  gap:20px;
  margin-top:-70px;
  position:relative;
  z-index:1;
}
.stat{
  padding:30px;
  border-radius:var(--radius-lg);
  background:var(--surface);
  border:1px solid var(--border);
  box-shadow:var(--shadow-card);
  text-align:center;
}
.stat h2{
  font-family:'Fraunces',serif;
  font-size:38px;
  font-weight:600;
  color:var(--accent-dark);
}
.stat p{
  margin-top:8px;
  color:var(--ink-faint);
  font-size:13.5px;
  text-transform:uppercase;
  letter-spacing:1px;
  font-weight:600;
}

/* ================= FEATURES ================= */
.features-section{
  width:1200px;
  max-width:95%;
  margin:120px auto;
  position:relative;
  z-index:1;
}
.section-title{text-align:center;margin-bottom:54px;}
.section-title p.eyebrow{
  font-size:12.5px;
  letter-spacing:1.5px;
  text-transform:uppercase;
  color:var(--accent-dark);
  font-weight:700;
  margin-bottom:12px;
}
.section-title h2{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:38px;
}
.section-title p.sub{
  color:var(--ink-faint);
  margin-top:12px;
  font-size:15px;
}

.grid{
  display:grid;
  grid-template-columns:repeat(2,1fr);
  gap:20px;
}
.feature{
  padding:30px;
  border-radius:var(--radius-lg);
  background:var(--surface);
  border:1px solid var(--border);
  box-shadow:var(--shadow-card);
  transition:.2s;
}
.feature:hover{transform:translateY(-6px);border-color:var(--accent);}
.feature .icon{
  width:46px;height:46px;
  border-radius:12px;
  background:var(--accent-soft);
  display:flex;align-items:center;justify-content:center;
  margin-bottom:18px;
}
.feature .icon svg{width:22px;height:22px;stroke:var(--accent-dark);fill:none;}
.feature h3{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:19px;
  margin-bottom:10px;
}
.feature p{color:var(--ink-soft);line-height:1.7;font-size:14px;}

/* ================= CTA ================= */
.cta{
  width:1200px;
  max-width:95%;
  margin:120px auto;
  padding:60px;
  border-radius:var(--radius-lg);
  background:linear-gradient(160deg,#0D1119 0%,#1B2434 100%);
  text-align:center;
  position:relative;
  overflow:hidden;
  z-index:1;
}
.cta::before{
  content:"";
  position:absolute;
  width:300px;height:300px;
  border-radius:50%;
  background:radial-gradient(circle,rgba(21,92,67,.35),transparent 70%);
  right:-80px;top:-100px;
}
.cta h2{
  font-family:'Fraunces',serif;
  font-weight:600;
  font-size:38px;
  color:#F4F6F8;
  position:relative;
}
.cta p{
  margin-top:14px;
  color:#9BA6B5;
  position:relative;
  font-size:15px;
}
.cta-buttons{margin-top:30px;position:relative;}
.cta .secondary{background:#F4F6F8;}

/* ================= FOOTER ================= */
.footer{
  text-align:center;
  padding:40px;
  color:var(--ink-faint);
  border-top:1px solid var(--border);
  font-size:13px;
  position:relative;
  z-index:1;
}

/* ================= MOBILE ================= */
@media(max-width:900px){
  .navbar{padding:18px 22px;}
  .hero{flex-direction:column;justify-content:center;padding-top:130px;}
  .left,.right{width:100%;text-align:center;}
  .left p{margin-left:auto;margin-right:auto;}
  .left h1{font-size:42px;}
  .hero-buttons{justify-content:center;}
  .right{margin-top:44px;}
  .stats{grid-template-columns:1fr;margin-top:36px;}
  .grid{grid-template-columns:1fr;}
  .cta h2{font-size:28px;}
  .cta{padding:40px 26px;}
}

</style>

</head>

<body>

<div class="shape shape1"></div>
<div class="shape shape2"></div>

<!-- NAVBAR -->

<nav class="navbar">

    <div class="logo">
        <div class="mark">
            <svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="6" width="18" height="14" rx="2"></rect><circle cx="12" cy="13" r="2.4"></circle><path d="M7 6V5a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1"></path></svg>
        </div>
        <div class="name">SecurePAY</div>
    </div>

    <div class="nav-links">

        <a href="Login.jsp">
            Login
        </a>

        <a href="Register.jsp">
            Register
        </a>

        <a href="AdminLogin.jsp" class="admin">
            Admin
        </a>

    </div>

</nav>

<!-- HERO -->

<section class="hero">

    <div class="left">

        <div class="tag">
            <span class="dot"></span>
            Digital Banking Platform
        </div>

        <h1>
            Banking, reimagined<br>
            for the <em>digital era</em>
        </h1>

        <p>
            SecurePAY helps individuals manage
            payments, transfers and finances with
            enterprise-grade security, real-time
            transactions and a modern banking experience.
        </p>

        <div class="hero-buttons">

            <a href="Register.jsp"
               class="btn primary">

               Get started

            </a>

            <a href="AdminLogin.jsp"
               class="btn secondary">

               Admin portal

            </a>

        </div>

    </div>

    <div class="right">

        <div class="bank-card">

            <div class="visa">VISA</div>

            <h3>
                SecurePAY Platinum
            </h3>

            <p>
                **** **** **** 4589
            </p>

            <span>
                Valid thru 12/30
            </span>

        </div>

    </div>

</section>

<!-- STATS -->

<section class="stats">

    <div class="stat">

        <h2 class="num">10K+</h2>

        <p>Customers</p>

    </div>

    <div class="stat">

        <h2 class="num">₹50Cr+</h2>

        <p>Transactions</p>

    </div>

    <div class="stat">

        <h2 class="num">99.9%</h2>

        <p>Uptime</p>

    </div>

</section>

<!-- FEATURES -->

<section class="features-section">

    <div class="section-title">

        <p class="eyebrow">Platform</p>

        <h2>
            Why choose SecurePAY
        </h2>

        <p class="sub">
            Built for speed, security and reliability.
        </p>

    </div>

    <div class="grid">

        <div class="feature">
            <div class="icon">
                <svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3l4 4-4 4M21 7H7M7 21l-4-4 4-4M3 17h14"></path></svg>
            </div>
            <h3>
                Instant transfers
            </h3>

            <p>
                Transfer funds instantly and securely
                between accounts.
            </p>

        </div>

        <div class="feature">
            <div class="icon">
                <svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M4 6h16M4 12h16M4 18h10"></path></svg>
            </div>
            <h3>
                Smart analytics
            </h3>

            <p>
                Track transactions and financial
                activity in real time.
            </p>

        </div>

        <div class="feature">
            <div class="icon">
                <svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="9" rx="2"></rect><path d="M8 11V7a4 4 0 0 1 8 0v4"></path></svg>
            </div>
            <h3>
                Advanced security
            </h3>

            <p>
                Enterprise-grade protection with
                secure authentication.
            </p>

        </div>

        <div class="feature">
            <div class="icon">
                <svg viewBox="0 0 24 24" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M3 11l9-8 9 8"></path><path d="M5 10v10h14V10"></path></svg>
            </div>
            <h3>
                Banking dashboard
            </h3>

            <p>
                Access balances, statements and
                account information instantly.
            </p>

        </div>

    </div>

</section>

<!-- CTA -->

<section class="cta">

    <h2>
        Ready to start banking smarter?
    </h2>

    <p>
        Create your SecurePAY account today.
    </p>

    <div class="cta-buttons">

        <a href="Register.jsp"
           class="btn secondary">

           Create account

        </a>

    </div>

</section>

<!-- FOOTER -->

<div class="footer">

    © 2026 SecurePAY Digital Banking Platform

</div>

</body>
</html>
