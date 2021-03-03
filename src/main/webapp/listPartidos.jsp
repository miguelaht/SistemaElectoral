<%--
    Document   : listPartidos
    Created on : Feb 11, 2021, 10:27:51 AM
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
<%
    String queryCandidatos = "SELECT P.ID, P.NOMBRE1, P.NOMBRE2, P.APELLIDO1, P.APELLIDO2 "
            + "FROM PERSONAS P "
            + "INNER JOIN CANDIDATO C ON P.ID = C.ID_PERSONA "
            + "WHERE C.ID_CARGO='%s' AND C.ID_PARTIDO='%s'";
    String queryPersonas = "SELECT P.ID, P.NOMBRE1, P.NOMBRE2, P.APELLIDO1, P.APELLIDO2 FROM PERSONAS P"
            + " WHERE P.ID NOT IN (SELECT ID_PERSONA FROM CANDIDATO)";
%>
<html>
<head>
    <jsp:include page="head.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Partido
        <form method="GET" action="listPartidos.jsp">
            <select onchange="this.form.submit()" class="form-select" name="party" id="party">
                <option value="" selected>Seleccionar partido</option>
                <%
                    // watch if president exist.
                    // 1 -> hide button to add president
                    // != 1 -> show button
                    int president = 0;

                    // show every value for political party
                    try {
                        Dba db = new Dba();
                        db.Conectar();
                        db.query.execute("SELECT NOMBRE FROM Partido");
                        ResultSet rs = db.query.getResultSet();
                        while (rs.next()) {
                %>
                <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%>
                </option>
                <%
                        }
                        db.desconectar();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </select>
        </form>
    </h4>

    <%
        if (request.getParameter("party") != null) {%>
    <div class="container-fluid mx-auto">
        <button class="btn btn-sm btn-primary"
                data-toggle="modal" data-target="#exampleModalCenter1"
        >Agregar presidente
        </button>

        <button class="btn btn-sm btn-primary"
                data-toggle="modal" data-target="#exampleModalCenter2"
        >Agregar alcalde
        </button>

        <button class="btn btn-sm btn-primary"
                data-toggle="modal" data-target="#exampleModalCenter3"
        >Agregar diputado
        </button>
    </div>


    <div class="mt-3">
        <h5>Presidente</h5>
        <%

            if (request.getParameter("party") != null) {

                // fetch personal and user data
                try {
                    Dba db = new Dba();
                    db.Conectar();
                    president = db.query.executeUpdate(
                            String.format("SELECT P.NOMBRE1, P.NOMBRE2, P.APELLIDO1, P.APELLIDO2, P.ID, C.FOTO FROM PERSONAS P "
                                    + "INNER JOIN CANDIDATO C ON P.ID = C.ID_PERSONA "
                                    + "WHERE C.ID_CARGO='PRESIDENTE' AND C.ID_PARTIDO='%S'", request.getParameter("party").toUpperCase()));
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
        %>
        <div class="d-flex flex-column fs-6 fw-normal">
            <div>
                <img src="<%="./media/"+rs.getString(6)%>" class="img-thumbnail">
            </div>
            <div class="p-2 fs-6">
                Nombre: <%=rs.getString(1) != null ? rs.getString(1) : ""%> <%=rs.getString(2) != null ? rs.getString(2) : ""%>
                <%=rs.getString(3) != null ? rs.getString(3) : ""%> <%=rs.getString(4) != null ? rs.getString(4) : ""%>
            </div>
            <div class="p-2">ID: <%=rs.getString(5)%>
            </div>

        </div>
        <%
                    }
                    db.desconectar();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

    <form action="optCandidato.jsp" method="POST" onsubmit="return confirm('Confirmar accion')">
        <h4>Alcaldes</h4>
        <jsp:include page="formList.jsp">
            <jsp:param name="query" value='<%=String.format(
			queryCandidatos, "ALCALDE", request.getParameter("party").toUpperCase())%>'/>
            <jsp:param name="radio" value="hidden"/>
        </jsp:include>

        <input class="btn btn-sm btn-danger" type="submit" name="submit" value="Remover Alcalde"/>
    </form>

    <form action="optCandidato.jsp" method="POST" onsubmit="return confirm('Confirmar accion')">
        <h4>Diputados</h4>
        <jsp:include page="formList.jsp">
            <jsp:param name="query" value='<%=String.format(
			queryCandidatos, "DIPUTADO", request.getParameter("party").toUpperCase())%>'/>
            <jsp:param name="radio" value="hidden"/>
        </jsp:include>

        <input class="btn btn-sm btn-danger" type="submit" name="submit" value="Remover Diputados"/>
    </form>

    <!--modal to add candidates-->
    <%if (president == 0) {%>
    <div class="modal bd-example-modal-lg" id="exampleModalCenter1"
         tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <jsp:include page="modalMiembro.jsp">
            <jsp:param name="queryPersonas" value="<%=queryPersonas%>"/>
            <jsp:param name="cargo" value="PRESIDENTE"/>
            <jsp:param name="party" value='<%=request.getParameter("party")%>'/>
        </jsp:include>
    </div>
    <%}%>
    <div class="modal bd-example-modal-lg" id="exampleModalCenter2"
         tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <jsp:include page="modalMiembro.jsp">
            <jsp:param name="queryPersonas" value="<%=queryPersonas%>"/>
            <jsp:param name="cargo" value="ALCALDE"/>
            <jsp:param name="party" value='<%=request.getParameter("party")%>'/>
        </jsp:include>
    </div>
    <div class="modal bd-example-modal-lg" id="exampleModalCenter3"
         tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <jsp:include page="modalMiembro.jsp">
            <jsp:param name="queryPersonas" value="<%=queryPersonas%>"/>
            <jsp:param name="cargo" value="DIPUTADO"/>
            <jsp:param name="party" value='<%=request.getParameter("party")%>'/>
        </jsp:include>
    </div>
    <%
        }
    %>
</main>

<jsp:include page="tableFooter.jsp"/>
</body>
</html>
