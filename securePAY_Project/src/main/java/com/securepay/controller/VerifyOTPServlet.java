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
import com.securepay.util.AccountGenerator;

/**
 * Servlet implementation class VerifyOTPServlet
 */
@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VerifyOTPServlet() {
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
		 HttpSession session = request.getSession(false);

	        if (session == null) {
	            response.sendRedirect("Register.jsp");
	            return;
	        }

	        String enteredOTP = request.getParameter("otp");
	        String originalOTP = (String) session.getAttribute("otp");

	        if (originalOTP == null) {
	            response.getWriter().println("OTP Session Expired");
	            return;
	        }

	        if (originalOTP.equals(enteredOTP)) {

	            User user = new User();

	            user.setName((String) session.getAttribute("name"));
	            user.setEmail((String) session.getAttribute("email"));
	            user.setPassword((String) session.getAttribute("password"));

	            user.setAccountNumber(
	                    AccountGenerator.generateAccountNumber());

	            user.setBalance(1000);

	            UserDAO dao = new UserDAO();

	            if (dao.registerUser(user)) {

	                session.removeAttribute("otp");
	                session.removeAttribute("name");
	                session.removeAttribute("email");
	                session.removeAttribute("password");

	                response.sendRedirect("Login.jsp");

	            } else {

	                response.getWriter().println(
	                        "Registration Failed");
	            }

	        } else {

	            response.getWriter().println(
	                    "Invalid OTP");
	        }
		
	}

}
