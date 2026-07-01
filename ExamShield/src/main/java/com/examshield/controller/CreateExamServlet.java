package com.examshield.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.examshield.dao.ExamDAO;
import com.examshield.model.Exam;

/**
 * Servlet implementation class CreateExamServlet
 */
@WebServlet("/CreateExamServlet")
public class CreateExamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateExamServlet() {
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
	    protected void doPost(
	            HttpServletRequest request,
	            HttpServletResponse response)
	            throws ServletException, IOException {

	        try {

	            String title =
	                    request.getParameter("title");

	            String description =
	                    request.getParameter("description");

	            int duration =
	                    Integer.parseInt(
	                            request.getParameter("duration"));

	            int totalMarks =
	                    Integer.parseInt(
	                            request.getParameter("totalMarks"));

	            String examDate =
	                    request.getParameter("examDate");

	            String status =
	                    request.getParameter("status");

	            Exam exam = new Exam();

	            exam.setTitle(title);
	            exam.setDescription(description);
	            exam.setDuration(duration);
	            exam.setTotalMarks(totalMarks);
	            exam.setExamDate(examDate);
	            exam.setStatus(status);

	            ExamDAO dao = new ExamDAO();

	            boolean result =
	                    dao.addExam(exam);

	            if (result) {

	                request.getSession()
	                        .setAttribute(
	                                "success",
	                                "Exam Created Successfully");

	                response.sendRedirect(
	                        "view-exams.jsp");

	            } else {

	                request.getSession()
	                        .setAttribute(
	                                "error",
	                                "Failed To Create Exam");

	                request.getRequestDispatcher(
	                        "create-exam.jsp");
	            }

	        } catch (Exception e) {

	            e.printStackTrace();

	            request.getSession()
	                    .setAttribute(
	                            "error",
	                            "Something Went Wrong");

	            response.sendRedirect(
	                    "create-exam.jsp");
	        }
	    }
}
