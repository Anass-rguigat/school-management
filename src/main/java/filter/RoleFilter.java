package filter;

import model.User;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class RoleFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            String path = req.getServletPath();

            // Admin only paths
            if ((path.startsWith("/users") || path.startsWith("/archive")) && !"ADMIN".equals(user.getRole())) {
                res.sendRedirect(req.getContextPath() + "/403.jsp");
                return;
            }
            
            // User restriction: No CREATE, UPDATE, DELETE
            if ("USER".equals(user.getRole())) {
                String action = req.getParameter("action");
                if ("add".equals(action) || "update".equals(action) || "delete".equals(action) || "create".equals(action)) {
                    res.sendRedirect(req.getContextPath() + "/403.jsp");
                    return;
                }
            }
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
