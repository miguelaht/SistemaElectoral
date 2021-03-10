<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %>
<%--
    Document   : optPersonas
    Created on : Feb 24, 2021, 2:22:56 PM
    Author     : miguelaht
--%>

<div class="row">
    <% if (session.getAttribute("s_rol").equals("AS") ||
           session.getAttribute("s_rol").equals("MM")) {%>
    <div class="col">
        <button formaction="userStatus.jsp" type="submit" name="activeUser"
                class="btn btn-link">Activar usuario
        </button>
    </div>
    <div class="col">
        <button formaction="userPass.jsp" class="btn btn-link">Recuperar Password</button>
    </div>
    <%}%>
    <% if (session.getAttribute("s_rol").equals("AS")) {%>
    <div class="col">
        <button type="button" onclick="showForm('mesa-container')" class="btn btn-link">Asignar
            mesa de votacion
        </button>
        <div style="display: none;" id="mesa-container">
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
            <input formaction="userMesa.jsp" class="btn btn-sm btn-primary" type="submit"
                   name="submit"
                   value="Asignar"/>
        </div>
    </div>
    <%}%>
</div>
