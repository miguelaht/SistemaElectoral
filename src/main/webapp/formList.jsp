<%--
    Document   : formList
    Created on : Feb 16, 2021, 8:41:38 AM
    Author     : miguelaht
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<table
        id="table"
        data-show-pagination-switch="true"
        data-show-fullscreen="true"
        data-detail-view="true"
        data-toggle="table"
        data-pagination="true"
        data-search="true"
        data-show-columns="true"
        data-show-pagination-switch="true"
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
        <% if (request.getParameter("check") != null || request.getParameter("radio") != null){%>
        <th>
            Seleccionar
        </th>
        <%}%>
        <th data-field="id">ID</th>
        <th data-field="n1">Primer Nombre</th>
        <th data-field="n2">Segundo Nombre</th>
        <th data-field="a1">Primer Apellido</th>
        <th data-field="a2">Segundo Apellido</th>
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
        <% if (request.getParameter("check") != null || request.getParameter("radio") != null){%>
        <td>
            <input <%=request.getParameter("radio")%> value="<%=rs.getString(1)%>" class="form-check-input"
                                                      type="radio" name="id_p"/>
            <input <%=request.getParameter("check")%> value="<%=rs.getString(1)%>" class="form-check-input"
                                                      type="checkbox" name="id_p"/>
        </td>
        <%}%>
        <td><%=rs.getString(1)%>
        </td>
        <td><%=rs.getString(2)%>
        </td>
        <td><%=rs.getString(3)%>
        </td>
        <td><%=rs.getString(4)%>
        </td>
        <td><%=rs.getString(5)%>
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
