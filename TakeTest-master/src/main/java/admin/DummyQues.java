package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.TestDao;

@WebServlet("/DummyQues")

public class DummyQues extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DummyQues() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int test_id = Integer.parseInt(request.getParameter("test_id"));
		TestDao.addDummyQues(test_id);
		response.sendRedirect("/TakeTest/EditTest?test_id="+test_id);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
