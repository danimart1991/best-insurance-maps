<%@page import="Controladores.Conexion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mapa - Todos los datos.</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="generico.css" />
        <link rel="stylesheet" href="leaflet.css" />
        <link rel="stylesheet" href="leaflet-routing-machine.css" />
    </head>

    <body>
        <div id="map"></div>

        <script src="leaflet.js"></script>
        <script src="leaflet-routing-machine.js"></script>
        <script>
            // Definimos el mapa y su vista inicial.
            var map = L.map('map').setView([40.41, -3.68], 6);

            // Definimos los iconos de gruas, hogar y clientes.
            var greenCliente = L.icon({// Cliente Atendido
                iconUrl: 'Imagenes/green-pin.png',
                iconSize: [48, 48], // tamaño del icono.
                iconAnchor: [24, 47], // punto del icono == punto localizacion
                popupAnchor: [0, -45]   // punto donde se abrirá el popup
            });
            var redCliente = L.icon({// Cliente NO Atendido
                iconUrl: 'Imagenes/red-pin.png',
                iconSize: [48, 48],
                iconAnchor: [24, 47],
                popupAnchor: [0, -45]
            });
            var greenGrua = L.icon({// Gruas con 0 Tareas
                iconUrl: 'Imagenes/green-grua.png',
                iconSize: [48, 48],
                iconAnchor: [24, 47],
                popupAnchor: [0, -45]
            });
            var blueGrua = L.icon({// Gruas con 1-3 Tareas
                iconUrl: 'Imagenes/blue-grua.png',
                iconSize: [48, 48],
                iconAnchor: [24, 47],
                popupAnchor: [0, -45]
            });
            var redGrua = L.icon({// Gruas con +3 Tareas
                iconUrl: 'Imagenes/red-grua.png',
                iconSize: [48, 48],
                iconAnchor: [24, 47],
                popupAnchor: [0, -45]
            });
            var greenHogar = L.icon({// Hogar con 0 Tareas
                iconUrl: 'Imagenes/green-home.png',
                iconSize: [48, 48],
                iconAnchor: [24, 47],
                popupAnchor: [0, -45]
            });
            var blueHogar = L.icon({// Hogar con 1-3 Tareas
                iconUrl: 'Imagenes/blue-home.png',
                iconSize: [48, 48],
                iconAnchor: [24, 47],
                popupAnchor: [0, -45]
            });
            var redHogar = L.icon({// Hogar con +3 Tareas
                iconUrl: 'Imagenes/red-home.png',
                iconSize: [48, 48],
                iconAnchor: [24, 47],
                popupAnchor: [0, -45]
            });

            // Incluimos las atribuciones en el mapa.
            L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
            }).addTo(map);

            // Definimos los grupos que van a incluir datos
            // Estos servirán para tener mayor control y opciones en el mapa.
            var gruas = L.layerGroup();
            var hogar = L.layerGroup();
            var incidencias = L.layerGroup();

            <%  // Recogemos todos los datos de profesionales de la BBDD.
            Conexion bd = new Conexion();
            bd.abrirConexion();
            ArrayList<String> datosB = null;
            datosB = (ArrayList<String>) bd.datosTodosProfesionales();

            // Recorremos todos y los vamos dibujando.
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
                    gruas.addLayer(L.marker([<%=formateado[2]%>, <%=formateado[3]%>], {icon: iconoProfesional})
                    .bindPopup("<b>Profesional <%=formateado[0]%></b><br />Estado <%=formateado[1]%>."));
                } else {
                    if (<%=Integer.parseInt(formateado[1])%> === 0) iconoProfesional = greenHogar;
                    else if (<%=Integer.parseInt(formateado[1])%> > 3) iconoProfesional = redHogar;
                    else iconoProfesional = blueHogar;
                    hogar.addLayer(L.marker([<%=formateado[2]%>, <%=formateado[3]%>], {icon: iconoProfesional})
                    .bindPopup("<b>Profesional <%=formateado[0]%></b><br />Estado <%=formateado[1]%>."));
                }
                   
            <%
            };

            // Del mismo modo recogemos los datos de Incidencias.
            ArrayList<String> datosC = null;
            datosC = (ArrayList<String>) bd.datosTodosIncidencias();

            // Recorremos el Array para dibujar cada incidencia.
            Iterator itC = datosC.iterator();
            while (itC.hasNext()) {
                String valor = (String) itC.next();
                String[] formateado = valor.split("/");
            %>
                // Incidencia atendida, icono = verde, NO atendida, icono = rojo.
                var iconoIncidencia;
                if (<%=formateado[1].equals("t")%>) iconoIncidencia = greenCliente;
                else iconoIncidencia = redCliente;
                
                incidencias.addLayer(L.marker([<%=formateado[2]%>, <%=formateado[3]%>], {icon: iconoIncidencia})
                .bindPopup("<b>Cliente <%=formateado[0]%> </b><br />Estado <%=formateado[1]%>."));

            <%
                // Si tiene un profesional asignado, dibujamos la ruta entre ambos.
                if (!formateado[4].equals("null")) {
                    String posicProf0 = null;
                    String posicProf1 = null;

                    // Recorremos todos los profesionales buscando el que tiene
                    // asignado para dibujar la ruta.
                    ArrayList<String> datosD = null;
                    datosD = (ArrayList<String>) bd.datosTodosProfesionales();
                    Iterator itD = datosD.iterator();
                    while (itD.hasNext() && posicProf0 == null) {
                        String datos = (String) itD.next();
                        String[] formateado2 = datos.split("/");
                        if (formateado2[0].equals(formateado[4])) {
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
            };
            %>

            // Definimos un control llamado leyenda que informa del significado
            // de los colores de los iconos del mapa.
            var legend = L.control({position: 'bottomleft'});
            legend.onAdd = function() {
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

            // Indicamos al control de capas, cuales son de cada tipo.
            // Existen de tipo radioboxes (baseMaps) y checkboxes (overlayMaps).
            // Por ultimo las añadimos al control de capas.
            var baseMaps = {};
            var overlayMaps = {
                "Gruas": gruas,
                "Hogar": hogar,
                "Incidencias": incidencias
            };
            L.control.layers(baseMaps, overlayMaps).addTo(map);

            // Añadimos los grupos de capas al mapa.
            map.addLayer(gruas);
            map.addLayer(hogar);
            map.addLayer(incidencias);

            // Aunque ya se definio, redefinimos la vista del mapa de nuevo.
            map.setView([40.41, -3.68], 6);
        </script>
    </body>
</html>
