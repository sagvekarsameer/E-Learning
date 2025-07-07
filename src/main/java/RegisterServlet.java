import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cpassword = request.getParameter("cpassword");
        String role = request.getParameter("role");

        if (role == null || !(role.equals("student") || role.equals("master") || role.equals("admin"))) {
            response.sendRedirect("student-register.jsp?error=Invalid+role");
            return;
        }

        if (!password.equals(cpassword)) {
            response.sendRedirect("register" + capitalize(role) + ".jsp?error=Password+Mismatch");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-learning", "root", "");

            // Check if email exists
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                response.sendRedirect("register" + capitalize(role) + ".jsp?error=Email+already+exists");
                return;
            }

            String sql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                int userId = 0;
                if (generatedKeys.next()) {
                    userId = generatedKeys.getInt(1);
                }

                // ✅ Store session attributes
                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);
                session.setAttribute("email", email); // Optional, useful for other forms

                // Redirect to respective form
                if (role.equals("student")) {
                    response.sendRedirect("studentForm.jsp");
                } else if (role.equals("master")) {
                    response.sendRedirect("masterForm.jsp");
                } else {
                    response.sendRedirect("adminForm.jsp");
                }
            } else {
                response.sendRedirect("register" + capitalize(role) + ".jsp?error=Failed+to+register");
            }

            rs.close();
            checkStmt.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register" + capitalize(role) + ".jsp?error=Exception");
        }
    }

    private String capitalize(String str) {
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }
}
