package com.securepay.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/admin")
public class AdminFilter implements Filter {

    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpSession session =
                req.getSession(false);

        if(session != null &&
                session.getAttribute("admin") != null) {

            chain.doFilter(
                    request,
                    response);

        } else {

            HttpServletResponse res =
                    (HttpServletResponse) response;

            res.sendRedirect("adminLogin.jsp");
        }
    }
}