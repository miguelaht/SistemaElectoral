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
        String query = String.format("SELECT U.ROL, M.ID_MESA FROM USUARIO U\n" +
                                     "INNER JOIN PERSONAS P ON P.ID = U.ID_PERSONA\n" +
                                     "LEFT JOIN MESAPERSONA M on P.ID = M.ID_PERSONA\n" +
                                     "WHERE U.ID_PERSONA='%s' AND U.PASSWORD='%s'\n",
                request.getParameter("id"), pass);
        boolean ok = db.query.execute(query);

        ResultSet rs = db.query.getResultSet();

        while (rs.next()) {
            if (rs.getString(1) != null) {
                session.setAttribute("s_id", request.getParameter("id"));
                session.setAttribute("s_rol", rs.getString(1));
                session.setAttribute("s_mesa", rs.getString(2));
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

