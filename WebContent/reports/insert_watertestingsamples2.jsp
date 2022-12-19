<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random,java.text.*"%>
<%System.out.println("insert_watertestingsamples2.jsp");%>
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
String Query = "";
try{
	int rcount=0;
	
	String empty="";
	int contaminated=0,rowcount=0;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con1 = DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.209:1521:wsoft","preduser","preduser");
	System.out.println("Connection created");

	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	con = DriverManager.getConnection("jdbc:odbc:WqLabPorting10092012","","");
	System.out.println(" access Connection created");

Statement stmt=con.createStatement();		
Statement stmt1=con.createStatement();
String Query1 = "SELECT [3842].testcode, WQQualityParameter.ParameterId, RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE FROM WQQualityParameter INNER JOIN (3842 INNER JOIN RWS_WQ_TEST_RESULTS_LNK_TBL ON [3842].TEST_ID = RWS_WQ_TEST_RESULTS_LNK_TBL.TEST_ID) ON WQQualityParameter.pcode = RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_CODE WHERE (((RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE) Is Not Null))";

Query1="SELECT WQM_WaterQualityTesting.TestId, WQQualityParameter.ParameterId, RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE FROM WQQualityParameter INNER JOIN (WQM_WaterQualityTesting INNER JOIN RWS_WQ_TEST_RESULTS_LNK_TBL ON WQM_WaterQualityTesting.Test_Code = RWS_WQ_TEST_RESULTS_LNK_TBL.TEST_ID) ON WQQualityParameter.pcode = RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_CODE WHERE (((RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE) Is Not Null))";

//Query1 = "SELECT WQM_WaterQualityTesting.TestId, WQQualityParameter.ParameterId, RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE FROM (WQQualityParameter INNER JOIN RWS_WQ_TEST_RESULTS_LNK_TBL ON WQQualityParameter.pcode = RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_CODE) INNER JOIN WQM_WaterQualityTesting ON RWS_WQ_TEST_RESULTS_LNK_TBL.TEST_ID = WQM_WaterQualityTesting.TestCode WHERE (((RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE) Is Not Null)) and WQQualityParameter.TestId='1'";
//Query1="SELECT WQM_WaterQualityTesting.TestId, WQQualityParameter.ParameterId, RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE FROM aaaa INNER JOIN ((WQQualityParameter INNER JOIN RWS_WQ_TEST_RESULTS_LNK_TBL ON WQQualityParameter.pcode = RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_CODE) INNER JOIN WQM_WaterQualityTesting ON RWS_WQ_TEST_RESULTS_LNK_TBL.TEST_ID = WQM_WaterQualityTesting.TestCode) ON (WQM_WaterQualityTesting.TestCode = aaaa.TEST_ID) AND (aaaa.TEST_CODE = WQQualityParameter.TestId) WHERE (((RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE) Is Not Null))";
Query1 = "SELECT WQM_WaterQualityTesting.TestId, WQQualityParameter.ParameterId, RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_TBL INNER JOIN ((WQQualityParameter INNER JOIN RWS_WQ_TEST_RESULTS_LNK_TBL ON WQQualityParameter.pcode = RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_CODE) INNER JOIN WQM_WaterQualityTesting ON RWS_WQ_TEST_RESULTS_LNK_TBL.TEST_ID = WQM_WaterQualityTesting.TestCode) ON (WQM_WaterQualityTesting.TestCode = RWS_WQ_TEST_RESULTS_TBL.TEST_ID) AND (RWS_WQ_TEST_RESULTS_TBL.TEST_CODE = WQQualityParameter.TestId) WHERE (((RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE) Is Not Null))";

//Query1 = "select TestId,ParameterId,TESTING_PARAMETER_VALUE FROM finalvalues1";


//Query1="SELECT WQM_WaterQualityTesting.TestId, RWS_WQ_TEST_RESULTS_TBL.FORWARDED_ON, [wslab-ddwslab].LabId, WQM_WaterQualityTesting.TestCode FROM (WQM_WaterQualityTesting INNER JOIN RWS_WQ_TEST_RESULTS_TBL ON WQM_WaterQualityTesting.TestCode = RWS_WQ_TEST_RESULTS_TBL.TEST_ID) INNER JOIN [wslab-ddwslab] ON RWS_WQ_TEST_RESULTS_TBL.LAB_CODE = [wslab-ddwslab].LAB_CODE;";



System.out.println("Query:"+Query1);
rs1 = stmt.executeQuery(Query1);


String sno = "";
String testid = "";
int salcount=0;
PreparedStatement ps=null;
while(rs1.next())
{

String value1=rs1.getString(1);
String value2=rs1.getString(2);
String value3=rs1.getString(3);

//System.out.println("Inserting");
  if(value2.equals("005")){
	//System.out.println("parameter Code"+value2);		
        double value=Double.parseDouble(value3);
          	value=0.03+((1.806*value)/1000);

             if(value>1.836){
             salcount++;
		Query="insert into WQM_LabTestingDetails values (?,'014',?)";
		  ps=con.prepareStatement(Query);
           ps.setString(1, value1);
           ps.setDouble(2, value);
}else{
			Query="insert into WQM_LabTestingDetails values (?,?,?)";
			ps=con.prepareStatement(Query);
	           ps.setString(1, value1);
	           ps.setString(2, value2);
	           ps.setString(3,value3);
}
}
else{
			Query="insert into WQM_LabTestingDetails values (?,?,?)";
			ps=con.prepareStatement(Query);
	           ps.setString(1, value1);
	           ps.setString(2, value2);
	           ps.setString(2, value3);
}
       System.out.println("Query:"+Query);
		rowcount += ps.executeUpdate();


 System.out.println("inserted rows"+rowcount);

}
System.out.println("Salinity Count"+salcount);
}
catch(Exception e){
e.printStackTrace();
 System.out.println("Query"+Query);
}
%>
