<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  session.invalidate();

  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);

  response.sendRedirect("login.jsp?logout=success");
%>
