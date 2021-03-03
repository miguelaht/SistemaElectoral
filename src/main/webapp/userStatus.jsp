<%--
    Document   : userStatus
    Created on : Feb 19, 2021, 3:57:35 PM
    Author     : miguelaht
--%>
<%@page import="database.Dba" %>
<%
    // update user status so it can login
    Dba db = new Dba();
    try {
        db.Conectar();
        String query = String.format("UPDATE USUARIO SET ESTADO_U=1 WHERE ID_PERSONA='%s'", request.getParameter("id"));
        db.query.execute(query);
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("listPersonas.jsp");
%>
