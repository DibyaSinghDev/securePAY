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
<title>SecurePAY | Deposit Funds</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif}
body{background:linear-gradient(135deg,#020617,#0f172a,#111827);color:#fff;min-height:100vh}
.navbar{background:rgba(255,255,255,.04);backdrop-filter:blur(20px);border-bottom:1px solid rgba(255,255,255,.08);padding:20px 40px}
.navbar-top{display:flex;justify-content:space-between;align-items:center}
.logo{font-size:30px;font-weight:700;color:#38bdf8}
.nav-right{display:flex;align-items:center;gap:18px}
.logout{text-decoration:none;color:#fff;background:#ef4444;padding:12px 20px;border-radius:12px}
.navbar-menu{display:flex;justify-content:center;gap:15px;flex-wrap:wrap;margin-top:18px}
.navbar-menu a{text-decoration:none;color:#fff;padding:12px 22px;background:#1e293b;border-radius:12px;transition:.3s}
.navbar-menu a:hover{background:#2563eb}
.container{padding:40px 60px}
.header h1{font-size:42px;margin-bottom:10px}
.header p{color:#94a3b8}
.balance-card{margin-top:30px;padding:40px;border-radius:25px;background:linear-gradient(135deg,#10b981,#059669);box-shadow:0 20px 40px rgba(16,185,129,.25)}
.balance-card h1{font-size:60px;margin-top:10px}
.deposit-panel{margin-top:30px;padding:35px;border-radius:25px;background:rgba(255,255,255,.05);backdrop-filter:blur(20px);border:1px solid rgba(255,255,255,.08)}
.deposit-panel label{display:block;margin-bottom:10px;color:#cbd5e1}
.deposit-panel input{width:100%;padding:18px;border-radius:15px;border:1px solid rgba(255,255,255,.08);background:rgba(255,255,255,.05);color:#fff}
.deposit-panel input:focus{border-color:#10b981;outline:none}
.deposit-btn{margin-top:20px;width:100%;padding:18px;border:none;border-radius:15px;background:linear-gradient(135deg,#10b981,#059669);color:#fff;font-size:17px;font-weight:600;cursor:pointer}
.server{background:#064e3b;color:#d1fae5;padding:12px;border-radius:10px;margin-bottom:15px}
.footer{text-align:center;color:#64748b;margin-top:40px}
@media(max-width:900px){.navbar-top{flex-direction:column;gap:15px}.container{padding:20px}}
</style>
</head>
<body>
<div class="navbar">
<div class="navbar-top">
<div class="logo">SecurePAY</div>
<div class="nav-right">
<span><%=user.getName()%></span>
<a href="LogoutServlet" class="logout">Logout</a>
</div>
</div>
<div class="navbar-menu">
<a href="Dashboard.jsp">🏠 Dashboard</a>
<a href="Withdraw.jsp">💸 Withdraw</a>
<a href="Transfer.jsp">🔄 Transfer</a>
<a href="TransactionServlet">📜 Transactions</a>
</div>
</div>

<div class="container">
<div class="header">
<h1>Deposit Funds</h1>
<p>Add money securely to your account.</p>
</div>

<div class="balance-card">
<h4>Current Balance</h4>
<h1>₹ <%=user.getBalance()%></h1>
</div>

<div class="deposit-panel">
<% if(error!=null){ %>
<div class="server"><%=error%></div>
<% } %>

<form action="DepositServlet" method="post">
<label>Deposit Amount</label>
<input type="number" name="amount" min="1" placeholder="Enter deposit amount" required>
<button type="submit" class="deposit-btn">Deposit Funds</button>
</form>
</div>

<div class="footer">© 2026 SecurePAY Digital Banking Platform</div>
</div>
</body>
</html>
