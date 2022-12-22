<%@	page import="java.sql.*, java.util.* " %>
<%		
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	Statement stmt = null;
try{
	DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
	//conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.137:1521:wsoft","aprwssuser","aprwssuser");
    //conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.67:1521:ORCL","aprwssuser","aprwssuser"); 
    //conn=DriverManager.getConnection("jdbc:oracle:thin:@10.72.4.26:1521:ORCL","aprwssuser","aprwssuser");
    //conn=DriverManager.getConnection("jdbc:oracle:thin:@10.242.51.240:1521:wsoft","aprwssuser","aprwssuser");
    //conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.19.167:1521:orastg","aprwssuser","aprwssuser");
	//conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.83:1521:ORCL","aprwssuser","aprwssuser");
	//conn = DriverManager.getConnection("jdbc:oracle:thin:@10.96.36.23:1521:wsoft", "aprwssuser", "aprwssuser");
	conn=DriverManager.getConnection("jdbc:oracle:thin:@10.72.4.57:1521:ORCL","aprwssuser","aprwssuser"); //Commented on 07-10-2021
	//conn=DriverManager.getConnection("jdbc:oracle:thin:@10.72.4.57:1521:ORCL","aprwssuser","aprwssuser"); //Commented on 30-03-2022
	//conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","aprwssuser","aprwssuser");
   }
catch(Exception e)
{
	System.out.println("EXCEPTION IN CONN3.JSP"+e.getMessage());
}
%>
