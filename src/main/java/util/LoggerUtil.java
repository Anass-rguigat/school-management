package util;

import dao.LogDAO;
import dao.impl.LogDAOImpl;
import model.Log;
import model.User;
import javax.servlet.http.HttpServletRequest;

public class LoggerUtil {
    private static LogDAO logDAO = new LogDAOImpl();

    public static void log(HttpServletRequest request, String action, String module, String details) {
        User user = (User) request.getSession().getAttribute("user");
        String username = (user != null) ? user.getUsername() : "Anonymous";
        String url = request.getRequestURL().toString();
        if (request.getQueryString() != null) {
            url += "?" + request.getQueryString();
        }
        
        Log log = new Log(username, action, module, url, details);
        logDAO.add(log);
    }
}
