package com.securepay.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {


private static final long serialVersionUID = 1L;

public ProfileServlet() {
    super();
}

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session =
            request.getSession(false);

    // Check Login

    if(session == null ||
       session.getAttribute("user") == null) {

        response.sendRedirect("Login.jsp");

        return;
    }

    // Forward To Profile Page

   RequestDispatcher rd =
            request.getRequestDispatcher(
                    "Profile.jsp");

    rd.forward(
            request,
            response);
}

@Override
protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    doGet(
            request,
            response);
}


}
