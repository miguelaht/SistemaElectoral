<%--
    Document   : autenticacion
    Created on : Feb 8, 2021, 11:12:48 AM
    Author     : miguelaht
--%>

<%@page import="java.sql.*" %>
<%@ page import="database.Dba" %>

<%
    try {
        Dba db = new Dba();
        db.Conectar();
        boolean ok = db.query.execute(String.format("SELECT u.rol FROM Usuario u\n"
                        + "INNER JOIN Personas p ON p.id = u.id_persona\n"
                        + "WHERE u.id_persona='%s' AND u.password='%s'",
                // AND u.estado_p=1 AND u.estado_u=1
                request.getParameter("id"), request.getParameter("password")));

        ResultSet rs = db.query.getResultSet();

        while (rs.next()) {
            if (rs.getString(1) != null) {
                session.setAttribute("s_id", request.getParameter("id"));
                session.setAttribute("s_rol", rs.getString(1));
            }
        }

        db.desconectar();

        if (ok) {
            response.sendRedirect("home.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

%>

