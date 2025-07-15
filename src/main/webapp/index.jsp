<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Welcome - E-Learning Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f2f2f2;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            text-align: center;
            padding: 20px;
        }
        h2 {
            margin-bottom: 10px;
            font-weight: 600;
            color: #333;
        }
        .tagline {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 30px;
        }
        .role-section {
            display: flex;
            flex-direction: column;
            gap: 30px;
            width: 100%;
            max-width: 450px;
        }
        .role-card {
            background-color: #fff;
            padding: 25px 35px;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
        }
        .role-card:hover {
            transform: translateY(-8px);
        }
        .role-card h4 {
            font-weight: 700;
            margin-bottom: 15px;
            color: #007bff;
        }
        .btn-group .btn {
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 8px;
            min-width: 130px;
            font-weight: 500;
            transition: all 0.2s ease-in-out;
        }
        .btn-group {
            gap: 15px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 15px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn-outline-primary {
            color: #007bff;
            border-color: #007bff;
        }
        .btn-outline-primary:hover {
            background-color: #007bff;
            color: #fff;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .btn-outline-success {
            color: #28a745;
            border-color: #28a745;
        }
        .btn-outline-success:hover {
            background-color: #28a745;
            color: #fff;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }
        .btn-outline-danger {
            color: #dc3545;
            border-color: #dc3545;
        }
        .btn-outline-danger:hover {
            background-color: #dc3545;
            color: #fff;
        }
        @media (max-width: 768px) {
            .role-card {
                padding: 20px 25px;
            }
            .btn-group {
                flex-direction: column;
                align-items: center;
            }
            .btn-group .btn {
                width: 80%;
            }
        }
    </style>
</head>
<body>

<h2>Welcome to the E-Learning Platform</h2>
<p class="tagline">Smart. Adaptive. Role-based learning experience.</p>

<div class="role-section">

    <div class="role-card">
        <h4><i class="bi bi-mortarboard-fill"></i> Student</h4>
        <div class="btn-group">
            <a href="<%= request.getContextPath() %>/login.jsp?role=student" class="btn btn-outline-primary">Login</a>
            <a href="<%= request.getContextPath() %>/student-register.jsp" class="btn btn-primary">Register</a>
        </div>
    </div>

    <div class="role-card">
        <h4><i class="bi bi-person-workspace"></i> Master</h4>
        <div class="btn-group">
            <a href="<%= request.getContextPath() %>/login.jsp?role=master" class="btn btn-outline-success">Login</a>
            <a href="<%= request.getContextPath() %>/master-register.jsp" class="btn btn-success">Register</a>
        </div>
    </div>

    <div class="role-card">
        <h4><i class="bi bi-gear-fill"></i> Admin</h4>
        <div class="btn-group">
            <a href="<%= request.getContextPath() %>/login.jsp?role=admin" class="btn btn-outline-danger">Login</a>
            <a href="<%= request.getContextPath() %>/admin-register.jsp" class="btn btn-danger">Register</a>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
