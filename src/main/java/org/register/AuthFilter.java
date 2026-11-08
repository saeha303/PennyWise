package org.register;

import java.io.IOException;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Sends visitors without a logged-in session to the login page.
 * Registered in WEB-INF/web.xml for all *.jsp requests; public pages are listed below.
 */
public class AuthFilter implements Filter {

    private static final Set<String> PUBLIC_PAGES = Set.of(
            "indexGuest.jsp", "pages-login.jsp", "pages-register.jsp", "pages-forgot-password.jsp",
            "pages-special-thanks.jsp", "logout.jsp",
            // AJAX endpoint for login/register/reset/demo; actions that need a user check the session themselves
            "changePassword.jsp");

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        String path = request.getServletPath();
        String page = path.substring(path.lastIndexOf('/') + 1);

        HttpSession session = request.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("User") != null;

        if (loggedIn || PUBLIC_PAGES.contains(page)) {
            chain.doFilter(req, res);
        } else {
            ((HttpServletResponse) res).sendRedirect(request.getContextPath() + "/pages-login.jsp");
        }
    }
}
