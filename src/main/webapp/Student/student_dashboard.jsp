<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="studSidebar.jsp" %>
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
    <title>Student Dashboard - E-Learning Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        .main-content {
            padding: 2rem;
            background-color: #f8f9fa;
            min-height: calc(100vh - 56px);
        }
        .top-bar h1 {
            color: #343a40;
            font-weight: 600;
        }
        .greeting {
            font-size: 1.1rem;
            color: #6c757d;
        }
        .greeting strong {
            color: #007bff;
        }
        .card {
            background-color: #ffffff;
            border: 1px solid #e9ecef;
            border-radius: 0.75rem;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        .card h5 {
            color: #007bff;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }
        .card ul {
            list-style: none;
            padding-left: 0;
        }
        .card ul li {
            margin-bottom: 0.8rem;
            color: #495057;
            font-size: 1rem;
        }
        .card ul li i {
            margin-right: 0.75rem;
            color: #28a745;
        }
    </style>
</head>
<body>

<div class="main-content">
    <div class="top-bar d-flex justify-content-between align-items-center mb-4">
        <h1 class="mb-0">Student Dashboard</h1>
        <div class="greeting text-muted">
            Welcome, <strong><%= session.getAttribute("name") != null ? session.getAttribute("name") : "Student" %></strong>
        </div>
    </div>

    <div class="card p-4 shadow-sm">
        <h5><i class="bi bi-bar-chart-line-fill"></i> Overview</h5>
        <p>This is your personalized learning dashboard. Here you can:</p>
        <ul>
            <li><i class="bi bi-journal-text"></i> Access uploaded notes relevant to your profile.</li>
            <li><i class="bi bi-calendar-check"></i> Track upcoming tests and quizzes.</li>
            <li><i class="bi bi-bookmark-fill"></i> Bookmark important resources for quick access.</li>
            <li><i class="bi bi-newspaper"></i> Read the latest blogs & updates from your instructors.</li>
            <li><i class="bi bi-person-circle"></i> Update your profile information.</li>
        </ul>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
