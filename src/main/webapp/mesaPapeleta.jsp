<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 3/3/21
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %>
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
        <th>Seleccionar</th>
        <th>ID Mesa</th>
        <th>Departamento</th>
        <th>Municipio</th>
    </tr>
    </thead>
    <tbody>
    <%

        try {
            Dba db = new Dba();
            db.Conectar();
            db.query.execute(request.getParameter("query"));
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
    %>
    <tr>
        <td>
            <input value="<%=rs.getString(1)%>"
                   class="form-check-input"
                   type="checkbox" name="id_m"/>
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