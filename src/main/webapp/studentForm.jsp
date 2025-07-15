<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
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
  <title>Student Profile Setup</title>
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

<div class="container">
  <div class="form-card">
    <h2>🎓 Complete Student Profile</h2>

    <%
      String error = request.getParameter("error");
      String success = request.getParameter("success");
      if (error != null) {
    %>
    <div class="alert alert-danger" role="alert">
      <%= URLDecoder.decode(error, "UTF-8") %>
    </div>
    <% } else if (success != null) { %>
    <div class="alert alert-success" role="alert">
      <%= URLDecoder.decode(success, "UTF-8") %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/studentDetails" method="post">
      <div class="mb-3">
        <label for="board" class="form-label">Board</label>
        <select id="board" name="board" class="form-select" required>
          <option value="">-- Select Board --</option>
          <option value="CBSE">CBSE</option>
          <option value="ICSE">ICSE</option>
          <option value="State">State Board</option>
          <option value="Other">Other</option>
        </select>
      </div>

      <div class="mb-3">
        <label for="std" class="form-label">Standard</label>
        <select id="std" name="std" class="form-select" required>
          <option value="">-- Select Standard --</option>
          <option value="11th">11th</option>
          <option value="12th">12th</option>
          <option value="Other">Other</option>
        </select>
      </div>

      <div class="mb-3">
        <label for="stream" class="form-label">Stream</label>
        <select id="stream" name="stream" class="form-select" required>
          <option value="">-- Select Stream --</option>
          <option value="Science">Science</option>
          <option value="Commerce">Commerce</option>
          <option value="Arts">Arts</option>
          <option value="Other">Other</option>
        </select>
      </div>

      <div class="mb-3">
        <label for="exam_preparing" class="form-label">Preparing For (Exam)</label>
        <select id="exam_preparing" name="exam_preparing" class="form-select" required>
          <option value="">-- Select Exam --</option>
          <option value="NEET">NEET</option>
          <option value="JEE">JEE</option>
          <option value="CET">CET</option>
          <option value="None">None</option>
        </select>
      </div>

      <button type="submit" class="btn btn-primary w-100">Submit Details</button>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>