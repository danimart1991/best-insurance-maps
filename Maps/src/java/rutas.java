
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.Iterator;

public class rutas {
    Gson gson = new Gson(); 
    Conexion db = new Conexion();
    String inicio;
    String fin;
    String duracion;
    String distancia;
    String id_ruta;
    int num=0;
     ArrayList<rutas> rutasL;

 
   
      private rutas(  String latini, String longini,String latfin,String longfin,  String dur,String dis){
      this.id_ruta=Integer.toString(num);
      num++;
      this.inicio=latini+"-"+longini;
      this.fin=latfin+"-"+longfin;
      this.duracion=dur;
      this.distancia=dis;
      
      
      }
  
    
    //CONVERTIMOS A JSON    
    public String rutasToJSON(){
        db.abrirConexion();
        //Extraemos los profesionales de la base de datos 
         ArrayList<String> datosA = null;
             datosA = (ArrayList<String>)db.datosBigDataRutas();

              Iterator itA = datosA.iterator();
              while (itA.hasNext()) {
                     String valor = (String) itA.next();
                     String[] formateado = valor.split("/");
                     rutas emple = new rutas(formateado[0],formateado[1],formateado[2],formateado[3],formateado[5],formateado[4]);
                     this.rutasL.add(emple);
              }
        //convertimos la lista de profesionales a formato JSON
        String formatoJSON = gson.toJson(rutasL); 
        return formatoJSON;
    }
}
