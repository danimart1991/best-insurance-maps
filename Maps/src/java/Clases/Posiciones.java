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

    public Posiciones(String id, String lat,String lon, String numer){
        super();
        id_empleado = id;
        Conexion db = new Conexion();
        db.abrirConexion();
        db.ModificasProfesional(id, lat, lon, numer);
        
    }
    
    public String getCaca() {
        return id_empleado;
    }
}
