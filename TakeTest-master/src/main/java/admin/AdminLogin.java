package admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.AdminDao;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static AdminDao adminDao = new AdminDao();
	
       
    public AdminLogin() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		try {
			if(adminDao.isValidAdmin(username, password)) {
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				response.sendRedirect("/TakeTest/AdminDashboard");
			}else {
				response.sendRedirect("/TakeTest/adminPages/adminLogin.jsp?error=1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//	// TODO Auto-generated method stub
//	response.getWriter().append("Served at: ").append(request.getContextPath());
//}
}