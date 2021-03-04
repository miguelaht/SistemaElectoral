<%@ page import="database.Dba" %><%--
    Document   : votar
    Created on : Feb 24, 2021, 7:39:18 PM
    Author     : miguelaht
--%>
<%
    if (request.getParameter("tipo").equals("PRESIDENTE") &&
        session.getAttribute("s_v1").equals("1")) {
        response.sendRedirect("home.jsp");
    }
    if (request.getParameter("tipo").equals("ALCALDE") &&
        session.getAttribute("s_v2").equals("1")) {
        response.sendRedirect("home.jsp");
    }
    if (request.getParameter("tipo").equals("DIPUTADO") &&
        session.getAttribute("s_v3").equals("1")) {
        response.sendRedirect("home.jsp");
    }
%>
<%
    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();

            String[] votos = request.getParameterValues("voto_id");
            if (votos != null && votos.length > 0) {
                db.Conectar();
                for (String voto : votos) {
                    db.query.execute(String.format("INSERT INTO VOTO (ID_CANDIDATO, ID_VOTANTE, ESTADO) VALUES ('%s', '%s', '1')", voto, session.getAttribute("s_id")));
                }
                if (request.getParameter("tipo").equals("PRESIDENTE")) {
                    db.query.execute(String.format("UPDATE PERSONAS SET V1=1 WHERE ID='%s'",
                            session.getAttribute("s_id")));
                    session.setAttribute("s_v1", "1");
                }
                if (request.getParameter("tipo").equals("ALCALDE")) {
                    db.query.execute(String.format("UPDATE PERSONAS SET V2=1 WHERE ID='%s'",
                            session.getAttribute("s_id")));
                    session.setAttribute("s_v2", "1");
                }
                if (request.getParameter("tipo").equals("DIPUTADO")) {
                    db.query.execute(String.format("UPDATE PERSONAS SET V3=1 WHERE ID='%s'",
                            session.getAttribute("s_id")));
                    session.setAttribute("s_v3", "1");
                }
                db.desconectar();
            }
            response.sendRedirect("home.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="head.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Papeleta de <%=request.getParameter("tipo")%>
    </h4>
    <div class="container" align="center">
        <form action="votar.jsp" method="POST">
            <input hidden name="tipo" value="<%=request.getParameter("tipo")%>">
            <jsp:include page="papeleta.jsp">
                <jsp:param name="tipo" value='<%=request.getParameter("tipo")%>'/>
            </jsp:include>
        </form>
    </div>
</main>
</body>
</html>
