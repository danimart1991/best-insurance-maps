
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;


public class Conexion {
    public static void main(String[] args){
    /*Variable para almacenar la URL de conexión a nuestra Base de Datos,
     si esta estuviera en otra máquina, necesitariamos estar registrados
     en ella y contar con su IP*/
        String url = "jdbc:postgresql://localhost:5432/serviciomapas";
        try{
            //Acceso al Driver
            Class.forName("org.postgresql.Driver");
            //La conexión con los parámetros necesarios
            Connection con = DriverManager.getConnection( url,"admin","admin");
            //Abrimos la conexión y la iniciamos
            java.sql.Statement stmt = con.createStatement();
            /*Un ResultSet es como en .NET un DataSet, un arreglo temporal donde se
            almacenará el resultado de la consulta SQL*/
            ResultSet rs;
            //Una variable String para almacenar la sentencia SQL
            String query = "select * from incidencia";
            //En el ResultSet guardamos el resultado de ejecutar la consulta
            rs = stmt.executeQuery(query);
            //En un ciclo while recorremos cada fila del resultado de nuestro Select
            while ( rs.next()){
                 /*Aqui practicamente podemos hacer lo que deseemos con el resultado,
                    en mi caso solo lo mande a imprimir*/
               System.out.println("ola");
            }
        //Cerramos la conexión
        stmt.execute("END");
        stmt.close();
        con.close();
        }
catch( Exception e ){
    //Por si ocurre un error
System.out.println(e.getMessage());
e.printStackTrace();
}
}

} 