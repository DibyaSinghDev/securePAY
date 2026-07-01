package com.examshield.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.examshield.dao.UserDAO;
import com.examshield.model.User;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
		String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String phone =
                request.getParameter("phone");

        String password =
                request.getParameter("password");

        String role =
                request.getParameter("role");

        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setRole(role);

        UserDAO dao =
                new UserDAO();

        boolean status =
                dao.registerUser(user);

        if (status) {

            response.sendRedirect(
                    "login.jsp");

        } else {

            response.sendRedirect(
                    "register.jsp");

        }
        
	}

}
