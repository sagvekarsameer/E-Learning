<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Profile Setup</title>
  <link rel="stylesheet" href="../CSS/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
  <div class="card p-4 shadow-lg" style="max-width: 500px; margin: auto;">
    <h3 class="text-center mb-4">🔐 Admin Profile Setup</h3>

    <% String error = request.getParameter("error");
      if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="adminDetails" method="post">
      <div class="mb-3">
        <label class="form-label">Institute Name</label>
        <input type="text" name="institute" class="form-control" required placeholder="e.g. Somaiya, Christ University">
      </div>

      <div class="mb-3">
        <label class="form-label">Access Level</label>
        <select name="access_level" class="form-select" required>
          <option value="">-- Choose Access --</option>
          <option value="Super Admin">Super Admin</option>
          <option value="Institute Admin">Institute Admin</option>
        </select>
      </div>

      <button type="submit" class="btn btn-primary w-100">Submit Profile</button>
    </form>
  </div>
</div>

</body>
</html>
