<%@ page import="database.Dba" %><%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 3/3/21
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%
    if (request.getParameter("rm") != null || request.getParameter("add") != null) {
        try {
            Dba db = new Dba();
            db.Conectar();
            String[] mesas = request.getParameterValues("id_m");
            String query = null;
            if (request.getParameter("rm") != null) {
                query = "DELETE FROM MESAPAPELETA WHERE ID_MESA=%s AND ID_PAPELETA=%s";
            } else if (request.getParameter("add") != null) {
                query = "INSERT INTO MESAPAPELETA (ID_MESA, ID_PAPELETA) VALUES(%s, %s)";
            }

            if (mesas != null && mesas.length > 0) {
                for (String id : mesas) {
                    db.query.execute(String.format(query, id, request.getParameter("id_p")));
                }
            }

            db.desconectar();
            response.sendRedirect("listPapeletas.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        out.print("<script>location.href = document.referrer;</script>");

    }
%>
