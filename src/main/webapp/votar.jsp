<%--
    Document   : votar
    Created on : Feb 24, 2021, 7:39:18 PM
    Author     : miguelaht
--%>

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

            <jsp:include page="papeleta.jsp">
                <jsp:param name="tipo" value='<%=request.getParameter("tipo")%>'/>
            </jsp:include>

            <div class="d-grid gap-2 p-3 px-lg-5">
                <button type="submit" name="submit" class="btn btn-primary ">Confirmar</button>
            </div>

        </form>
    </div>
</main>
</body>
</html>
