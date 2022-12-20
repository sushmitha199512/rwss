<%@	page import="java.sql.*" %>
<%		
	Connection conn = null, conn1 = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	Statement stmt = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
    conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","preduser","preduser");
	
    		%>
   	


	





