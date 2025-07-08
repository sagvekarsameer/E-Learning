<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - E-Learning Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../CSS/style.css">
</head>
<body>

<%@ include file="studSidebar.jsp" %>

<div class="main-content">
    <div class="top-bar d-flex justify-content-between align-items-center mb-4">
        <h1 class="mb-0">Dashboard</h1>
        <div class="greeting text-muted">
            Welcome, <strong><%= session.getAttribute("username") %></strong>
            <%-- You can use: Welcome, <%= session.getAttribute("username") %> --%>
        </div>
    </div>

    <!-- Page-specific content -->
    <div class="card p-4 shadow-sm">
        <h5>Overview</h5>
        <p>This is your personalized learning dashboard.</p>
        <ul>
            <li>Access uploaded notes</li>
            <li>Track upcoming tests</li>
            <li>Bookmark important resources</li>
            <li>Read blogs & updates</li>
        </ul>
    </div>
</div>

</body>
</html>
