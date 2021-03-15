<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 14/3/21
  Time: 17:37
  To change this template use File | Settings | File Templates.
--%>
<%@page import="com.lowagie.text.pdf.PdfWriter" %>
<%@page import="com.lowagie.text.*" %>
<%@page import="java.io.IOException" %>
<%@page import="java.util.Date" %>
<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.lowagie.text.pdf.PdfPTable" %>

<%
    try {
        Dba db = new Dba();
        db.Conectar();
        db.query.execute("SELECT ESTADO FROM MESAS WHERE ID=" + session.getAttribute("s_mesa"));
        ResultSet rs = db.query.getResultSet();
        if (rs.next()) {
            if (rs.getString(1).equals("0")) {

                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition",
                        "attachment; filename=\"" + request.getParameter("tipo") + new Date().toString() + ".pdf\"");

                Font titleFont = FontFactory.getFont("Helvetica Regular", 18);
                Font subTitleFont = FontFactory.getFont("Helvetica Regular", 14);
                Font bodyFont = FontFactory.getFont("Helvetica Light", 12);

                String query =
                        "SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, PA.NOMBRE, COUNT(V.ID) " +
                        "FROM PERSONAS P " +
                        "INNER JOIN CANDIDATO C ON P.ID = C.ID_PERSONA " +
                        "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
                        "INNER JOIN VOTO V ON C.ID_PERSONA = V.ID_CANDIDATO " +
                        "INNER JOIN PARTIDO PA ON PA.ID = C.ID_PARTIDO " +
                        "INNER JOIN PAPELETAELECTORAL PE ON PE.ID_CANDIDATO = P.ID " +
                        "INNER JOIN MESAPAPELETA MP ON MP.ID_PAPELETA = PE.ID_PAPELETA " +
                        "WHERE U.ROL='CA' AND C.ID_CARGO='%S' AND V.ESTADO=1 AND MP.ID_MESA=%s " +
                        "GROUP BY P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, PA.NOMBRE " +
                        "ORDER BY COUNT(V.ID) DESC";

                Document documentoPDF = new Document();
                PdfWriter.getInstance(documentoPDF, response.getOutputStream());
                documentoPDF.open();

                documentoPDF.addCreationDate();

                //agregar parrafos
                documentoPDF.add(new Paragraph("Resultados: " + request.getParameter("tipo"), titleFont));
                documentoPDF.add(new Paragraph(new Date().toString(), subTitleFont));
                documentoPDF.add(new Paragraph("\n"));

                try {
                    db.query.execute(String.format(query, request.getParameter("tipo"),
                            session.getAttribute("s_mesa")));
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }

                // make table

                rs = db.query.getResultSet();
                while (rs.next()) {
                    // candidate data
                    documentoPDF.add(new Paragraph(rs.getString(2), subTitleFont));
                    documentoPDF.add(new Paragraph("Partido: " + rs.getString(3), bodyFont));
                    documentoPDF.add(new Paragraph("Votos: " + rs.getString(4), bodyFont));
                    documentoPDF.add(new Paragraph("\n"));

                }
                documentoPDF.close();
            }
        }
        db.desconectar();
    } catch (DocumentException de) {
        throw new IOException(de.getMessage());
    }
    response.sendRedirect("home.jsp");
%>

