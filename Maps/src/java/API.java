
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
public class API {
 public static String excutePost(String Origen,String Destino){
    URL url;
    HttpURLConnection connection = null;  
    try {
      //Create connection
      url = new URL("http://maps.googleapis.com/maps/api/distancematrix/json?origins="+Origen+"&destinations="+Destino+"&mode=car&language=es-ES&sensor=false");
      connection = (HttpURLConnection)url.openConnection();
      connection.setRequestMethod("POST");
      connection.setRequestProperty("Content-Type", 
           "application/x-www-form-urlencoded");
			

      connection.setRequestProperty("Content-Language", "es-ES");  
			
      connection.setUseCaches (false);
      connection.setDoInput(true);
      connection.setDoOutput(true);

      //Send request
      DataOutputStream wr = new DataOutputStream (
                  connection.getOutputStream ());
     // wr.writeBytes (urlParameters);
      wr.flush ();
      wr.close ();

      //Get Response	
      InputStream is = connection.getInputStream();
      BufferedReader rd = new BufferedReader(new InputStreamReader(is));
      String line;
      StringBuffer response = new StringBuffer(); 
      while((line = rd.readLine()) != null) {
        response.append(line);
        response.append('\r');
      }
      rd.close();
      return response.toString();

    } catch (Exception e) {

      e.printStackTrace();
      return null;

    } finally {

      if(connection != null) {
        connection.disconnect(); 
      }
    }
  }

}

