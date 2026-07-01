package com.securepay.controller;

import com.securepay.dao.TransactionDAO;
import com.securepay.model.Transaction;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session == null ||
           session.getAttribute("user") == null) {

            response.sendRedirect("Login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        TransactionDAO dao =
                new TransactionDAO();

        List<Transaction> transactions =
                dao.getTransactions(
                        user.getAccountNumber());

        request.setAttribute(
                "transactions",
                transactions);

        request.getRequestDispatcher(
                "Transaction.jsp")
                .forward(
                        request,
                        response);
    }

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request,response);
    }
}