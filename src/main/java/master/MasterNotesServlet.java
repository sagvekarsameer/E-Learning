package master;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/master/notes")
public class MasterNotesServlet extends HttpServlet {

    private static final String ROLE_ATTR = "role";
    private static final String ERROR_MESSAGE_ATTR = "errorMessage";
    private static final String STANDARD_NOTES_REQ_ATTR = "standardNotes";
    private static final String EXAM_NOTES_REQ_ATTR = "examNotes";
    private static final String LOGIN_PAGE_PATH = "/login.jsp";
    private static final String MASTER_NOTES_JSP_PATH = "/Master/master_notes.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"master".equals(session.getAttribute(ROLE_ATTR))) {
            response.sendRedirect(request.getContextPath() + LOGIN_PAGE_PATH + "?error=Access+denied");
            return;
        }

        List<Map<String, String>> standardNotes = new ArrayList<>();
        List<Map<String, String>> examNotes = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {

            // ✅ Standard Notes
            try (PreparedStatement stdStmt = conn.prepareStatement(
                    "SELECT n.title, n.subject, n.description, n.file_path, " +
                            "s.assigned_standard, s.assigned_stream, s.assigned_board " +
                            "FROM notes n JOIN standard_notes s ON n.id = s.note_id " +
                            "ORDER BY n.id DESC")) {

                try (ResultSet rs = stdStmt.executeQuery()) {
                    while (rs.next()) {
                        String filePath = rs.getString("file_path");
                        if (filePath != null && filePath.startsWith("http")) {
                            Map<String, String> note = new HashMap<>();
                            note.put("title", rs.getString("title"));
                            note.put("subject", rs.getString("subject"));
                            note.put("description", rs.getString("description"));
                            note.put("filePath", filePath);
                            note.put("assigned", "Board: " + rs.getString("assigned_board")
                                    + ", Std: " + rs.getString("assigned_standard")
                                    + ", Stream: " + rs.getString("assigned_stream"));
                            standardNotes.add(note);
                        }
                    }
                }
            }

            // ✅ Exam Notes
            try (PreparedStatement examStmt = conn.prepareStatement(
                    "SELECT n.title, n.subject, n.description, n.file_path, e.assigned_exam " +
                            "FROM notes n JOIN exam_notes e ON n.id = e.note_id " +
                            "ORDER BY n.id DESC")) {

                try (ResultSet rs = examStmt.executeQuery()) {
                    while (rs.next()) {
                        String filePath = rs.getString("file_path");
                        if (filePath != null && filePath.startsWith("http")) {
                            Map<String, String> note = new HashMap<>();
                            note.put("title", rs.getString("title"));
                            note.put("subject", rs.getString("subject"));
                            note.put("description", rs.getString("description"));
                            note.put("filePath", filePath);
                            note.put("assigned", "Exam: " + rs.getString("assigned_exam"));
                            examNotes.add(note);
                        }
                    }
                }
            }

        } catch (SQLException e) {
            request.setAttribute(ERROR_MESSAGE_ATTR, "Database error while loading notes: " + e.getMessage());
        }

        request.setAttribute(STANDARD_NOTES_REQ_ATTR, standardNotes);
        request.setAttribute(EXAM_NOTES_REQ_ATTR, examNotes);
        request.getRequestDispatcher(MASTER_NOTES_JSP_PATH).forward(request, response);
    }
}
