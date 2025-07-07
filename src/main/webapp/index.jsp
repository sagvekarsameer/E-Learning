<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome - E-Learning Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f2f2f2;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            text-align: center;
            padding: 20px;
        }

        h2 {
            margin-bottom: 10px;
            font-weight: 600;
            color: #333;
        }

        .tagline {
            font-size: 14px;
            color: #666;
            margin-bottom: 30px;
        }

        .role-section {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        .role-card {
            background-color: #fff;
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .btn-group .btn {
            padding: 10px 20px;
            font-size: 15px;
            border-radius: 6px;
            min-width: 120px;
        }

        .btn-group {
            gap: 10px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }

        @media (max-width: 768px) {
            .role-card {
                padding: 15px 20px;
            }
        }
    </style>
</head>
<body>

<h2>Welcome to the E-Learning Platform</h2>
<p class="tagline">Smart. Adaptive. Role-based learning experience.</p>

<div class="role-section">
    <div class="role-card">
        <h4>🎓 Student</h4>
        <div class="btn-group">
            <a href="/Learning_war_exploded/login.jsp?role=student" class="btn btn-outline-primary">Login</a>
            <a href="/Learning_war_exploded/student-register.jsp" class="btn btn-primary">Register</a>
        </div>
    </div>

    <div class="role-card">
        <h4>👨‍🏫 Master</h4>
        <div class="btn-group">
            <a href="/Learning_war_exploded/login.jsp?role=master" class="btn btn-outline-success">Login</a>
            <a href="/Learning_war_exploded/master-register.jsp" class="btn btn-success">Register</a>
        </div>
    </div>

    <div class="role-card">
        <h4>🛠️ Admin</h4>
        <div class="btn-group">
            <a href="/Learning_war_exploded/login.jsp?role=admin" class="btn btn-outline-danger">Login</a>
            <a href="/Learning_war_exploded/admin-register.jsp" class="btn btn-danger">Register</a>
        </div>
    </div>
</div>

</body>
</html>
