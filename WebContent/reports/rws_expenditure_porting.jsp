<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random,java.text.*"%>

												//EXPENDITURE PORTIHNG DETAILS

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

//public static final String NRDWP_RELATED = "01,02,18,23,32,48,49,51,53,58,59,60";

			String bankQuery = "SELECT DISTINCT A.WORK_ID ,SUM(A.BILL_AMOUNT_CENTRAL),B.NO_OF_HABS,B.WORK_NAME  FROM RWS_BILL_BANK_BRIDGE_DET_TBL A,RWS_WORK_ADMN_TBL B  WHERE SUBSTR(A.BANK_SEND_DATE ,4,3) IN ('APR','MAY','JUN') AND substr(A.BANK_SEND_DATE ,8,2) ='12' AND A.TXID IS NOT NULL AND A.WORK_ID=B.WORK_ID AND SUBSTR(A.WORK_ID,7,2)<>'12' GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME";
			String stateQuery = "SELECT  DISTINCT A.WORK_ID, SUM(A.BILL_AMOUT_STATE),B.NO_OF_HABS,B.WORK_NAME  FROM RWS_BILL_PAO_BRIDGE_DET_TBL A, RWS_WORK_ADMN_TBL B WHERE SUBSTR(A.STATE_SEND_DATE ,4,3) IN ('APR','MAY','JUN') AND substr(A.STATE_SEND_DATE ,8,2) ='12' AND  A.STATE_TXID  IS NOT NULL  AND A.WORK_ID=B.WORK_ID  AND SUBSTR(A.WORK_ID,7,2)<>'12' GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME";

      			


////bank details

			System.out.println("Query:" + bankQuery);
			bankQuery="select *from BANKDET_AUG";
			//bankQuery="select *from WorksDet";		
			rs1 = stmt.executeQuery(bankQuery);
		   System.out.println("StaRTING Process");
               while(rs1.next())
				{
   System.out.println("Statred Process");
               String work_id=rs1.getString(1);     ///01010411120008
          System.out.println("Work Id"+work_id);
                int programeCode=Integer.parseInt(work_id.substring(0,2));
			    int subprogrameCode=Integer.parseInt(work_id.substring(2,4));
                 String districtId=rs1.getString(5);
                 String workName=rs1.getString(4);
				 String month=rs1.getString(6);
				 
				String noHabs=rs1.getString(3);
				int cateGoreyCode=Integer.parseInt(rs1.getString(7));
int noOfHabs=0;
        if(noHabs!=null){
                 noOfHabs=Integer.parseInt(noHabs);
				}
	   //System.out.println("Work ID:"+work_id+"Programme Code:"+programeCode);
			     String mvspopuLationQuery="select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_EST_NEW_HAB_LNK_TBL b,distlist c where b.work_id='"+work_id+"' and a.hab_code=b.hab_code and MID(B.WORK_ID,5,2)=C.dcode  and  a.COVERAGE_STATUS <>'UI' ";
        		 String mvsSchoolpopuLationQuery="select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_WORK_SCHOOL_LNK_TBL b ,distlist c  where b.work_id='"+work_id+"' and a.hab_code=b.hab_code and MID(B.WORK_ID,5,2)=C.dcode and a.COVERAGE_STATUS <>'UI'";
				
bankAmount+=rs1.getDouble(2);

//1 PROJECTS (mvs)
//2 NORMAL   (svs)
				   
							if(work_id.substring(6,8).equals("11")){           //FOR SCHOOLS
							// System.out.println("mvsSchoolpopuLationQuery"+mvsSchoolpopuLationQuery);
                               rs3=stmt1.executeQuery(mvsSchoolpopuLationQuery);
												}else {
 //System.out.println("mvspopuLationQuery:"+mvspopuLationQuery);
                               rs3=stmt1.executeQuery(mvspopuLationQuery);
												}
								
 //System.out.println("Amount:"+bankAmount);
long gen=0,scpop=0,stpop=0;totalp=0;
boolean flag=false;
									while(rs3.next()){

								 value1=rs3.getInt(1);	 value2=rs3.getInt(2);	 value3=rs3.getInt(3);
			districtId=rs3.getString(4);
						 totalp+=value1+value2+value3; //System.out.println("Total Poplation:"+totalp);

							gen+=value1;scpop+=value2;stpop+=value3;
									flag=true;

									}
						 if(flag){
								sca+=(bankAmount*scpop)/totalp;//System.out.println("SCA Poplation:"+sca);
	      					  sta+=(bankAmount*stpop)/totalp;//System.out.println("sta Poplation:"+sta);
			   				  plaina+=(bankAmount*gen)/totalp;
							}else{	
									System.out.println("Not found Work Id:"+work_id);
             }
                		
					//NRDWP Related (100%) 

       				  if(cateGoreyCode==1){          //MVS SCHEMES
  // System.out.println("MVS SCHEME");
                      
					if(programeCode==1 || programeCode==2 || programeCode==18 || programeCode==23 || programeCode==32 || programeCode==48 || programeCode==49 || programeCode==51 || programeCode==53 || programeCode==59 || programeCode==58|| programeCode==60)
					{  

									if(programeCode==51){
										delhiProgramID=21;
											}else if(programeCode==60){     //(NRDWP 0&M)
										delhiProgramID=27; 
											}else if(programeCode==59){
										delhiProgramID=24;
											}else if(programeCode==18){
										delhiProgramID=14;
											}else if(programeCode==1 && (subprogrameCode==0 || subprogrameCode==1 || subprogrameCode==2 || subprogrameCode==3 || subprogrameCode==4|| subprogrameCode==6)){
											delhiProgramID=1;
											}else{
                        				 if(subprogrameCode==5){      //ARWS 15%--(NRDWP-O & M)
 										delhiProgramID=27;
											}else{                    //NRDWP RELATED
											delhiProgramID=19;
										 } }
 				if(work_id.substring(6,8).equals("11")){  
				insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','"+plaina+"','"+sca+"','"+sta+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; //correct
							}else{
  
				insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','"+plaina+"','"+sca+"','"+sta+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							}
						
					}else if(programeCode==4 || programeCode==46 || programeCode==57 || programeCode==12 || programeCode==63 ){
               					  //State Exp.- NABARD(04), State Plan(46), World Bank(APRWSP-WB)57, HUDCO(12), TFC(63) (100%) & GOI 0%
								switch (programeCode){
                                    case 4:
										delhiProgramID=22;break;
								case 46:
										delhiProgramID=15;break;
								case 57:
										delhiProgramID=25;break;
                                case 12:
										delhiProgramID=15;break;
										}

	if(work_id.substring(6,8).equals("11")){  
				insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','0','0','0','0','"+plaina+"','"+sca+"','"+sta+"','0','0','0','0','0','0','0','0','0','0','0','0')";
							}else{
  
				insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','0','"+plaina+"','"+sca+"','"+sta+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							}
			


					}
		}else{                //SVS SCHEMES
   System.out.println("SVS SCHEME");


if(programeCode==1 || programeCode==2 || programeCode==18 || programeCode==23 || programeCode==32 || programeCode==48 || programeCode==49 || programeCode==51 || programeCode==53 || programeCode==59 || programeCode==58|| programeCode==60)
					{  
                        				// if(subprogrameCode==5){      //ARWS 15%--(NRDWP-O & M)
 										//delhiProgramID=27;
											//}else if(subprogrameCode==6){ //ARWS 5%--NRDWP SUSTAINBILITY 
											//delhiProgramID=1;
											//}else{                    //NRDWP RELATED
											//delhiProgramID=19;
										 //}

									if(programeCode==51){
										delhiProgramID=21;
											}else if(programeCode==60){     //(NRDWP 0&M)
										delhiProgramID=27;
											}else if(programeCode==59){
										delhiProgramID=24;
											}else if(programeCode==18){
										delhiProgramID=14;
											}else if(programeCode==1 && (subprogrameCode==0 || subprogrameCode==1 || subprogrameCode==2 || subprogrameCode==3 || subprogrameCode==4 || subprogrameCode==6)){
											delhiProgramID=1;
											}else{
                        				 if(subprogrameCode==5){      //ARWS 15%--(NRDWP-O & M)
 										delhiProgramID=27;
											}else{                    //NRDWP RELATED
											delhiProgramID=19;
										 } }


				
						if(subprogrameCode==0 ||subprogrameCode==1 ){
									if(work_id.substring(6,8).equals("11")){  
					insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; 
																}else{
					insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
												 }
											}else if(subprogrameCode==2){
							if(work_id.substring(6,8).equals("11")){  
     				insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							}else{
			        insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
				}
												  }
											else if(subprogrameCode==3 || subprogrameCode==4){     //if we get subprogrammes other than sc,plain,st we are taken as st 
					 							if(work_id.substring(6,8).equals("11")){  
					insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
											}else{
					insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
											}
								 }
else if(subprogrameCode==5 || subprogrameCode==6){     //if we get subprogrammes other than sc,plain,st we are taken as st 
					 							if(work_id.substring(6,8).equals("11")){  
					insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
											}else{
					insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
											}
								 }

			}
}
         


        //  System.out.println("Insert Query:"+insertQuery);
           if(!insertQuery.equals(" ")){
            
                rcount+=stmt3.executeUpdate(insertQuery);
				}
flag=false;
insertQuery=" ";bankAmount=0;plaina=0;sca=0;sta=0;delhiProgramID=0;
          	
				}
System.out.println("Records inserted:"+rcount);
//pao details

			String sno = "";
		} catch (Exception e) {
			//System.out.println("Final Query:" + insertQuery);
			e.printStackTrace();

		}
%>