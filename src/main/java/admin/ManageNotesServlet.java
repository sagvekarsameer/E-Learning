package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/admin/manage-notes")
public class ManageNotesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> standardNotes = new ArrayList<>();
        List<Map<String, String>> examNotes = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {

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
                            note.put("assigned", "Board: " + rs.getString("assigned_board") +
                                    ", Std: " + rs.getString("assigned_standard") +
                                    ", Stream: " + rs.getString("assigned_stream"));
                            standardNotes.add(note);
                        }
                    }
                }
            }

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

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading notes: " + e.getMessage());
        }

        request.setAttribute("standardNotes", standardNotes);
        request.setAttribute("examNotes", examNotes);
        request.getRequestDispatcher("/Admin/manage_notes.jsp").forward(request, response);
    }
}
