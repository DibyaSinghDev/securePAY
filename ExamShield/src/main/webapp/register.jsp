<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>

    <title>Register | ExamShield AI</title>

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
            padding:30px;
        }

        .register-container{
            width:100%;
            max-width:1200px;
            display:flex;
            background:#fff;
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
        }

        .left-panel p{
            margin-top:20px;
            font-size:18px;
            line-height:1.8;
        }

        .left-panel i{
            font-size:120px;
            margin-top:30px;
        }

        .right-panel{
            flex:1.2;
            padding:50px;
        }

        .title{
            text-align:center;
            margin-bottom:25px;
        }

        .title h2{
            color:#2563eb;
            font-weight:700;
        }

        .form-control,
        .form-select{
            height:50px;
            border-radius:12px;
        }

        .btn-register{
            width:100%;
            height:50px;
            border:none;
            border-radius:12px;
            background:#2563eb;
            color:white;
            font-size:16px;
            font-weight:600;
            transition:.3s;
        }

        .btn-register:hover{
            background:#1d4ed8;
        }

        .login-link{
            text-align:center;
            margin-top:20px;
        }

        .profile-upload{
            text-align:center;
            margin-bottom:20px;
        }

        .profile-upload i{
            font-size:70px;
            color:#2563eb;
        }

        @media(max-width:768px){

            .register-container{
                flex-direction:column;
            }

            .left-panel{
                display:none;
            }

        }

    </style>

</head>

<body>

<div class="register-container">

    <!-- LEFT SIDE -->

    <div class="left-panel">

        <h1>Join ExamShield AI</h1>

        <p>

            Create your account and access
            secure online examinations,
            AI-powered monitoring,
            instant results,
            and performance analytics.

        </p>

        <i class="fa-solid fa-graduation-cap"></i>

    </div>

    <!-- RIGHT SIDE -->

    <div class="right-panel">

        <div class="title">

            <h2>Create Account</h2>

            <p>Register to continue</p>

        </div>

        <form action="RegisterServlet"
              method="post"
              >

            <div class="profile-upload">

                <i class="fa-solid fa-circle-user"></i>

            </div>

            <div class="row">

                <div class="col-md-6 mb-3">

                    <label>Full Name</label>

                    <input type="text"
                           name="name"
                           class="form-control"
                           required>

                </div>

                <div class="col-md-6 mb-3">

                    <label>Email</label>

                    <input type="email"
                           name="email"
                           class="form-control"
                           required>

                </div>

            </div>

            <div class="row">

                <div class="col-md-6 mb-3">

                    <label>Phone Number</label>

                    <input type="text"
                           name="phone"
                           class="form-control"
                           required>

                </div>

                <div class="col-md-6 mb-3">

                    <label>Role</label>

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

            </div>

            <div class="row">

                <div class="col-md-6 mb-3">

                    <label>Password</label>

                    <input type="password"
                           id="password"
                           name="password"
                           class="form-control"
                           required>

                </div>

                <div class="col-md-6 mb-3">

                    <label>Confirm Password</label>

                    <input type="password"
                           id="confirmPassword"
                           class="form-control"
                           required>

                </div>

            </div>

            <div class="mb-3">

                <label>Profile Photo</label>

                <input type="file"
                       name="photo"
                       class="form-control">

            </div>

            <div class="mb-3">

                <input type="checkbox"
                       required>

                I agree to the Terms & Conditions

            </div>

            <button class="btn-register">

                <i class="fa-solid fa-user-plus"></i>

                Create Account

            </button>

        </form>

        <div class="login-link">

            Already have an account?

            <a href="login.jsp">

                Login Here

            </a>

        </div>

    </div>

</div>

<script>

    const form = document.querySelector("form");

    form.addEventListener("submit", function(e){

        const password =
            document.getElementById("password").value;

        const confirmPassword =
            document.getElementById("confirmPassword").value;

        if(password !== confirmPassword){

            alert("Passwords do not match");

            e.preventDefault();
        }

    });

</script>

</body>
</html>