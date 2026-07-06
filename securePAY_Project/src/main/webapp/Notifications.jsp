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
<meta name="viewport" content="width=device-width,initial-scale=1.0">

<title>Notifications | SecurePAY</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">

<style>

:root{
  --ink:#0B1B33;
  --ink-2:#14294c;
  --gold:#C9A44C;
  --gold-soft:#e4c98a;
  --paper:#F7F4EC;
  --paper-line:#E4DFC9;
  --ledger-ink:#1F2A3B;
  --muted:#6B7280;
}

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Inter',sans-serif;
}

body{
background:
  radial-gradient(ellipse at top left, rgba(201,164,76,.10), transparent 55%),
  linear-gradient(160deg,var(--ink) 0%,var(--ink-2) 55%,#0d2044 100%);
color:#fff;
min-height:100vh;
}

.container{
width:92%;
max-width:760px;
margin:44px auto 70px;
}

.header{
display:flex;
justify-content:space-between;
align-items:center;
flex-wrap:wrap;
gap:14px;
margin-bottom:34px;
}

.header h2{
font-family:'Fraunces',serif;
font-weight:600;
font-size:28px;
display:flex;
align-items:center;
gap:12px;
}

.header h2 i{
width:46px;height:46px;border-radius:12px;
background:linear-gradient(155deg,#1a3663,#0e2145);
border:1px solid rgba(201,164,76,.35);
color:var(--gold);
display:flex;align-items:center;justify-content:center;font-size:18px;
}

.back{
text-decoration:none;
font-weight:600;
font-size:13.5px;
color:var(--gold-soft);
padding:10px 18px;
border:1px solid rgba(201,164,76,.35);
border-radius:10px;
transition:.2s;
}
.back:hover{background:rgba(201,164,76,.12);color:var(--gold)}

/* ---------- Timeline ---------- */
.timeline{
position:relative;
padding-left:52px;
}
.timeline::before{
content:"";
position:absolute;
left:15px;top:6px;bottom:6px;
width:2px;
background:linear-gradient(rgba(201,164,76,.55), rgba(201,164,76,.08));
}

.entry{
position:relative;
margin-bottom:34px;
animation:fade .5s ease both;
}
.entry:last-child{margin-bottom:0}

.marker{
position:absolute;
left:-52px;top:2px;
width:32px;height:32px;
border-radius:50%;
background:var(--ink);
border:2px solid var(--gold);
color:var(--gold-soft);
display:flex;align-items:center;justify-content:center;
font-size:13px;
z-index:2;
}

/* ---------- Notice slip ---------- */
.slip{
position:relative;
background:var(--paper);
color:var(--ledger-ink);
padding:22px 24px 20px;
border-radius:4px 4px 14px 14px;
box-shadow:0 16px 34px rgba(0,0,0,.28);
margin-top:12px;
transition:transform .25s;
}
.slip:hover{transform:translateY(-3px)}

/* torn-paper top edge, pinned-memo feel */
.slip::before{
content:"";
position:absolute;
top:-9px;left:0;right:0;height:18px;
background-image:
  linear-gradient(45deg, var(--paper) 50%, transparent 50%),
  linear-gradient(-45deg, var(--paper) 50%, transparent 50%);
background-size:18px 18px;
background-position:0 0;
background-repeat:repeat-x;
}

/* pin dot */
.slip::after{
content:"";
position:absolute;
top:-4px;left:22px;
width:9px;height:9px;
border-radius:50%;
background:var(--gold);
box-shadow:0 2px 4px rgba(0,0,0,.3);
}

.slip h3{
font-family:'Fraunces',serif;
font-size:17px;
font-weight:600;
color:var(--ink);
margin-bottom:8px;
padding-right:6px;
}

.slip p{
font-size:14px;
color:#4b5563;
line-height:1.6;
margin-bottom:12px;
}

.time{
font-family:'IBM Plex Mono',monospace;
font-size:12px;
color:var(--muted);
display:flex;
align-items:center;
gap:6px;
}
.time i{font-size:10px;color:var(--gold)}

@keyframes fade{
from{opacity:0;transform:translateY(16px)}
to{opacity:1;transform:translateY(0)}
}

/* ---------- Empty state ---------- */
.empty{
background:var(--paper);color:var(--ledger-ink);
padding:70px 40px;
text-align:center;
border-radius:18px;
box-shadow:0 20px 45px rgba(0,0,0,.3);
margin-left:-52px;
}
.empty i{font-size:56px;color:var(--gold);margin-bottom:18px}
.empty h2{font-family:'Fraunces',serif;font-size:22px;margin-bottom:8px;color:var(--ink)}
.empty p{color:var(--muted);font-size:14px}

@media(max-width:700px){
.container{width:94%}
.timeline{padding-left:42px}
.timeline::before{left:12px}
.marker{left:-42px;width:26px;height:26px;font-size:11px}
.empty{margin-left:-42px}
}

</style>
</head>

<body>

<div class="container">

<div class="header">
<h2><i class="fa-solid fa-bell"></i>Notifications</h2>
<a href="Dashboard.jsp" class="back">← Dashboard</a>
</div>

<%
if(notifications.size()==0){
%>

<div class="empty">
<i class="fa-regular fa-bell-slash"></i>
<h2>No Notifications</h2>
<p>You don't have any notifications yet.</p>
</div>

<%
}else{
%>

<div class="timeline">
<%
for(Notification n : notifications){
%>
<div class="entry">
<div class="marker"><i class="fa-solid fa-bell"></i></div>
<div class="slip">
<h3><%=n.getTitle()%></h3>
<p><%=n.getMessage()%></p>
<div class="time"><i class="fa-solid fa-circle"></i><%=n.getCreatedAt()%></div>
</div>
</div>
<%
}
%>
</div>

<%
}
%>

</div>

</body>

</html>
