<%--
    Document   : userPass
    Created on : Feb 19, 2021, 6:39:58 PM
    Author     : miguelaht
--%>

<%@page import="util.Mail" %>
<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%
    // recover user password
    Dba db = new Dba();
    try {
        db.Conectar();
        db.query.execute(String.format("SELECT email FROM Personas WHERE id='%s'", request.getParameter("id")));
        ResultSet rs = db.query.getResultSet();
        String mail = null;
        while (rs.next()) {
            mail = rs.getString(1);
            break;
        }
        Mail msg = new Mail();
        String code = msg.sendMail(mail, application.getRealPath("WEB-INF/") + "main.py");

        String query = String.format("UPDATE Usuario SET password='%s', estado_p=1 WHERE id_persona='%s'", code, request.getParameter("id"));
        db.query.execute(query);
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("listPersonas.jsp");
%>
