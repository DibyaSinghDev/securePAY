package com.securepay.controller;

import com.securepay.dao.NotificationDAO;
import com.securepay.dao.TransactionDAO;
import com.securepay.model.Transaction;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public DashboardServlet() {
        super();
    }

    @Override
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

        String action =
                request.getParameter("action");

        if("Profile".equalsIgnoreCase(action)) {

            response.sendRedirect("Profile.jsp");
            return;
        }

        if("Transaction".equalsIgnoreCase(action)) {

            response.sendRedirect("TransactionServlet");
            return;
        }

        // Mini Statement

        TransactionDAO dao =
                new TransactionDAO();

        List<Transaction> recentTransactions =
                dao.getRecentTransactions(
                        user.getAccountNumber());

        request.setAttribute(
                "recentTransactions",
                recentTransactions);

        NotificationDAO notificationDAO = new NotificationDAO();
        int unreadCount = notificationDAO.getUnreadNotificationCount(user.getId());

        request.setAttribute("unreadCount", unreadCount);
        
        request.getRequestDispatcher(
                "Dashboard.jsp")
                .forward(
                        request,
                        response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}