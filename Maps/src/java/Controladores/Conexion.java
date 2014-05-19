package Controladores;

import java.sql.*;
import java.util.ArrayList;
/*
* Clase para controlar los datos de la base de datos
* En el se codifican todas las sentencias SQL necesarias para el acceso, modificacion, creacion y eliminacion de datos en la base de datos
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


//Metodo que devuelve los profesionales para mostrarlos en Todos
public ArrayList<String>  datosTodosProfesionales() {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select id_profesional,profesion,estado,ST_X(ST_GeomFromText(ST_AsText(posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(posicionprofesional))) as latitud from profesional ");
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

//Metodo que devuelve los profesionales para la generacion de los JSON de Big Data
public ArrayList<String>  bigDataTodosProfesionales() {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select id_profesional,profesion,estado,ST_X(ST_GeomFromText(ST_AsText(posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(posicionprofesional))) as latitud,radio_zona,ST_X(ST_GeomFromText(ST_AsText(zona))) as longitudzona, ST_Y(ST_GeomFromText(ST_AsText(zona))) as latitudzona  from profesional");
        while (rs.next()){
            cadena.add(rs.getString("id_profesional")+"/"+rs.getString("estado")+"/"+rs.getString("latitud")+"/"+rs.getString("longitud")+"/"+rs.getString("profesion")+"/"+rs.getString("radio_zona")+"/"+rs.getString("latitudzona")+"/"+rs.getString("longitudzona"));
        }
        rs.close();
        set.close();
        
    }catch(Exception e){
        System.out.println("ERROR: Fallo al mostrar los Profesionales");
    }
    return cadena;
}

//Metodo que devuelve las posiciones de todos profesionales
public ArrayList<String>  posicionTodosProfesionales() {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select id_profesional,ST_X(ST_GeomFromText(ST_AsText(posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(posicionprofesional))) as latitud from profesional where ST_X(ST_GeomFromText(ST_AsText(posicionprofesional)))!=0 and ST_Y(ST_GeomFromText(ST_AsText(posicionprofesional)))!=0 order by id_profesional");
        while (rs.next()){
            cadena.add(rs.getString("id_profesional")+"/"+rs.getString("latitud")+"/"+rs.getString("longitud"));
        }
        rs.close();
        set.close();
        
    }catch(Exception e){
        System.out.println("ERROR: Fallo al mostrar las Posiciones de Profesionales");
    }
    return cadena;
}


//Metodo que devuelve las incidencias para mostrarlos en Todos
public ArrayList<String>  datosTodosIncidencias() {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select id_profesional ,id_incidencia,atendido,ST_X(ST_GeomFromText(ST_AsText(posicionincidencia))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(posicionincidencia))) as latitud from incidencia");
        while (rs.next()){
            cadena.add(rs.getString("id_incidencia")+"/"+rs.getString("atendido")+"/"+rs.getString("latitud")+"/"+rs.getString("longitud")+"/"+rs.getString("id_profesional"));
        }
        rs.close();
        set.close();
        
    }catch(Exception e){
        System.out.println("ERROR: Fallo al mostrar las Incidencias");
    }
    return cadena;
}

//Metodo que devuelve una incidencia
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

//Metodo que devuelve las posiciones de profesionales e Incidencias para calcular las rutas
public String  posicionesIncdProfe(String profesion,String inc) {
     String cadena= " ";
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select ST_X(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as latitud ,ST_X(ST_GeomFromText(ST_AsText(incidencia.posicionincidencia))) as longitudid, ST_Y(ST_GeomFromText(ST_AsText(incidencia.posicionincidencia))) as latitudid from profesional INNER JOIN incidencia on profesional.id_profesional=incidencia.id_profesional");
        while (rs.next()){
            cadena=(rs.getString("latitud")+"/"+rs.getString("longitud")+"/"+rs.getString("latitudid")+"/"+rs.getString("longitudid"));
        }
        rs.close();
        set.close();
        
    }catch(Exception e){
        System.out.println("ERROR: Fallo al mostrar los Profesionales e Incidencias");
    }
    return cadena;
}


//Metodo que devuelve los profesionales mas rapidos
public ArrayList<String>  datosProfesionalesRapidos(String profesion,String numero,String posicion) {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select profesional.id_profesional,profesional.profesion,profesional.estado,ST_X(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as latitud ,datosruta.distancia from profesional INNER JOIN datosruta on profesional.id_profesional=datosruta.id_profesional where profesional.profesion='"+profesion+"' and ST_X(ST_GeomFromText(ST_AsText(profesional.posicionprofesional)))!=0 and ST_Y(ST_GeomFromText(ST_AsText(profesional.posicionprofesional)))!=0  and ST_distance((select posicionincidencia from incidencia where id_incidencia=datosruta.id_incidencia),profesional.posicionprofesional)>profesional.radio_zona order by datosruta.tiempo asc limit "+ numero);
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


//Metodo que devuelve los profesionales mas cercanos
public ArrayList<String>  datosProfesionalesCorto(String profesion,String numero, String posicion) {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select profesional.id_profesional,profesional.profesion,profesional.estado,ST_X(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as latitud, datosruta.tiempo from profesional INNER JOIN datosruta on profesional.id_profesional=datosruta.id_profesional where profesional.profesion='"+profesion+"' and where ST_X(ST_GeomFromText(ST_AsText(profesional.posicionprofesional)))!=0 and ST_Y(ST_GeomFromText(ST_AsText(profesional.posicionprofesional)))!=0 and ST_distance((select posicionincidencia from incidencia where id_incidencia=datosruta.id_incidencia),profesional.posicionprofesional)>profesional.radio_zona order by datosruta.distancia asc limit "+ numero);
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



//Metodo que devuelve las rutas para la generacion de los JSON de Big Data
public ArrayList<String>  datosBigDataRutas() {
     ArrayList<String>  cadena= new ArrayList<String>();
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("select ST_X(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as longitud, ST_Y(ST_GeomFromText(ST_AsText(profesional.posicionprofesional))) as latitud, ST_X(ST_GeomFromText(ST_AsText(incidencia.posicionincidencia))) as longitudfin, ST_Y(ST_GeomFromText(ST_AsText(incidencia.posicionincidencia))) as latitudfin,datosruta.tiempo, datosruta.distancia from profesional INNER JOIN datosruta on profesional.id_profesional=datosruta.id_profesional   INNER JOIN incidencia on incidencia.id_incidencia=datosruta.id_incidencia ");
        while (rs.next()){
            cadena.add(rs.getString("latitud")+"/"+rs.getString("longitud")+"/"+rs.getString("latitudfin")+"/"+rs.getString("longitudfin")+"/"+rs.getString("distancia")+"/"+rs.getString("tiempo"));
        }
        rs.close();
        set.close();
        
    }catch(Exception e){
        System.out.println("ERROR: Fallo al sacar las rutas");
    }
    return cadena;
}


// Metodo para la insercion de los datos de una nueva ruta
public void insertarDistanciasTiempos(String profesional,String incidencia,String distancia,String tiempo) {
    try {
        set = conexion.createStatement();
        set.executeUpdate("INSERT INTO datosruta (id_profesional,id_incidencia,distancia,tiempo) VALUES ('"+profesional+"','"+incidencia+"',"+distancia+","+tiempo+")");
        set.close();
    }catch(Exception e){
        System.out.println("ERROR: Fallo en la inserccion de los datos de ruta");
    }
}

//Metodo para la insercion de una nueva incidencia
public void insertarIncidencia(String incid,String lati,String longi) {
    try {
        set = conexion.createStatement();
        set.executeUpdate("insert into incidencia (id_incidencia,atendido,posicionincidencia)values('"+incid+"','f',ST_GeographyFromText('POINT('||'"+longi+"'||' '||'"+lati+"'||')'))" );
        set.close();
    }catch(Exception e){
        System.out.println("ERROR: Fallo en la inserccion de la incidencia");
    }
}

// Metodo para la modificacion de una incidecia que ya tiene un profesional
public void ModificasIncidencia(String incid,String prof) {
      try{
        set = conexion.createStatement();
        set.executeUpdate("UPDATE incidencia SET id_profesional='"+prof+"',atendido='t' WHERE id_incidencia ='"+incid+"'");
        set.close();
    }catch(Exception e){
        System.out.println("ERROR: Fallo en la modificacion de la incidencia");
    }
}

//Metodo para la insercion de un nuevo profesional
public void insertarProfesional(String prof,String tipo,String lati,String longi,String radio,String num) {
    try {
        set = conexion.createStatement();
        set.executeUpdate("insert into profesional (id_profesional,profesion,estado,radio_zona,zona,posicionprofesional)values('"+prof+"','"+tipo+"',"+num+","+radio+",ST_GeographyFromText('POINT('||'"+longi+"'||' '||'"+lati+"'||')'),ST_GeographyFromText('POINT(0 0)'))" );
        set.close();
    }catch(Exception e){
        System.out.println("ERROR: Fallo en la inserccion del profesional");
    }
}

//Metodo para la modificacion de las posiciones del profesional
public void ModificasProfesional(String prof,String lat,String lon,String num) {
      try{
        set = conexion.createStatement();
        set.executeUpdate("UPDATE profesional SET estado="+num+",posicionprofesional=ST_GeographyFromText('POINT('||'"+lon+"'||' '||'"+lat+"'||')') WHERE id_profesional ='"+prof+"'");
        set.close();
    }catch(Exception e){
        System.out.println("ERROR: Fallo en la modificacion del Profesional");
    }
}

//Metodo para saber si una incidencia existe y a de ser modificada y no insertada
public boolean existeIncidencia(String id) {
    boolean existe = false;
    String cadena;
    try{
        set = conexion.createStatement();
        rs = set.executeQuery("SELECT * FROM incidencia");
        while (rs.next()){
          cadena =rs.getString("id_incidencia");
            if (cadena.equals(id)){
                return true;//La matricula existe en la base de datos
            }
        }
        rs.close();
        set.close();
    }catch(Exception e){
        System.out.println("No lee de la tabla incidencia para la comprobacion de la existencia");
    }
return(existe);
}

//Metodo para borrar los datos de la tabla datosruta
public void eliminarDistanciasTiempos() {
    try{
        set = conexion.createStatement();
        set.executeUpdate("Delete from datosruta");
        set.close();
    }catch(Exception e){
        System.out.println("ERROR: Fallo en la eliminacion de los datos de Datos Ruta");
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
