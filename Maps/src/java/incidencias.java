
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.Iterator;


public class incidencias {
    String id_incidencia;
    String GPS;
    String atendido;
    Conexion db = new Conexion();
    Gson gson = new Gson(); 
    ArrayList<incidencias> incidenciasL;
    private incidencias(String id, String lat,String lon,String estado){
        db.abrirConexion();
        this.id_incidencia=id;
        this.atendido=estado;
        this.GPS=lat+"-"+lon;
    }
    
    
    //CONVERTIMOS A JSON    
    public String incidenciasToJSON(){
       db.abrirConexion();
        //Extraemos las incidencias de la base de datos 
        //convertimos la lista de incidencias a formato JSON
        ArrayList<String> datosA = null;
             datosA = (ArrayList<String>)db.datosTodosIncidencias();

              Iterator itA = datosA.iterator();
              while (itA.hasNext()) {
                     String valor = (String) itA.next();
                     String[] formateado = valor.split("/");
                     incidencias emple = new incidencias(formateado[0],formateado[2],formateado[3],formateado[1]);
                     this.incidenciasL.add(emple);
              }
        String formatoJSON = gson.toJson(incidenciasL); 
        return formatoJSON;
    }
}
