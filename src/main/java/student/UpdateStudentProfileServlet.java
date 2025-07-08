package student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/updateStudentProfile")
public class UpdateStudentProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String board = request.getParameter("board");
        String std = request.getParameter("std");
        String stream = request.getParameter("stream");
        String exam = request.getParameter("exam_preparing");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "UPDATE student_profiles SET board = ?, standard = ?, stream = ?, exam_preparing = ? WHERE user_id = ?"
            );
            ps.setString(1, board);
            ps.setString(2, std);
            ps.setString(3, stream);
            ps.setString(4, exam);
            ps.setInt(5, userId);

            int updated = ps.executeUpdate();

            if (updated > 0) {
                session.setAttribute("standard", std);
                session.setAttribute("stream", stream);
                session.setAttribute("examTags", exam);
            }

            response.sendRedirect("profile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=Update+failed");
        }
    }
}
