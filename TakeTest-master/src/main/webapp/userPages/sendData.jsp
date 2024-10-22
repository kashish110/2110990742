<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	HttpSession session2 = request.getSession(false);
	if (session2 != null && session2.getAttribute("user_id") != null) {
		String name = (String) session2.getAttribute("name");
		String test = ((String) session2.getAttribute("test_tag")).toUpperCase();
		int score = (int) request.getAttribute("score");
		int tab_switch = (int) request.getAttribute("tab_switches");
		int total = (int) request.getAttribute("total");
		int passMarks = (int) request.getAttribute("pass_marks");
		int percentage = (score * 100) / total;
	%>

	<form name="submit-to-google-sheet">
		<input type="hidden" name="Name" value="<%=name%>" required> <input
			type="hidden" name="TestTag" value="<%=test%>" required> <input
			type="hidden" name="MaxMarks" value="<%=total%>" required> <input
			type="hidden" name="passMarks" value="<%=passMarks%>" required>
		<input type="hidden" name="MarksScored" value="<%=score%>" required>
		<input type="hidden" name="Percentage" value="<%=percentage%>"
			required> <input type="hidden" name="TabSwitches"
			value="<%=tab_switch%>" required>
	</form>
	
	<script>
  
	
	const scriptURL = 'https://script.google.com/macros/s/AKfycbwHnQvkEQS3wsGf0rWW8ML2CyPtBDqaxWMMKRRjjSOPBbHPL1sL4y_q4tHi1igRUCJG/exec';
  const form = document.forms['submit-to-google-sheet'];
  document.addEventListener('DOMContentLoaded', (e) => {
	    e.preventDefault();
	    fetch(scriptURL, { method: 'POST', body: new FormData(form) })
	      .then(response => console.log('Success!', response))
	      .catch(error => console.error('Error!', error.message));
	   window.location.href = "/TakeTest/userPages/result.jsp";

  });	
  
  // Add this script to display the current time
  var currentTime = document.getElementById("current-time");
  var date = new Date();
  var hours = date.getHours();
  var minutes = date.getMinutes();
  var seconds = date.getSeconds();
  var IST = "IST";
  currentTime.innerHTML = hours + ":" + minutes + ":" + seconds + " " + IST;
</script>



	<%
	} else
	response.sendRedirect("/TakeTest/userPages/userLogin.jsp");
	%>

</body>
</html>