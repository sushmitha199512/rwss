<%@	page import="java.sql.*, java.util.* " %>
<%		
	Connection conn = null, conn1 = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Statement stmt = null;
    PreparedStatement pstmt1 = null;
	ResultSet rs1 = null;
	Statement stmt1 = null;
try{
	DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
    conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","preduser","preduser");
    conn1=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","preduser","preduser");
   }
catch(Exception e)
{System.out.println("EXCEPTION IN CONN3.JSP TEST :: "+e.getMessage());}
%>
   	<%--
<%@	page import="java.sql.*, java.util.*,javax.sql.*,javax.naming.*" %>
<%	
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	Statement stmt = null;
	DataSource ds = null;

try
{

	InitialContext ctx=new InitialContext();
	ds=(DataSource)ctx.lookup("java:comp/env/jdbc/pred");
	conn=ds.getConnection();
}
catch(Exception e)
{
}	
%>
--%>



	





