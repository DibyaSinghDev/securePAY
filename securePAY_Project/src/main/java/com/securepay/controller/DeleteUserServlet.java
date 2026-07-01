package com.securepay.controller;

import com.securepay.dao.AdminDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet
extends HttpServlet {


protected void doPost(
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

    String accountNumber =
            request.getParameter(
                    "accountNumber");

    AdminDAO dao =
            new AdminDAO();

    boolean status =
            dao.deleteUser(
                    accountNumber);

    if(status){

        response.getWriter().println("""


<html>

<body style='font-family:Arial;
text-align:center;
margin-top:100px;'>

<h2 style='color:green;'>

✅ User Deleted Successfully

</h2>

<a href='AdminDashboardServlet'>

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

❌ User Not Found

</h2>

<a href='DeleteUser.jsp'>

Try Again

</a>

</body>

</html>

""");
}
}
}
