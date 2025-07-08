<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="masterSidebar.jsp" %>
<%
  String email = (String) session.getAttribute("email");
  if (email == null) {
    response.sendRedirect("../login.jsp");
    return;
  }

  String subjectSpecialization = "", assignedTo = "";

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "");

    PreparedStatement ps = conn.prepareStatement("SELECT subject_specialization, assigned_to FROM masters WHERE email = ?");
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
      subjectSpecialization = rs.getString("subject_specialization");
      assignedTo = rs.getString("assigned_to");
    }

    conn.close();
  } catch (Exception e) {
    out.println("<div class='alert alert-danger'>Error loading profile: " + e.getMessage() + "</div>");
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Master Profile</title>
  <link rel="stylesheet" href="../CSS/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .form-card {
      max-width: 480px;
      margin: 40px auto;
      padding: 30px;
      border-radius: 10px;
      background: #fff;
      box-shadow: 0 0 20px rgba(0,0,0,0.08);
    }
  </style>
</head>
<body>

<div class="main-content p-4">
  <h2 class="mb-4">👨‍🏫 Master Profile</h2>

  <div class="form-card">
    <form action="updateMasterProfile" method="post">
      <div class="mb-3">
        <label class="form-label">Subject Specialization</label>
        <input type="text" name="subject_specialization" class="form-control" value="<%= subjectSpecialization %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Assigned To (Std-Stream)</label>
        <select name="assigned_to" class="form-select" required>
          <option value="">-- Select --</option>
          <option value="11th-Science" <%= "11th-Science".equals(assignedTo) ? "selected" : "" %>>11th - Science</option>
          <option value="12th-Science" <%= "12th-Science".equals(assignedTo) ? "selected" : "" %>>12th - Science</option>
          <option value="11th-Commerce" <%= "11th-Commerce".equals(assignedTo) ? "selected" : "" %>>11th - Commerce</option>
          <option value="12th-Commerce" <%= "12th-Commerce".equals(assignedTo) ? "selected" : "" %>>12th - Commerce</option>
          <option value="11th-Arts" <%= "11th-Arts".equals(assignedTo) ? "selected" : "" %>>11th - Arts</option>
          <option value="12th-Arts" <%= "12th-Arts".equals(assignedTo) ? "selected" : "" %>>12th - Arts</option>
        </select>
      </div>

      <button type="submit" class="btn btn-primary w-100">Update Profile</button>
    </form>
  </div>
</div>

</body>
</html>
