<%--
    Document   : newPartido
    Created on : Feb 24, 2021, 11:42:09 AM
    Author     : miguelaht
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext" %>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload" %>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem" %>
<%@ page import="org.junit.platform.commons.util.StringUtils" %>
<%
    try {
        ServletFileUpload fu = new ServletFileUpload(new DiskFileItemFactory()); //apache 7

        List items = fu.parseRequest(new ServletRequestContext(request)); //apache 814 en adelante

        // Iteramos por cada elemento del Request
        Iterator i = items.iterator();

        String fileName = "";
        File fichero = null;
        String nombre = null, descripcion = null, id = null;
        while (i.hasNext()) {
            FileItem ff = (FileItem) i.next();
            //verificamos si el elemento es un archivo
            if (!ff.isFormField()) {
                long a = ff.getSize();
                //verificamos si el tamano del archivo es mayor a 0 bites
                if (a > 0) {
                    fileName = ff.getName();
                    fichero = new File(fileName);
                    // escribimos el fichero en la carpeta que corresponde
                    fichero = new File(application.getRealPath("/media"), fichero.getName());
                    ff.write(fichero);
                }
            } else {
                if (ff.getFieldName().compareTo("nombre") == 0) {
                    nombre = ff.getString();
                } else if (ff.getFieldName().compareTo("descripcion") == 0) {
                    descripcion = ff.getString();
                } else if (ff.getFieldName().compareTo("id") == 0) {
                    id = ff.getString();
                }
            }
        }

        Dba db = new Dba();
        db.Conectar();
        Connection con = db.getConexion();
        if (!StringUtils.isNotBlank(id)) {
            try (PreparedStatement ps = con.prepareStatement("BEGIN\n" +
                                                             "   INSERT INTO PARTIDO (NOMBRE, DESCRIPCION, BANDERA)\n" +
                                                             "      VALUES(?, ?, ?);\n" +
                                                             "EXCEPTION\n" +
                                                             "   WHEN DUP_VAL_ON_INDEX THEN\n" +
                                                             "     NULL;\n" +
                                                             "END;\n")) {

                ps.setString(1, nombre);
                ps.setString(2, descripcion);
                ps.setString(3, fichero != null ? fichero.getName() : null);
                ps.execute();
            }
        } else {
            if (fichero != null) {
                try (PreparedStatement ps = con.prepareStatement("BEGIN\n" +
                                                                 "     UPDATE PARTIDO\n" +
                                                                 "      SET    NOMBRE= ?, DESCRIPCION=?, BANDERA=?\n" +
                                                                 "      WHERE  ID = ?;\n" +
                                                                 "END;\n")) {

                    ps.setString(1, nombre);
                    ps.setString(2, descripcion);
                    ps.setString(3, fichero.getName());
                    ps.setInt(4, Integer.parseInt(id));
                    ps.execute();
                }
            } else {
                try (PreparedStatement ps = con.prepareStatement("BEGIN\n" +
                                                                 "     UPDATE PARTIDO\n" +
                                                                 "      SET    NOMBRE= ?, DESCRIPCION=?\n" +
                                                                 "      WHERE  ID = ?;\n" +
                                                                 "END;\n")) {

                    ps.setString(1, nombre);
                    ps.setString(2, descripcion);
                    ps.setInt(3, Integer.parseInt(id));
                    ps.execute();
                }
            }
        }

        db.desconectar();

    } catch (Exception e) {

        e.printStackTrace();
    }
    response.sendRedirect("listPartidos.jsp");
%>
