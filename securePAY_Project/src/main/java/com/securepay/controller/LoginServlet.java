package com.securepay.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.securepay.dao.UserDAO;
import com.securepay.model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
		  

		 String email =
	                request.getParameter("email");

	        String password =
	                request.getParameter("password");

	        UserDAO dao = new UserDAO();

	        User user =
	                dao.loginUser(email,password);

	        if(user != null) {

	            HttpSession session =
	                    request.getSession();

	            session.setAttribute("user", user);

	            response.sendRedirect("Dashboard.jsp");

	        } else {

	            response.getWriter()
	                    .println("Invalid Credentials");
	        }
	        
    }
		
	

}
