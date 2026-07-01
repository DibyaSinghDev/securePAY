package com.securepay.controller;

import java.io.IOException;

import com.securepay.dao.LoanDAO;
import com.securepay.dao.NotificationDAO;
import com.securepay.model.Loan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RejectLoanServlet")
public class RejectLoanServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private LoanDAO loanDAO = new LoanDAO();
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
                    Integer.parseInt(
                            request.getParameter("loanId"));

            String remark =
                    request.getParameter("remark");

            Loan loan =
                    loanDAO.getLoanById(loanId);

            if (loan == null) {

                response.sendRedirect("AdminLoanServlet");
                return;
            }

            boolean status =
                    loanDAO.rejectLoan(
                            loanId,
                            remark);

            if (status) {

                notificationDAO.addNotification(
                        loan.getUserId(),
                        "Loan Application Rejected",
                        "Your "
                                + loan.getLoanType()
                                + " loan application has been rejected.\nReason : "
                                + remark);

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