<%--
    Document   : userStatus
    Created on : Feb 19, 2021, 3:57:35 PM
    Author     : miguelaht
--%>
<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%
    // update user status so it can login
    Dba db = new Dba();
    try {
        db.Conectar();
        String query = String.format("UPDATE Usuario SET estado_u=1 WHERE id_persona='%s'", request.getParameter("id"));
        db.query.execute(query);
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("listPersonas.jsp");
%>
