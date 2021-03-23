<%@ page import="database.Dba" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 23/3/21
  Time: 09:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <jsp:include page="head.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Reportes</h4>
    <%
        try {
            Dba db = new Dba();
            db.Conectar();
            db.query.execute("SELECT DISTINCT DEPARTAMENTO FROM UBICACION");
            List<String> deptos = new ArrayList<>();
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
                deptos.add(rs.getString(1));
            }
            for (String depto : deptos) {
    %>
    <div class="border border-1 my-3 py-3 w-50">
        <div class="row">
            <div class="col-4 mx-3">
                <div data-bs-offset="0"
                     class="scrollspy-example" tabindex="0">
                    <h6 id="<%=depto%>">
                        <a href="pdfReport.jsp?depto=<%=depto%>">
                            <%=depto%>
                        </a>
                    </h6>

                </div>
            </div>
            <div class="col-4">
                <div id="list-example-<%=depto%>" class="list-group">
                    <%
                        db.query.execute("SELECT DISTINCT MUNICIPIO FROM UBICACION WHERE DEPARTAMENTO='" + depto + "'");
                        rs = db.query.getResultSet();
                        while (rs.next()) {%>
                    <a class="list-group-item list-group-item-action"
                       href="pdfReport.jsp?muni=<%=rs.getString(1)%>"><%=rs.getString(1)%>
                    </a>
                    <%
                        }

                    %>
                </div>
            </div>

        </div>
    </div>
    <%
            }
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

</main>
</body>
</html>


