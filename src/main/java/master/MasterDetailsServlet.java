package master;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/masterDetails")
public class MasterDetailsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String specialization = request.getParameter("subject_specialization");
        String assigned = request.getParameter("assigned");

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("user_id") : null;

        if (userId == null) {
            response.sendRedirect("login.jsp?error=Session+expired,+please+login+again");
            return;
        }

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to DB
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "")) {
                // Check if master already exists (optional, prevents duplicate insert)
                PreparedStatement check = conn.prepareStatement("SELECT * FROM masters WHERE user_id = ?");
                check.setInt(1, userId);
                ResultSet rs = check.executeQuery();
                if (rs.next()) {
                    response.sendRedirect("login.jsp?success=Master+profile+already+exists");
                    return;
                }

                // Insert new master details
                PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO masters (user_id, subject_specialization, assigned) VALUES (?, ?, ?)"
                );
                ps.setInt(1, userId);
                ps.setString(2, specialization);
                ps.setString(3, assigned);

                int rows = ps.executeUpdate();
                ps.close();

                if (rows > 0) {
                    session.invalidate(); // force re-login
                    response.sendRedirect("login.jsp?success=Master+profile+completed,+please+login");
                } else {
                    response.sendRedirect("masterForm.jsp?error=Failed+to+save+details");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("masterForm.jsp?error=Server+Error");
        }
    }
}
