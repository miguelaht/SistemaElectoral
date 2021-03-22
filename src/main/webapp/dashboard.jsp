<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 15/3/21
  Time: 17:22
  To change this template use File | Settings | File Templates.
--%>
<%
    //    if (session.getAttribute("s_id") == null || !session.getAttribute("s_rol").equals("MA")) {
//        response.sendRedirect("home.jsp");
//    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/themes/dark-unica.js"></script>
    <script src="https://code.highcharts.com/modules/data.js"></script>
    <script src="https://code.highcharts.com/modules/drilldown.js"></script>
<%--    <link rel="stylesheet" href="./css/dashboard.css">--%>
<%--    <jsp:include page="head.jsp"/>--%>
</head>
<body>
<%--<jsp:include page="navbar.jsp"/>--%>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Dashboard</h4>
    <figure class="highcharts-figure">
        <div id="res-depto-pres"></div>
    </figure>
    <figure class="highcharts-figure">
        <div id="res-mesa-pres"></div>
    </figure>
</main>
</body>
<jsp:include page="deptoBarChart.jsp">
    <jsp:param name="cargo" value="PRESIDENTE"/>
    <jsp:param name="container" value="res-depto-pres"/>
    <jsp:param name="title" value="Resultados Presidenciales por Departamento"/>
</jsp:include>
<jsp:include page="mesaPieChart.jsp">
    <jsp:param name="cargo" value="PRESIDENTE"/>
    <jsp:param name="container" value="res-mesa-pres"/>
    <jsp:param name="title" value="Resultados Presidenciales por Mesa"/>
</jsp:include>
</html>
