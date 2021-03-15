<%--
    Document   : formMesa
    Created on : Feb 11, 2021, 1:30:12 PM
    Author     : miguelaht
--%>

<%@page import="database.Dba" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    if (session.getAttribute("s_id") == null) {
        response.sendRedirect("index.jsp");
    }
    if (!session.getAttribute("s_rol").equals("AS")) {
        response.sendRedirect("home.jsp");
    }
%>

<div class="col-md-6">
    <label for="depto" class="form-label">Departamento</label>
    <select id="depto" name="depto"  class="form-control">
        <option>Seleccionar</option>
        <option>Atlantida</option>
        <option>Colon</option>
        <option>Comayagua</option>
        <option>Copan</option>
        <option>Cortes</option>
        <option>Choluteca</option>
        <option>El Paraiso</option>
        <option>Francisco Morazan</option>
        <option>Gracias a Dios</option>
        <option>Intibuca</option>
        <option>Islas de la Bahia</option>
        <option>La Paz</option>
        <option>Lempira</option>
        <option>Ocotepeque</option>
        <option>Olancho</option>
        <option>Santa Barbara</option>
        <option>Valle</option>
        <option>Yoro</option>
    </select>
</div>
<div class="col-md-6">
    <label for="muni" class="form-label">Municipio</label>
    <select id="muni" name="muni"  class="form-control">
        <option>Seleccionar</option>
    </select>
</div>
<div class="col-md-6">
    <label for="desc" class="form-label">Descripcion de Ubicacion</label>
    <textarea class="form-control" id="desc" name="desc" autoComplete="off"></textarea>
</div>
<div class="col-md-6">
    <label for="estado" class="form-label">Estado de Mesa</label>
    <input list="status" id="estado" class="form-control" name="estado" autoComplete="off"
           placeholder="Seleccionar Estado">
    <datalist id="status">
        <option value="1">Abierta</option>
        <option value="0">Cerrada</option>
    </datalist>
</div>
<div class="col-md-6">
    <label for="lat" class="form-label">Latitud</label>
    <input class="form-control" name="lat" id="lat" autoComplete="off" readonly>
</div>
<div class="col-md-6">
    <label for="lng" class="form-label">Longitud</label>
    <input class="form-control" name="lng" id="lng" autoComplete="off" readonly>
</div>
<%--map--%>
<div class="col-md-6 w-100 rounded shadow-lg border border-dark mt-2">
    <div style="height: 500px" id="map"></div>
</div>