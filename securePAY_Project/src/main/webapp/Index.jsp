
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>SecurePAY Digital Banking Platform</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    min-height:100vh;
    background:
    linear-gradient(
    135deg,
    #020617,
    #0f172a,
    #111827);

    overflow-x:hidden;
    color:white;
}

/* ================= NAVBAR ================= */

.navbar{

    position:fixed;

    top:0;
    left:0;

    width:100%;

    padding:22px 70px;

    display:flex;

    justify-content:space-between;

    align-items:center;

    background:
    rgba(255,255,255,.04);

    backdrop-filter:
    blur(20px);

    border-bottom:
    1px solid rgba(255,255,255,.08);

    z-index:1000;
}

.logo{

    font-size:30px;

    font-weight:800;

    color:#38bdf8;

    letter-spacing:1px;
}

.nav-links a{

    text-decoration:none;

    color:white;

    margin-left:30px;

    transition:.3s;
}

.nav-links a:hover{

    color:#38bdf8;
}

/* ================= BACKGROUND ================= */

.shape{

    position:absolute;

    border-radius:50%;

    background:
    rgba(255,255,255,.04);

    filter:blur(40px);

    animation:
    float 10s infinite;
}

.shape1{

    width:350px;
    height:350px;

    top:-120px;
    left:-120px;
}

.shape2{

    width:250px;
    height:250px;

    right:-80px;
    bottom:-80px;
}

@keyframes float{

    50%{

        transform:
        translateY(-30px);
    }
}

/* ================= HERO ================= */

.hero{

    width:1200px;

    max-width:95%;

    margin:auto;

    min-height:100vh;

    display:flex;

    align-items:center;

    justify-content:space-between;
}

/* Left */

.left{

    width:55%;
}

.tag{

    display:inline-block;

    padding:10px 20px;

    border-radius:50px;

    background:
    rgba(56,189,248,.1);

    color:#38bdf8;

    margin-bottom:25px;
}

.left h1{

    font-size:70px;

    line-height:1.1;
}

.left p{

    margin-top:25px;

    color:#94a3b8;

    font-size:18px;

    line-height:1.8;
}

/* Buttons */

.hero-buttons{

    margin-top:35px;

    display:flex;

    gap:20px;
}

.btn{

    text-decoration:none;

    padding:16px 30px;

    border-radius:15px;

    font-weight:600;

    transition:.3s;
}

.primary{

    background:
    linear-gradient(
    135deg,
    #2563eb,
    #1d4ed8);

    color:white;
}

.secondary{

    border:
    1px solid rgba(
    255,255,255,.15);

    color:white;
}

.btn:hover{

    transform:
    translateY(-4px);
}

/* ================= RIGHT ================= */

.right{

    width:40%;
}

/* Premium Card */

.bank-card{

    height:260px;

    padding:30px;

    border-radius:30px;

    background:
    linear-gradient(
    135deg,
    #000000,
    #111827);

    border:
    1px solid rgba(
    255,255,255,.08);

    box-shadow:
    0 25px 50px
    rgba(0,0,0,.5);

    animation:
    cardFloat 5s infinite;

    position:relative;
}

@keyframes cardFloat{

    50%{

        transform:
        translateY(-12px);
    }
}

.chip{

    width:60px;
    height:45px;

    background:gold;

    border-radius:10px;
}

.bank-card h3{

    margin-top:20px;
}

.bank-card p{

    margin-top:35px;

    letter-spacing:4px;

    font-size:20px;
}

.bank-card span{

    position:absolute;

    bottom:30px;
    right:30px;

    color:#94a3b8;
}

/* ================= STATS ================= */

.stats{

    width:1200px;

    max-width:95%;

    margin:auto;

    display:grid;

    grid-template-columns:
    repeat(3,1fr);

    gap:25px;

    margin-top:-80px;
}

.stat{

    padding:30px;

    border-radius:25px;

    background:
    rgba(255,255,255,.05);

    backdrop-filter:
    blur(20px);

    text-align:center;
}

.stat h2{

    font-size:40px;

    color:#38bdf8;
}

.stat p{

    margin-top:10px;

    color:#94a3b8;
}

/* ================= FEATURES ================= */

.features-section{

    width:1200px;

    max-width:95%;

    margin:100px auto;
}

.section-title{

    text-align:center;

    margin-bottom:50px;
}

.section-title h2{

    font-size:45px;
}

.section-title p{

    color:#94a3b8;

    margin-top:10px;
}

.grid{

    display:grid;

    grid-template-columns:
    repeat(2,1fr);

    gap:25px;
}

.feature{

    padding:30px;

    border-radius:25px;

    background:
    rgba(255,255,255,.05);

    backdrop-filter:
    blur(20px);

    transition:.3s;
}

.feature:hover{

    transform:
    translateY(-10px);
}

.feature h3{

    margin-bottom:15px;

    color:#38bdf8;
}

.feature p{

    color:#94a3b8;

    line-height:1.8;
}

/* ================= CTA ================= */

.cta{

    width:1200px;

    max-width:95%;

    margin:100px auto;

    padding:60px;

    border-radius:30px;

    background:
    linear-gradient(
    135deg,
    #2563eb,
    #06b6d4);

    text-align:center;
}

.cta h2{

    font-size:45px;
}

.cta p{

    margin-top:15px;
}

.cta-buttons{

    margin-top:30px;
}

/* ================= FOOTER ================= */

.footer{

    text-align:center;

    padding:40px;

    color:#64748b;

    border-top:
    1px solid rgba(
    255,255,255,.08);
}

/* ================= MOBILE ================= */

@media(max-width:900px){

    .navbar{
        padding:20px;
    }

    .hero{
        flex-direction:column;
        justify-content:center;
        padding-top:120px;
    }

    .left,
    .right{
        width:100%;
        text-align:center;
    }

    .left h1{
        font-size:50px;
    }

    .hero-buttons{
        justify-content:center;
    }

    .right{
        margin-top:50px;
    }

    .stats{
        grid-template-columns:1fr;
        margin-top:40px;
    }

    .grid{
        grid-template-columns:1fr;
    }

    .cta h2{
        font-size:32px;
    }
}

</style>

</head>

<body>

<div class="shape shape1"></div>
<div class="shape shape2"></div>

<!-- NAVBAR -->

<nav class="navbar">

    <div class="logo">
        SecurePAY
    </div>

    <div class="nav-links">

        <a href="Login.jsp">
            Login
        </a>

        <a href="Register.jsp">
            Register
        </a>

        <a href="AdminLogin.jsp">
            Admin
        </a>

    </div>

</nav>

<!-- HERO -->

<section class="hero">

    <div class="left">

        <div class="tag">
            Digital Banking Platform
        </div>

        <h1>

            Banking
            Reimagined
            For The
            Digital Era

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

               Get Started

            </a>

            <a href="AdminLogin.jsp"
               class="btn secondary">

               Admin Portal

            </a>

        </div>

    </div>

    <div class="right">

        <div class="bank-card">

            <div class="chip"></div>

            <h3>
                SecurePAY Platinum
            </h3>

            <p>
                **** **** **** 4589
            </p>

            <span>
                VALID THRU 12/30
            </span>

        </div>

    </div>

</section>

<!-- STATS -->

<section class="stats">

    <div class="stat">

        <h2>10K+</h2>

        <p>Customers</p>

    </div>

    <div class="stat">

        <h2>₹50Cr+</h2>

        <p>Transactions</p>

    </div>

    <div class="stat">

        <h2>99.9%</h2>

        <p>Uptime</p>

    </div>

</section>

<!-- FEATURES -->

<section class="features-section">

    <div class="section-title">

        <h2>
            Why Choose SecurePAY
        </h2>

        <p>
            Built for speed, security and reliability.
        </p>

    </div>

    <div class="grid">

        <div class="feature">

            <h3>
                Instant Transfers
            </h3>

            <p>
                Transfer funds instantly and securely
                between accounts.
            </p>

        </div>

        <div class="feature">

            <h3>
                Smart Analytics
            </h3>

            <p>
                Track transactions and financial
                activity in real time.
            </p>

        </div>

        <div class="feature">

            <h3>
                Advanced Security
            </h3>

            <p>
                Enterprise-grade protection with
                secure authentication.
            </p>

        </div>

        <div class="feature">

            <h3>
                Banking Dashboard
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
        Ready To Start Banking Smarter?
    </h2>

    <p>
        Create your SecurePAY account today.
    </p>

    <div class="cta-buttons">

        <a href="Register.jsp"
           class="btn secondary">

           Create Account

        </a>

    </div>

</section>

<!-- FOOTER -->

<div class="footer">

    © 2026 SecurePAY Digital Banking Platform

</div>

</body>
</html>

