<%--
    Document   : formCandidatos
    Created on : Feb 10, 2021, 10:37:33 AM
    Author     : miguelaht
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<div class="col-md-6">
    <label for="party" class="form-label">Partido Politico</label>
    <select class="form-select" name="party" id="party">
        <%

            try {
                Dba db = new Dba();
                db.Conectar();
                db.query.execute("SELECT NOMBRE FROM PARTIDO");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
        %>
        <option value=<%=rs.getString(1)%>><%=rs.getString(1)%>
        </option>
        <%
                }
                db.desconectar();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </select>
</div>
<div class="col-md-6">
    <label for="cargo" class="form-label">Cargo Electoral</label>
    <select class="form-select" name="cargo" id="cargo">
        <%
            try {
                Dba db = new Dba();
                db.Conectar();
                db.query.execute("SELECT NOMBRE FROM CARGO");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
        %>
        <option value=<%=rs.getString(1)%>><%=rs.getString(1)%>
        </option>
        <%
                }
                db.desconectar();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </select>
</div>
<div class="col-md-6">
    <label for="foto" class="form-label">Fotografia</label>
    <input type="file" class="form-control" id="foto" name="foto">
</div>
