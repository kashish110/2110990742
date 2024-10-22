
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Take Test</title>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Rubik+Scribble&display=swap')
	;

body {
	margin: 0;
	padding: 0;
	font-family: 'Montserrat', sans-serif;
	background-color: #EAF4FD;
}

.container {
	position: relative;
	display: flex;
	justify-content: flex-end;
	align-items: center;
	height: 100vh;
	padding-left: 50px;
	padding-right: 190px;
	text-align: justify;
}

.white-box {
	position: relative;
	z-index: 1;
	background-color: white;
	padding: 30px;
	box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.1);
	height: 56%;
	width: 40%;
	text-align: center;
	border-radius:2%;
}

.white-box p {
	width: 90%;
	margin-left: 30px;
}

h1 {
	/* font-family: "Rubik Scribble", system-ui;    */
	font-weight: bold;
	margin-top: 20;
	margin-bottom: 0;
	color: #006D77;
	font-size: 50px;
}

.sub {
	margin-top: 5px;
	font-size: 20px;
	color: #006D77;
}

.button-container {
	margin-top: 30px;
}

.button-container a {
	display: block;
	margin-bottom: 15px;
	text-decoration: none;
}

.button-container button {
	width: 65%;
	padding: 12px 0; /* Adjust padding */
	background-color:  #006D77 ;
	border: none;
	color: white;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 18px;
	cursor: pointer;
	border-radius: 2px;
	transition: background-color 0.3s ease;
	box-sizing: border-box; 
}

.button-container button:hover {
	background-color: #83C5BE; 
}

.image-container {
	position: absolute;
	top: 12%;
	right: calc(50% + 200px);
	bottom: 0%;
	width: 400px;
}

.image-container img {
	width: 200%;
	height: auto;
	border-radius: 15px;
}

footer {
	position: fixed;
	bottom: 0;
	width: 100%;
	background-color: #333;
	color: #fff;
	text-align: center;
}
</style>
</head>
<body>

	<div class="container">
		<div class="white-box">
			<br>
			<br>
			<h1>MIND GAUGE</h1>
			<p class="sub">
				<b>ONLINE ASSESSMENT PORTAL</b>
			</p>

			<div class="button-container">
				<a href="/TakeTest/adminPages/adminLogin.jsp"><button>Login as Admin</button></a> 
				<a href="/TakeTest/userPages/userLogin.jsp"><button>Login as User</button></a> 
				<a href="/TakeTest/userPages/userRegister.jsp"><button>Register as New User</button></a>
			</div>
		</div>
		<div class="image-container">
			<img src="mg2.jpg" alt="Image">
		</div>
	</div>

	<footer>
		<p>&copy; 2024 Mind Gauge. All rights reserved.</p>
	</footer>

</body>
</html>
