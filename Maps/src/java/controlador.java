
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class controlador extends HttpServlet {

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
    
    
     @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
       /*Nos mostrara Todos los clientes y profesionales*/
         if (req.getParameter("tipo").toString().equals("Todos")) {
            Todos(req, res);
        }
        if (req.getParameter("tipo").toString().equals("Profesional")) {
            Profesional(req, res);
        }
        req.getRequestDispatcher("/index.jsp").forward(req, res);
    }
    
    
     //Todos
    public void Todos(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

       /*Array con todos los profesionales*/
        ArrayList<String> datosTodosProfesionales = null;
        datosTodosProfesionales = bd.datosTodosProfesionales();
        req.setAttribute("datosTodosProfesionales", datosTodosProfesionales);
       
        /*Array con todas las incidencias*/
        ArrayList<String> datosTodosIncidencias = null;
        datosTodosIncidencias = bd.datosTodosIncidencias();
        req.setAttribute("datosTodosIncidencias", datosTodosIncidencias);
    }
    
    
    
    public void Profesional(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

         HttpSession s = req.getSession(true);
         String cliente = (String) req.getParameter("cliente");
         String profesion = (String) req.getParameter("profesion");
         String numero= (String)req.getParameter("NumeroProfesional");
         req.setAttribute("cliente", cliente);
         req.setAttribute("profesion", profesion);
         req.setAttribute("TipoProfesional", req.getParameter("TipoProfesional"));
         req.setAttribute("NumeroProfesional", req.getParameter("NumeroProfesional"));

       
      //Si ha introducido un cliente  
       if(cliente!= null && !cliente.equals("") && !req.getParameter("TipoProfesional").toString().equals("Ninguno")){  
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
                
                /*Array con todos los profesionales*/
                ArrayList<String> datosProfesionalesRapidos = null;
                datosProfesionalesRapidos = bd.datosProfesionalesRapidos(profesion,numero);
                req.setAttribute("datosProfesionalesRapidos", datosProfesionalesRapidos);
                
                /*Array con todos los profesionales*/
                ArrayList<String> datosProfesionalesCorto = null;
                datosProfesionalesCorto = bd.datosProfesionalesCorto(profesion,numero);
                req.setAttribute("datosProfesionalesCorto", datosProfesionalesCorto);
                 
           }
       }
    }
    
    /*Cierre de la conexion con la bbdd*/
     @Override
    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}
