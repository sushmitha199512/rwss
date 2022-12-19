<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random,java.text.*"%>
<%System.out.println("updateTestId.jsp");%>
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

	
	String empty="";
	
	int contaminated=0,rowcount=0;
	/*Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	con1 = DriverManager.getConnection("jdbc:odbc:abc","","");
	System.out.println("Connection created");*/

   Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	con = DriverManager.getConnection("jdbc:odbc:WqLabPorting10092012","","");
	System.out.println(" access Connection created");

Statement stmt=con.createStatement();		
Statement neww=con.createStatement();		
//Statement stmt1=con1.createStatement();
//String Query1 = "SELECT DISTINCT TotalSourcess.SourceCode, RWS_WATER_SAMPLE_COLLECT_TBL.HAB_CODE, RWS_WATER_SAMPLE_COLLECT_TBL.TEST_ID, IMISMASTERDATA1.HabitationId, IMISMASTERDATA1.DistrictId, TotalSourcess.SourceCode1, RWS_WATER_SAMPLE_COLLECT_TBL.TEST_ID FROM IMISMASTERDATA1 INNER JOIN ((RWS_WATER_SAMPLE_COLLECT_TBL INNER JOIN TotalSourcess ON RWS_WATER_SAMPLE_COLLECT_TBL.SOURCE_CODE = TotalSourcess.SourceCode) INNER JOIN RWS_WQ_TEST_RESULTS_TBL ON RWS_WATER_SAMPLE_COLLECT_TBL.TEST_ID = RWS_WQ_TEST_RESULTS_TBL.TEST_ID) ON IMISMASTERDATA1.habcode = RWS_WATER_SAMPLE_COLLECT_TBL.HAB_CODE";
String query1="SELECT finalSources.* FROM finalSources";
System.out.println("qyery1:"+query1);

rs1 = neww.executeQuery(query1);

out.println("result set rs"+rs1);
String sno = "";
String testid ="";
long rcount=505034;
//

//0000404418

while(rs1.next())
{
	//System.out.println("rcount:"+rcount);
	rcount++;
	System.out.println("rcount1:"+rcount);
	sno = ""+rcount;
  String sCode=rs1.getString(1);
String type=rs1.getString(7);
	
	System.out.println("sCode:"+sCode);
System.out.println("type:"+type);
	if(sno.length()==1)
	{
		testid="000000000"+sno;
	}
	else if(sno.length()==2)
	{
		testid="00000000"+sno;
	}
	else if(sno.length()==3)
	{
		testid="0000000"+sno;
	}
	else if(sno.length()==4)
	{
		testid="000000"+sno;
	}
	else if(sno.length()==5)
	{
		testid="00000"+sno;
	}
	else if(sno.length()==6)
	{
		testid="0000"+sno;
	}
	else if(sno.length()==7)
	{
		testid="000"+sno;
	}
	else if(sno.length()==8)
	{
		testid="00"+sno;
	}
	else if(sno.length()==9)
	{
		testid="0"+sno;
	}
  if(sCode!=null && sCode.substring(19,21).equals("SO")){

				      if(type!=null && type.equals("2")){
													sCode="S"+sCode;                             
									}else if(type!=null && type.equals("1")){
													sCode="SC"+sCode;																							
						}
									
				}else if(sCode!=null && sCode.substring(19,21).equals("HP")){
                        sCode="H"+sCode;
					}	


	String Query="insert into [WQM_WaterQualityTesting](TestId,Source,HabitationId,Districtid,TestCode)values(?,?,?,?,?)";
   System.out.println("Query"+Query);
   PreparedStatement pst=con.prepareStatement(Query);
   pst.setString(1, testid);
	pst.setString(2,  sCode);
	 pst.setString(3,rs1.getString(4));
	 pst.setString(4,rs1.getString(5));
	pst.setString(5,rs1.getString(3));
	rowcount += pst.executeUpdate();
}
System.out.println("updated rows"+rowcount);
}
catch(Exception e){
e.printStackTrace();
}
%>
 