<%--
  Created by IntelliJ IDEA.
  User: miguelaht
  Date: 22/3/21
  Time: 10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

            String query = null;

            if (request.getParameter("cargo").equals("PRESIDENTE")){
                query = String.format("SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, COUNT(V.ID) " +
                "FROM PERSONAS P " +
                "INNER JOIN CANDIDATO C ON P.ID = C.ID_PERSONA " +
                "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
                "INNER JOIN VOTO V ON V.ID_CANDIDATO = P.ID " +
                "INNER JOIN PARTIDO PA ON PA.ID = C.ID_PARTIDO "+
                "WHERE V.ESTADO=1 AND U.ROL='CA' AND C.ID_CARGO='%s' " +
                "GROUP BY P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, PA.NOMBRE", request.getParameter("cargo"));
            } else if(request.getParameter("cargo").equals("ALCALDE")){
                query = String.format("SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, COUNT(V.ID) " +
                "FROM PERSONAS P " +
                "INNER JOIN CANDIDATO C ON P.ID = C.ID_PERSONA " +
                "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
                "INNER JOIN VOTO V ON V.ID_CANDIDATO = P.ID " +
                "INNER JOIN PARTIDO PA ON PA.ID = C.ID_PARTIDO "+
                "INNER JOIN MESAPERSONA MP ON MP.ID_PERSONA = V.ID_VOTANTE " +
                "INNER JOIN MESAS M ON MP.ID_MESA = M.ID " +
                "INNER JOIN UBICACION U ON U.ID = M.UBICACION " +
                "WHERE V.ESTADO=1 AND U.ROL='CA' AND C.ID_CARGO='%s' AND U.MUNICIPIO='"+request.getParameter("muni")+"' " +
                "GROUP BY P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, PA.NOMBRE",request.getParameter("cargo"));
            } else if(request.getParameter("cargo").equals("DIPUTADO")){
                query =
                String.format("SELECT P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, COUNT(V.ID) " +
                "FROM PERSONAS P " +
                "INNER JOIN CANDIDATO C ON P.ID = C.ID_PERSONA " +
                "INNER JOIN USUARIO U ON P.ID = U.ID_PERSONA " +
                "INNER JOIN VOTO V ON V.ID_CANDIDATO = P.ID " +
                "INNER JOIN PARTIDO PA ON PA.ID = C.ID_PARTIDO "+
                "INNER JOIN MESAPERSONA MP ON MP.ID_PERSONA = V.ID_VOTANTE " +
                "INNER JOIN MESAS M ON MP.ID_MESA = M.ID " +
                "INNER JOIN UBICACION U ON U.ID = M.UBICACION " +
                "WHERE V.ESTADO=1 AND U.ROL='CA' AND C.ID_CARGO='%s' AND U.DEPARTAMENTO='"+request.getParameter("depto")+"' " +
                "GROUP BY P.ID, P.NOMBRE1 || ' ' || P.NOMBRE2 || ' ' ||  P.APELLIDO1 || ' ' || P.APELLIDO2, PA.NOMBRE",request.getParameter("cargo"));
            }
            db.query.execute(query);

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

            String voto= null;

            if (request.getParameter("cargo").equals("ALCALDE")){
                voto = "SELECT DISTINCT COUNT(V.ID), M.ID_MESA " +
                     "FROM MESAPERSONA M " +
                     "INNER JOIN VOTO V ON M.ID_PERSONA = V.ID_VOTANTE "+
                     "INNER JOIN MESAS MM ON M.ID_MESA = MM.ID " +
                     "INNER JOIN UBICACION U ON U.ID = MM.UBICACION " +
                     "WHERE V.ESTADO=1 AND V.ID_CANDIDATO='%s' AND U.MUNICIPIO='"+request.getParameter("muni")+"' " +
                     "GROUP BY M.ID_MESA";

            } else if (request.getParameter("cargo").equals("DIPUTADO")){
                voto = "SELECT DISTINCT COUNT(V.ID), M.ID_MESA " +
                     "FROM MESAPERSONA M " +
                     "INNER JOIN VOTO V ON M.ID_PERSONA = V.ID_VOTANTE "+
                     "INNER JOIN MESAS MM ON M.ID_MESA = MM.ID " +
                     "INNER JOIN UBICACION U ON U.ID = MM.UBICACION " +
                     "WHERE V.ESTADO=1 AND V.ID_CANDIDATO='%s' AND U.DEPARTAMENTO='"+request.getParameter("depto")+"' " +
                     "GROUP BY M.ID_MESA";
            } else if(request.getParameter("cargo").equals("PRESIDENTE")) {
                voto = "SELECT DISTINCT COUNT(V.ID), M.ID_MESA " +
                     "FROM MESAPERSONA M " +
                     "INNER JOIN VOTO V ON M.ID_PERSONA = V.ID_VOTANTE "+
                     "WHERE V.ESTADO=1 AND V.ID_CANDIDATO='%s' " +
                    "GROUP BY M.ID_MESA";
            }


            // votos por mesa
            for (List<String> item : names) {
                db.query.execute(String.format(voto, item.get(0)));
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
        lang: {
            noData: 'No hay datos para mostrar'
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

