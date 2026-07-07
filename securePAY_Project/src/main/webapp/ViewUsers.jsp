<%@ page import="java.util.List" %>
<%@ page import="com.securepay.model.User" %>

<%
List<User> users =
(List<User>)request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>View Users</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600&family=Manrope:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">

<style>

:root{
    --metal:#1a1613;
    --metal-raised:#242019;
    --metal-deep:#100d0b;
    --line:#3a3227;
    --brass:#c9a227;
    --brass-bright:#e8c765;
    --phosphor:#5eda8e;
    --phosphor-dim:#264534;
    --ivory:#f3ede0;
    --gray:#948c78;
}

*{ margin:0; padding:0; box-sizing:border-box; font-family:'Manrope',sans-serif; }

body{
    background:radial-gradient(circle at 15% 0%, #201b16 0%, var(--metal-deep) 60%);
    min-height:100vh;
    padding:36px 28px 50px;
    color:var(--ivory);
}

::selection{ background:var(--phosphor); color:#0a1a11; }

.container{ max-width:1300px; margin:0 auto; }

/* ---------- Header ---------- */

.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:26px;
}

.title{ display:flex; align-items:center; gap:14px; }

.title .seal{
    width:44px; height:44px;
    border-radius:50%;
    border:1px dashed var(--brass);
    display:flex; align-items:center; justify-content:center;
    font-family:'Fraunces',serif; font-weight:600; font-size:16px;
    color:var(--brass-bright);
    flex-shrink:0;
}

.title .eyebrow{
    font-family:'JetBrains Mono',monospace;
    font-size:11px; letter-spacing:2.5px; text-transform:uppercase;
    color:var(--brass); margin-bottom:4px;
}

.title h1{ font-family:'Fraunces',serif; font-weight:600; font-size:26px; }

.back-btn{
    display:flex; align-items:center; gap:9px;
    padding:11px 18px;
    background:var(--metal-raised);
    border:1px solid var(--line);
    color:var(--ivory);
    text-decoration:none;
    border-radius:10px;
    font-weight:500;
    font-size:13.5px;
    transition:border-color .15s, transform .15s;
}

.back-btn:hover{ border-color:var(--brass); transform:translateY(-2px); }

/* ---------- Search ---------- */

.search-box{ margin-bottom:22px; max-width:420px; position:relative; }

.search-box::before{
    content:"⌕";
    position:absolute;
    left:14px; top:50%; transform:translateY(-50%);
    color:var(--gray);
    font-size:16px;
}

.search-box input{
    width:100%;
    padding:13px 14px 13px 38px;
    background:var(--metal);
    border:1px solid var(--line);
    border-radius:10px;
    color:var(--ivory);
    font-family:'JetBrains Mono',monospace;
    font-size:13.5px;
    transition:border-color .15s;
}

.search-box input::placeholder{ color:var(--gray); }
.search-box input:focus{ outline:none; border-color:var(--brass); }

/* ---------- Table ---------- */

.table-card{
    background:var(--metal);
    border:1px solid var(--line);
    border-radius:16px;
    overflow:hidden;
    overflow-x:auto;
}

table{ width:100%; border-collapse:collapse; }

th{
    background:var(--metal-deep);
    color:var(--brass);
    font-family:'JetBrains Mono',monospace;
    font-size:11px;
    letter-spacing:1.2px;
    text-transform:uppercase;
    text-align:left;
    padding:16px 18px;
    border-bottom:1px solid var(--line);
    white-space:nowrap;
}

td{
    padding:16px 18px;
    border-bottom:1px dashed var(--line);
    text-align:left;
    font-size:14px;
    color:var(--ivory);
    white-space:nowrap;
}

tbody tr:hover{ background:var(--metal-raised); }
tbody tr:last-child td{ border-bottom:none; }

.balance{
    color:var(--phosphor);
    font-weight:700;
    font-family:'JetBrains Mono',monospace;
}

.empty-row td{
    text-align:center;
    padding:36px;
    color:var(--gray);
    font-family:'JetBrains Mono',monospace;
    font-size:13px;
    white-space:normal;
}

@media(max-width:900px){
    body{ padding:24px 16px 40px; }
    table{ font-size:13px; }
}

</style>

<script>

function searchUser(){

let input =
document.getElementById(
"userSearch");

let filter =
input.value.toUpperCase();

let table =
document.getElementById(
"userTable");

let tr =
table.getElementsByTagName("tr");

for(let i=1;i<tr.length;i++){

let td =
tr[i].getElementsByTagName("td")[1];

if(td){

let txt =
td.textContent ||
td.innerText;

tr[i].style.display =
txt.toUpperCase()
.indexOf(filter) > -1
? ""
: "none";
}
}
}

</script>
</head>

<body>
<div class="container">

<div class="header">
    <div class="title">
        <div class="seal">SP</div>
        <div>
            <div class="eyebrow">Admin console</div>
            <h1>All Users</h1>
        </div>
    </div>
    <a href="AdminDashboardServlet" class="back-btn">← Dashboard</a>
</div>

<div class="search-box">
    <input
        type="text"
        id="userSearch"
        onkeyup="searchUser()"
        placeholder="Search user by name...">
</div>

<div class="table-card">
<table id="userTable">

<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Account Number</th>
<th>Balance</th>
</tr>

<%
if(users != null && !users.isEmpty()){
for(User user : users){
%>
<tr>
<td><%= user.getId() %></td>
<td><%= user.getName() %></td>
<td><%= user.getEmail() %></td>
<td><%= user.getAccountNumber() %></td>
<td class="balance">₹ <%= user.getBalance() %></td>
</tr>
<%
}
} else {
%>
<tr class="empty-row"><td colspan="5">No users on file.</td></tr>
<%
}
%>

</table>
</div>

</div>
</body>
</html>
