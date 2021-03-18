<%--
    Document   : userRol
    Created on : Feb 19, 2021, 6:57:49 PM
    Author     : miguelaht
--%>
<%@page import="database.Dba" %>
<%
    Dba db = new Dba();
    try {
        db.Conectar();
        String query = String.format("UPDATE USUARIO SET ROL='%s' WHERE ID_PERSONA='%s'",
                request.getParameter("rol_opt"), request.getParameter("id"));
        db.query.execute(query);
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
    out.print("<script>location.href = document.referrer;</script>");
%>
