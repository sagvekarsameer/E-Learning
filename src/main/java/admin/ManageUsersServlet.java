package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.DBUtil;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/admin/manage-users")
public class ManageUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> students = new ArrayList<>();
        List<Map<String, String>> masters = new ArrayList<>();
        List<Map<String, String>> admins = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            String query = "SELECT id, name, email, role FROM users ORDER BY FIELD(role, 'admin', 'master', 'student'), id";
            try (PreparedStatement stmt = conn.prepareStatement(query);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    String role = rs.getString("role");
                    Map<String, String> user = new HashMap<>();
                    user.put("id", String.valueOf(rs.getInt("id")));
                    user.put("name", rs.getString("name"));
                    user.put("email", rs.getString("email"));

                    switch (role) {
                        case "student" -> students.add(user);
                        case "master" -> masters.add(user);
                        case "admin" -> admins.add(user);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading users: " + e.getMessage());
        }

        request.setAttribute("students", students);
        request.setAttribute("masters", masters);
        request.setAttribute("admins", admins);
        request.getRequestDispatcher("/Admin/manageUsers.jsp").forward(request, response);
    }
}
