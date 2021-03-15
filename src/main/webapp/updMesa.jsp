<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 15/3/21
  Time: 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="head.jsp"/>
    <jsp:include page="headerMap.jsp"/>
    <script>
        function setValue(id, value) {
            document.getElementById(id).value = value ? value : "";
        }
    </script>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Actualizar Mesa</h4>
    <div class="container-fluid pb-3">
        <form class="row g-1" action="addMesa.jsp" method="POST">
            <input name="M" hidden value='<%=request.getParameter("M")%>'>
            <input name="U" hidden value='<%=request.getParameter("U")%>'>
            <jsp:include page="formMesa.jsp"/>
            <div class="pt-3 d-grid gap-2 col-6 mx-auto">
                <input type="submit" class="btn btn-primary" class="form-control" name="update"
                       value="Actualizar"
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
    setValue("depto", '<%=request.getParameter("d")%>');
    setValue("muni", '<%=request.getParameter("m")%>');
    setValue("desc", '<%=request.getParameter("D")%>');
    setValue("estado", '<%=request.getParameter("e")%>');
    setValue("lat", <%=request.getParameter("lat")%>);
    setValue("lng", <%=request.getParameter("lng")%>);
    addInfoBubble(map, null, null, null, null, <%=request.getParameter("lat")%>, <%=request.getParameter("lng")%>, null, null);
</script>
</body>
</html>
