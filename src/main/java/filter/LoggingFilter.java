package filter;

import dao.LogDAO;
import dao.impl.LogDAOImpl;
import model.Log;
import model.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoggingFilter implements Filter {
    private LogDAO logDAO = new LogDAOImpl();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        
        String path = req.getServletPath();
        String method = req.getMethod();
        String action = req.getParameter("action");

        if (session != null && session.getAttribute("user") != null && "POST".equalsIgnoreCase(method)) {
            User user = (User) session.getAttribute("user");
            String logAction = "UNKNOWN";
            
            if (action != null) {
                if (action.contains("add")) logAction = "CREATE";
                else if (action.contains("update")) logAction = "UPDATE";
                else if (action.contains("delete")) logAction = "DELETE";
                else if (action.contains("restore")) logAction = "RESTORE";
            }

            if (!"UNKNOWN".equals(logAction)) {
                String module = path.replace("/", "").toUpperCase();
                Log log = new Log(user.getUsername(), logAction, module, req.getRequestURI(), "Automatic log from filter");
                logDAO.add(log);
            }
        }
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
