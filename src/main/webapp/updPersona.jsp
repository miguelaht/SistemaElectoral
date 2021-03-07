<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 7/3/21
  Time: 10:05
  To change this template use File | Settings | File Templates.
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
            if (opt === "CA") {
                x.style.display = "block";
            } else {
                x.style.display = "none";
            }
        }

        function setValue(id, mail, cel, n1, n2, a1, a2, rol, party, cargo) {
            try {
                document.getElementById("id").readOnly = true;
                document.getElementById("id").value = id != 'null' ? id : "";

                document.getElementById("email").value = mail != 'null' ? mail : "";

                document.getElementById("cel").value = cel != 'null' ? cel : "";

                document.getElementById("name1").value = n1 != 'null' ? n1 : "";

                document.getElementById("name2").value = n2 != 'null' ? n2 : "";

                document.getElementById("sur1").value = a1 != 'null' ? a1 : "";

                document.getElementById("sur2").value = a2 != 'null' ? a2 : "";

                document.getElementById("rol").value = rol != 'null' ? rol : "";

                document.getElementById("party").value = party != 'null' ? party : "";

                document.getElementById("cargo").value = cargo != 'null' ? cargo : "";

                showForm('candidato');
            } catch (error) {
                console.error(error)
            }
        }
    </script>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h4>Modificar</h4>
    <form action="addPersona.jsp" method="POST" class="row g-1" enctype="MULTIPART/FORM-DATA">
        <jsp:include page="formPersonas.jsp"/>
    </form>
</main>
</body>
<%
    try {
        Dba db = new Dba();
        db.Conectar();

        String query =
                String.format("SELECT P.ID, P.EMAIL, P.TELEFONO, P.NOMBRE1, P.NOMBRE2, P.APELLIDO1, P.APELLIDO2, U.ROL, C.ID_PARTIDO, C.ID_CARGO FROM PERSONAS P " +
                              "LEFT JOIN CANDIDATO C on P.ID = C.ID_PERSONA " +
                              "LEFT JOIN USUARIO U on P.ID = U.ID_PERSONA WHERE P.ID='%s'", request.getParameter("id"));

        db.query.execute(query);
        ResultSet rs = db.query.getResultSet();
        while (rs.next()) {%>
<script>
    setValue('<%=rs.getString(1)%>', '<%=rs.getString(2)%>', '<%=rs.getString(3)%>', '<%=rs.getString(4)%>',
        '<%=rs.getString(5)%>', '<%=rs.getString(6)%>', '<%=rs.getString(7)%>', '<%=rs.getString(8)%>', '<%=rs.getString(9)%>', '<%=rs.getString(10)%>');
</script>
<%
        }
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</html>

