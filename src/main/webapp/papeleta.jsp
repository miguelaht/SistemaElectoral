<%--
    Document   : papeleta
    Created on : Feb 8, 2021, 5:58:33 PM
    Author     : miguelaht
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    if (session.getAttribute("s_id") == null) {
        response.sendRedirect("index.jsp");
    }
%>

<%
    String query = "SELECT PE.ID_PAPELETA, PE.ID_CANDIDATO,\n" +
                   "PR.NOMBRE1 || ' ' || PR.NOMBRE2 || ' ' || PR.APELLIDO1 || ' ' || PR.APELLIDO2, CA.FOTO, PA.NOMBRE \n" +
                   "FROM PAPELETAELECTORAL PE\n" +
                   "INNER JOIN CANDIDATO CA on CA.ID_PERSONA = PE.ID_CANDIDATO\n" +
                   "INNER JOIN PERSONAS PR ON CA.ID_PERSONA = PR.ID\n" +
                   "INNER JOIN MESAPAPELETA M on PE.ID_PAPELETA = M.ID_PAPELETA\n" +
                   "INNER JOIN PAPELETA P on P.ID = PE.ID_PAPELETA\n" +
                   "INNER JOIN TIPOPAPELETA T on T.ID = P.TIPO\n" +
                   "INNER JOIN PARTIDO PA ON CA.ID_PARTIDO = PA.ID\n" +
                   "WHERE T.TIPO='%s' AND M.ID_MESA=%s\n" +
                   "ORDER BY PA.NOMBRE DESC";
%>

<div class="row justify-content-between">
    <%
        Boolean isEmpty = true;
        try {
            Dba db = new Dba();
            db.Conectar();
            db.query.execute(String.format(query, request.getParameter("tipo"),
                    session.getAttribute("s_mesa")));
            ResultSet rs = db.query.getResultSet();

            while (rs.next()) {
                isEmpty = false;
    %>

    <div class=" col-6 col-sm-3 p-3 border border-secondary border-1 rounded">
        <label><%=rs.getString(5)%></label>
        <label for="<%=rs.getString(2)%>">
            <img src="./media/<%=rs.getString(4)%>" class="img-thumbnail">
        </label>

        <div class="px-auto"><%=rs.getString(3)%>
        </div>
        <div class="row checkbox-row">
            <div class="col-xs-2 col-xs-offset-4">
                <div class="checkbox-inline">
                    <% if (request.getParameter("tipo").equals("DIPUTADO")) {%>
                    <span><input type="checkbox" value="<%=rs.getString(2)%>"
                                 id="<%=rs.getString(2)%>"
                                 class="form-check-input"
                                 name="voto_id"/></span>
                    <%} else {%>
                    <span><input type="radio" value="<%=rs.getString(2)%>"
                                 id="<%=rs.getString(2)%>" class="form-check-input"
                                 name="voto_id"/></span>
                    <%}%>
                </div>
            </div>
        </div>
    </div>

    <%
            }
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>
<% if (!isEmpty) {
%>
<div class="pt-3">
    <button type="submit" name="submit" class="btn btn-sm btn-primary ">Votar
    </button>
    <button type="submit" name="cancel" class="btn btn-sm btn-danger ">Anular
    </button>
</div>
<%
    } else {
        out.print("<h4>No hay papeleta disponible</h4>");
    }
%>


