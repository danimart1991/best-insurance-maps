
import com.google.gson.Gson;
import java.util.ArrayList;



public class bigDataEmpleados {
    
    //CONVERTIMOS A JSON    
    public String profesionalesToJSON(){
        Gson gson = new Gson(); 
        Conexion db = new Conexion();
        db.abrirConexion();
        //Extraemos los profesionales de la base de datos 
        ArrayList<String> profesional = db.datosTodosProfesionales();
        //convertimos la lista de profesionales a formato JSON
        String formatoJSON = gson.toJson(profesional); 
        
        return formatoJSON;
    }
}
