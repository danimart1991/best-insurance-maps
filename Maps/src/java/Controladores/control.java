package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class control extends HttpServlet {
   private Conexion bd;
    private API api;
    
    @Override
    public void init(ServletConfig cfg) throws ServletException {
        /*
         * Creacion de un objeto del tipo Conexion para la gestion de la base de datos.
         * Iniciacion de la conexion con la base de datos.
         */
        bd = new Conexion();
        bd.abrirConexion();
    }
    
    //Metodo ejecutado siempre que se realiza una llamada para saber si nos encontramos en Todos o Profesionales
     @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
       HttpSession s = req.getSession(true);
         String profesion = (String) req.getParameter("profesion");
         String numero= (String)req.getParameter("NumeroProfesional");
         String lat2= (String) req.getParameter("lat");
         String lon2= (String) req.getParameter("lon");
         String cliente = (String) req.getParameter("id_incidencia");
         String tipo= (String)req.getParameter("TipoProfesional");
         String direccion=(String)req.getParameter("direccion");
        
         if(!bd.existeIncidencia(cliente)){
            bd.insertarIncidencia(cliente, lat2, lon2);
         }
      //Si ha introducido un cliente  
       if(cliente!= null && !cliente.equals("") && !tipo.equals("Ninguno")){  
            /*Latitud y Longitud de la incidencia*/
           String client = bd.datosIncidencia(cliente);
           //Si el cliente existe en la base de datos con un numero de lon y lat
           if(client!= null && !client.equals(" ")){
               req.setAttribute("datosIncidencia", client); 
               String[] formateado = client.split("/");
                
                
                String lat=formateado[0].replace(",",".");
                String lon=formateado[1].replace(",",".");
           
                //Posicion de origen del cliente
                String Origen= lat+","+lon;
                
                bd.eliminarDistanciasTiempos();
                //Aray con todas las posiciones de los profesionales
                ArrayList<String> datosTodosP = null;
                datosTodosP = bd.posicionTodosProfesionales();
                Iterator itC = datosTodosP.iterator();
                while (itC.hasNext()) {
                    String valor = (String) itC.next();
                    String[] format = valor.split("/");
                    
                    String latP=format[1].replace(",",".");
                    String lonP=format[2].replace(",",".");
                    
                    String ruta=api.excutePost(Origen,latP+","+lonP);
                    String[] respuesta = ruta.split(":");
                    String[] distancia=respuesta[7].split("}");
                    String[] tiempo=respuesta[10].split("}");
                    bd.insertarDistanciasTiempos(format[0],formateado[2],distancia[0],tiempo[0]);
                }
                String posicion=formateado[0]+" "+formateado[1];
                /*Array con todos los profesionales*/
                ArrayList<String> datosProfesionalesRapidos = null;
                datosProfesionalesRapidos = bd.datosProfesionalesRapidos(profesion,numero,posicion);
                req.setAttribute("datosProfesionalesRapidos", datosProfesionalesRapidos);
                
                /*Array con todos los profesionales*/
                ArrayList<String> datosProfesionalesCorto = null;
                datosProfesionalesCorto = bd.datosProfesionalesCorto(profesion,numero,posicion);
                req.setAttribute("datosProfesionalesCorto", datosProfesionalesCorto);
                 
           }
       }
        req.getRequestDispatcher("/Profesionales.jsp?id_incidencia="+cliente+"&direccion="+direccion+"&profesion="+profesion+"").forward(req, res);
    }

    /*Cierre de la conexion con la bbdd*/
     @Override
    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}
