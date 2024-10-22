<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>404 Error</title>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f2f2f2;
}

.error-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	text-align: center;
}

.error-content {
	background-color: #fff;
	padding: 40px;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.error-code {
	font-size: 80px;
	font-weight: bold;
	color: #333;
	margin-bottom: 20px;
}

.error-message {
	font-size: 24px;
	color: #666;
	margin-bottom: 30px;
}

.error-link {
	display: inline-block;
	background-color: #f5b700;
	color: #fff;
	text-decoration: none;
	padding: 12px 24px;
	border-radius: 4px;
	transition: background-color 0.3s ease;
}

.error-link:hover {
	background-color: #b88400;
}
</style>

</head>
<body>

	<div class="error-container">
		<div class="error-content">
			<div class="error-code">404</div>
			<div class="error-message">Oops! That page can't be found.</div>
			<p>The page you are looking for may have been deleted or moved.</p>
			<a href="home.jsp" class="error-link">Go to Home</a>
		</div>
	</div>

</body>
</html>