<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Master Profile Setup</title>
  <link rel="stylesheet" href="../CSS/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

  <style>
    body {
      background-color: #f2f2f2;
    }
    .form-card {
      max-width: 480px;
      margin: 60px auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.08);
      background-color: #fff;
    }
    h2 {
      text-align: center;
      margin-bottom: 25px;
      font-weight: 600;
    }
    label {
      font-weight: 500;
    }
    .btn-success {
      width: 100%;
      padding: 10px;
      font-weight: 500;
      border-radius: 6px;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="form-card">
    <h2>👨‍🏫 Master Profile Setup</h2>
    <form action="masterDetails" method="post">

      <div class="mb-3">
        <label class="form-label">Subject Specialization</label>
        <input type="text" name="subject_specialization" class="form-control" required placeholder="e.g. Physics, Math, Economics">
      </div>

      <div class="mb-3">
        <label class="form-label">Assigned To (Std/Stream)</label>
        <select name="assigned" class="form-select" required>
          <option value="">-- Choose --</option>
          <option value="11th-Science">11th - Science</option>
          <option value="12th-Science">12th - Science</option>
          <option value="11th-Commerce">11th - Commerce</option>
          <option value="12th-Commerce">12th - Commerce</option>
          <option value="11th-Arts">11th - Arts</option>
          <option value="12th-Arts">12th - Arts</option>
        </select>
      </div>

      <button type="submit" class="btn btn-success">Submit Profile</button>
    </form>
  </div>
</div>

</body>
</html>
