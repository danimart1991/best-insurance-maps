
public class profesionales {
   String id_empleado;
   String profesion;
   String latitud;
    String longitud;
    String radio;
    String numero_trabajos;

    public void profesionales(String id,String prof, String lat,String lon,String rad, String numer){
        Conexion db = new Conexion();
        db.abrirConexion();
        db.insertarProfesional(id, prof, lat, lon, rad, numer);
        
    }
}
