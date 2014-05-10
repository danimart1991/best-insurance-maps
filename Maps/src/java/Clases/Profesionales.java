package Clases;
/*
 * Clase para la insercion de los empleados cuando
 * leamos los JSON de Gruas y Hogar, cuando se registren en su aplicacion
*/

import Controladores.Conexion;

public class Profesionales {
    String id_empleado;
    String profesion;
    String latitud;
    String longitud;
    String radio;
    String numero_trabajos;

    public Profesionales(String id,String prof, String lat,String lon,String rad, String numer){
        super();
        Conexion db = new Conexion();
        db.abrirConexion();
        db.insertarProfesional(id, prof, lat, lon, rad, numer);
        
    }
 }
