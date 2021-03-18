<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 27/2/21
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    try {
        Dba db = new Dba();
        String[] ids = request.getParameterValues("id");
        List<String> items = new ArrayList<>();
        if (ids != null && ids.length > 0) {
            db.Conectar();

            // only update if user has not voted
            for (String id : ids) {
                db.query.execute(String.format("SELECT V1,V2,V3 FROM PERSONAS WHERE ID='%s'", id));
                ResultSet rs = db.query.getResultSet();
                if (rs.next()) {
                    if (rs.getString(1).equals("0") && rs.getString(2).equals("0") && rs.getString(3).equals("0")) {
                        items.add(id);
                    }
                }
            }

            if (items.size() > 0) {
                Connection con = db.getConexion();
                if (request.getParameter("mesa").equals("0")) {
                    try (PreparedStatement ps = con.prepareStatement("DELETE FROM MESAPERSONA WHERE ID_PERSONA=?")) {
                        for (String id : items) {
                            ps.setString(1, id);
                            ps.execute();
                        }
                    }
                } else {
                    try (PreparedStatement ps = con.prepareStatement("BEGIN\n" +
                                                                     "   INSERT INTO MESAPERSONA (ID_PERSONA, ID_MESA)\n" +
                                                                     "      VALUES(?, ?);\n" +
                                                                     "EXCEPTION\n" +
                                                                     "   WHEN DUP_VAL_ON_INDEX THEN\n" +
                                                                     "      UPDATE MESAPERSONA\n" +
                                                                     "      SET    ID_MESA = ?\n" +
                                                                     "      WHERE  ID_PERSONA = ?;\n" +
                                                                     "END;\n")) {
                        for (String id : items) {
                            ps.setString(1, id);
                            ps.setString(4, id);
                            ps.setString(2, request.getParameter("mesa"));
                            ps.setString(3, request.getParameter("mesa"));

                            ps.execute();
                        }
                    }
                }
            }
        }
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("listPersonas.jsp");
%>
