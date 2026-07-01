
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SecurePAY Admin Portal</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    height:100vh;
    display:flex;
    background:#0f172a;
}

/* Left Section */

.left{
    flex:1;
    background:linear-gradient(
        135deg,
        #2563eb,
        #06b6d4
    );
    color:white;
    display:flex;
    flex-direction:column;
    justify-content:center;
    padding:80px;
    position:relative;
    overflow:hidden;
}

.left::before{
    content:"";
    position:absolute;
    width:500px;
    height:500px;
    border-radius:50%;
    background:rgba(255,255,255,.08);
    top:-150px;
    right:-150px;
}

.left::after{
    content:"";
    position:absolute;
    width:350px;
    height:350px;
    border-radius:50%;
    background:rgba(255,255,255,.08);
    bottom:-100px;
    left:-100px;
}

.brand{
    position:relative;
    z-index:2;
}

.brand h1{
    font-size:56px;
    margin-bottom:15px;
}

.brand p{
    font-size:18px;
    line-height:1.8;
    max-width:500px;
}

.features{
    margin-top:40px;
}

.features div{
    margin:15px 0;
    font-size:18px;
}

/* Right Section */

.right{
    width:480px;
    background:white;
    display:flex;
    justify-content:center;
    align-items:center;
}

.login-box{
    width:380px;
}

.login-box h2{
    font-size:34px;
    color:#0f172a;
    margin-bottom:10px;
}

.login-box p{
    color:#64748b;
    margin-bottom:30px;
}

.input-group{
    margin-bottom:20px;
}

.input-group label{
    display:block;
    margin-bottom:8px;
    color:#334155;
    font-weight:500;
}

.input-group input{
    width:100%;
    padding:15px;
    border:2px solid #e2e8f0;
    border-radius:12px;
    font-size:15px;
    transition:.3s;
}

.input-group input:focus{
    outline:none;
    border-color:#2563eb;
}

button{
    width:100%;
    padding:15px;
    border:none;
    border-radius:12px;
    background:#2563eb;
    color:white;
    font-size:16px;
    font-weight:600;
    cursor:pointer;
    transition:.3s;
}

button:hover{
    background:#1d4ed8;
}

.footer{
    margin-top:25px;
    text-align:center;
    color:#64748b;
    font-size:14px;
}

@media(max-width:900px){

    body{
        flex-direction:column;
    }

    .left{
        display:none;
    }

    .right{
        width:100%;
        height:100vh;
    }
}

</style>

</head>

<body>

<div class="left">

    <div class="brand">

        <h1>SecurePAY</h1>

        <p>
            Enterprise Banking Administration Platform
            designed for secure account management,
            transaction monitoring and system control.
        </p>

        <div class="features">
            <div>Real-Time Monitoring</div>
            <div>Transaction Control</div>
            <div>User Management</div>
            <div>Advanced Security</div>
        </div>

    </div>

</div>

<div class="right">

    <div class="login-box">

        <h2>Admin Login</h2>

        <p>
            Access the SecurePAY administration portal
        </p>

        <form action="AdminLoginServlet" method="post">

            <div class="input-group">

                <label>Username</label>

                <input type="text"
                       name="username"
                       required>

            </div>

            <div class="input-group">

                <label>Password</label>

                <input type="password"
                       name="password"
                       required>

            </div>

            <button type="submit">
                Sign In
            </button>

        </form>

        <div class="footer">
            SecurePAY Admin Portal v1.0
        </div>

    </div>

</div>

</body>
</html>

