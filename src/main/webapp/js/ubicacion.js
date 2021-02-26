/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {

    $("#depto").change(function () {
        var val = $(this).val();
        if (val == "Seleccionar") {
            $("#muni").html(" <option>Seleccionar</option>");
        } else if (val == "Atlantida") {
            $("#muni").html(`
           <option>Arizona</option>
<option>El Porvenir</option>
<option>Esparta</option>
<option>Jutiapa</option>
<option>La Ceiba</option>
<option>La Masica</option>
<option>San Francisco</option>
<option>Tela</option>
        `);
        } else if (val == "Choluteca") {
            $("#muni").html(`
<option>Apacilagua</option>
<option>Choluteca</option>
<option>Concepción de María</option>
<option>Duyure</option>
<option>El Corpus</option>
<option>El Triunfo</option>
<option>Marcovia</option>
<option>Morolica</option>
<option>Namasigue</option>
<option>Orocuina</option>
<option>Pespire</option>
<option>San Antonio de Flores</option>
<option>San Isidro</option>
<option>San José</option>
<option>San Marcos de Colón</option>
<option>Santa Ana de Yusguare</option>`);
        } else if (val == "Colon") {
            $("#muni").html(`<option>Balfate</option>
<option>Bonito Oriental</option>
<option>Iriona</option>
<option>Limón</option>
<option>Sabá</option>
<option>Santa Fé</option>
<option>Santa Rosa de Aguán</option>
<option>Sonaguera</option>
<option>Tocoa</option>
<option>Trujillo</option>`);
        } else if (val == "Comayagua") {
            $("#muni").html(`<option>Ajuterique</option>
<option>Comayagua</option>
<option>El Rosario</option>
<option>Esquías</option>
<option>Humuya</option>
<option>La Libertad</option>
<option>Lamaní</option>
<option>Las Lajas</option>
<option>La Trinidad</option>
<option>Lejamaní</option>
<option>Meámbar</option>
<option>Minas de Oro</option>
<option>Ojos de Agua</option>
<option>San Jerónimo</option>
<option>San José de Comayagua</option>
<option>San José del Potrero</option>
<option>San Luis</option>
<option>San Sebastián</option>
<option>Siguatepeque</option>
<option>Taulabé</option>
<option>Villa de San Antonio</option>`);
        } else if (val == "Copan") {
            $("#muni").html(`<option>Cabañas</option>
<option>Concepción</option>
<option>Copán Ruinas</option>
<option>Corquín</option>
<option>Cucuyagua</option>
<option>Dolores</option>
<option>Dulce Nombre</option>
<option>El Paraíso</option>
<option>Florida</option>
<option>La Jigua</option>
<option>La Unión</option>
<option>Nueva Arcadia</option>
<option>San Agustín</option>
<option>San Antonio</option>
<option>San Jerónimo</option>
<option>San José</option>
<option>San Juan de Opoa</option>
<option>San Nicolás</option>
<option>San Pedro de Copán</option>
<option>Santa Rita</option>
<option>Santa Rosa de Copán</option>
<option>Trinidad de Copán</option>
<option>Veracruz, Copán</option>`);
        } else if (val == "Cortes") {
            $("#muni").html(`<option>Choloma</option>
<option>La Lima</option>
<option>Omoa</option>
<option>Pimienta</option>
<option>Potrerillos</option>
<option>Puerto Cortés</option>
<option>San Antonio de Cortés</option>
<option>San Francisco de Yojoa</option>
<option>San Manuel</option>
<option>San Pedro Sula</option>
<option>Santa Cruz de Yojoa</option>
<option>Villanueva</option>`);
        } else if (val == "El Paraiso") {
            $("#muni").html(`<option>Alauca</option>
<option>Danlí</option>
<option>El Paraíso</option>
<option>Guinope</option>
<option>Jacaleapa</option>
<option>Liure</option>
<option>Morocelí</option>
<option>Oropolí</option>
<option>Potrerillos</option>
<option>San Antonio de Flores</option>
<option>San Lucas</option>
<option>San Matías</option>
<option>Soledad</option>
<option>Teupasenti</option>
<option>Texiguat</option>
<option>Trojes</option>
<option>Vado Ancho</option>
<option>Yauyupe</option>
<option>Yuscarán</option>`);
        } else if (val == "Francisco Morazan") {
            $("#muni").html(`<option>Alubarén</option>
<option>Cedros</option>
<option>Curarén</option>
<option>Distrito Central</option>
<option>El Porvenir</option>
<option>Guaimaca</option>
<option>La Libertad</option>
<option>La Venta</option>
<option>Lepaterique</option>
<option>Maraita</option>
<option>Marale</option>
<option>Nueva Armenia</option>
<option>Ojojona</option>
<option>Orica</option>
<option>Reitoca</option>
<option>Sabanagrande</option>
<option>San Antonio de Oriente</option>
<option>San Buenaventura</option>
<option>San Ignacio</option>
<option>San Juan de Flores</option>
<option>San Miguelito</option>
<option>Santa Ana</option>
<option>Santa Lucía</option>
<option>Talanga</option>
<option>Tatumbla</option>
<option>Valle de Ángeles</option>
<option>Vallecillo</option>
<option>Villa de San Francisco</option>`);
        } else if (val == "Gracias a Dios") {
            $("#muni").html(`<option>Ahuas</option>
<option>Brus Laguna</option>
<option>Juan Francisco Bulnes</option>
<option>Puerto Lempira</option>
<option>Ramón Villeda Morales</option>
<option>Wampusirpi</option>`);
        } else if (val == "Intibuca") {
            $("#muni").html(`<option>Camasca</option>
<option>Colomoncagua</option>
<option>Concepción</option>
<option>Dolores</option>
<option>Intibucá</option>
<option>Jesús de Otoro</option>
<option>La Esperanza</option>
<option>Magdalena</option>
<option>Masaguara</option>
<option>San Antonio</option>
<option>San Francisco de Opalaca</option>
<option>San Isidro</option>
<option>San Juan</option>
<option>San Marco de Sierra</option>
<option>San Miguel Guancapla</option>
<option>Santa Lucía</option>
<option>Yamaranguila</option>`);
        } else if (val == "Islas de la Bahia") {
            $("#muni").html(`<option>Guanaja</option>
<option>Jose Santos Guardiola</option>
<option>Roatan </option>
<option>Utila</option>
<option>Banco Vivorillo</option>`);
        } else if (val == "La Paz") {
            $("#muni").html(`<option>Aguaqueterique</option>
<option>Cabañas</option>
<option>Cane</option>
<option>Chinacla</option>
<option>Guajiquiro</option>
<option>La Paz</option>
<option>Lauterique</option>
<option>Marcala</option>
<option>Mercedes de Oriente</option>
<option>Opatoro</option>
<option>San Antonio del Norte</option>
<option>San José</option>
<option>San Juan</option>
<option>San Pedro de Tutule</option>
<option>Santa Ana</option>
<option>Santa Elena</option>
<option>Santa María</option>
<option>Santiago de Puringla</option>
<option>Yarula</option>`);
        } else if (val == "Lempira") {
            $("#muni").html(`<option>Belén</option>
<option>Candelaria</option>
<option>Cololaca</option>
<option>Erandique</option>
<option>Gracias</option>
<option>Gualcince</option>
<option>Guarita</option>
<option>La Campa</option>
<option>La Iguala</option>
<option>Las Flores</option>
<option>La Unión</option>
<option>La Virtud</option>
<option>Lepaera</option>
<option>Mapulaca</option>
<option>Piraera</option>
<option>San Andrés</option>
<option>San Francisco</option>
<option>San Juan Guarita</option>
<option>San Manuel Colohete</option>
<option>San Marcos de Caiquín</option>
<option>San Rafael</option>
<option>San Sebastián</option>
<option>Santa Cruz</option>
<option>Talgua</option>
<option>Tambla</option>
<option>Tomalá</option>
<option>Valladolid</option>
<option>Virginia</option>`);
        } else if (val == "Ocotepeque") {
            $("#muni").html(`<option>Belén Gualcho</option>
<option>Concepción</option>
<option>Dolores Merendon</option>
<option>Fraternidad</option>
<option>La Encarnación</option>
<option>La Labor</option>
<option>Lucerna</option>
<option>Mercedes</option>
<option>Ocotepeque</option>
<option>San Fernando</option>
<option>San Francisco del Valle</option>
<option>Santa Ifigenia</option>
<option>San Jorge</option>
<option>San Marcos</option>
<option>Santa Fé</option>
<option>Sensenti</option>
<option>Sinuapa</option>`);
        } else if (val == "Olancho") {
            $("#muni").html(`<option>Campamento</option>
<option>Catacamas</option>
<option>Concordia</option>
<option>Dulce Nombre de Culmí</option>
<option>El Rosario</option>
<option>Esquipulas del Norte</option>
<option>Gualaco</option>
<option>Guarizama</option>
<option>Guata</option>
<option>Guayape</option>
<option>Jano</option>
<option>Juticalpa</option>
<option>La Unión</option>
<option>Mangulile</option>
<option>Manto</option>
<option>Patuca</option>
<option>Salamá</option>
<option>San Esteban</option>
<option>San Francisco de Becerra</option>
<option>San Francisco de la Paz</option>
<option>Santa María del Real</option>
<option>Silca</option>
<option>Yocón</option>`);
        } else if (val == "Santa Barbara") {
            $("#muni").html(`<option>Arada</option>
<option>Atima</option>
<option>Azacualpa</option>
<option>Ceguaca</option>
<option>Chinda</option>
<option>Concepción del Norte</option>
<option>Concepción del Sur</option>
<option>El Nispero</option>
<option>Gualala</option>
<option>Ilama</option>
<option>Las Vegas</option>
<option>Macuelizo</option>
<option>Naranjito</option>
<option>Nueva Frontera</option>
<option>Nuevo Celilac</option>
<option>Petoa</option>
<option>Protección</option>
<option>Quimistán</option>
<option>San Francisco de Ojuera</option>
<option>San José de Colinas</option>
<option>San Luis</option>
<option>San Marcos</option>
<option>San Nicolás</option>
<option>San Pedro Zacapa</option>
<option>Santa Bárbara</option>
<option>Santa Rita</option>
<option>San Vicente Centenario</option>
<option>Trinidad</option>`);
        } else if (val == "Valle") {
            $("#muni").html(`<option>Alianza</option>
<option>Amapala</option>
<option>Aramecina</option>
<option>Caridad</option>
<option>Goascorán</option>
<option>Langue</option>
<option>Nacaome</option>
<option>San Francisco de Coray</option>
<option>San Lorenzo</option>`);
        } else if (val == "Yoro") {
            $("#muni").html(`<option>Arenal</option>
<option>El Negrito</option>
<option>El Progreso</option>
<option>Jocón</option>
<option>Morazán</option>
<option>Olanchito</option>
<option>Santa Rita</option>
<option>Sulaco</option>
<option>Victoria</option>
<option>Yorito</option>
<option>Yoro</option>`);
        } else {
            $("#muni").html(`<option>Nada</option>`);
        }
    });
});

