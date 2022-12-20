<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table border="1" align="center" class="table table-striped table-bordered" id="dataTables-example" style="font-size: 14px; color:#0F2A3E ">
   <tr ><TD colspan=6 align = center >MID DAY MEAL SCHEME"</TD></TR>
    <tr>
    <th>School Code</th><th>Class</th><th>No.of Students Attendance</th><th>No.of Students Meals taken</th><th>Mobile</th><th>Received Date</th>
</tr>


<%

    
    Connection con = null;
    PreparedStatement ps = null;

    String result = "",schoolcode="",
classtype="",attendance="",mealstaken="",mobile="",cudate="";

    try {
     

        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
 //conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.137:1521:orcl","aprwssuser","aprwssuser");
 con=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","aprwssuser","aprwssuser");

        ps = con.prepareStatement("select schoolcode,classtype,attendance,mealstaken,mobile,to_char(createddate,'DD-Mon-YY')  from middaymeal");

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
          schoolcode =  rs.getString("schoolcode");
          classtype=rs.getString("classtype");
          attendance=rs.getString("attendance");
          mealstaken=rs.getString("mealstaken");
          mobile=rs.getString("mobile");
          cudate=rs.getString(6);
                 


out.println("<tr><td>"+schoolcode+"</td>");
out.println("<td>"+classtype+"</td>");
out.println("<td>"+attendance+"</td>");
out.println("<td>"+mealstaken+"</td>");


out.println("<td>"+mobile+"</td>");

out.println("<td>"+cudate+"</td></tr>");
 }

   
    } catch (Exception ex) {
        System.out.println(ex);
    } finally {
       con.close();
    }

%>


</table>
