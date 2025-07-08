<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upload Notes - Admin</title>
    <link rel="stylesheet" href="../CSS/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        .upload-wrapper {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 30px;
        }

        .upload-form, .upload-preview {
            flex: 1 1 45%;
            min-width: 300px;
        }

        .upload-preview {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.05);
        }

        .form-label {
            font-weight: 600;
        }

        .form-control, .form-select {
            margin-bottom: 15px;
        }

        .toast-container {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 9999;
        }

        .toast {
            padding: 14px 20px;
            border-radius: 6px;
            margin-top: 10px;
            color: white;
            font-size: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            opacity: 0.95;
            animation: fadein 0.4s ease, fadeout 4s ease forwards;
        }

        .toast-success {
            background-color: #28a745;
        }

        .toast-error {
            background-color: #dc3545;
        }

        @keyframes fadein {
            0% {opacity: 0; transform: translateY(20px);}
            100% {opacity: 1; transform: translateY(0);}
        }

        @keyframes fadeout {
            0% {opacity: 1;}
            100% {opacity: 0; transform: translateY(-20px);}
        }
    </style>
</head>
<body>

<%@ include file="adminSidebar.jsp" %>

<div class="main-content p-4">
    <h2 class="mb-4">📄 Upload Notes (Cloud Storage)</h2>

    <!-- Toast Message -->
    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");
    %>
    <div class="toast-container" id="toastBox">
        <% if ("true".equals(success)) { %>
        <div class="toast toast-success">✅ Note uploaded successfully to Cloudinary!</div>
        <% } else if ("InvalidFileType".equals(error)) { %>
        <div class="toast toast-error">❌ Invalid file type. Only PDF files are allowed.</div>
        <% } else if ("serverError".equals(error)) { %>
        <div class="toast toast-error">⚠️ Server error occurred while uploading. Please try again.</div>
        <% } %>
    </div>

    <div class="upload-wrapper">
        <!-- Upload Form -->
        <form action="<%=request.getContextPath()%>/uploadNotes" method="post" enctype="multipart/form-data" class="upload-form">
            <div class="mb-3">
                <label class="form-label">Note Title</label>
                <input type="text" name="title" class="form-control" placeholder="e.g. Organic Chemistry Basics" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Description</label>
                <input type="text" name="description" class="form-control" placeholder="Short summary of note content" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Subject</label>
                <input type="text" name="subject" class="form-control" placeholder="e.g. Physics, Accountancy" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Select Standard</label>
                <select name="standard" class="form-select" required>
                    <option value="">-- Choose Standard --</option>
                    <option value="11th">11th</option>
                    <option value="12th">12th</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Select Stream</label>
                <select name="stream" class="form-select" required>
                    <option value="">-- Choose Stream --</option>
                    <option value="Science">Science</option>
                    <option value="Commerce">Commerce</option>
                    <option value="Arts">Arts</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Exam Tags</label>
                <select name="tags" multiple class="form-select" size="3" required>
                    <option value="NEET">NEET</option>
                    <option value="JEE">JEE</option>
                    <option value="CET">CET</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Upload PDF File</label>
                <input type="file" name="file" class="form-control" accept=".pdf" required>
                <small class="text-muted">Only PDF files are accepted. Max size: 50MB</small>
            </div>

            <button type="submit" class="btn btn-primary w-100">📤 Upload Note to Cloud</button>
        </form>

        <!-- Instructions / Preview -->
        <div class="upload-preview">
            <h5>🛠 How it works:</h5>
            <ul>
                <li>✅ Files are securely uploaded to <strong>Cloudinary</strong></li>
                <li>📝 Add title, description, and subject</li>
                <li>📚 Assign to <strong>Standard + Stream</strong> + Optional exam tags</li>
                <li>🔒 Only <strong>.PDF</strong> files up to <strong>10MB</strong> are supported</li>
                <li>📁 File is automatically saved in <code>/notes</code> folder in your cloud</li>
            </ul>
        </div>
    </div>
</div>

<script>
    window.addEventListener("DOMContentLoaded", () => {
        const toastBox = document.getElementById("toastBox");
        if (toastBox) {
            setTimeout(() => {
                toastBox.style.display = "none";
            }, 5000);
        }
    });
</script>

</body>
</html>
