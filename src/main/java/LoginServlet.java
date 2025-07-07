import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "");

            String sql = "SELECT role FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");

                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                switch (role) {
                    case "student":
                        response.sendRedirect("Student/student_dashboard.jsp");
                        break;
                    case "master":
                        response.sendRedirect("Master/master_dashboard.jsp");
                        break;
                    case "admin":
                        response.sendRedirect("Admin/admin_dashboard.jsp");
                        break;
                    default:
                        response.sendRedirect("login.jsp?error=Unknown+Role");
                        break;
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid+Credentials");
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Exception+Occurred");
        }
    }
}
