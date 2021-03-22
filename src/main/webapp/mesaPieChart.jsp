<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 22/3/21
  Time: 10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="database.Dba" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<script>
    series = [];
    data = [];
    votos = []
    <%
        try {

            Dba db = new Dba();
            db.Conectar();


            db.query.execute(String.format("SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, COUNT(V.ID) " +
                "FROM PERSONAS P " +
                "INNER JOIN CANDIDATO C ON P.ID = C.ID_PERSONA " +
                "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
                "INNER JOIN VOTO V ON V.ID_CANDIDATO = P.ID " +
                "INNER JOIN PARTIDO PA ON PA.ID = C.ID_PARTIDO " +
                "WHERE V.ESTADO=1 AND U.ROL='CA' AND C.ID_CARGO='%s' " +
                 "GROUP BY P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, PA.NOMBRE",
                request.getParameter("cargo"))
                );

            ResultSet rs = db.query.getResultSet();

            // datos candidato
            List<List<String>> names= new ArrayList<>();
            while(rs.next()){
                List<String> lista= new ArrayList<>();
                lista.add(rs.getString(1)); // id
                lista.add(rs.getString(2)); // nombre
                lista.add(rs.getString(3)); // total votos
                names.add(lista);
            }

            for (List<String> item : names) {
                %>
    data.push({name: '<%=item.get(1)%>', y: <%=item.get(2)%>, drilldown: '<%=item.get(1)%>'});
    <%
            }

            // votos por mesa
            for (List<String> item : names) {
                db.query.execute(String.format("SELECT DISTINCT COUNT(V.ID), M.ID_MESA " +
                     "FROM MESAPERSONA M " +
                     "INNER JOIN VOTO V ON M.ID_PERSONA = V.ID_VOTANTE " +
                     "WHERE V.ESTADO=1 AND V.ID_CANDIDATO='%s' " +
                     "GROUP BY M.ID_MESA", item.get(0)));
                rs = db.query.getResultSet();

                while (rs.next()){%>
    votos.push(["<%=rs.getString(2)%>", <%=rs.getString(1)%>]);
    <%}
      %>
    series.push({name: '<%=item.get(1)%>', id: '<%=item.get(1)%>', data: votos});
    votos = [];
    <%
            }


    db.desconectar();
} catch (Exception e) {
e.printStackTrace();
}
%>
    Highcharts.chart('<%=request.getParameter("container")%>', {
        chart: {
            type: 'pie'
        },
        title: {
            text: '<%=request.getParameter("title")%>'
        },
        accessibility: {
            announceNewData: {
                enabled: true
            },
            point: {
                valueSuffix: ''
            }
        },
        plotOptions: {
            series: {
                dataLabels: {
                    enabled: true,
                    format: '{point.name}: {point.y}'
                }
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
            pointFormat:
                '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b> of total<br/>'
        },
        // series

        series: [
            {
                name: "Resultados",
                colorByPoint: true,
                data,

            },

        ],
        drilldown: {
            series
        }
    });

</script>

