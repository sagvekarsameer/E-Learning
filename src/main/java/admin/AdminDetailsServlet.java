package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.DBUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/adminDetails")
public class AdminDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String institute = request.getParameter("institute");
        String access = request.getParameter("access_level");

        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Session+expired,+please+login+again");
            return;
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO admins (user_id, institute_name, access_level) VALUES (?, ?, ?)"
             )) {

            ps.setInt(1, userId);
            ps.setString(2, institute);
            ps.setString(3, access);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?success=Admin+profile+completed,+please+login");
            } else {
                response.sendRedirect(request.getContextPath() + "/adminForm.jsp?error=Failed+to+save+details");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/adminForm.jsp?error=Database+Error");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/adminForm.jsp?error=Server+Error");
        }
    }
}