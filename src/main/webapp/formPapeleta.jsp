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
    String queryPersonas =
            "SELECT P.ID, P.NOMBRE1 ||''|| P.NOMBRE2||''|| P.APELLIDO1||''||  P.APELLIDO2, PA.NOMBRE FROM PERSONAS P"
            + " INNER JOIN CANDIDATO C ON C.ID_PERSONA = P.ID" +
            " INNER JOIN PARTIDO PA ON PA.ID = C.ID_PARTIDO"
            + " WHERE C.ID_CARGO = '%s' AND"
            + " P.ID NOT IN (SELECT ID_CANDIDATO FROM PAPELETAELECTORAL)";
%>

<%
    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();

            String[] candidatos = request.getParameterValues("id_p");

            if (candidatos.length != 0) {
                db.Conectar();

                // create papeleta
                String query = String.format("INSERT INTO Papeleta (tipo) VALUES (%s)",
                        request.getParameter("tipo"));

                String[] generatedColumns = {"ID"};
                db.query.executeUpdate(query, generatedColumns);
                ResultSet rs = db.query.getGeneratedKeys();

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
    <%
        String tipo = null;
        try {
            Dba db = new Dba();
            db.Conectar();
            db.query.execute(String.format("SELECT TIPO FROM TIPOPAPELETA WHERE ID=%s",
                    request.getParameter("tipo")));
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
                tipo = rs.getString(1);
                break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <%
        if (tipo != null &&
            (tipo.equals("PRESIDENTE") ||
             tipo.equals("ALCALDE") || tipo.equals("DIPUTADO"))) {
    %>
    <h4>Nueva Papeleta <%=tipo%>
    </h4>
    <form action="formPapeleta.jsp" method="POST">
        <table
                id="table"
                data-toggle="table"
                data-pagination="true"
                data-search="true"
                data-key-events="true"
                data-resizable="true"
                data-cookie="true"
                data-cookie-id-table="saveId"
                data-click-to-select="true"
                data-toolbar="#toolbar">
            <thead>
            <tr>
                <th>
                    Seleccionar
                </th>
                <th>ID</th>
                <th>Nombre</th>
                <th>Partido</th>
            </tr>
            </thead>
            <tbody>
            <%

                try {
                    Dba db = new Dba();
                    db.Conectar();

                    db.query.execute(String.format(queryPersonas, tipo));
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
            %>
            <tr>
                <td>
                    <label>
                        <input <%=request.getParameter("check")%> value="<%=rs.getString(1)%>"
                                                                  class="form-check-input"
                                                                  type="checkbox" name="id_p"/>
                    </label>
                </td>
                <td><%=rs.getString(1)%>
                </td>
                <td><%=rs.getString(2)%>
                </td>
                <td><%=rs.getString(3)%>
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
        <div class="pt-3">
            <input hidden type="text" name="tipo"
                   value='<%=request.getParameter("tipo")%>'/>
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
                    db.query.execute("SELECT ID, TIPO FROM TipoPapeleta");
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
            %>
            <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%>
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
