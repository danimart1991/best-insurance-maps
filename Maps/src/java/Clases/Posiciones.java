package Clases;
/*
 * Clase para la modificacion de las posiciones de los empleados cuando
 * leamos los JSON de Gruas y Hogar, con el cambio de su posicion periodico
*/

import Controladores.Conexion;

public class Posiciones {
    String id_empleado;
    String latitud;
    String longitud;
    String numero_trabajos;

    public Posiciones(String id,String prof, String lat,String lon,String rad, String numer){
        super();
        Conexion db = new Conexion();
        db.abrirConexion();
        db.ModificasProfesional(id, lat, lon, numer);
        
    }
}
