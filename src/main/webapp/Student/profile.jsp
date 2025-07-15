<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="studSidebar.jsp" %>
<%
  Integer userId = (Integer) session.getAttribute("user_id");
  String userName = (String) session.getAttribute("name");

  if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp?error=Session+expired,+please+login+again");
    return;
  }

  String board = "", std = "", stream = "", exam = "", errorMessage = null;

  try (Connection conn = utils.DBUtil.getConnection();
       PreparedStatement ps = conn.prepareStatement("SELECT board, standard, stream, exam_preparing FROM student_profiles WHERE user_id = ?")) {
    ps.setInt(1, userId);
    try (ResultSet rs = ps.executeQuery()) {
      if (rs.next()) {
        board = rs.getString("board");
        std = rs.getString("standard");
        stream = rs.getString("stream");
        exam = rs.getString("exam_preparing");
      } else {
        errorMessage = "Student profile not found. Please complete your profile if you haven't.";
      }
    }
  } catch (SQLException e) {
    e.printStackTrace();
    errorMessage = "Database error fetching profile: " + e.getMessage();
  } catch (Exception e) {
    e.printStackTrace();
    errorMessage = "An unexpected error occurred: " + e.getMessage();
  }
%>

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
  <title>Student Profile - E-Learning</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .main-content {
      padding: 2rem;
      background-color: #f8f9fa;
      min-height: calc(100vh - 56px);
    }
    .form-card {
      max-width: 500px;
      margin: 40px auto;
      padding: 30px;
      border-radius: 10px;
      background: #fff;
      box-shadow: 0 0 20px rgba(0,0,0,0.08);
    }
    .alert-message {
      margin-top: 20px;
      text-align: center;
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
      padding: 0.75rem 1.5rem;
      font-size: 1.1rem;
      border-radius: 0.5rem;
    }
  </style>
</head>
<body>
<div class="main-content p-4">
  <h2 class="mb-4 text-center">👤 Student Profile</h2>

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
  <%
  } else if (urlErrorMessage != null) {
  %>
  <div class="alert alert-danger alert-message" role="alert">
    <%= urlErrorMessage.replace("+", " ") %>
  </div>
  <%
    }
  %>

  <div class="form-card">
    <form action="<%=request.getContextPath()%>/updateStudentProfile" method="post">
      <div class="mb-3">
        <label for="name" class="form-label">Full Name</label>
        <input type="text" id="name" name="name" class="form-control" value="<%= userName != null ? userName : "" %>" required>
      </div>
      <div class="mb-3">
        <label for="board" class="form-label">Board</label>
        <select id="board" name="board" class="form-select" required>
          <option value="">-- Select Board --</option>
          <option value="CBSE" <%= "CBSE".equals(board) ? "selected" : "" %>>CBSE</option>
          <option value="ICSE" <%= "ICSE".equals(board) ? "selected" : "" %>>ICSE</option>
          <option value="State" <%= "State".equals(board) ? "selected" : "" %>>State Board</option>
          <option value="Other" <%= "Other".equals(board) ? "selected" : "" %>>Other</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="std" class="form-label">Standard</label>
        <select id="std" name="std" class="form-select" required>
          <option value="">-- Select Standard --</option>
          <option value="11th" <%= "11th".equals(std) ? "selected" : "" %>>11th</option>
          <option value="12th" <%= "12th".equals(std) ? "selected" : "" %>>12th</option>
          <option value="Other" <%= "Other".equals(std) ? "selected" : "" %>>Other</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="stream" class="form-label">Stream</label>
        <select id="stream" name="stream" class="form-select" required>
          <option value="">-- Select Stream --</option>
          <option value="Science" <%= "Science".equals(stream) ? "selected" : "" %>>Science</option>
          <option value="Commerce" <%= "Commerce".equals(stream) ? "selected" : "" %>>Commerce</option>
          <option value="Arts" <%= "Arts".equals(stream) ? "selected" : "" %>>Arts</option>
          <option value="Other" <%= "Other".equals(stream) ? "selected" : "" %>>Other</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="exam_preparing" class="form-label">Exam Preparing</label>
        <select id="exam_preparing" name="exam_preparing" class="form-select" required>
          <option value="">-- Select Exam --</option>
          <option value="NEET" <%= "NEET".equals(exam) ? "selected" : "" %>>NEET</option>
          <option value="JEE" <%= "JEE".equals(exam) ? "selected" : "" %>>JEE</option>
          <option value="CET" <%= "CET".equals(exam) ? "selected" : "" %>>CET</option>
          <option value="None" <%= "None".equals(exam) ? "selected" : "" %>>None</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary w-100">Update Profile</button>
    </form>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
