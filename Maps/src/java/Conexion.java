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

//Metodo que devuelve los profesionales
public ArrayList<String>  posicionTodosProfesionales() {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select id_profesional,ST_X(ST_GeomFromText(ST_AsText(posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(posicionprofesional))) as latitud from \"public\".profesional order by id_profesional");
        while (rs.next()){
            cadena.add(rs.getString("id_profesional")+"/"+rs.getString("latitud")+"/"+rs.getString("longitud"));
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

//Metodo que devuelve las incidencias
public String  datosIncidencia(String cliente) {
    String  cadena= " ";
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select ST_X(ST_GeomFromText(ST_AsText(posicionincidencia))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(posicionincidencia))) as latitud, id_incidencia, atendido from incidencia where id_incidencia ='"+cliente+"'");
        while (rs.next()){
            cadena=rs.getString("latitud")+"/"+rs.getString("longitud")+"/"+rs.getString("id_incidencia")+"/"+rs.getString("atendido");
        }
        rs.close();
        set.close();
        
    }catch(Exception e){
        System.out.println("ERROR: Fallo al sacar posicion Incidencia");
    }
    return cadena;
}

//Metodo que devuelve los profesionales
public ArrayList<String>  datosProfesionalesRapidos(String profesion,String numero) {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select profesional.id_profesional,profesional.profesion,profesional.estado,ST_X(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as latitud ,datosruta.distancia from profesional INNER JOIN datosruta on profesional.id_profesional=datosruta.id_profesional where profesional.profesion='"+profesion+"' order by datosruta.tiempo asc limit "+ numero);
        while (rs.next()){
            cadena.add(rs.getString("id_profesional")+"/"+rs.getString("estado")+"/"+rs.getString("latitud")+"/"+rs.getString("longitud")+"/"+rs.getString("profesion")+"/"+rs.getString("distancia"));
        }
        rs.close();
        set.close();
        
    }catch(Exception e){
        System.out.println("ERROR: Fallo al mostrar los Profesionales mas rapidos");
    }
    return cadena;
}


//Metodo que devuelve los profesionales
public ArrayList<String>  datosProfesionalesCorto(String profesion,String numero) {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select profesional.id_profesional,profesional.profesion,profesional.estado,ST_X(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as latitud, datosruta.tiempo from profesional INNER JOIN datosruta on profesional.id_profesional=datosruta.id_profesional where profesional.profesion='"+profesion+"' order by datosruta.distancia asc limit "+ numero);
        while (rs.next()){
            cadena.add(rs.getString("id_profesional")+"/"+rs.getString("estado")+"/"+rs.getString("latitud")+"/"+rs.getString("longitud")+"/"+rs.getString("profesion")+"/"+rs.getString("tiempo"));
        }
        rs.close();
        set.close();
        
    }catch(Exception e){
        System.out.println("ERROR: Fallo al mostrar los Profesionales mas cercanos");
    }
    return cadena;
}



//Metodo para insertar un nuevo profesor en la base de datos que no tenga un DNIP ya existente
public void insertarDistanciasTiempos(String profesional,String incidencia,String distancia,String tiempo) {
    try {
        set = conexion.createStatement();
        set.executeUpdate("INSERT INTO datosruta (id_profesional,id_incidencia,distancia,tiempo) VALUES ('"+profesional+"','"+incidencia+"',"+distancia+","+tiempo+")");
        set.close();
    }catch(Exception e){
        System.out.println("ERROR: Fallo en la inserccion de los datos de ruta");
    }
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
