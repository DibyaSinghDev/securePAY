package com.examshield.controller;

import com.examshield.dao.AdminDAO;
import com.examshield.dao.UserDAO;
import com.examshield.model.Admin;
import com.examshield.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {


private static final long serialVersionUID = 1L;

public LoginServlet() {
    super();
}

@Override
protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    String email =
            request.getParameter("email");

    String password =
            request.getParameter("password");

    String role =
            request.getParameter("role");

    try {

        // ADMIN LOGIN

        if ("admin".equals(role)) {

            AdminDAO adminDAO =
                    new AdminDAO();

            Admin admin =
                    adminDAO.login(
                            email,
                            password);

            if (admin != null) {

                HttpSession session =
                        request.getSession();

                session.setAttribute(
                        "admin",
                        admin);

                session.setAttribute(
                        "adminName",
                        admin.getUsername());

                response.sendRedirect(
                        "admin.jsp");

            } else {

                request.setAttribute(
                        "error",
                        "Invalid Admin Credentials");

                request.getRequestDispatcher(
                        "login.jsp")
                        .forward(
                                request,
                                response);
            }

        }

        // STUDENT LOGIN

        else {

            UserDAO userDAO =
                    new UserDAO();

            User user =
                    userDAO.loginUser(
                            email,
                            password,
                            role);

            if (user != null) {

                HttpSession session =
                        request.getSession();

                session.setAttribute(
                        "user",
                        user);

                session.setAttribute(
                        "username",
                        user.getName());

                session.setAttribute(
                        "role",
                        user.getRole());

                response.sendRedirect(
                        "DashboardServlet");

            } else {

                request.setAttribute(
                        "error",
                        "Invalid Email or Password");

                request.getRequestDispatcher(
                        "login.jsp")
                        .forward(
                                request,
                                response);
            }
        }

    } catch (Exception e) {

        e.printStackTrace();

        request.setAttribute(
                "error",
                "Something went wrong");

        request.getRequestDispatcher(
                "login.jsp")
                .forward(
                        request,
                        response);
    }
}

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    doPost(request, response);
}


}
