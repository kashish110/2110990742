package user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

import dao.Question;
import dao.TestDao;

@WebServlet("/TestLive")
public class TestLive extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TestLive() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		if(session != null && session.getAttribute("user_id") != null) {
			try {

				int test_id = Integer.parseInt(request.getParameter("test_id"));
				String testName = TestDao.getTestName(test_id);
				session.setAttribute("test_id", test_id);
				session.setAttribute("test_tag", testName);
				ArrayList<Question> arr = TestDao.getAllQuestions(test_id);
				session.setAttribute("questions", arr);
				response.sendRedirect("./userPages/liveTest.jsp");
				
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
