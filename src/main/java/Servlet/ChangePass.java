package Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import DAO.UserDAO;
import Entity.Bill;
import Entity.Users;

/**
 * Servlet implementation class ChangePass
 */
@WebServlet("/ChangePass")
public class ChangePass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePass() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		Users user = (Users) session.getAttribute("user");
		UserDAO dao = new UserDAO();
		
		String pass = request.getParameter("pass");
		String newPass = request.getParameter("newPass");
		String newPass2 = request.getParameter("newPass2");
		
		if(user.getPassword().equals(pass)&&newPass.equals(newPass2)) {
			dao.UpdateUser(new Users(user.getUserId(), user.getUserName(), newPass , user.getUserPhone(), user.getRole(), user.getEmail(), user.getBills()));
			request.setAttribute("mess", "Đổi pass thành công");
		}else {
			request.setAttribute("mess", "Sai thông tin");
		}
		System.out.println(user);
		request.getRequestDispatcher("Quenmatkhau.jsp").forward(request, response);
		
		
		
		
		
	}

	private Users Users(Integer userId, String userName, String pass, String userPhone, String role, String email,
			List<Bill> bills) {
		// TODO Auto-generated method stub
		return null;
	}

}
