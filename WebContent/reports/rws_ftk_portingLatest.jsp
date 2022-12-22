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
           String mainQuery="select a.* from RWS_FTK_TESTING_TBL a,wq_waterQualityTesting b   where a.FTK_TEST_ID=b.TestId order by FTK_TEST_ID";

  //mainQuery="select distinct a.source_code,a.FTK_TEST_ID,a.TEST_DATE from RWS_FTK_TESTING_TBL a,finalTests b  WHERE a.ftk_test_id=b.ftk_test_id and a.source_code=b.source_code and a.TEST_DATE=b.TEST_DATE and a.test_date>'01/09/2012  order by a.TEST_DATE";

  System.out.println("mainQuery"+mainQuery);
        rsqq=  mainStmt.executeQuery(mainQuery);
String ftestId="";           
   while(rsqq.next()){            //MAIN LOOP
query="";
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
  String tdate1=rsqq.getString(2);    
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


		
//insert into second table
ftestId=rsqq.getString("FTK_TEST_ID");
String conStatus=rsqq.getString("CONTAMINATION_STATUS");
if(conStatus!=null && conStatus.equals("Y")){
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
					PreparedStatement ps1=conn.prepareStatement(query);
					 ps1.setString(1,ftestId);
					 ps1.setString(1,ddws_id);
					 ps1.setString(1,parameterId);
					ps1.executeUpdate();
}
}
} //end loop

}

           
	
 //System.out.print("Yest got data::"+contaminated);

//2010-06-21
String tdate="-";








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


  
	query = "update   wq_waterQualityTesting set DDWS_TEST_ID=?,FinYear=? where TestId=?";
 System.out.print("Running Query"+query);
 PreparedStatement ps2=conn.prepareStatement(query);
 ps2.setString(1,ddws_id);
 ps2.setString(2,finYear);
 ps2.setString(3,ftestId);
 total += ps2.executeUpdate();

System.out.println("Total:"+total);
query="";
}
			
} catch (Exception e) {
 System.out.print("Running Query"+query);
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