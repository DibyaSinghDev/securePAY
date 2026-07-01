package com.securepay.controller;

import com.securepay.dao.TransactionDAO;
import com.securepay.dao.UserDAO;
import com.securepay.model.User;
import com.securepay.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/DepositServlet")
public class DepositeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
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

        double amount =
                Double.parseDouble(
                        request.getParameter("amount"));

        UserDAO userDAO =
                new UserDAO();

        boolean status =
                userDAO.depositMoney(
                        user.getAccountNumber(),
                        amount);

        if(status) {

            TransactionDAO tdao =
                    new TransactionDAO();

            tdao.addTransaction(
                    user.getAccountNumber(),
                    user.getAccountNumber(),
                    amount,
                    "DEPOSIT");

            double newBalance =
                    user.getBalance() + amount;

            user.setBalance(
                    newBalance);

            session.setAttribute(
                    "user",
                    user);

            EmailUtil.sendTransactionMail(
                    user.getEmail(),
                    "DEPOSIT",
                    amount,
                    newBalance);

            response.sendRedirect(
                    "DashboardServlet");

        } else {

            response.getWriter().println(
                    "Deposit Failed");
        }
    }

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }
}