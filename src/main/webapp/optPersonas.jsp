<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %>
<%--
    Document   : optPersonas
    Created on : Feb 24, 2021, 2:22:56 PM
    Author     : miguelaht
--%>

<div class="row">
    <div>
        <form name="userPassForm" action="userPass.jsp" method="POST" onsubmit="return userPass(this);">
            <button class="btn btn-link">Recuperar Password</button>
        </form>
    </div>
    <% if (session.getAttribute("s_rol").equals("AS")) {%>
    <div >
        <button onclick="showForm('mesa-container')" class="btn btn-link">Asignar mesa de votacion
        </button>
        <div style="display: none;" id="mesa-container">
            <form name="userMesaForm" action="userMesa.jsp" method="POST"
                  onsubmit="return addID(this);">
                <input class="form-control" name="mesa" list="mesa-list"/>
                <datalist name="mesa-list" id="mesa-list">
                    <%
                        try {
                            Dba db = new Dba();
                            db.Conectar();
                            db.query.execute("SELECT M.ID, U.DEPARTAMENTO, U.MUNICIPIO, U.DESCRIPCION FROM MESAS M " +
                                    "INNER JOIN UBICACION U ON M.UBICACION = U.ID");
                            ResultSet rs = db.query.getResultSet();
                            while (rs.next()) {%>
                    <option value=<%=rs.getString(1)%>><%=rs.getString(2)%>, <%=rs.getString(3)%>
                        , <%=rs.getString(4)%>
                    </option>

                    <%
                            }
                            db.desconectar();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </datalist>
                <input class="btn btn-sm btn-primary" type="submit" name="submit" value="Asignar"/>
            </form>
        </div>
    </div>
    <%}%>
    <div>
        <form name="userStatusForm" action="userStatus.jsp" method="POST"
              onsubmit="return userStatus(this);">
            <button type="submit" name="activeUser" class="btn btn-link">Activar usuario</button>
        </form>
    </div>
    <% if (session.getAttribute("s_rol").equals("AS")) {%>
    <div>
        <button onclick="showForm('rol-container')" class="btn btn-link">Actualizar rol</button>
        <div style="display: none;" id="rol-container">
            <form name="userRolForm" action="userRol.jsp" method="POST"
                  onsubmit="return addID(this);">
                <input class="form-control" name="rol_opt" list="rol_list"
                       placeholder="Seleccionar Rol"/>
                <datalist id="rol_list">
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
                </datalist>
                <input class="btn btn-sm btn-primary" type="submit" name="submit" value="Actualizar"/>
            </form>
        </div>
    </div>
    <%}%>
</div>
