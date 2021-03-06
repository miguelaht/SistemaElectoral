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
