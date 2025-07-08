package student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

@WebServlet("/student/notes")
public class StudentNotesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");

        String studentStd = (String) session.getAttribute("standard");
        String studentStream = (String) session.getAttribute("stream");
        String studentExam = (String) session.getAttribute("exam_preparing");

        // If any session value missing, try fetching from DB
        if (studentStd == null || studentStream == null || studentExam == null) {
            try (Connection conn = DBUtil.getConnection()) {
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM student_profiles WHERE user_id = ?");
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    studentStd = rs.getString("standard");
                    studentStream = rs.getString("stream");
                    studentExam = rs.getString("exam_preparing");

                    // Refresh session attributes
                    session.setAttribute("standard", studentStd);
                    session.setAttribute("stream", studentStream);
                    session.setAttribute("exam_preparing", studentExam);
                }

                rs.close();
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Unable to load student profile.");
                request.getRequestDispatcher("/Student/studentNotes.jsp").forward(request, response);
                return;
            }
        }

        List<Map<String, String>> standardNotes = new ArrayList<>();
        List<Map<String, String>> examNotes = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM notes ORDER BY id DESC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String title = rs.getString("title");
                String subject = rs.getString("subject");
                String desc = rs.getString("description");
                String filePath = rs.getString("file_path");
                String assignedTo = rs.getString("assigned_to");

                if (filePath == null || !filePath.startsWith("http")) continue;
                if (assignedTo == null) assignedTo = "";

                Set<String> assignedSet = new HashSet<>(Arrays.asList(assignedTo.split(",")));

                boolean matchedStandard = (studentStd != null && assignedSet.contains(studentStd)) ||
                        (studentStream != null && assignedSet.contains(studentStream));
                boolean matchedExam = (studentExam != null && assignedSet.contains(studentExam));

                Map<String, String> note = new HashMap<>();
                note.put("title", title);
                note.put("subject", subject);
                note.put("description", desc);
                note.put("filePath", filePath);
                note.put("assigned", assignedTo);

                if (matchedStandard) {
                    standardNotes.add(note);
                } else if (matchedExam) {
                    examNotes.add(note);
                }
            }

            rs.close();
            stmt.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading notes: " + e.getMessage());
        }

        if (standardNotes.isEmpty() && examNotes.isEmpty()) {
            request.setAttribute("errorMessage", "No relevant notes found for your profile.");
        }

        request.setAttribute("standardNotes", standardNotes);
        request.setAttribute("examNotes", examNotes);
        request.getRequestDispatcher("/Student/studentNotes.jsp").forward(request, response);
    }
}
