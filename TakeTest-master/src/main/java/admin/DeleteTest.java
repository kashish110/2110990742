package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.TestDao;

@WebServlet("/DeleteTest")

public class DeleteTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteTest() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			if(request.getParameter("what").equals("ques")) {
				String ques_id = request.getParameter("ques_id");
				HttpSession session = request.getSession();
				int test_id = (int)session.getAttribute("test_id");
				TestDao.deleteQues(ques_id, test_id);
				
				request.setAttribute("test_id", test_id);
				response.sendRedirect("/TakeTest/EditTest?test_id="+test_id);
				return;
			}
//			if(request.getParameter("what").equals("test")) {
				String test_id = request.getParameter("test_id");
				TestDao.deleteTest(test_id);
				response.sendRedirect("/TakeTest/AdminDashboard");				
//			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
