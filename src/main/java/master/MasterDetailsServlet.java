package master;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/masterDetails")
public class MasterDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String specialization = request.getParameter("subject_specialization");
        String assigned = request.getParameter("assigned");

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("user_id") : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Session+expired,+please+login+again");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {

            try (PreparedStatement checkPs = conn.prepareStatement(
                    "SELECT id FROM masters WHERE user_id = ?")) {
                checkPs.setInt(1, userId);
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next()) {
                        response.sendRedirect(request.getContextPath() + "/login.jsp?success=Master+profile+already+exists");
                        return;
                    }
                }
            }

            try (PreparedStatement insertPs = conn.prepareStatement(
                    "INSERT INTO masters (user_id, subject_specialization, assigned) VALUES (?, ?, ?)")) {
                insertPs.setInt(1, userId);
                insertPs.setString(2, specialization);
                insertPs.setString(3, assigned);

                int rows = insertPs.executeUpdate();

                if (rows > 0) {
                    session.invalidate();
                    response.sendRedirect(request.getContextPath() + "/login.jsp?success=Master+profile+completed,+please+login");
                } else {
                    response.sendRedirect(request.getContextPath() + "/masterForm.jsp?error=Failed+to+save+details");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/masterForm.jsp?error=Database+Error");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/masterForm.jsp?error=Server+Error");
        }
    }
}
