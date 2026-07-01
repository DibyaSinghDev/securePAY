package com.examshield.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.examshield.dao.ExamDAO;
import com.examshield.model.Exam;

/**
 * Servlet implementation class DashboardServlet
 */
@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 ExamDAO examDAO =
	                new ExamDAO();

	        List<Exam> exams =
	                examDAO.getAllExams();

	        int totalExams =
	                examDAO.getTotalExams();

	        request.setAttribute(
	                "examList",
	                exams);

	        request.setAttribute(
	                "totalExams",
	                totalExams);

	        RequestDispatcher rd =
	                request.getRequestDispatcher(
	                        "dashboard.jsp");

	        rd.forward(
	                request,
	                response);
	    }
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
