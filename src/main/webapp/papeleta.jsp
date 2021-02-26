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
    String query = "SELECT pe.id_papeleta, pe.id_candidato, "
            + "pr.nombre1 || ' ' || pr.nombre2 || ' ' || pr.apellido1 || ' ' || pr.apellido2, ca.foto "
            + "FROM PapeletaElectoral pe "
            + "INNER JOIN Candidato ca ON ca.id_persona = pe.id_candidato "
            + "INNER JOIN Personas pr ON ca.id_persona = pr.id "
            + "WHERE ca.id_cargo = '%s' AND ca.id_persona IN (SELECT id_candidato FROM PapeletaElectoral)";
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


