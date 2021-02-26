<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%
    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();
            String candidato[] = request.getParameterValues("id_p");
            db.Conectar();
            if (candidato != null && candidato.length != 0) {
                for (String id : candidato) {
                    db.query.execute(String.format("INSERT INTO Candidato "
                                    + "(id_persona, id_cargo, id_partido) VALUES ('%s', '%s', '%s')",
                            id, request.getParameter("cargo").toUpperCase(), request.getParameter("party").toUpperCase()));
                }
            }

            db.desconectar();
            response.sendRedirect("listPartidos.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
%>

