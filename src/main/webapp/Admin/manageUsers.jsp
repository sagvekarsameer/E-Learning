<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ include file="adminSidebar.jsp" %>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    List<Map<String, String>> students = (List<Map<String, String>>) request.getAttribute("students");
    List<Map<String, String>> masters = (List<Map<String, String>>) request.getAttribute("masters");
    List<Map<String, String>> admins = (List<Map<String, String>>) request.getAttribute("admins");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        .main-content { padding: 2rem; background-color: #f8f9fa; min-height: 100vh; margin-left: 240px; }
        h2 { color: #343a40; font-weight: 600; margin-bottom: 2rem; }
        .user-section h3 { color: #007bff; margin-bottom: 1rem; font-weight: 600; }
        .table { background-color: #ffffff; border: 1px solid #dee2e6; border-radius: 0.5rem; overflow: hidden; }
        .table th, .table td { vertical-align: middle; font-size: 0.95rem; }
        .alert { border-radius: 0.5rem; }
        .action-buttons { width: 120px; text-align: center; }
    </style>
</head>
<body>

<div class="main-content">
    <h2><i class="bi bi-people-fill"></i> Manage All Users</h2>

    <% if (errorMessage != null) { %>
    <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <% if ((students == null || students.isEmpty()) &&
            (masters == null || masters.isEmpty()) &&
            (admins == null || admins.isEmpty())) { %>
    <div class="alert alert-info">No users found in the system.</div>
    <% } else { %>

    <%-- === USER SECTION BLOCK START === --%>
    <%
        Map<String, List<Map<String, String>>> userMap = new LinkedHashMap<>();
        userMap.put("👑 Admins", admins);
        userMap.put("🎓 Masters", masters);
        userMap.put("📚 Students", students);
    %>

    <% for (Map.Entry<String, List<Map<String, String>>> entry : userMap.entrySet()) {
        String title = entry.getKey();
        List<Map<String, String>> list = entry.getValue();
        if (list == null || list.isEmpty()) continue;
    %>
    <div class="user-section mb-5">
        <h3><%= title %></h3>
        <table class="table table-bordered table-hover">
            <thead class="table-light">
            <tr>
                <th>ID</th><th>Name</th><th>Email</th><th class="action-buttons">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Map<String, String> user : list) { %>
            <tr>
                <td><%= user.get("id") %></td>
                <td><%= user.get("name") %></td>
                <td><%= user.get("email") %></td>
                <td>
                    <button class="btn btn-sm btn-primary me-2"
                            onclick="openEditModal('<%= user.get("id") %>', '<%= user.get("name") %>', '<%= user.get("email") %>', '<%= user.get("role") %>')">
                        <i class="bi bi-pencil-square"></i>
                    </button>
                    <button class="btn btn-sm btn-danger" onclick="confirmDelete('<%= user.get("id") %>')">
                        <i class="bi bi-trash"></i>
                    </button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } %>

    <% } %>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editUserModal" tabindex="-1">
    <div class="modal-dialog">
        <form method="post" action="<%= request.getContextPath() %>/admin/update-user">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="id" id="editUserId">
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" name="name" id="editUserName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" id="editUserEmail" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Role</label>
                        <select name="role" id="editUserRole" class="form-select" required>
                            <option value="admin">Admin</option>
                            <option value="master">Master</option>
                            <option value="student">Student</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Update</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Delete Form -->
<form id="deleteForm" method="post" action="<%= request.getContextPath() %>/admin/delete-user">
    <input type="hidden" name="userId" id="deleteUserId">
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openEditModal(id, name, email, role) {
        document.getElementById('editUserId').value = id;
        document.getElementById('editUserName').value = name;
        document.getElementById('editUserEmail').value = email;
        document.getElementById('editUserRole').value = role;
        new bootstrap.Modal(document.getElementById('editUserModal')).show();
    }

    function confirmDelete(id) {
        if (confirm("Are you sure you want to delete this user?")) {
            document.getElementById('deleteUserId').value = id;
            document.getElementById('deleteForm').submit();
        }
    }
</script>
</body>
</html>
