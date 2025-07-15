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
  <title>Admin Profile Setup</title>
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
    .card {
      max-width: 500px;
      width: 100%;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.08);
      background-color: #fff;
    }
    .form-label {
      font-weight: 600;
      color: #343a40;
    }
    .form-control, .form-select {
      border-radius: 0.375rem;
      padding: 0.75rem 1rem;
    }
    .btn-primary {
      background-color: #007bff;
      border-color: #007bff;
      padding: 0.75rem 1.5rem;
      font-size: 1.1rem;
      border-radius: 0.5rem;
      transition: background-color 0.2s ease-in-out, border-color 0.2s ease-in-out;
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

<div class="container mt-5">
  <div class="card p-4 shadow-lg">
    <h3 class="text-center mb-4">🔐 Admin Profile Setup</h3>

    <% String error = request.getParameter("error");
      if (error != null) { %>
    <div class="alert alert-danger" role="alert">
      <%= error.replace("+", " ") %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/adminDetails" method="post">
      <div class="mb-3">
        <label for="institute" class="form-label">Institute Name</label>
        <input type="text" id="institute" name="institute" class="form-control" required placeholder="e.g. Somaiya, Christ University">
      </div>

      <div class="mb-3">
        <label for="access_level" class="form-label">Access Level</label>
        <select id="access_level" name="access_level" class="form-select" required>
          <option value="">-- Choose Access --</option>
          <option value="Super Admin">Super Admin</option>
          <option value="Institute Admin">Institute Admin</option>
        </select>
      </div>

      <button type="submit" class="btn btn-primary w-100">Submit Profile</button>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
