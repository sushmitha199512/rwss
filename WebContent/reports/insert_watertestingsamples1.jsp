<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random,java.text.*"%>
<%System.out.println("insert_watertestingsamples1.jsp");%>
<%!  ResultSet rs=null,rs1=null,rs2=null; Connection con=null,con1=null; 
%>
<%
String LAStatus="";
String CAStatus="";
String mainreason="";
String test_id="";
String genid="";

%>
<BODY >


<%
try{
	int rcount=0;
	
	String empty="";
	int contaminated=0,rowcount=0;


 Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	con = DriverManager.getConnection("jdbc:odbc:WqLabPorting10092012","","");
	System.out.println(" access Connection created");

Statement stmt=con.createStatement();		
Statement stmt1=con.createStatement();
String Query1 = "SELECT DISTINCT RWS_WATER_SAMPLE_COLLECT_TBL.HAB_CODE, RWS_WATER_SAMPLE_COLLECT_TBL.TEST_ID, IMISMASTERDATA1.HabitationId, IMISMASTERDATA1.DistrictId, RWS_WQ_TEST_RESULTS_TBL.FORWARDED_ON, [wslab-ddwslab].LabId, RWS_WATER_SAMPLE_COLLECT_TBL.testcode FROM WQM_WaterQualityTesting INNER JOIN ((IMISMASTERDATA1 INNER JOIN (RWS_WATER_SAMPLE_COLLECT_TBL INNER JOIN RWS_WQ_TEST_RESULTS_TBL ON RWS_WATER_SAMPLE_COLLECT_TBL.TEST_ID = RWS_WQ_TEST_RESULTS_TBL.TEST_ID) ON IMISMASTERDATA1.habcode = RWS_WATER_SAMPLE_COLLECT_TBL.HAB_CODE) INNER JOIN [wslab-ddwslab] ON RWS_WQ_TEST_RESULTS_TBL.LAB_CODE = [wslab-ddwslab].LAB_CODE) ON WQM_WaterQualityTesting.source_code = RWS_WATER_SAMPLE_COLLECT_TBL.SOURCE_CODE";


Query1 = "SELECT DISTINCT RWS_WQ_TEST_RESULTS_TBL.FORWARDED_ON, [wslab-ddwslab].DDWS_LABID, WQM_WaterQualityTesting.TestId,WQM_WaterQualityTesting.TestCode,RWS_WQ_TEST_RESULTS_TBL.LAB_CODE FROM WQM_WaterQualityTesting INNER JOIN (RWS_WQ_TEST_RESULTS_TBL INNER JOIN [wslab-ddwslab] ON RWS_WQ_TEST_RESULTS_TBL.LAB_CODE = [wslab-ddwslab].LAB_CODE) ON WQM_WaterQualityTesting.TestCode = RWS_WQ_TEST_RESULTS_TBL.TEST_ID";
Statement neww=con.createStatement();		
System.out.println("query1wwwww:"+Query1);
rs1 = neww.executeQuery(Query1);


System.out.println("result set rs"+rs1);
String sno = "";
String testid = "";
while(rs1.next())
{
//2012-07-25 00:00:00
	String Query="insert into WQM_WaterTestingSamples(TestId,TestingDate,LabId,Sample,AP_LABID) values ('"+rs1.getString(3)+"','"+rs1.getString(1)+"','"+rs1.getString(2)+"','"+rs1.getString(4)+"','"+rs1.getString(5)+"')";
        System.out.println("Query"+Query);
		rowcount += stmt1.executeUpdate(Query);
}
System.out.println("inserted rows"+rowcount);
}
catch(Exception e){
e.printStackTrace();
}
%>
