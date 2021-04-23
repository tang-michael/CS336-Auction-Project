package controller;
import persistence.model.user.Admin;
import persistence.model.user.CustomerRepresentative;
import persistence.model.user.EndUser;
import persistence.model.user.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Authentication filter. Ensures only authenticated requests are allowed to certain pages.
 */
@WebFilter({ "/end_user/*", "/cust_rep/*", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;

        // get the authenticated user from the session.
        HttpSession session = httpServletRequest.getSession();
        User authenticatedUser = (User) session.getAttribute(AttributeKeys.AUTHENTICATED_USER);

        // no authenticated user, redirect to login page.
        if(authenticatedUser == null){
            String url = httpServletRequest.getContextPath() + "/?error=Access Denied. Please Login.";
            httpServletResponse.sendRedirect(url);
            return;
        }

        // get the url the user is trying to access.
        String requestURI = httpServletRequest.getRequestURI();

        // validate the eligibility to access the url above.
        boolean isInvalidEndUser = requestURI.contains("end_user") && !(authenticatedUser instanceof EndUser);
        boolean isInvalidAdmin = requestURI.contains("admin") && !(authenticatedUser instanceof Admin);
        boolean isInvalidCustRep = requestURI.contains("cust_rep") && !(authenticatedUser instanceof CustomerRepresentative);

        // if the user is illegible, redirect them to the home page.
        if(isInvalidEndUser || isInvalidAdmin || isInvalidCustRep){
            String url = httpServletRequest.getContextPath() + "/?error=Access Denied. Please Login.";
            httpServletResponse.sendRedirect(url);
            return;
        }

        // continue to the next filter.
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
        // TODO Auto-generated method stub
        
    }
}
