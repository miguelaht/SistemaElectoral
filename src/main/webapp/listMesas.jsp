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
    List<List<String>> items = new ArrayList<>();
%>
<%
    if (request.getParameter("del") != null) {
        try {
            Dba db = new Dba();
            db.Conectar();
            db.query.execute(String.format("DELETE FROM MESAS WHERE ID=%s",
                    request.getParameter("del")));
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("listMesas.jsp");
    }
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
                                 "INNER JOIN PERSONAS P ON MP.ID_PERSONA = P.ID " +
                                 "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
                                 "INNER JOIN UBICACION U ON M.UBICACION = U.ID " +
                                 "WHERE U.ROL='EL' " +
                                 "GROUP BY M.ID, M.ESTADO, U.DEPARTAMENTO, U.MUNICIPIO, U.LATITUD, U.LONGITUD, U.DESCRIPCION, U.ID");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
                    List<String> list1 = new ArrayList<>();
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
                   class="btn btn-sm btn-outline-primary">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-people" viewBox="0 0 16 16">
                        <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1h8zm-7.978-1A.261.261 0 0 1 7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002a.274.274 0 0 1-.014.002H7.022zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0zM6.936 9.28a5.88 5.88 0 0 0-1.23-.247A7.35 7.35 0 0 0 5 9c-4 0-5 3-5 4 0 .667.333 1 1 1h4.216A2.238 2.238 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816zM4.92 10A5.493 5.493 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275zM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0zm3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4z"></path>
                    </svg>
                </a>
                <a class="btn btn-sm btn-outline-secondary"
                   href="votantesPDF.jsp?ID=<%=rs.getString(1)%>"
                   title="Reporte de votantes">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                         fill="currentColor" class="bi bi-table" viewBox="0 0 16 16">
                        <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z"></path>
                    </svg>
                </a>
                <a class="btn btn-sm btn-outline-info" href="updMesa.jsp?M=<%=rs.getString(1)%>&U=<%=rs.getString(9)%>&d=<%=rs.getString(3)%>&m=<%=rs.getString(4)%>&lat=<%=rs.getString(5)%>&lng=<%=rs.getString(6)%>&D=<%=rs.getString(7)%>&e=<%=rs.getString(2)%>"
                   title="Actualizar informacion">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                         fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456l-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"></path>
                        <path fill-rule="evenodd"
                              d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"></path>
                    </svg>
                </a>
                <a title="Eliminar" type="submit" class="btn btn-sm btn-outline-danger"
                   href="listMesas.jsp?del=<%=rs.getString(1)%>">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                         fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"></path>
                        <path fill-rule="evenodd"
                              d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"></path>
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
        for(List<String> item: items){%>
    addInfoBubble(map, "<%=item.get(0)%>", "<%=item.get(1)%>",
        "<%=item.get(2)%>", "<%=item.get(3)%>", "<%=item.get(4)%>",
        "<%=item.get(5)%>", "<%=item.get(6)%>", "<%=item.get(7)%>");
    <%
        }
}catch(Exception e){
e.printStackTrace();
}%>
</script>
<form id="form_del" action="listMesas.jsp" method="POST">

</form>
</body>
</html>
