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
                <label class="form-label">Numero de Identidad</label>
                <input list="candidatos" class="form-control" name="p_id" autoComplete="off">
                <datalist id="candidatos">
                    <%
                        try {
                            Dba db = new Dba();
                            db.Conectar();
                            db.query.execute("SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' || P.APELLIDO1|| ' ' ||  P.APELLIDO2 FROM PERSONAS P "
                                             + "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA WHERE U.ROL = 'CA' AND P.ID NOT IN (SELECT ID_PERSONA FROM CANDIDATO)");
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

                        try {
                            Dba db = new Dba();
                            db.Conectar();
                            db.query.execute("SELECT NOMBRE FROM PARTIDO");
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
                        try {
                            Dba db = new Dba();
                            db.Conectar();
                            db.query.execute("SELECT NOMBRE FROM CARGO");
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
