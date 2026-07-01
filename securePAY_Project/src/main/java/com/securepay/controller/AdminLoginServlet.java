package com.securepay.controller;

import com.securepay.dao.AdminDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        AdminDAO dao =
                new AdminDAO();

        if(dao.validateAdmin(
                username,
                password)) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "admin",
                    username);

            response.sendRedirect(
                    "AdminDashboardServlet");

        } else {

            response.getWriter()
                    .println(
                    "Invalid Admin Credentials");
        }
    }
}