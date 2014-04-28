<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
  	<title>Mapa de prueba</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.css" />
        <link rel="stylesheet" href="leaflet.css" />
        <link rel="stylesheet" href="generico.css" />
        <link rel="stylesheet" href="leaflet-routing-machine.css" />
    </head>

    <body>
    
        
      <div id="page"> 
         <div id="primario">
        <%-- Controlamos según la devolución por parámetro del servlet el apartado que tenemos que cargar --%>
            <%
              String formularios = "nada";
              if (request.getParameter("Todos") != null) {
                 if (request.getParameter("Todos").equals("Todos")) {
                    formularios = request.getParameter("Todos");
                 }
              }
              if (request.getParameter("Profesional") != null) {
                 if (request.getParameter("Profesional").equals("Profesional")) {
                    formularios = request.getParameter("Profesional");
                 }
              }
            %>
         
                     
                     
                     
        <%-- Si el atributo es Nada porque los parámetro anterior devuelto por el 
servlets no coincide con ninguno solo cargaos esta parte de código para informar que debe hacer el usuario --%>

            <% if (formularios.equals("nada")) {%>
               <div id="cabezaH2">
                  <div id="map" style="width: 900px; height: 550px"></div>

        <script src="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.js"></script>
        <script src="leaflet-routing-machine.js"></script>
        <script>

            var map = L.map('map').setView([40.41, -3.68], 13);

             L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
            }).addTo(map);


            L.marker([40.41, -3.68]).addTo(map)
                    .bindPopup("<b>Hello world!</b><br />I am a popup.").openPopup();

            L.circle([41.41, -2.11], 500, {
                color: 'red',
                fillColor: '#f03',
                fillOpacity: 0.5
            }).addTo(map).bindPopup("I am a circle.");

            L.polygon([
                [40.509, -3.08],
                [40.503, -3.06],
                [40.51, -3.047]
            ]).addTo(map).bindPopup("I am a polygon.");
            
            L.Routing.control({
                waypoints: [
                    L.latLng(41.74, -4.94),
                    L.latLng(41.6792, -4.949)
                ]
            }).addTo(map);
            
            L.Routing.control({
                waypoints: [
                    L.latLng(42.74, -4.94),
                    L.latLng(42.6792, -4.949)
                ]
            }).addTo(map);

            var popup = L.popup();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      

            function onMapClick(e) {
                popup
                        .setLatLng(e.latlng)
                        .setContent("You clicked the map at " + e.latlng.toString())
                        .openOn(map);
            }

            map.on('click', onMapClick);

        </script>
                </div> <%--Fin del Cabeza--%>
            <% }%>

            <%-- Si el atributo es Todos cargamos sus correspondientes valores --%>
            <% if (formularios.equals("Todos")) {%>
                <input type="hidden" name="Todos" value="Todos">
               <p><input type="hidden" value="Todos"  name="tipo">
               <div class="tablasListados" >                        
                   <table id="tablas">
                         <tr> <td>ID</td><td>Estado</td><td>Longitud Latitud</td></tr>
                                <%
                                    ArrayList<String> datosA = null;
                                    datosA = (ArrayList<String>) request.getAttribute("datosTodosProfesionales");

                                    Iterator itA = datosA.iterator();
                                    while (itA.hasNext()) {
                                        String valor = (String) itA.next();
                                        String[] formateado = valor.split("/");
                                %>
                                <tr> <td><%=formateado[0]%></td><td><%=formateado[1]%></td><td><%=formateado[2]%></td><td><%=formateado[3]%></td></tr>
                                <%
                                    };%>
                   </table>
               </div>
                            
               <div id="map" style="width: 900px; height: 550px"></div>

        <script src="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.js"></script>
        <script>

            var map = L.map('map').setView([40.41, -3.68], 13);
            var greenCliente = L.icon({
                iconUrl: 'Imagenes/green-pin.png',
                iconSize:     [48, 48], // size of the icon
                iconAnchor:   [24, 47], // point of the icon which will correspond to marker's location
                popupAnchor:  [0, -45] // point from which the popup should open relative to the iconAnchor
            });
            var redCliente = L.icon({
                iconUrl: 'Imagenes/red-pin.png',
                iconSize:     [48, 48], // size of the icon
                iconAnchor:   [24, 47], // point of the icon which will correspond to marker's location
                popupAnchor:  [0, -45] // point from which the popup should open relative to the iconAnchor
            });
            var greenGrua = L.icon({
                iconUrl: 'Imagenes/green-grua.png',
                iconSize:     [48, 48], // size of the icon
                iconAnchor:   [24, 47], // point of the icon which will correspond to marker's location
                popupAnchor:  [0, -45] // point from which the popup should open relative to the iconAnchor
            });
            var blueGrua = L.icon({
                iconUrl: 'Imagenes/blue-grua.png',
                iconSize:     [48, 48], // size of the icon
                iconAnchor:   [24, 47], // point of the icon which will correspond to marker's location
                popupAnchor:  [0, -45] // point from which the popup should open relative to the iconAnchor
            });
            var redGrua = L.icon({
                iconUrl: 'Imagenes/red-grua.png',
                iconSize:     [48, 48], // size of the icon
                iconAnchor:   [24, 47], // point of the icon which will correspond to marker's location
                popupAnchor:  [0, -45] // point from which the popup should open relative to the iconAnchor
            });
            var greenHogar = L.icon({
                iconUrl: 'Imagenes/green-home.png',
                iconSize:     [48, 48], // size of the icon
                iconAnchor:   [24, 47], // point of the icon which will correspond to marker's location
                popupAnchor:  [0, -45] // point from which the popup should open relative to the iconAnchor
            });
            var blueHogar = L.icon({
                iconUrl: 'Imagenes/blue-home.png',
                iconSize:     [48, 48], // size of the icon
                iconAnchor:   [24, 47], // point of the icon which will correspond to marker's location
                popupAnchor:  [0, -45] // point from which the popup should open relative to the iconAnchor
            });
            var redHogar = L.icon({
                iconUrl: 'Imagenes/red-home.png',
                iconSize:     [48, 48], // size of the icon
                iconAnchor:   [24, 47], // point of the icon which will correspond to marker's location
                popupAnchor:  [0, -45] // point from which the popup should open relative to the iconAnchor
            });

            L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
            }).addTo(map);

                               <%
                                    ArrayList<String> datosB = null;
                                    datosB = (ArrayList<String>) request.getAttribute("datosTodosProfesionales");

                                    Iterator itB = datosB.iterator();
                                    while (itB.hasNext()) {
                                        String valor = (String) itB.next();
                                        String[] formateado = valor.split("/");
                                %>
                                L.marker([<%=formateado[2]%>, <%=formateado[3]%>]
                                        <% if(formateado[4].equals("Grua")){
                                                if(Integer.parseInt(formateado[1])==0){%>, {icon:greenGrua}
                                            <%} else if(Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueGrua}
                                            <%} else if(Integer.parseInt(formateado[1])>3){%>, {icon:redGrua}
                                        <%}} else {
                                                if(Integer.parseInt(formateado[1])==0){%>, {icon:greenHogar}
                                            <%} else if(Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueHogar}
                                            <%} else if(Integer.parseInt(formateado[1])>3){%>, {icon:redHogar}
                                        <%}}%>).addTo(map)
                    .bindPopup("<b>Profesional <%=formateado[0]%></b><br />Estado <%=formateado[1]%>.").openPopup();
                                <%
                                    };
                                    
                                    ArrayList<String> datosC = null;
                                    datosC = (ArrayList<String>) request.getAttribute("datosTodosIncidencias");

                                    Iterator itC = datosC.iterator();
                                    while (itC.hasNext()) {
                                        String valor = (String) itC.next();
                                        String[] formateado = valor.split("/");
                                %>
                                L.marker([<%=formateado[2]%>, <%=formateado[3]%>]<% if(formateado[1].equals("t")){%>, {icon:greenCliente}<%}else{%>, {icon:redCliente}<%}%>
                                           ).addTo(map)
                    .bindPopup("<b>Cliente <%=formateado[0]%> </b><br />Estado <%=formateado[1]%>.").openPopup();
                                <%
                                    };%>
           
            L.circle([51.508, -0.11], 500, {
                color: 'red',
                fillColor: '#f03',
                fillOpacity: 0.5
            }).addTo(map).bindPopup("I am a circle.");

            L.polygon([
                [51.509, -0.08],
                [51.503, -0.06],
                [51.51, -0.047]
            ]).addTo(map).bindPopup("I am a polygon.");


            var popup = L.popup();

            function onMapClick(e) {
                popup
                        .setLatLng(e.latlng)
                        .setContent("You clicked the map at " + e.latlng.toString())
                        .openOn(map);
            }

            map.on('click', onMapClick);

        </script>
               
          <% }%>
          
          <%-- Si el atributo es Profesional cargamos sus correspondientes valores --%>
            <% if (formularios.equals("Profesional")) {%>
           
            <form id="formulario" action="controlador">
                
             <input type="hidden" name="Profesional" value="Profesional">
             <input type="hidden" value="Profesional"  name="tipo">
            <%--opciones de la seleccion de profesionales a mostrar--%>
               
                <select id="TipoProfesional" name="TipoProfesional" onchange="javascript:submit();">
                                     <option value="Ninguno">Ninguno</option>
                                    <option value="Rapido">Mas rapido</option>
                                    <option value="Corto">Mas corto</option>
                </select>
                <select id="NumeroProfesional" name="NumeroProfesional">
                                    <option value="5">5 profesionales</option>
                                    <option value="10">10 profesionales</option>
                                    <option value="15">15 profesionales</option>
                                    <option value="20">20 profesionales</option>
                </select>
                <select id="profesion" name="profesion">
                                    <option value="Grua">Grua</option>
                                    <option value="Hogar">Hogar</option>
                </select> 
                <p>Cliente<input type="text" name="cliente" title="Solo se aceptan numeros" required></p> 
                            
               <div id="map" style="width: 900px; height: 550px"></div>

        <script src="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.js"></script>
        <script>

            var map = L.map('map').setView([40.41, -3.68], 13);
            var greenCliente = L.icon({
                iconUrl: 'Imagenes/green-pin.png',
                iconSize:     [32, 32], // size of the icon
                iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
                popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
            });
           var redCliente = L.icon({
                iconUrl: 'Imagenes/red-pin.png',
                iconSize:     [32, 32], // size of the icon
                iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
                popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
            });
            var greenGrua = L.icon({
                iconUrl: 'Imagenes/green-grua.png',
                iconSize:     [32, 32], // size of the icon
                iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
                popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
            });
           var blueGrua = L.icon({
                iconUrl: 'Imagenes/blue-grua.png',
                iconSize:     [32, 32], // size of the icon
                iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
                popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
            });
            var redGrua = L.icon({
                iconUrl: 'Imagenes/red-grua.png',
                iconSize:     [32, 32], // size of the icon
                iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
                popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
            });
           var greenHogar = L.icon({
                iconUrl: 'Imagenes/green-home.png',
                iconSize:     [32, 32], // size of the icon
                iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
                popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
            });
            var blueHogar = L.icon({
                iconUrl: 'Imagenes/blue-home.png',
                iconSize:     [32, 32], // size of the icon
                iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
                popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
            });
            var redHogar = L.icon({
                iconUrl: 'Imagenes/red-home.png',
                iconSize:     [32, 32], // size of the icon
                iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
                popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
            });

            L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
            }).addTo(map);

                    <% 
                       if (request.getParameter("cliente") != null && !request.getParameter("cliente").toString().equals("")){
                                   
                                    
                                     String vals = null;
                                       vals=  (String) request.getAttribute("datosIncidencia");
                                     String[] formateados = vals.split("/");
                                %>
                                L.marker([<%=formateados[0]%>, <%=formateados[1]%>]<% if(formateados[3]=="t"){%>, {icon:greenCliente}<%}else{%>, {icon:redCliente}<%}%>
                                           ).addTo(map)
                    .bindPopup("<b>Cliente <%=formateados[2]%> </b><br />Estado <%=formateados[3]%>.").openPopup();
            
                           <%
                           if (request.getParameter("TipoProfesional").toString().equals("Rapido")) {
                                   
                                    ArrayList<String> datosB = null;
                                    datosB = (ArrayList<String>) request.getAttribute("datosProfesionalesRapidos");

                                    Iterator itB = datosB.iterator();
                                    while (itB.hasNext()) {
                                        String valor = (String) itB.next();
                                        String[] formateado = valor.split("/");
                                %>
                                L.marker([<%=formateado[2]%>, <%=formateado[3]%>]
                                        <% if(formateado[4]=="Grua" && Integer.parseInt(formateado[1])==0){%>, {icon:greenGrua})<%}%>
                                        <% if(formateado[4]=="Grua" && Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueGrua}<%}%>
                                        <% if(formateado[4]=="Grua" && Integer.parseInt(formateado[1])>3){%>, {icon:redGrua})<%}%>
                                        <% if(formateado[4]=="Hogar" && Integer.parseInt(formateado[1])==0){%>, {icon:greenHogar})<%}%>
                                        <% if(formateado[4]=="Hogar" && Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueHogar}<%}%>
                                        <% if(formateado[4]=="Hogar" && Integer.parseInt(formateado[1])>3){%>, {icon:redHogar})<%}%>).addTo(map)
                    .bindPopup("<b>Profesional <%=formateado[0]%></b><br />Estado <%=formateado[1]%></b><br />Km <%=formateado[5]%>.").openPopup();
                                <%
                                    };}
                    if (request.getAttribute("TipoProfesional").toString().equals("Corto")) {                
                                    ArrayList<String> datosC = null;
                                    datosC = (ArrayList<String>) request.getAttribute("datosProfesionalesCorto");

                                    Iterator itC = datosC.iterator();
                                    while (itC.hasNext()) {
                                        String valor = (String) itC.next();
                                        String[] formateado = valor.split("/");
                                %>
                                L.marker([<%=formateado[2]%>, <%=formateado[3]%>] <% if(formateado[4]=="Grua" && Integer.parseInt(formateado[1])==0){%>, {icon:greenGrua})<%}%>
                                        <% if(formateado[4]=="Grua" && Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueGrua}<%}%>
                                        <% if(formateado[4]=="Grua" && Integer.parseInt(formateado[1])>3){%>, {icon:redGrua})<%}%>
                                        <% if(formateado[4]=="Hogar" && Integer.parseInt(formateado[1])==0){%>, {icon:greenHogar})<%}%>
                                        <% if(formateado[4]=="Hogar" && Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueHogar}<%}%>
                                        <% if(formateado[4]=="Hogar" && Integer.parseInt(formateado[1])>3){%>, {icon:redHogar})<%}%>).addTo(map)
                    
                    .bindPopup("<b>Profesional <%=formateado[0]%> </b><br />Estado <%=formateado[1]%> </b><br />Duracion <%=formateado[5]%>.").openPopup();
                                <%
                                    };}}%>



            var popup = L.popup();

            function onMapClick(e) {
                popup
                        .setLatLng(e.latlng)
                        .setContent("You clicked the map at " + e.latlng.toString())
                        .openOn(map);
            }

            map.on('click', onMapClick);

        </script>
        
             </form>
          <% }%>
      </div> <%--Primario--%>
       
      
          
          
        <%--Menu derecho de las opciones de visualizacion --%>  
          <div id="secundario">
                <ul id="opciones" >
                    <li >
                        <form action="controlador" method="post"> 
                            <input type="hidden" value="Todos"  name="tipo">
                            <%-- Llamamos al servlet según el action que hay en el form que en este caso es listados--%>
                            <input type="submit" name="Todos" value="Todos" class="botones">
                        </form>
                    </li>                    
                    <li >
                        <form action="controlador" method="post"> 
                            <input type="hidden" value="Profesional"  name="tipo">
                            <%-- Llamamos al servlet según el action que hay en el form que en este caso es listados--%>
                            <input type="submit" name="Profesional" value="Profesional" class="botones">
                        </form>
                    </li>
                </ul>
           </div>
        </div>
        
    </body>
</html>