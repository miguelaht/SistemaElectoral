<%--
    Document   : userRol
    Created on : Feb 19, 2021, 6:57:49 PM
    Author     : miguelaht
--%>
<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%
    Dba db = new Dba();
    try {
        db.Conectar();
        String query = String.format("UPDATE Usuario SET rol='%s' WHERE id_persona='%s'",
                request.getParameter("rol_opt"), request.getParameter("rol_id"));
        db.query.execute(query);
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("listPersonas.jsp");
%>
