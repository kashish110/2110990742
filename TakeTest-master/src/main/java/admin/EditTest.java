package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

import dao.Question;
import dao.Test;
import dao.TestDao;


@WebServlet("/EditTest")
public class EditTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditTest() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		
		HttpSession session = request.getSession();
		if(session != null && session.getAttribute("username") != null ) {
			try {
				int test_id = Integer.parseInt(request.getParameter("test_id"));
				
				ArrayList<Question> arr = TestDao.getAllQuestions(test_id);
				session.setAttribute("test_id", test_id);
				int passmarks = TestDao.getPassMarks(test_id);
				String topic = TestDao.getTestTopic(test_id);
				String lang = TestDao.getTestLang(test_id);
				
				session.setAttribute("test_id", test_id);
				request.setAttribute("questions", arr);
				request.setAttribute("pass_marks", passmarks);
				request.setAttribute("topic", topic);
				request.setAttribute("lang", lang);
				
				request.getRequestDispatcher("./adminPages/editTest.jsp").forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			response.sendRedirect("/TakeTest/adminPages/adminLogin.jsp");
		}
	}
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
}
