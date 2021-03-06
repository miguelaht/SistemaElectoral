<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %><%--
    Document   : formPersonas
    Created on : Feb 24, 2021, 2:19:03 PM
    Author     : miguelaht
--%>

<div class="col-md-6">
    <label for="id" class="form-label">Numero de identidad</label>
    <input type="text" class="form-control" name="id" id="id" autocomplete="off">
</div>
<div class="col-md-6">
    <label for="email" class="form-label">Correo electronico</label>
    <input type="email" class="form-control" name="email" id="email" autocomplete="off">
</div>
<div class="col-md-3 pt-3">
    <label for="name1" class="form-label">Primer nombre</label>
    <input type="text" class="form-control" name="name1" id="name1" autocomplete="off">
</div>
<div class="col-md-3 pt-3">
    <label for="name2" class="form-label">Segundo nombre</label>
    <input type="text" class="form-control" name="name2" id="name2" autocomplete="off">
</div>
<div class="col-md-6 pt-3">
    <label for="cel" class="form-label">Telefono</label>
    <input type="text" class="form-control" name="cel" id="cel" autocomplete="off">
</div>
<div class="col-md-3 pt-3">
    <label for="sur1" class="form-label">Primer apellido</label>
    <input type="text" class="form-control" name="sur1" id="sur1" autocomplete="off">
</div>
<div class="col-md-3 pt-3">
    <label for="sur2" class="form-label">Segundo apellido</label>
    <input type="text" class="form-control" name="sur2" id="sur2" autocomplete="off">
</div>
<div class="col-md-6 pt-3">
    <label for="rol" class="form-label">Rol</label>
    <select class="form-control" name="rol" id="rol" onchange="showForm('candidato');">
        <option>Seleccionar</option>
        <%
            try {
                Dba db = new Dba();
                db.Conectar();
                db.query.execute("SELECT ROL, DESCRIPCION FROM ROLES");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
        %>
        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%>
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
<div class="col-md-12 pt-3" style="display: none;" id="candidato">
    <h5>Candidato Politico</h5>
    <jsp:include page="formCandidatos.jsp"/>
</div>
<div class="pt-5 d-grid gap-2 col-6 mx-auto">
    <input type="submit" class="btn btn-primary" class="form-control" name="submit"
           value="Registrar"
           id="submit">
</div>
