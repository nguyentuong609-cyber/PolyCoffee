package Ulti;

import Entity.Users;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AuthUtil {

	
	public static final String SESSION_USER="user";
	
	public static void setUser(HttpServletRequest req, Users user) {
		HttpSession session = req.getSession();
		session.setAttribute(SESSION_USER, user);
	}
	
	
	public static Users getUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);

        if (session == null) {
            return null;
        }

        return (Users) session.getAttribute(SESSION_USER);
    }
	
	
	public static boolean isAuthenticated(HttpServletRequest req) {
		return getUser(req) != null;		
	}
	
	public static boolean isManager(HttpServletRequest req) {
		Users u = getUser(req);
		return u != null && "ADMIN".equals(u.getRole());
	}
	
	public static boolean isBarista(HttpServletRequest req) {
		Users u = getUser(req);
		return u != null && "BARISTA".equals(u.getRole());
	}
	
	public static boolean isUser(HttpServletRequest req) {
		Users u = getUser(req);
		return u != null && "USER".equals(u.getRole());
	}
	
	public static void clear(HttpServletRequest req) {
        HttpSession session = req.getSession(false);

        if (session != null) {
            session.invalidate();
        }
    }
}
