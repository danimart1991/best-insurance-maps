package Clases;

import Controladores.Conexion;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.Iterator;

/*
 * Clase Profesionales para la utilizacion de la generacion del JSON para BIG DATA
*/

public class bigDataEmpleados {
   
    String id_empleado;
    String GPS;
    String estado;
    String profesion;
    String punto_zona;
    String radio_zona;
    
    public bigDataEmpleados(){
         super();
    } 
      private bigDataEmpleados(  String id_empleado, String profesion,String lati,String longi,  String estado,String radio_zona,  String latzona,String longzona){
      super();
      this.GPS=lati+"-"+longi;
      this.estado=estado;
      this.id_empleado=id_empleado;
      this.profesion=profesion;
      this.punto_zona=latzona+"-"+longzona;
      this.radio_zona=radio_zona;
      
      
      }
    
    
    //CONVERTIMOS A JSON    
    public String profesionalesToJSON(){
         Gson gson = new Gson(); 
            Conexion db = new Conexion();
            db.abrirConexion();
            ArrayList<bigDataEmpleados> profesional=new ArrayList<bigDataEmpleados>();    
         
            ArrayList<String> datosA = null;
             datosA = (ArrayList<String>)db.bigDataTodosProfesionales();

              Iterator itA = datosA.iterator();
              while (itA.hasNext()) {
                     String valor = (String) itA.next();
                     String[] formateado = valor.split("/");
                     bigDataEmpleados emple = new bigDataEmpleados(formateado[0],formateado[4],formateado[2],formateado[3],formateado[1],formateado[5],formateado[6],formateado[7]);
                     profesional.add(emple);
              }
        //convertimos la lista de profesionales a formato JSON
        String formatoJSON = gson.toJson(profesional); 
        return formatoJSON;
    }
}
