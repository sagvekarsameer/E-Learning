<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - E-Learning Platform</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f2f2f2;
        }
        .login-card {
            max-width: 400px;
            margin: 80px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card login-card">
        <h3 class="text-center mb-4">Login</h3>

        <%
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            if (error != null) {
        %>
        <div class="alert alert-danger" role="alert">
            <%= URLDecoder.decode(error, "UTF-8") %>
        </div>
        <%
        } else if (success != null) {
        %>
        <div class="alert alert-success" role="alert">
            <%= URLDecoder.decode(success, "UTF-8") %>
        </div>
        <%
            }
        %>
        <%
            String logoutMsg = request.getParameter("logout");
            if ("success".equals(logoutMsg)) {
        %>
        <div class="alert alert-success text-center">
            ✅ You have been logged out successfully.
        </div>
        <%
            }
        %>


        <form action="login" method="post" id="loginForm">
            <div class="mb-3">
                <label for="username" class="form-label">Username:</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>

        <p class="text-center mt-3">
            Don't have an account? <a href="student-register.jsp">Register here</a>
        </p>
    </div>
</div>
<script>
    document.getElementById("loginForm").addEventListener("submit", function(e) {
        const username = document.getElementById("username").value.trim();
        const password = document.getElementById("password").value;

        if (username === "" || password === "") {
            e.preventDefault();
            alert("Please fill all fields.");
        }
    });
</script>
</body>
</html>
