package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.TestDao;


@WebServlet("/UpdateTest")
public class UpdateTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateTest() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("update test servlet ");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null && session.getAttribute("test_id") != null) {
        	
        	try {
        		int test_id = (int) session.getAttribute("test_id");
        		int passMarks = Integer.parseInt(request.getParameter("pass_marks"));
        		String topic = (String)request.getParameter("topic");
        		String lang = (String)request.getParameter("lang");
        		
        		TestDao.updatePassMarks(test_id, passMarks);
        		TestDao.updateTestLang(test_id, lang);
        		TestDao.updateTestTopic(test_id, topic);
        		
        		int numQuestions = Integer.parseInt(request.getParameter("num_ques"));
        		for(int i=1; i<=numQuestions; i++) {
        			int ques_id = Integer.parseInt(request.getParameter("questionId" + i));
        			String ques_text = request.getParameter("ques_text" + i);
        			String option1 = request.getParameter("option1" + i);
        			String option2 = request.getParameter("option2" + i);
        			String option3 = request.getParameter("option3" + i);
        			String option4 = request.getParameter("option4" + i);
        			int correct_answer = Integer.parseInt(request.getParameter("correctAnswer" + i));
                    
                    TestDao.updateQuestion(test_id, ques_id, ques_text, option1, option2, option3, option4, correct_answer);
        		}
        		response.sendRedirect("/TakeTest/AdminDashboard");
        	}catch(Exception e) {
				e.printStackTrace();
			}	
        }else response.sendRedirect("/TakeTest/AdminDashboard");
		
	}

}
