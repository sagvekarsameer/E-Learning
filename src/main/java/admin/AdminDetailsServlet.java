package admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/adminDetails")
public class AdminDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String institute = request.getParameter("institute");
        String access = request.getParameter("access_level");

        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp?error=Session+expired,+please+login+again");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "");

            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO admins (user_id, institute_name, access_level) VALUES (?, ?, ?)"
            );
            ps.setInt(1, userId);
            ps.setString(2, institute);
            ps.setString(3, access);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("login.jsp?success=Admin+profile+completed,+please+login");
            } else {
                response.sendRedirect("adminForm.jsp?error=Failed+to+save+details");
            }

            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminForm.jsp?error=Server+Error");
        }
    }
}
