package com.examshield.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter({
    "/dashboard.jsp",
    "/exam.jsp",
    "/result.jsp",
    "/admin.jsp",
    "/create-exam.jsp",
    "/add-question.jsp",
    "/view-exams.jsp",
    "/view-results.jsp"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)

            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse res =
                (HttpServletResponse) response;

        HttpSession session =
        		req.getSession(false);

        		boolean studentLoggedIn =
        		session != null &&
        		session.getAttribute("user") != null;

        		boolean adminLoggedIn =
        		session != null &&
        		session.getAttribute("admin") != null;

        		if(studentLoggedIn || adminLoggedIn){

        		
        		chain.doFilter(request, response);
        		

        		}else{

        		res.sendRedirect("login.jsp");
        		

        		}

    }
}