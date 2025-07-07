package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/uploadNotes")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class UploadNotesServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uploadPath = getServletContext().getRealPath("") + File.separator + "notes";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        try {
            HttpSession session = request.getSession(false);
            String username = (session != null) ? (String) session.getAttribute("username") : null;
            if (username == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=sessionExpired");
                return;
            }

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String subject = request.getParameter("subject");
            String standard = request.getParameter("standard");
            String stream = request.getParameter("stream");
            String[] tags = request.getParameterValues("tags");

            StringBuilder assignedTo = new StringBuilder();
            if (standard != null && !standard.isEmpty()) assignedTo.append(standard);
            if (stream != null && !stream.isEmpty()) assignedTo.append(",").append(stream);
            if (tags != null) {
                for (String tag : tags) {
                    assignedTo.append(",").append(tag);
                }
            }

            Part filePart = request.getPart("file");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (!fileName.toLowerCase().endsWith(".pdf")) {
                response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?error=InvalidFileType");
                return;
            }

            filePart.write(uploadPath + File.separator + fileName);

            try (Connection conn = DBUtil.getConnection()) {
                String sql = "INSERT INTO notes (title, description, subject, file_path, assigned_to, uploaded_by) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, description);
                stmt.setString(3, subject);
                stmt.setString(4, "notes/" + fileName);
                stmt.setString(5, assignedTo.toString());
                stmt.setString(6, username);
                stmt.executeUpdate();
            }

            response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?error=serverError");
        }
    }
}
