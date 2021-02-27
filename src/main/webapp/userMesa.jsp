<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 27/2/21
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%
    Dba db = new Dba();
    try {
        db.Conectar();
        String query = String.format("INSERT INTO MesaPersona (id_persona, id_mesa) VALUES('%s', %s)",
                request.getParameter("id"), request.getParameter("mesa"));
        db.query.execute(query);
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("listPersonas.jsp");
%>
