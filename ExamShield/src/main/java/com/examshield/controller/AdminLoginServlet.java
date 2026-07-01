package com.examshield.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.examshield.dao.AdminDAO;
import com.examshield.model.Admin;

/**
 * Servlet implementation class AdminLoginServlet
 */
@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username =
                request.getParameter(
                        "username");

        String password =
                request.getParameter(
                        "password");

        AdminDAO dao =
                new AdminDAO();

        Admin admin =
                dao.login(
                        username,
                        password);

        if(admin != null){

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "admin",
                    admin);
            System.out.println("Admin Login Success");
            System.out.println("Admin Username = " + admin.getUsername());
            System.out.println("Session Admin = " + session.getAttribute("admin"));
            request.getRequestDispatcher("admin.jsp")
            .forward(request,response);

        }else{

            response.sendRedirect(
                    "admin-login.jsp");
        }
	}

}
