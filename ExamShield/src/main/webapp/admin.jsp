<%
if(session.getAttribute("admin")==null){

    response.sendRedirect(
            "admin-login.jsp");

    return;
}
%>
<%
System.out.println("Admin Session = " +
        session.getAttribute("admin"));
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">
</head>

<body>

<div class="container mt-5">

<h2>Admin Dashboard</h2>

<hr>

<a href="create-exam.jsp"
   class="btn btn-success">

   Create Exam

</a>

<a href="add-question.jsp"
   class="btn btn-primary">

   Add Question

</a>

<a href="view-results.jsp"
   class="btn btn-warning">

   Results

</a>
<a href="ViewExamServlet"
   class="btn btn-primary">

   View Exams

</a>

<a href="AdminLogoutServlet"
   class="btn btn-danger">

   Logout

</a>

</div>

</body>
</html>