import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String USER_ID_ATTR = "user_id";
    private static final String NAME_ATTR = "name";
    private static final String EMAIL_ATTR = "email";
    private static final String ROLE_ATTR = "role";
    private static final String STANDARD_ATTR = "standard";
    private static final String STREAM_ATTR = "stream";
    private static final String EXAM_PREPARING_ATTR = "exam_preparing";
    private static final String BOARD_ATTR = "board";

    private static final String STUDENT_ROLE = "student";
    private static final String MASTER_ROLE = "master";
    private static final String ADMIN_ROLE = "admin";

    private static final String LOGIN_JSP_PATH = "/login.jsp";
    private static final String STUDENT_DASHBOARD_PATH = "/Student/student_dashboard.jsp";
    private static final String MASTER_DASHBOARD_PATH = "/Master/master_dashboard.jsp";
    private static final String ADMIN_DASHBOARD_PATH = "/Admin/admin_dashboard.jsp";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection()) {

            String authSql = "SELECT id, name, role FROM users WHERE email = ? AND password = ?";
            try (PreparedStatement ps = conn.prepareStatement(authSql)) {
                ps.setString(1, email);
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int userId = rs.getInt("id");
                        String name = rs.getString(NAME_ATTR);
                        String role = rs.getString(ROLE_ATTR);

                        HttpSession oldSession = request.getSession(false);
                        if (oldSession != null) {
                            oldSession.invalidate();
                        }

                        HttpSession newSession = request.getSession(true);
                        newSession.setAttribute(USER_ID_ATTR, userId);
                        newSession.setAttribute(NAME_ATTR, name);
                        newSession.setAttribute(EMAIL_ATTR, email);
                        newSession.setAttribute(ROLE_ATTR, role);

                        if (STUDENT_ROLE.equals(role)) {
                            String profileSql = "SELECT board, standard, stream, exam_preparing FROM student_profiles WHERE user_id = ?";
                            try (PreparedStatement profileStmt = conn.prepareStatement(profileSql)) {
                                profileStmt.setInt(1, userId);
                                try (ResultSet profileRs = profileStmt.executeQuery()) {
                                    if (profileRs.next()) {
                                        newSession.setAttribute(BOARD_ATTR, profileRs.getString(BOARD_ATTR));
                                        newSession.setAttribute(STANDARD_ATTR, profileRs.getString(STANDARD_ATTR));
                                        newSession.setAttribute(STREAM_ATTR, profileRs.getString(STREAM_ATTR));
                                        newSession.setAttribute(EXAM_PREPARING_ATTR, profileRs.getString(EXAM_PREPARING_ATTR));
                                    }
                                }
                            }
                            response.sendRedirect(request.getContextPath() + STUDENT_DASHBOARD_PATH);
                        } else if (MASTER_ROLE.equals(role)) {
                            response.sendRedirect(request.getContextPath() + MASTER_DASHBOARD_PATH);
                        } else if (ADMIN_ROLE.equals(role)) {
                            response.sendRedirect(request.getContextPath() + ADMIN_DASHBOARD_PATH);
                        } else {
                            response.sendRedirect(request.getContextPath() + LOGIN_JSP_PATH + "?error=Invalid+role+assigned");
                        }

                    } else {
                        response.sendRedirect(request.getContextPath() + LOGIN_JSP_PATH + "?error=Invalid+email+or+password");
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + LOGIN_JSP_PATH + "?error=Database+error+occurred+during+login");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + LOGIN_JSP_PATH + "?error=Server+error+occurred+during+login");
        }
    }
}
