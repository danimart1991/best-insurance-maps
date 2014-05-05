
import com.google.gson.Gson;
import java.util.ArrayList;


public class profesionales {
    String id_empleado;
    String profesion;
    String latitud;
    String longitud;
    String radio;
    String numero_trabajos;

    public void profesionales(String id,String prof, String lat,String lon,String rad, String numer){
        Conexion db = new Conexion();
        db.abrirConexion();
        db.insertarProfesional(id, prof, lat, lon, rad, numer);
        
    }
    
    
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
