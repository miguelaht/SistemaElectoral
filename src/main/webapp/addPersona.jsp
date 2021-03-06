<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 5/3/21
  Time: 19:59
  To change this template use File | Settings | File Templates.
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
        //archivo
        ServletFileUpload fu = new ServletFileUpload(new DiskFileItemFactory()); //apache 7

        List items = fu.parseRequest(new ServletRequestContext(request)); //apache 814 en adelante

        // Iteramos por cada elemento del Request
        Iterator i = items.iterator();

        String fileName = "";
        File fichero = null;
        String p_id = null, party = null, cargo = null, n1 = null, n2 = null, a1 = null, a2 = null,
                email = null, cel = null, rol = null;
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
                if (ff.getFieldName().compareTo("id") == 0) {
                    p_id = ff.getString();
                } else if (ff.getFieldName().compareTo("party") == 0) {
                    party = ff.getString();
                } else if (ff.getFieldName().compareTo("cargo") == 0) {
                    cargo = ff.getString();
                } else if (ff.getFieldName().compareTo("sur1") == 0) {
                    a1 = ff.getString();
                } else if (ff.getFieldName().compareTo("sur2") == 0) {
                    a2 = ff.getString();
                } else if (ff.getFieldName().compareTo("name1") == 0) {
                    n1 = ff.getString();
                } else if (ff.getFieldName().compareTo("name2") == 0) {
                    n2 = ff.getString();
                } else if (ff.getFieldName().compareTo("email") == 0) {
                    email = ff.getString();
                } else if (ff.getFieldName().compareTo("cel") == 0) {
                    cel = ff.getString();
                } else if (ff.getFieldName().compareTo("rol") == 0) {
                    rol = ff.getString();
                }
            }
        }
//            archivo

        Dba db = new Dba();
        db.Conectar();

        // persona
        db.query.execute(
                String.format(
                        "INSERT INTO PERSONAS (ID, NOMBRE1, NOMBRE2, APELLIDO1, APELLIDO2, EMAIL, TELEFONO) "
                        + "VALUES ('%s', '%s','%s', '%s','%s', '%s','%s')",
                        p_id, n1, n2, a1, a2, email, cel));
        // usuario
        db.query.execute(
                String.format(
                        "INSERT INTO USUARIO (ID_PERSONA, ESTADO_U, PASSWORD, ESTADO_P, ROL) "
                        + "VALUES ('%s', 0, NULL, 0, '%s')", p_id, rol
                )
        );

        // candidato
        if (fichero != null) {
            db.query.execute(String.format("INSERT INTO CANDIDATO (ID_PERSONA, ID_CARGO, ID_PARTIDO, FOTO) VALUES ('%s', '%s', '%s', '%s')"
                    , p_id, cargo, party, fichero.getName()));
        }
        db.desconectar();

    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("newPersona.jsp");
%>