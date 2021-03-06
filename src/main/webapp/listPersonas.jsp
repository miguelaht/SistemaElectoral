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
    String queryAdmin = "SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, U.ROL, " +
                        "U.ESTADO_U, U.PASSWORD, U.ESTADO_P, M.ID_MESA FROM PERSONAS P " +
                        "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
                        "LEFT JOIN MESAPERSONA M ON M.ID_PERSONA = P.ID WHERE ROL='%S'";

    // people on same table as miembro de mesa
    String queryMiembro = String.format(
            "SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, U.ROL, " +
            "U.ESTADO_U, U.PASSWORD, U.ESTADO_P FROM PERSONAS P " +
            "LEFT JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
            "INNER JOIN MESAPERSONA MP ON MP.ID_PERSONA= P.ID " +
            "WHERE P.ID <>'%s', U.ROL = 'EL' AND MP.ID_MESA = %s",
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
    <%
        if (request.getParameter("r") != null) {
            if (request.getParameter("r").equals("EL")) {%>
    <h4>Electores</h4>
    <%} else if (request.getParameter("r").equals("MA")) {%>
    <h4>Magistrados</h4>
    <%} else if (request.getParameter("r").equals("MM")) {%>
    <h4>Miembros de Mesa</h4>
    <%} else if (request.getParameter("r").equals("CA")) {%>
    <h4>Candidatos</h4>
    <%
            }
        }%>
    <table
            id="table"
            data-show-fullscreen="true"
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
                db.query.execute(session.getAttribute("s_rol").equals("AS") ?
                        String.format(queryAdmin, request.getParameter("r")) : queryMiembro);
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
                        class="btn btn-sm btn-outline-info"
                        data-toggle="modal"
                        data-target="#exampleModalCenter"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                         fill="currentColor" class="bi bi-clipboard-check" viewBox="0 0 16 16">
                        <path fill-rule="evenodd"
                              d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                        <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1v-1z"/>
                        <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5h3zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3z"/>
                    </svg>
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
