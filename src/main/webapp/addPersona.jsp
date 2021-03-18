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
<%@ page import="util.Mail" %>
<%@ page import="util.CryptoHash" %>

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

        // persona
        Dba db = new Dba();
        db.Conectar();
        Connection con = db.getConexion();
        try (PreparedStatement ps = con.prepareStatement("BEGIN\n" +
                                                         "   INSERT INTO PERSONAS (ID, NOMBRE1, NOMBRE2, APELLIDO1, APELLIDO2, EMAIL, TELEFONO)\n" +
                                                         "      VALUES(?, ?, ?, ?, ?, ?, ?);\n" +
                                                         "EXCEPTION\n" +
                                                         "   WHEN DUP_VAL_ON_INDEX THEN\n" +
                                                         "      UPDATE PERSONAS\n" +
                                                         "      SET    NOMBRE1= ?, NOMBRE2=?, APELLIDO1=?, APELLIDO2=?, EMAIL=?, TELEFONO=?\n" +
                                                         "      WHERE  ID = ?;\n" +
                                                         "END;\n")) {

            ps.setString(1, p_id);
            ps.setString(14, p_id);
            ps.setString(2, n1);
            ps.setString(8, n1);
            ps.setString(3, n2);
            ps.setString(9, n2);
            ps.setString(4, a1);
            ps.setString(10, a1);
            ps.setString(5, a2);
            ps.setString(11, a2);
            ps.setString(6, email);
            ps.setString(12, email);
            ps.setString(7, cel);
            ps.setString(13, cel);

            ps.execute();
        }


        // usuario
        String hash = null;
        if (email != null && email.length() > 0) {
            Mail inbox = new Mail();
            String code = inbox.sendMail(email, application.getRealPath("WEB-INF/") + "main.py");
            hash = code != null ? CryptoHash.getHash(code) : null;
        }

        try (PreparedStatement ps = con.prepareStatement("BEGIN\n" +
                                                         "   INSERT INTO USUARIO (ID_PERSONA, PASSWORD, ESTADO_U, ROL, ESTADO_P)\n" +
                                                         "      VALUES(?, ?, 0, ?, ?);\n" +
                                                         "EXCEPTION\n" +
                                                         "   WHEN DUP_VAL_ON_INDEX THEN\n" +
                                                         "      UPDATE USUARIO SET ROL=? WHERE ID_PERSONA=?;\n" +
                                                         "END;\n")) {
            ps.setString(1, p_id);
            ps.setString(2, hash);
            ps.setString(3, rol);
            ps.setInt(4, hash == null ? 0 : 1);
            ps.setString(5, rol);
            ps.setString(6, p_id);
            ps.execute();
        }

        // candidato
        if (cargo != null && party != null && rol.equals("CA")) {
            if (fichero != null) {
                try (PreparedStatement ps = con.prepareStatement("BEGIN\n" +
                                                                 "   INSERT INTO CANDIDATO (ID_PERSONA, ID_CARGO, ID_PARTIDO, FOTO)\n" +
                                                                 "      VALUES(?, ?, ?, ?);\n" +
                                                                 "EXCEPTION\n" +
                                                                 "   WHEN DUP_VAL_ON_INDEX THEN\n" +
                                                                 "      UPDATE CANDIDATO\n" +
                                                                 "      SET    ID_CARGO= ?, ID_PARTIDO=?, FOTO=?\n" +
                                                                 "      WHERE  ID_PERSONA = ?;\n" +
                                                                 "END;\n")) {

                    ps.setString(1, p_id);
                    ps.setString(2, cargo);
                    ps.setString(3, party);
                    ps.setString(4, fichero.getName());
                    ps.setString(5, cargo);
                    ps.setString(6, party);
                    ps.setString(7, fichero.getName());
                    ps.setString(8, p_id);
                    ps.execute();
                }
            } else {
                try (PreparedStatement ps = con.prepareStatement("BEGIN\n" +
                                                                 "   INSERT INTO CANDIDATO (ID_PERSONA, ID_CARGO, ID_PARTIDO)\n" +
                                                                 "      VALUES(?, ?, ?);\n" +
                                                                 "EXCEPTION\n" +
                                                                 "   WHEN DUP_VAL_ON_INDEX THEN\n" +
                                                                 "      UPDATE CANDIDATO\n" +
                                                                 "      SET    ID_CARGO= ?, ID_PARTIDO=?\n" +
                                                                 "      WHERE  ID_PERSONA = ?;\n" +
                                                                 "END;\n")) {

                    ps.setString(1, p_id);
                    ps.setString(2, cargo);
                    ps.setString(3, party);
                    ps.setString(4, cargo);
                    ps.setString(5, party);
                    ps.setString(6, p_id);
                    ps.execute();
                }
            }
        }
        db.desconectar();

    } catch (Exception e) {
        e.printStackTrace();
    }
    out.print("<script>location.href = document.referrer;</script>");

%>