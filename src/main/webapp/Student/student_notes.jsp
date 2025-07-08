<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="studSidebar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Notes for You</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .notes-section { margin-bottom: 40px; }
    .notes-section h3 { color: #007bff; margin-bottom: 20px; }
    .card-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }
    .note-card {
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 15px;
      background-color: #fff;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 320px;
    }
    .note-title { font-weight: 600; font-size: 18px; color: #333; }
    .note-subject { font-size: 14px; color: #555; }
    .note-assigned { font-size: 13px; color: #888; }
  </style>
</head>
<body>

<div class="main-content p-4">
  <h2 class="mb-4">📘 Notes for You</h2>

  <%
    String standard = (String) session.getAttribute("std");
    String stream = (String) session.getAttribute("stream");
    String exam = (String) session.getAttribute("exam_preparing");

    if (standard == null) standard = "";
    if (stream == null) stream = "";
    if (exam == null) exam = "";

    List<Map<String, String>> matchedNotes = new ArrayList<>();

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "");
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery("SELECT * FROM notes");

      while (rs.next()) {
        String assigned = rs.getString("assigned_to");
        if (assigned == null) assigned = "";

        Set<String> assignedSet = new HashSet<>(Arrays.asList(assigned.split(",")));

        boolean isForStudent = false;

        if (assignedSet.contains(standard) || assignedSet.contains(stream) || assignedSet.contains(exam)) {
          isForStudent = true;
        }

        if (isForStudent) {
          Map<String, String> note = new HashMap<>();
          note.put("title", rs.getString("title"));
          note.put("subject", rs.getString("subject"));
          note.put("description", rs.getString("description"));
          note.put("filePath", rs.getString("file_path"));
          note.put("assigned", assigned);
          matchedNotes.add(note);
        }
      }

      conn.close();
    } catch (Exception e) {
      out.println("<div class='alert alert-danger'>❌ Error: " + e.getMessage() + "</div>");
    }
  %>

  <% if (matchedNotes.isEmpty()) { %>
  <div class="alert alert-warning">⚠️ No notes available for your stream or exam preferences.</div>
  <% } else { %>
  <div class="notes-section">
    <h3>📄 Filtered Notes</h3>
    <div class="card-grid">
      <% for (Map<String, String> note : matchedNotes) { %>
      <div class="note-card">
        <div class="note-title"><%= note.get("title") %></div>
        <div class="note-subject">📘 Subject: <%= note.get("subject") %></div>
        <div class="note-assigned">🎯 Assigned To: <%= note.get("assigned") %></div>
        <p class="mt-2"><%= note.get("description") %></p>
        <a href="<%= note.get("filePath") %>" class="btn btn-sm btn-outline-primary mt-2" target="_blank">📥 Download PDF</a>
      </div>
      <% } %>
    </div>
  </div>
  <% } %>
</div>

</body>
</html>
