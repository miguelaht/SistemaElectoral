<%--
    Document   : formPartido
    Created on : Feb 10, 2021, 10:31:55 AM
    Author     : miguelaht
--%>

<div class="col-md-6">
    <label for="nombre" class="form-label">Nombre de partido</label>
    <input type="text" class="form-control" name="nombre" id="nombre">
</div>
<div class="col-md-6">
    <label for="bandera" class="form-label">Bandera del partido</label>
    <input type="file" class="form-control" name="bandera" id="bandera">
</div>
<div class="col-md-6">
    <label for="descripcion" class="form-label">Descripcion</label>
    <textarea class="form-control" name="descripcion" id="descripcion">
                        </textarea>
</div>

<div class="col-md-12">

</div>
<div class="pt-3 d-grid gap-2 col-6 mx-auto">
    <input type="submit" class="btn btn-primary" name="submit" value="Submit"
           id="submit">
</div>
