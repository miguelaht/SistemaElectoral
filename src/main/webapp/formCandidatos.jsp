<%--
    Document   : formCandidatos
    Created on : Feb 10, 2021, 10:37:33 AM
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
<html>
<head>

    <jsp:include page="head.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Nuevo Candidato</h4>
    <div class="container-fluid">
        <form class="row g-1" action="newCandidato.jsp" method="POST" enctype="MULTIPART/FORM-DATA">
            <div class="col-md-6">
                <label for="p_id" class="form-label">Numero de Identidad</label>
                <input list="candidatos" class="form-control" name="p_id" autoComplete="off">
                <datalist id="candidatos">
                    <%
                        // show every posible value of political party

                        try {
                            Dba db = new Dba();
                            db.Conectar();
                            db.query.execute("SELECT p.id, p.nombre1 || ' ' || p.nombre2 || ' ' || p.apellido1|| ' ' ||  p.apellido2 FROM Personas p "
                                    + "INNER JOIN Usuario u ON p.id = u.id_persona WHERE u.rol = 'EL' AND p.id NOT IN (SELECT id_persona FROM Candidato)");
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
            <div class="col-md-6">
                <label for="party" class="form-label">Partido Politico</label>
                <select class="form-select" name="party" id="party">
                    <%
                        // show every posible value of political party

                        try {
                            Dba db = new Dba();
                            db.Conectar();
                            db.query.execute("SELECT nombre FROM PARTIDO");
                            ResultSet rs = db.query.getResultSet();
                            while (rs.next()) {
                    %>
                    <option value=<%=rs.getString(1)%>><%=rs.getString(1)%>
                    </option>
                    <%
                            }
                            db.desconectar();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
            <div class="col-md-6">
                <label for="cargo" class="form-label">Cargo Electoral</label>
                <select class="form-select" name="cargo" id="cargo">
                    <%
                        // show every posible value of position in political party
                        try {
                            Dba db = new Dba();
                            db.Conectar();
                            db.query.execute("SELECT nombre FROM CARGO");
                            ResultSet rs = db.query.getResultSet();
                            while (rs.next()) {
                    %>
                    <option value=<%=rs.getString(1)%>><%=rs.getString(1)%>
                    </option>
                    <%
                            }
                            db.desconectar();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
            <div class="col-md-6">
                <label for="foto" class="form-label">Fotografia</label>
                <input type="file" class="form-control" id="foto" name="foto">
            </div>
            <div class="pt-3 d-grid gap-2 col-6 mx-auto">
                <button type="submit" name="submit" class="btn btn-primary ">Enviar</button>
            </div>
        </form>
    </div>
</main>
</body>
</html>
