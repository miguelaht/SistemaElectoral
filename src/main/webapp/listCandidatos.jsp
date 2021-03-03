<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 2/3/21
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    String query =
            "SELECT PA.ID, PR.ID, PR.NOMBRE1 || ' ' || PR.NOMBRE2 || ' ' || PR.APELLIDO1 || ' ' || PR.APELLIDO2, CA.FOTO " +
                    "FROM PAPELETAELECTORAL PE INNER JOIN CANDIDATO CA ON CA.ID_PERSONA = PE.ID_CANDIDATO " +
                    "INNER JOIN PERSONAS PR ON PR.ID = PE.ID_CANDIDATO " +
                    "INNER JOIN PAPELETA PA ON PA.ID = PE.ID_PAPELETA " +
                    "WHERE PA.ID = %s";
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
    <div>
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
                    <th>Fotografia</th>
                </tr>
                </thead>
                <tbody>
                <%
                    try {
                        Dba db = new Dba();
                        db.Conectar();
                        db.query.execute(String.format(query, request.getParameter("id")));
                        try (ResultSet rs = db.query.getResultSet()) {
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
                    <td><a class="nav-link" href="./media/<%=rs.getString(4)%>">Ver</a></td>
                </tr>
                <%
                            }
                        }
                        db.desconectar();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
                </tbody>
            </table>
            <button type="submit" value="submit" class="btn btn-danger"
                    name="submit">Remover
            </button>
        </form>
    </div>
</main>
<jsp:include page="tableFooter.jsp"/>
</body>
</html>