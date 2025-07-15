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
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/uploadNotes")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class UploadNotesServlet extends HttpServlet {
    private Cloudinary cloudinary;

    @Override
    public void init() throws ServletException {
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
        Object userObj = (session != null) ? session.getAttribute("user_id") : null;
        Integer adminId = null;

        if (userObj instanceof Integer) {
            adminId = (Integer) userObj;
        } else if (userObj instanceof String) {
            try {
                adminId = Integer.parseInt((String) userObj);
            } catch (NumberFormatException ignored) {}
        }

        if (adminId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Session+Expired");
            return;
        }

        File tempFile = null;

        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String subject = request.getParameter("subject");
            String noteType = request.getParameter("noteType");
            String board = request.getParameter("board");
            String standard = request.getParameter("standard");
            String stream = request.getParameter("stream");
            String exam = request.getParameter("exam");

            if (title == null || title.trim().isEmpty() ||
                    description == null || description.trim().isEmpty() ||
                    subject == null || subject.trim().isEmpty() ||
                    noteType == null || (!noteType.equals("standard") && !noteType.equals("exam"))) {
                response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?error=MissingRequiredFields");
                return;
            }

            if (noteType.equals("standard")) {
                if (board == null || board.trim().isEmpty() ||
                        standard == null || standard.trim().isEmpty() ||
                        stream == null || stream.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?error=StandardDetailsMissing");
                    return;
                }
            } else if (noteType.equals("exam")) {
                if (exam == null || exam.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?error=ExamDetailsMissing");
                    return;
                }
            }

            Part filePart = request.getPart("file");
            if (filePart == null || filePart.getSize() == 0) {
                response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?error=NoFileSelected");
                return;
            }

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (!fileName.toLowerCase().endsWith(".pdf")) {
                response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?error=InvalidFileType");
                return;
            }

            long maxSize = 10 * 1024 * 1024;
            if (filePart.getSize() > maxSize) {
                response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?error=FileTooLarge");
                return;
            }

            String tempDirPath = getServletContext().getRealPath("/tempUploads");
            File tempDir = new File(tempDirPath);
            if (!tempDir.exists()) {
                tempDir.mkdirs();
            }

            tempFile = new File(tempDir, "upload_" + System.currentTimeMillis() + "_" + fileName);
            filePart.write(tempFile.getAbsolutePath());

            Map<String, Object> options = new HashMap<>();
            options.put("resource_type", "raw");
            options.put("folder", "notes");

            Map uploadResult = cloudinary.uploader().upload(tempFile, options);
            String cloudinaryUrl = (String) uploadResult.get("secure_url");

            try (Connection conn = DBUtil.getConnection()) {
                conn.setAutoCommit(false);

                String insertNoteSQL = "INSERT INTO notes (title, description, subject, file_path, uploaded_by, note_type) VALUES (?, ?, ?, ?, ?, ?)";
                int noteId = 0;
                try (PreparedStatement noteStmt = conn.prepareStatement(insertNoteSQL, Statement.RETURN_GENERATED_KEYS)) {
                    noteStmt.setString(1, title);
                    noteStmt.setString(2, description);
                    noteStmt.setString(3, subject);
                    noteStmt.setString(4, cloudinaryUrl);
                    noteStmt.setInt(5, adminId);
                    noteStmt.setString(6, noteType);
                    noteStmt.executeUpdate();

                    ResultSet rs = noteStmt.getGeneratedKeys();
                    if (rs.next()) {
                        noteId = rs.getInt(1);
                    } else {
                        throw new SQLException("Creating note failed, no ID obtained.");
                    }
                }

                if (noteType.equals("standard")) {
                    String updateNoteSQL = "UPDATE notes SET assigned_standard = ?, assigned_stream = ?, assigned_board = ? WHERE id = ?";
                    try (PreparedStatement stdStmt = conn.prepareStatement(updateNoteSQL)) {
                        stdStmt.setString(1, standard);
                        stdStmt.setString(2, stream);
                        stdStmt.setString(3, board);
                        stdStmt.setInt(4, noteId);
                        stdStmt.executeUpdate();
                    }
                } else if (noteType.equals("exam")) {
                    String updateExamSQL = "UPDATE notes SET assigned_exam = ? WHERE id = ?";
                    try (PreparedStatement examStmt = conn.prepareStatement(updateExamSQL)) {
                        examStmt.setString(1, exam);
                        examStmt.setInt(2, noteId);
                        examStmt.executeUpdate();
                    }
                }

                conn.commit();
                response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?success=Note+Uploaded+Successfully");

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?error=DatabaseError");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Admin/upload_notes.jsp?error=UploadFailedUnexpectedly");
        } finally {
            if (tempFile != null && tempFile.exists()) {
                tempFile.delete();
            }
        }
    }
}