<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - E-Learning Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../CSS/style.css">
</head>
<body>

<%@ include file="adminSidebar.jsp" %>

<div class="main-content p-4">
    <div class="top-bar d-flex justify-content-between align-items-center mb-4">
        <h1>Admin Dashboard</h1>
        <div class="greeting text-muted">
            Welcome, <strong><%= session.getAttribute("username") %></strong>
        </div>
    </div>

    <div class="card-grid">
        <div class="card shortcut-card">
            <h4>Upload Notes</h4>
            <p>Add new notes for students</p>
            <a href="upload_notes.jsp" class="btn btn-primary">Go</a>
        </div>
        <div class="card shortcut-card">
            <h4>Manage Notes</h4>
            <p>Edit or delete existing notes</p>
            <a href="manageNotes.jsp" class="btn btn-secondary">Go</a>
        </div>
        <div class="card shortcut-card">
            <h4>Manage Users</h4>
            <p>View/edit masters & students</p>
            <a href="manageUsers.jsp" class="btn btn-warning">Go</a>
        </div>
    </div>
</div>

</body>
</html>
