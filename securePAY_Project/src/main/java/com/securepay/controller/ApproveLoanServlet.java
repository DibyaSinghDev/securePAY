package com.securepay.controller;

import java.io.IOException;

import com.securepay.dao.LoanDAO;
import com.securepay.dao.NotificationDAO;
import com.securepay.dao.TransactionDAO;
import com.securepay.model.Loan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ApproveLoanServlet")
public class ApproveLoanServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private LoanDAO loanDAO = new LoanDAO();
    private TransactionDAO transactionDAO = new TransactionDAO();
    private NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int loanId =
                    Integer.parseInt(request.getParameter("loanId"));

            String remark =
                    request.getParameter("remark");

            Loan loan =
                    loanDAO.getLoanById(loanId);

            if (loan == null) {

                response.sendRedirect("AdminLoanServlet");
                return;
            }

            boolean status =
                    loanDAO.approveLoan(loanId, remark);

            if (status) {

                // Save Transaction History
                transactionDAO.addTransaction(
                        "BANK",
                        loan.getAccountNumber(),
                        loan.getLoanAmount(),
                        "Loan Credit");

                // Send Notification
                notificationDAO.addNotification(
                        loan.getUserId(),
                        "Loan Approved",
                        "Congratulations! Your "
                                + loan.getLoanType()
                                + " of ₹"
                                + loan.getLoanAmount()
                                + " has been approved.");

                response.sendRedirect(
                        "AdminLoanServlet");

            } else {

                response.sendRedirect(
                        "LoanDetailsServlet?loanId=" + loanId);
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "AdminLoanServlet");
        }

    }

}