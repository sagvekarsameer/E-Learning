package student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/studentDetails")
public class StudentDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Session+expired,+please+login+again");
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        String board = request.getParameter("board");
        String std = request.getParameter("std");
        String stream = request.getParameter("stream");
        String exam = request.getParameter("exam_preparing");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO student_profiles (user_id, board, standard, stream, exam_preparing) VALUES (?, ?, ?, ?, ?)"
             )) {

            ps.setInt(1, userId);
            ps.setString(2, board);
            ps.setString(3, std);
            ps.setString(4, stream);
            ps.setString(5, exam);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/login.jsp?success=Profile+completed+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/studentForm.jsp?error=Could+not+save+details");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/studentForm.jsp?error=Database+error+occurred");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/studentForm.jsp?error=Server+error+occurred");
        }
    }
}
