<%@ page import="java.sql.ResultSet" %>
<%@ page import="database.Dba" %><%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 22/3/21
  Time: 20:05
  To change this template use File | Settings | File Templates.
--%>
<%
    if (session.getAttribute("s_id") == null || !session.getAttribute("s_rol").equals("MA")) {
        response.sendRedirect("home.jsp");
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<jsp:include page="chartHeader.jsp"/>
    <jsp:include page="head.jsp"/>
    <script>
        function setValue(name) {
            if (name != 'null')
                document.getElementById("depto").value = name;
        }
    </script>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Resultados Diputado</h4>
    <%
        try {
            Dba db = new Dba();
            db.Conectar();
    %>
    <form method="GET" action="Diputado.jsp">
        <select onchange="this.form.submit()" class="form-select" name="depto" id="depto">

            <option value="" selected>Seleccionar departamento</option>


            <%
                db.query.execute("SELECT DISTINCT DEPARTAMENTO FROM UBICACION");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
            %>
            <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%>
            </option>
            <% }
            %>
        </select>
    </form>

    <%
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
        }

    %>
    <%
        if (request.getParameter("depto") != null) {%>
    <figure class="highcharts-figure">
        <div id="res-mesa-pres"></div>
    </figure>

    <jsp:include page="mesaPieChart.jsp">
        <jsp:param name="cargo" value="DIPUTADO"/>
        <jsp:param name="depto" value='<%=request.getParameter("depto")%>'/>
        <jsp:param name="container" value="res-mesa-pres"/>
        <jsp:param name="title" value="Resultados Diputado por Mesa"/>
    </jsp:include>
    <%
        } %>


</main>
<script>
    setValue('<%=request.getParameter("depto")%>')
</script>
</body>
</html>
