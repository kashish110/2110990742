package mail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/Contact")
public class Contact extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Contact() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("name") != null) {
			
			String subject = "New message from Contact Form";
			String to = "";
			String msg = "Dear Admin, \n"
					+ "You have received a new message from the contact form on your website. Here are the details:\n\n"
					+ "Name: " + request.getParameter("name") + "\n"
					+ "Email: " + request.getParameter("email") + "\n"
					+ "Phone Number: " + request.getParameter("phone") + "\n"
					+ "Message: " + request.getParameter("text") + "\n\n"
					+ "Please respond to this inquiry promptly.\n\n"
					+ "Thank you,\n"
					+ "Mind Gauge";
			
			SendMail obj = new SendMail();
			boolean success = obj.send(subject, msg, to);
			
			PrintWriter out = response.getWriter();
			if(success) out.println("<script> alert('Message sent successfully!'); window.location.href='index.html'; </script>");
			else out.println("<script> alert('Message not sent!'); window.location.href='index.html'; </script>");
			out.close();
		} else response.sendRedirect("index.html");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
