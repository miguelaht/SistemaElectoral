<%--
    Document   : papeleta
    Created on : Feb 8, 2021, 5:58:33 PM
    Author     : miguelaht
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    if (session.getAttribute("s_id") == null) {
        response.sendRedirect("index.jsp");
    }
%>

<%
    String query = "SELECT PE.ID_PAPELETA, PE.ID_CANDIDATO, "
            + "PR.NOMBRE1 || ' ' || PR.NOMBRE2 || ' ' || PR.APELLIDO1 || ' ' || PR.APELLIDO2, CA.FOTO "
            + "FROM PAPELETAELECTORAL PE "
            + "INNER JOIN CANDIDATO CA ON CA.ID_PERSONA = PE.ID_CANDIDATO "
            + "INNER JOIN PERSONAS PR ON CA.ID_PERSONA = PR.ID "
            + "WHERE CA.ID_CARGO = '%s' AND CA.ID_PERSONA IN (SELECT ID_CANDIDATO FROM PAPELETAELECTORAL)";
%>


<div class="row justify-content-between">
    <%
        try {
            Dba db = new Dba();
            db.Conectar();
            db.query.execute(String.format(query, request.getParameter("tipo")));
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
    %>

    <div class=" col-6 col-sm-3 p-3 border border-secondary border-1 rounded">
        <div>
            <img src="./media/<%=rs.getString(4)%>" class="img-thumbnail">
        </div>

        <div class="px-auto"><%=rs.getString(3)%>
        </div>
        <div class="form-check form-switch">
            <input type="checkbox" class="form-check-input" name="voto_id"/>
        </div>
    </div>

    <%
            }
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>


