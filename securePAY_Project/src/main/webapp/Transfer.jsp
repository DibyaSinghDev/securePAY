<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.securepay.model.User"%>
<%
User user=(User)session.getAttribute("user");
if(user==null){
 response.sendRedirect("Login.jsp");
 return;
}
String error=(String)request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>SecurePAY | Transfer Funds</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Space+Grotesk:wght@500;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Outfit',sans-serif}
body{background:linear-gradient(135deg,#020617,#0f172a,#111827);color:#fff;min-height:100vh}
.nav{display:flex;justify-content:space-between;align-items:center;padding:22px 40px;background:rgba(255,255,255,.05);backdrop-filter:blur(12px)}
.logo{font-family:'Space Grotesk',sans-serif;font-size:30px;color:#38bdf8;font-weight:700}
.logout{background:#ef4444;color:#fff;text-decoration:none;padding:10px 18px;border-radius:10px}
.wrap{max-width:850px;margin:35px auto;padding:0 20px}
.card{background:rgba(255,255,255,.06);backdrop-filter:blur(15px);border-radius:24px;padding:28px;border:1px solid rgba(255,255,255,.08)}
.balance{font-family:'Space Grotesk',sans-serif;font-size:42px;color:#4ade80;margin:12px 0 25px}
label{display:block;margin:16px 0 8px}
input{width:100%;padding:15px;border-radius:14px;border:1px solid #334155;background:#0f172a;color:#fff;font-size:16px}
input:focus{outline:none;border-color:#38bdf8}
button{width:100%;margin-top:18px;padding:16px;border:none;border-radius:14px;background:#2563eb;color:#fff;font-size:17px;font-weight:600;cursor:pointer}
button:hover{background:#1d4ed8}
#errorMsg{display:block;color:#ef4444;font-weight:600;margin-top:8px;min-height:22px}
.server{background:#7f1d1d;color:#fecaca;padding:12px;border-radius:12px;margin-bottom:18px}
.navbar{
background:rgba(255,255,255,.04);
backdrop-filter:blur(20px);
border-bottom:1px solid rgba(255,255,255,.08);
padding:20px 40px;
}

.navbar-top{
display:flex;
justify-content:space-between;
align-items:center;
}

.logo{
font-size:30px;
font-weight:700;
color:#38bdf8;
}

.nav-right{
display:flex;
align-items:center;
gap:20px;
}

.logout{
text-decoration:none;
color:white;
padding:12px 20px;
background:#ef4444;
border-radius:12px;
}

.navbar-menu{
display:flex;
justify-content:center;
gap:15px;
margin-top:20px;
flex-wrap:wrap;
}

.navbar-menu a{
text-decoration:none;
color:white;
padding:12px 22px;
border-radius:12px;
background:#1e293b;
transition:.3s;
font-weight:500;
}

.navbar-menu a:hover{
background:#2563eb;
transform:translateY(-3px);
}

@media(max-width:900px){

.navbar-top{
flex-direction:column;
gap:15px;
}

.navbar-menu{
justify-content:center;
}

}
.footer{text-align:center;color:#94a3b8;margin:25px}
</style>
</head>
<body>
<div class="nav">
<div class="logo">SecurePAY</div>
<div>
<span><%=user.getName()%></span>
<a class="logout" href="LogoutServlet">Logout</a>
</div>
</div>
<div class="navbar">

    <div class="navbar-top">


    </div>

    <div class="navbar-menu">

        <a href="Dashboard.jsp">🏠 Dashboard</a>

        <a href="Deposite.jsp">💰 Deposit</a>

        <a href="Withdraw.jsp">💸 Withdraw</a>

        <a href="Transfer.jsp">🔄 Transfer</a>

        <a href="TransactionServlet">📜 Transactions</a>

    </div>

</div>
<div class="wrap">
<div class="card">
<h1 style="font-family:'Space Grotesk',sans-serif;">Transfer Funds</h1>
<p style="margin-top:8px;color:#cbd5e1;">Transfer money securely.</p>

<% if(error!=null){ %>
<div class="server">❌ <%=error%></div>
<% } %>

<h3 style="margin-top:25px">Available Balance</h3>
<div class="balance">₹ <%=user.getBalance()%></div>

<form action="TransferServlet" method="post" id="transferForm">
<input type="hidden" id="balance" value="<%=user.getBalance()%>">

<label>Receiver Account Number</label>
<input type="text" name="receiverAccount" required placeholder="Enter account number">

<label>Transfer Amount</label>
<input type="number" id="amount" name="amount" min="1" required placeholder="Enter amount">

<span id="errorMsg"></span>

<button type="submit">Transfer Funds</button>
</form>
</div>

<div class="footer">© 2026 SecurePAY Digital Banking Platform</div>
</div>

<script>
const amount=document.getElementById("amount");
const balance=parseFloat(document.getElementById("balance").value);
const error=document.getElementById("errorMsg");
const form=document.getElementById("transferForm");

amount.addEventListener("input",function(){
 let value=parseFloat(this.value)||0;
 if(value>balance){
   error.innerHTML="❌ Insufficient Balance!";
   this.style.borderColor="#ef4444";
 }else{
   error.innerHTML="";
   this.style.borderColor="#22c55e";
 }
});

form.addEventListener("submit",function(e){
 let value=parseFloat(amount.value)||0;
 if(value>balance){
   e.preventDefault();
   error.innerHTML="❌ Insufficient Balance! You cannot transfer more than your available balance.";
   amount.focus();
 }
});
</script>
</body>
</html>
