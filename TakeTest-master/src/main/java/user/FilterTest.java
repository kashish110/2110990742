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

@WebServlet("/FilterTest")
public class FilterTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FilterTest() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		if(session != null) {
			try {
				String person = request.getParameter("person");
				String lang = request.getParameter("languageSelect");
				String topic = request.getParameter("topicSelect");
				String level = request.getParameter("DifficultyLevel");
				
				if(lang.equals("all") && topic.equals("all") && level.equals("all")) {
					if(person == "user") response.sendRedirect("/TakeTest/UserDashboard");
					if(person == "admin") response.sendRedirect("/TakeTest/AdminDashboard");
				}
				
				ArrayList<Test> arr = TestDao.filterTest(lang, topic, level);
				System.out.print(arr);
				ArrayList<String> allTopics = TestDao.getAllTopics();
				ArrayList<String> allLang = TestDao.getAllLang();
				
				request.setAttribute("allTopics", allTopics);
				request.setAttribute("allLang", allLang);
				request.setAttribute("tests", arr);
				
				if(person == "user") request.getRequestDispatcher("./userPages/userDashboard.jsp").forward(request, response);
				if(person == "admin") request.getRequestDispatcher("./adminPages/adminDashboard.jsp").forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			response.sendRedirect("/TakeTest/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		if(session != null) {
			try {
				String person = request.getParameter("person");
				String lang = request.getParameter("languageSelect");
				String topic = request.getParameter("topicSelect");
				String level = request.getParameter("DifficultyLevel");
				
				if(lang == "all" && topic == "all" && level == "all") {
					if(person == "user") response.sendRedirect("/TakeTest/UserDashboard");
					if(person == "admin") response.sendRedirect("/TakeTest/AdminDashboard");
				}
				
				ArrayList<Test> arr = TestDao.filterTest(lang, topic, level);
				ArrayList<String> allTopics = TestDao.getAllTopics();
				ArrayList<String> allLang = TestDao.getAllLang();
				
				request.setAttribute("allTopics", allTopics);
				request.setAttribute("allLang", allLang);
				request.setAttribute("tests", arr);
				
				if(person.equals("user")) request.getRequestDispatcher("./userPages/userDashboard.jsp").forward(request, response);
				if(person.equals("admin")) request.getRequestDispatcher("./adminPages/adminDashboard.jsp").forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			response.sendRedirect("/TakeTest/error.jsp");
		}
	}

}
