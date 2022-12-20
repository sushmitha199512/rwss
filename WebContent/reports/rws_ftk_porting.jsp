<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random,java.text.*"%>

												//FTK PORTING

<% 


ResultSet rs = null, rs1 = null, rs2 = null,rs3=null,rs4=null,rs5=null,rs6=null;

	Connection con = null, con1 = null;
	String LAStatus = "";
		String CAStatus = "";
		String mainreason = "";
		String test_id = "";
		String genid = "";

		%>
<BODY>


<%String Query = "";
		String insertQuery = "";
		int notfoundcount = 0;
		try {
			int rcount = 0;

			String empty = "";
			int contaminated = 0, rowcount = 0;
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con1 = DriverManager.getConnection(
					"jdbc:oracle:thin:@10.160.2.209:1521:wsoft", "preduser",
					"preduser");
			System.out.println("Connection created");

			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			con = DriverManager.getConnection("jdbc:odbc:schemeExpenditure30072012",
					"", "");
			System.out.println(" access Connection created");

			int delhiProgramID=0;
	long totalp=0;double bankAmount=0,sca=0,sta=0,plaina=0,value1=0,value2=0,value3=0;

			Statement stmt = con.createStatement();
			Statement stmt1 = con.createStatement();
			Statement stmt2 = con.createStatement();
			Statement stmt3 = con.createStatement();
			Statement stmt4 = con.createStatement();
			Statement stmt5 = con.createStatement();
				String query="";
			rs1 = stmt.executeQuery(query);
		   System.out.println("StaRTING Process");
               while(rs1.next())
				{

			
   }
			String sno = "";
		} catch (Exception e) {
			//System.out.println("Final Query:" + insertQuery);
			e.printStackTrace();

		}
%>