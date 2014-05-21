<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
  	<title>Mapa - Profesionales.</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="generico.css" />
        <link rel="stylesheet" href="leaflet.css" />
        <link rel="stylesheet" href="leaflet-routing-machine.css" />
    </head>

    <body>
        <form id="formulario" method="Get" action="control">

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

            <input name="direccion" value="<%=request.getParameter("direccion")%>">  
            <input name="id_incidencia" value="<%=request.getParameter("id_incidencia")%>"> 
            <input  name="profesion" value="<%=request.getParameter("profesion")%>"> 
            <script>
                // Definimos el mapa y su vista inicial.
                var map = L.map('map').setView([40.41, -3.68], 6);

                // Definimos los iconos de gruas, hogar y clientes.
                var greenCliente = L.icon({             // Cliente Atendido
                    iconUrl: 'Imagenes/green-pin.png',
                    iconSize: [48, 48],                 // tamaño del icono.
                    iconAnchor: [24, 47],               // punto del icono == punto localizacion
                    popupAnchor: [0, -45]               // punto donde se abrirá el popup
                });
                var redCliente = L.icon({               // Cliente NO Atendido
                    iconUrl: 'Imagenes/red-pin.png',
                    iconSize: [48, 48],
                    iconAnchor: [24, 47],
                    popupAnchor: [0, -45]
                });
                var greenGrua = L.icon({                // Gruas con 0 Tareas
                    iconUrl: 'Imagenes/green-grua.png',
                    iconSize: [48, 48],
                    iconAnchor: [24, 47],
                    popupAnchor: [0, -45]
                });
                var blueGrua = L.icon({                 // Gruas con 1-3 Tareas
                    iconUrl: 'Imagenes/blue-grua.png',
                    iconSize: [48, 48],
                    iconAnchor: [24, 47],
                    popupAnchor: [0, -45]
                });
                var redGrua = L.icon({                  // Gruas con +3 Tareas
                    iconUrl: 'Imagenes/red-grua.png',
                    iconSize: [48, 48],
                    iconAnchor: [24, 47],
                    popupAnchor: [0, -45]
                });
                var greenHogar = L.icon({               // Hogar con 0 Tareas
                    iconUrl: 'Imagenes/green-home.png',
                    iconSize: [48, 48],
                    iconAnchor: [24, 47],
                    popupAnchor: [0, -45]
                });
                var blueHogar = L.icon({                // Hogar con 1-3 Tareas
                    iconUrl: 'Imagenes/blue-home.png',
                    iconSize: [48, 48],
                    iconAnchor: [24, 47],
                    popupAnchor: [0, -45]
                });
                var redHogar = L.icon({                 // Hogar con +3 Tareas
                    iconUrl: 'Imagenes/red-home.png',
                    iconSize: [48, 48],
                    iconAnchor: [24, 47],
                    popupAnchor: [0, -45]
                });

                // Incluimos las atribuciones en el mapa.
                L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
                }).addTo(map);

                <%             
                if (request.getParameter("id_incidencia") != null && request.getParameter("direccion") != null && request.getParameter("profesion") != null) {

                    if(request.getAttribute("TipoProfesional") != null){
                        String vals = null;
                        vals=  (String) request.getAttribute("datosIncidencia");
                        String[] formateados = vals.split("/");
                %>
                        // Incidencia atendida, icono = verde, NO atendida, icono = rojo.
                        var iconoIncidencia;
                        if (<%=formateados[3].equals("t")%>) iconoIncidencia = greenCliente;
                        else iconoIncidencia = redCliente;

                        L.marker([<%=formateados[0]%>, <%=formateados[1]%>], {icon: iconoIncidencia}).addTo(map)
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

                                // Dependiendo del tipo y tareas se dibuja de un icono u otro.
                                var iconoProfesional;
                                if (<%=formateado[4].equals("Grua")%>) {
                                    if (<%=Integer.parseInt(formateado[1])%> === 0) iconoProfesional = greenGrua;
                                    else if (<%=Integer.parseInt(formateado[1])%> > 3) iconoProfesional = redGrua;
                                    else iconoProfesional = blueGrua;
                                    L.marker([<%=formateado[2]%>, <%=formateado[3]%>], {icon: iconoProfesional}).addTo(map)
                                    .bindPopup("<b>Profesional: <%=formateado[0]%></b><br />Tareas: <%=formateado[1]%>.").openPopup();
                                } else {
                                    if (<%=Integer.parseInt(formateado[1])%> === 0) iconoProfesional = greenHogar;
                                    else if (<%=Integer.parseInt(formateado[1])%> > 3) iconoProfesional = redHogar;
                                    else iconoProfesional = blueHogar;
                                    L.marker([<%=formateado[2]%>, <%=formateado[3]%>], {icon: iconoProfesional}).addTo(map)
                                    .bindPopup("<b>Profesional: <%=formateado[0]%></b><br />Tareas: <%=formateado[1]%>.").openPopup();
                                }

                                L.Routing.control({
                                    waypoints: [
                                    L.latLng(<%=formateado[2]%>, <%=formateado[3]%>),
                                    L.latLng(<%=formateados[0]%>, <%=formateados[1]%>)
                                    ],
                                    showitinerary: true,
                                    id_incidencia: "<%=formateados[2]%>",
                                    id_profesional: "<%=formateado[0]%>",
                                    estado_profesional: "<%=formateado[1]%>"
                                }).addTo(map);
                        <%
                            };
                        }

                        if (request.getAttribute("TipoProfesional").toString().equals("Corto")) {                
                            ArrayList<String> datosC = null;
                            datosC = (ArrayList<String>) request.getAttribute("datosProfesionalesCorto");

                            Iterator itC = datosC.iterator();
                            while (itC.hasNext()) {
                                String valor = (String) itC.next();
                                String[] formateado = valor.split("/");
                        %>
                                var iconoProfesional;
                                if (<%=formateado[4].equals("Grua")%>) {
                                    if (<%=Integer.parseInt(formateado[1])%> === 0) iconoProfesional = greenGrua;
                                    else if (<%=Integer.parseInt(formateado[1])%> > 3) iconoProfesional = redGrua;
                                    else iconoProfesional = blueGrua;
                                    L.marker([<%=formateado[2]%>, <%=formateado[3]%>], {icon: iconoProfesional}).addTo(map)
                                    .bindPopup("<b>Profesional: <%=formateado[0]%></b><br />Tareas: <%=formateado[1]%>.").openPopup();
                                } else {
                                    if (<%=Integer.parseInt(formateado[1])%> === 0) iconoProfesional = greenHogar;
                                    else if (<%=Integer.parseInt(formateado[1])%> > 3) iconoProfesional = redHogar;
                                    else iconoProfesional = blueHogar;
                                    L.marker([<%=formateado[2]%>, <%=formateado[3]%>], {icon: iconoProfesional}).addTo(map)
                                    .bindPopup("<b>Profesional: <%=formateado[0]%></b><br />Tareas: <%=formateado[1]%>.").openPopup();
                                }

                                L.Routing.control({
                                    waypoints: [
                                    L.latLng(<%=formateado[2]%>, <%=formateado[3]%>),
                                    L.latLng(<%=formateados[0]%>, <%=formateados[1]%>)
                                    ],
                                    showitinerary: true,
                                    id_incidencia: "<%=formateados[2]%>",
                                    id_profesional: "<%=formateado[0]%>",
                                    estado_profesional: "<%=formateado[1]%>"
                                }).addTo(map);

                <%
                            };
                        }
                    }
                }
                %>
                
                // Aunque ya se definio, redefinimos la vista del mapa de nuevo.
                map.setView([40.41, -3.68], 6);
            </script>
        </form>
    </body>
</html>
