<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>SecurePAY | OTP Verification</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',sans-serif;
}

body{

    min-height:100vh;

    display:flex;

    justify-content:center;

    align-items:center;

    background:linear-gradient(
        135deg,
        #0f172a,
        #1d4ed8,
        #38bdf8
    );

    overflow:hidden;
}

/* Floating Circles */

.circle{

    position:absolute;

    border-radius:50%;

    background:rgba(255,255,255,0.1);

    animation:float 8s infinite ease-in-out;
}

.circle:nth-child(1){

    width:220px;

    height:220px;

    top:10%;

    left:10%;
}

.circle:nth-child(2){

    width:180px;

    height:180px;

    bottom:10%;

    right:10%;
}

@keyframes float{

    0%{
        transform:translateY(0);
    }

    50%{
        transform:translateY(-30px);
    }

    100%{
        transform:translateY(0);
    }
}

/* OTP Card */

.container{

    width:420px;

    padding:40px;

    background:rgba(255,255,255,0.15);

    backdrop-filter:blur(15px);

    border-radius:25px;

    text-align:center;

    color:white;

    box-shadow:
    0 8px 32px rgba(0,0,0,0.3);

    animation:popup 0.8s ease;
}

@keyframes popup{

    from{

        opacity:0;

        transform:scale(0.7);
    }

    to{

        opacity:1;

        transform:scale(1);
    }
}

.logo{

    font-size:70px;

    margin-bottom:15px;
}

h2{

    margin-bottom:10px;

    font-size:28px;
}

.subtitle{

    color:#e2e8f0;

    margin-bottom:25px;

    font-size:14px;
}

/* OTP Input */

input{

    width:100%;

    padding:15px;

    border:none;

    border-radius:12px;

    text-align:center;

    font-size:24px;

    letter-spacing:8px;

    margin-bottom:20px;
}

input:focus{

    outline:none;

    box-shadow:
    0 0 12px white;
}

/* Verify Button */

.verify-btn{

    width:100%;

    padding:15px;

    border:none;

    border-radius:12px;

    background:#10b981;

    color:white;

    font-size:16px;

    cursor:pointer;

    transition:0.3s;
}

.verify-btn:hover{

    background:#059669;

    transform:translateY(-3px);
}

/* Timer */

.timer{

    margin-top:20px;

    color:#fde047;

    font-size:15px;

    font-weight:bold;
}

/* Resend */

.resend{

    display:block;

    margin-top:15px;

    color:white;

    text-decoration:none;

    transition:0.3s;
}

.resend:hover{

    color:#fde047;
}

/* Footer */

.secure{

    margin-top:20px;

    color:#cbd5e1;

    font-size:13px;
}

/* Mobile */

@media(max-width:500px){

    .container{

        width:90%;
    }
}

</style>

<script>

let timeLeft = 120;

function startTimer(){

    let timer =
    document.getElementById("timer");

    let interval =
    setInterval(function(){

        let minutes =
        Math.floor(timeLeft/60);

        let seconds =
        timeLeft%60;

        timer.innerHTML =
        "OTP Expires In : "
        + minutes + ":"
        + (seconds < 10 ? "0"+seconds : seconds);

        if(timeLeft <= 0){

            clearInterval(interval);

            timer.innerHTML =
            "OTP Expired ❌";
        }

        timeLeft--;

    },1000);
}

window.onload = startTimer;

</script>

</head>

<body>

<div class="circle"></div>

<div class="circle"></div>

<div class="container">

<div class="logo">

🏦

</div>

<h2>SecurePAY Verification</h2>

<p class="subtitle">

Enter the OTP sent to your registered Gmail

</p>

<form action="VerifyOTPServlet"
method="post">

<input
type="text"
name="otp"
maxlength="6"
placeholder="------"
required>

<button
type="submit"
class="verify-btn">

Verify OTP

</button>

</form>

<div id="timer"
class="timer">

OTP Expires In : 2:00

</div>

<a href="register.jsp"
class="resend">

Resend OTP

</a>

<div class="secure">

🔒 Secure Banking Authentication

</div>

</div>

</body>
</html>
