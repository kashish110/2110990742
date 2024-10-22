package user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mail.SendMail;

import java.io.IOException;
import java.util.Random;

import dao.UserDao;


@WebServlet("/VerifyUser")
public class VerifyUser extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static UserDao userDao = new UserDao();
       

    public VerifyUser() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

			
			String name = request.getParameter("name");
			String mobile = request.getParameter("mobile");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			
			try {
				
				// if mobile no starts with 0
				if(mobile.charAt(0) == '0') {
					response.sendRedirect("/TakeTest/userPages/userRegister.jsp?error=mobile_invalid");
					return;
				}
				
				// check if user with mobile already exists
				if(userDao.existsMobile(mobile)) {
					response.sendRedirect("/TakeTest/userPages/userRegister.jsp?error=user_already_exists");
					return;
				}
				
				if(userDao.existsEmail(email)) {
					response.sendRedirect("/TakeTest/userPages/userRegister.jsp?error=email_already_exists");
					return;	
				}
				
				Random random = new Random();
				int min = 100000;
				int max = 999999;
				int val = 0;
				do {
					val = random.nextInt(max - min + 1) + min;
				} while (String.valueOf(val).startsWith("0"));
				String otp = String.valueOf(val);
				String subject = "Your Two-Step Verification Code";
				String to = email;
				String msg = "Dear " + name + ", \n"
						+ "To complete the verification process, please use the following verification code: \n\n"
						+ "Verification Code: " + otp + " \n\n"
						+ "Please enter this code in the appropriate field on our website to complete the verification process. "
						+ "If you did not request this verification, please disregard this email. \n"
						+ "Thank You. \nMindGauge";
				
				SendMail obj = new SendMail();
				boolean success = obj.send(subject, msg, to);
				
				if(success) {
					// create session 
					HttpSession session = request.getSession();
					session.setAttribute("name", name);
					session.setAttribute("mobile", mobile);
					session.setAttribute("password", password);
					session.setAttribute("email", email);
					session.setAttribute("otp", otp);
					request.getRequestDispatcher("./userPages/verifyUser.jsp").forward(request, response);
					
				}else response.sendRedirect("/TakeTest/userPages/userRegister.jsp?error=try_again");
			
		}catch(Exception e) {
			e.printStackTrace();
		}

		
	}

}
