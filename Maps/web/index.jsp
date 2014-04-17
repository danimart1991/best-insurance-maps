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
        <link rel="stylesheet" href="generico.css" />
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
            %>
         
                     
                     
                     
        <%-- Si el atributo es Nada porque los parámetro anterior devuelto por el 
servlets no coincide con ninguno solo cargaos esta parte de código para informar que debe hacer el usuario --%>

            <% if (formularios.equals("nada")) {%>
               <div id="cabezaH2">
                   <h2 >Elija una opcion del menu de la derechar para navegar por la aplicacion</h2>
                   
                  <div id="map" style="width: 600px; height: 400px"></div>

        <script src="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.js"></script>
        <script>

            var map = L.map('map').setView([40.41, -3.68], 13);

            L.tileLayer('http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png', {
                maxZoom: 18,
                attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery Â© <a href="http://cloudmade.com">CloudMade</a>'
            }).addTo(map);


            L.marker([40.41, -3.68]).addTo(map)
                    .bindPopup("<b>Hello world!</b><br />I am a popup.").openPopup();

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
                </div> <%--Fin del Cabeza--%>
            <% }%>

            <%-- Si el atributo es Todos cargamos sus correspondientes valores --%>
            <% if (formularios.equals("Todos")) {%>

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
                            
               <div id="map" style="width: 600px; height: 400px"></div>

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

            L.tileLayer('http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png', {
                maxZoom: 18,
                attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery Â© <a href="http://cloudmade.com">CloudMade</a>'
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
                                        <% if(formateado[4]=="Grua" && Integer.parseInt(formateado[1])==0){%>, {icon:greenGrua})<%}%>
                                        <% if(formateado[4]=="Grua" && Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueGrua}<%}%>
                                        <% if(formateado[4]=="Grua" && Integer.parseInt(formateado[1])>3){%>, {icon:redGrua})<%}%>
                                        <% if(formateado[4]=="Hogar" && Integer.parseInt(formateado[1])==0){%>, {icon:greenHogar})<%}%>
                                        <% if(formateado[4]=="Hogar" && Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueHogar}<%}%>
                                        <% if(formateado[4]=="Hogar" && Integer.parseInt(formateado[1])>3){%>, {icon:redHogar})<%}%>).addTo(map)
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
                                L.marker([<%=formateado[2]%>, <%=formateado[3]%>]<% if(formateado[1]=="t"){%>, {icon:greenCliente}<%}else{%>, {icon:redCliente}<%}%>
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
      </div> <%--Primario--%>
       
      
          
          
        <%--Menu derecho de las opciones de visualizacion --%>  
          <div id="secundario">
                <ul id="lista" >
                    <li >
                        <form action="controlador" method="post"> 
                            <input type="hidden" value="Todos"  name="tipo">
                            <%-- Llamamos al servlet según el action que hay en el form que en este caso es listados--%>
                            <input type="submit" name="Todos" value="Todos" class="botones">
                        </form>
                    </li>
                </ul>
           </div>
        </div>
        
    </body>
</html>