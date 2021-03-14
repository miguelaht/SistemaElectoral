<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 7/3/21
  Time: 07:18
  To change this template use File | Settings | File Templates.
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
<%
    String query = "SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, U.ROL, " +
                   "U.ESTADO_U, U.PASSWORD, U.ESTADO_P, M.ID_MESA, PA.NOMBRE, CA.ID_CARGO, CA.FOTO FROM PERSONAS P " +
                   "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
                   "INNER JOIN CANDIDATO CA ON CA.ID_PERSONA = P.ID " +
                   "LEFT JOIN PARTIDO PA ON CA.ID_PARTIDO = PA.ID " +
                   "LEFT JOIN MESAPERSONA M ON M.ID_PERSONA = P.ID WHERE ROL='CA'";
%>
<html>
<head>
    <jsp:include page="head.jsp"/>
    <link rel="stylesheet" href="./css/foto.css">
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

        function showPicture(src) {
            // Get the modal
            const modal = document.getElementById("fotoModal");

            // Get the image and insert it inside the modal - use its "alt" text as a caption
            const modalImg = document.getElementById("img01");

            modal.style.display = "block";
            modalImg.src = src

            // Get the <span> element that closes the modal
            const span = document.getElementsByClassName("close")[0];

            // When the user clicks on <span> (x), close the modal
            span.onclick = function () {
                modal.style.display = "none";
            }
        }
    </script>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<link rel="stylesheet" href="./css/foto.css">
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Candidatos</h4>
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
                <th>ID</th>
                <th>Nombre</th>
                <th>Rol</th>
                <th>Estado de Usuario</th>
                <th>Password</th>
                <th>Estado del Password</th>
                <th>Mesa</th>
                <th>Partido</th>
                <th>Cargo</th>
                <th>Fotografia</th>
                <th>Opciones</th>
            </tr>
            </thead>
            <tbody>
            <%
                // fetch personal and user data
                try {
                    Dba db = new Dba();
                    db.Conectar();

                    db.query.execute(query);

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
                <td><%=rs.getString(7) != null ? rs.getString(7) : "P"%>
                </td>
                <td><%=rs.getString(8)%>
                </td>
                <td><%=rs.getString(9)%>
                </td>
                <td>
                    <button type="button" class="btn btn-sm btn-link"
                            onclick="showPicture('./media/<%=rs.getString(10)%>')">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                             fill="currentColor"
                             class="bi bi-image" viewBox="0 0 16 16">
                            <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
                            <path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
                        </svg>
                    </button>
                </td>
                <td>
                    <a href="updPersona.jsp?id=<%=rs.getString(1)%>">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                             fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456l-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                            <path fill-rule="evenodd"
                                  d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                        </svg>
                    </a>
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

<div id="fotoModal" class="modal">
    <span class="close">&times;</span>
    <img class="modal-content" id="img01">
</div>

<jsp:include page="tableFooter.jsp"/>
</body>
</html>

