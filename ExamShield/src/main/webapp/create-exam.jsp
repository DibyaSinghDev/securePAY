<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if(session.getAttribute("admin") == null){
        response.sendRedirect("admin-login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <title>Create Exam | ExamShield AI</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>

        body{
            background:#f4f7fc;
        }

        .sidebar{
            width:260px;
            height:100vh;
            position:fixed;
            background:#1e293b;
            color:white;
        }

        .sidebar h2{
            text-align:center;
            padding:20px;
        }

        .sidebar a{
            display:block;
            color:white;
            text-decoration:none;
            padding:15px 25px;
        }

        .sidebar a:hover{
            background:#2563eb;
        }

        .main-content{
            margin-left:260px;
            padding:30px;
        }

        .form-card{
            background:white;
            border-radius:20px;
            padding:30px;
            box-shadow:0 8px 25px rgba(0,0,0,.08);
        }

        .page-title{
            margin-bottom:25px;
        }

    </style>

</head>

<body>

<div class="sidebar">

    <h2>ExamShield AI</h2>

    <a href="admin.jsp">
        <i class="fas fa-home"></i>
        Dashboard
    </a>

    <a href="create-exam.jsp">
        <i class="fas fa-file-alt"></i>
        Create Exam
    </a>

    <a href="view-exams.jsp">
        <i class="fas fa-list"></i>
        View Exams
    </a>

    <a href="logout">
        <i class="fas fa-sign-out-alt"></i>
        Logout
    </a>

</div>

<div class="main-content">

    <div class="page-title">

        <h2>Create New Exam</h2>

        <p>
            Create and schedule a new examination.
        </p>

    </div>

    <div class="form-card">

        <form action="CreateExamServlet"
              method="post">

            <div class="mb-3">

                <label class="form-label">
                    Exam Title
                </label>

                <input type="text"
                       name="title"
                       class="form-control"
                       required>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Description
                </label>

                <textarea name="description"
                          rows="4"
                          class="form-control"
                          required></textarea>

            </div>

            <div class="row">

                <div class="col-md-6">

                    <div class="mb-3">

                        <label class="form-label">
                            Duration (Minutes)
                        </label>

                        <input type="number"
                               name="duration"
                               class="form-control"
                               required>

                    </div>

                </div>

                <div class="col-md-6">

                    <div class="mb-3">

                        <label class="form-label">
                            Total Marks
                        </label>

                        <input type="number"
                               name="totalMarks"
                               class="form-control"
                               required>

                    </div>

                </div>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Exam Date & Time
                </label>

                <input type="datetime-local"
                       name="examDate"
                       class="form-control"
                       required>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Status
                </label>

                <select name="status"
                        class="form-select">

                    <option value="ACTIVE">
                        Active
                    </option>

                    <option value="INACTIVE">
                        Inactive
                    </option>

                </select>

            </div>

            <button type="submit"
                    class="btn btn-primary">

                <i class="fas fa-save"></i>
                Create Exam

            </button>

        </form>

    </div>

</div>

</body>
</html>