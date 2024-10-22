<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <link rel="stylesheet" href="UserResources/fonts/icomoon/style.css">
    <link rel="stylesheet" href="UserResources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="UserResources/css/bootstrap.min.css">
    <link rel="stylesheet" href="UserResources/css/newStyle.css">

    <style>
    	
        .btn-link {
            display: inline-block;
            padding: 5px 10px;
            margin-top: 10px;
            text-decoration: none;
            color: white;
            background-color: #333;
            border: 1px solid #333;
            border-radius: 5px;
        }

        .btn-link:hover {
            background-color: #83C5BE;
            color:black;
            border: 1px solid #83C5BE;
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

        .btn-link:focus, .btn-link:hover, .btn-link:active {
            text-decoration: none;
            outline: none;
            border: none;
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
                    <h1>Login as <br><strong><span style="color: #006D77; font-size: 4rem;">User</span></strong></h1>
                    <form action="/TakeTest/UserLogin" method="post">
                        <div class="form-group first" style="border: 2px solid #ccc; border-radius: 10px; padding: 10px;">
                            <label for="mobile"><b>Enter your mobile</b></label>
                            <input type="text" class="form-control" placeholder="Mobile(10 digits)" required id="mobile" name="mobile" style="border-radius: 5px;" required pattern="[0-9]{10}">
                        </div>
                        <div class="form-group last mb-3" style="border: 2px solid #ccc; border-radius: 10px; padding: 10px;">
                            <label for="password"><b>Enter your password</b></label>
                            <input type="password" class="form-control" placeholder="Password" required id="password" name="password" style="border-radius: 5px;">
                        </div>
                        
                        <input type="submit" value="Log In" style="background-color: #006D77; color:#ffffff" class="btn btn-block btn-warning">
                    </form>
                    <% 
                        String error = request.getParameter("error");
                        if(error != null && error.equals("1")){
                    %>
                    <p style="color: red;">Invalid mobile or password. Try again</p>
                    <%
                        }
                    %>
                    <div class="text-center">
                        <a href="/TakeTest/home.jsp" class="btn-link">Back to Home</a>
                        <a href="/TakeTest/userPages/userRegister.jsp" class="btn-link">Register Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="UserResources/js/jquery-3.3.1.min.js"></script>
<script src="UserResources/js/popper.min.js"></script>
<script src="UserResources/js/bootstrap.min.js"></script>
<script src="UserResources/js/main.js"></script>

</body>
</html>