<%--
    Document   : listPersonas
    Created on : Feb 8, 2021, 6:19:01 PM
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
    if (!session.getAttribute("s_rol").equals("AS")) {
        response.sendRedirect("home.jsp");
    }
%>
<html>

<head>
    <jsp:include page="head.jsp"/>

</head>
<script>
    function mod(id, n1, n2, a1, a2, r) {
        $('#exampleModalCenter').on('show.bs.modal', function () {
            var modal = $(this);
            modal.find('#nombre').text(n1 + ' ' + n2 + ' ' + a1 + ' ' + a2);
            modal.find('#rol').text(r);
            document.getElementById('rol_p').value = r;
            modal.find('#id').text(id);
            document.getElementById('id_p').value = id;
        });
    }

    function userStatus(form) {
        let id = document.getElementById('id_p').value;
        if (window.confirm('Activar usuario con ID=' + id + '?')) {
            addHidden(form, 'id', id);
            return true;
        }
        return false;
    }

    function addHidden(theForm, key, value) {
        // Create a hidden input element, and append it to the form:
        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = key; // 'the key/name of the attribute/field that is sent to the server
        input.value = value;
        theForm.appendChild(input);
    }

    function showForm() {
        var x = document.getElementById("rol-container");
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            x.style.display = "none";
        }
    }

    function userPass(form) {
        let id = document.getElementById('id_p').value;
        addHidden(form, "id", id);
        window.alert("El password sera reestablecido y enviado por correo");
    }

    function userRol(form) {
        let id = document.getElementById('id_p').value;

        addHidden(form, "rol_id", id);
    }
</script>

<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Personas</h4>
    <div class="pt-3">
        <a href="newPersona.jsp" class="nav-link">Nuevo Registro</a>
    </div>
    <table
            id="table"
            data-show-pagination-switch="true"
            data-show-fullscreen="true"
            data-detail-view="true"
            data-toggle="table"
            data-pagination="true"
            data-search="true"
            data-show-columns="true"
            data-show-pagination-switch="true"
            data-show-refresh="true"
            data-key-events="true"
            data-show-toggle="true"
            data-resizable="true"
            data-cookie="true"
            data-cookie-id-table="saveId"
            data-show-export="true"
            data-click-to-select="true"
            data-show-button-icons="true"
            data-toolbar="#toolbar">
        <thead>
        <tr>
            <th data-field="id">ID</th>
            <th data-field="n1">Primer nombre</th>
            <th data-field="n2">Segundo nombre</th>
            <th data-field="a1">Primer Apellido</th>
            <th data-field="a2">Segundo Apellido</th>
            <th data-field="rol">Rol</th>
            <th data-field="us">Estado de Usuario</th>
            <th data-field="pass">Password</th>
            <th data-field="ps">Estado del Password</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            // fetch personal and user data
            try {
                Dba db = new Dba();
                db.Conectar();
                db.query.execute("SELECT p.id, p.nombre1, p.nombre2, p.apellido1, p.apellido2, u.rol, u.estado_u, "
                        + "u.password, u.estado_p FROM PERSONAS p LEFT JOIN USUARIO u on p.id = u.id_persona WHERE p.id <>'" + session.getAttribute("s_id") + "'");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
        %>
        <tr>
            <td><%=rs.getString(1)%>
            </td>
            <td><%=rs.getString(2)%>
            </td>
            <td><%=rs.getString(3)%>
            </td>
            <td><%=rs.getString(4)%>
            </td>
            <td><%=rs.getString(5)%>
            </td>
            <td><%=rs.getString(6) != null ? rs.getString(6) : ""%>
            </td>
            <td><%=rs.getString(7) != null ? rs.getString(7) : ""%>
            </td>
            <td><%=rs.getString(8) != null ? "1" : "0"%>
            </td>
            <td><%=rs.getString(9) != null ? rs.getString(9) : ""%>
            </td>
            <td>
                <button onclick="mod('<%=rs.getString(1)%>', '<%=rs.getString(2)%>',
                        '<%=rs.getString(3)%>', '<%=rs.getString(4)%>', '<%=rs.getString(5)%>',
                        '<%=rs.getString(6)%>')" class="btn btn-sm btn-primary"
                        data-toggle="modal" data-target="#exampleModalCenter"
                >Informacion
                </button>
            </td>
        </tr>
        <%
                }
                db.desconectar();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</main>

<!-- Actions Modal -->
<div class="modal bd-example-modal-lg" id="exampleModalCenter" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <div class="d-flex flex-column">
                    <h5 class="modal-title" id="nombre">NOMBRE</h5>
                    <h5 class="modal-title" id="id">ID</h5>
                    <h5 class="modal-title" id="rol">ROL</h5>
                    <input hidden type="text" id="id_p"/>
                    <input hidden type="text" id="rol_p"/>
                </div>
            </div>
            <div class="modal-body">
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
                        <form name="userStatusForm" action="userStatus.jsp" method="POST"
                              onsubmit="return userStatus(this);">
                            <button type="submit" name="activeUser" class="btn btn-link">Activar usuario</button>
                        </form>
                    </div>
                    <div class="col-6 col-sm-4">
                        <button onclick="showForm()" class="btn btn-link">Actualizar rol</button>
                        <div style="display: none;" id="rol-container">
                            <form name="userRolForm" action="userRol.jsp" method="POST"
                                  onsubmit="return userRol(this);">
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
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="tableFooter.jsp"/>
</body>
</html>
