package user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

import dao.Test;
import dao.TestDao;
import dao.UserDao;

@WebServlet("/UserProfile")
public class UserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UserProfile() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		if(session != null && session.getAttribute("user_id") != null) {

			int user_id = (int)session.getAttribute("user_id");
			String phone = UserDao.getPhone(user_id);
			String email = UserDao.getEmail(user_id);
						
			try {
				ArrayList<dao.Result> arr = TestDao.getResults(user_id);
//				ArrayList<String> allTopics = TestDao.getAllTopics();
//				ArrayList<String> allLang = TestDao.getAllLang();
				
				request.setAttribute("resultarr", arr);
				request.setAttribute("phone", phone);
				request.setAttribute("email", email);
				request.getRequestDispatcher("./userPages/profile.jsp").forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else {
			response.sendRedirect("/TakeTest/userPages/userLogin.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
