package admin;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
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
import java.util.HashMap;
import java.util.Map;

@WebServlet("/uploadNotes")
@MultipartConfig
public class UploadNotesServlet extends HttpServlet {
    private Cloudinary cloudinary;

    @Override
    public void init() {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dwkp1j8ls",
                "api_key", "225488918674755",
                "api_secret", "rXzqDS7j7YQ5S2Cr-7-337MWBqo"
        ));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sessionExpired");
            return;
        }

        try {
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

            String tempDirPath = getServletContext().getRealPath("/tempUploads");
            File tempDir = new File(tempDirPath);
            if (!tempDir.exists()) tempDir.mkdirs();

            File tempFile = new File(tempDir, "upload_" + System.currentTimeMillis() + "_" + fileName);
            filePart.write(tempFile.getAbsolutePath());

            Map<String, Object> options = new HashMap<>();
            options.put("resource_type", "raw");
            options.put("folder", "notes");

            Map uploadResult = cloudinary.uploader().upload(tempFile, options);
            String cloudinaryUrl = (String) uploadResult.get("secure_url");

            if (tempFile.exists()) tempFile.delete();

            try (Connection conn = DBUtil.getConnection()) {
                String sql = "INSERT INTO notes (title, description, subject, file_path, assigned_to, uploaded_by) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, description);
                stmt.setString(3, subject);
                stmt.setString(4, cloudinaryUrl);
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
