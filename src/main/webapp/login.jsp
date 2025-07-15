<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <title>Login - E-Learning Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .form-container {
            max-width: 420px;
            width: 100%;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.08);
        }
        .form-label {
            font-weight: 600;
            color: #343a40;
        }
        .form-control {
            border-radius: 0.375rem;
            padding: 0.75rem 1rem;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            padding: 0.75rem 1.5rem;
            font-size: 1.05rem;
            border-radius: 0.5rem;
            transition: all 0.2s ease-in-out;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .alert {
            margin-bottom: 1rem;
            padding: 0.75rem 1.25rem;
            border-radius: 0.375rem;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-container">
        <h3 class="text-center mb-4">🔐 Login</h3>

        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            String error = request.getParameter("error");
            String success = request.getParameter("success");
            String logout = request.getParameter("logout");

            if (error != null) {
        %>
        <div class="alert alert-danger" role="alert">
            <i class="bi bi-x-circle-fill"></i> <%= URLDecoder.decode(error, "UTF-8") %>
        </div>
        <% } else if (success != null) { %>
        <div class="alert alert-success" role="alert">
            <i class="bi bi-check-circle-fill"></i> <%= URLDecoder.decode(success, "UTF-8") %>
        </div>
        <% } else if ("success".equals(logout)) { %>
        <div class="alert alert-success" role="alert">
            <i class="bi bi-check-circle-fill"></i> You have logged out successfully.
        </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="post" id="loginForm">
            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" name="email" id="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" name="password" id="password" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">🔓 Login</button>
        </form>

        <p class="text-center mt-3">Don't have an account? <a href="<%= request.getContextPath() %>/student-register.jsp">Register as Student</a></p>
        <p class="text-center mt-1 text-muted small">Other roles? Ask Admin to create account.</p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("loginForm").addEventListener("submit", function(e) {
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value;
        if (email === "" || password === "") {
            e.preventDefault();
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-danger alert-dismissible fade show mt-3';
            alertDiv.setAttribute('role', 'alert');
            alertDiv.innerHTML = `
        <i class="bi bi-x-circle-fill"></i> Please fill in both email and password.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      `;
            this.parentNode.insertBefore(alertDiv, this.nextSibling);
        }
    });
</script>

</body>
</html>
