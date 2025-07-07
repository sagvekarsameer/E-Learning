<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Registration - E-Learning</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f2f2f2;
    }
    .register-card {
      max-width: 450px;
      margin: 60px auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      background-color: #fff;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="card register-card">
    <h3 class="text-center mb-4">Register as Admin</h3>

    <% String error = request.getParameter("error");
      String success = request.getParameter("success");
      if (error != null) { %>
    <div class="alert alert-danger"><%= URLDecoder.decode(error, "UTF-8") %></div>
    <% } else if (success != null) { %>
    <div class="alert alert-success"><%= URLDecoder.decode(success, "UTF-8") %></div>
    <% } %>

    <form action="register" method="post" id="registerForm">
      <input type="hidden" name="role" value="admin">
      <div class="mb-3">
        <label for="username">Username:</label>
        <input type="text" class="form-control" name="username" required>
      </div>
      <div class="mb-3">
        <label for="email">Email:</label>
        <input type="email" class="form-control" name="email" required>
      </div>
      <div class="mb-3">
        <label for="password">Password:</label>
        <input type="password" class="form-control" name="password" id="password" required>
      </div>
      <div class="mb-3">
        <label for="cpassword">Confirm Password:</label>
        <input type="password" class="form-control" name="cpassword" id="cpassword" required>
        <div id="passwordMatchMsg" class="form-text"></div>
      </div>
      <button type="submit" class="btn btn-success w-100">Register</button>
    </form>
    <p class="text-center mt-3">Already have an account? <a href="login.jsp">Login here</a></p>
  </div>
</div>
<script>
  const pw = document.getElementById("password");
  const cpw = document.getElementById("cpassword");
  const msg = document.getElementById("passwordMatchMsg");
  const form = document.getElementById("registerForm");
  function check() {
    if (cpw.value && pw.value !== cpw.value) {
      msg.textContent = "Passwords do not match!";
      msg.style.color = "red";
    } else {
      msg.textContent = "Passwords match.";
      msg.style.color = "green";
    }
  }
  pw.addEventListener("input", check);
  cpw.addEventListener("input", check);
  form.addEventListener("submit", e => {
    if (pw.value !== cpw.value) {
      e.preventDefault();
      alert("Passwords do not match!");
    }
  });
</script>
</body>
</html>
