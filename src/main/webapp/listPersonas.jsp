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
    if (session.getAttribute("s_rol").equals("MM") && !request.getParameter("r").equals("EL")) {
        response.sendRedirect("listPersonas.jsp?r=EL");
    }
%>
<%
    String queryAS =
            "SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, U.ROL, " +
            "U.ESTADO_U, U.PASSWORD, U.ESTADO_P, M.ID_MESA FROM PERSONAS P " +
            "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
            "LEFT JOIN MESAPERSONA M ON M.ID_PERSONA = P.ID WHERE ROL='%S'";
    String queryMM =
            "SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, U.ROL, " +
            "U.ESTADO_U, U.PASSWORD, U.ESTADO_P, M.ID_MESA FROM PERSONAS P " +
            "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
            "INNER JOIN MESAPERSONA M on P.ID = M.ID_PERSONA " +
            "JOIN MESAPERSONA M ON M.ID_PERSONA = P.ID WHERE ROL='%S' AND M.ID_MESA =" + session.getAttribute("s_mesa");
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
    <%} else if (request.getParameter("r").equals("AS")) {%>
    <h4>Administradores</h4>
    <%

            }
        }%>
    <form method="POST">
        <div class="container">
            <div class="row align-items-start">
                <jsp:include page="optPersonas.jsp"/>
            </div>
        </div>
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
                <th>Seleccionar</th>
                <th data-field="id">ID</th>
                <th data-field="n1">Nombre</th>
                <th data-field="rol">Rol</th>
                <th data-field="us">Estado de Usuario</th>
                <th data-field="pass">Password</th>
                <th data-field="ps">Estado del Password</th>
                <%if (session.getAttribute("s_rol").equals("AS")) {%>
                <th>Mesa</th>
                <th>Acciones</th>
                <%}%>
            </tr>
            </thead>
            <tbody>
            <%
                // fetch personal and user data
                try {
                    Dba db = new Dba();
                    db.Conectar();

                    if (session.getAttribute("s_rol").equals("AS")) {
                        db.query.execute(String.format(queryAS, request.getParameter("r")));
                    } else if (session.getAttribute("s_rol").equals("MM") &&
                               request.getParameter("r").equals("EL")) {
                        db.query.execute(String.format(queryMM, request.getParameter("r")));
                    }

                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
            %>
            <tr>
                <td>
                    <input <%=request.getParameter("check")%> value="<%=rs.getString(1)%>"
                                                              class="form-check-input"
                                                              type="checkbox" name="id"/>
                </td>
                <td><%=rs.getString(1)%>
                </td>
                <td><%=rs.getString(2)%>
                </td>
                <td><%=rs.getString(3) != null ? rs.getString(3) : ""%>
                </td>
                <td><%=rs.getInt(4) != 0 ? "Activo" : "Inactivo"%>
                </td>
                <td><%=rs.getString(5) != null ? "Asignado" : "Pendiente"%>
                </td>
                <td><%=rs.getInt(6) != 0 ? "Activo" : "Inactivo"%>
                </td>
                <%if (session.getAttribute("s_rol").equals("AS")) {%>
                <td><%=rs.getString(7) != null ? rs.getString(7) : "P"%>
                </td>
                <td>
                    <a href="updPersona.jsp?id=<%=rs.getString(1)%>"
                       class="btn btn-sm btn-outline-info">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                             fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456l-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                            <path fill-rule="evenodd"
                                  d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                        </svg>
                    </a>
                    <%if (!rs.getString(3).equals("CA")) {%>
                    <a title="Eliminar" type="submit" class="btn btn-sm btn-outline-danger"
                       href="userDel.jsp?id=<%=rs.getString(1)%>">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                             fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"></path>
                            <path fill-rule="evenodd"
                                  d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"></path>
                        </svg>
                    </a>
                    <%}%>
                </td>
                <%}%>
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

<jsp:include page="tableFooter.jsp"/>
</body>
</html>
