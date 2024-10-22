package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.TestDao;

@WebServlet("/AddTest")
public class AddTest extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public AddTest() {
        super();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	if(request.getParameter("test_tag") != null) {
    		
    		String test_tag = request.getParameter("test_tag");
    		String questions = request.getParameter("questions");
    		String pass_marks = request.getParameter("pass_marks");
    		String lang = request.getParameter("lang");
    		String topic = request.getParameter("topic");
    		String level = request.getParameter("difficultyLevel");
    		
    		try {
    			if (questions == null || pass_marks == null || Integer.parseInt(pass_marks) < 0 || Integer.parseInt(pass_marks) > Integer.parseInt(questions)) {
    				response.sendRedirect("/TakeTest/adminPages/addTest.jsp?error=invalid_passing_marks&ques="+questions);
    				return;
    			}
    			if(TestDao.addNewTest(test_tag, questions, pass_marks, lang, topic, level)){
    				int test_id = TestDao.getTestId();
    				if(test_id == -1) {
    					response.sendRedirect("/TakeTest/adminPages/addTest.jsp?error=try_again");
    					return;
    				}
    				request.setAttribute("testId", String.valueOf(test_id));
    				request.setAttribute("ques", questions);
    				request.setAttribute("lang", String.valueOf(lang));
    				request.setAttribute("topics", String.valueOf(topic));
    				
    				
    				request.getRequestDispatcher("./adminPages/addQuestions.jsp").forward(request, response);
    			}
    			else response.sendRedirect("/TakeTest/adminPages/addTest.jsp?error=try_again");
    			
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	}else  response.sendRedirect("/TakeTest/adminPages/addTest.jsp?error=try_again");
    		
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
