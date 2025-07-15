package student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/updateStudentProfile")
public class UpdateStudentProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Session+expired,+please+login+again");
            return;
        }

        String name = request.getParameter("name");
        String board = request.getParameter("board");
        String std = request.getParameter("std");
        String stream = request.getParameter("stream");
        String exam = request.getParameter("exam_preparing");

        try (Connection conn = DBUtil.getConnection()) {

            try (PreparedStatement updateProfile = conn.prepareStatement(
                    "UPDATE student_profiles SET board = ?, standard = ?, stream = ?, exam_preparing = ? WHERE user_id = ?"
            )) {
                updateProfile.setString(1, board);
                updateProfile.setString(2, std);
                updateProfile.setString(3, stream);
                updateProfile.setString(4, exam);
                updateProfile.setInt(5, userId);
                updateProfile.executeUpdate();
            }

            try (PreparedStatement updateName = conn.prepareStatement(
                    "UPDATE users SET name = ? WHERE id = ?"
            )) {
                updateName.setString(1, name);
                updateName.setInt(2, userId);
                updateName.executeUpdate();
            }

            session.setAttribute("name", name);
            session.setAttribute("board", board);
            session.setAttribute("standard", std);
            session.setAttribute("stream", stream);
            session.setAttribute("exam_preparing", exam);

            response.sendRedirect(request.getContextPath() + "/Student/profile.jsp?success=Profile+updated");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Student/profile.jsp?error=Database+update+failed");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Student/profile.jsp?error=Server+error+occurred");
        }
    }
}
