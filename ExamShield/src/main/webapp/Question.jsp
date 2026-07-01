<%@ page import="java.util.List"%>
<%@ page import="com.examshield.model.Exam"%>

<%
if(session.getAttribute("admin")==null){

    response.sendRedirect("admin-login.jsp");
    return;
}

List<Exam> exams =
(List<Exam>)request.getAttribute("examList");
%>

<!DOCTYPE html>
<html>
<head>
<title>Add Question</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">
</head>

<body>

<div class="container mt-5">

<h2>Add Question</h2>

<form action="QuestionServlet"
      method="post">

    <label>Select Exam</label>

    <select name="examId"
            class="form-control mb-3">

        <% for(Exam exam : exams){ %>

        <option value="<%=exam.getId()%>">

            <%=exam.getTitle()%>

        </option>

        <% } %>

    </select>

    <textarea
        name="questionText"
        class="form-control mb-3"
        placeholder="Question"
        required>
    </textarea>

    <input type="text"
           name="optionA"
           class="form-control mb-2"
           placeholder="Option A">

    <input type="text"
           name="optionB"
           class="form-control mb-2"
           placeholder="Option B">

    <input type="text"
           name="optionC"
           class="form-control mb-2"
           placeholder="Option C">

    <input type="text"
           name="optionD"
           class="form-control mb-2"
           placeholder="Option D">

    <select name="correctAnswer"
            class="form-control mb-3">

        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>

    </select>

    <button class="btn btn-success">

        Add Question

    </button>

</form>

</div>

</body>
</html>