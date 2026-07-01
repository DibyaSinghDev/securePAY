<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.examshield.model.Exam" %>

<%
if(session.getAttribute("admin") == null){


    response.sendRedirect("admin-login.jsp");
    return;
}

List<Exam> exams =
        (List<Exam>) request.getAttribute("examList");


%>

<!DOCTYPE html>

<html>

<head>


<title>View Exams | ExamShield Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

    body{
        background:#f4f7fc;
        font-family:'Segoe UI',sans-serif;
    }

    .header{

        background:#2563eb;
        color:white;

        padding:20px 40px;

        display:flex;
        justify-content:space-between;
        align-items:center;
    }

    .container-box{

        background:white;

        padding:30px;

        margin-top:30px;

        border-radius:15px;

        box-shadow:
        0 5px 20px rgba(0,0,0,.08);
    }

    .table th{

        background:#2563eb;
        color:white;
    }

</style>


</head>

<body>

<div class="header">


<h3>
    ExamShield Admin
</h3>

<a href="admin.jsp"
   class="btn btn-light">

    Dashboard

</a>


</div>

<div class="container mt-4">

<div class="container-box">

    <div class="d-flex
                justify-content-between
                align-items-center
                mb-4">

        <h3>
            All Exams
        </h3>

        <a href="create-exam.jsp"
           class="btn btn-success">

            <i class="fas fa-plus"></i>

            Create Exam

        </a>

    </div>

    <table class="table table-bordered table-hover">

        <thead>

        <tr>

            <th>ID</th>

            <th>Title</th>

            <th>Description</th>

            <th>Duration</th>

            <th>Total Marks</th>

            <th>Exam Date</th>

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
                <%= exam.getId() %>
            </td>

            <td>
                <%= exam.getTitle() %>
            </td>

            <td>
                <%= exam.getDescription() %>
            </td>

            <td>
                <%= exam.getDuration() %> Min
            </td>

            <td>
                <%= exam.getTotalMarks() %>
            </td>

            <td>
                <%= exam.getExamDate() %>
            </td>

        </tr>

        <%

                }

            }else{

        %>

        <tr>

            <td colspan="6"
                class="text-center">

                No Exams Found

            </td>

        </tr>

        <%

            }

        %>

        </tbody>

    </table>

</div>


</div>

</body>

</html>
