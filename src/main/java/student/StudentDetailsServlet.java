package student;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/studentDetails")
public class StudentDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String board = request.getParameter("board");
        String std = request.getParameter("std");
        String stream = request.getParameter("stream");
        String exam = request.getParameter("exam_preparing");

        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp?error=Session+expired,+please+login+again");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "");

            PreparedStatement ps = conn.prepareStatement("INSERT INTO students (user_id, board, std, stream, exam_preparing) VALUES (?, ?, ?, ?, ?)");
            ps.setInt(1, userId);
            ps.setString(2, board);
            ps.setString(3, std);
            ps.setString(4, stream);
            ps.setString(5, exam);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("login.jsp?success=Student+profile+completed,+please+login");
            } else {
                response.sendRedirect("studentForm.jsp?error=Failed+to+save+details");
            }

            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("studentForm.jsp?error=Server+Error");
        }
    }
}
