<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 23/3/21
  Time: 09:43
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

<%!

    public PdfPTable makeTable(ResultSet rs) throws SQLException {
        // create table
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);

        table.addCell("ID");
        table.addCell("Partido");
        table.addCell("Nombre");
        table.addCell("Votos");

        // populate table
        while (rs.next()) {
            table.addCell(rs.getString(2));
            table.addCell(rs.getString(4));
            table.addCell(rs.getString(3));
            table.addCell(rs.getString(1));
        }

        return table;
    }

%>

<%
    if (session.getAttribute("s_rol").equals("MA") && request.getParameter("muni") != null ||
        request.getParameter("depto") != null) {
        try {
            // municipio o departamento
            String param = request.getParameter("muni") != null ? request.getParameter("muni") :
                    request.getParameter("depto");

            String[] cargos = {"PRESIDENTE", "ALDALDE", "DIPUTADO"};

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition",
                    "attachment; filename=\"" + param + new Date().toString() + ".pdf\"");

            //crear y abrir documento pdf
            Document documentoPDF = new Document();
            PdfWriter.getInstance(documentoPDF, response.getOutputStream());
            documentoPDF.open();
            documentoPDF.addCreationDate();

            //agregar parrafos
            documentoPDF.add(new Paragraph("Elecciones"));
            documentoPDF.add(new Paragraph("Resultados: " + param));

            Dba db = new Dba();
            db.Conectar();
            String query = null;
            if (request.getParameter("muni") != null) {
                query = "SELECT DISTINCT COUNT(V.ID),\n" +
                        "                P.ID,\n" +
                        "                P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' || P.APELLIDO1 || ' ' || P.APELLIDO2,\n" +
                        "                PA.NOMBRE\n" +
                        "FROM MESAPAPELETA MP\n" +
                        "         INNER JOIN MESAS M ON M.ID = MP.ID_MESA\n" +
                        "         INNER JOIN MESAPERSONA M2 on M.ID = M2.ID_MESA\n" +
                        "         INNER JOIN UBICACION U on U.ID = M.UBICACION\n" +
                        "         INNER JOIN VOTO V ON V.ID_VOTANTE = M2.ID_PERSONA\n" +
                        "         INNER JOIN CANDIDATO C ON V.ID_CANDIDATO = C.ID_PERSONA\n" +
                        "         INNER JOIN PERSONAS P ON C.ID_PERSONA = P.ID\n" +
                        "         INNER JOIN PARTIDO PA ON C.ID_PARTIDO = PA.ID\n" +
                        "WHERE V.ESTADO = 1\n" +
                        "    AND C.ID_CARGO = '%S'\n" +
                        "    AND V.ID_CANDIDATO IN (SELECT ID_CANDIDATO\n" +
                        "                           FROM PAPELETAELECTORAL\n" +
                        "                           WHERE ID_PAPELETA = MP.ID_PAPELETA)\n" +
                        "    AND\n" +
                        "      U.MUNICIPIO = '%s'\n" +
                        "GROUP BY P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' || P.APELLIDO1 || ' ' || P.APELLIDO2, PA.NOMBRE\n" +
                        "ORDER BY COUNT(V.ID) DESC";
            }else if (request.getParameter("depto") != null) {
                query = "SELECT DISTINCT COUNT(V.ID),\n" +
                        "                P.ID,\n" +
                        "                P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' || P.APELLIDO1 || ' ' || P.APELLIDO2,\n" +
                        "                PA.NOMBRE\n" +
                        "FROM MESAPAPELETA MP\n" +
                        "         INNER JOIN MESAS M ON M.ID = MP.ID_MESA\n" +
                        "         INNER JOIN MESAPERSONA M2 on M.ID = M2.ID_MESA\n" +
                        "         INNER JOIN UBICACION U on U.ID = M.UBICACION\n" +
                        "         INNER JOIN VOTO V ON V.ID_VOTANTE = M2.ID_PERSONA\n" +
                        "         INNER JOIN CANDIDATO C ON V.ID_CANDIDATO = C.ID_PERSONA\n" +
                        "         INNER JOIN PERSONAS P ON C.ID_PERSONA = P.ID\n" +
                        "         INNER JOIN PARTIDO PA ON C.ID_PARTIDO = PA.ID\n" +
                        "WHERE V.ESTADO = 1\n" +
                        "    AND C.ID_CARGO = '%S'\n" +
                        "    AND V.ID_CANDIDATO IN (SELECT ID_CANDIDATO\n" +
                        "                           FROM PAPELETAELECTORAL\n" +
                        "                           WHERE ID_PAPELETA = MP.ID_PAPELETA)\n" +
                        "    AND\n" +
                        "      U.DEPARTAMENTO = '%s'\n" +
                        "GROUP BY P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' || P.APELLIDO1 || ' ' || P.APELLIDO2, PA.NOMBRE\n" +
                        "ORDER BY COUNT(V.ID) DESC";
            }


            for (String i : cargos) {
                documentoPDF.add(new Paragraph(i));
                documentoPDF.add(new Paragraph("\n"));

                try {
                    assert query != null;
                    db.query.execute(String.format(query, i, param));
                    ResultSet rs = db.query.getResultSet();

                    //insert table
                    documentoPDF.add(makeTable(rs));
                    documentoPDF.add(new Paragraph("\n"));
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }

            }

            db.desconectar();
            documentoPDF.close();
        } catch (DocumentException de) {
            throw new IOException(de.getMessage());
        }
    }
%>