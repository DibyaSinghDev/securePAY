<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Delete User</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{

height:100vh;

display:flex;

justify-content:center;

align-items:center;

background:
linear-gradient(
135deg,
#020617,
#0f172a,
#1e293b);
}

.card{

width:500px;

padding:40px;

background:
rgba(255,255,255,0.08);

backdrop-filter:blur(15px);

border-radius:25px;

text-align:center;

color:white;
}

input{

width:100%;

padding:15px;

margin:15px 0;

border:none;

border-radius:10px;
}

button{

width:100%;

padding:15px;

border:none;

border-radius:10px;

background:#ef4444;

color:white;

font-size:16px;

cursor:pointer;
}

button:hover{

background:#dc2626;
}

.back{

display:block;

margin-top:15px;

text-decoration:none;

color:white;
}

</style>

</head>

<body>

<div class="card">

<h2>

❌ Delete User

</h2>

<form action="DeleteUserServlet"
method="post">

<input
type="text"
name="accountNumber"
placeholder="Enter Account Number"
required>

<button type="submit">

Delete User

</button>

</form>

<a href="AdminDashboardServlet"
class="back">

🏠 Back To Dashboard

</a>

</div>

</body>

</html>
