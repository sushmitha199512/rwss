<%@	page import="java.sql.Connection"%>
<%@	page import="java.sql.DriverManager"%>
<%@	page import="java.sql.PreparedStatement"%>
<%@	page import="java.sql.Statement"%>
<%@	page import="java.sql.ResultSet"%>
<%@	page import="java.sql.SQLException"%>
<%@	page import="java.util.Date"%>
<%	
    java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	Connection con=null;
	PreparedStatement ps = null,ps1=null;
	ResultSet rs=null,rs1=null;
    String sqlquery=null,sqlquery1=null,dcode=null,mcode=null,pcode=null,vcode=null,prcode=null,distcode=null,bvalue=null,cvalue=null,svalue=null,nvalue=null,dvalue=null,wvalue=null,value=null;
    int srlno=0,total=0,wtotal=0,ntotal=0,stotal=0,dtotal=0,ctotal=0,qaffected=0,tflouride=0,tbrakish=0,
    tiron=0;
    try
	{
	
    Class.forName("oracle.jdbc.driver.OracleDriver");
    con = DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","preduser","preduser");
    }
	catch(SQLException e)
	{
     //System.out.println("Exception is"+e);
	}
 
 %>


