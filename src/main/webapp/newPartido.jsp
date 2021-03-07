<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 6/3/21
  Time: 18:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
        <form class="row g-1" action="addPartido.jsp" method="POST" enctype="MULTIPART/FORM-DATA">
            <jsp:include page="formPartido.jsp"/>
        </form>
    </div>
</main>
</body>
</html>
