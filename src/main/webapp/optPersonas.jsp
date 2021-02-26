<%--
    Document   : optPersonas
    Created on : Feb 24, 2021, 2:22:56 PM
    Author     : miguelaht
--%>

<div class="row">
    <div class="col-6 col-sm-4">
        <form name="userPassForm" action="userPass.jsp" method="POST" onsubmit="return userPass(this);">
            <button class="btn btn-link">Recuperar Password</button>
        </form>
    </div>
    <div class="col-6 col-sm-4">
        <button class="btn btn-link">Cambiar ubicacion</button>

    </div>
    <div class="col-6 col-sm-4">
        <form name="userStatusForm" action="userStatus.jsp" method="POST" onsubmit="return userStatus(this);">
            <button type="submit" name="activeUser" class="btn btn-link">Activar usuario</button>
        </form>
    </div>
    <div class="col-6 col-sm-4">
        <button onclick="showForm()" class="btn btn-link">Actualizar rol</button>
        <div style="display: none;" id="rol-container">
            <form name="userRolForm" action="userRol.jsp" method="POST" onsubmit="return userRol(this);">
                <select class="form-select" name="rol_opt" id="rol_opt">
                    <option value="" selected>Seleccionar</option>
                    <%
                        try {
                            Dba db = new Dba();
                            db.Conectar();
                            db.query.execute("SELECT rol, descripcion FROM Roles");
                            ResultSet rs = db.query.getResultSet();
                            while (rs.next()) {%>
                    <option value=<%=rs.getString(1)%>><%=rs.getString(2)%>
                    </option>

                    <%
                            }
                            db.desconectar();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
                <input class="btn btn-sm btn-primary" type="submit" name="submit" value="Actualizar"/>
            </form>
        </div>
    </div>
</div>
