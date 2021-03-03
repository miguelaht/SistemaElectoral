<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 2/3/21
  Time: 08:39
  To change this template use File | Settings | File Templates.
--%>
<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    if (session.getAttribute("s_id") == null) {
        response.sendRedirect("index.jsp");
    }
    if (!session.getAttribute("s_rol").equals("AS")) {
        response.sendRedirect("home.jsp");
    }
%>
<%
    String queryMiembros = "SELECT P.ID, P.NOMBRE1, P.NOMBRE2, P.APELLIDO1, P.APELLIDO2 "
            + "FROM PERSONAS P "
            + "INNER JOIN MESAPERSONA MP ON MP.ID_PERSONA = P.ID "
            + "INNER JOIN MESAS M ON MP.ID_MESA = M.ID "
            + "WHERE M.ID=%s";
%>
<%
    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();
            String miembros[] = request.getParameterValues("id_p");

            db.Conectar();
            if (miembros != null && miembros.length > 0) {
                for (String id : miembros) {
                    db.query.execute(String.format("DELETE FROM MESAPERSONA WHERE ID_PERSONA = '%s' AND ID_MESA = '%s'"
                            , id, request.getParameter("m_id")));
                }
            }

            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("listMesas.jsp");
    }
%>
<html>
<head>
    <jsp:include page="head.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Miembros de mesa <%=request.getParameter("mID")%>
    </h4>
    <form method="POST" action="mesa.jsp">
        <jsp:include page="formList.jsp">
            <jsp:param name="query" value='<%=String.format(queryMiembros, request.getParameter("mID"))%>'/>
            <jsp:param name="radio" value="hidden"/>
        </jsp:include>
        <div class="pt-3">
            <input hidden id="m_id" name="m_id" value='<%=request.getParameter("mID")%>'/>
            <button type="submit" name="submit" class="btn btn-primary">Remover</button>
        </div>
    </form>
</main>
<jsp:include page="tableFooter.jsp"/>
</body>
</html>
