<%--
    Document   : formPartido
    Created on : Feb 10, 2021, 10:31:55 AM
    Author     : miguelaht
--%>

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
    <div class="container-fluid">
        <form class="row g-1" action="newPartido.jsp" method="POST" enctype="MULTIPART/FORM-DATA">
            <div class="col-md-6">
                <label for="nombre" class="form-label">Nombre de partido</label>
                <input type="text" class="form-control" name="nombre" id="nombre">
            </div>
            <div class="col-md-6">
                <label for="bandera" class="form-label">Bandera del partido</label>
                <input type="file" class="form-control" name="bandera" id="bandera">
            </div>
            <div class="col-md-6">
                <label for="descripcion" class="form-label">Descripcion</label>
                <textarea class="form-control" name="descripcion" id="descripcion">
                        </textarea>
            </div>

            <div class="col-md-12">

            </div>
            <div class="pt-3 d-grid gap-2 col-6 mx-auto">
                <input type="submit" class="btn btn-primary" class="form-control" name="submit" value="Crear"
                       id="submit">
            </div>
        </form>
    </div>
</main>
</body>
</html>
