package user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mail.SendMail;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import dao.Question;
import dao.TestDao;
import dao.UserDao;

@WebServlet("/Result")

public class Result extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public Result() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		if(session != null && session.getAttribute("user_id") != null && session.getAttribute("test_id") != null) {
			
			int test_id = (int)session.getAttribute("test_id");
			int user_id = (int)session.getAttribute("user_id");
	        int tab_switch = Integer.parseInt(request.getParameter("tab_switch"));
	        
			TestDao.updateCandidates(test_id);
			
			boolean nullString = false;
			String[] answers;
			if(request.getParameter("answers") == null) {
				nullString = true;
				answers = null;
			}
			else answers = request.getParameter("answers").split(",");
			int[] ans = new int[2];
			int passmarks = 0;
			String test_tag = "";
			String lang = "";
			String topic = "";
			try {
				lang = TestDao.getTestLang(test_id);
				topic = TestDao.getTestTopic(test_id);
				ans = TestDao.getScore(test_id, answers, nullString);
				passmarks = TestDao.getPassMarks(test_id);
				test_tag = TestDao.getTestName(test_id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			int score = ans[0];
			int total = ans[1];
			String status = "";
			if(score < total || tab_switch > 3) status = "Fail";
			else status = "Pass";
			
			Date currentDate = new Date();
			Timestamp currentTimestamp = new Timestamp(currentDate.getTime());
			System.out.println(currentTimestamp);
			
			if(TestDao.addResult(test_id, user_id, test_tag, total, score, status, currentTimestamp)) {
				System.out.println("result added");
			}
			else System.out.println("result not added");
			
			// sending mails ---------------------------------------------------------------------------------
//			String text = "hello admin";
//			SendMail obj = new SendMail();
//			boolean success = obj.send(text);
//			if(success) System.out.println("mail sent successfully.");
//			else System.out.println("Mail not sent.");

			// redirecting to result page  -------------------------------------------------------------------
			request.setAttribute("score", score);
			request.setAttribute("total", total);
			request.setAttribute("lang", lang);
			request.setAttribute("topic", topic);
			request.setAttribute("tab_switches", tab_switch);
			request.setAttribute("pass_marks", passmarks);

			request.setAttribute("status", status);
			request.setAttribute("date", currentTimestamp);
			
			request.getRequestDispatcher("./userPages/result.jsp").forward(request, response);
		}else {
			response.sendRedirect("/TakeTest/userPages/userLogin.jsp");
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
