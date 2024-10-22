<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, dao.Result"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>

    <style>
        /* General styling */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #EDF6F9; /* Light background */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px; /* Increased max-width */
            width: 100%;
            padding: 30px;
            background-color: #ffffff; /* White background for content */
            border-radius: 15px; /* Rounded corners */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            display: grid;
            grid-template-columns: 1fr 2fr; /* Two-column layout */
            gap: 30px; /* Increased gap */
        }

        /* User details styling */
        .user-details {
            background-color: #83C5BE; /* Soft teal background for user details */
            border-radius: 15px; /* Rounded corners */
            padding: 20px;
            color: #ffffff; /* White text color */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            height: auto; /* Changed to auto for dynamic content */
        }

        .user-details h2 {
            margin-top: 0;
            font-size: 28px; /* Increased font size */
            color: #006D77; /* Dark teal for heading */
        }

        .user-details p {
            margin: 10px 0; /* Spacing between paragraphs */
            font-size: 18px; /* Increased font size */
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #FFDDD2; /* Light peach for table */
            border-radius: 10px;
            overflow: hidden; /* Rounded corners for table */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px; /* Increased padding */
            text-align: left;
            border-bottom: 1px solid #dee2e6; /* Light border color */
        }

        th {
            background-color: #E29578; /* Soft orange for header */
            color: #ffffff; /* White text for header */
            font-weight: bold; /* Bold text for header */
        }

        /* Button styling */
        .button-container {
            text-align: right;
            margin-top: 20px; /* Spacing above button container */
        }

        .button, .header-buttons a {
            background-color: #006D77; /* Teal for buttons */
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 8px; /* Slightly more rounded corners */
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            text-decoration: none; /* Ensured no underline */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .button:hover, .header-buttons a:hover {
            background-color: #005b5b; /* Darker teal on hover */
            transform: translateY(-2px); /* Subtle lift effect on hover */
        }

        /* Responsive styling */
        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr; /* Stack columns on small screens */
            }
        }

        .header-buttons {
            margin-top: 10px;
            display: flex;
            align-items: center;
            gap: 10px; /* Spacing between buttons */
        }
    </style>
</head>
<body>

<%
HttpSession session2 = request.getSession(false);
if (session2 != null && session2.getAttribute("user_id") != null) {
    int user_id = (int) session2.getAttribute("user_id");
    String name = (String) session2.getAttribute("name");
    ArrayList<Result> arr = (ArrayList<Result>) request.getAttribute("resultarr");
    String phone = (String)request.getAttribute("phone");
    String email = (String)request.getAttribute("email");
%>      

<div class="container">
    <!-- User details -->
    <div class="user-details">
        <h2>Welcome, <%= name %></h2>
        <p>Phone Number: <%= phone %></p>
        <p>Email: <%= email %></p>
        <!-- Button container -->
        <div class="button-container">        
            <div class="header-buttons">
                <a href="/TakeTest/UserDashboard">Dashboard</a> 
                <a href="./Logout" onclick="return confirmLogout();">Logout</a>
            </div>
        </div>
    </div>

<%
    if (arr.size() != 0) {
%>

    <table>
        <thead>
            <tr>
                <th>Test Name</th>
                <th>Max Marks</th>
                <th>Scored Marks</th>
                <th>Percentage</th>
                <th>Pass/Fail</th>
                <th>Date</th>
            </tr>
        </thead>
        
        <tbody>
            <% for (Result result : arr) { %>
                <tr>
                    <td><%= result.getTestTag() %></td>
                    <td><%= result.getMaxMarks() %></td>
                    <td><%= result.getScore() %></td>
                    <td><%= (result.getScore()*100) / result.getMaxMarks() %></td>
                    <td><%= result.getStatus() %></td>
                    <td><%= result.getDate() %></td>
                </tr>
            <% } %>
        </tbody>
    </table>

<%
    } else {
%>

    <p id="displaymsg">No tests given.</p>

<%
    }
%>
    
</div>

<script>
function confirmLogout() {
    return confirm("Do you want to log out?");
}
</script>

<%
} else {
    response.sendRedirect("/TakeTest/userPages/userLogin.jsp");
}
%>

</body>
</html>