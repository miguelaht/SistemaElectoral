<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 7/3/21
  Time: 14:57
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
    <script>
        function setValue(n, d) {
            document.getElementById("nombre").value = n != null ? n : "";
            document.getElementById("descripcion").textContent = d != null ? d : "";
        }

        function addHidden(theForm, key, value) {
            // Create a hidden input element, and append it to the form:
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = key; // 'the key/name of the attribute/field that is sent to the server
            input.value = value;
            theForm.appendChild(input);
        }
    </script>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="container-fluid">
        <form class="row g-1" action="addPartido.jsp" method="POST"
              onsubmit='addHidden(this, "id", <%=request.getParameter("id")%>)'
              enctype="MULTIPART/FORM-DATA">
            <jsp:include page="formPartido.jsp"/>
        </form>
    </div>
</main>
<%
    try {
        Dba db = new Dba();
        db.Conectar();
        db.query.execute("SELECT NOMBRE, DESCRIPCION FROM PARTIDO WHERE ID=" +
                         request.getParameter("id"));
        ResultSet rs = db.query.getResultSet();
        while (rs.next()) {
%>
<script>
    setValue('<%=rs.getString(1)%>', '<%=rs.getString(2)%>');
</script>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
