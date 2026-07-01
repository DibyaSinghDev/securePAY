<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.examshield.model.Exam" %>

<%
if(session.getAttribute("user") == null){
response.sendRedirect("login.jsp");
return;
}


String username =
        (String) session.getAttribute("username");

if(username == null){
    username = "Student";
}

List<Exam> exams =
        (List<Exam>) request.getAttribute("examList");


%>

<!DOCTYPE html>

<html>

<head>


<title>ExamShield AI | Student Dashboard</title>

<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<link rel="preconnect"
      href="https://fonts.googleapis.com">

<link rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
      rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
        font-family:'Poppins',sans-serif;
    }

    body{
        background:#f1f5f9;
    }

    .sidebar{

        width:280px;
        height:100vh;

        position:fixed;
        left:0;
        top:0;

        background:
                linear-gradient(
                        180deg,
                        #0f172a,
                        #1e293b
                );

        color:white;

        box-shadow:
                10px 0 30px
                rgba(0,0,0,.15);

        z-index:1000;

    }

    .logo{

        text-align:center;
        padding:30px;

        font-size:28px;
        font-weight:700;

        color:#60a5fa;

        border-bottom:
                1px solid rgba(255,255,255,.1);

    }

    .sidebar ul{
        list-style:none;
        padding:20px 0;
    }

    .sidebar ul li{

        margin:8px 15px;
        border-radius:12px;

        transition:.3s;

    }

    .sidebar ul li:hover{

        background:#2563eb;
        transform:translateX(5px);

    }

    .sidebar ul li a{

        color:white;
        text-decoration:none;

        display:block;

        padding:15px 20px;

        font-size:15px;
        font-weight:500;

    }

    .sidebar ul li i{
        margin-right:10px;
    }

    .main{
        margin-left:280px;
    }

    .topbar{

        height:80px;

        background:
                rgba(255,255,255,.8);

        backdrop-filter:
                blur(15px);

        display:flex;

        justify-content:
                space-between;

        align-items:center;

        padding:0 35px;

        border-bottom:
                1px solid #e2e8f0;

    }

    .profile{

        display:flex;
        align-items:center;
        gap:12px;

    }

    .profile img{

        width:50px;
        height:50px;

        border-radius:50%;

        border:3px solid #2563eb;

    }

    .content{
        padding:35px;
    }

    .hero{

        background:
                linear-gradient(
                        135deg,
                        #2563eb,
                        #4f46e5
                );

        color:white;

        padding:40px;

        border-radius:25px;

        box-shadow:
                0 20px 40px
                rgba(37,99,235,.25);

        margin-bottom:30px;

    }

    .hero h2{
        font-weight:700;
    }

    .hero p{
        margin-top:10px;
        opacity:.9;
    }

    .stat-card{

        background:white;

        border-radius:20px;

        padding:25px;

        text-align:center;

        box-shadow:
                0 10px 30px
                rgba(0,0,0,.08);

        transition:.3s;

    }

    .stat-card:hover{

        transform:
                translateY(-8px);

        box-shadow:
                0 15px 40px
                rgba(0,0,0,.12);

    }

    .stat-card i{

        font-size:40px;

        color:#2563eb;

        margin-bottom:12px;

    }

    .stat-card h3{

        font-size:30px;
        font-weight:700;

    }

    .stat-card p{

        color:#64748b;

        margin-top:8px;

    }

    .table-card,
    .notification-card{

        background:white;

        border-radius:20px;

        padding:30px;

        box-shadow:
                0 10px 30px
                rgba(0,0,0,.08);

    }

    .table-card h4,
    .notification-card h4{

        font-weight:700;
        margin-bottom:20px;

    }

    .table th{

        color:#64748b;

        font-size:13px;

        text-transform:uppercase;

        border:none;

    }

    .table td{

        vertical-align:middle;
        padding:18px 10px;

    }

    .start-btn{

        background:
                linear-gradient(
                        135deg,
                        #2563eb,
                        #4f46e5
                );

        border:none;

        color:white;

        border-radius:12px;

        padding:10px 20px;

        font-weight:600;

    }

    .start-btn:hover{

        color:white;

        transform:scale(1.05);

    }

    .notification{

        background:#f8fafc;

        border-left:
                5px solid #2563eb;

        padding:15px;

        margin-bottom:15px;

        border-radius:12px;

    }

    .badge-status{

        background:#dcfce7;

        color:#16a34a;

        padding:6px 12px;

        border-radius:20px;

        font-size:12px;

        font-weight:600;

    }

    @media(max-width:992px){

        .sidebar{
            display:none;
        }

        .main{
            margin-left:0;
        }

    }

</style>


</head>

<body>

<div class="sidebar">


<div class="logo">
    ExamShield AI
</div>

<ul>

    <li>
        <a href="DashboardServlet">
            <i class="fas fa-home"></i>
            Dashboard
        </a>
    </li>

    <li>
        <a href="ExamServlet">
            <i class="fas fa-file-alt"></i>
            Exams
        </a>
    </li>

    <li>
        <a href="#">
            <i class="fas fa-chart-line"></i>
            Results
        </a>
    </li>

    <li>
        <a href="#">
            <i class="fas fa-user"></i>
            Profile
        </a>
    </li>

    <li>
        <a href="LogoutServlet">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </li>

</ul>


</div>

<div class="main">


<div class="topbar">

    <h5>
        Welcome, <%= username %>
    </h5>

    <div class="profile">

        <span>
            Student
        </span>

        <img src="https://ui-avatars.com/api/?name=<%= username %>&background=2563eb&color=fff">

    </div>

</div>

<div class="content">

    <div class="hero">

        <h2>
            Welcome Back, <%= username %> 👋
        </h2>

        <p>
            Ready to conquer your next examination and improve your ranking?
        </p>

    </div>

    <div class="row g-4">

        <div class="col-md-3">

            <div class="stat-card">

                <i class="fas fa-book-open"></i>

                <h3>
                    <%= exams != null ? exams.size() : 0 %>
                </h3>

                <p>Total Exams</p>

            </div>

        </div>

        <div class="col-md-3">

            <div class="stat-card">

                <i class="fas fa-check-circle"></i>

                <h3>0</h3>

                <p>Completed</p>

            </div>

        </div>

        <div class="col-md-3">

            <div class="stat-card">

                <i class="fas fa-clock"></i>

                <h3>
                    <%= exams != null ? exams.size() : 0 %>
                </h3>

                <p>Available Exams</p>

            </div>

        </div>

        <div class="col-md-3">

            <div class="stat-card">

                <i class="fas fa-award"></i>

                <h3>0%</h3>

                <p>Average Score</p>

            </div>

        </div>

    </div>

    <div class="row mt-4">

        <div class="col-lg-8">

            <div class="table-card">

                <h4>
                    Available Exams
                </h4>

                <table class="table table-hover">

                    <thead>

                    <tr>

                        <th>Exam</th>
                        <th>Date</th>
                        <th>Duration</th>
                        <th>Status</th>
                        <th>Action</th>

                    </tr>

                    </thead>

                    <tbody>

                    <%

                        if(exams != null &&
                                !exams.isEmpty()){

                            for(Exam exam : exams){

                    %>

                    <tr>

                        <td>
                            <%= exam.getTitle() %>
                        </td>

                        <td>
                            <%= exam.getExamDate() %>
                        </td>

                        <td>
                            <%= exam.getDuration() %> Min
                        </td>

                        <td>

                            <span class="badge-status">
                                Active
                            </span>

                        </td>

                        <td>

                            <a href="ExamServlet?id=<%= exam.getId() %>"
                               class="btn start-btn">

                                Start Exam

                            </a>

                        </td>

                    </tr>

                    <%

                            }

                        }else{

                    %>

                    <tr>

                        <td colspan="5"
                            class="text-center">

                            No Exams Available

                        </td>

                    </tr>

                    <%

                        }

                    %>

                    </tbody>

                </table>

            </div>

        </div>

        <div class="col-lg-4">

            <div class="notification-card">

                <h4>
                    Notifications
                </h4>

                <div class="notification">
                    📢 New Exams Available
                </div>

                <div class="notification">
                    🔒 AI Proctoring Enabled
                </div>

                <div class="notification">
                    📊 Results Will Appear Here
                </div>

                <div class="notification">
                    🏆 Improve Your Ranking
                </div>

            </div>

        </div>

    </div>

</div>


</div>

</body>

</html>
