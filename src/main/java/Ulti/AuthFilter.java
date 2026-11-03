
package Ulti;

import java.io.IOException;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter({"/manager/*", 
			"/employee/*",
			"/barista/*",
			"/DrinkServlet",
			"/Report",
			"/UserList"
			})
public class AuthFilter extends HttpFilter {

    @Override
    protected void doFilter(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();
        String path = uri.substring(contextPath.length());

        // 1. Check whether the user is logged in.
        if (!AuthUtil.isAuthenticated(request)) {

            // Save the intended destination across the redirect.
            HttpSession session = request.getSession();
            session.setAttribute("REDIRECT_URL",
                    path + (request.getQueryString() == null
                            ? ""
                            : "?" + request.getQueryString()));

            response.sendRedirect(contextPath + "/User/dang-nhap.jsp");
            return;
        }

        // 2. Check the user's role for the requested area.
        if (path.startsWith("/manager/")) {
            if (!AuthUtil.isManager(request)) {
                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "You do not have permission to access this page.");
                return;
            }
        }

        if (path.startsWith("/employee/")) {
            if (!AuthUtil.isAuthenticated(request)) {
                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "You do not have permission to access this page.");
                return;
            }
        }
        
        if (path.startsWith("/barista/")
                && !AuthUtil.isBarista(request)) {

        	response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "You do not have permission to access this page.");
            return;
        }
        
        if (path.equals("/DrinkServlet")
                && !AuthUtil.isManager(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        if (path.equals("/Report")
        		&& !AuthUtil.isManager(request)) {
        	response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        if (path.equals("/UserList")
        		&& !AuthUtil.isManager(request)) {
        	response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // 3. Only authorized requests reach the servlet.
        chain.doFilter(request, response);
    }
}
