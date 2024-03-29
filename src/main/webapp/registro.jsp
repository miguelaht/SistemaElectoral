<%--
    Document   : registro
    Created on : Feb 9, 2021, 12:10:46 PM
    Author     : miguelaht
--%>

<%--
    Store personal data and user creation.
    Password generation if email was given.
--%>

<%@page import="database.Dba" %>
<%@page import="util.Mail" %>
<%@page import="util.CryptoHash" %>
<!--Registro de personas-->

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    if (session.getAttribute("s_id") != null) {
        response.sendRedirect("home.jsp");
    }
%>
<%
    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();
            db.Conectar();
            int exists = db.query.executeUpdate(String.format("SELECT ID FROM PERSONAS WHERE ID='%s'", request.getParameter("id")));

            if (exists == 0) {
                // save personal data
                db.query.execute(String.format("INSERT INTO PERSONAS (ID, NOMBRE1, NOMBRE2, APELLIDO1, "
                                               + "APELLIDO2, EMAIL, TELEFONO) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s')",
                        request.getParameter("id"), request.getParameter("name1"),
                        request.getParameter("name2"), request.getParameter("sur1"),
                        request.getParameter("sur2"), request.getParameter("email"), request.getParameter("cel")));

                Mail msg = new Mail();
                String code = msg.sendMail(request.getParameter("email"), application.getRealPath("WEB-INF/") + "main.py");

                // hash password
                String hash = code != null ? CryptoHash.getHash(code) : null;

                // save user and password if email was given
                db.query.execute(String.format("INSERT INTO USUARIO (ID_PERSONA, ESTADO_U, PASSWORD, ESTADO_P, ROL ) VALUES ('%s', %s, '%s', '%s', '%s')",
                        request.getParameter("id"), 0, hash, 1, "EL"));

                db.desconectar();
                if (code == null) {
                    out.print("<script>alert('Usuario registrado. Solicite clave de acceso en mesa')</script>");
                } else {
                    out.print("<script>alert('Usuario registrado. La clave de acceso a sido envida por email')</script>");
                }
            } else {
                out.print("<script>alert('Datos personales ya han sido registrados. Contacte al administrador')</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("index.jsp");
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
          crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
            crossorigin="anonymous"></script>
    <script src="./public/bootstrap.min.css"></script>
    <title>Registro</title>
</head>
<body>
<div class="container-fluid pt-3">
    <div class="container pt-3" align="center">
        <h3>Registro</h3>

        <div class="container-fluid w-75 border rounded shadow p-5 bg-light">
            <form action="registro.jsp" method="POST" class="row g-1">

                <jsp:include page="formPersonas.jsp"/>
                <div class="col-md-6 pt-3">
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
