<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 3/3/21
  Time: 12:04
  To change this template use File | Settings | File Templates.
--%>
<table
        id="table"
        data-detail-view="true"
        data-toggle="table"
        data-pagination="true"
        data-search="true"
        data-key-events="true"
        data-resizable="true"
        data-cookie="true"
        data-cookie-id-table="saveId"
        data-click-to-select="true"
        data-show-button-icons="true"
        data-toolbar="#toolbar">
    <thead>
    <tr>
        <th>
            Seleccionar
        </th>
        <th>Partido Politico</th>
        <th> Candidato</th>
        <th>Nombre de Candidato</th>
        <th>Fotografia</th>
    </tr>
    </thead>
    <tbody>
    <%
        try {
            Dba db = new Dba();
            db.Conectar();
            db.query.execute(request.getParameter("query"));
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