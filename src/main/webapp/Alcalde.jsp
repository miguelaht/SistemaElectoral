<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 22/3/21
  Time: 14:00
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
                document.getElementById("muni").value = name;
        }
    </script>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Resultados Alcaldes</h4>
    <%
        try {
            Dba db = new Dba();
            db.Conectar();
    %>
    <form method="GET" action="Alcalde.jsp">
        <select onchange="this.form.submit()" class="form-select" name="muni" id="muni">
            <optgroup label="Default">
                <option value="" selected>Seleccionar municipio</option>
            </optgroup>
            <%
                db.query.execute("SELECT DISTINCT DEPARTAMENTO FROM UBICACION");
                ResultSet rs = db.query.getResultSet();

                List<String> deptos = new ArrayList<>();
                while (rs.next()) {
                    deptos.add(rs.getString(1));
                }

                for (String dept: deptos) {
            %>
            <optgroup label="<%=dept%>">
                <%
                    db.query.execute("SELECT DISTINCT MUNICIPIO FROM UBICACION WHERE DEPARTAMENTO='"+dept+"'");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                %>
                <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%>
                </option>
                <% }
                %>

            </optgroup>
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
        if (request.getParameter("muni") != null) {%>
    <figure class="highcharts-figure">
        <div id="res-mesa-pres"></div>
    </figure>

    <jsp:include page="mesaPieChart.jsp">
        <jsp:param name="cargo" value="ALCALDE"/>
        <jsp:param name="muni" value='<%=request.getParameter("muni")%>'/>
        <jsp:param name="container" value="res-mesa-pres"/>
        <jsp:param name="title" value="Resultados Alcalde por Mesa"/>
    </jsp:include>
    <%
        } %>


</main>
<script>
    setValue('<%=request.getParameter("muni")%>')
</script>
</body>
</html>
