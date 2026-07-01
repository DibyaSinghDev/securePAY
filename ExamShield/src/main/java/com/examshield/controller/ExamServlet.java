package com.examshield.controller;

import com.examshield.dao.QuestionDAO;
import com.examshield.model.Question;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ExamServlet")
public class ExamServlet extends HttpServlet {


private static final long serialVersionUID = 1L;

public ExamServlet() {
    super();
}

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {
	System.out.println("EXAM SERVLET HIT");
    try {

        System.out.println("ExamServlet Called");

        String examIdParam = request.getParameter("id");

        if(examIdParam == null ||
                examIdParam.isEmpty()) {

            response.sendRedirect("DashboardServlet");
            return;
        }

        int examId =
                Integer.parseInt(examIdParam);

        System.out.println(
                "Exam ID = " + examId);

        QuestionDAO dao =
                new QuestionDAO();

        List<Question> questions =
                dao.getQuestionsByExam(examId);

        System.out.println(
                "Questions Loaded = "
                + questions.size());

        request.setAttribute(
                "examId",
                examId);

        request.setAttribute(
                "questions",
                questions);

        RequestDispatcher rd =
                request.getRequestDispatcher(
                        "/exam.jsp");

        rd.forward(
                request,
                response);

    } catch (Exception e) {

        e.printStackTrace();

        response.sendRedirect(
                "DashboardServlet");
    }
}

@Override
protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    doGet(request, response);
}


}
