<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, dao.Question" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Test</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #EDF6F9;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .header {
            background-color: #006D77;
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
            font-size: 2.5rem;
        }

        .container {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .form-inline {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .form-inline .form-group {
            flex: 1;
        }

        .form-inline .form-group label {
            font-weight: bold;
            color: #006D77;
        }

        .question-item {
            background-color: #F0F4F8; /* Changed background color */
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.1);
        }

        .close-icon {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
            width: 25px;
            height: 25px;
            background-color: #E29578;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 16px;
        }

        .close-icon:hover {
            background-color: #D86A53;
        }

        .btn-primary {
            background-color: #006D77;
            border-color: #006D77;
        }

        .btn-primary:hover {
            background-color: #004F5E;
            border-color: #004F5E;
        }

        .btn-success {
            background-color: #83C5BE;
            border-color: #83C5BE;
        }

        .btn-success:hover {
            background-color: #6BAAA7;
            border-color: #6BAAA7;
        }

        .btn-danger {
            background-color: #E29578;
            border-color: #E29578;
        }

        .btn-danger:hover {
            background-color: #D86A53;
            border-color: #D86A53;
        }

        /* Styles for the add question button */
        .add-ques {
            background-color: #83C5BE;
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .add-ques:hover {
            background-color: #6BAAA7;
        }

    </style>
</head>
<body>

<%
    HttpSession session2 = request.getSession(false);
    if (session2 != null && session2.getAttribute("username") != null) {
        int test_id = (int) session.getAttribute("test_id");
        int passmarks = (int) request.getAttribute("pass_marks");
        String topic = (String) request.getAttribute("topic");
        String lang = (String) request.getAttribute("lang");
        ArrayList<Question> questions = (ArrayList<Question>) request.getAttribute("questions");
%>

<div class="header">
    <h1>Edit Test</h1>
</div>

<div class="container mt-4 p-4 shadow rounded bg-white">
    <!-- Add Question Form at the Top -->
    <form id="questionForm" action="/TakeTest/DummyQues" method="post">
        <input type="hidden" name="test_id" value="<%= test_id %>">
        <button type="submit" class="add-ques" id="addQuestionBtn">Add a new Question</button>
    </form>

    <h2 class="text-center mb-4">Edit Questions</h2>

    <!-- Inline display of Pass Marks and Language -->
    <form id="editQuestionForm" action="/TakeTest/UpdateTest" method="post">
        <div class="form-inline mb-4">
            <div class="form-group">
                <label for="pass_marks">Pass Marks:</label>
                <input type="number" class="form-control" id="pass_marks" name="pass_marks" value="<%= passmarks %>" required min="0" max="<%= questions.size() %>">
            </div>
            <div class="form-group">
                <label for="lang">Language:</label>
                <input type="text" class="form-control" id="lang" name="lang" value="<%= lang %>" required maxlength="20">
            </div>
        </div>

        <!-- Move Test Topic to a new line -->
        <div class="mb-4">
            <label for="topic">Test Topic:</label>
            <input type="text" class="form-control" id="topic" name="topic" value="<%= topic %>" required maxlength="20">
        </div>

        <input type="hidden" id="num_ques" name="num_ques" value="<%= questions.size() %>">

        <!-- Display Questions in a straightforward format -->
        <% 
            if (questions.size() != 0) {
                int serialNumber = 1;
                for (Question ques : questions) {
        %>
        <div class="question-item mb-3">
            <label>Question <%= serialNumber %>:</label>
            <span class="close-icon" onclick="deleteQues(<%= ques.getQuesId() %>)">X</span>
            <input type="hidden" name="questionId<%= serialNumber %>" value="<%= ques.getQuesId() %>">
            
            <div class="mb-3">
                <label for="question<%= serialNumber %>" class="form-label">Question text:</label>
                <input type="text" class="form-control" id="question<%= serialNumber %>" name="ques_text<%= serialNumber %>" value="<%= ques.getQuesText() %>" required>
            </div>
            
            <div class="mb-3">
                <label for="option1<%= serialNumber %>" class="form-label">Option 1:</label>
                <input type="text" class="form-control" id="option1<%= serialNumber %>" name="option1<%= serialNumber %>" value="<%= ques.getOption1() %>" required>
            </div>
            
            <div class="mb-3">
                <label for="option2<%= serialNumber %>" class="form-label">Option 2:</label>
                <input type="text" class="form-control" id="option2<%= serialNumber %>" name="option2<%= serialNumber %>" value="<%= ques.getOption2() %>" required>
            </div>
            
            <div class="mb-3">
                <label for="option3<%= serialNumber %>" class="form-label">Option 3:</label>
                <input type="text" class="form-control" id="option3<%= serialNumber %>" name="option3<%= serialNumber %>" value="<%= ques.getOption3() %>" required>
            </div>
            
            <div class="mb-3">
                <label for="option4<%= serialNumber %>" class="form-label">Option 4:</label>
                <input type="text" class="form-control" id="option4<%= serialNumber %>" name="option4<%= serialNumber %>" value="<%= ques.getOption4() %>" required>
            </div>

            <div class="mb-3">
                <label for="correctAnswer<%= serialNumber %>" class="form-label">Correct Answer:</label>
                <input type="number" class="form-control" id="correctAnswer<%= serialNumber %>" name="correctAnswer<%= serialNumber %>" value="<%= ques.getCorrectAnswer() %>" required min="1" max="4">
            </div>
        </div>
        <% 
                serialNumber++; 
                } 
            } 
        %>

        <!-- Save Changes Button -->
        <div class="text-center">
            <button type="submit" class="btn btn-success mt-4">Save Changes</button>
        </div>
    </form>

    <!-- Back to Dashboard Button -->
    <div class="text-center mt-4">
        <button class="btn btn-danger" onclick="redirectToDashboard()">Back to Dashboard</button>
    </div>
</div>

<script>
    function redirectToDashboard() {
        window.location.href = "/TakeTest/AdminDashboard";
    }

    function deleteQues(quesId) {
        // Implement question delete functionality here
        alert("Delete Question ID: " + quesId);
    }
</script>

<%
    } else {
        response.sendRedirect("/TakeTest/login.jsp");
    }
%>

</body>
</html>