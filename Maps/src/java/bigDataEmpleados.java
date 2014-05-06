
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.Iterator;



public class bigDataEmpleados {
    
    Gson gson = new Gson(); 
    Conexion db = new Conexion();
    String id_empleado;
    String profesion;
    String GPS;
    String estado;
    String radio_zona;
    String punto_zona;
    
     ArrayList<bigDataEmpleados> profesional;

 
   
      private bigDataEmpleados(  String id_empleado, String profesion,String lati,String longi,  String estado,String radio_zona,  String latzona,String longzona){
      this.GPS=lati+"-"+longi;
      this.estado=estado;
      this.id_empleado=id_empleado;
      this.profesion=profesion;
      this.punto_zona=latzona+"-"+longzona;
      this.radio_zona=radio_zona;
      
      
      }
     public void generarbigDataEmpleados(){
             ArrayList<String> datosA = null;
             datosA = (ArrayList<String>)db.bigDataTodosProfesionales();

              Iterator itA = datosA.iterator();
              while (itA.hasNext()) {
                     String valor = (String) itA.next();
                     String[] formateado = valor.split("/");
                     bigDataEmpleados emple = new bigDataEmpleados(formateado[0],formateado[4],formateado[2],formateado[3],formateado[1],formateado[5],formateado[6],formateado[7]);
                     this.profesional.add(emple);
              }
    }
    
    //CONVERTIMOS A JSON    
    public String profesionalesToJSON(){
        db.abrirConexion();
        //Extraemos los profesionales de la base de datos 
        this.generarbigDataEmpleados();
        //convertimos la lista de profesionales a formato JSON
        String formatoJSON = gson.toJson(profesional); 
        return formatoJSON;
    }
}
