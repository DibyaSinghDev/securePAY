package com.securepay.controller;

import com.securepay.dao.UserDAO;
import com.securepay.util.EmailUtil;
import com.securepay.util.OTPGenerator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        UserDAO dao =
                new UserDAO();

        if (dao.emailExists(email)) {

            response.setContentType("text/html");

            PrintWriter out =
                    response.getWriter();

            out.println("""
<!DOCTYPE html>
<html>
<head>

<title>Already Registered</title>

<meta http-equiv="refresh"
content="3;url=login.jsp">

<style>

body{
height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:linear-gradient(
135deg,#020617,#0f172a,#1e293b);
font-family:'Segoe UI',sans-serif;
}

.card{
background:rgba(255,255,255,0.08);
backdrop-filter:blur(15px);
padding:40px;
border-radius:25px;
text-align:center;
color:white;
box-shadow:0 0 30px #ef4444;
}

.btn{
display:inline-block;
margin-top:15px;
padding:12px 25px;
background:#2563eb;
color:white;
text-decoration:none;
border-radius:10px;
}

</style>

</head>

<body>

<div class="card">

<h2>⚠️ Email Already Registered</h2>

<p>
Redirecting to Login Page...
</p>

<a href="Login.jsp"
class="btn">

🔑 Login Now

</a>

</div>

</body>
</html>
""");

            return;
        }

        String otp =
                OTPGenerator.generateOTP();

        HttpSession session =
                request.getSession();

        session.setAttribute("name", name);
        session.setAttribute("email", email);
        session.setAttribute("password", password);
        session.setAttribute("otp", otp);

        boolean sent =
                EmailUtil.sendOTP(email, otp);

        if (sent) {

            response.sendRedirect(
                    "verifyOTP.jsp");

        } else {

            response.getWriter()
                    .println(
                    "OTP Email Failed");
        }
    }
}