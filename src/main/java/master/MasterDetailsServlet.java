package master;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/masterDetails")
public class MasterDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String specialization = request.getParameter("subject_specialization");
        String assigned = request.getParameter("assigned");

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
                    "INSERT INTO masters (user_id, subject_specialization, assigned) VALUES (?, ?, ?)");
            ps.setInt(1, userId);
            ps.setString(2, specialization);
            ps.setString(3, assigned);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                session.invalidate(); // Optional
                response.sendRedirect("login.jsp?success=Master+profile+completed,+please+login");
            } else {
                response.sendRedirect("masterForm.jsp?error=Failed+to+save+details");
            }

            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("masterForm.jsp?error=Server+Error");
        }
    }
}
