package com.securepay.controller;

import com.securepay.dao.TransactionDAO;
import com.securepay.dao.UserDAO;
import com.securepay.model.User;
import com.securepay.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/WithdrawServlet")
public class WithdrawServlet extends HttpServlet {

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
                userDAO.withdrawMoney(
                        user.getAccountNumber(),
                        amount);

        if(status) {

            TransactionDAO tdao =
                    new TransactionDAO();

            tdao.addTransaction(
                    user.getAccountNumber(),
                    user.getAccountNumber(),
                    amount,
                    "WITHDRAW");

            double newBalance =
                    user.getBalance() - amount;

            user.setBalance(
                    newBalance);

            session.setAttribute(
                    "user",
                    user);

            EmailUtil.sendTransactionMail(
                    user.getEmail(),
                    "WITHDRAW",
                    amount,
                    newBalance);

            response.sendRedirect(
                    "DashboardServlet");

        } else {

            response.setContentType(
                    "text/html");

            response.getWriter().println("""

<html>
<head>
<title>Withdraw Failed</title>
</head>

<body style='font-family:Arial;
text-align:center;
margin-top:100px;'>

<h2 style='color:red;'>

❌ Insufficient Balance

</h2>

<br>

<a href='Withdraw.jsp'>

Try Again

</a>

</body>
</html>

""");
        }
    }

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }
}