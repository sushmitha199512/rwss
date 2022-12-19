<%@	page import="java.sql.*, java.util.*,java.math.BigDecimal " %>
<%
		Connection conn = null, conn1 = null;
		Statement st1 = null, st2 = null;
		ResultSet rs2 = null, rs1 = null;
		int total = 0;
		String workid = "", main = "0", workname = "", stateid = "002", dcode = "", schemetypeid = "", type = "", sancyear = "", estcost = "0", revestcost = "0", goicost = "0", statecost = "0", commcont = "0", capacity = "0", service = "", exp = "0", moreexp = "0", dofcomm = "", dofcomp = "", psy = "", atm = "No", sourcetypeid = "";
		double popcov = 0;
		Statement stq1 = null, stq2 = null, stq3 = null, stq31 = null, stq4 = null, stq5 = null, sss = null, prev = null;
		ResultSet rsq1 = null, rsq2 = null, rsq3 = null, rsq31 = null, rsq4 = null, rsq5 = null, prevrs = null, san = null;

		%>

<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" border="1"
	style="border-collapse:collapse;" width="780">
	<%try {

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@10.160.2.209:1521:wsoft", "preduser",
					"preduser");

			//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			//conn = DriverManager.getConnection("jdbc:odbc:delhidsn1");

			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			conn1 = DriverManager.getConnection("jdbc:odbc:FTKDSN");

		} catch (Exception e) {
			System.out.println("EXCEPTION IN getting Connection"
					+ e.getMessage());
		}
		Statement stqq = null, stqq1 = null;
		ResultSet rsqq = null;
 Statement mainStmt=null,mainStmt1=null,st5=null;
  ResultSet mainRs=null, mainRs1=null;
	int yesContaminated=0;
   int noContaminated=0;
long ddws_test_id=1;
String ddws_id="";
		String query = "";
String finYear="";
 String WORK_ID="",parameterId="";

		String location = "", date_of_comm = "";
		try {
st1 = conn1.createStatement();
		stqq = conn1.createStatement();
 String source_code="";
			mainStmt=conn1.createStatement();
			mainStmt1=conn1.createStatement();
st5=conn1.createStatement();
//FTK_TEST_ID>'0000201764'
           String mainQuery="select distinct source_code,FTK_TEST_ID,TEST_DATE from RWS_FTK_TESTING_TBL   order by FTK_TEST_ID";

  //mainQuery="select distinct a.source_code,a.FTK_TEST_ID,a.TEST_DATE from RWS_FTK_TESTING_TBL a,finalTests b  WHERE a.ftk_test_id=b.ftk_test_id and a.source_code=b.source_code and a.TEST_DATE=b.TEST_DATE and a.test_date>'01/09/2012  order by a.TEST_DATE";

  System.out.println("mainQuery"+mainQuery);
        mainRs=  mainStmt.executeQuery(mainQuery);
String ftestId="";           
   while(mainRs.next()){            //MAIN LOOP

     
 source_code=mainRs.getString(1);
//System.out.println("Yes"+source_code);
ftestId=mainRs.getString(2);
//0000130854

 String q1="select DISTINCT work_id,hab_code from RWS_SOURCE_IDEN_FIN_TBL where source_code='"+source_code+"'";
    
   // System.out.println("q1"+q1);            

			mainRs1=  mainStmt1.executeQuery(q1);
  //		String qq = "SELECT DISTINCT  RWS_SOURCE_IDEN_FIN_TBL.WORK_ID, Switch(rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=1,10,rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=2,27,rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=3,13,rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=4,09,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=1,18,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=2,15,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=3,15,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=4,19,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=5,18,True,('Unspecified')) AS sourcetypeid, IMISMASTERDATA1.Stateid, IMISMASTERDATA1.DistrictId, IMISMASTERDATA1.BlockId, IMISMASTERDATA1.PanchayatId, IMISMASTERDATA1.Villageid, IMISMASTERDATA1.HabitationId, rws_source_tbl.LOCATION, rws_work_completion_tbl.DATE_OF_COMM FROM (((RWS_Schemes INNER JOIN rws_source_iden_fin_tbl ON RWS_Schemes.work_id = rws_source_iden_fin_tbl.WORK_ID) INNER JOIN IMISMASTERDATA1 ON rws_source_iden_fin_tbl.HAB_CODE = IMISMASTERDATA1.HabCode) LEFT JOIN rws_source_tbl ON rws_source_iden_fin_tbl.SOURCE_CODE = rws_source_tbl.SOURCE_CODE) LEFT JOIN rws_work_completion_tbl ON RWS_Schemes.work_id = rws_work_completion_tbl.WORK_ID";
String qq="";
               if(mainRs1.next()){
				WORK_ID="work_id";
System.out.println("Yes11");
			
			 qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,c.work_id FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_SOURCE_IDEN_FIN_TBL C WHERE C.HAB_CODE=B.HabCODE and A.SOURCE_CODE=C.SOURCE_CODE and C.SOURCE_CODE='"+source_code+"'";
                   }else {
//System.out.println("Yes22");
System.out.print(""+ source_code.substring(19,21));
					WORK_ID="asset_code";
                         if(source_code.substring(19,21).equals("HP"))
									{
													 qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,rws_hp_subcomp_param_tbl  C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.hp_code='"+source_code+"' and a.source_code=c.hp_code and a.ftk_test_id='"+ftestId+"'";
									}else if(source_code.substring(19,21).equals("OW")){
							 qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_OPEN_WELL_MAST_TBL C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.openwell_code='"+source_code+"' and a.source_code=c.openwell_code and a.ftk_test_id='"+ftestId+"'";
													}
else if(source_code.substring(19,21).equals("SH")){
							 qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_SHALLOWHANDPUMPS_TBL C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.shallowhp_code='"+source_code+"' and a.source_code=c.shallowhp_code and a.ftk_test_id='"+ftestId+"'";
													}
					
else if(source_code.substring(19,21).equals("SO")){
							 qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_SOURCE_TBL C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.source_code='"+source_code+"' and  a.source_code=c.source_code and a.ftk_test_id='"+ftestId+"'";
													}else {
     continue;
}
	
	
					}



           
			System.out.println(qq);
	

			rsqq = stqq.executeQuery(qq);

			        String contaminated="";
       boolean flag=false;			
while (rsqq.next()) {
  String tdate1=rsqq.getString(2);

  if(!(Integer.parseInt(tdate1.substring(0,4))==2012 && Integer.parseInt(tdate1.substring(5,7))>=9)){
     continue;
}  


String FTK_ID=rsqq.getString("FTK_TEST_ID");
String OLD_FTK_ID=rsqq.getString("OLD_FTK_ID");

if(OLD_FTK_ID==null || OLD_FTK_ID.equals("null")){
OLD_FTK_ID="";
}


ddws_test_id++;
if(ddws_test_id<10){
ddws_id="000000000";

}else if(ddws_test_id<100){
ddws_id="00000000";
}else if(ddws_test_id<1000){
ddws_id="0000000";
}
else if(ddws_test_id<10000){
ddws_id="000000";
}
else if(ddws_test_id<100000){
ddws_id="00000";
}else if(ddws_test_id<1000000){
ddws_id="0000";
}
else if(ddws_test_id<10000000){
ddws_id="000";
}
else if(ddws_test_id<100000000){
ddws_id="00";
}
else if(ddws_test_id<1000000000){
ddws_id="0";
}
ddws_id=ddws_id+""+ddws_test_id;
 String value="";       
String value3=rsqq.getString(3);
String value4=rsqq.getString(4);
String value5=rsqq.getString(5);
String value6=rsqq.getString(6);
String value7=rsqq.getString(7);
String value8=rsqq.getString(8);
String value9=rsqq.getString(9);
String value10=rsqq.getString(10);
String value11=rsqq.getString(11);
String value12=rsqq.getString(12);
String value13=rsqq.getString(13);
String value14=rsqq.getString(14);
String value15=rsqq.getString(15);
String value16=rsqq.getString(16);
String value17=rsqq.getString(17);


				if (value3==null
						&& value4==null
						&& value5==null
						&& value6==null
						&& value7==null
						&& value8==null
						&& value9==null
						&& value10==null
						&& value11==null
						&& value12==null
						&& value13==null
						&& value14==null
						&& value15==null && value16==null && value17==null) 
{
             System.out.print("Yes comming");
                contaminated="0";
 noContaminated++;
				}else{
  System.out.print("Second ");

//insert into second table

for(int i=0;i<15;i++){

                       if(value+""+(i+3)!=null)
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

query = "insert into wq_FTKTestingdetails(TestId,DDWS_TEST_ID,ParameterId)values(?,?,?)";
					System.out.println(query);
					PreparedStatement ps=conn.prepareStatement(query);
                    ps.setString(1, FTK_ID);
                    ps.setString(2, ddws_id);
                    ps.setString(3, parameterId);
					ps.executeUpdate();
}
}
} //end loop

           
			contaminated="1";
yesContaminated++;
}
		
 //System.out.print("Yest got data::"+contaminated);

//2010-06-21
String tdate="-";
 // String tdate1=rsqq.getString(2);







 //System.out.print("Date:"+tdate);
 if(tdate1!=null){
 String year=tdate1.substring(0,4);  
String month=tdate1.substring(5,7);  
String day=tdate1.substring(8,10); 
tdate=day+"/"+month+"/"+year; 

int mnth=Integer.parseInt(month);
int yr=Integer.parseInt(year);
   int yr1=0;
if(mnth>3){
	 yr1=yr+1;
	finYear=yr+"-"+yr1;   
   }else{
	   yr1=yr-1;
	   finYear=yr1+"-"+yr;
   }
 }
 System.out.println("Ddws_id:"+ddws_id);


  
	query = "insert into wq_waterQualityTesting(TestId,DDWS_TEST_ID,TestingDate,ContaminatedYes_No,HabitationId,StateID,DistrictId,SchemeNo,GPId_testingDone,FinYear,Old_Ftk_Id)values("
							+ "?,?,?,?,?,?,?,?,?,?,?)";

 System.out.print("Running Query"+query);
 PreparedStatement ps=conn.prepareStatement(query);
 ps.setString(1, FTK_ID);
	ps.setString(2,ddws_id);
	ps.setString(3, tdate);
	ps.setString(4, contaminated);
	ps.setString(5, rsqq.getString("HabitationId"));
	ps.setString(6, rsqq.getString("StateID"));
	ps.setString(7,rsqq.getString("DistrictId"));
	ps.setString(8, rsqq.getString(WORK_ID));
	ps.setString(9,  rsqq.getString("Panchayatid"));
	ps.setString(10,finYear);
    ps.setString(11,OLD_FTK_ID);
   
					total += ps.executeUpdate();

System.out.println("Total:"+total);

}
flag=false;
}

			
} catch (Exception e) {
					System.out.println(query);
e.printStackTrace();
				
				} finally {
					try {
						//if(st1!=null)st1.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
				}
		try{	
	out.println("<font face=verdana size=2>"
							+ total
		

					+ " no.of Tests exported Successfully! To download the mdb file Click the following Link:<!-- <a href=d:/habdata/habdata.mdb></font><font face=verdana size=3 color=red>Download</a></font> -->");

 out.println("Contaminated Count"+yesContaminated+"<br>"+"Not Contaminated"+noContaminated);

}catch(Exception e){
	e.printStackTrace();
}
	%>