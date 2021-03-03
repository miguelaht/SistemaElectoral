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
    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();
            String[] candidatos = request.getParameterValues("id_p");
            db.Conectar();
            Connection con = db.getConexion();
            try (PreparedStatement ps =
                         con.prepareStatement("DELETE FROM PAPELETAELECTORAL WHERE ID_CANDIDATO=?")){
                if (candidatos != null && candidatos.length > 0) {
                    for (String id : candidatos) {
                        ps.setString(1, id);
                        ps.execute();
                    }
                }
            }
            db.desconectar();
            response.sendRedirect("papeletas.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("home.jsp");
    }
%>