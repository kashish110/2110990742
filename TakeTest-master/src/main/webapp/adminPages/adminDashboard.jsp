<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, dao.Test"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #EDF6F9;
}

header {
	background-color: #006D77;
	color: #fff;
	padding: 15px 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

header h1 {
	margin: 0;
	color: #FFDDD2;
}

.header-buttons {
	display: flex;
	align-items: center;
}

.header-buttons a {
	color: #FFF;
	text-decoration: none;
	padding: 8px 15px;
	margin-left: 15px;
	background-color: #83C5BE;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.header-buttons a:hover {
	background-color: #FFDDD2;
	color: #006D77;
}

.container {
	background-color: #83C5BE;
	width: 80vw;
	margin: 80px auto 20px;
	padding: 30px;
	border-radius: 10px;
	color: #006D77;
}

h2 {
	color: #006D77;
	text-align: center;
}

.card {
	background-color: #FFFFFF;
	border: 1px solid #006D77;
	border-radius: 10px;
	margin: 15px 0;
	padding: 20px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
}

.card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.card-header h3 {
	margin: 0;
	color: #006D77;
}

.card-content {
	margin-top: 10px;
}

.card-actions {
	margin-top: 15px;
	display: flex;
	justify-content: flex-end;
}

.btn {
	padding: 8px 15px;
	background-color: #FFDDD2;
	color: #006D77;
	font-size: 13px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn:hover {
	background-color: #E29578;
}

.logout-btn {
	padding: 8px 15px;
	background-color: #E29578;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.logout-btn:hover {
	background-color: #FFDDD2;
	color: #006D77;
}

#displaymsg {
	font-size: 18px;
	color: #E29578;
	text-align: center;
}

</style>

</head>
<body>

	<%
	HttpSession session2 = request.getSession(false);
	if (session2 != null && session2.getAttribute("username") != null) {
		ArrayList<Test> tests = (ArrayList<Test>) request.getAttribute("tests");
		ArrayList<String> allTopics = (ArrayList<String>) request.getAttribute("allTopics");
		ArrayList<String> allLang = (ArrayList<String>) request.getAttribute("allLang");
	%>

	<header>
		<h1>Admin<span style="color: #E29578;">Dashboard</span></h1>
		<div class="header-buttons">
			<a href="/TakeTest/adminPages/addTest.jsp">Add New Test</a> 
			<a href="./Logout" onclick="return confirmLogout();">Logout</a>
		</div>
	</header>

	<div class="container">
		<h2>Display All Tests</h2>
		
		<div style="margin-bottom: 15px;">
			<form action="/TakeTest/FilterTest" method="post">
				<input type="hidden" id="person" name="person" value="admin">
				<label for="languageSelect">Select Language:</label>
				<select id="languageSelect" name="languageSelect">
					<option value="all" selected>All</option>
					<% 
						for(String lang: allLang){
					%>
						<option value="<%= lang %>"> <%= lang %> </option>
					<%
						}
					%>
				</select> 
				<label for="topicSelect" style="margin-left: 15px;">Select Topic:</label>
				<select id="topicSelect" name="topicSelect">
					<option value="all" selected>All</option>
					<% 
						for(String topic: allTopics){
					%>
						<option value="<%= topic %>"> <%= topic %> </option>
					<%
						}
					%>
				</select>
				<label for="DifficultyLevel" style="margin-left: 15px;">Select Difficulty Level:</label>
				<select id="DifficultyLevel" name="DifficultyLevel">
					<option value="all" selected>All</option>
					<option value="easy"> Easy </option>
					<option value="medium"> Medium </option>
					<option value="hard"> Hard </option>
				</select>

				<button class="btn" onclick="searchTests()" style="margin-left: 15px;">Search</button>
			</form>
		</div>
		
		<% if(tests.size() > 0) { %>

		<div class="cards-container">
			<%
				for (Test test : tests) {
			%>
			<div class="card">
				<div class="card-header">
					<h3><%= test.getTestTag() %></h3>
					<span>No of Questions: <%= test.getNoOfQuestions() %></span>
				</div>
				<div class="card-content">
					<p>No of People Who Took the Test: <%= test.getNoOfCandidates() %></p>
					<p>Language: <%= test.getLang() %></p>
					<p>Topic: <%= test.getTopic() %></p>
					<p>Difficulty Level: <%= test.getLevel() %></p>
				</div>
				<div class="card-actions">
					<button class="btn" onclick="editTest(<%=test.getTestId()%>)">
						<img width="20" height="20" src="https://img.icons8.com/ios/20/pen.png" alt="edit" />
					</button>
					<button class="logout-btn" id="deleteTestButton" onclick="deleteTest(<%=test.getTestId()%>)">
						<img width="20" height="20" src="https://img.icons8.com/ios/20/000000/waste.png" alt="delete" />
					</button>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<% } else { %>
		<p id="displaymsg">No tests available.</p>
		<% } %>
	</div>

	<script>
		function editTest(testId) {
			const form = document.createElement('form');
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/TakeTest/EditTest');
			const testIdInput = document.createElement('input');
			testIdInput.setAttribute('type', 'hidden');
			testIdInput.setAttribute('name', 'test_id');
			testIdInput.setAttribute('value', testId);
			form.appendChild(testIdInput);
			document.body.appendChild(form);
			form.submit();
		}

		function deleteTest(testId) {
			if (confirmTestDeletion()) {
				window.location.href = "/TakeTest/DeleteTest?what=test&test_id=" + testId;
			}
		}

		function confirmTestDeletion() {
			return confirm("Are you sure you want to delete this test?");
		}

		function confirmLogout() {
			return confirm("Do you want to log out?");
		}
	</script>

	<%
	} else
		response.sendRedirect("/TakeTest/adminPages/adminLogin.jsp");
	%>

</body>
</html> 
