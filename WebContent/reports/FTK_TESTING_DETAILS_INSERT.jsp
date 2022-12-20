<%@	page import="java.sql.*, java.util.*,java.math.BigDecimal " %>
<%
	Connection conn=null,conn1=null;
	Statement st1=null,st2=null;
    ResultSet rs2=null,rs1=null;
	int total = 0;
	String workid="",main="0",workname="",stateid="002",dcode="",schemetypeid="",type="",sancyear="",estcost="0",revestcost="0",goicost="0",statecost="0",commcont="0",capacity="0",service="",exp="0",moreexp="0",dofcomm="",dofcomp="",psy="",atm="No",sourcetypeid="";
	double popcov = 0;
	Statement stq1=null,stq2=null,stq3=null,stq31=null,stq4=null,stq5=null,sss=null,prev=null;
	ResultSet rsq1=null,rsq2=null,rsq3=null,rsq31=null,rsq4=null,rsq5=null,prevrs=null,san=null;

    %>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="780" >
<% 			
try{
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.209:1521:wsoft","preduser","preduser");
		
//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
//conn = DriverManager.getConnection("jdbc:odbc:delhidsn1");

Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
conn1 = DriverManager.getConnection("jdbc:odbc:FTKDSN");
	
   }
   catch(Exception e)
   {
		System.out.println("EXCEPTION IN getting Connection"+e.getMessage());
   }   
   Statement stqq =null,stqq1 =null; 
   ResultSet rsqq = null;
   String query = "";

   
   String location = "",date_of_comm="";
   try{
//		String qq = "SELECT DISTINCT  RWS_SOURCE_IDEN_FIN_TBL.WORK_ID, Switch(rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=1,10,rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=2,27,rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=3,13,rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=4,09,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=1,18,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=2,15,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=3,15,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=4,19,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=5,18,True,('Unspecified')) AS sourcetypeid, IMISMASTERDATA1.Stateid, IMISMASTERDATA1.DistrictId, IMISMASTERDATA1.BlockId, IMISMASTERDATA1.PanchayatId, IMISMASTERDATA1.Villageid, IMISMASTERDATA1.HabitationId, rws_source_tbl.LOCATION, rws_work_completion_tbl.DATE_OF_COMM FROM (((RWS_Schemes INNER JOIN rws_source_iden_fin_tbl ON RWS_Schemes.work_id = rws_source_iden_fin_tbl.WORK_ID) INNER JOIN IMISMASTERDATA1 ON rws_source_iden_fin_tbl.HAB_CODE = IMISMASTERDATA1.HabCode) LEFT JOIN rws_source_tbl ON rws_source_iden_fin_tbl.SOURCE_CODE = rws_source_tbl.SOURCE_CODE) LEFT JOIN rws_work_completion_tbl ON RWS_Schemes.work_id = rws_work_completion_tbl.WORK_ID";
	
  String qq="select  A.* FROM RWS_FTK_TESTING_TBL A where (ARSENIC IS NOT NULL  or NITRATE is not null or FLORIDE is not null or  SALINITY is not null or  IRON is not null or COLIFORM is not null or  TURBIDITY is not null or  CHLORIDES is not null or MANGANESE is not null or SULPHATES is not null or COPPER is not null or  CALCIUM is not null or  TDS is not null or MAGNESIUM is not null or HARDNESS is not null)";
          ResultSet rsmaster=null;
		System.out.println(qq);
		stqq  = conn.createStatement();
		rsqq = stqq.executeQuery(qq);
		st1 = conn1.createStatement();
       Statement stmt2=conn1.createStatement();
         String  parameterId="";
		while(rsqq.next())
		{
			String testId=rsqq.getString("FTK_TEST_ID");
			parameterId="";
		for(int i=0;i<15;i++){
         if(rsqq.getString(i+3)!=null)
			{
                 
				switch(i+3){     // 
					case 3:
					parameterId="002";break;      //ARSENIC 
                    case 4:
					parameterId="006";break;      //NITRATE
                    case 5:
					parameterId="003";break;      //FLOURIDE
                    case 6:
					parameterId="014";break;      //SALINITY
                    case 7:
					parameterId="004";break;      //IRON
                     case 8:
					parameterId="012";break;      //COLIFORM
                    case 9:
					parameterId="001";break;      //TURBODITY
                    case 10:
					parameterId="005";break;      //CHLORIDE
                    case 11:
					parameterId="010";break;      //MANGANEESE
                    case 12:
					parameterId="007";break;      //SULPHATES
                    case 13:
					parameterId="011";break;      //COPPER
                    case 14:
					parameterId="008";break;      //CALSIUM
                    case 15:
					parameterId="015";break;      //TDS
                    case 16:
					parameterId="009";break;      //MAGNINESIUM
                    case 17:
					parameterId="016"; break; //HARDNESS
                     
				}
                if(!parameterId.equals("")){

query = "insert into wq_FTKTestingdetails(TestId,ParameterId)values('"+testId+"','"+parameterId+"')";
					System.out.println(query);
					st1.executeUpdate(query);
}
 parameterId="";


			}		
}
   total++;         }}catch(Exception e)
		    	{
					System.out.println(query);
  					e.printStackTrace();
		    	}
				finally{
				try{
				//if(st1!=null)st1.close();
				}catch(Exception e){}
		   	}
		try{
		out.println("<font face=verdana size=2>"+total+" no.of FTK Tests exported Successfully! To download the mdb file Click the following Link:<!-- <a href=d:/habdata/habdata.mdb></font><font face=verdana size=3 color=red>Download</a></font> -->");
}catch(Exception e){ e.printStackTrace();}
   %>
