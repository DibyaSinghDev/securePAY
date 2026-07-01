package com.securepay.controller;

import java.io.IOException;

import com.securepay.dao.LoanDAO;
import com.securepay.model.Loan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LoanDetailsServlet")
public class LoanDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private LoanDAO loanDAO = new LoanDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int loanId = Integer.parseInt(
                    request.getParameter("loanId"));

            Loan loan = loanDAO.getLoanById(loanId);

            request.setAttribute("loan", loan);

            request.getRequestDispatcher(
                    "LoanDetails.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "AdminLoanServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }

}