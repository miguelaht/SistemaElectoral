<%--
    Document   : navbar
    Created on : Feb 8, 2021, 4:39:33 PM
    Author     : miguelaht
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>


<header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3" href="home.jsp">Elecciones 2077</a>
    <button class="navbar-toggler position-absolute d-md-none collapsed" type="button"
            data-bs-toggle="collapse"
            data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false"
            aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
            <a class="nav-link" href="logout.jsp">Sign out</a>
        </li>
    </ul>
</header>

<div class="container-fluid">
    <div class="row overflow-scroll">
        <nav id="sidebarMenu"
             class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse overflow-scroll">
            <div class="position-sticky pt-3 overflow-scroll">
                <ul class="nav flex-column">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="votar.jsp?tipo=PRESIDENTE">
                                <span data-feather="home"></span>
                                Votar Presidentes
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="votar.jsp?tipo=ALCALDE">
                                <span data-feather="file"></span>
                                Votar Alcaldes
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="votar.jsp?tipo=DIPUTADO">
                                <span data-feather="shopping-cart"></span>
                                Votar Diputados
                            </a>
                        </li>
                    </ul>

                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Personas</span>
                        <a class="link-secondary" href="#" aria-label="Add a new report">
                            <span data-feather="plus-circle"></span>
                        </a>
                    </h6>
                    <ul class="nav flex-column">
                        <% if (session.getAttribute("s_rol").equals("AS")) {%>
                        <li class="nav-item">
                            <a class="nav-link" href="newPersona.jsp">
                                <span data-feather="shopping-cart"></span>
                                Nuevo Registro
                            </a>
                        </li>
                        <%}%>
                        <li class="nav-item">
                            <a class="nav-link" href="listPersonas.jsp?r=EL">
                                <span data-feather="shopping-cart"></span>
                                Electores
                            </a>
                        </li>
                        <% if (session.getAttribute("s_rol").equals("AS")) {%>
                        <li class="nav-item">
                            <a class="nav-link" href="listPersonas.jsp?r=AS">
                                <span data-feather="shopping-cart"></span>
                                Administradores
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listCandidatos.jsp">
                                <span data-feather="shopping-cart"></span>
                                Candidatos
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listPersonas.jsp?r=MM">
                                <span data-feather="shopping-cart"></span>
                                Miembros de Mesa
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listPersonas.jsp?r=MA">
                                <span data-feather="shopping-cart"></span>
                                Magistrados
                            </a>
                        </li>
                    </ul>
                        <%}%>
                        <% if (session.getAttribute("s_rol").equals("AS")) {%>
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Partidos Politicos</span>
                        <a class="link-secondary" href="#" aria-label="Add a new report">
                            <span data-feather="plus-circle"></span>
                        </a>
                    </h6>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="newPartido.jsp">
                                <span data-feather="shopping-cart"></span>
                                Nuevo Partido
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listPartidos.jsp">
                                <span data-feather="shopping-cart"></span>
                                Partidos
                            </a>
                        </li>
                    </ul>
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Mesas Electorales</span>
                        <a class="link-secondary" href="#" aria-label="Add a new report">
                            <span data-feather="plus-circle"></span>
                        </a>
                    </h6>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="newMesas.jsp">
                                <span data-feather="users"></span>
                                Nueva Mesa
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listMesas.jsp">
                                <span data-feather="users"></span>
                                Mesas
                            </a>
                        </li>
                    </ul>
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>papeletas electorales</span>
                        <a class="link-secondary" href="#" aria-label="add a new report">
                            <span data-feather="plus-circle"></span>
                        </a>
                    </h6>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="formPapeleta.jsp">
                                <span data-feather="users"></span>
                                Nueva Papeleta
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                               href="listPapeletas.jsp">
                                <span data-feather="users"></span>
                                Papeletas
                            </a>
                        </li>
                    </ul>
                        <%}%>
                        <% if (session.getAttribute("s_rol").equals("AS")) {%>
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Reportes</span>
                        <a class="link-secondary" href="#" aria-label="add a new report">
                            <span data-feather="plus-circle"></span>
                        </a>
                    </h6>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="presidentePDF.jsp">
                                <span data-feather="users"></span>
                                Presidente
                            </a>
                        </li>
                    </ul>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="votantesPDF.jsp">
                                <span data-feather="users"></span>
                                Votantes
                            </a>
                        </li>
                    </ul>
                        <%}%>
                        <%if (session.getAttribute("s_rol").equals("MM")) {%>
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Reportes</span>
                        <a class="link-secondary" href="#" aria-label="add a new report">
                            <span data-feather="plus-circle"></span>
                        </a>
                    </h6>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="candidatoPDF.jsp?tipo=PRESIDENTE">
                                <span data-feather="users"></span>
                                Presidente
                            </a>
                        </li>
                    </ul>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="candidatoPDF.jsp?tipo=ALCALDE">
                                <span data-feather="users"></span>
                                Alcalde
                            </a>
                        </li>
                    </ul>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="candidatoPDF.jsp?tipo=DIPUTADO">
                                <span data-feather="users"></span>
                                Diputados
                            </a>
                        </li>
                    </ul>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="votantesPDF.jsp">
                                <span data-feather="users"></span>
                                Votantes
                            </a>
                        </li>
                    </ul>
                        <%}%>
            </div>
        </nav>
    </div>
</div>
