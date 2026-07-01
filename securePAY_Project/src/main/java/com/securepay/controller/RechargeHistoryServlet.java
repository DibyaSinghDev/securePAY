package com.securepay.controller;

import java.io.IOException;
import java.util.List;

import com.securepay.dao.RechargeDAO;
import com.securepay.model.Recharge;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RechargeHistoryServlet")
public class RechargeHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RechargeDAO rechargeDAO = new RechargeDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("RechargeHistory.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        List<Recharge> rechargeList =
                rechargeDAO.getRechargeHistory(user.getId());

        request.setAttribute("rechargeList", rechargeList);

        request.getRequestDispatcher("RechargeHistory.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}