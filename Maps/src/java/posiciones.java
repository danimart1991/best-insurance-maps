
import com.google.gson.Gson;
import java.util.ArrayList;


public class posiciones {
    String id_empleado;
   String latitud;
    String longitud;
    String numero_trabajos;

    public void posiciones(String id,String prof, String lat,String lon,String rad, String numer){
        Conexion db = new Conexion();
        db.abrirConexion();
        db.ModificasProfesional(id, lat, lon, numer);
        
    }
    
    //CONVERTIMOS A JSON    
    public String posicionesToJSON(){
        Gson gson = new Gson(); 
        Conexion db = new Conexion();
        db.abrirConexion();
        //Extraemos las posiciones de la base de datos 
        ArrayList<String> posiciones = db.posicionTodosProfesionales();
        //convertimos la lista de posiciones a formato JSON
        String formatoJSON = gson.toJson(posiciones); 
        
        return formatoJSON;
    }
}
