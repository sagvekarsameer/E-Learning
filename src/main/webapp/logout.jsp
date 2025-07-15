<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  session.invalidate();
  jakarta.servlet.http.Cookie[] cookies = request.getCookies();
  if (cookies != null) {
    for (jakarta.servlet.http.Cookie cookie : cookies) {
      if (cookie.getName().equalsIgnoreCase("JSESSIONID")) {
        cookie.setMaxAge(0);
        cookie.setPath(request.getContextPath() + "/");
        response.addCookie(cookie);
      }
    }
  }

  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);

  response.sendRedirect(request.getContextPath() + "/login.jsp?logout=success");
%>
