import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String STUDENT_ROLE = "student";
    private static final String MASTER_ROLE = "master";
    private static final String ADMIN_ROLE = "admin";

    private static final String USER_ID_ATTR = "user_id";
    private static final String NAME_ATTR = "name";
    private static final String EMAIL_ATTR = "email";
    private static final String ROLE_ATTR = "role";

    private static final String STUDENT_REGISTER_JSP = "/student-register.jsp";
    private static final String MASTER_REGISTER_JSP = "/master-register.jsp";
    private static final String ADMIN_REGISTER_JSP = "/admin-register.jsp";

    private static final String STUDENT_FORM_JSP = "/studentForm.jsp";
    private static final String MASTER_FORM_JSP = "/masterForm.jsp";
    private static final String ADMIN_FORM_JSP = "/adminForm.jsp";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cpassword = request.getParameter("cpassword");
        String role = request.getParameter("role");

        String registerJspPath;
        if (STUDENT_ROLE.equals(role)) {
            registerJspPath = STUDENT_REGISTER_JSP;
        } else if (MASTER_ROLE.equals(role)) {
            registerJspPath = MASTER_REGISTER_JSP;
        } else if (ADMIN_ROLE.equals(role)) {
            registerJspPath = ADMIN_REGISTER_JSP;
        } else {
            response.sendRedirect(request.getContextPath() + STUDENT_REGISTER_JSP + "?error=Invalid+role+selected");
            return;
        }

        if (!password.equals(cpassword)) {
            response.sendRedirect(request.getContextPath() + registerJspPath + "?error=Password+Mismatch");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            String checkEmailSql = "SELECT id FROM users WHERE email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkEmailSql)) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        response.sendRedirect(request.getContextPath() + registerJspPath + "?error=Email+already+exists");
                        return;
                    }
                }
            }

            String insertUserSql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertUserSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, role);

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                        int userId = 0;
                        if (generatedKeys.next()) {
                            userId = generatedKeys.getInt(1);
                        }

                        HttpSession oldSession = request.getSession(false);
                        if (oldSession != null) {
                            oldSession.invalidate();
                        }

                        HttpSession newSession = request.getSession(true);
                        newSession.setAttribute(USER_ID_ATTR, userId);
                        newSession.setAttribute(EMAIL_ATTR, email);
                        newSession.setAttribute(NAME_ATTR, name);
                        newSession.setAttribute(ROLE_ATTR, role);

                        if (STUDENT_ROLE.equals(role)) {
                            response.sendRedirect(request.getContextPath() + STUDENT_FORM_JSP);
                        } else if (MASTER_ROLE.equals(role)) {
                            response.sendRedirect(request.getContextPath() + MASTER_FORM_JSP);
                        } else if (ADMIN_ROLE.equals(role)) {
                            response.sendRedirect(request.getContextPath() + ADMIN_FORM_JSP);
                        }
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + registerJspPath + "?error=Failed+to+register");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + registerJspPath + "?error=Database+error+during+registration");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + registerJspPath + "?error=Server+error+during+registration");
        }
    }

    private String capitalize(String str) {
        if (str == null || str.isEmpty()) return str;
        return str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase();
    }
}
