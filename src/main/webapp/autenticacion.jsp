<%--
    Document   : autenticacion
    Created on : Feb 8, 2021, 11:12:48 AM
    Author     : miguelaht
--%>

<%@page import="java.sql.*" %>
<%@ page import="database.Dba" %>
<%@ page import="util.CryptoHash" %>

<%
    try {
        Dba db = new Dba();
        db.Conectar();
        String pass = CryptoHash.getHash(request.getParameter("password"));
        boolean ok = db.query.execute(String.format("SELECT U.ROL FROM USUARIO U "
                        + "INNER JOIN PERSONAS P ON P.ID = U.ID_PERSONA "
                        + "WHERE U.ID_PERSONA='%s' AND U.PASSWORD='%s'",
                // AND u.estado_p=1 AND u.estado_u=1
                request.getParameter("id"), pass));

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

