<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Master Dashboard - E-Learning Platform</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../CSS/style.css">
</head>
<body>

<%@ include file="masterSidebar.jsp" %>

<div class="main-content p-4">
  <div class="top-bar d-flex justify-content-between align-items-center mb-4">
    <h1>Master Dashboard</h1>
    <div class="greeting text-muted">
      Welcome, <strong><%= session.getAttribute("username") %></strong>
    </div>
  </div>

  <div class="card p-4 shadow-sm">
    <h5 class="mb-3">Your Tools</h5>
    <ul>
      <li>📤 Upload notes and study material</li>
      <li>📝 Create and manage tests</li>
      <li>📈 View student performance reports</li>
      <li>💬 Respond to student queries (Coming Soon)</li>
    </ul>
  </div>
</div>

</body>
</html>
