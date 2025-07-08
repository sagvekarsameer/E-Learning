<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="adminSidebar.jsp" %>
<%
  String email = (String) session.getAttribute("email");
  if (email == null) {
    response.sendRedirect("../login.jsp");
    return;
  }

  String institute = "", accessLevel = "";

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "");

    PreparedStatement ps = conn.prepareStatement("SELECT institute_name, access_level FROM admins WHERE email = ?");
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
      institute = rs.getString("institute_name");
      accessLevel = rs.getString("access_level");
    }

    conn.close();
  } catch (Exception e) {
    out.println("<div class='alert alert-danger'>Error fetching admin profile: " + e.getMessage() + "</div>");
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Profile</title>
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
  <h2 class="mb-4">⚙️ Admin Profile</h2>

  <div class="form-card">
    <form action="updateAdminProfile" method="post">
      <div class="mb-3">
        <label class="form-label">Institute Name</label>
        <input type="text" name="institute_name" class="form-control" value="<%= institute %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Access Level</label>
        <select name="access_level" class="form-select" required>
          <option value="">-- Select Access Level --</option>
          <option value="Super Admin" <%= "Super Admin".equals(accessLevel) ? "selected" : "" %>>Super Admin</option>
          <option value="Institute Admin" <%= "Institute Admin".equals(accessLevel) ? "selected" : "" %>>Institute Admin</option>
        </select>
      </div>

      <button type="submit" class="btn btn-primary w-100">Update Profile</button>
    </form>
  </div>
</div>

</body>
</html>
