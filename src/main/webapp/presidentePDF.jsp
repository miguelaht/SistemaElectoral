<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 14/3/21
  Time: 10:58
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
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=\"Presidente" + new Date().toString() + ".pdf\"");

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
                "WHERE U.ROL='CA' AND C.ID_CARGO='PRESIDENTE' AND V.ESTADO=1 " +
                "GROUP BY P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, PA.NOMBRE " +
                "ORDER BY COUNT(V.ID) DESC";

        String votos = "SELECT DISTINCT COUNT(V.ID), U.DEPARTAMENTO \n" +
                       "FROM MESAPAPELETA MP " +
                       "INNER JOIN MESAS M ON M.ID = MP.ID_MESA " +
                       "INNER JOIN MESAPERSONA M2 on M.ID = M2.ID_MESA " +
                       "INNER JOIN UBICACION U on U.ID = M.UBICACION " +
                       "INNER JOIN VOTO V ON V.ID_VOTANTE = M2.ID_PERSONA " +
                       "WHERE V.ESTADO=1 AND V.ID_CANDIDATO='%s' AND V.ID_CANDIDATO IN (SELECT ID_CANDIDATO FROM PAPELETAELECTORAL\n" +
                       "      WHERE ID_PAPELETA=MP.ID_PAPELETA) " +
                       "GROUP BY U.DEPARTAMENTO " +
                       "ORDER BY U.DEPARTAMENTO DESC";

        Document documentoPDF = new Document();
        PdfWriter.getInstance(documentoPDF, response.getOutputStream());
        documentoPDF.open();

        documentoPDF.addCreationDate();

        //agregar parrafos
        documentoPDF.add(new Paragraph("Resultados: Presidentes", titleFont));
        documentoPDF.add(new Paragraph(new Date().toString(), subTitleFont));
        documentoPDF.add(new Paragraph("\n"));

        Dba db = new Dba();
        db.Conectar();


        try {
            db.query.execute(query);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        // make table

        ResultSet rs = db.query.getResultSet();
        while (rs.next()) {
            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(100);

            table.addCell(new Paragraph("Departamento", bodyFont));
            table.addCell(new Paragraph("Votos", bodyFont));

            Dba v = new Dba();
            v.Conectar();
            try {
                // fetch table content
                v.query.execute(String.format(votos, rs.getString(1)));
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }

            ResultSet resultados = v.query.getResultSet();
            while (resultados.next()) {
                // populate table
                table.addCell(new Paragraph(resultados.getString(2), bodyFont));
                table.addCell(new Paragraph(resultados.getString(1), bodyFont));
            }
            v.desconectar();

            // candidate data
            documentoPDF.add(new Paragraph(rs.getString(2), subTitleFont));
            documentoPDF.add(new Paragraph("Partido: " + rs.getString(3), bodyFont));
            documentoPDF.add(new Paragraph("Votos: " + rs.getString(4), bodyFont));
            documentoPDF.add(new Paragraph("\n"));

            if (!table.getRows().isEmpty())
                documentoPDF.add(table);

            documentoPDF.add(new Paragraph("\n\n"));
        }

        db.desconectar();


        documentoPDF.close();
    } catch (DocumentException de) {
        throw new IOException(de.getMessage());
    }
%>
