<%--
    Document   : newMesa
    Created on : Feb 24, 2021, 4:22:14 PM
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

<%
    String queryMiembros = "SELECT P.ID, P.NOMBRE1, P.NOMBRE2, P.APELLIDO1, P.APELLIDO2 "
                           + "FROM PERSONAS P "
                           + "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA "
                           + "WHERE ID NOT IN (SELECT ID_PERSONA FROM MESAPERSONA) AND U.ROL = 'MM'";
%>
<html>
<head>
    <jsp:include page="head.jsp"/>
    <jsp:include page="headerMap.jsp"/>

</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Nueva Mesa</h4>
    <div class="container-fluid pb-3">
        <form class="row g-1" action="addMesa.jsp" method="POST">
            <jsp:include page="formMesa.jsp"/>
            <div class="col-md-12 pt-3">
                <label class="form-label">Miembros de Mesa</label>
                <jsp:include page='formList.jsp'>
                    <jsp:param name="radio" value="hidden"/>
                    <jsp:param name="query" value='<%=queryMiembros%>'/>
                </jsp:include>
            </div>
            <div class="pt-3 d-grid gap-2 col-6 mx-auto">
                <input type="submit" class="btn btn-primary" class="form-control" name="submit"
                       value="Crear"
                       id="submit">
            </div>
        </form>
    </div>
</main>
<jsp:include page="tableFooter.jsp"/>
<script type="text/javascript" src="js/ubicacion.js"></script>
<script type="text/javascript" src='js/map.js'></script>
<script>
    setUpClickListener(map);
</script>
</body>
</html>
