package com.examshield.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.examshield.dao.QuestionDAO;
import com.examshield.model.Question;

/**
 * Servlet implementation class QuestionServlet
 */
@WebServlet("/QuestionServlet")
public class QustionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QustionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Question q =
		        new Question();

		        q.setExamId(
		        Integer.parseInt(
		        request.getParameter("examId")));

		        q.setQuestionText(
		        request.getParameter(
		        "questionText"));

		        q.setOptionA(
		        request.getParameter(
		        "optionA"));

		        q.setOptionB(
		        request.getParameter(
		        "optionB"));

		        q.setOptionC(
		        request.getParameter(
		        "optionC"));

		        q.setOptionD(
		        request.getParameter(
		        "optionD"));

		        q.setCorrectAnswer(
		        request.getParameter(
		        "correctAnswer"));

		        QuestionDAO dao =
		        new QuestionDAO();

		        dao.addQuestion(q);

		        response.sendRedirect(
		        "ViewExamServlet");
	}

}
