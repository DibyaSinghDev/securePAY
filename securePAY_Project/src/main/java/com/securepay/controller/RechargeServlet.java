package com.securepay.controller;

import java.io.IOException;

import com.securepay.dao.RechargeDAO;
import com.securepay.dao.TransactionDAO;
import com.securepay.dao.UserDAO;
import com.securepay.model.Recharge;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RechargeServlet")
public class RechargeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RechargeDAO rechargeDAO = new RechargeDAO();
    private UserDAO userDAO = new UserDAO();
    private TransactionDAO transactionDAO = new TransactionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("Recharge.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {

            String serviceType = request.getParameter("serviceType");
            String provider = request.getParameter("provider");
            String customerNumber = request.getParameter("customerNumber");
            double amount = Double.parseDouble(request.getParameter("amount"));

            // Check available balance
            double balance = userDAO.getBalance(user.getAccountNumber());

            if (balance < amount) {

                session.setAttribute("errorMessage",
                        "Insufficient Balance!");

                response.sendRedirect("Recharge.jsp");
                return;
            }

            // Generate Transaction ID
            String transactionId = rechargeDAO.generateTransactionId();

            // Deduct Balance
            boolean deducted = userDAO.rechargeMoney(
                    user.getAccountNumber(),
                    amount);

            if (!deducted) {

                session.setAttribute("errorMessage",
                        "Recharge Failed!");

                response.sendRedirect("Recharge.jsp");
                return;
            }

            // Save Recharge History
            Recharge recharge = new Recharge();

            recharge.setUserId(user.getId());
            recharge.setServiceType(serviceType);
            recharge.setProvider(provider);
            recharge.setCustomerNumber(customerNumber);
            recharge.setAmount(amount);
            recharge.setTransactionId(transactionId);
            recharge.setStatus("SUCCESS");

            rechargeDAO.saveRecharge(recharge);

            // Save Transaction
            transactionDAO.addRechargeTransaction(
                    user.getAccountNumber(),
                    amount,
                    provider,
                    serviceType);

            // Reward Coins
            userDAO.addRewardCoins(
                    user.getAccountNumber(),
                    5);

            // Update session balance
            user.setBalance(balance - amount);
            session.setAttribute("user", user);

            session.setAttribute("transactionId", transactionId);
            session.setAttribute("successMessage",
                    "Recharge Successful!");

            response.sendRedirect("RechargeSuccess.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute("errorMessage",
                    "Something went wrong!");

            response.sendRedirect("Recharge.jsp");
        }
    }
}