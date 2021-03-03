<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 2/3/21
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String query = "SELECT pa.id, pr.id, pr.nombre1 || ' ' || pr.nombre2 || ' ' || pr.apellido1 || ' ' || pr.apellido2 " +
            "FROM PapeletaElectoral pe INNER JOIN Candidato ca ON ca.id_persona = pe.id_candidato " +
            "INNER JOIN Personas pr ON pr.id = pe.id_candidato " +
            "INNER JOIN Papeleta pa ON pa.id = pe.id_papeleta " +
            "WHERE pa.id = %s";
%>
<html>
<head>
<jsp:include page="head.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Papeleta de
        <%=request.getParameter("tipo")%> : <%=request.getParameter("id")%>
    </h4>
    <form action="rmCandidato.jsp" method="POST">
        <table
                id="table"
                data-show-pagination-switch="true"
                data-show-fullscreen="true"
                data-detail-view="true"
                data-toggle="table"
                data-pagination="true"
                data-search="true"
                data-show-columns="true"
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
                <th>
                    Seleccionar
                </th>
                <th>ID Papeleta</th>
                <th>ID Candidato</th>
                <th>Nombre de Candidato</th>
            </tr>
            </thead>
            <tbody>
            <%
                try {
                    Dba db = new Dba();
                    db.Conectar();
                    db.query.execute(String.format(query, request.getParameter("id")));
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
            %>
            <tr>
                <td>
                    <input value="<%=rs.getString(2)%>"
                           class="form-check-input"
                           type="checkbox" name="id_p"/>
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
        <button type="submit" value="submit" class="btn btn-danger"
                name="submit">Remover</button>
    </form>
</main>
<jsp:include page="tableFooter.jsp"/>
</body>
</html>