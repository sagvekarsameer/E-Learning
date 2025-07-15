<div class="sidebar">
    <a href="<%= request.getContextPath() %>/Admin/admin_dashboard.jsp">
        <i class="bi bi-speedometer2"></i> Dashboard
    </a>
    <a href="<%= request.getContextPath() %>/Admin/upload_notes.jsp">
        <i class="bi bi-upload"></i> Upload Notes
    </a>
    <a href="<%= request.getContextPath() %>/admin/manage-notes">
        <i class="bi bi-folder-check"></i> Manage Notes
    </a>
    <a href="<%= request.getContextPath() %>/admin/manage-users">
        <i class="bi bi-people"></i> Manage Users
    </a>
    <a href="#" class="disabled">
        <i class="bi bi-bar-chart-line"></i> Reports
    </a>
    <a href="<%= request.getContextPath() %>/logout.jsp" class="logout">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>
</div>
