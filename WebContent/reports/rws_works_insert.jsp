<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random,java.text.*"%>

												//Works Inserting

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
			con = DriverManager.getConnection("jdbc:odbc:schemePorting21082012",
					"", "");
			System.out.println(" access Connection created");

			int delhiProgramID=0;
	long totalp=0;double bankAmount=0,sca=0,sta=0,plaina=0,value1=0,value2=0,value3=0;

			Statement stmt = con.createStatement();
			Statement stmt1 = con1.createStatement();
			Statement stmt2 = con.createStatement();
			Statement stmt3 = con.createStatement();
			Statement stmt4 = con.createStatement();
			Statement stmt5 = con.createStatement();

//public static final String NRDWP_RELATED = "01,02,18,23,32,48,49,51,53,58,59,60";
//create table  temp_works(work_id varchar2(14));

			String aQ = "select work_id  from SchemeMPR";
			String dQ = "";

             rs=stmt.executeQuery(aQ);

           while(rs.next()){
rcount++;
				String work_id=rs.getString(1);

                dQ="insert into temp_works values('"+work_id+"')";
				stmt1.executeUpdate(dQ);


		}    
      			System.out.println("No Of Works Inserted"+rcount);

		} catch (Exception e) {
			//System.out.println("Final Query:" + insertQuery);
			e.printStackTrace();

		}
%>