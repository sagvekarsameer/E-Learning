<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="adminSidebar.jsp" %>
<%
  String userEmail = (String) session.getAttribute("email");
  Integer userId = (Integer) session.getAttribute("user_id");

  if (userEmail == null || userId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp?error=Session+expired,+please+login+again");
    return;
  }

  String institute = "";
  String accessLevel = "";
  String errorMessage = null;

  try (Connection conn = utils.DBUtil.getConnection();
       PreparedStatement ps = conn.prepareStatement("SELECT institute_name, access_level FROM admins WHERE user_id = ?")) {

    ps.setInt(1, userId);
    try (ResultSet rs = ps.executeQuery()) {
      if (rs.next()) {
        institute = rs.getString("institute_name");
        accessLevel = rs.getString("access_level");
      } else {
        errorMessage = "Admin profile not found. Please complete your profile if you haven't.";
      }
    }
  } catch (SQLException e) {
    e.printStackTrace();
    errorMessage = "Database error fetching admin profile: " + e.getMessage();
  } catch (Exception e) {
    e.printStackTrace();
    errorMessage = "An unexpected error occurred: " + e.getMessage();
  }
%>

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
  <title>Admin Profile - E-Learning</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .main-content {
      min-height: 100vh;
      padding: 2rem;
      background-color: #f8f9fa;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .form-card {
      width: 100%;
      max-width: 500px;
      background-color: #ffffff;
      padding: 2rem;
      margin-top: 2rem;
      border-radius: 0.75rem;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      border: 1px solid #e9ecef;
    }
    .form-card h2 {
      text-align: center;
      margin-bottom: 1.5rem;
      font-weight: 700;
      color: #212529;
    }
    .alert-message {
      margin-top: 1rem;
      width: 100%;
      max-width: 500px;
    }
  </style>
</head>
<body>

<div class="main-content">
  <h2>⚙️ Admin Profile</h2>

  <% if (errorMessage != null) { %>
  <div class="alert alert-danger alert-message" role="alert">
    <%= errorMessage %>
  </div>
  <% } %>

  <%
    String successMessage = request.getParameter("success");
    String urlErrorMessage = request.getParameter("error");
    if (successMessage != null) {
  %>
  <div class="alert alert-success alert-message" role="alert">
    <%= successMessage.replace("+", " ") %>
  </div>
  <% } else if (urlErrorMessage != null) { %>
  <div class="alert alert-danger alert-message" role="alert">
    <%= urlErrorMessage.replace("+", " ") %>
  </div>
  <% } %>

  <div class="form-card">
    <form action="<%= request.getContextPath() %>/updateAdminProfile" method="post">
      <div class="mb-3">
        <label for="institute_name" class="form-label">Institute Name</label>
        <input type="text" id="institute_name" name="institute_name" class="form-control" value="<%= institute %>" required>
      </div>

      <div class="mb-3">
        <label for="access_level" class="form-label">Access Level</label>
        <select id="access_level" name="access_level" class="form-select" required>
          <option value="">-- Select Access Level --</option>
          <option value="Super Admin" <%= "Super Admin".equals(accessLevel) ? "selected" : "" %>>Super Admin</option>
          <option value="Institute Admin" <%= "Institute Admin".equals(accessLevel) ? "selected" : "" %>>Institute Admin</option>
        </select>
      </div>

      <button type="submit" class="btn btn-primary w-100">Update Profile</button>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
