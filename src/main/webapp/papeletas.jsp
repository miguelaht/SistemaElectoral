<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 2/3/21
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("s_id") == null) {
        response.sendRedirect("index.jsp");
    }
    if (!session.getAttribute("s_rol").equals("AS")) {
        response.sendRedirect("home.jsp");
    }
%>
<!DOCTYPE html>
<%
    String candExists =
            "SELECT P.NOMBRE, PR.ID, PR.NOMBRE1 || ' ' || PR.NOMBRE2 || ' ' || PR.APELLIDO1 || ' ' || PR.APELLIDO2, CA.FOTO\n" +
            "FROM PAPELETAELECTORAL PE\n" +
            "INNER JOIN CANDIDATO CA ON CA.ID_PERSONA = PE.ID_CANDIDATO\n" +
            "INNER JOIN PERSONAS PR ON PR.ID = PE.ID_CANDIDATO\n" +
            "INNER JOIN PARTIDO P ON CA.ID_PARTIDO = P.ID\n" +
            " JOIN PAPELETA PA ON PA.ID = PE.ID_PAPELETA\n" +
            "WHERE PA.ID = %s";
    String candNotExists =
            "SELECT P.NOMBRE, PR.ID, PR.NOMBRE1 || ' ' || PR.NOMBRE2 || ' ' || PR.APELLIDO1 || ' ' || PR.APELLIDO2, CA.FOTO\n" +
            "FROM CANDIDATO CA\n" +
            "INNER JOIN PERSONAS PR ON PR.ID = CA.ID_PERSONA\n" +
            "INNER JOIN PARTIDO P ON CA.ID_PARTIDO = P.ID\n" +
            "WHERE CA.ID_CARGO='%S' AND CA.ID_PERSONA NOT IN (SELECT ID_CANDIDATO FROM PAPELETAELECTORAL)";
    String mesaExists = "SELECT M.ID, U.DEPARTAMENTO, U.MUNICIPIO\n" +
                        "FROM MESAS M\n" +
                        "INNER JOIN UBICACION U ON M.UBICACION = U.ID\n" +
                        "WHERE EXISTS(SELECT 1 FROM MESAPAPELETA WHERE ID_MESA = M.ID AND ID_PAPELETA = %s)\n" +
                        "GROUP BY M.ID, U.DEPARTAMENTO, U.MUNICIPIO\n";
    String mesaNotExists = "SELECT M.ID, U.DEPARTAMENTO, U.MUNICIPIO\n" +
                           "FROM MESAS M\n" +
                           "INNER JOIN UBICACION U ON M.UBICACION = U.ID\n" +
                           "WHERE NOT EXISTS(SELECT 1 FROM MESAPAPELETA WHERE ID_MESA = M.ID AND ID_PAPELETA = %s)\n" +
                           "GROUP BY M.ID, U.DEPARTAMENTO, U.MUNICIPIO\n";
%>
<html>
<head>
    <jsp:include page="head.jsp"/>
    <link rel="stylesheet" href="./css/foto.css">
    <script type="application/javascript">
        function addHidden(theForm, key, value) {
            // Create a hidden input element, and append it to the form:
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = key; // 'the key/name of the attribute/field that is sent to the server
            input.value = value;
            theForm.appendChild(input);
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
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Papeleta de
        <%=request.getParameter("tipo")%> : <%=request.getParameter("id")%>
    </h4>
    <div>

        <%if (request.getParameter("opt") == null) {%>
        <h4>Nada que mostrar</h4>
        <%}%>
        <% if (request.getParameter("opt").equals("c")) {%>
        <%-- candidatos en papeleta --%>
        <div class="mt-3">
            <h5>Candidatos En papeleta</h5>
            <form action="optCandidato.jsp" method="POST">
                <jsp:include page="candPapeleta.jsp">
                    <jsp:param name="query"
                               value='<%=String.format(candExists,request.getParameter("id"))%>'/>
                </jsp:include>
                <button type="submit" value="rm" class="btn btn-sm btn-danger"
                        name="rm">Remover
                </button>
            </form>
        </div>
        <div class="mt-3">
            <h5>Candidatos Disponibles</h5>
            <form action="optCandidato.jsp" method="POST"
                  onsubmit='addHidden(this, "id_pl", <%=request.getParameter("id")%>)'>
                <jsp:include page="candPapeleta.jsp">
                    <jsp:param name="query"
                               value='<%=String.format(candNotExists,request.getParameter("tipo"))%>'/>
                </jsp:include>
                <button type="submit" value="add" class="btn btn-sm btn-primary"
                        name="add">Agregar
                </button>
            </form>
        </div>
        <%}%>

        <%-- mesas --%>
        <%-- exists --%>
        <% if (request.getParameter("opt").equals("m")) {%>
        <div class="mt-3">
            <h5>Mesas en las que ha sido asignada</h5>
            <form method="POST" action="optMesa.jsp"
                  onsubmit='addHidden(this, "id_p", <%=request.getParameter("id")%>)'>
                <jsp:include page="mesaPapeleta.jsp">
                    <jsp:param name="query" value='<%=String.format(mesaExists,
                    request.getParameter("id"))%>'/>
                </jsp:include>
                <input type="submit" name="rm" value="Remover" class="btn btn-danger btn-sm">
            </form>
        </div>
        <%-- !exists --%>
        <div class="mt-3">
            <h5>Mesas disponibles</h5>
            <form method="POST" action="optMesa.jsp"
                  onsubmit='addHidden(this, "id_p", <%=request.getParameter("id")%>)'>
                <jsp:include page="mesaPapeleta.jsp">
                    <jsp:param name="query" value='<%=String.format(mesaNotExists,
                    request.getParameter("id"))%>'/>
                </jsp:include>
                <input type="submit" name="add" value="Agegar" class="btn btn-primary btn-sm">
            </form>
        </div>
        <%}%>
    </div>
</main>
<div id="fotoModal" class="modal">
    <span class="close">&times;</span>
    <img class="modal-content" id="img01">
</div>
<jsp:include page="tableFooter.jsp"/>
</body>
</html>