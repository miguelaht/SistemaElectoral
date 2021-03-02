<%--
    Document   : listMesas
    Created on : Feb 15, 2021, 4:30:17 PM
    Author     : miguelaht
--%>


<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%
    if (session.getAttribute("s_id") == null) {
        response.sendRedirect("index.jsp");
    }
    if (!session.getAttribute("s_rol").equals("AS")) {
        response.sendRedirect("home.jsp");
    }
%>
<%
    String mID = null;
    List<List> items = new ArrayList<List>();
%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <jsp:include page="head.jsp"/>
    <jsp:include page="headerMap.jsp"/>
</head>

<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Mesas</h4>
    <div class="pt-3">
        <a href="newMesa.jsp" class="nav-link">Nueva Mesa</a>
    </div>

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
            <th>ID Mesa</th>
            <th>Estado</th>
            <th>Departamento</th>
            <th>Municipio</th>
            <th>Latitud</th>
            <th>Longitud</th>
            <th>Descripcion</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%

            try {
                Dba db = new Dba();
                db.Conectar();
                db.query.execute("SELECT m.id, m.estado, u.departamento, u.municipio, u.latitud, u.longitud, u.descripcion, COUNT(mp.id_mesa) "
                        + "FROM Mesas m "
                        + "LEFT JOIN MesaPersona mp ON m.id = mp.id_mesa "
                        + "INNER JOIN Ubicacion u ON m.ubicacion = u.id "
                        + "GROUP BY m.id, m.estado, u.departamento, u.municipio, u.latitud, u.longitud, u.descripcion");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
                    List list1 = new ArrayList();
                    list1.add(rs.getString(1));
                    list1.add(rs.getString(2));
                    list1.add(rs.getString(3));
                    list1.add(rs.getString(4));
                    list1.add(rs.getString(5));
                    list1.add(rs.getString(6));
                    list1.add(rs.getString(7));
                    list1.add(rs.getString(8));
                    items.add(list1);
        %>
        <tr>
            <td><%=rs.getString(1)%>
            </td>
            <td><%=rs.getString(2) == "1" ? "Abierta" : "Cerrada"%>
            </td>
            <td><%=rs.getString(3)%>
            </td>
            <td><%=rs.getString(4)%>
            </td>
            <td><%=rs.getString(5)%>
            </td>
            <td><%=rs.getString(6)%>
            </td>
            <td><%=rs.getString(7)%>
            </td>
            <td>
                <a href="mesa.jsp?mID=<%=rs.getString(1)%>" class="nav-link">Miembros de Mesa</a>
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
    <div class="col-md-6 w-100 rounded border mt-2 mb-2">
        <div style="height: 500px" id="map"></div>
    </div>
</main>

<jsp:include page="tableFooter.jsp"/>
<script src='js/map.js'></script>
<script type="text/javascript">
    <% try{
        for(int i = 0 ; i < items.size(); i++){%>
    addInfoBubble(map, "<%=items.get(i).get(0)%>", "<%=items.get(i).get(1)%>",
        "<%=items.get(i).get(2)%>", "<%=items.get(i).get(3)%>", "<%=items.get(i).get(4)%>",
        "<%=items.get(i).get(5)%>", "<%=items.get(i).get(6)%>", "<%=items.get(i).get(7)%>");
    <%}
}catch(Exception e){
e.printStackTrace();
}%>
</script>
</body>
</html>
