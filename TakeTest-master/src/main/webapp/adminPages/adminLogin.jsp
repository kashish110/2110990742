<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login to TakeTest</title>
    <link rel="stylesheet" href="AdminResources/fonts/icomoon/style.css">
    <link rel="stylesheet" href="AdminResources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="AdminResources/css/bootstrap.min.css">
    <link rel="stylesheet" href="AdminResources/css/newStyle.css">
    
    <style>
        .btn-link {
            display: inline-block;
            padding: 5px 10px
            margin-top: 10px;
            color: white !important;
            background-color: #333;
            border: 1px solid #333;
            border-radius: 5px;
            text-decoration: none !important;
        }

        .btn-link:hover {
            background-color: #83C5BE;
            color:black !important;
            border: 1px solid #83C5BE;
        }

        .btn-link:focus, .btn-link:hover, .btn-link:active {
            text-decoration: none;
            outline: none;
            border: none;
        }

        .form-group {
            margin-bottom: 15px !important; /* Reduced margin-bottom */
            border-width: 0px !important;
        }

        .form-group .form-control {
            height: 30px; /* Reduced height */
            padding-bottom: 10px !important;
            border-bottom: solid #006D77 !important;
            
        }
    </style>
</head>
<body>

<div class="d-lg-flex half">
    <div class="bg order-1 order-md-2" style="background-image: url('../mg2.jpg');"></div>
    <div class="contents order-2 order-md-1">
        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-md-7">
                    <h1>Login as <br><strong><span style="color: #006D77; font-size: 4rem;">Admin</span></strong></h1>
                    <form action="/TakeTest/AdminLogin" method="post" onsubmit="return validateForm()">
                        <div class="form-group first" style="border: 2px solid #ccc; border-radius: 10px; padding: 10px; margin-bottom: 15px;">
                            <label for="username"><b>Enter your username</b></label>
                            <input type="text" class="form-control" placeholder="Username " id="username" name="username" required style="border-radius: 5px;">
                        </div>
                        <div class="form-group last mb-3" style="border: 2px solid #ccc; border-radius: 10px; padding: 10px; margin-bottom: 15px;">
                            <label for="password"><b>Enter your password</b></label>
                            <input type="password" class="form-control" placeholder="Password" id="password" name="password" required style="border-radius: 5px;">
                        </div>
                        
                        <input type="submit" value="Log In" style="background-color: #006D77; color:#ffffff" class="btn btn-block btn-warning">
                    </form>
                    <p id="error" style="color: red;"></p>
                    <% 
                        String error = request.getParameter("error");
                        if(error != null && error.equals("1")){
                    %>
                    <p style="color: red;">Invalid username or password. Try again</p>
                    <%
                        }
                    %>
                    <div class="text-center">
                        <a href="/TakeTest/home.jsp" class="btn-link">Back to Home</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="AdminResources/js/jquery-3.3.1.min.js"></script>
<script src="AdminResources/js/popper.min.js"></script>
<script src="AdminResources/js/bootstrap.min.js"></script>
<script src="AdminResources/js/main.js"></script>

<script>
    function validateForm() {
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;
        if (username.length > 20) {
            document.getElementById("error").innerHTML = "Username should not exceed 20 characters.";
            return false;
        }
        return true;
    }
</script>

</body>
</html>