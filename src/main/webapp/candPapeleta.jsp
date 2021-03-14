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
        <td>
            <button type="button" class="btn btn-sm btn-link"
                    onclick="showPicture('./media/<%=rs.getString(4)%>')">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                     fill="currentColor"
                     class="bi bi-image" viewBox="0 0 16 16">
                    <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
                    <path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
                </svg>
            </button>
        </td>
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
