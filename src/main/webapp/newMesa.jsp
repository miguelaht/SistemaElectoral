<%--
    Document   : newMesa
    Created on : Feb 24, 2021, 4:22:14 PM
    Author     : miguelaht
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
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

<%
    String queryMiembros = "SELECT p.id, p.nombre1, p.nombre2, p.apellido1, p.apellido2 "
            + "FROM Personas p "
            + "INNER JOIN Usuario u ON p.id = u.id_persona "
            + "WHERE id NOT IN (SELECT id_persona FROM MesaPersona) AND u.rol = 'MM'";
%>

<%

    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();
            String query = String.format("INSERT INTO Ubicacion (departamento, municipio, latitud, longitud, descripcion) VALUES ('%s','%s',%s,%s,'%s')"
                    , request.getParameter("depto"), request.getParameter("muni"), request.getParameter("lat"), "-" + request.getParameter("lng"), request.getParameter("desc"));


            String generatedColumns[] = {"ID"};

            db.Conectar();

            db.query.executeUpdate(query, generatedColumns);
            ResultSet rs = db.query.getGeneratedKeys();
            long idUbicacion = 0;
            if (rs.next()) {
                idUbicacion = rs.getInt(1);
            }


            query = String.format("INSERT INTO Mesas (estado, ubicacion) VALUES ('%s', %s)",
                    request.getParameter("estado"), idUbicacion);


            String generatedID[] = {"ID"};
            db.query.executeUpdate(query, generatedID);
            rs = db.query.getGeneratedKeys();
            long idMesa = 0;
            if (rs.next()) {
                idMesa = rs.getInt(1);
            }
            String miembros[] = request.getParameterValues("id_p");
            if (miembros != null && miembros.length != 0) {
                for (String id : miembros) {
                    db.query.execute(String.format("INSERT INTO MesaPersona (id_mesa, id_persona) VALUES (%s, '%s')", idMesa, id));
                }
            }
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("listMesas.jsp");
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
    <h4>Nueva Mesa</h4>
    <div class="container-fluid pb-3">
        <form class="row g-1" action="newMesa.jsp" method="POST">
            <jsp:include page="formMesa.jsp">
                <jsp:param name="query" value="<%=queryMiembros%>"/>
            </jsp:include>
            <div class="pt-3 d-grid gap-2 col-6 mx-auto">
                <input type="submit" class="btn btn-primary" class="form-control" name="submit" value="Registrar"
                       id="submit">
            </div>
        </form>
    </div>
</main>
<jsp:include page="tableFooter.jsp"/>
<script type="text/javascript" src="js/ubicacion.js"></script>
<script type="text/javascript" src='js/map.js'></script>
<script>
    setUpClickListener(map);
</script>
</body>
</html>
