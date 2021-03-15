<%@ page import="java.sql.ResultSet" %>
<%@ page import="database.Dba" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %><%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 15/3/21
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%

    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();

            String query = String.format("INSERT INTO UBICACION (DEPARTAMENTO, MUNICIPIO, LATITUD, LONGITUD, DESCRIPCION) VALUES ('%s','%s',%s,%s,'%s')"
                    , request.getParameter("depto"), request.getParameter("muni"), request.getParameter("lat"), "-" + request.getParameter("lng"), request.getParameter("desc"));


            String generatedColumns[] = {"ID"};

            db.Conectar();

            db.query.executeUpdate(query, generatedColumns);
            ResultSet rs = db.query.getGeneratedKeys();
            long idUbicacion = 0;
            if (rs.next()) {
                idUbicacion = rs.getInt(1);
            }


            query = String.format("INSERT INTO MESAS (ESTADO, UBICACION) VALUES ('%s', %s)",
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
                    db.query.execute(String.format("INSERT INTO MESAPERSONA (ID_MESA, ID_PERSONA) VALUES (%s, '%s')", idMesa, id));
                }
            }
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("listMesas.jsp");
    } else if (request.getParameter("update") != null) {
        try {
            Dba db = new Dba();

            String queryUbicacion =
                    String.format("UPDATE UBICACION SET DEPARTAMENTO='%s', MUNICIPIO='%s', LATITUD=%s, LONGITUD=%s, DESCRIPCION='%s' WHERE ID=%s",
                            request.getParameter("depto"), request.getParameter("muni"),
                            request.getParameter("lat"), "-" + request.getParameter("lng"),
                            request.getParameter("desc"), request.getParameter("U"));

            String queryMesa = String.format("UPDATE MESAS SET ESTADO = '%s' WHERE ID=%s",
                    request.getParameter("estado"), request.getParameter("M"));

            db.Conectar();

            // update ubicacion
            db.query.execute(queryUbicacion);

            // update mesa
            db.query.execute(queryMesa);

            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("listMesas.jsp");
    }
%>
