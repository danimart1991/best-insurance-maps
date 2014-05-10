package Clases;
/*
 * Clase Incidencias para la utilizacion de la generacion del JSON para BIG DATA
*/

import Controladores.Conexion;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.Iterator;


public class Incidencias {
    private String id_incidencia;
    private String GPS;
   private  String atendido;
    
   
    private Incidencias(String id, String lat,String lon,String estado){
        super();
        this.id_incidencia=id;
        this.atendido=estado;
        this.GPS=lat+"-"+lon;
    }
     public Incidencias(){
     super();
    }
    
    //CONVERTIMOS A JSON    
    public String incidenciasToJSON(){
        Conexion db = new Conexion();
        Gson gson = new Gson(); 
        
        db.abrirConexion();
        ArrayList incidenciasL= new ArrayList<Incidencias>();
        String formatoJSON ;
        //Extraemos las Incidencias de la base de datos 
        //convertimos la lista de Incidencias a formato JSON
        ArrayList<String> datosA = null;
             datosA = (ArrayList<String>)db.datosTodosIncidencias();

              Iterator itA = datosA.iterator();
              while (itA.hasNext()) {
                     String valor = (String) itA.next();
                     String[] formateado = valor.split("/");
                     Incidencias emple = new Incidencias(formateado[0],formateado[2],formateado[3],formateado[1]);
                     incidenciasL.add(emple);
                                        
              }
        formatoJSON = gson.toJson(incidenciasL); 
        System.out.println(formatoJSON);
        return formatoJSON;
    }
}
