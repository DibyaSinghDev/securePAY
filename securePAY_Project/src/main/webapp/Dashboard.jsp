<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.securepay.model.User"%>
<%@ page import="java.util.List"%>
<%@ page import="com.securepay.model.Transaction"%>

<%
User user=(User)session.getAttribute("user");
if(user==null){
response.sendRedirect("Login.jsp");
return;
}
%>
<%
Boolean transferSuccess =
(Boolean)session.getAttribute("transferSuccess");

Integer rewardCoins =
(Integer)session.getAttribute("rewardCoins");

Double transferAmount =
(Double)session.getAttribute("transferAmount");
%>
<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

if(session.getAttribute("user")==null){
    response.sendRedirect("Login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SecurePAY Professional Dashboard V2</title>

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{background:#0f172a;color:white;display:flex;min-height:100vh;}
.sidebar{width:250px;background:#020617;padding:25px;}
.logo{font-size:28px;font-weight:700;color:#38bdf8;margin-bottom:30px;}
.menu a{display:block;padding:14px;margin-bottom:10px;background:#1e293b;color:white;text-decoration:none;border-radius:12px;}
.menu a:hover{background:#2563eb;}
.main{flex:1;padding:25px;}
.topbar{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;}
.logout{padding:10px 20px;background:#ef4444;color:white;text-decoration:none;border-radius:10px;}
.announcement{
padding:15px;border-radius:15px;
background:linear-gradient(135deg,#2563eb,#38bdf8);
margin-bottom:20px;text-align:center;font-weight:600;
}
.cards{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
gap:20px;
}
.card{padding:25px;border-radius:20px;}
.balance{background:linear-gradient(135deg,#10b981,#059669);}
.reward{background:linear-gradient(135deg,#f59e0b,#d97706);}
.account{background:linear-gradient(135deg,#6366f1,#4338ca);}
.status{background:linear-gradient(135deg,#06b6d4,#0891b2);}

.promo-grid{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
gap:20px;
margin-top:25px;
}

.promo-card{
padding:25px;
border-radius:20px;
color:white;
}

.offer{background:linear-gradient(135deg,#2563eb,#06b6d4);}
.loan{background:linear-gradient(135deg,#7c3aed,#9333ea);}
.rewardoffer{background:linear-gradient(135deg,#f59e0b,#d97706);}

.content{
display:grid;
grid-template-columns:1fr 1fr;
gap:20px;
margin-top:25px;
}

.bank-card{
height:220px;
border-radius:25px;
padding:25px;
background:linear-gradient(135deg,#0047ff,#001d5c);
position:relative;
}

.visa{
position:absolute;
right:25px;
top:20px;
font-size:32px;
font-weight:bold;
}

.quick{
background:#111827;
padding:25px;
border-radius:20px;
}

.actions{
display:grid;
grid-template-columns:repeat(2,1fr);
gap:12px;
margin-top:15px;
}

.actions a{
text-decoration:none;
color:white;
padding:14px;
background:#1e293b;
text-align:center;
border-radius:10px;
}

.actions a:hover{
background:#2563eb;
}

.ad-banner{
margin-top:20px;
padding:25px;
border-radius:20px;
background:linear-gradient(135deg,#111827,#1e293b);
}

.transactions{

    margin-top:35px;

    background:linear-gradient(
        135deg,
        rgba(17,24,39,.95),
        rgba(30,41,59,.95)
    );

    backdrop-filter:blur(25px);

    border:1px solid rgba(255,255,255,.08);

    border-radius:28px;

    padding:35px;

    overflow:hidden;

    box-shadow:
    0 25px 60px rgba(0,0,0,.45),
    inset 0 1px 0 rgba(255,255,255,.05);

    position:relative;

}

/* Animated Glow */

.transactions::before{

    content:"";

    position:absolute;

    width:320px;

    height:320px;

    background:#2563eb;

    opacity:.12;

    filter:blur(120px);

    top:-150px;

    right:-120px;

}

.transactions::after{

    content:"";

    position:absolute;

    width:280px;

    height:280px;

    background:#06b6d4;

    opacity:.08;

    filter:blur(110px);

    bottom:-120px;

    left:-100px;

}

.transactions h2{

    display:flex;

    align-items:center;

    gap:15px;

    font-size:34px;

    font-weight:700;

    margin-bottom:35px;

    position:relative;

}

.transactions h2 i{

    color:#38bdf8;

    font-size:34px;

}

/* Table */

.transactions table{

    width:100%;

    border-collapse:separate;

    border-spacing:0 16px;

    position:relative;

    z-index:5;

}

.transactions th{

    color:#94a3b8;

    text-transform:uppercase;

    letter-spacing:2px;

    font-size:13px;

    padding:18px;

}

.transactions tbody tr{

    background:rgba(255,255,255,.04);

    backdrop-filter:blur(18px);

    transition:.4s;

    cursor:pointer;

}

.transactions tbody tr:hover{

    transform:
    translateY(-5px)
    scale(1.01);

    background:rgba(37,99,235,.12);

    box-shadow:

    0 15px 40px rgba(37,99,235,.25);

}

.transactions td{

    padding:24px 18px;

    font-size:17px;

}

.transactions td:first-child{

    border-radius:18px 0 0 18px;

}

.transactions td:last-child{

    border-radius:0 18px 18px 0;

}

/* Transaction Icon */

.type{

    display:flex;

    align-items:center;

    gap:18px;

    font-weight:600;

}

.icon-box{

    width:52px;

    height:52px;

    border-radius:15px;

    display:flex;

    justify-content:center;

    align-items:center;

    font-size:22px;

    color:white;

}

.transfer{

background:linear-gradient(135deg,#3b82f6,#2563eb);

}

.recharge{

background:linear-gradient(135deg,#06b6d4,#0891b2);

}

.loan{

background:linear-gradient(135deg,#22c55e,#16a34a);

}

.deposit{

background:linear-gradient(135deg,#8b5cf6,#7c3aed);

}

.withdraw{

background:linear-gradient(135deg,#ef4444,#dc2626);

}

/* Amount */

.amount{

font-size:22px;

font-weight:700;

color:#38bdf8;

text-align:center;

}

/* Status */

.status{

display:inline-flex;

align-items:center;

gap:8px;

padding:10px 20px;

border-radius:50px;

font-weight:600;

}

.success{

background:rgba(16,185,129,.15);

color:#10b981;

border:1px solid #10b981;

}

.pending{

background:rgba(245,158,11,.15);

color:#f59e0b;

border:1px solid #f59e0b;

}

.failed{

background:rgba(239,68,68,.15);

color:#ef4444;

border:1px solid #ef4444;

}

table{
width:100%;
border-collapse:collapse;
margin-top:15px;
}

th,td{
padding:12px;
border-bottom:1px solid rgba(255,255,255,.1);
}

.success{color:#10b981;}

@media(max-width:900px){
body{flex-direction:column;}
.sidebar{width:100%;}
.content{grid-template-columns:1fr;}
}
.reward-popup{
display:none;
position:fixed;
top:0;
left:0;
width:100%;
height:100%;
background:rgba(0,0,0,.75);
justify-content:center;
align-items:center;
z-index:9999;
}

.reward-box{
width:550px;
padding:40px;
border-radius:30px;
background:linear-gradient(135deg,#111827,#1e293b);
text-align:center;
position:relative;
overflow:hidden;
box-shadow:0 0 40px rgba(251,191,36,.4);
}

.reward-title{
font-size:38px;
color:#10b981;
margin-bottom:15px;
}

.reward-coins{
font-size:42px;
font-weight:bold;
color:#fbbf24;
margin-top:15px;
}

.coin{
position:absolute;
font-size:60px;
bottom:-100px;
animation:coinFly 3s linear infinite;
}

.c1{left:10%;}
.c2{left:30%;animation-delay:.5s;}
.c3{left:50%;animation-delay:1s;}
.c4{left:70%;animation-delay:1.5s;}
.c5{left:85%;animation-delay:2s;}

@keyframes coinFly{
0%{
transform:translateY(0) rotate(0deg);
opacity:0;
}
20%{
opacity:1;
}
100%{
transform:translateY(-600px) rotate(1080deg);
opacity:0;
}
}
.feature-card{
    width:280px;
    background:white;
    border-radius:15px;
    padding:25px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,.15);
    transition:.3s;
}

.feature-card:hover{
    transform:translateY(-8px);
}

.feature-card .icon{
    font-size:100px;
    margin-bottom:15px;
}

.feature-card h3{
    color:#0d6efd;
    margin-bottom:10px;
}

.feature-card p{
    color:#693;
    margin-bottom:20px;
}

.btn{
    display:inline-block;
    padding:12px 20px;
    background:#0d6efd;
    color:white;
    border-radius:8px;
    text-decoration:none;
}

.btn:hover{
    background:#084298;
}

.notification{
position:relative;
display:inline-flex;
align-items:center;
justify-content:center;
width:48px;
height:48px;
background:#1e293b;
border-radius:50%;
color:#fff;
text-decoration:none;
transition:.3s;
}
.notification:hover{
background:#2563eb;
transform:translateY(-2px);
}
.badge{
position:absolute;
top:-6px;
right:-6px;
min-width:22px;
height:22px;
padding:0 6px;
background:#ef4444;
color:#fff;
border-radius:50px;
display:flex;
align-items:center;
justify-content:center;
font-size:11px;
font-weight:bold;
border:2px solid #fff;
}

</style>
</head>

<body>
<div id="rewardPopup" class="reward-popup">

<div class="reward-box">

<h1 class="reward-title">
✅ Transfer Successful
</h1>

<h2>
₹ <%= transferAmount != null ? transferAmount : 0 %>
Transferred
</h2>

<div class="reward-coins">
🪙 +<%= rewardCoins != null ? rewardCoins : 0 %>
Reward Coins
</div>

<div class="coin c1">🪙</div>
<div class="coin c2">🪙</div>
<div class="coin c3">🪙</div>
<div class="coin c4">🪙</div>
<div class="coin c5">🪙</div>

</div>

</div>

<script>

window.onload=function(){

<%
if(Boolean.TRUE.equals(transferSuccess)){
%>

document.getElementById(
"rewardPopup")
.style.display="flex";

setTimeout(function(){

document.getElementById(
"rewardPopup")
.style.display="none";

},5000);

<%
session.removeAttribute("transferSuccess");
session.removeAttribute("rewardCoins");
session.removeAttribute("transferAmount");
}
%>

};

</script>

<div class="sidebar">
<div class="logo">🛡 SecurePAY</div>

<div class="menu">
<a href="Dashboard.jsp">🏠 Dashboard</a>
<a href="Deposite.jsp">💰 Deposit</a>
<a href="Withdraw.jsp">💸 Withdraw</a>
<a href="Transfer.jsp">🔄 Transfer</a>
<a href="TransactionServlet">📜 Transactions</a>
<a href="Profile.jsp">👤 Profile</a>
<a href="PassbookServlet">📒 Passbook</a>
<a href="ChangePassword.jsp">🔑 Password</a>
<a href="RechargeServlet" class="quick-action">
    <p>⚡Recharge</p>
</a>
<a href="MobileRecharge.jsp" class="btn">
    📲 Mobile Recharge
</a>
<a href="ElectricityRecharge.jsp" class="btn">
    💡Electricity Recharge
</a>
<a href="LoanApplication.jsp" class="btn">
    Loan
</a>
<a href="chatbot.jsp">🔑 chatbot</a>
 <a href="NotificationServlet" class="quick orange">
                <i class="fa-solid fa-mobile-screen-button"></i>
                🔔 Notification
            </a>
            <a href="RechargeHistoryServlet" class="btn">
    View Recharge History
</a>
</div>
</div>

<div class="main">

<div class="topbar">
<div>
<h1>Welcome, <%= user.getName() %></h1>
<p><%= user.getEmail() %></p>
</div>
 <a href="NotificationServlet" class="notification">
    <i class="fa-solid fa-bell"></i>
    <%
    Integer unreadCount=(Integer)session.getAttribute("unreadCount");
    if(unreadCount!=null && unreadCount>0){
    %>
    <span class="badge"><%= unreadCount %></span>
    <%
    }
    %>
</a>
<a href="LogoutServlet" class="logout">Logout</a>
</div>

<div class="announcement">
🔥 Special Offer: Get ₹100 Cashback on your first transfer today!
</div>

<div class="cards">

<div class="card balance">
<h3>Available Balance</h3>
<h2>₹ <%= user.getBalance() %></h2>
</div>

<div class="card reward">
<h3>Reward Coins</h3>
<h2>🪙 450</h2>
</div>

<div class="card account">
<h3>Account Number</h3>
<h2><%= user.getAccountNumber() %></h2>
</div>

<div class="card status">
<h3>Account Status</h3>
<h2>ACTIVE</h2>
</div>

</div>

<div class="promo-grid">

<div class="promo-card offer">
<h2>🎉 Cashback Festival</h2>
<p>Get 10% Cashback on UPI payments above ₹500.</p>
</div>

<div class="promo-card loan">
<h2>💰 Instant Loan</h2>
<p>Loans up to ₹5,00,000 with instant approval.</p>
</div>

<div class="promo-card rewardoffer">
<h2>🪙 Reward Bonus</h2>
<p>Earn double reward coins this weekend.</p>
</div>

</div>

<div class="content">

<div>

<div class="bank-card">
<div class="visa">VISA</div>
<h2>SecurePAY Platinum</h2>
<br><br>
<h3>**** **** **** 4589</h3>
<br><br>
<h4><%= user.getName() %></h4>
</div>

<div class="ad-banner">
<h2>🏦 SecurePAY Platinum Card</h2>
<p>Airport lounge access, cashback and premium rewards.</p>
</div>


</div>
<div class="feature-card">
    <div class="icon">⚡</div>
    <h3>Recharge & Bills</h3>
    <p>Mobile, Electricity, DTH, Water, Gas & Broadband</p>

    <a href="RechargeServlet" class="btn">
        Recharge Now
    </a>
</div>



</div>

<div class="transactions">

<h2>Recent Transactions</h2>

<table>
<tr>
<th>Type</th>
<th>Amount</th>
<th>Status</th>
</tr>

<%
List<Transaction> recentTransactions=(List<Transaction>)request.getAttribute("recentTransactions");

if(recentTransactions!=null){
for(Transaction t:recentTransactions){
%>
<tr>
<td><%= t.getTransactionType() %></td>
<td>₹ <%= t.getAmount() %></td>
<td class="success">SUCCESS</td>
</tr>
<%
}
}
%>

</table>

</div>

</div>

</body>
</html>
