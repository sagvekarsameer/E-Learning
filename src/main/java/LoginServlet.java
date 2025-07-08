
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "");

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                String role = rs.getString("role");

                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);
                session.setAttribute("username", username);
                session.setAttribute("email", email);
                session.setAttribute("role", role);

                if ("student".equals(role)) {
                    // ✅ Load student profile from student_profiles
                    PreparedStatement profileStmt = conn.prepareStatement("SELECT standard, stream, exam_preparing FROM student_profiles WHERE user_id = ?");
                    profileStmt.setInt(1, userId);
                    ResultSet profileRs = profileStmt.executeQuery();

                    if (profileRs.next()) {
                        session.setAttribute("standard", profileRs.getString("standard"));
                        session.setAttribute("stream", profileRs.getString("stream"));
                        session.setAttribute("exam_preparing", profileRs.getString("exam_preparing"));
                    }

                    profileRs.close();
                    profileStmt.close();
                    response.sendRedirect("Student/student_dashboard.jsp");
                } else if ("master".equals(role)) {
                    response.sendRedirect("Master/master_dashboard.jsp");
                } else if ("admin".equals(role)) {
                    response.sendRedirect("Admin/admin_dashboard.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=Invalid+role+assigned");
                }

            } else {
                response.sendRedirect("login.jsp?error=Invalid+email+or+password");
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Server+error+occurred");
        }
    }
}
