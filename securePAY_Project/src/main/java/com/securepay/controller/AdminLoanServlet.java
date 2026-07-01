package com.securepay.controller;

import java.io.IOException;
import java.util.List;

import com.securepay.dao.LoanDAO;
import com.securepay.model.Loan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminLoanServlet")
public class AdminLoanServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private LoanDAO loanDAO = new LoanDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Loan> loanList =
                loanDAO.getAllLoanApplications();

        request.setAttribute("loanList", loanList);

        request.getRequestDispatcher("AdminLoanDashboard.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}