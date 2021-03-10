<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 10/3/21
  Time: 14:59
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
    if (session.getAttribute("s_rol").equals("MM")) {
        try {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition",
                    "attachment; filename=\"Votantes" + new Date().toString() + ".pdf\"");

            //crear y abrir documento tipo pdf
            Document documentoPDF = new Document();
            PdfWriter.getInstance(documentoPDF, response.getOutputStream());
            documentoPDF.open();

            documentoPDF.addCreationDate();
            documentoPDF.addTitle("DAW-PDF");

            //agregar parrafos
            documentoPDF.add(new Paragraph("Elecciones 2077"));
            documentoPDF.add(new Paragraph("Mesa " + session.getAttribute("s_mesa")));
            Dba db = new Dba();
            db.Conectar();
            try {
//            db.query.execute("SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, P.V1, p.V2, p.V3, U2.DEPARTAMENTO, U2.MUNICIPIO " +
//                             "FROM PERSONAS P " +
//                             "INNER JOIN MESAPERSONA M on P.ID = M.ID_PERSONA " +
//                             "INNER JOIN USUARIO U on P.ID = U.ID_PERSONA " +
//                             "INNER JOIN MESAS M2 on M.ID_MESA = M2.ID " +
//                             "INNER JOIN UBICACION U2 on M2.UBICACION = U2.ID  " +
//                             "WHERE U.ROL='EL' AND M.ID_MESA=" + session.getAttribute("s_mesa"));
                db.query.execute("SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, P.V1, p.V2, p.V3 " +
                                 "FROM PERSONAS P " +
                                 "INNER JOIN USUARIO U on P.ID = U.ID_PERSONA ");
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }


            String depto = null, muni = null;
            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);

            table.addCell("ID");
            table.addCell("Nombre");
            table.addCell("Voto Presidente");
            table.addCell("Voto Alcalde");
            table.addCell("Voto Diputado");

            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
                table.addCell(rs.getString(1));
                table.addCell(rs.getString(2));
                table.addCell(rs.getString(3));
                table.addCell(rs.getString(4));
                table.addCell(rs.getString(5));
            }
            db.desconectar();


            documentoPDF.add(new Paragraph(muni + "/" + depto));
            documentoPDF.add(new Paragraph(new Date().toString()));
            documentoPDF.add(new Paragraph("\n"));
            documentoPDF.add(table);

            documentoPDF.close();
        } catch (DocumentException de) {
            throw new IOException(de.getMessage());
        }
    }
%>


