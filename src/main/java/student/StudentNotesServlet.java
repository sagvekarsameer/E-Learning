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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }

        // DEBUG: Print session data
        String std = (String) session.getAttribute("std");
        String stream = (String) session.getAttribute("stream");
        String exam = (String) session.getAttribute("exam_preparing");

        System.out.println("Student Session - STD: " + std + ", Stream: " + stream + ", Exam: " + exam);

        String studentStd = std != null ? std.trim().toLowerCase() : "";
        String studentStream = stream != null ? stream.trim().toLowerCase() : "";
        String studentExam = exam != null ? exam.trim().toLowerCase() : "";

        List<Map<String, String>> standardNotes = new ArrayList<>();
        List<Map<String, String>> examNotes = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM notes";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String assignedTo = rs.getString("assigned_to");
                if (assignedTo == null || assignedTo.isEmpty()) continue;

                // DEBUG
                System.out.println("Checking note: " + rs.getString("title") + " | assigned_to: " + assignedTo);

                String[] parts = assignedTo.toLowerCase().split("[,\\-]");
                Set<String> assignedSet = new HashSet<>();
                for (String p : parts) assignedSet.add(p.trim());

                boolean isStandardMatch = assignedSet.contains(studentStd) && assignedSet.contains(studentStream);
                boolean isExamMatch = !studentExam.isEmpty() && assignedSet.contains(studentExam);

                if (isStandardMatch) {
                    Map<String, String> note = new HashMap<>();
                    note.put("title", rs.getString("title"));
                    note.put("subject", rs.getString("subject"));
                    note.put("description", rs.getString("description"));
                    note.put("filePath", rs.getString("file_path"));
                    standardNotes.add(note);
                    System.out.println("✅ Added to Standard Notes: " + rs.getString("title"));
                } else if (isExamMatch) {
                    Map<String, String> note = new HashMap<>();
                    note.put("title", rs.getString("title"));
                    note.put("subject", rs.getString("subject"));
                    note.put("description", rs.getString("description"));
                    note.put("filePath", rs.getString("file_path"));
                    examNotes.add(note);
                    System.out.println("✅ Added to Exam Notes: " + rs.getString("title"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("standardNotes", standardNotes);
        request.setAttribute("examNotes", examNotes);
        request.getRequestDispatcher("/Student/studentNotes.jsp").forward(request, response);
    }
}
