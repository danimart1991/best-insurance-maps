package Tarea_Periodica;

/*
 * Tarea que es invocada por Programacion para que sea ejecutada periodicamente.
 * Realizara la llamada y lectura de los JSON de los Profesionales, para el registro 
 * y modificacion de su posicion.
*/
import Controladores.API;
import Clases.Posiciones;
import Clases.Profesionales;
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import java.util.ArrayList;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class TareaInvocar implements Job {
    API llamadas = new API();
    Gson gson=new Gson();
  
//Metodo que se ejecutara cada cierto tiempo
  @Override
  public void execute(JobExecutionContext jec) throws JobExecutionException {
      
      //LLamada a las Posiciones de las Gruas
      String JSONGruas= llamadas.excutePostJSON("http://172.29.40.136:8888/mapas");
      java.lang.reflect.Type tipoObjeto = new TypeToken<Posiciones>(){}.getType();
      //Transformacion del JSON en un array de Posiciones
      ArrayList<Posiciones> grua=gson.fromJson(JSONGruas, tipoObjeto);
     
      
      //LLamada a las Posiciones del Hogar
      String JSONHogar= llamadas.excutePostJSON("http://172.29.40.136:8888/mapas");
      java.lang.reflect.Type tipoObjeto2 = new TypeToken<Posiciones>(){}.getType();
      //Transformacion del JSON en un array de Posiciones
      ArrayList<Posiciones> hogar=gson.fromJson(JSONHogar, tipoObjeto2);
      
      
      //LLamada a los registros de los Profeionales 
      String JSONProfesionalesH= llamadas.excutePostJSON("http://172.29.40.136:8888/mapas");
      java.lang.reflect.Type tipoObjeto3 = new TypeToken<Profesionales>(){}.getType();
      //Transformacion del JSON en un array de Posiciones
      ArrayList<Profesionales> hogarP=gson.fromJson(JSONProfesionalesH, tipoObjeto3);
      
      //LLamada a los registros de las Gruas
      String JSONProfesionalesG= llamadas.excutePostJSON("http://172.29.40.136:8888/mapas");
      java.lang.reflect.Type tipoObjeto4 = new TypeToken<Profesionales>(){}.getType();
      //Transformacion del JSON en un array de Posiciones
      ArrayList<Profesionales> gruaP=gson.fromJson(JSONProfesionalesG, tipoObjeto4);
     

  }
  
}
