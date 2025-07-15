package student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/student/notes")
public class StudentNotesServlet extends HttpServlet {

    private static final String USER_ID_SESSION_ATTR = "user_id";
    private static final String STANDARD_SESSION_ATTR = "standard";
    private static final String STREAM_SESSION_ATTR = "stream";
    private static final String EXAM_SESSION_ATTR = "exam_preparing";
    private static final String BOARD_SESSION_ATTR = "board";
    private static final String ERROR_MESSAGE_ATTR = "errorMessage";
    private static final String STANDARD_NOTES_REQ_ATTR = "standardNotes";
    private static final String EXAM_NOTES_REQ_ATTR = "examNotes";
    private static final String LOGIN_PAGE_PATH = "/login.jsp";
    private static final String STUDENT_NOTES_JSP_PATH = "/Student/student_notes.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute(USER_ID_SESSION_ATTR) == null) {
            response.sendRedirect(request.getContextPath() + LOGIN_PAGE_PATH);
            return;
        }

        int userId = (int) session.getAttribute(USER_ID_SESSION_ATTR);
        String studentStd = (String) session.getAttribute(STANDARD_SESSION_ATTR);
        String studentStream = (String) session.getAttribute(STREAM_SESSION_ATTR);
        String studentExam = (String) session.getAttribute(EXAM_SESSION_ATTR);
        String studentBoard = (String) session.getAttribute(BOARD_SESSION_ATTR);

        if (studentStd == null || studentStream == null || studentExam == null || studentBoard == null) {
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement ps = conn.prepareStatement(
                         "SELECT standard, stream, exam_preparing, board FROM student_profiles WHERE user_id = ?")) {

                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        studentStd = rs.getString("standard");
                        studentStream = rs.getString("stream");
                        studentExam = rs.getString("exam_preparing");
                        studentBoard = rs.getString("board");

                        session.setAttribute(STANDARD_SESSION_ATTR, studentStd);
                        session.setAttribute(STREAM_SESSION_ATTR, studentStream);
                        session.setAttribute(EXAM_SESSION_ATTR, studentExam);
                        session.setAttribute(BOARD_SESSION_ATTR, studentBoard);
                    } else {
                        request.setAttribute(ERROR_MESSAGE_ATTR, "Student profile not found for the logged-in user.");
                        request.getRequestDispatcher(STUDENT_NOTES_JSP_PATH).forward(request, response);
                        return;
                    }
                }
            } catch (SQLException e) {
                request.setAttribute(ERROR_MESSAGE_ATTR, "Database error loading student profile.");
                request.getRequestDispatcher(STUDENT_NOTES_JSP_PATH).forward(request, response);
                return;
            }
        }

        List<Map<String, String>> standardNotes = new ArrayList<>();
        List<Map<String, String>> examNotes = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {

            // Fetch standard notes via JOIN
            try (PreparedStatement stdStmt = conn.prepareStatement(
                    "SELECT n.title, n.subject, n.description, n.file_path, s.assigned_standard, s.assigned_stream, s.assigned_board " +
                            "FROM notes n JOIN standard_notes s ON n.id = s.note_id " +
                            "WHERE s.assigned_standard = ? AND s.assigned_stream = ? AND s.assigned_board = ? " +
                            "ORDER BY n.id DESC")) {

                stdStmt.setString(1, studentStd);
                stdStmt.setString(2, studentStream);
                stdStmt.setString(3, studentBoard);

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

            // Fetch exam notes via JOIN
            try (PreparedStatement examStmt = conn.prepareStatement(
                    "SELECT n.title, n.subject, n.description, n.file_path, e.assigned_exam " +
                            "FROM notes n JOIN exam_notes e ON n.id = e.note_id " +
                            "WHERE e.assigned_exam = ? ORDER BY n.id DESC")) {

                examStmt.setString(1, studentExam);

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
            e.printStackTrace();
            request.setAttribute(ERROR_MESSAGE_ATTR, "Database error while loading notes.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute(ERROR_MESSAGE_ATTR, "Unexpected error while loading notes.");
        }

        request.setAttribute(STANDARD_NOTES_REQ_ATTR, standardNotes);
        request.setAttribute(EXAM_NOTES_REQ_ATTR, examNotes);
        request.getRequestDispatcher(STUDENT_NOTES_JSP_PATH).forward(request, response);
    }
}
