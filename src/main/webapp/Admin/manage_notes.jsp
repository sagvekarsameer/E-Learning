<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ include file="adminSidebar.jsp" %>
<%
  String errorMessage = (String) request.getAttribute("errorMessage");
  List<Map<String, String>> standardNotes = (List<Map<String, String>>) request.getAttribute("standardNotes");
  List<Map<String, String>> examNotes = (List<Map<String, String>>) request.getAttribute("examNotes");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Manage Notes</title>
  <link href="<%=request.getContextPath()%>/CSS/style.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    .main-content { padding: 2rem; background: #f8f9fa; min-height: 100vh; }
    .card-grid { display: flex; flex-wrap: wrap; gap: 1rem; }
    .note-card {
      width: 260px; border: 1px solid #ccc; border-radius: 0.75rem;
      padding: 1rem; background: white; box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      display: flex; flex-direction: column;
    }
    .note-title { font-weight: bold; font-size: 1.1rem; }
    .note-subject, .note-assigned { font-size: 0.9rem; color: #666; margin-bottom: 0.5rem; }
    .note-description { font-size: 0.95rem; color: #333; margin-bottom: 1rem; }
    .note-download-link { margin-top: auto; }
    .notes-section h3 { font-size: 1.3rem; margin-bottom: 1rem; color: #007bff; }
  </style>
</head>
<body>
<div class="main-content">
  <h2 class="mb-4">📚 Manage All Notes</h2>

  <% if (errorMessage != null) { %>
  <div class="alert alert-danger"><%= errorMessage %></div>
  <% } %>

  <% if ((standardNotes == null || standardNotes.isEmpty()) && (examNotes == null || examNotes.isEmpty())) { %>
  <div class="alert alert-info">No notes found in the system.</div>
  <% } else { %>

  <% if (standardNotes != null && !standardNotes.isEmpty()) { %>
  <div class="notes-section mb-5">
    <h3>📘 Academic Notes (Standard Based)</h3>
    <div class="card-grid">
      <% for (Map<String, String> note : standardNotes) { %>
      <div class="note-card">
        <div class="note-title"><%= note.get("title") %></div>
        <div class="note-subject"><i class="bi bi-book"></i> Subject: <strong><%= note.get("subject") %></strong></div>
        <div class="note-assigned"><i class="bi bi-tags"></i> <%= note.get("assigned") %></div>
        <div class="note-description"><%= note.get("description") %></div>
        <a href="<%= note.get("filePath") %>" class="btn btn-sm btn-outline-primary note-download-link" target="_blank">
          <i class="bi bi-eye"></i> View PDF
        </a>
      </div>
      <% } %>
    </div>
  </div>
  <% } %>

  <% if (examNotes != null && !examNotes.isEmpty()) { %>
  <div class="notes-section mb-5">
    <h3>🧪 Exam Preparation Notes</h3>
    <div class="card-grid">
      <% for (Map<String, String> note : examNotes) { %>
      <div class="note-card">
        <div class="note-title"><%= note.get("title") %></div>
        <div class="note-subject"><i class="bi bi-book"></i> Subject: <strong><%= note.get("subject") %></strong></div>
        <div class="note-assigned"><i class="bi bi-tags"></i> <%= note.get("assigned") %></div>
        <div class="note-description"><%= note.get("description") %></div>
        <a href="<%= note.get("filePath") %>" class="btn btn-sm btn-outline-primary note-download-link" target="_blank">
          <i class="bi bi-eye"></i> View PDF
        </a>
      </div>
      <% } %>
    </div>
  </div>
  <% } %>

  <% } %>
</div>
</body>
</html>
