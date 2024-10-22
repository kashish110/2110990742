package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.*;

import dao.Test;
import dao.TestDao;

@WebServlet("/AdminDashboard")
public class AdminDashboard extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public AdminDashboard() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		if(session != null && session.getAttribute("username") != null) {
			try {				
				ArrayList<Test> arr = TestDao.getAllTests();
				ArrayList<String> allTopics = TestDao.getAllTopics();
				ArrayList<String> allLang = TestDao.getAllLang();
				
				request.setAttribute("allTopics", allTopics);
				request.setAttribute("allLang", allLang);
				request.setAttribute("tests", arr);
				
				request.getRequestDispatcher("./adminPages/adminDashboard.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else response.sendRedirect("/TakeTest/adminPages/adminLogin.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
