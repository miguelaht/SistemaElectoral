<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <div class="d-flex flex-column">
                <h5 class="modal-title">Agregar <%=request.getParameter("cargo")%>
                </h5>
            </div>
        </div>
        <div class="modal-body">
            <form method="POST" action="addCandidato.jsp">
                <%if (request.getParameter("cargo").equals("PRESIDENTE")) {%>
                <jsp:include page="formList.jsp">
                    <jsp:param name="check" value="hidden"/>
                    <jsp:param name="query" value='<%=request.getParameter("queryPersonas")%>'/>
                </jsp:include>
                <% } else {%>
                <jsp:include page="formList.jsp">
                    <jsp:param name="radio" value="hidden"/>
                    <jsp:param name="query" value='<%=request.getParameter("queryPersonas")%>'/>
                </jsp:include>
                <% }%>


                <input hidden type="text" name="cargo" value="<%=request.getParameter("cargo")%>"/>
                <input hidden type="text" name="party" value="<%=request.getParameter("party")%>"/>
                <button type="submit" name="submit" class="btn btn-primary">Agregar</button>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        </div>
    </div>
</div>
