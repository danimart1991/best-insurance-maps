package Clases;

/*
 * Clase Ruta para la utilizacion de la generacion del JSON para BIG DATA
*/

import Controladores.Conexion;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.Iterator;

public class Rutas {
    String id_ruta;
    String inicio;
    String fin;
    String duracion;
    String distancia;

   public Rutas(){
     super();  
   }
   
   private Rutas( int num, String latini, String longini,String latfin,String longfin,  String dur,String dis){
        super();  
         this.id_ruta=Integer.toString(num);
         num++;
         this.inicio=latini+"-"+longini;
         this.fin=latfin+"-"+longfin;
         this.duracion=dur;
         this.distancia=dis;
 
      }
  
    
    //CONVERTIMOS A JSON    
    public String rutasToJSON(){
        
    Gson gson = new Gson(); 
    Conexion db = new Conexion();
        db.abrirConexion();
        
     ArrayList<Rutas> rutasL= new ArrayList<Rutas>();
     
    int num=0;
        //Extraemos los profesionales de la base de datos 
         ArrayList<String> datosA = null;
             datosA = (ArrayList<String>)db.datosBigDataRutas();

              Iterator itA = datosA.iterator();
              while (itA.hasNext()) {
                     String valor = (String) itA.next();
                     String[] formateado = valor.split("/");
                     Rutas emple = new Rutas(num,formateado[0],formateado[1],formateado[2],formateado[3],formateado[5],formateado[4]);
                     num++;
                     rutasL.add(emple);
              }
        //convertimos la lista de profesionales a formato JSON
        String formatoJSON = gson.toJson(rutasL); 
        return formatoJSON;
    }
}
