import java.sql.*;
import java.util.ArrayList;
/*
* Clase para controlar los datos de la base de datos
* En el se codifican todas las sentencias SQL necesarias para el acceso, modificacion, creacion y eliminacion de datos en la base de datos Access
*/

public class Conexion {
     /*Definicion de las variables necesarias en dicha clase*/
    private Connection conexion;// Variables de conexion
    
     //Variables para la ejecucion de las consultas SQL
    private Statement set;
    private ResultSet rs;
    
     /*
 *Metodo para la inicializacion de la conexion con la base de datos   
 */
public void abrirConexion() {
    /*Variable para almacenar la URL de conexión a nuestra Base de Datos,
     si esta estuviera en otra máquina, necesitariamos estar registrados
     en ella y contar con su IP*/
    String url = "jdbc:postgresql://localhost:5432/mapas";
    try{
         //Acceso al Driver
         Class.forName("org.postgresql.Driver");
         //La conexión con los parámetros necesarios
         conexion = DriverManager.getConnection( url,"admin","admin");
         System.out.println("Se ha conectado");
    }catch(Exception e){
        System.out.println("No se ha podido conectar a la base de datos");
    }
}


//Metodo que devuelve los profesionales
public ArrayList<String>  datosTodosProfesionales() {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select id_profesional,profesion,estado,ST_X(ST_GeomFromText(ST_AsText(posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(posicionprofesional))) as latitud from \"public\".profesional");
        while (rs.next()){
            cadena.add(rs.getString("id_profesional")+"/"+rs.getString("estado")+"/"+rs.getString("latitud")+"/"+rs.getString("longitud")+"/"+rs.getString("profesion"));
        }
        rs.close();
        set.close();
        
    }catch(Exception e){
        System.out.println("ERROR: Fallo al mostrar los Profesionales");
    }
    return cadena;
}

//Metodo que devuelve las incidencias
public ArrayList<String>  datosTodosIncidencias() {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select id_incidencia,atendido,ST_X(ST_GeomFromText(ST_AsText(posicionincidencia))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(posicionincidencia))) as latitud from incidencia");
        while (rs.next()){
            cadena.add(rs.getString("id_incidencia")+"/"+rs.getString("atendido")+"/"+rs.getString("latitud")+"/"+rs.getString("longitud"));
        }
        rs.close();
        set.close();
        
    }catch(Exception e){
        System.out.println("ERROR: Fallo al mostrar los Profesionales");
    }
    return cadena;
}

/*
*Cierre de la conexion con la base de datos, cuando cerramos la aplicacion
*/
public void cerrarConexion() {
    try {
        conexion.close();
    } catch (Exception e){}
}
   

} 
