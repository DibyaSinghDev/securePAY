package com.securepay.controller;

import com.securepay.dao.AdminDAO;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/ViewUsersServlet")
public class ViewUsersServlet extends HttpServlet {


private static final long serialVersionUID = 1L;

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

    List<User> users =
            dao.getAllUsers();

    request.setAttribute(
            "users",
            users);

    request.getRequestDispatcher(
            "ViewUsers.jsp")
            .forward(
                    request,
                    response);
}

protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    doGet(request,response);
}

}
