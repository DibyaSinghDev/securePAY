package com.securepay.controller;

import java.io.IOException;
import java.util.List;

import com.securepay.dao.NotificationDAO;
import com.securepay.model.Notification;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private NotificationDAO notificationDAO =
            new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session==null ||
                session.getAttribute("user")==null){

            response.sendRedirect("Login.jsp");
            return;
        }

        User user =
                (User)session.getAttribute("user");

        List<Notification> list =
                notificationDAO.getNotifications(
                        user.getId());

        request.setAttribute(
                "notifications",
                list);

        request.getRequestDispatcher(
                "Notifications.jsp")
                .forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request,response);

    }

}