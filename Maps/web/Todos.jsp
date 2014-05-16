
<%@page import="Controladores.Conexion"%>
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
        <input type="hidden" name="Todos" value="Todos">
        <input type="hidden" value="Todos" name="tipo">
        <div id="map" style="width: 900px; height: 550px"></div>
        
        <script src="leaflet.js"></script>
        <script src="leaflet-routing-machine.js"></script>
        <script>

            var map = L.map('map').setView([40.41, -3.68], 6);
            
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
            
            var gruas = L.layerGroup();
            var hogar = L.layerGroup();
            var incidencias = L.layerGroup();

                               <%
                                   Conexion bd= new Conexion();
                                   bd.abrirConexion();
                                    ArrayList<String> datosB = null;
                                    /*Array con todos los profesionales*/
                                    datosB =(ArrayList<String>)  bd.datosTodosProfesionales();
                                    
                                    Iterator itB = datosB.iterator();
                                    while (itB.hasNext()) {
                                        String valor = (String) itB.next();
                                        String[] formateado = valor.split("/");
                                %>
                                <% if(formateado[4].equals("Grua")){%>
                                        gruas.addLayer(L.marker([<%=formateado[2]%>, <%=formateado[3]%>]
                                            <%  if(Integer.parseInt(formateado[1])==0){%>, {icon:greenGrua}
                                            <%} else if(Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueGrua}
                                            <%} else if(Integer.parseInt(formateado[1])>3){%>, {icon:redGrua}
                                        <%}} else {%>
                                        hogar.addLayer(L.marker([<%=formateado[2]%>, <%=formateado[3]%>]
                                            <%  if(Integer.parseInt(formateado[1])==0){%>, {icon:greenHogar}
                                            <%} else if(Integer.parseInt(formateado[1])>0 && Integer.parseInt(formateado[1])<3){%>, {icon:blueHogar}
                                            <%} else if(Integer.parseInt(formateado[1])>3){%>, {icon:redHogar}
                                        <%}}%>)
                    .bindPopup("<b>Profesional <%=formateado[0]%></b><br />Estado <%=formateado[1]%>."));
                                <%
                                    };
                                    
                                    ArrayList<String> datosC = null;
                                    datosC = (ArrayList<String>) bd.datosTodosIncidencias();

                                    Iterator itC = datosC.iterator();
                                    while (itC.hasNext()) {
                                        String valor = (String) itC.next();
                                        String[] formateado = valor.split("/");
                                            %>
                                            incidencias.addLayer(L.marker([<%=formateado[2]%>, <%=formateado[3]%>]<% if(formateado[1].equals("t")){%>, {icon:greenCliente}<%}else{%>, {icon:redCliente}<%}%>)
                                            .bindPopup("<b>Cliente <%=formateado[0]%> </b><br />Estado <%=formateado[1]%>."));
                                                    <%
                                                    // Si tiene un profesional asignado, dibujamos la ruta entre ambos.
                                                    if (!formateado[4].equals("null")) {
                                                        String posicProf0 = null;
                                                        String posicProf1 = null;
                                                        
                                                        ArrayList<String> datosD = null;
                                                        datosD = (ArrayList<String>) bd.datosTodosProfesionales();
                                                        Iterator itD = datosD.iterator();
                                                        while (itD.hasNext() && posicProf0 == null) {
                                                            String datos = (String) itD.next();
                                                            String[] formateado2 = datos.split("/");
                                                            if (formateado2[0].equals(formateado[4])){
                                                                posicProf0 = formateado2[2];
                                                                posicProf1 = formateado2[3];
                                                            }
                                                        }
                                                    %>
                                                        L.Routing.control({
                                                             waypoints: [
                                                             L.latLng(<%=formateado[2]%>, <%=formateado[3]%>), // Posicion Incidencia
                                                             L.latLng(<%=posicProf0%>, <%=posicProf1%>)        // Posicion Profesional
                                                              ],
                                                            id_profesional: "null",
                                                            estado_profesional: "null"
                                                        }).addTo(map);
                                                     <%   
                                                    }
                                    };%>
           
           // TODO: Terminar leyenda con iconos y colores. ;)
           var legend = L.control({position: 'bottomleft'});
           
           legend.onAdd = function (map) {
               
               var div = L.DomUtil.create('div', 'info legend');
               
               div.innerHTML +=
                       '<i>Clientes: </i>' + '<br>' +
                       '<i style="background: green"></i>' + 'Atendido<br>' +
                       '<i style="background: red"></i>' + 'Pendiente<br>' +
                       '<i>Profesionales: </i>' + '<br>' +
                       '<i style="background: green"></i>' + '0 Tareas<br>' +
                       '<i style="background: blue"></i>' + '1-3 Tareas<br>' +
                       '<i style="background: red"></i>' + '+3 Tareas<br>';
               
           
               return div;
           };
           
           legend.addTo(map);
           
            var baseMaps = {};
            
            var overlayMaps = {
                "Gruas": gruas,
                "Hogar": hogar,
                "Incidencias": incidencias
            };
            
            L.control.layers(baseMaps, overlayMaps).addTo(map);
            
            map.addLayer(gruas);
            map.addLayer(hogar);
            map.addLayer(incidencias);
            
            map.setView([40.41, -3.68], 6);
        </script>

    </body>
</html>
