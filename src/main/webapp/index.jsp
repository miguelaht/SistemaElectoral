<%--
    Document   : index
    Created on : Feb 8, 2021, 11:13:00 AM
    Author     : miguelaht
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    if (session.getAttribute("s_id") != null) {
        response.sendRedirect("home.jsp");
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
            crossorigin="anonymous"></script>
    <script src="css/bootstrap.min.css"></script>
</head>
<body>
<div>
    <div class="container pt-3" align="center">
        <div class="d-flex justify-content-sm-center mb-5">
            <h3>Sistema Electoral</h3>
        </div>
        <div class="login w-50 p-5 m-5 border rounded">
            <form action="autenticacion.jsp" method="POST">
                <div class="mb-4">
                    <label>Numero de identidad</label>
                    <input type="text" name="id" class="form-control" value=""/>
                </div>
                <div class="mb-4">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" value=""/>
                </div>
                <input class="btn btn-primary" type="submit" value="Login" name="bt_login"/>
            </form>
            <div class="pt-3">
                <a href="registro.jsp">o registrarse</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
