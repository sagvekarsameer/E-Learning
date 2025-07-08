<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - E-Learning Platform</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f2f2f2;
        }
        .login-card {
            max-width: 420px;
            margin: 80px auto;
            padding: 30px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card login-card">
        <h3 class="text-center mb-4">🔐 Login</h3>

        <%
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            String logout = request.getParameter("logout");

            if (error != null) {
        %>
        <div class="alert alert-danger"><%= URLDecoder.decode(error, "UTF-8") %></div>
        <% } else if (success != null) { %>
        <div class="alert alert-success"><%= URLDecoder.decode(success, "UTF-8") %></div>
        <% } else if ("success".equals(logout)) { %>
        <div class="alert alert-success">✅ You have logged out successfully.</div>
        <% } %>

        <form action="login" method="post" id="loginForm">
            <div class="mb-3">
                <label class="form-label">Email:</label>
                <input type="email" name="email" id="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password:</label>
                <input type="password" name="password" id="password" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">🔓 Login</button>
        </form>

        <p class="text-center mt-3">Don't have an account?
            <a href="student-register.jsp">Register as Student</a>
        </p>
        <p class="text-center mt-1 text-muted small">Other roles? Ask Admin to create account.</p>
    </div>
</div>

<script>
    document.getElementById("loginForm").addEventListener("submit", function(e) {
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value;
        if (email === "" || password === "") {
            e.preventDefault();
            alert("Please fill in both email and password.");
        }
    });
</script>

</body>
</html>
