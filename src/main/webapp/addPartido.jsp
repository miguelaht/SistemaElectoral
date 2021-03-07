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
<%
    try {
        String dir = "";
        //clase para subir archivos a disco
        //DiskFileUpload fu = new DiskFileUpload(); //hasta versi�n 6 de apache
        ServletFileUpload fu = new ServletFileUpload(new DiskFileItemFactory()); //apache 7

        //parceamos lo que viene en el request y lo clasificamos en �tems antes de apache 8.14
        //List items = fu.parseRequest(request);
        List items = fu.parseRequest(new ServletRequestContext(request)); //apache 814 en adelante

        // Iteramos por cada elemento del Request
        Iterator i = items.iterator();

        String fileName = "";
        String link = "";
        File fichero = null;
        String nombre = null, descripcion = null;
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
                }
            }
        }

        Dba db = new Dba();
        db.Conectar();
        String query = String.format("INSERT INTO PARTIDO (NOMBRE, DESCRIPCION, BANDERA) VALUES ('%s', '%s', '%s')",
                nombre.toUpperCase(), descripcion, fichero.getName());

        db.query.execute(query);

        db.desconectar();

    } catch (Exception e) {

        e.printStackTrace();
    }
    response.sendRedirect("listPartidos.jsp");
%>
