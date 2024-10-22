package user;

import java.io.IOException;

import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public UserLogin() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String mobile = request.getParameter("mobile");
		String password = request.getParameter("password");

		try {
			int user_id = UserDao.getUserId(mobile, password);
			if (user_id != -1) {
				String name = UserDao.getUserName(mobile);

				HttpSession session = request.getSession();
				session.setAttribute("user_id", user_id);
				session.setAttribute("name", name);

				response.sendRedirect("/TakeTest/UserDashboard");
			} else {
				response.sendRedirect("/TakeTest/userPages/userLogin.jsp?error=1");
				System.out.println("not a valid user");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
