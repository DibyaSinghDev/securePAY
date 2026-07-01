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
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>SecurePAY | Withdraw Funds</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Space+Grotesk:wght@500;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Outfit',sans-serif}
body{background:linear-gradient(135deg,#020617,#0f172a,#111827);color:#fff;min-height:100vh}
.nav{display:flex;justify-content:space-between;align-items:center;padding:22px 40px;background:rgba(255,255,255,.05);backdrop-filter:blur(12px)}
.logo{font:700 30px 'Space Grotesk',sans-serif;color:#38bdf8}
.right{display:flex;gap:16px;align-items:center}
.logout{text-decoration:none;color:#fff;background:#ef4444;padding:10px 18px;border-radius:10px}
.wrap{max-width:850px;margin:35px auto;padding:0 20px}
.card{background:rgba(255,255,255,.06);backdrop-filter:blur(16px);border:1px solid rgba(255,255,255,.08);padding:28px;border-radius:22px}
.balance{font:700 42px 'Space Grotesk',sans-serif;color:#4ade80;margin:10px 0 20px}
label{display:block;margin:14px 0 8px}
input{width:100%;padding:15px;border-radius:14px;background:#0f172a;border:1px solid #334155;color:#fff}
button{width:100%;padding:16px;margin-top:18px;border:none;border-radius:14px;background:#dc2626;color:#fff;font-size:16px;font-weight:600;cursor:pointer}
button:hover{background:#b91c1c}
#errorMsg{display:block;color:#ef4444;font-weight:600;min-height:22px;margin-top:8px}
.server{background:#7f1d1d;color:#fecaca;padding:12px;border-radius:10px;margin-bottom:16px}
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
<div class="right">
<span><%=user.getName()%></span>
<a href="LogoutServlet" class="logout">Logout</a>
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

<h1 style="font-family:'Space Grotesk',sans-serif;">Withdraw Funds</h1>
<p style="color:#cbd5e1;margin-top:8px;">Withdraw money securely from your account.</p>

<% if(error!=null){ %>
<div class="server">❌ <%=error%></div>
<% } %>

<h3 style="margin-top:20px">Available Balance</h3>
<div class="balance">₹ <%=user.getBalance()%></div>

<form id="withdrawForm" action="WithdrawServlet" method="post">
<input type="hidden" id="balance" value="<%=user.getBalance()%>">

<label>Withdrawal Amount</label>
<input type="number" id="amount" name="amount" min="1" placeholder="Enter withdrawal amount" required>
<span id="errorMsg"></span>

<button type="submit">Withdraw Funds</button>
</form>
</div>
<div class="footer">© 2026 SecurePAY Digital Banking Platform</div>
</div>

<script>
const bal=parseFloat(document.getElementById("balance").value);
const amt=document.getElementById("amount");
const err=document.getElementById("errorMsg");
document.getElementById("withdrawForm").addEventListener("submit",function(e){
 let v=parseFloat(amt.value)||0;
 if(v>bal){
   e.preventDefault();
   err.innerHTML="❌ Insufficient Balance!";
   amt.style.borderColor="#ef4444";
 }
});
amt.addEventListener("input",()=>{
 let v=parseFloat(amt.value)||0;
 if(v>bal){
   err.innerHTML="❌ Insufficient Balance!";
   amt.style.borderColor="#ef4444";
 }else{
   err.innerHTML="";
   amt.style.borderColor="#22c55e";
 }
});
</script>
</body>
</html>