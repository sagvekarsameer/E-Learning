<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Student Profile Setup</title>
  <link rel="stylesheet" href="../CSS/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

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
    .btn-primary {
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
    <h2>🎓 Complete Student Profile</h2>
    <form action="studentDetails" method="post">

      <div class="mb-3">
        <label class="form-label">Board</label>
        <select name="board" class="form-select" required>
          <option value="">-- Select Board --</option>
          <option value="CBSE">CBSE</option>
          <option value="ICSE">ICSE</option>
          <option value="State">State Board</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">Standard</label>
        <select name="std" class="form-select" required>
          <option value="">-- Select Standard --</option>
          <option value="11th">11th</option>
          <option value="12th">12th</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">Stream</label>
        <select name="stream" class="form-select" required>
          <option value="">-- Select Stream --</option>
          <option value="Science">Science</option>
          <option value="Commerce">Commerce</option>
          <option value="Arts">Arts</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">Preparing For (Exam)</label>
        <select name="exam_preparing" class="form-select" required>
          <option value="">-- Select Exam --</option>
          <option value="NEET">NEET</option>
          <option value="JEE">JEE</option>
          <option value="CET">CET</option>
          <option value="None">None</option>
        </select>
      </div>

      <button type="submit" class="btn btn-primary">Submit Details</button>
    </form>
  </div>
</div>

</body>
</html>
