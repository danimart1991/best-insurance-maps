<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
  	<title>Mapa de prueba</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="generico.css" />
        <link rel="stylesheet" href="leaflet.css" />
        <link rel="stylesheet" href="leaflet-routing-machine.css" />
    </head>

    <body>
    
            <form id="formulario" action="control">
                
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
               <div id="map" style="width: 900px; height: 550px"></div>
                <script src="leaflet.js"></script>
                <script src="leaflet-routing-machine.js"></script>
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
            if (request.getParameter("id_incidencia") != null && request.getParameter("direccion") != null && request.getParameter("profesion") != null) {
                         request.setAttribute("id_incidencia", request.getParameter("id_incidencia"));
                         request.setAttribute("profesion", request.getParameter("profesion"));    
                         request.setAttribute("direccion", request.getParameter("direccion"));  
                        %>; 
                       //  var geocoder = new google.maps.Geocoder();
                       //  var address = "Calle alcala 6, Madrid";<%//request.getParameter("direccion").toString();%>;
                       //  geocoder.geocode( { 'address': address}, function(results, status) {
                      //   var latitude;
                      //   var  longitude;
                      //   if (status === google.maps.GeocoderStatus.OK) {

                       //     latitude = results[0].geometry.location.lat();
                       //     longitude = results[0].geometry.location.lng();
                       //   }
                        //    request.setAttribute("lat", latitude);
                        //    request.setAttribute("lon", longitude);
                      // })   
                 
                 ///Falta quitar el profesional en el codigo de abajo
           <%      
                   if(request.getParameter("TipoProfesional")!=null){
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
                                                <% if(formateado[4].equals("Grua")){
                                                        if(Integer.parseInt(formateado[1])==0){%>, {icon:greenGrua}
                                                    <%} else if(Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueGrua}
                                                    <%} else if(Integer.parseInt(formateado[1])>3){%>, {icon:redGrua}
                                                <%}} else {
                                                        if(Integer.parseInt(formateado[1])==0){%>, {icon:greenHogar}
                                                    <%} else if(Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueHogar}
                                                    <%} else if(Integer.parseInt(formateado[1])>3){%>, {icon:redHogar}
                                                <%}}%>).addTo(map)
                                                .bindPopup("<b>Profesional <%=formateado[0]%></b><br />Estado <%=formateado[1]%></b><br />Km <%=formateado[5]%>.").openPopup();
                                        L.Routing.control({
                                                 waypoints: [
                                                 L.latLng(<%=formateado[2]%>, <%=formateado[3]%>),
                                                 L.latLng(<%=formateados[0]%>, <%=formateados[1]%>)
                                                 ],
                                                 showitinerary: true
                                        }).addTo(map);
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
                                
                    
                    .bindPopup("<b>Profesional <%=formateado[0]%> </b><br />Estado <%=formateado[1]%> </b><br />Duracion <%=formateado[5]%>.").openPopup();
                            L.Routing.control({
                                                 waypoints: [
                                                 L.latLng(<%=formateado[2]%>, <%=formateado[3]%>),
                                                 L.latLng(<%=formateados[0]%>, <%=formateados[1]%>)
                                                 ],
                                                 showitinerary: true
                                        }).addTo(map);
                    <%
                                    };}}}%>



            //var popup = L.popup();

            //function onMapClick(e) {
            //    popup
            //            .setLatLng(e.latlng)
            //            .setContent("You clicked the map at " + e.latlng.toString())
            //            .openOn(map);
            //}

            //map.on('click', onMapClick);
         
            
            
            

        </script>
        
             </form>
    </body>
</html>
