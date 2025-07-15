<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);

  if (session == null || session.getAttribute("role") == null || !"student".equals(session.getAttribute("role"))) {
    response.sendRedirect(request.getContextPath() + "/login.jsp?error=Access+denied");
    return;
  }

  String errorMessage = (String) request.getAttribute("errorMessage");
  List<Map<String, String>> standardNotes = (List<Map<String, String>>) request.getAttribute("standardNotes");
  List<Map<String, String>> examNotes = (List<Map<String, String>>) request.getAttribute("examNotes");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Your Study Notes</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <style>
    .main-content {
      padding: 2rem;
      background-color: #f8f9fa;
      min-height: calc(100vh - 56px);
    }

    .notes-section {
      margin-bottom: 2.5rem;
    }

    .notes-section h3 {
      color: #007bff;
      margin-bottom: 1.5rem;
      font-weight: 600;
      text-align: left;
    }

    .card-grid {
      display: flex;
      flex-wrap: wrap;
      justify-content: flex-start;
      gap: 1rem;
    }

    .note-card {
      width: 260px;
      border: 1px solid #bfc7ff;
      border-radius: 0.75rem;
      padding: 1rem;
      background-color: #ffffff;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
      display: flex;
      flex-direction: column;
    }

    .note-title {
      font-weight: 700;
      font-size: 1.1rem;
      color: #212529;
      margin-bottom: 0.5rem;
    }

    .note-subject,
    .note-assigned {
      font-size: 0.85rem;
      color: #6c757d;
      margin-bottom: 0.25rem;
    }

    .note-subject strong {
      color: #495057;
    }

    .note-description {
      font-size: 0.9rem;
      color: #495057;
      margin-top: 0.5rem;
      flex-grow: 1;
      margin-bottom: 0.75rem;
    }

    .note-download-link {
      margin-top: auto;
    }

    .alert-info {
      background-color: #d1ecf1;
      border-color: #bee5eb;
      color: #0c5460;
      padding: 1.5rem;
      border-radius: 0.5rem;
      margin-top: 2rem;
      text-align: center;
    }

    .alert-info .alert-heading {
      font-weight: 700;
      margin-bottom: 0.75rem;
    }

    .alert-danger {
      background-color: #f8d7da;
      border-color: #f5c6cb;
      color: #721c24;
      padding: 1rem 1.25rem;
      border-radius: 0.5rem;
      margin-top: 1.5rem;
    }
  </style>
</head>
<body>

<%@ include file="studSidebar.jsp" %>

<div class="main-content p-4">
  <h2 class="mb-4">📘 Your Personal Study Notes</h2>

  <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
  <div class="alert alert-danger"><%= errorMessage %></div>
  <% } %>

  <% if ((standardNotes == null || standardNotes.isEmpty()) && (examNotes == null || examNotes.isEmpty()) && errorMessage == null) { %>
  <div class="alert alert-info">
    <h4 class="alert-heading">No Notes Yet!</h4>
    <p>No study notes assigned to your profile yet. Please check back later.</p>
  </div>
  <% } else { %>

  <% if (standardNotes != null && !standardNotes.isEmpty()) { %>
  <div class="notes-section">
    <h3>📚 Academic Notes (Board / Standard / Stream)</h3>
    <div class="card-grid">
      <% for (Map<String, String> note : standardNotes) { %>
      <div class="note-card">
        <div class="note-title"><%= note.get("title") %></div>
        <div class="note-subject"><i class="bi bi-book"></i> Subject: <strong><%= note.get("subject") %></strong></div>
        <div class="note-assigned"><i class="bi bi-tag"></i> Tags: <%= note.get("assigned") %></div>
        <p class="note-description"><%= note.get("description") %></p>
        <a href="<%= note.get("filePath") %>" class="btn btn-sm btn-outline-primary note-download-link" target="_blank">
          <i class="bi bi-download"></i> Download PDF
        </a>
      </div>
      <% } %>
    </div>
  </div>
  <% } %>

  <% if (examNotes != null && !examNotes.isEmpty()) { %>
  <div class="notes-section">
    <h3>🧪 Exam Preparation Notes (NEET / JEE / CET)</h3>
    <div class="card-grid">
      <% for (Map<String, String> note : examNotes) { %>
      <div class="note-card">
        <div class="note-title"><%= note.get("title") %></div>
        <div class="note-subject"><i class="bi bi-book"></i> Subject: <strong><%= note.get("subject") %></strong></div>
        <div class="note-assigned"><i class="bi bi-tag"></i> Tags: <%= note.get("assigned") %></div>
        <p class="note-description"><%= note.get("description") %></p>
        <a href="<%= note.get("filePath") %>" class="btn btn-sm btn-outline-primary note-download-link" target="_blank">
          <i class="bi bi-download"></i> Download PDF
        </a>
      </div>
      <% } %>
    </div>
  </div>
  <% } %>

  <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
