<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.securepay.model.Notification"%>

<%
List<Notification> notifications =
(List<Notification>)request.getAttribute("notifications");

if(notifications==null){
    notifications = new java.util.ArrayList<>();
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Notifications | SecurePAY</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Segoe UI,sans-serif;
}

body{

background:#f5f7fb;

}

.container{

width:90%;
max-width:900px;
margin:40px auto;

}

.header{

display:flex;
justify-content:space-between;
align-items:center;

margin-bottom:30px;

}

.header h2{

color:#2563eb;

}

.back{

text-decoration:none;
color:#2563eb;
font-weight:bold;

}

.notification{

background:white;

padding:20px;

margin-bottom:18px;

border-radius:15px;

box-shadow:0 8px 20px rgba(0,0,0,.08);

transition:.3s;

animation:fade .4s ease;

}

.notification:hover{

transform:translateY(-4px);

}

.notification h3{

color:#2563eb;

margin-bottom:10px;

}

.notification p{

color:#555;

margin-bottom:10px;

}

.time{

font-size:13px;

color:gray;

}

.empty{

background:white;

padding:60px;

border-radius:15px;

text-align:center;

box-shadow:0 8px 20px rgba(0,0,0,.08);

}

.empty i{

font-size:70px;

color:#2563eb;

margin-bottom:20px;

}

@keyframes fade{

from{

opacity:0;

transform:translateY(20px);

}

to{

opacity:1;

transform:translateY(0);

}

}

</style>

</head>

<body>

<div class="container">

<div class="header">

<h2>

<i class="fa-solid fa-bell"></i>

Notifications

</h2>

<a href="Dashboard.jsp" class="back">

← Dashboard

</a>

</div>

<%

if(notifications.size()==0){

%>

<div class="empty">

<i class="fa-regular fa-bell-slash"></i>

<h2>No Notifications</h2>

<p>

You don't have any notifications yet.

</p>

</div>

<%

}else{

for(Notification n : notifications){

%>

<div class="notification">

<h3>

<%=n.getTitle()%>

</h3>

<p>

<%=n.getMessage()%>

</p>

<div class="time">

<%=n.getCreatedAt()%>

</div>

</div>

<%

}

}

%>

</div>

</body>

</html>