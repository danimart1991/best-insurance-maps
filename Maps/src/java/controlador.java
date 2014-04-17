
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class controlador extends HttpServlet {

    private Conexion bd;

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
       /*Array con todos los profesionales*/
        ArrayList<String> datosTodosProfesionales = null;
        datosTodosProfesionales = bd.datosTodosProfesionales();
        req.setAttribute("datosTodosProfesionales", datosTodosProfesionales);
       
        /*Array con todas las incidencias*/
        ArrayList<String> datosTodosIncidencias = null;
        datosTodosIncidencias = bd.datosTodosIncidencias();
        req.setAttribute("datosTodosIncidencias", datosTodosIncidencias);
        req.getRequestDispatcher("/index.jsp").forward(req, res);
    }
    
    /*Cierre de la conexion con la bbdd*/
     @Override
    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}
