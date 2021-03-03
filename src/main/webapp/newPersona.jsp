<%--
    Document   : newPersona
    Created on : Feb 24, 2021, 2:24:07 PM
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
    if (!session.getAttribute("s_rol").equals("AS")) {
        response.sendRedirect("home.jsp");
    }
%>

<%
    if (request.getParameter("submit") != null) {
        try {
            Dba db = new Dba();
            db.Conectar();

            db.query.execute(
                    String.format(
                            "INSERT INTO PERSONAS (ID, NOMBRE1, NOMBRE2, APELLIDO1, APELLIDO2, EMAIL, TELEFONO) "
                                    + "VALUES ('%s', '%s','%s', '%s','%s', '%s','%s')",
                            request.getParameter("id"), request.getParameter("name1"), request.getParameter("name2"), request.getParameter("sur1"),
                            request.getParameter("sur2"), request.getParameter("email"), request.getParameter("cel")
                    )
            );

            db.query.execute(
                    String.format(
                            "INSERT INTO USUARIO (ID_PERSONA, ESTADO_U, PASSWORD, ESTADO_P, ROL) "
                                    + "VALUES ('%s', 0, NULL, 0, '%s')", request.getParameter("id"), request.getParameter("rol")
                    )
            );
            db.desconectar();

        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("listPersonas.jsp");
    }

%>
<html>

<head>
    <jsp:include page="head.jsp"/>

</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Nuevo Registro</h4>
    <form action="newPersona.jsp" method="POST" class="row g-1">
        <jsp:include page="formPersonas.jsp"/>
        <div class="col-md-6 pt-3">
            <label for="rol" class="form-label">Rol</label>
            <input list="roles" class="form-control" name="rol" id="rol" autocomplete="off">
            <datalist id="roles">
                <%
                    try {
                        Dba db = new Dba();
                        db.Conectar();
                        db.query.execute("SELECT ROL, DESCRIPCION FROM ROLES");
                        ResultSet rs = db.query.getResultSet();
                        while (rs.next()) {
                %>
                <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%>
                </option>
                <%
                        }
                        db.desconectar();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </datalist>

        </div>
        <div class="pt-5 d-grid gap-2 col-6 mx-auto">
            <input type="submit" class="btn btn-primary" class="form-control" name="submit" value="Registrar"
                   id="submit">
        </div>
    </form>
</main>
</body>
</html>
