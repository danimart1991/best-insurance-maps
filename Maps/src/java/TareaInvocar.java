import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import java.util.ArrayList;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class TareaInvocar implements Job {
    API llamadas = new API();
    Gson gson=new Gson();
  //Metodo que se ejecutara cada cierto tiempo que lo programemos despues
  @Override
  public void execute(JobExecutionContext jec) throws JobExecutionException {
      //LLamada a las posiciones de las Gruas
      String JSONGruas= llamadas.excutePostJSON("http://172.29.40.136:8888/mapas");
      java.lang.reflect.Type tipoObjeto = new TypeToken<posiciones>(){}.getType();
      ArrayList<posiciones> grua=gson.fromJson(JSONGruas, tipoObjeto);
      System.out.println("\nJSON A JAVA");
      
      
      String JSONHogar= llamadas.excutePostJSON("http://172.29.40.136:8888/mapas");
      java.lang.reflect.Type tipoObjeto2 = new TypeToken<posiciones>(){}.getType();
      ArrayList<posiciones> hogar=gson.fromJson(JSONHogar, tipoObjeto2);
      System.out.println("\nJSON A JAVA");

  }
  
}
