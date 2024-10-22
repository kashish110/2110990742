package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import dao.Question;
import dao.TestDao;

@WebServlet("/AddQuestion")
public class AddQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddQuestion() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("testId") != null) {
			try {
				int test_id = Integer.parseInt(request.getParameter("testId"));
				String ques = request.getParameter("num_ques");
				int numberOfQuestions = Integer.parseInt(ques);
				
				for(int i=1; i<= numberOfQuestions; i++) {
					String quesText = request.getParameter("ques_text" + i);
					String option1 = request.getParameter("option1" + i);
					String option2 = request.getParameter("option2" + i);
					String option3 = request.getParameter("option3" + i);
					String option4 = request.getParameter("option4" + i);
					int correctAnswer = Integer.parseInt(request.getParameter("correctAnswer" + i));
					
					TestDao.addNewQuestion(test_id, quesText, option1, option2, option3, option4, correctAnswer);		
				}
				response.sendRedirect("/TakeTest/AdminDashboard");
				
			}catch(Exception e) {
				e.printStackTrace();
			}	
		}else  response.sendRedirect("/TakeTest/adminPages/addTest.jsp");
	}

}
