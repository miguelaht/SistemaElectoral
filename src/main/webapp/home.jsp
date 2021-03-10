<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %><%--
    Document   : home
    Created on : Feb 8, 2021, 4:33:38 PM
    Author     : miguelaht
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    if (session.getAttribute("s_id") == null) {
        response.sendRedirect("index.jsp");
    }
%>
<%
    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();
            db.Conectar();
            System.out.println("AQUI");
            db.query.execute(String.format("UPDATE MESAS SET ESTADO=%s WHERE ID = %s",
                    request.getParameter("status"), session.getAttribute("s_mesa")));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<html>
<head>
    <jsp:include page="head.jsp"/>
    <jsp:include page="headerMap.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Lugar de votacion</h4>
    <% if (session.getAttribute("s_rol").equals("MM")) {%>
    <div>
        <span>Estado de mesa</span>
        <form action="home.jsp" method="POST">
            <%
                try {
                    Dba db = new Dba();
                    db.Conectar();
                    db.query.execute("SELECT ESTADO FROM MESAS WHERE ID=" + session.getAttribute("s_mesa"));
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
                        if (rs.getString(1).equals("1")) {%>
            <input hidden value="0" name="status"/>
            <button type="submit" name="submit" class="btn btn-sm btn-outline-primary">Abierta
            </button>
            <%} else {%>
            <input hidden value="1" name="status"/>
            <button type="submit" name="submit" class="btn btn-sm btn-outline-danger">Cerrada
            </button>
            <%
                        }
                    }
                    db.desconectar();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </form>
    </div>
    <% } %>
    <div class="col-md-6 w-100 rounded border mt-2 mb-2">
        <div style="height: 500px" id="map"></div>
    </div>
</main>
<script type="text/javascript" src='js/map.js'></script>
<script type="text/javascript">
    <%
    try{
        Dba db = new Dba();
        db.Conectar();
        db.query.execute("SELECT M.ID, M.ESTADO, U.DEPARTAMENTO, U.MUNICIPIO, U.LATITUD, U.LONGITUD, U.DESCRIPCION FROM MESAS M " +
         "INNER JOIN UBICACION U on M.UBICACION = U.ID WHERE M.ID="+session.getAttribute("s_mesa"));
        ResultSet rs = db.query.getResultSet();
        while (rs.next()){
        %>
    addInfoBubble(map, "<%=rs.getString(1)%>", <%=rs.getString(2)%>, "<%=rs.getString(3)%>",
        "<%=rs.getString(4)%>", "<%=rs.getString(5)%>", "<%=rs.getString(6)%>", "<%=rs.getString(7)%>", null);
    <%
        }
        db.desconectar();
}catch(Exception e){
e.printStackTrace();
}%>
</script>
</body>
</html>
