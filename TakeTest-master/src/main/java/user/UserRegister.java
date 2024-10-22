package user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mail.SendMail;

import java.io.IOException;
import java.io.PrintWriter;

import dao.UserDao;

@WebServlet("/UserRegister")

public class UserRegister extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public UserRegister() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		String mobile = (String) session.getAttribute("mobile");
		String password = (String) session.getAttribute("password");
		String email = (String) session.getAttribute("email");
		String otp = (String) session.getAttribute("otp");
		
		try {
			String code = "";
			for(int i=1; i<=6; i++) {
				code += request.getParameter("digit"+i);
			}
			System.out.println("code: " + code);
			System.out.println("otp: " + otp);
			if(!code.equals(otp)) {
				response.sendRedirect("/TakeTest/userPages/userRegister.jsp?error=wrong_otp");
			}else {
				// create new user 	
				if(UserDao.addUser(name, mobile, password, email)) {
					
					String subject = "Registeration success!";
					String to = email;
					String msg = "Dear ," + name +  ",\n"
							+ "Thank you for registering with TakeTest! You are now part of our community.";
					SendMail obj = new SendMail();
					boolean success = obj.send(subject, msg, to);
					
					
					session.invalidate();
					PrintWriter out = response.getWriter();
					out.println("<script> alert('User registered successfully!'); window.location.href='/TakeTest/userPages/userLogin.jsp'; </script>");
					out.close();
				}
				else response.sendRedirect("/TakeTest/userPages/userRegister.jsp?error=try_again");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
}