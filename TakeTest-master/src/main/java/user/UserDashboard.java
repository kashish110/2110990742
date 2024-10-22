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

@WebServlet("/UserDashboard")
public class UserDashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UserDashboard() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		if(session != null && session.getAttribute("user_id") != null) {
			try {
				ArrayList<Test> arr = TestDao.getAllTests();
				ArrayList<String> allTopics = TestDao.getAllTopics();
				ArrayList<String> allLang = TestDao.getAllLang();
				
				request.setAttribute("allTopics", allTopics);
				request.setAttribute("allLang", allLang);
				request.setAttribute("tests", arr);
				request.getRequestDispatcher("./userPages/userDashboard.jsp").forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			response.sendRedirect("/TakeTest/userPages/userLogin.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
