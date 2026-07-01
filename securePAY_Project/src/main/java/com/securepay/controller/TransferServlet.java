package com.securepay.controller;

import com.securepay.dao.TransactionDAO;
import com.securepay.dao.UserDAO;
import com.securepay.model.User;
import com.securepay.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/TransferServlet")
public class TransferServlet extends HttpServlet {

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

        String senderAccount =
                user.getAccountNumber();

        String receiverAccount =
                request.getParameter("receiverAccount");

        double amount =
                Double.parseDouble(
                        request.getParameter("amount"));

        UserDAO userDAO =
                new UserDAO();

        boolean debitStatus =
                userDAO.transferMoney(
                        senderAccount,
                        amount);
        if(debitStatus) {

        	
        	userDAO.creditReceiver(
        	        receiverAccount,
        	        amount);

        	TransactionDAO dao =
        	        new TransactionDAO();

        	dao.addTransaction(
        	        senderAccount,
        	        receiverAccount,
        	        amount,
        	        "TRANSFER");

        	double newBalance =
        	        user.getBalance() - amount;

        	user.setBalance(
        	        newBalance);

        	session.setAttribute(
        	        "user",
        	        user);

        	EmailUtil.sendTransactionMail(
        	        user.getEmail(),
        	        "TRANSFER",
        	        amount,
        	        newBalance);

        	int rewardCoins =
        	        Math.max(
        	                5,
        	                (int)(amount / 100));

        	session.setAttribute(
        	        "transferSuccess",
        	        true);

        	session.setAttribute(
        	        "rewardCoins",
        	        rewardCoins);

        	session.setAttribute(
        	        "transferAmount",
        	        amount);

        	response.sendRedirect(
        	        "DashboardServlet");
        	

        	} else {

        	
        	response.setContentType(
        	        "text/html");

        	PrintWriter out =
        	        response.getWriter();

        	out.println("""

        	<!DOCTYPE html>
        	<html>
        	<head>
        	<title>Transfer Failed</title>
        	<style>
        	body{
        	    height:100vh;
        	    display:flex;
        	    justify-content:center;
        	    align-items:center;
        	    background:#0f172a;
        	    color:white;
        	    font-family:'Segoe UI',sans-serif;
        	}

        	.card{
        	    width:450px;
        	    padding:35px;
        	    text-align:center;
        	    border-radius:25px;
        	    background:#111827;
        	}

        	.btn{
        	    display:block;
        	    margin-top:20px;
        	    padding:15px;
        	    background:#2563eb;
        	    color:white;
        	    text-decoration:none;
        	    border-radius:12px;
        	}
        	</style>
        	</head>
        	<body>

        	<div class="card">

        	    <h1>❌ Transfer Failed</h1>

        	    <p>
        	    Insufficient balance or invalid account.
        	    </p>

        	    <a href="Transfer.jsp"
        	    class="btn">

        	    Try Again

        	    </a>

        	</div>

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