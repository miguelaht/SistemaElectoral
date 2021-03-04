<%--
    Document   : formPapeleta
    Created on : Feb 19, 2021, 6:08:26 PM
    Author     : miguelaht
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%
    if (session.getAttribute("s_id") == null) {
        response.sendRedirect("index.jsp");
    }
    if (!session.getAttribute("s_rol").equals("AS")) {
        response.sendRedirect("home.jsp");
    }
%>
<%
    String queryPersonas = "SELECT P.ID, P.NOMBRE1, P.NOMBRE2, P.APELLIDO1, P.APELLIDO2 FROM PERSONAS P"
            + " INNER JOIN CANDIDATO C ON C.ID_PERSONA = P.ID"
            + " WHERE C.ID_CARGO = '%s' AND"
            + " P.ID NOT IN (SELECT ID_CANDIDATO FROM PAPELETAELECTORAL)";
%>

<%
    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();

            String candidatos[] = request.getParameterValues("id_p");

            if (candidatos.length != 0) {
                db.Conectar();

                // get id of TipoPapeleta
                int idTipo = 0;
                db.query.execute(String.format("SELECT id FROM TipoPapeleta WHERE tipo = '%s'", request.getParameter("tipo").toUpperCase()));
                ResultSet rs = db.query.getResultSet();

                if (rs.next()) {
                    System.out.print("getInt" + rs.getInt(1));
                    idTipo = rs.getInt(1);
                }

                System.out.print("idtipo" + idTipo);
                if (idTipo != 0) {
                    // create papeleta
                    String query = String.format("INSERT INTO Papeleta (tipo) VALUES (%s)", idTipo);
                    String generatedColumns[] = {"ID"};
                    db.query.executeUpdate(query, generatedColumns);
                    rs = db.query.getGeneratedKeys();

                    long idPapeleta = 0;
                    if (rs.next()) {
                        idPapeleta = rs.getInt(1);
                    }

                    // insert candidates into PapeletaElectoral with previously created papeleta
                    for (String id : candidatos) {
                        db.query.execute(String.format(
                                "INSERT INTO PapeletaElectoral (id_candidato, id_papeleta) VALUES "
                                        + "('%s', %s)",
                                id, idPapeleta));
                    }
                }
            }
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("listPapeletas.jsp");
    }
%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp"/>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <%if (request.getParameter("tipo") != null && (request.getParameter("tipo").equals("PRESIDENTE") || request.getParameter("tipo").equals("ALCALDE") || request.getParameter("tipo").equals("DIPUTADO"))) {%>
    <h4>Nueva Papeleta <%=request.getParameter("tipo")%>
    </h4>
    <form action="formPapeleta.jsp" method="POST">
        <jsp:include page='formList.jsp'>
            <jsp:param name="query"
                       value='<%=String.format(queryPersonas, request.getParameter("tipo").toUpperCase())%>'/>
            <jsp:param name="radio" value="hidden"/>
        </jsp:include>
        <div class="pt-3">
            <input hidden type="text" name="tipo"
                   value='<%=request.getParameter("tipo").toUpperCase()%>'/>
            <button type="submit" name="submit" class="btn btn-primary ">Crear Papeleta</button>
        </div>
    </form>

    <%} else {%>

    <h4>Nueva Papeleta</h4>
    <form method="GET" action="formPapeleta.jsp">
        <select onchange="this.form.submit()" class="form-select" name="tipo" id="tipo">
            <option value="" selected>Seleccionar tipo de papeleta</option>
            <%
                try {
                    Dba db = new Dba();
                    db.Conectar();
                    db.query.execute("SELECT TIPO FROM TipoPapeleta");
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

    <%}%>

</main>

<jsp:include page="tableFooter.jsp"/>
</body>
</html>
