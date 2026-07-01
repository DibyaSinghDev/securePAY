<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>

    <title>Login | ExamShield AI</title>

    <link rel="stylesheet" href="css/style.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>

        body{
            margin:0;
            min-height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            background:linear-gradient(
                    135deg,
                    #2563eb,
                    #1e3a8a,
                    #0f172a
            );
        }

        .login-container{
            width:100%;
            max-width:1100px;
            display:flex;
            background:white;
            border-radius:25px;
            overflow:hidden;
            box-shadow:0 20px 60px rgba(0,0,0,.25);
        }

        .left-panel{
            flex:1;
            background:linear-gradient(
                    135deg,
                    #2563eb,
                    #1e40af
            );
            color:white;
            padding:60px;
            display:flex;
            flex-direction:column;
            justify-content:center;
        }

        .left-panel h1{
            font-size:45px;
            font-weight:700;
            margin-bottom:20px;
        }

        .left-panel p{
            font-size:18px;
            line-height:1.8;
        }

        .left-panel i{
            font-size:120px;
            margin-top:30px;
        }

        .right-panel{
            flex:1;
            padding:60px;
        }

        .login-title{
            text-align:center;
            margin-bottom:30px;
        }

        .login-title h2{
            font-weight:700;
            color:#2563eb;
        }

        .form-control{
            height:50px;
            border-radius:12px;
        }

        .form-select{
            height:50px;
            border-radius:12px;
        }

        .btn-login{
            width:100%;
            height:50px;
            border:none;
            border-radius:12px;
            background:#2563eb;
            color:white;
            font-weight:600;
            transition:.3s;
        }

        .btn-login:hover{
            background:#1d4ed8;
        }

        .extra-links{
            text-align:center;
            margin-top:20px;
        }

        .extra-links a{
            text-decoration:none;
        }

        .social-login{
            display:flex;
            gap:10px;
            margin-top:20px;
        }

        .social-btn{
            flex:1;
            border:1px solid #ddd;
            padding:10px;
            border-radius:10px;
            text-align:center;
            cursor:pointer;
        }

        @media(max-width:768px){

            .login-container{
                flex-direction:column;
                margin:20px;
            }

            .left-panel{
                display:none;
            }

        }

    </style>

</head>

<body>

<div class="login-container">

    <!-- LEFT SECTION -->

    <div class="left-panel">

        <h1>ExamShield AI</h1>

        <p>
            Secure Online Examination Platform
            with AI-Based Proctoring,
            Face Detection,
            Tab Switch Monitoring,
            and Real-Time Analytics.
        </p>

        <i class="fa-solid fa-user-graduate"></i>

    </div>

    <!-- RIGHT SECTION -->

    <div class="right-panel">

        <div class="login-title">

            <h2>Welcome Back</h2>

            <p>
                Login to continue your examination journey
            </p>

        </div>

        <!-- Display Error Message -->

        <%
            String error =
                    (String) request.getAttribute("error");

            if(error != null){
        %>

        <div class="alert alert-danger">

            <%= error %>

        </div>

        <%
            }
        %>

        <form action="LoginServlet"
              method="post">

            <div class="mb-3">

                <label>Email Address</label>

                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="Enter email"
                       required>

            </div>

            <div class="mb-3">

                <label>Password</label>

                <input type="password"
                       name="password"
                       class="form-control"
                       placeholder="Enter password"
                       required>

            </div>

            <div class="mb-3">

                <label>Login As</label>

                <select name="role"
                        class="form-select">

                    <option value="student">
                        Student
                    </option>

                    <option value="admin">
                        Admin
                    </option>

                </select>

            </div>

            <div class="d-flex justify-content-between mb-3">

                <div>

                    <input type="checkbox">

                    Remember Me

                </div>

                <a href="#">
                    Forgot Password?
                </a>

            </div>

            <button class="btn-login">

                <i class="fa-solid fa-right-to-bracket"></i>

                Login

            </button>

        </form>

        <div class="social-login">

            <div class="social-btn">

                <i class="fab fa-google"></i>

                Google

            </div>

            <div class="social-btn">

                <i class="fab fa-github"></i>

                GitHub

            </div>

        </div>

        <div class="extra-links">

            <p class="mt-4">

                Don't have an account?

                <a href="register.jsp">

                    Register Now

                </a>

            </p>

        </div>
        <div class="text-center mt-3">

    <a href="admin-login.jsp"
       class="btn btn-danger">

        Admin Login

    </a>

</div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>