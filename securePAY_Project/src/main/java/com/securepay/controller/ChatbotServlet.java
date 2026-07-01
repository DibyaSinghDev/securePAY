package com.securepay.controller;

import java.io.IOException;
import java.util.List;

import com.securepay.dao.TransactionDAO;
import com.securepay.model.Transaction;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ChatbotServlet")
public class ChatbotServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TransactionDAO transactionDAO;

    @Override
    public void init() {
        transactionDAO = new TransactionDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("user") == null) {
            response.getWriter().write("Please login first.");
            return;
        }

        User user = (User) session.getAttribute("user");

        String msg = request.getParameter("message");

        if(msg == null) {
            response.getWriter().write("Please enter a message.");
            return;
        }

        msg = msg.toLowerCase().trim();

        String reply = "";

        if(msg.contains("hi") || msg.contains("hello")) {

            reply = "👋 Hello " + user.getName() + "! Welcome to SecurePAY.";

        }

        else if(msg.contains("balance")) {

            reply = "💰 Your current balance is ₹" +
                    String.format("%.2f", user.getBalance());

        }

        else if(msg.contains("account")) {

            reply = "🏦 Your Account Number is : "
                    + user.getAccountNumber();

        }

        else if(msg.contains("last transaction")
                || msg.contains("recent transaction")) {

            List<Transaction> list =
                    transactionDAO.getRecentTransactions(
                            user.getAccountNumber());

            if(list.isEmpty()) {

                reply = "No recent transactions.";

            } else {

                StringBuilder sb = new StringBuilder();

                sb.append("📄 Last Transactions:\n\n");

                for(Transaction t : list) {

                    sb.append(t.getTransactionType())
                      .append(" - ₹")
                      .append(t.getAmount())
                      .append("\n");
                }

                reply = sb.toString();
            }

        }

        else if(msg.contains("transfer")) {

            reply = "Open Dashboard → Transfer Money → Enter Receiver Account → Amount → Transfer.";

        }

        else if(msg.contains("recharge")) {

            reply = "Go to Recharge section and choose Mobile, DTH or Electricity.";

        }

        else if(msg.contains("passbook")) {

            reply = "Open Passbook from Dashboard to view all transactions.";

        }

        else if(msg.contains("loan")) {

            reply = "SecurePAY currently supports Personal Loan and Education Loan (Demo).";

        }

        else if(msg.contains("thank")) {

            reply = "😊 You're welcome! Happy Banking.";

        }

        else {

            reply = "🤖 Sorry, I didn't understand that.\n\nTry asking:\n• Balance\n• Account Number\n• Recent Transactions\n• Transfer\n• Recharge\n• Passbook";
        }

        response.getWriter().print(reply);

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request,response);
    }
}