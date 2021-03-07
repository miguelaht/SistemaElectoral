<%--
    Document   : userStatus
    Created on : Feb 19, 2021, 3:57:35 PM
    Author     : miguelaht
--%>
<%@page import="database.Dba" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%
    // update user status so it can login
    try {
        Dba db = new Dba();
        String[] ids = request.getParameterValues("id");
        if (ids != null && ids.length > 0) {
            db.Conectar();
            Connection con = db.getConexion();
            String query = "UPDATE USUARIO SET ESTADO_U=1 WHERE ID_PERSONA=?";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                for (String id : ids) {
                    ps.setString(1, id);
                    ps.execute();
                }
            }
        }
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("home.jsp");
%>
