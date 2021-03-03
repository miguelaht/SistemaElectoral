<%@ page import="database.Dba" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 2/3/21
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>

<%
    if (request.getParameter("rm") != null || request.getParameter("add") != null) {
        try {
            Dba db = new Dba();
            String[] candidatos = request.getParameterValues("id_p");
            db.Conectar();
            Connection con = db.getConexion();
            String query = null;

            if (request.getParameter("rm") != null) {
                query = "DELETE FROM PAPELETAELECTORAL WHERE ID_CANDIDATO=?";
            } else if (request.getParameter("add") != null) {
                query =
                        "INSERT INTO PAPELETAELECTORAL (ID_CANDIDATO, ID_PAPELETA) VALUES(?," +
                        request.getParameter("id_pl") + ")";
            }

            if (query != null) {
                try (PreparedStatement ps =
                             con.prepareStatement(query)) {
                    if (candidatos != null && candidatos.length > 0) {
                        for (String id : candidatos) {
                            ps.setString(1, id);
                            ps.execute();
                        }
                    }
                }
            }

            db.desconectar();
            response.sendRedirect("listPapeletas.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("home.jsp");
    }
%>