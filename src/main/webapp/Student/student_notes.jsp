<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ include file="studSidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>Student Notes</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css"> <%-- Corrected path --%>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .notes-section { margin-bottom: 40px; }
    .notes-section h3 { color: #007bff; margin-bottom: 20px; }
    .card-grid { display: flex; flex-wrap: wrap; gap: 20px; }
    .note-card {
      border: 1px solid #ddd;
      padding: 15px;
      width: 100%;
      max-width: 280px;
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      transition: all 0.3s ease;
    }
    .note-card:hover {
      transform: scale(1.03);
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }
    .btn-sm {
      margin-top: 10px;
    }
  </style>
</head>
<body>

<div class="main-content p-4">
  <h2 class="mb-4">📘 Notes for You</h2>

  <%
    // Type casting and null checks for lists
    List<Map<String, String>> standardNotes = (List<Map<String, String>>) request.getAttribute("standardNotes");
    List<Map<String, String>> examNotes = (List<Map<String, String>>) request.getAttribute("examNotes");

    // Initialize lists if null to prevent NullPointerExceptions in JSP logic
    if (standardNotes == null) {
      standardNotes = Collections.emptyList();
    }
    if (examNotes == null) {
      examNotes = Collections.emptyList();
    }
  %>

  <% if (!standardNotes.isEmpty()) { %>
  <div class="notes-section">
    <h3>📗 Your Standard Notes</h3>
    <div class="card-grid">
      <% for (Map<String, String> note : standardNotes) { %>
      <div class="note-card">
        <h5><%= note.get("title") %></h5>
        <p><strong>Subject:</strong> <%= note.get("subject") %></p>
        <p><%= note.get("description") %></p>
        <a href="<%= request.getContextPath() + "/" + note.get("filePath") %>" target="_blank" class="btn btn-sm btn-outline-primary">📥 View / Download</a>
      </div>
      <% } %>
    </div>
  </div>
  <% } %>

  <% if (!examNotes.isEmpty()) { %>
  <div class="notes-section">
    <h3>🎯 Competitive Exam Notes</h3>
    <div class="card-grid">
      <% for (Map<String, String> note : examNotes) { %>
      <div class="note-card">
        <h5><%= note.get("title") %></h5>
        <p><strong>Subject:</strong> <%= note.get("subject") %></p>
        <p><%= note.get("description") %></p>
        <a href="<%= request.getContextPath() + "/" + note.get("filePath") %>" target="_blank" class="btn btn-sm btn-outline-success">📥 View / Download</a>
      </div>
      <% } %>
    </div>
  </div>
  <% } %>

  <%
    // Display warning only if both lists are empty
    if (standardNotes.isEmpty() && examNotes.isEmpty()) {
  %>
  <div class="alert alert-warning">⚠️ No notes available for your class or exam preparation.</div>
  <% } %>

  <%-- Display any error messages set by the servlet --%>
  <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
  <% if (errorMessage != null) { %>
  <div class="alert alert-danger mt-4"><%= errorMessage %></div>
  <% } %>

</div>

</body>
</html>