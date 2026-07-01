package com.securepay.controller;

import java.io.IOException;
import java.util.List;

import com.securepay.dao.TransactionDAO;
import com.securepay.model.Transaction;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/PassbookServlet")
public class PassbookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TransactionDAO transactionDAO;

    @Override
    public void init() {
        transactionDAO = new TransactionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("user") == null) {

            response.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        String accountNumber = user.getAccountNumber();

        List<Transaction> transactions =
                transactionDAO.getTransactions(accountNumber);

        double totalCredit = 0;
        double totalDebit = 0;

        for(Transaction t : transactions){

            if(t.getTransactionType().equalsIgnoreCase("Credit")){

                totalCredit += t.getAmount();

            }else{

                totalDebit += t.getAmount();

            }
        }

        request.setAttribute("transaction", transactions);
        request.setAttribute("balance", user.getBalance());
        request.setAttribute("accountNumber", accountNumber);
        request.setAttribute("totalCredit", totalCredit);
        request.setAttribute("totalDebit", totalDebit);

        RequestDispatcher rd =
                request.getRequestDispatcher("passbook.jsp");

        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request,response);
    }
}