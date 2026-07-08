<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SecurePAY | OTP Verification</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600&family=Inter:wght@400;500;600&family=IBM+Plex+Mono:wght@500;600&display=swap" rel="stylesheet">

<style>

:root{
    --vault-navy:#0B1120;
    --panel:#161D2C;
    --panel-edge:#232C40;
    --brass:#C9A227;
    --brass-dim:#8a721f;
    --ink:#EDEFF3;
    --slate:#8A93A6;
    --danger:#E5484D;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:
        radial-gradient(circle at 50% -10%, #1a2438 0%, var(--vault-navy) 55%);
    font-family:'Inter',sans-serif;
    color:var(--ink);
    padding:24px;
}

/* faint ledger rule lines across the backdrop */
body::before{
    content:"";
    position:fixed;
    inset:0;
    background-image:repeating-linear-gradient(
        0deg,
        rgba(255,255,255,0.02) 0px,
        rgba(255,255,255,0.02) 1px,
        transparent 1px,
        transparent 40px
    );
    pointer-events:none;
}

.card{
    position:relative;
    width:440px;
    max-width:100%;
    padding:48px 40px 40px;
    background:var(--panel);
    border:1px solid var(--panel-edge);
    border-radius:18px;
    text-align:center;
    box-shadow:
        0 0 0 1px rgba(201,162,39,0.06),
        0 24px 60px rgba(0,0,0,0.45);
    animation:rise 0.6s cubic-bezier(.2,.8,.2,1);
}

@keyframes rise{
    from{ opacity:0; transform:translateY(18px); }
    to{ opacity:1; transform:translateY(0); }
}

/* corner rivets — vault door detail */
.rivet{
    position:absolute;
    width:8px;
    height:8px;
    border-radius:50%;
    background:linear-gradient(135deg,#3a4256,#1c2436);
    box-shadow:inset 0 0 0 1px rgba(255,255,255,0.05);
}
.rivet.tl{ top:16px; left:16px; }
.rivet.tr{ top:16px; right:16px; }
.rivet.bl{ bottom:16px; left:16px; }
.rivet.br{ bottom:16px; right:16px; }

.eyebrow{
    font-family:'IBM Plex Mono',monospace;
    font-size:11px;
    letter-spacing:3px;
    color:var(--brass);
    text-transform:uppercase;
    margin-bottom:14px;
}

h1{
    font-family:'Fraunces',serif;
    font-weight:600;
    font-size:28px;
    letter-spacing:-0.3px;
    margin-bottom:10px;
}

.subtitle{
    color:var(--slate);
    font-size:14px;
    line-height:1.5;
    margin-bottom:36px;
}

.subtitle strong{
    color:var(--ink);
    font-weight:500;
}

/* Vault dial tumbler inputs */
.tumblers{
    display:flex;
    justify-content:center;
    gap:10px;
    margin-bottom:32px;
}

.tumblers input{
    width:48px;
    height:58px;
    text-align:center;
    font-family:'IBM Plex Mono',monospace;
    font-size:24px;
    font-weight:600;
    color:var(--ink);
    background:#0F1524;
    border:1.5px solid var(--panel-edge);
    border-radius:10px;
    transition:border-color 0.2s, box-shadow 0.2s;
}

.tumblers input:focus{
    outline:none;
    border-color:var(--brass);
    box-shadow:0 0 0 3px rgba(201,162,39,0.15);
}

.tumblers input.filled{
    border-color:var(--brass-dim);
}

/* Circular brass timer ring */
.timer-wrap{
    display:flex;
    flex-direction:column;
    align-items:center;
    gap:10px;
    margin-bottom:30px;
}

.ring-holder{
    position:relative;
    width:84px;
    height:84px;
}

.ring-holder svg{
    transform:rotate(-90deg);
}

.ring-bg{
    fill:none;
    stroke:var(--panel-edge);
    stroke-width:5;
}

.ring-progress{
    fill:none;
    stroke:var(--brass);
    stroke-width:5;
    stroke-linecap:round;
    transition:stroke-dashoffset 1s linear;
}

.ring-time{
    position:absolute;
    inset:0;
    display:flex;
    align-items:center;
    justify-content:center;
    font-family:'IBM Plex Mono',monospace;
    font-size:15px;
    font-weight:600;
}

.timer-label{
    font-size:11px;
    letter-spacing:1.5px;
    text-transform:uppercase;
    color:var(--slate);
}

.timer-label.expired{
    color:var(--danger);
}

/* Verify button */
.verify-btn{
    width:100%;
    padding:16px;
    border:none;
    border-radius:10px;
    background:var(--brass);
    color:#1a1508;
    font-family:'Inter',sans-serif;
    font-weight:600;
    font-size:15px;
    letter-spacing:0.3px;
    cursor:pointer;
    transition:background 0.2s, transform 0.15s;
}

.verify-btn:hover{
    background:#dab531;
}

.verify-btn:active{
    transform:scale(0.98);
}

.resend{
    display:inline-block;
    margin-top:20px;
    color:var(--slate);
    text-decoration:none;
    font-size:13px;
    border-bottom:1px solid transparent;
    transition:color 0.2s, border-color 0.2s;
}

.resend:hover{
    color:var(--brass);
    border-color:var(--brass);
}

.secure-footer{
    margin-top:28px;
    padding-top:20px;
    border-top:1px solid var(--panel-edge);
    color:var(--slate);
    font-size:11.5px;
    letter-spacing:0.4px;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:6px;
}

@media(prefers-reduced-motion: reduce){
    .card{ animation:none; }
    .ring-progress{ transition:none; }
}

@media(max-width:480px){
    .card{ padding:36px 24px 30px; }
    .tumblers{ gap:6px; }
    .tumblers input{ width:40px; height:52px; font-size:20px; }
}

</style>

<script>

let timeLeft = 120;
const totalTime = 120;
const circumference = 2 * Math.PI * 38;

function startTimer(){
    const ringProgress = document.getElementById("ringProgress");
    const ringTime = document.getElementById("ringTime");
    const timerLabel = document.getElementById("timerLabel");

    ringProgress.style.strokeDasharray = circumference;

    const interval = setInterval(function(){
        const minutes = Math.floor(timeLeft / 60);
        const seconds = timeLeft % 60;

        ringTime.textContent = minutes + ":" + (seconds < 10 ? "0" + seconds : seconds);

        const offset = circumference * (1 - timeLeft / totalTime);
        ringProgress.style.strokeDashoffset = offset;

        if(timeLeft <= 0){
            clearInterval(interval);
            ringTime.textContent = "0:00";
            timerLabel.textContent = "Code expired";
            timerLabel.classList.add("expired");
        }

        timeLeft--;
    }, 1000);
}

function setupTumblers(){
    const inputs = document.querySelectorAll(".tumblers input");
    const hidden = document.getElementById("otpCombined");

    inputs.forEach(function(input, index){
        input.addEventListener("input", function(){
            input.value = input.value.replace(/[^0-9]/g, "");
            if(input.value){
                input.classList.add("filled");
                if(index < inputs.length - 1){
                    inputs[index + 1].focus();
                }
            } else {
                input.classList.remove("filled");
            }
            updateHidden();
        });

        input.addEventListener("keydown", function(e){
            if(e.key === "Backspace" && !input.value && index > 0){
                inputs[index - 1].focus();
            }
        });

        input.addEventListener("paste", function(e){
            e.preventDefault();
            const pasted = (e.clipboardData || window.clipboardData).getData("text").replace(/[^0-9]/g, "");
            for(let i = 0; i < inputs.length; i++){
                inputs[i].value = pasted[i] || "";
                if(inputs[i].value) inputs[i].classList.add("filled");
            }
            updateHidden();
            inputs[Math.min(pasted.length, inputs.length - 1)].focus();
        });
    });

    function updateHidden(){
        let combined = "";
        inputs.forEach(function(input){ combined += input.value; });
        hidden.value = combined;
    }
}

window.onload = function(){
    startTimer();
    setupTumblers();
    document.querySelector(".tumblers input").focus();
};

</script>

</head>

<body>

<div class="card">

    <div class="rivet tl"></div>
    <div class="rivet tr"></div>
    <div class="rivet bl"></div>
    <div class="rivet br"></div>

    <div class="eyebrow">SecurePAY &middot; Vault Access</div>
    <h1>Enter your code</h1>
    <p class="subtitle">A 6-digit code was sent to your <strong>registered email</strong>. Enter it below to continue.</p>

    <form action="VerifyOTPServlet" method="post" id="otpForm">

        <div class="tumblers">
            <input type="text" inputmode="numeric" maxlength="1" autocomplete="one-time-code">
            <input type="text" inputmode="numeric" maxlength="1">
            <input type="text" inputmode="numeric" maxlength="1">
            <input type="text" inputmode="numeric" maxlength="1">
            <input type="text" inputmode="numeric" maxlength="1">
            <input type="text" inputmode="numeric" maxlength="1">
        </div>

        <input type="hidden" name="otp" id="otpCombined">

        <div class="timer-wrap">
            <div class="ring-holder">
                <svg width="84" height="84" viewBox="0 0 84 84">
                    <circle class="ring-bg" cx="42" cy="42" r="38"></circle>
                    <circle class="ring-progress" id="ringProgress" cx="42" cy="42" r="38"></circle>
                </svg>
                <div class="ring-time" id="ringTime">2:00</div>
            </div>
            <div class="timer-label" id="timerLabel">Time remaining</div>
        </div>

        <button type="submit" class="verify-btn">Verify and continue</button>

    </form>

    <a href="register.jsp" class="resend">Didn't get a code? Resend</a>

    <div class="secure-footer">
        Encrypted end-to-end &middot; SecurePAY Banking
    </div>

</div>

</body>
</html>