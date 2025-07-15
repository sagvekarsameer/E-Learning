<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <title>Register as Student - E-Learning</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css"> <%-- Link to your global style.css --%>
</head>
<body>
<div class="container">
    <%-- Replaced .register-card with .form-container for consistent styling --%>
    <div class="form-container">
        <h3 class="text-center mb-4">Register as Student</h3>

        <%
            String error = request.getParameter("error");
            String success = request.getParameter("success");

            if (error != null) {
        %>
        <div class="alert alert-danger" role="alert">
            <i class="bi bi-x-circle-fill"></i> <%= URLDecoder.decode(error, "UTF-8") %>
        </div>
        <% } else if (success != null) { %>
        <div class="alert alert-success" role="alert">
            <i class="bi bi-check-circle-fill"></i> <%= URLDecoder.decode(success, "UTF-8") %>
        </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/register" method="post" id="registerForm">
            <input type="hidden" name="role" value="student">

            <div class="mb-3">
                <label for="name" class="form-label">Name:</label>
                <input type="text" id="name" class="form-control" name="name" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" id="email" class="form-control" name="email" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" class="form-control" name="password" id="password" required>
            </div>

            <div class="mb-3">
                <label for="cpassword" class="form-label">Confirm Password:</label>
                <input type="password" class="form-control" name="cpassword" id="cpassword" required>
                <div id="passwordMatchMsg" class="form-text"></div>
            </div>

            <button type="submit" class="btn btn-success w-100">Register</button>
        </form>

        <p class="text-center mt-3">Already registered? <a href="<%= request.getContextPath() %>/login.jsp">Login here</a></p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const pw = document.getElementById("password");
    const cpw = document.getElementById("cpassword");
    const msg = document.getElementById("passwordMatchMsg");
    const form = document.getElementById("registerForm");

    function checkPasswordMatch() {
        if (cpw.value === "") {
            msg.textContent = "";
            cpw.classList.remove("is-valid", "is-invalid");
            pw.classList.remove("is-valid", "is-invalid");
            return;
        }

        if (pw.value === cpw.value) {
            msg.textContent = "✅ Passwords match.";
            msg.style.color = "green";
            pw.classList.add("is-valid");
            cpw.classList.add("is-valid");
            pw.classList.remove("is-invalid");
            cpw.classList.remove("is-invalid");
        } else {
            msg.textContent = "❌ Passwords do not match!";
            msg.style.color = "red";
            pw.classList.add("is-invalid");
            cpw.classList.add("is-invalid");
            pw.classList.remove("is-valid");
            cpw.classList.remove("is-valid");
        }
    }

    pw.addEventListener("input", checkPasswordMatch);
    cpw.addEventListener("input", checkPasswordMatch);

    form.addEventListener("submit", e => {
        if (pw.value !== cpw.value) {
            e.preventDefault();
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-danger alert-dismissible fade show mt-3';
            alertDiv.setAttribute('role', 'alert');
            alertDiv.innerHTML = `
                <i class="bi bi-x-circle-fill"></i> Passwords do not match!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            `;
            form.parentNode.insertBefore(alertDiv, form.nextSibling);
        }
    });
</script>
</body>
</html>