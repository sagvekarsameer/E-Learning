<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<%-- Include adminSidebar.jsp for consistent navigation --%>
<%@ include file="adminSidebar.jsp" %>
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
    <title>Upload Notes - Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        .main-content {
            padding: 2rem;
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        .upload-wrapper {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 30px;
        }
        .upload-form, .upload-preview {
            flex: 1 1 45%;
            min-width: 300px;
            background-color: #ffffff;
            border-radius: 0.75rem;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        .upload-preview {
            background-color: #e9f7ef;
            border: 1px solid #d4edda;
            color: #155724;
        }
        .upload-preview h5 {
            color: #007bff;
            margin-bottom: 1rem;
        }
        .upload-preview ul {
            list-style: none;
            padding-left: 0;
        }
        .upload-preview ul li {
            margin-bottom: 0.75rem;
            display: flex;
            align-items: flex-start;
        }
        .upload-preview ul li i {
            margin-right: 0.75rem;
            color: #28a745;
            font-size: 1.2rem;
        }
        .form-label {
            font-weight: 600;
            color: #343a40;
            margin-bottom: 0.5rem;
        }
        .form-control, .form-select {
            margin-bottom: 1rem;
            border-radius: 0.375rem;
            border: 1px solid #ced4da;
            padding: 0.75rem 1rem;
        }
        .form-control:focus, .form-select:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            padding: 0.75rem 1.5rem;
            font-size: 1.1rem;
            border-radius: 0.5rem;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .toast-container {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 1050;
        }
        .toast {
            padding: 1rem 1.5rem;
            border-radius: 0.5rem;
            margin-top: 10px;
            color: white;
            font-size: 1rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            opacity: 0.95;
            animation: fadein 0.4s ease forwards, fadeout 0.4s ease forwards 4.6s;
        }
        .toast-success { background-color: #28a745; }
        .toast-error { background-color: #dc3545; }
        @keyframes fadein {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeout {
            0% { opacity: 1; transform: translateY(0); }
            100% { opacity: 0; transform: translateY(-20px); }
        }
    </style>
</head>
<body>

<%-- This include is already at the top, no need to duplicate --%>
<%-- <%@ include file="adminSidebar.jsp" %> --%>

<div class="main-content">
    <h2 class="mb-4">📄 Upload Notes (Cloud Storage)</h2>

    <%
        // Retrieve and decode success/error messages from URL parameters
        String success = request.getParameter("success");
        String error = request.getParameter("error");
    %>
    <div class="toast-container" id="toastBox">
        <% if (success != null) { %>
        <div class="toast toast-success" role="alert">
            <i class="bi bi-check-circle-fill"></i> <%= URLDecoder.decode(success, "UTF-8") %>
        </div>
        <% } else if (error != null) { %>
        <div class="toast toast-error" role="alert">
            <i class="bi bi-x-circle-fill"></i> <%= URLDecoder.decode(error, "UTF-8") %>
        </div>
        <% } %>
    </div>

    <div class="upload-wrapper">
        <form action="<%=request.getContextPath()%>/uploadNotes" method="post" enctype="multipart/form-data" class="upload-form">

            <div class="mb-3">
                <label for="title" class="form-label">Note Title</label>
                <input type="text" id="title" name="title" class="form-control" required placeholder="e.g. Organic Chemistry Basics">
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <input type="text" id="description" name="description" class="form-control" required placeholder="Short summary of the note">
            </div>

            <div class="mb-3">
                <label for="subject" class="form-label">Subject</label>
                <input type="text" id="subject" name="subject" class="form-control" required placeholder="e.g. Physics, Accountancy">
            </div>

            <div class="mb-3">
                <label class="form-label">Note Type</label><br>
                <div class="btn-group" role="group">
                    <input type="radio" class="btn-check" name="noteType" id="standardType" value="standard" autocomplete="off" checked>
                    <label class="btn btn-outline-primary" for="standardType">Standard-Based</label>

                    <input type="radio" class="btn-check" name="noteType" id="examType" value="exam" autocomplete="off">
                    <label class="btn btn-outline-success" for="examType">Exam-Based</label>
                </div>
            </div>

            <div id="standardFields">
                <div class="mb-3">
                    <label for="board" class="form-label">Select Board</label>
                    <select id="board" name="board" class="form-select">
                        <option value="">-- Choose Board --</option>
                        <option value="CBSE">CBSE</option>
                        <option value="ICSE">ICSE</option>
                        <option value="State">State Board</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="standard" class="form-label">Select Standard</label>
                    <select id="standard" name="standard" class="form-select">
                        <option value="">-- Choose Standard --</option>
                        <option value="11th">11th</option>
                        <option value="12th">12th</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="stream" class="form-label">Select Stream</label>
                    <select id="stream" name="stream" class="form-select">
                        <option value="">-- Choose Stream --</option>
                        <option value="Science">Science</option>
                        <option value="Commerce">Commerce</option>
                        <option value="Arts">Arts</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
            </div>

            <div id="examFields" style="display:none">
                <div class="mb-3">
                    <label for="exam" class="form-label">Exam</label>
                    <select id="exam" name="exam" class="form-select">
                        <option value="">-- Select Exam --</option>
                        <option value="NEET">NEET</option>
                        <option value="JEE">JEE</option>
                        <option value="CET">CET</option>
                        <option value="None">None</option>
                    </select>
                </div>
            </div>

            <div class="mb-3">
                <label for="file" class="form-label">Upload PDF File</label>
                <input type="file" id="file" name="file" class="form-control" accept="application/pdf" required>
                <small class="text-muted">Only PDF files accepted. Max size: 10MB</small>
            </div>

            <button type="submit" class="btn btn-primary w-100">
                <i class="bi bi-cloud-arrow-up-fill"></i> Upload Note to Cloud
            </button>
        </form>

        <div class="upload-preview">
            <h5><i class="bi bi-info-circle-fill"></i> How it works:</h5>
            <ul>
                <li><i class="bi bi-check-circle-fill"></i> Files uploaded to <strong>Cloudinary</strong>.</li>
                <li><i class="bi bi-book-fill"></i> Choose <strong>Standard</strong> or <strong>Exam</strong> type.</li>
                <li><i class="bi bi-file-earmark-pdf-fill"></i> Only <strong>.PDF</strong> format allowed.</li>
                <li><i class="bi bi-folder-fill"></i> Max file size: <strong>10MB</strong>.</li>
            </ul>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleNoteTypeFields() {
        const standardFields = document.getElementById('standardFields');
        const examFields = document.getElementById('examFields');
        const boardSelect = document.getElementById('board');
        const standardSelect = document.getElementById('standard');
        const streamSelect = document.getElementById('stream');
        const examSelect = document.getElementById('exam');

        const selected = document.querySelector('input[name="noteType"]:checked').value;

        if (selected === 'standard') {
            standardFields.style.display = 'block';
            examFields.style.display = 'none';

            // Set required for standard fields, remove for exam fields
            boardSelect.setAttribute('required', 'required');
            standardSelect.setAttribute('required', 'required');
            streamSelect.setAttribute('required', 'required');
            examSelect.removeAttribute('required');
        } else if (selected === 'exam') {
            standardFields.style.display = 'none';
            examFields.style.display = 'block';

            // Set required for exam fields, remove for standard fields
            examSelect.setAttribute('required', 'required');
            boardSelect.removeAttribute('required');
            standardSelect.removeAttribute('required');
            streamSelect.removeAttribute('required');
        }
    }

    // Attach event listeners to the radio buttons
    document.querySelectorAll('input[name="noteType"]').forEach(input => {
        input.addEventListener('change', toggleNoteTypeFields);
    });

    // Call on DOMContentLoaded to set initial state based on default checked radio
    window.addEventListener('DOMContentLoaded', toggleNoteTypeFields);

    // Auto-hide toasts after a few seconds
    window.addEventListener('DOMContentLoaded', (event) => {
        const toastBox = document.getElementById('toastBox');
        if (toastBox) {
            const toasts = toastBox.querySelectorAll('.toast');
            toasts.forEach(toast => {
                setTimeout(() => {
                    toast.style.opacity = '0';
                    toast.style.transform = 'translateY(-20px)';
                    setTimeout(() => {
                        toast.remove();
                    }, 500); // Allow time for fade-out animation
                }, 5000); // 5 seconds
            });
        }
    });
</script>
</body>
</html>