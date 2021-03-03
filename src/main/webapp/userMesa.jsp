<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 27/2/21
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%
    Dba db = new Dba();
    try {
        db.Conectar();
        Connection con = db.getConexion();
        try (PreparedStatement ps = con.prepareStatement("""
                BEGIN
                   INSERT INTO MESAPERSONA (ID_PERSONA, ID_MESA)
                      VALUES(?, ?);
                EXCEPTION
                   WHEN DUP_VAL_ON_INDEX THEN
                      UPDATE MESAPERSONA
                      SET    ID_MESA = ?
                      WHERE  ID_PERSONA = ?;
                END;
                """)) {
            ps.setString(1, request.getParameter("id"));
            ps.setString(3, request.getParameter("id"));
            ps.setString(2, request.getParameter("mesa"));
            ps.setString(4, request.getParameter("mesa"));

            ps.execute();
        }
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("listPersonas.jsp");
%>
