<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Test</title>
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

        .container {
            background-color: #fff;
            padding: 30px;
            margin-top: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            color: #006D77;
            font-weight: bold;
        }

        .form-control {
            margin-bottom: 15px;
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

        .mt20 {
            margin-top: 20px;
        }
    </style>
</head>

<body>
    <div class="header">
        <h1>Add New Test</h1>
    </div>
    
    <div class="container">
        <form action="../AddTest" method="post">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="test_tag" class="form-label">Test Tag</label>
                    <input type="text" class="form-control" id="test_tag" name="test_tag" placeholder="Max 20 characters" required maxlength="20">
                </div>

                <div class="col-md-6">
                    <label for="questions" class="form-label">Number of Questions</label>
                    <input type="number" class="form-control" id="questions" name="questions" placeholder="Max 10 questions" required max="10" min="1">
                </div>

                <div class="col-md-6">
                    <label for="pass_marks" class="form-label">Pass Marks</label>
                    <input type="number" class="form-control" id="pass_marks" name="pass_marks" placeholder="Pass marks" min="0" required>
                </div>

                <div class="col-md-6">
                    <label for="language" class="form-label">Language</label>
                    <input type="text" class="form-control" id="lang" name="lang" placeholder="Max 20 characters" required maxlength="20">
                </div>

                <div class="col-md-6">
                    <label for="topics" class="form-label">Topics</label>
                    <input type="text" class="form-control" id="topic" name="topic" placeholder="Max 20 characters" required maxlength="20">
                </div>

                <div class="col-md-6">
                    <label for="difficulty" class="form-label">Difficulty</label>
                    <select id="difficulty" name="difficultyLevel" class="form-select" required>
                        <option value="" selected disabled hidden>Choose difficulty</option>
                        <option value="easy">Easy</option>
                        <option value="medium">Medium</option>
                        <option value="hard">Hard</option>
                    </select>
                </div>
            </div>

            <div class="text-center mt20">
                <button type="button" class="btn btn-secondary" onclick="redirectToDashboard()">Back to Dashboard</button>
                <button type="submit" class="btn btn-primary">Add Test</button>
            </div>
        </form>

        <%
            String error = request.getParameter("error");
            String toprint = "";
            if (error != null) {
                if (error.equals("invalid_passing_marks")) {
                    toprint = "Pass marks should be between 0 and " + request.getParameter("ques");
                } else if (error.equals("try_again")) {
                    toprint = "Error.";
                } else if (error.equals("invalid_ques")) {
                    toprint = "Invalid number of questions";
                }
        %>
        <p class="error-message"><%= toprint %>. Try again.</p>
        <%
            }
        %>
    </div>

    <script>
        function redirectToDashboard() {
            window.location.href = '/TakeTest/AdminDashboard';
        }
    </script>

    <%
        HttpSession session2 = request.getSession(false);
        if (session2 == null || session2.getAttribute("username") == null) {
            response.sendRedirect("/TakeTest/adminPages/adminLogin.jsp");
        }
    %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
