<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
  %>
  <title>Master Profile Setup</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
    }
    .form-card { /* Using .form-card for consistency with global style.css */
      max-width: 480px;
      width: 100%;
      margin: auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.08);
      background-color: #fff;
    }
    h2 {
      text-align: center;
      margin-bottom: 25px;
      font-weight: 600;
      color: #343a40;
    }
    .form-label {
      font-weight: 600;
      color: #343a40;
    }
    .form-control, .form-select {
      border-radius: 0.375rem;
      padding: 0.75rem 1rem;
    }
    .btn-success {
      background-color: #28a745;
      border-color: #28a745;
      padding: 0.75rem 1.5rem;
      font-size: 1.1rem;
      border-radius: 0.5rem;
      transition: background-color 0.2s ease-in-out, border-color 0.2s ease-in-out;
    }
    .btn-success:hover {
      background-color: #218838;
      border-color: #1e7e34;
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
  <div class="form-card">
    <h2>👨‍🏫 Master Profile Setup</h2>

    <% String error = request.getParameter("error");
      if (error != null) { %>
    <div class="alert alert-danger" role="alert">
      <%= error.replace("+", " ") %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/masterDetails" method="post">

      <div class="mb-3">
        <label for="subject_specialization" class="form-label">Subject Specialization</label>
        <input type="text" id="subject_specialization" name="subject_specialization" class="form-control" required placeholder="e.g. Physics, Math, Economics">
      </div>

      <div class="mb-3">
        <label for="assigned" class="form-label">Assigned To (Standard + Stream)</label>
        <select id="assigned" name="assigned" class="form-select" required>
          <option value="">-- Choose --</option>
          <option value="11th-Science">11th - Science</option>
          <option value="12th-Science">12th - Science</option>
          <option value="11th-Commerce">11th - Commerce</option>
          <option value="12th-Commerce">12th - Commerce</option>
          <option value="11th-Arts">11th - Arts</option>
          <option value="12th-Arts">12th - Arts</option>
          <option value="Other">Other</option>
        </select>
      </div>

      <button type="submit" class="btn btn-success w-100">Submit Profile</button>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>