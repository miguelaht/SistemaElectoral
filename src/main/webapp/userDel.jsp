<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 18/3/21
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %>
<%
    Dba db = new Dba();
    try {
        db.Conectar();
        db.query.execute(String.format("SELECT ID_VOTANTE FROM VOTO WHERE ID_VOTANTE='%s'",
                request.getParameter("id")));
        ResultSet rs = db.query.getResultSet();
        if (!rs.next()) {
            db.query.execute(String.format("DELETE FROM MESAPERSONA WHERE ID_PERSONA='%s'",
                    request.getParameter("id")));
            db.query.execute(String.format("DELETE FROM USUARIO WHERE ID_PERSONA='%s'",
                    request.getParameter("id")));
            db.query.execute(String.format("DELETE FROM PERSONAS WHERE ID='%s'",
                    request.getParameter("id")));
        } else {
            out.print("<script>alert('El registro no puede ser eliminado, usuario ya ha votado'); location.href = document.referrer;</script>");
        }
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
    out.print("<script>location.href = document.referrer;</script>");
%>
