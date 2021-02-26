<%--
    Document   : logout
    Created on : Feb 8, 2021, 5:32:19 PM
    Author     : miguelaht
--%>

<%
    session.invalidate();
    response.sendRedirect("index.jsp");
%>
