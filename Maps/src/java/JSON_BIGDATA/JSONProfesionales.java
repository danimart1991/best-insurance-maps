package JSON_BIGDATA;

/*
 *Servlet para la generacion del JSON de Profesionales para BIGDATA
 * Direccion  http://localhost:8080/Maps/JSONprofesionales
 */

import Clases.bigDataEmpleados;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns = {"/JSONprofesionales"})
public class JSONProfesionales extends HttpServlet {

//Metodo para obtener los datos de todos los profesionales en formato JSON
    bigDataEmpleados id = new bigDataEmpleados();
    
   //Metodo que devuelve el HTML que muestra el JSON de Profesionales por pantalla
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String json = id.profesionalesToJSON();
        try {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet JSONProfesionales</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println(json);
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    /*
     * Metodos para las peticiones GET y POST, con la ejecucion del metodo anterior, para que
     * saque por pantalla el JSON
    */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
