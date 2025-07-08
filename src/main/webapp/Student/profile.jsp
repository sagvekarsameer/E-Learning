<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="studSidebar.jsp" %>
<%
  String email = (String) session.getAttribute("email");
  if (email == null) {
    response.sendRedirect("../login.jsp");
    return;
  }

  String board = "", std = "", stream = "", exam = "";

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "");
    PreparedStatement ps = conn.prepareStatement(
            "SELECT board, standard, stream, exam_preparing FROM student_profiles WHERE user_id = (SELECT id FROM users WHERE email = ?)"
    );
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
      board = rs.getString("board");
      std = rs.getString("standard");
      stream = rs.getString("stream");
      exam = rs.getString("exam_preparing");
    }
    conn.close();
  } catch (Exception e) {
    out.println("<div class='alert alert-danger'>Error fetching profile: " + e.getMessage() + "</div>");
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Student Profile</title>
  <link rel="stylesheet" href="../CSS/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="main-content p-4">
  <h2 class="mb-4">👤 Student Profile</h2>
  <div class="card p-4 shadow-sm" style="max-width: 500px; margin: auto;">
    <form action="updateStudentProfile" method="post">
      <div class="mb-3">
        <label>Board</label>
        <select name="board" class="form-select" required>
          <option value="">-- Select Board --</option>
          <option value="CBSE" <%= "CBSE".equals(board) ? "selected" : "" %>>CBSE</option>
          <option value="ICSE" <%= "ICSE".equals(board) ? "selected" : "" %>>ICSE</option>
          <option value="State" <%= "State".equals(board) ? "selected" : "" %>>State Board</option>
        </select>
      </div>
      <div class="mb-3">
        <label>Standard</label>
        <select name="std" class="form-select" required>
          <option value="">-- Select Standard --</option>
          <option value="11th" <%= "11th".equals(std) ? "selected" : "" %>>11th</option>
          <option value="12th" <%= "12th".equals(std) ? "selected" : "" %>>12th</option>
        </select>
      </div>
      <div class="mb-3">
        <label>Stream</label>
        <select name="stream" class="form-select" required>
          <option value="">-- Select Stream --</option>
          <option value="Science" <%= "Science".equals(stream) ? "selected" : "" %>>Science</option>
          <option value="Commerce" <%= "Commerce".equals(stream) ? "selected" : "" %>>Commerce</option>
          <option value="Arts" <%= "Arts".equals(stream) ? "selected" : "" %>>Arts</option>
        </select>
      </div>
      <div class="mb-3">
        <label>Exam Preparing</label>
        <select name="exam_preparing" class="form-select" required>
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
</body>
</html>
