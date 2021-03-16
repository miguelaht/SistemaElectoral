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
    <jsp:include page="head.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Dashboard</h4>
    <figure class="highcharts-figure">
        <div id="depto-barChart"></div>
    </figure>
</main>
</body>
<jsp:include page="deptoBarChart.jsp"/>
</html>
