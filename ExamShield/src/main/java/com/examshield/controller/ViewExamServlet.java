package com.examshield.controller;

import com.examshield.dao.ExamDAO;
import com.examshield.model.Exam;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ViewExamServlet")
public class ViewExamServlet extends HttpServlet {


private static final long serialVersionUID = 1L;

public ViewExamServlet() {
    super();
}

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {

        ExamDAO examDAO =
                new ExamDAO();

        List<Exam> exams =
                examDAO.getAllExams();

        request.setAttribute(
                "examList",
                exams);

        RequestDispatcher rd =
                request.getRequestDispatcher(
                        "/view-exams.jsp");

        rd.forward(
                request,
                response);

    } catch (Exception e) {

        e.printStackTrace();

        response.getWriter().println(
                "Error loading exams");
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
