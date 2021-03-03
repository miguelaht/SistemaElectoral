<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 2/3/21
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %>
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
<html>
<head>
    <jsp:include page="head.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Papeletas</h4>
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
            <th>ID Papeleta</th>
            <th>Tipo</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                Dba db = new Dba();
                db.Conectar();
                db.query.execute("SELECT P.ID, T.TIPO FROM PAPELETA P INNER JOIN TIPOPAPELETA T on T.ID = P.TIPO");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
        %>
        <tr>
            <td><%=rs.getString(1)%>
            </td>
            <td><%=rs.getString(2)%>
            </td>
            <td><a class="nav-link"
                   href="papeletas.jsp?id=<%=rs.getString(1)%>&tipo=<%=rs.getString(2)%>&opt=c">Candidatos
            </a><a class="nav-link"
                   href="papeletas.jsp?id=<%=rs.getString(1)%>&tipo=<%=rs.getString(2)%>&opt=m">Mesas
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

</main>
<jsp:include page="tableFooter.jsp"/>
</body>
</html>
