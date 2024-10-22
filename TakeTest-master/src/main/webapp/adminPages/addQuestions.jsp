<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Questions</title>
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
            font-size: 2rem;
        }

        .questionForm {
            display: none; /* Hide all question forms by default */
        }

        .questionForm.active {
            display: block; /* Display only the active question form */
        }

        .btn-primary {
            background-color: #FFDDD2;
            border: none;
            color: #006D77;
        }

        .btn-primary:hover {
            background-color: #E29578;
        }

        .btn-secondary {
            background-color: #83C5BE;
            border: none;
            margin-right: 10px;
        }

        .btn-secondary:hover {
            background-color: #006D77;
        }

        .error-message {
            color: #E29578;
            font-weight: bold;
            margin-top: 20px;
            text-align: center;
            font-size: 1.1rem;
        }

        textarea {
            resize: vertical; /* Allow vertical resizing */
        }
    </style>
</head>

<body>
    <div class="header">
        <h1>Add Questions</h1>
    </div>

    <div class="container mt-4 p-4 shadow rounded bg-white">
        <%
            HttpSession session2 = request.getSession(false);
            if (session2 != null && session2.getAttribute("username") != null) {
        %>
        <h2 class="text-center text-dark">Add Questions</h2>

        <% 
            String error = (String) request.getAttribute("error");
            if (error != null && error.equals("invalid passing marks")) {
        %>
        <p class="text-danger text-center">Invalid passing marks entered. Try again.</p>
        <%
            }
        %>

        <form id="questionForm" action="/TakeTest/AddQuestion" method="post">
            <% 
                String questions = (String) request.getAttribute("ques");
                String test_id = (String) request.getAttribute("testId");
                if (questions != null && test_id != null) {
                    int numberOfQuestions = Integer.parseInt(questions);

                    for (int i = 1; i <= numberOfQuestions; i++) {
            %>
            <div class="questionForm <%= i == 1 ? "active" : "" %>">
                <h4 class="mb-3">Question <%= i %></h4>

                <div class="mb-3">
                    <label for="question<%= i %>" class="form-label">Question statement:</label>
                    <textarea class="form-control" id="question<%= i %>" name="ques_text<%= i %>" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="option1<%= i %>" class="form-label">Option 1:</label>
                    <textarea class="form-control" id="option1<%= i %>" name="option1<%= i %>" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="option2<%= i %>" class="form-label">Option 2:</label>
                    <textarea class="form-control" id="option2<%= i %>" name="option2<%= i %>" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="option3<%= i %>" class="form-label">Option 3:</label>
                    <textarea class="form-control" id="option3<%= i %>" name="option3<%= i %>" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="option4<%= i %>" class="form-label">Option 4:</label>
                    <textarea class="form-control" id="option4<%= i %>" name="option4<%= i %>" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="correctAnswer<%= i %>" class="form-label">Correct Answer:</label>
                    <input type="number" class="form-control" id="correctAnswer<%= i %>" name="correctAnswer<%= i %>" required min="1" max="4">
                </div>
            </div>
            <% 
                    }
                } else response.sendRedirect("/TakeTest/error.jsp");
            %>

            <input type="hidden" name="num_ques" value="<%= questions %>">
            <input type="hidden" name="testId" value="<%= test_id %>">

            <div class="text-center mt-4">
                <button id="prevButton" type="button" class="btn btn-secondary hidden">Previous</button>
                <button id="nextButton" type="button" class="btn btn-primary">Next</button>
                <button type="submit" class="btn btn-success hidden" id="submitButton">Submit Questions</button>
                <p id="errorMsg" class="error-message hidden">Make sure you have filled all the fields properly.</p>
            </div>
        </form>

        <div class="text-center mt-4">
            <button class="btn btn-danger" id="deleteTestButton" data-test-id="<%= test_id %>">Go Back</button>
        </div>

        <%
            } else response.sendRedirect("/TakeTest/adminPages/adminLogin.jsp");
        %>
    </div>

    <script>
        var currentQuestion = 0;
        var questionForms = document.querySelectorAll('.questionForm');
        var nextButton = document.getElementById('nextButton');
        var prevButton = document.getElementById('prevButton');
        var submitButton = document.getElementById('submitButton');
        var errorMsg = document.getElementById('errorMsg');

        function showQuestion() {
            questionForms.forEach(function(form, index) {
                form.classList.toggle('active', index === currentQuestion);
            });

            prevButton.classList.toggle('hidden', currentQuestion === 0);
            nextButton.classList.toggle('hidden', currentQuestion === questionForms.length - 1);
            submitButton.classList.toggle('hidden', currentQuestion !== questionForms.length - 1);
        }

        nextButton.addEventListener('click', function() {
            currentQuestion++;
            showQuestion();
        });

        prevButton.addEventListener('click', function() {
            currentQuestion--;
            showQuestion();
        });

        submitButton.addEventListener('click', function() {
            document.getElementById('questionForm').submit();
        });

        document.getElementById('deleteTestButton').addEventListener('click', function(event) {
            if (confirm('Current test will not be added. Are you sure you want to go back?')) {
                window.location.href = "/TakeTest/DeleteTest?what=test&test_id=" + event.target.dataset.testId;
            }
        });

        showQuestion();
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
