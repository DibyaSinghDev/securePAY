package com.securepay.controller;

import java.io.IOException;

import com.securepay.dao.LoanDAO;
import com.securepay.model.Loan;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoanServlet")
public class LoanServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private LoanDAO loanDAO = new LoanDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("LoanApplication.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect("Login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        try {

            String loanType =
                    request.getParameter("loanType");

            double loanAmount =
                    Double.parseDouble(
                            request.getParameter("loanAmount"));

            int duration =
                    Integer.parseInt(
                            request.getParameter("duration"));

            double monthlyIncome =
                    Double.parseDouble(
                            request.getParameter("monthlyIncome"));

            String purpose =
                    request.getParameter("purpose");

            Loan loan = new Loan();

            loan.setUserId(user.getId());

            loan.setApplicantName(
                    user.getName());

            loan.setAccountNumber(
                    user.getAccountNumber());

            loan.setEmail(
                    user.getEmail());

            loan.setLoanType(
                    loanType);

            loan.setLoanAmount(
                    loanAmount);

            loan.setDuration(
                    duration);

            loan.setMonthlyIncome(
                    monthlyIncome);

            loan.setPurpose(
                    purpose);

            loan.setStatus(
                    "Pending");

            boolean status =
                    loanDAO.applyLoan(loan);

            if (status) {

                session.setAttribute(
                        "loanSuccess",
                        "Loan Application Submitted Successfully!");

                response.sendRedirect(
                        "LoanSuccess.jsp");

            } else {

                session.setAttribute(
                        "loanError",
                        "Loan Application Failed!");

                response.sendRedirect(
                        "LoanApplication.jsp");
            }

        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute(
                    "loanError",
                    "Something went wrong!");

            response.sendRedirect(
                    "LoanApplication.jsp");
        }

    }

}