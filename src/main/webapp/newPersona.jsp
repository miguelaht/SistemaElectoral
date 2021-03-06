<%--
    Document   : newPersona
    Created on : Feb 24, 2021, 2:24:07 PM
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
    <script>
        function showForm(id) {
            const x = document.getElementById(id);
            const opt = document.getElementById("rol").value;
            console.log(opt);
            if (opt === "CA") {
                x.style.display = "block";
            } else {
                x.style.display = "none";
            }
        }
    </script>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Nuevo Registro</h4>
    <form action="addPersona.jsp" method="POST" class="row g-1" enctype="MULTIPART/FORM-DATA">
        <jsp:include page="formPersonas.jsp"/>
    </form>
</main>
</body>
</html>
