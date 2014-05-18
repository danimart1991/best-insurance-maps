
package Servicios;

import Clases.Posiciones;
import Clases.Profesionales;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.reflect.TypeToken;
import java.util.ArrayList;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;


@WebService(serviceName = "ServicioMapas")
public class Servicio {
    Gson gson=new Gson();
    /**
     * Web service operation
     */
    @WebMethod(operationName = "posiciones")
    public String datos(@WebParam(name = "JSONs") JsonArray JSONs) {
        java.lang.reflect.Type tipoObjeto = new TypeToken<Posiciones>(){}.getType();
      //Transformacion del JSON en un array de Posiciones
      ArrayList<Posiciones> grua=gson.fromJson(JSONs, tipoObjeto);
        return null;
    }
    
      /**
     * Web service operation
     */
    @WebMethod(operationName = "profesionales")
    public String profesionales(@WebParam(name = "JSONs") JsonArray JSONs) {
         java.lang.reflect.Type tipoObjeto3 = new TypeToken<Profesionales>(){}.getType();
         //Transformacion del JSON en un array de Posiciones
        ArrayList<Profesionales> hogarP=gson.fromJson(JSONs, tipoObjeto3);
        return null;
    }
}
