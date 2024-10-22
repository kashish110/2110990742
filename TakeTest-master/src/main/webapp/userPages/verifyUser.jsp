<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Verification</title>
<style>

* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', sans-serif;
    background-color: #EDF6F9; /* Light blue background */
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    color: #006D77; /* Primary color */
}

.container {
    background-color: #FFFFFF; /* White container */
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15); /* Softer shadow for depth */
    width: 100%;
    max-width: 500px; /* Limit width for better readability */
    text-align: center;
}

h2 {
    color: #006D77; /* Dark teal */
    font-size: 2rem;
    margin-bottom: 10px;
}

p {
    color: #83C5BE; /* Light teal */
    margin-bottom: 30px;
    font-size: 1rem;
}

.code-container {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.code {
    height: 60px; 
    width: 50px; 
    border: 2px solid #006D77; /* Teal border */
    background-color: #FFDDD2; /* Light peach background */
    font-size: 1.5rem;
    color: #006D77; /* Teal text */
    text-align: center;
    border-radius: 8px;
    transition: border-color 0.3s, background-color 0.3s;
}

.code:focus {
    border-color: #83C5BE; /* Light teal border on focus */
    background-color: #EDF6F9; /* Light blue background on focus */
    outline: none; /* Remove focus outline */
}

button {
    padding: 12px 24px;
    font-size: 1.1rem;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    margin: 10px;
    transition: background-color 0.3s, transform 0.2s;
}

.button-verify {
    background-color: #E29578; /* Coral background */
    color: white;
}

.button-verify:hover {
    background-color: #FFDDD2; /* Lighter peach on hover */
    transform: scale(1.05);
}

.button-home {
    background-color: #83C5BE; /* Light teal */
    color: white;
}

.button-home:hover {
    background-color: #006D77; /* Dark teal on hover */
    transform: scale(1.05);
}

.footer {
    margin-top: 20px;
    color: #83C5BE; /* Light teal */
    font-size: 0.9rem;
}

.footer a {
    color: #006D77;
    text-decoration: none;
}

.footer a:hover {
    text-decoration: underline;
}

</style>
</head>
<body>

<%
HttpSession session2 = request.getSession(false);
if (session2 != null && session2.getAttribute("email") != null) {
%>

<div class="container">
    <h2>Verify Your Account</h2>
    <p>We have sent a verification code to your email address.<br>Enter the verification code that you received.</p>

    <form action="/TakeTest/UserRegister" method="post">
        <div class="code-container">
            <input type="number" class="code" name="digit1" placeholder="0" min="0" max="9" maxlength="1" required>
            <input type="number" class="code" name="digit2" placeholder="0" min="0" max="9" maxlength="1" required>
            <input type="number" class="code" name="digit3" placeholder="0" min="0" max="9" maxlength="1" required>
            <input type="number" class="code" name="digit4" placeholder="0" min="0" max="9" maxlength="1" required>
            <input type="number" class="code" name="digit5" placeholder="0" min="0" max="9" maxlength="1" required>
            <input type="number" class="code" name="digit6" placeholder="0" min="0" max="9" maxlength="1" required>
        </div>

        <button class="button-verify" type="submit">Verify</button>
        <button class="button-home" type="button" onclick="goToHome()">Go to Home</button>
    </form>

    
</div>

<script>
const codes = document.querySelectorAll(".code");
codes[0].focus();

codes.forEach((code, idx) => {
    code.addEventListener("keydown", (e) => {
        if (e.key >= 0 && e.key <= 9) {
            codes[idx].value = "";
            setTimeout(() => codes[idx + 1]?.focus(), 10);
        } else if (e.key === "Backspace") {
            setTimeout(() => codes[idx - 1]?.focus(), 10);
        }
    });
});

function goToHome() {
    if (confirm("Back to Home?")) {
        window.location.href = "/TakeTest/userPages/userRegister.jsp";
    }
}
</script>

<%
} else {
    response.sendRedirect("/TakeTest/userPages/userRegister.jsp");
}
%>

</body>
</html>