<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>All Notes - Master</title>
  <link rel="stylesheet" href="../CSS/style.css">
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
      max-width: 360px;
      width: 100%;
    }
    .note-title { font-weight: 600; font-size: 18px; color: #333; }
    .note-subject { font-size: 14px; color: #555; }
    .note-assigned { font-size: 13px; color: #888; }
  </style>
</head>
<body>

<%@ include file="masterSidebar.jsp" %>

<div class="main-content p-4">
  <h2 class="mb-4">📚 Available Notes (Cloud Storage)</h2>

  <%
    Map<String, List<Map<String, String>>> categorizedNotes = new HashMap<>();

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "");
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery("SELECT * FROM notes ORDER BY id DESC");

      while (rs.next()) {
        String title = rs.getString("title");
        String subject = rs.getString("subject");
        String desc = rs.getString("description");
        String filePath = rs.getString("file_path"); // Cloudinary URL
        String assigned = rs.getString("assigned_to");

        if (filePath == null || !filePath.startsWith("http")) continue;

        String key = "Others";
        if (assigned.contains("11th")) key = "11th Standard";
        else if (assigned.contains("12th")) key = "12th Standard";
        if (assigned.contains("NEET") || assigned.contains("JEE") || assigned.contains("CET")) key = "Competitive Exams";

        Map<String, String> note = new HashMap<>();
        note.put("title", title);
        note.put("subject", subject);
        note.put("description", desc);
        note.put("filePath", filePath);
        note.put("assigned", assigned);

        categorizedNotes.computeIfAbsent(key, k -> new ArrayList<>()).add(note);
      }

      conn.close();
    } catch (Exception e) {
      out.println("<div class='alert alert-danger'>Error loading notes: " + e.getMessage() + "</div>");
    }
  %>

  <% if (categorizedNotes.isEmpty()) { %>
  <div class="alert alert-warning">⚠️ No notes found in the system.</div>
  <% } else {
    for (Map.Entry<String, List<Map<String, String>>> entry : categorizedNotes.entrySet()) {
      String category = entry.getKey();
      List<Map<String, String>> notesList = entry.getValue();
  %>
  <div class="notes-section">
    <h3>📂 <%= category %></h3>
    <div class="card-grid">
      <% for (Map<String, String> note : notesList) { %>
      <div class="note-card">
        <div class="note-title"><%= note.get("title") %></div>
        <div class="note-subject">📘 Subject: <%= note.get("subject") %></div>
        <div class="note-assigned">🎯 Tags: <%= note.get("assigned") %></div>
        <p class="mt-2"><%= note.get("description") %></p>
        <a href="<%= note.get("filePath") %>" target="_blank" class="btn btn-sm btn-outline-primary mt-2">📥 View / Download</a>
      </div>
      <% } %>
    </div>
  </div>
  <% } } %>

</div>

</body>
</html>
