package com.securepay.controller;

import java.io.IOException;
import java.util.List;

import com.securepay.dao.LoanDAO;
import com.securepay.model.Loan;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoanStatusServlet")
public class LoanStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private LoanDAO loanDAO = new LoanDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        List<Loan> loans = loanDAO.getUserLoans(user.getId());

        request.setAttribute("loanList", loans);

        request.getRequestDispatcher("LoanStatus.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);

    }

}