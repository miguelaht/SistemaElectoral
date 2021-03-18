<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %><%--
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
    if (request.getParameter("submit") != null || request.getParameter("cancel") != null) {
        try {
            Dba db = new Dba();
            db.Conectar();

            if (request.getParameter("submit") != null) {
                String[] votos = request.getParameterValues("voto_id");
                if (votos != null && votos.length > 0) {
                    int value =1;
                    for (String voto : votos) {
                        db.query.execute(String.format("INSERT INTO VOTO (ID_CANDIDATO, ID_VOTANTE, ESTADO) VALUES ('%s', '%s', '%s')", voto, session.getAttribute("s_id"), value));
                    }
                }
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(function () {
            const limit = 10;//Limit of selections
            let state = 0;//Selection counter

            //I detect when a common element changes
            $(".form-check-input").change(function () {
                //Check if the item is checked
                if ($(this).is(':checked')) {
                    if (state < limit) {
                        state = parseInt(state) + 1;
                    } else {
                        $(this).prop('checked', false); // Unchecks it
                        alert("Limite de " + limit + " marcas alcanzado");
                    }
                } else {
                    state = parseInt(state) - 1;
                }
            })
        })
    </script>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Votar <%=request.getParameter("tipo")%>
    </h4>
    <div class="container" align="center">
        <%
            try {
                Dba db = new Dba();
                db.Conectar();
                db.query.execute("SELECT ESTADO FROM MESAS WHERE ID=" + session.getAttribute("s_mesa"));
                ResultSet rs = db.query.getResultSet();
                if (rs.next()) {
                    if (rs.getString(1).equals("1")) {
                        db.query.execute(String.format("SELECT ESTADO_U FROM USUARIO WHERE ID_PERSONA='%s'",
                                session.getAttribute("s_id")));
                        rs = db.query.getResultSet();
                        if (rs.next()) {
                            if (rs.getString(1).equals("1")) {


        %>
        <form action="votar.jsp" method="POST">
            <input hidden name="tipo" value="<%=request.getParameter("tipo")%>">
            <jsp:include page="papeleta.jsp">
                <jsp:param name="tipo" value='<%=request.getParameter("tipo")%>'/>
            </jsp:include>
        </form>
        <%
                            } else {
                                out.print("<h4>Solicite la activacion de usuario en la mesa de votacion</h4>");
                            }
                        }
                    } else {
                        out.print("<h4>Espere la apertura de la mesa</h4>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</main>
</body>
</html>
