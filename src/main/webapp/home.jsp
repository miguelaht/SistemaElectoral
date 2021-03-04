<%--
    Document   : home
    Created on : Feb 8, 2021, 4:33:38 PM
    Author     : miguelaht
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    if (session.getAttribute("s_id") == null) {
        response.sendRedirect("index.jsp");
    }
%>
<html>

<jsp:include page="head.jsp"/>

<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4><%=session.getAttribute("s_id")%></h4>
    <h4><%=session.getAttribute("s_rol")%></h4>
    <h4><%=session.getAttribute("s_mesa")%></h4>
    <h4><%=session.getAttribute("s_v1")%></h4>
    <h4><%=session.getAttribute("s_v2")%></h4>
    <h4><%=session.getAttribute("s_v3")%></h4>
</main>
</body>
</html>
