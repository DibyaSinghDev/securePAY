<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>ExamShield AI</title>

    <link rel="stylesheet" href="css/style.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>

        .hero{
            min-height:100vh;
            display:flex;
            align-items:center;
            background:linear-gradient(
                    135deg,
                    #2563eb,
                    #1e3a8a
            );
            color:white;
        }

        .hero h1{
            font-size:60px;
            font-weight:800;
        }

        .hero p{
            font-size:20px;
            margin-top:20px;
            margin-bottom:30px;
        }

        .hero-img{
            text-align:center;
        }

        .hero-img i{
            font-size:250px;
            opacity:.9;
        }

        .feature-card{
            background:white;
            border-radius:20px;
            padding:30px;
            text-align:center;
            box-shadow:0 8px 25px rgba(0,0,0,.08);
            transition:.3s;
            height:100%;
        }

        .feature-card:hover{
            transform:translateY(-10px);
        }

        .feature-card i{
            font-size:50px;
            color:#2563eb;
            margin-bottom:15px;
        }

        .section-title{
            text-align:center;
            margin-bottom:50px;
        }

        .section-title h2{
            font-weight:700;
        }

        .stats{
            background:#1e293b;
            color:white;
            padding:80px 0;
        }

        .stat-box{
            text-align:center;
        }

        .stat-box h1{
            font-size:50px;
            font-weight:700;
        }

        .cta{
            background:#2563eb;
            color:white;
            padding:80px 0;
            text-align:center;
        }

        .navbar-home{
            position:fixed;
            width:100%;
            top:0;
            z-index:999;
            background:white;
            box-shadow:0 2px 10px rgba(0,0,0,.1);
        }

    </style>

</head>
<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg navbar-light navbar-home">

    <div class="container">

        <a class="navbar-brand fw-bold fs-3 text-primary"
           href="#">
            ExamShield AI
        </a>

        <button class="navbar-toggler"
                data-bs-toggle="collapse"
                data-bs-target="#menu">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse"
             id="menu">

            <ul class="navbar-nav ms-auto">

                <li class="nav-item">
                    <a class="nav-link" href="#features">
                        Features
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#about">
                        About
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#contact">
                        Contact
                    </a>
                </li>

            </ul>

            <a href="login.jsp"
               class="btn btn-primary ms-3">
                Login
            </a>

        </div>

    </div>

</nav>

<!-- HERO -->

<section class="hero">

    <div class="container">

        <div class="row align-items-center">

            <div class="col-lg-6">

                <h1>
                    Smart Online Exam
                    Proctoring Platform
                </h1>

                <p>
                    AI Powered Examination System
                    with Face Detection,
                    Tab Monitoring,
                    Live Proctoring,
                    and Secure Assessment.
                </p>

                <a href="register.jsp"
                   class="btn btn-light btn-lg me-3">
                    Get Started
                </a>

                <a href="login.jsp"
                   class="btn btn-outline-light btn-lg">
                    Login
                </a>

            </div>

            <div class="col-lg-6 hero-img">

                <i class="fa-solid fa-user-graduate"></i>

            </div>

        </div>

    </div>

</section>

<!-- FEATURES -->

<section id="features"
         class="py-5">

    <div class="container">

        <div class="section-title">

            <h2>
                Powerful Features
            </h2>

            <p>
                Everything needed for secure
                online examinations.
            </p>

        </div>

        <div class="row g-4">

            <div class="col-md-4">

                <div class="feature-card">

                    <i class="fa-solid fa-camera"></i>

                    <h4>
                        Face Detection
                    </h4>

                    <p>
                        Monitor candidate presence
                        continuously during exams.
                    </p>

                </div>

            </div>

            <div class="col-md-4">

                <div class="feature-card">

                    <i class="fa-solid fa-eye"></i>

                    <h4>
                        Live Monitoring
                    </h4>

                    <p>
                        Real-time proctor dashboard
                        with alerts and analytics.
                    </p>

                </div>

            </div>

            <div class="col-md-4">

                <div class="feature-card">

                    <i class="fa-solid fa-shield-halved"></i>

                    <h4>
                        Anti-Cheating
                    </h4>

                    <p>
                        Detect tab switching,
                        fullscreen exit and violations.
                    </p>

                </div>

            </div>

            <div class="col-md-4">

                <div class="feature-card">

                    <i class="fa-solid fa-clock"></i>

                    <h4>
                        Smart Timer
                    </h4>

                    <p>
                        Auto submission after
                        exam duration ends.
                    </p>

                </div>

            </div>

            <div class="col-md-4">

                <div class="feature-card">

                    <i class="fa-solid fa-chart-line"></i>

                    <h4>
                        Analytics
                    </h4>

                    <p>
                        Detailed reports and
                        performance insights.
                    </p>

                </div>

            </div>

            <div class="col-md-4">

                <div class="feature-card">

                    <i class="fa-solid fa-file-pdf"></i>

                    <h4>
                        PDF Reports
                    </h4>

                    <p>
                        Download result reports
                        and violation reports.
                    </p>

                </div>

            </div>

        </div>

    </div>

</section>

<!-- ABOUT -->

<section id="about"
         class="py-5 bg-light">

    <div class="container">

        <div class="row align-items-center">

            <div class="col-lg-6">

                <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f"
                     class="img-fluid rounded shadow">

            </div>

            <div class="col-lg-6">

                <h2 class="fw-bold">
                    About ExamShield AI
                </h2>

                <p class="mt-3">

                    ExamShield AI is an advanced
                    online examination platform
                    designed to provide secure,
                    scalable and intelligent
                    remote assessments.

                </p>

                <p>

                    It combines modern web
                    technologies with AI-powered
                    monitoring features to
                    maintain exam integrity.

                </p>

            </div>

        </div>

    </div>

</section>

<!-- STATS -->

<section class="stats">

    <div class="container">

        <div class="row">

            <div class="col-md-3 stat-box">

                <h1>5000+</h1>

                <p>Students</p>

            </div>

            <div class="col-md-3 stat-box">

                <h1>500+</h1>

                <p>Exams</p>

            </div>

            <div class="col-md-3 stat-box">

                <h1>99%</h1>

                <p>Security</p>

            </div>

            <div class="col-md-3 stat-box">

                <h1>24/7</h1>

                <p>Monitoring</p>

            </div>

        </div>

    </div>

</section>

<!-- CTA -->

<section class="cta">

    <div class="container">

        <h2 class="fw-bold">

            Start Secure Online Exams Today

        </h2>

        <p class="mt-3">

            Join the future of online
            examination management.

        </p>

        <a href="register.jsp"
           class="btn btn-light btn-lg">

            Create Account

        </a>

    </div>

</section>

<!-- FOOTER -->

<footer id="contact"
        class="footer">

    <p>

        © 2026 ExamShield AI |
        Smart Online Exam Proctoring System

    </p>

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>