<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 15/3/21
  Time: 19:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<script>
     categories = [];
     series = [];
     values = []
    <%
        try {

            Dba db = new Dba();
            db.Conectar();
            db.query.execute("SELECT DISTINCT DEPARTAMENTO FROM UBICACION ORDER BY DEPARTAMENTO DESC");
            ResultSet rs = db.query.getResultSet();

            List<String> categories = new ArrayList<>();
            while (rs.next()) {
                categories.add(rs.getString(1));
            }

            db.query.execute(String.format("SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, PA.NOMBRE " +
                "FROM PERSONAS P " +
                "INNER JOIN CANDIDATO C ON P.ID = C.ID_PERSONA " +
                "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
                "INNER JOIN PARTIDO PA ON PA.ID = C.ID_PARTIDO " +
                "WHERE U.ROL='CA' AND C.ID_CARGO='%s'", request.getParameter("cargo"))
                );
            rs = db.query.getResultSet();
            List<List<String>> names= new ArrayList<>();
            while(rs.next()){
                List<String> lista= new ArrayList<>();
                lista.add(rs.getString(1));
                lista.add(rs.getString(2));
                names.add(lista);
            }

           String votos = "SELECT DISTINCT COUNT(V.ID), U.DEPARTAMENTO " +
                       "FROM MESAPAPELETA MP " +
                       "INNER JOIN MESAS M ON M.ID = MP.ID_MESA " +
                       "INNER JOIN MESAPERSONA M2 on M.ID = M2.ID_MESA " +
                       "INNER JOIN UBICACION U on U.ID = M.UBICACION " +
                       "INNER JOIN VOTO V ON V.ID_VOTANTE = M2.ID_PERSONA " +
                       "WHERE V.ESTADO=1 AND V.ID_CANDIDATO='%s' AND U.DEPARTAMENTO='%s' AND V.ID_CANDIDATO IN (SELECT ID_CANDIDATO FROM PAPELETAELECTORAL\n" +
                       "      WHERE ID_PAPELETA=MP.ID_PAPELETA) " +
                       "GROUP BY U.DEPARTAMENTO " +
                       "ORDER BY U.DEPARTAMENTO DESC";

            List<List<String>> series= new ArrayList<>();
            for(List<String> presi: names){
                List<String> lista= new ArrayList<>();
                for (String depto : categories) {
                    db.query.execute(String.format(votos, presi.get(0), depto));
                    rs = db.query.getResultSet();
                    while(rs.next()){
                        lista.add(rs.getString(1) != null ? rs.getString(1) : "0");
                    }
                }
                series.add(lista);
            }
            db.desconectar();

            for (String depto : categories) {
                %>
    categories.push('<%=depto%>')
    <%
            }

            for (int i=0;i<names.size();i++){
                for (String val:series.get(i)){
                %>
    values.push(<%=val%>)
    <%}
                %>
    series.push({name: '<%=names.get(i).get(1)%>', data: values});
    values = []
    <%
}

} catch (Exception e) {
e.printStackTrace();
}
%>
    Highcharts.chart('<%=request.getParameter("container")%>', {
        chart: {
            type: 'column'
        },
        title: {
            text: '<%=request.getParameter("title")%>'
        },
        xAxis: {
            categories,
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Votos'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series
    });
</script>