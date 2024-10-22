<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Test Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #EDF6F9; /* Light background color */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            display: flex;
            flex-direction: column; /* Vertical layout */
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 600px;
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .header h1 {
            color: #006D77; /* Header title color */
            margin: 0;
        }

        .header h2 {
            color: #E29578; /* Subheader color */
            margin: 5px 0;
        }

        .content {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .left-section {
            flex: 1;
            padding: 20px;
            border-radius: 10px;
            margin-right: 10px; /* Space between sections */
            background-color: transparent; /* Remove card color */
        }

        .right-section {
            flex: 0.5;
            padding: 20px;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .score-card {
            text-align: center;
        }

        .score-card p {
            color: #333; /* Text color */
            margin: 5px 0;
        }

        .score-graphic {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: transparent; /* Remove circle color */
            border: 10px solid #006D77; /* Border color */
            display: flex;
            justify-content: center;
            align-items: center;
            color: #006D77; /* Text color */
            font-size: 24px;
            font-weight: bold;
            position: relative;
            animation: zoom 2s ease-in-out infinite; /* Animation added */
        }

        /* Animation for the score circle */
        @keyframes zoom {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
        }

        .actions {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            flex-wrap: wrap; /* Wrap buttons on small screens */
        }

        .actions a {
            display: block;
            margin: 0 5px;
            padding: 10px 15px;
            background-color: #006D77; /* Action button color */
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .actions a.logout {
            background-color: #D9534F; /* Logout button color */
        }

        .actions a:hover {
            background-color: #004d54; /* Darker shade on hover */
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .content {
                flex-direction: column; /* Stack sections on small screens */
            }

            .left-section {
                margin-right: 0; /* Remove margin on small screens */
                margin-bottom: 10px; /* Add margin below left section */
            }

            .right-section {
                margin-bottom: 0; /* Remove margin on small screens */
            }
        }
    </style>
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
    String status = (String) request.getAttribute("status");
    String lang = (String) request.getAttribute("lang");
    String topic = (String) request.getAttribute("topic");
%>

<div class="container">
    <div class="header">
        <h1>You <%= status %>ed!</h1>
        <h2>Test: <%= test %></h2>
    </div>
    <div class="content">
        <div class="left-section">
            <div class="score-card">
                <p>Status: <%= status %></p>
                <p>Test Lang: <%= lang %></p>
                <p>Test Topic: <%= topic %></p>
                <p>Test ended at: <span id="current-time"></span></p>
                <b><p class="tab-switches">Tab Switches: <%= tab_switch %></p></b>
            </div>
        </div>
        <div class="right-section">
            <div class="score-graphic">
                <span><%= percentage %>%</span>
            </div>
        </div>
    </div>
    <div class="actions">
        <a href="/TakeTest/UserDashboard" onclick="return goToDashboard()">Test Options</a>
        <a href="./Logout" onclick="return confirmLogout();" class="logout">User Logout</a>
        <a href="#" onclick="printResults()">Print Results</a>
    </div>
</div>

<form name="submit-to-google-sheet">
    <input type="hidden" name="Name" value="<%= name %>" required>
    <input type="hidden" name="TestTag" value="<%= test %>" required>
    <input type="hidden" name="MaxMarks" value="<%= total %>" required>
    <input type="hidden" name="passMarks" value="<%= passMarks %>" required>
    <input type="hidden" name="MarksScored" value="<%= score %>" required>
    <input type="hidden" name="Percentage" value="<%= percentage %>" required>
    <input type="hidden" name="TabSwitches" value="<%= tab_switch %>" required>
</form>

<script>
    const scriptURL = 'https://script.google.com/macros/s/AKfycbwHnQvkEQS3wsGf0rWW8ML2CyPtBDqaxWMMKRRjjSOPBbHPL1sL4y_q4tHi1igRUCJG/exec';
    const form = document.forms['submit-to-google-sheet'];
    document.addEventListener('DOMContentLoaded', (e) => {
        e.preventDefault();
        fetch(scriptURL, { method: 'POST', body: new FormData(form) })
            .then(response => console.log('Success!', response))
            .catch(error => console.error('Error!', error.message));
    });

    function confirmLogout() {
        return confirm("Do you want to log out?");
    }

    function printResults() {
        window.print();
    }

    function goToDashboard() {
        if (confirm("Check other test options?")) return true;
        else return false;
    }

    // Add this script to display the current time
    var currentTime = document.getElementById("current-time");
    var date = new Date();
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();
    var IST = "IST";
    currentTime.innerHTML = hours + ":" + (minutes < 10 ? '0' : '') + minutes + ":" + (seconds < 10 ? '0' : '') + seconds + " " + IST;
</script>

<%
} else
response.sendRedirect("/TakeTest/userPages/userLogin.jsp");
%>
</body>
</html>