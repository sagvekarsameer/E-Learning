<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="adminSidebar.jsp" %>
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
    <title>Admin Dashboard - E-Learning Platform</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        .main-content {
            padding: 2rem;
            background-color: #f8f9fa;
            min-height: 100vh;
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
        .card-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 2rem;
        }
        .shortcut-card {
            flex: 1 1 280px;
            background-color: #ffffff;
            border: 1px solid #e9ecef;
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .shortcut-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
        }
        .shortcut-card h4 {
            color: #007bff;
            font-weight: 600;
            margin-bottom: 0.75rem;
        }
        .shortcut-card p {
            color: #6c757d;
            font-size: 0.95rem;
            flex-grow: 1;
            margin-bottom: 1.5rem;
        }
        .shortcut-card .btn {
            align-self: flex-start;
            padding: 0.6rem 1.2rem;
            border-radius: 0.5rem;
            font-weight: 500;
            transition: background-color 0.2s ease-in-out, border-color 0.2s ease-in-out;
        }
        .shortcut-card .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .shortcut-card .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .shortcut-card .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .shortcut-card .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
        .shortcut-card .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #212529;
        }
        .shortcut-card .btn-warning:hover {
            background-color: #e0a800;
            border-color: #d39e00;
        }
    </style>
</head>
<body>

<div class="main-content p-4">
    <div class="top-bar d-flex justify-content-between align-items-center mb-4">
        <h1>Admin Dashboard</h1>
        <div class="greeting text-muted">
            Welcome, <strong><%= session.getAttribute("name") != null ? session.getAttribute("name") : "Admin" %></strong>
        </div>
    </div>

    <div class="card-grid">
        <div class="shortcut-card">
            <h4>Upload Notes</h4>
            <p>Add new study materials and notes for students.</p>
            <a href="<%= request.getContextPath() %>/Admin/upload_notes.jsp" class="btn btn-primary">Go to Upload</a>
        </div>
        <div class="shortcut-card">
            <h4>Manage Notes</h4>
            <p>View, edit, or delete existing notes and resources.</p>
            <a href="<%= request.getContextPath() %>/admin/manage-notes" class="btn btn-secondary">Manage Notes</a>
        </div>
        <div class="shortcut-card">
            <h4>Manage Users</h4>
            <p>Oversee and manage master (teachers) and student accounts.</p>
            <a href="<%= request.getContextPath() %>/admin/manage-users" class="btn btn-warning">Manage Users</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
