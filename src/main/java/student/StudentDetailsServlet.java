package student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/studentDetails")
public class StudentDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        String board = request.getParameter("board");
        String std = request.getParameter("std");
        String stream = request.getParameter("stream");
        String exam = request.getParameter("exam_preparing");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO student_profiles (user_id, board, standard, stream, exam_preparing) VALUES (?, ?, ?, ?, ?)"
            );
            ps.setInt(1, userId);
            ps.setString(2, board);
            ps.setString(3, std);
            ps.setString(4, stream);
            ps.setString(5, exam);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                session.invalidate(); // force re-login for session refresh
                response.sendRedirect("login.jsp?success=Profile+completed+successfully");
            } else {
                response.sendRedirect("studentForm.jsp?error=Could+not+save+details");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("studentForm.jsp?error=Server+error+occurred");
        }
    }
}
