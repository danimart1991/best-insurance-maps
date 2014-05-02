
public class posiciones {
    String id_empleado;
   String latitud;
    String longitud;
    String numero_trabajos;

    public void posiciones(String id,String prof, String lat,String lon,String rad, String numer){
        Conexion db = new Conexion();
        db.abrirConexion();
        db.ModificasProfesional(id, lat, lon, numer);
        
    }
}
