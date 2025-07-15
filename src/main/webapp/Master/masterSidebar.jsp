<div class="sidebar">
    <a href="<%= request.getContextPath() %>/Master/master_dashboard.jsp">Dashboard</a>
    <a href="<%= request.getContextPath() %>/master/notes">Notes</a>
    <a href="<%= request.getContextPath() %>/Master/post_test.jsp">Post Test</a>
    <a href="#" class="disabled">Student Queries</a>
    <a href="#" class="disabled">Results</a>
    <a href="<%= request.getContextPath() %>/Master/master_profile.jsp">Profile</a>
    <a href="<%= request.getContextPath() %>/logout.jsp" class="logout">Logout</a>
</div>

<script>
    window.addEventListener("DOMContentLoaded", () => {
        const links = document.querySelectorAll(".sidebar a");
        const currentPath = window.location.pathname;
        links.forEach(link => {
            const href = link.getAttribute("href");
            if (href && currentPath.endsWith(href)) {
                link.classList.add("active");
            }
        });
    });
</script>
