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
    if (!(session.getAttribute("s_rol").equals("AS") || session.getAttribute("s_rol").equals("MM"))) {
        response.sendRedirect("home.jsp");
    }
%>
<%
    // every person
    String queryAdmin = String.format("SELECT p.id, p.nombre1 || ' ' || p.nombre2 || ' ' ||  p.apellido1 || ' ' || p.apellido2, u.rol, " +
            "u.estado_u, u.password, u.estado_p, m.id_mesa FROM PERSONAS p " +
            "INNER JOIN USUARIO u ON p.id = u.id_persona " +
            "LEFT JOIN MesaPersona m ON m.id_persona = p.id " +
            "WHERE p.id <>'%s'", session.getAttribute("s_id"));

    // people on same table as miembro de mesa
    String queryMiembro = String.format(
            "SELECT p.id, p.nombre1 || ' ' || p.nombre2 || ' ' ||  p.apellido1 || ' ' || p.apellido2, u.rol, " +
                    "u.estado_u, u.password, u.estado_p FROM PERSONAS p " +
                    "LEFT JOIN USUARIO u ON p.id = u.id_persona " +
                    "INNER JOIN MesaPersona mp ON mp.id_persona= p.id " +
                    "WHERE p.id <>'%s', u.rol = 'EL' AND mp.id_mesa = %s",
            request.getParameter("s_id"), request.getParameter("s_mesa"));
%>
<html>

<head>
    <jsp:include page="head.jsp"/>
</head>
<script>
    function mod(id, n, r) {
        $('#exampleModalCenter').on('show.bs.modal', function () {
            const modal = $(this);
            modal.find('#nombre').text(n);
            modal.find('#rol').text(r);
            document.getElementById('rol_p').value = r;
            modal.find('#id').text(id);
            document.getElementById('id_p').value = id;
        });
    }

    function userStatus(form) {
        const id = document.getElementById('id_p').value;
        if (window.confirm('Activar usuario con ID=' + id + '?')) {
            addHidden(form, 'id', id);
            return true;
        }
        return false;
    }

    function addHidden(theForm, key, value) {
        // Create a hidden input element, and append it to the form:
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = key; // 'the key/name of the attribute/field that is sent to the server
        input.value = value;
        theForm.appendChild(input);
    }

    function showForm(id) {
        const x = document.getElementById(id);
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            x.style.display = "none";
        }
    }

    function userPass(form) {
        let id = document.getElementById('id_p').value;
        addHidden(form, "id", id);
        window.alert("El password sera reestablecido y enviado por email");
    }

    function addID(form) {
        let id = document.getElementById('id_p').value;
        addHidden(form, "id", id);
    }
</script>

<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Personas</h4>
    <div class="pt-3">
        <a href="newPersona.jsp" class="nav-link">Nuevo Registro</a>
    </div>
    <form method="POST">
        <table
                id="table"
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
                <th data-field="n1">Nombre</th>
                <th data-field="rol">Rol</th>
                <th data-field="us">Estado de Usuario</th>
                <th data-field="pass">Password</th>
                <th data-field="ps">Estado del Password</th>
                <%if (session.getAttribute("s_rol").equals("AS")) {%>
                <th>Mesa</th>
                <%}%>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
                // fetch personal and user data
                try {
                    Dba db = new Dba();
                    db.Conectar();
                    db.query.execute(session.getAttribute("s_rol").equals("AS") ? queryAdmin : queryMiembro);
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
            %>
            <tr>
                <td><%=rs.getString(1)%>
                </td>
                <td><%=rs.getString(2)%>
                </td>
                <td><%=rs.getString(3) != null ? rs.getString(3) : ""%>
                </td>
                <td><%=rs.getString(4) != null ? "Activo" : "Inactivo"%>
                </td>
                <td><%=rs.getString(5) != null ? "Asignado" : "Pendiente"%>
                </td>
                <td><%=rs.getString(6) != null ? "Activo" : "Inactivo"%>
                </td>
                <%if (session.getAttribute("s_rol").equals("AS")) {%>
                <td><%=rs.getString(7)%>
                </td>
                <%}%>
                <td>
                    <button onclick="mod('<%=rs.getString(1)%>', '<%=rs.getString(2)%>',
                            '<%=rs.getString(3)%>','<%=rs.getString(6)%>')"
                            class="btn btn-sm btn-primary"
                            data-toggle="modal"
                            data-target="#exampleModalCenter"
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
    </form>

</main>

<!-- Actions Modal -->
<div class="modal bd-example-modal-lg" id="exampleModalCenter" tabindex="-1"
     role="dialog"
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
                <% if (session.getAttribute("s_rol").equals("AS") || session.getAttribute("s_rol").equals("MM")) {%>
                <jsp:include page="optPersonas.jsp"/>
                <%}%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary"
                        data-dismiss="modal">Cerrar
                </button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="tableFooter.jsp"/>
</body>
</html>
