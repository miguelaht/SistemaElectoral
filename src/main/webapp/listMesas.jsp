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
    <table
            id="table"
            data-show-pagination-switch="true"
            data-show-fullscreen="true"
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
                db.query.execute("SELECT M.ID, M.ESTADO, U.DEPARTAMENTO, U.MUNICIPIO, U.LATITUD, U.LONGITUD, U.DESCRIPCION, COUNT(MP.ID_MESA), U.ID " +
                                 "FROM MESAS M " +
                                 "LEFT JOIN MESAPERSONA MP ON M.ID = MP.ID_MESA " +
                                 "INNER JOIN UBICACION U ON M.UBICACION = U.ID " +
                                 "GROUP BY M.ID, M.ESTADO, U.DEPARTAMENTO, U.MUNICIPIO, U.LATITUD, U.LONGITUD, U.DESCRIPCION, U.ID");
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
            <td><%=rs.getString(2).equals("1") ? "Abierta" : "Cerrada"%>
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
                <a href="mesa.jsp?mID=<%=rs.getString(1)%>" title="Miembros de Mesa"
                   class="btn btn-sm btn-link">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                         fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16">
                        <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                        <path fill-rule="evenodd"
                              d="M5.216 14A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216z"/>
                        <path d="M4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5z"/>
                    </svg>
                </a>
                <a href="votantesPDF.jsp?ID=<%=rs.getString(1)%>" title="Reporte de votantes"
                   class="btn btn-sm
                   btn-link">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                         fill="currentColor" class="bi bi-table" viewBox="0 0 16 16">
                        <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z"/>
                    </svg>
                </a>
                <a href="updMesa.jsp?M=<%=rs.getString(1)%>&U=<%=rs.getString(9)%>&d=<%=rs.getString(3)%>&m=<%=rs.getString(4)%>&lat=<%=rs.getString(5)%>&lng=<%=rs.getString(6)%>&D=<%=rs.getString(7)%>&e=<%=rs.getString(2)%>"
                   title="Actualizar informacion">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                         fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456l-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                        <path fill-rule="evenodd"
                              d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                    </svg>
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
    <div class="col-md-6 w-100 rounded border mt-2 mb-2">
        <div style="height: 500px" id="map"></div>
    </div>
</main>

<jsp:include page="tableFooter.jsp"/>
<script type="text/javascript" src='js/map.js'></script>
<script type="text/javascript">
    <%
    try{
        for(List item: items){%>
    addInfoBubble(map, "<%=item.get(0)%>", "<%=item.get(1)%>",
        "<%=item.get(2)%>", "<%=item.get(3)%>", "<%=item.get(4)%>",
        "<%=item.get(5)%>", "<%=item.get(6)%>", "<%=item.get(7)%>");
    <%
        }
}catch(Exception e){
e.printStackTrace();
}%>
</script>
</body>
</html>
