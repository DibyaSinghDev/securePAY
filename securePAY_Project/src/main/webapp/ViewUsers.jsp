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

<title>View Users</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{

background:
linear-gradient(
135deg,
#020617,
#0f172a,
#1e293b);

min-height:100vh;

padding:30px;

color:white;
}

/* Header */

.header{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:30px;
}

.title{

font-size:35px;

font-weight:bold;

color:#38bdf8;
}

.back-btn{

padding:12px 25px;

background:#2563eb;

color:white;

text-decoration:none;

border-radius:10px;

font-weight:bold;

transition:0.3s;
}

.back-btn:hover{

background:#1d4ed8;

transform:translateY(-3px);
}

/* Search */

.search-box{

margin-bottom:25px;
}

.search-box input{

width:100%;

padding:15px;

border:none;

border-radius:12px;

font-size:16px;
}

/* Table Card */

.table-card{

background:
rgba(255,255,255,0.08);

backdrop-filter:blur(15px);

padding:25px;

border-radius:20px;

overflow-x:auto;

box-shadow:
0 0 25px rgba(0,0,0,0.3);
}

table{

width:100%;

border-collapse:collapse;
}

th{

background:#2563eb;

padding:15px;

font-size:16px;
}

td{

padding:15px;

text-align:center;

border-bottom:
1px solid rgba(255,255,255,0.1);
}

tr:hover{

background:
rgba(255,255,255,0.05);
}

.balance{

color:#10b981;

font-weight:bold;
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

<div class="header">

<div class="title">

👥 All Users

</div>

<a href="AdminDashboardServlet"
class="back-btn">

🏠 Dashboard

</a>

</div>

<div class="search-box">

<input
type="text"
id="userSearch"
onkeyup="searchUser()"
placeholder="Search User By Name...">

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

if(users != null){

for(User user : users){
%>

<tr>

<td>
<%= user.getId() %>
</td>

<td>
<%= user.getName() %>
</td>

<td>
<%= user.getEmail() %>
</td>

<td>
<%= user.getAccountNumber() %>
</td>

<td class="balance">

₹ <%= user.getBalance() %>

</td>

</tr>

<%
}
}
%>

</table>

</div>

</body>

</html>
