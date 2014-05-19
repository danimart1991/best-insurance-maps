<%@page import="Controladores.Conexion"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page contentType="text/html" %>
<%
    Enumeration paramNames = request.getParameterNames();
    String json = (String)paramNames.nextElement();
    JSONParser parser = new JSONParser();
    Object obj=parser.parse(json);
    Conexion con = new Conexion();
    JSONArray array=(JSONArray)obj;
    for(int i=0;i<array.size();i++){
        JSONObject elem=(JSONObject)array.get(i);
        String prof = (String) elem.get("id_empleado");
        String lati = (String) elem.get("latitud");
        String longi = (String) elem.get("longitud");
        String num = (String) elem.get("numero_trabajos");
        //con.insertarProfesional(prof,tipo,lati,longi,radio,num);
    }      
%>