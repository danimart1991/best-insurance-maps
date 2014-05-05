
import com.google.gson.Gson;
import java.util.ArrayList;


public class incidencias {
    String id_incidencia;
    String latitud;
    String longitud;

    public void incidencias(String id, String lat,String lon){
        Conexion db = new Conexion();
        db.abrirConexion();
        db.insertarIncidencia(id, lat, long);
        
    }
    
    
    //CONVERTIMOS A JSON    
    public String incidenciasToJSON(){
        Gson gson = new Gson(); 
        Conexion db = new Conexion();
        db.abrirConexion();
        //Extraemos las incidencias de la base de datos 
        ArrayList<String> incidencias = db.datosTodosIncidencias();
        //convertimos la lista de incidencias a formato JSON
        String formatoJSON = gson.toJson(incidencias); 
        
        return formatoJSON;
    }
}
