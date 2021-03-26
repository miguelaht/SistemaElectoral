<%--
    Document   : userPass
    Created on : Feb 19, 2021, 6:39:58 PM
    Author     : miguelaht
--%>

<%@page import="util.Mail" %>
<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%@ page import="util.CryptoHash" %>
<%
    // recover user password
    Dba db = new Dba();
    try {
        db.Conectar();
        db.query.execute(String.format("SELECT EMAIL FROM PERSONAS WHERE ID='%s'", request.getParameter("id")));
        ResultSet rs = db.query.getResultSet();
        String mail = null;

        while (rs.next()) {
            mail = rs.getString(1);
            break;
        }

        Mail msg = new Mail();
        String code = msg.sendMail(mail, application.getRealPath("WEB-INF/") + "main.py");
        String hash = code != null ? CryptoHash.getHash(code) : null;

        String query = "UPDATE USUARIO SET PASSWORD= ?, ESTADO_P=1 WHERE ID_PERSONA=?";

        Connection con = db.getConexion();
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, hash);
            ps.setString(2, request.getParameter("id"));
            ps.execute();
        }

        db.desconectar();
        if (mail == null) {
            out.print("<script>alert('Clave de acceso es: " + code +
                      "'); location.href = document.referrer;</script>");
        } else {
            out.print("<script>alert('Success'); location.href = document.referrer;</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
