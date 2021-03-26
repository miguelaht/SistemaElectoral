<%@ page import="util.xmlPort" %>
<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 26/3/21
  Time: 12:18
  To change this template use File | Settings | File Templates.
--%>
<%
    if (session.getAttribute("s_rol").equals("AS")) {
        boolean resp = false;
        if (request.getParameter("exp") != null) {
            try {
                xmlPort xml = new xmlPort();

                resp = xml.exportXML();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (request.getParameter("imp") != null) {
            try {
                xmlPort xml = new xmlPort();

                resp = xml.importXML();


            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (resp) {
            out.print("<script>alert('Exito'); location.href = document.referrer;</script>");
        } else {
            out.print("<script>alert('Error'); location.href = document.referrer;</script>");
        }
    }
%>
