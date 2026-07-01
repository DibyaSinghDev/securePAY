package com.securepay.controller;

import com.securepay.dao.AdminDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session == null ||
           session.getAttribute("admin") == null) {

            response.sendRedirect(
                    "AdminLogin.jsp");

            return;
        }

        AdminDAO dao =
                new AdminDAO();

        request.setAttribute(
                "totalUsers",
                dao.getTotalUsers());

        request.setAttribute(
                "totalTransactions",
                dao.getTotalTransactions());

        request.setAttribute(
                "totalBalance",
                dao.getTotalBalance());

        request.getRequestDispatcher(
                "AdminDashboard.jsp")
                .forward(
                        request,
                        response);
    }
}