package com.securepay.controller;

import com.securepay.dao.UserDAO;
import com.securepay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet
        extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session == null ||
           session.getAttribute("user") == null) {

            response.sendRedirect("Login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        String oldPassword =
                request.getParameter(
                        "oldPassword");

        String newPassword =
                request.getParameter(
                        "newPassword");

        String confirmPassword =
                request.getParameter(
                        "confirmPassword");

        if(!newPassword.equals(
                confirmPassword)) {

            response.getWriter().println(
                    "New Password And Confirm Password Do Not Match");

            return;
        }

        UserDAO dao =
                new UserDAO();

        boolean status =
                dao.changePassword(
                        user.getEmail(),
                        oldPassword,
                        newPassword);

        if(status) {

            response.getWriter().println("""

<html>
<body style='font-family:Arial;
text-align:center;
margin-top:100px;'>

<h2 style='color:green;'>
✅ Password Changed Successfully
</h2>

<a href='Dashboard.jsp'>
Back To Dashboard
</a>

</body>
</html>

""");

        } else {

            response.getWriter().println("""

<html>
<body style='font-family:Arial;
text-align:center;
margin-top:100px;'>

<h2 style='color:red;'>
❌ Old Password Incorrect
</h2>

<a href='ChangePassword.jsp'>
Try Again
</a>

</body>
</html>

""");
        }
    }
}