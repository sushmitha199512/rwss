<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random,java.text.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%  
    //System.out.println("i am in audit report1111111111"); 
    DecimalFormat ndf = new DecimalFormat("####.00");
	String fromdate=request.getParameter("fdate");
    String todate=request.getParameter("todate");
    // System.out.println("fromdate:::::::::::::"+fromdate);
   //  System.out.println("todate:::::::::::::"+todate);
     SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yy");
     SimpleDateFormat sdfSource = new SimpleDateFormat("dd-MMM-yy");
    
    SimpleDateFormat sdfDestination1 = new SimpleDateFormat("dd-MMM-yy");
    SimpleDateFormat sdfSource1 = new SimpleDateFormat("dd-MMM-yy");
    
     try{
     //parse the string into Date object
     java.util.Date date = sdfSource.parse(fromdate);

     //parse the date into another format
      fromdate = sdfDestination.format(date);

     //parse the string into Date object
     java.util.Date date1 = sdfSource1.parse(todate);

     //parse the date into another format
      todate = sdfDestination1.format(date1);
     
      //System.out.println("Date is converted from dd/MM/yy format to MM-dd-yyyy hh:mm:ss");
     // System.out.println("Converted date is : " + fromdate+"...."+todate);
   } catch(ParseException pe)
   { 
     System.out.println("Parse Exception : " + pe);
   }

String myreptype=request.getParameter("reptype");
System.out.println("myreptype: " + myreptype);
session.setAttribute("Type",myreptype);
ResultSet rs1 = null, rs2 = null,rs3=null,rs4=null,rs5=null,rs6=null;

	//Connection con = null, con1 = null;
	String LAStatus = "";
		String CAStatus = "";
		String mainreason = "";
		String test_id = "";
		String genid = "";

		%>
<BODY>
<form name="f1">

<%String Query = "",y="";
  String bankQuery="";
String stateQuery="";
  boolean flag1=false;
	int bc=0,sc=0;
		String insertQuery = "";
		int notfoundcount = 0;
		Statement stmt55=  null;
            Statement stmtdr = null;
           
		try {
			int rcount = 0;

			String empty = "";
			int contaminated = 0, rowcount = 0;
			int delhiProgramID=0;
 			String delhiProgramName="";
	        long totalp=0;double bankAmount=0,sca=0,sta=0,plaina=0,value1=0,value2=0,value3=0;

		    stmt = conn.createStatement();			
            Statement stmt99 = conn.createStatement();
            Statement stmt88 = conn.createStatement();
            Statement stmt77=  conn.createStatement();
            Statement stmt66=  conn.createStatement();
            stmt55=  conn.createStatement();
            Statement stmt44=  conn.createStatement();
			Statement stmt33=  conn.createStatement();
			Statement stmt22=  conn.createStatement();
            Statement stmt11=  conn.createStatement();
            Statement stmt1 = conn.createStatement();
            Statement stmtdc = conn.createStatement();
            Statement stmtdi = conn.createStatement();
             stmtdr = conn.createStatement();
            ResultSet rs33=null;

             conn.setAutoCommit(false); 

            Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt5 = conn.createStatement();   
            Statement st1 = conn.createStatement(); //database Connections

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                       
        String distquery="CREATE table rws_delhi_district_list_tbl(DistrictId varchar2(5),DistrictName varchar2(50),dcode varchar2(2))";
        stmtdc.executeUpdate(distquery);
		//conn.setAutoCommit(true);
       // System.out.println("distquery"+distquery);
      
        String  distinsert="insert into rws_delhi_district_list_tbl  values('0003','SRIKAKULAM(01)','01')";		
            stmtdi.addBatch(distinsert);
			String 	distinsert1="insert into rws_delhi_district_list_tbl  values('0004','VIZIANAGARAM(02)','02')";
            stmtdi.addBatch(distinsert1);
			String 	distinsert2="insert into rws_delhi_district_list_tbl  values('0005','VISAKHAPATNAM(03)','03')";
			stmtdi.addBatch(distinsert2);
			String 	distinsert3="insert into rws_delhi_district_list_tbl  values('0006','EAST GODAVARI(04)','04')";
			stmtdi.addBatch(distinsert3);
			String 	distinsert4="insert into rws_delhi_district_list_tbl  values('0007','WEST GODAVARI(05)','05')";
			stmtdi.addBatch(distinsert4);
			String 	distinsert5="insert into rws_delhi_district_list_tbl  values('0008','KRISHNA(06)','06')";
			stmtdi.addBatch(distinsert5);
			String 	distinsert6="insert into rws_delhi_district_list_tbl  values('0009','GUNTUR(07)','07')";
			stmtdi.addBatch(distinsert6);
			String	distinsert7="insert into rws_delhi_district_list_tbl  values('0010','PRAKASAM(08)','08')";
			stmtdi.addBatch(distinsert7);
			String 	distinsert8="insert into rws_delhi_district_list_tbl  values('0011','NELLORE(09)','09')";
			stmtdi.addBatch(distinsert8);
			String 	distinsert9="insert into rws_delhi_district_list_tbl  values('0012','CHITTOOR(10)','10')";
			stmtdi.addBatch(distinsert9);
			String 	distinsert10="insert into rws_delhi_district_list_tbl  values('0013','KADAPA(11)','11')";
			stmtdi.addBatch(distinsert10);
			String 	distinsert11="insert into rws_delhi_district_list_tbl  values('0014','ANANTAPUR(12)','12')";
			stmtdi.addBatch(distinsert11);
			String 	distinsert12="insert into rws_delhi_district_list_tbl  values('0015','KURNOOL(13)','13')";
			stmtdi.addBatch(distinsert12);
			String 	distinsert13="insert into rws_delhi_district_list_tbl  values('0016','MAHABOOBNAGAR(14)','14')";
			stmtdi.addBatch(distinsert13);
			String 	distinsert14="insert into rws_delhi_district_list_tbl  values('0017','RANGAREDDY(15)','15')";
			stmtdi.addBatch(distinsert14);
			String 	distinsert15="insert into rws_delhi_district_list_tbl  values('0019','MEDAK(17)','17')";
			stmtdi.addBatch(distinsert15);
			String 	distinsert16="insert into rws_delhi_district_list_tbl  values('0020','NIZAMABAD(18)','18')";
			stmtdi.addBatch(distinsert16);
			String 	distinsert17="insert into rws_delhi_district_list_tbl  values('0021','ADILABAD(19)','19')";
			stmtdi.addBatch(distinsert17);
			String 	distinsert18="insert into rws_delhi_district_list_tbl  values('0022','KARIMNAGAR(20)','20')";
			stmtdi.addBatch(distinsert18);
			String 	distinsert19="insert into rws_delhi_district_list_tbl  values('0023','WARANGAL(21)','21')";
			stmtdi.addBatch(distinsert19);
			String 	distinsert20="insert into rws_delhi_district_list_tbl  values('0024','KHAMMAM(22)','22')";
			stmtdi.addBatch(distinsert20);
			String 	distinsert21="insert into rws_delhi_district_list_tbl  values('0025','NALGONDA(23)','23')";
			stmtdi.addBatch(distinsert21);
			                //System.out.println("distinserts"+distinsert);
			int c[]=stmtdi.executeBatch();
			if(c.length>0)
			{
			//out.println("Inserted Successfully");
			}
			else
			{
			out.println("Not Inserted");
			
			}
/////////////////////////////////////////////////////////

        String selquery="Select tname from tab where tname like 'SCHEMEEXPENDITURE'";
        rs33=stmt33.executeQuery(selquery);
        if(!rs33.next())
	    {
          //String crquery="create table SchemeExpenditure(SchemeID varchar2(14),SchemeName varchar2(100),YearID varchar2(4),MonthID   varchar2(4),DistrictID   varchar2(5),ProgrammeId  varchar2(2),GOIGenExpenditure   number(11,2),GOISCExpenditure    number(11,2),GOISTExpenditure    number(11,2),GOISchoolGenExpenditure number(11,2),GOISchoolSCExpenditure   number(11,2),   GOISchoolSTExpenditure   number(11,2),   StateGenExpenditure     number(11,2), StateSCExpenditure  number(11,2),StateSTExpenditure  number(11,2),StateSchoolGenExpenditure  number(11,2),StateSchoolSCExpenditure  number(11,2),StateSchoolSTExpenditure  number(11,2),DDPGenExpenditure  number(11,2),DDPSCExpenditure       number(11,2), DDPSTExpenditure       number(11,2),DDPSchoolGenExpenditure     number(11,2), DDPSchoolSCExpenditure     number(11,2),  DDPSchoolSTExpenditure       number(11,2),CommunityGenExpenditure      number(11,2),CommunitySCExpenditure     number(11,2),  CommunitySTExpenditure       number(11,2),CommunitySchoolGenExpenditure     number(11,2),CommunitySchoolSCExpenditure   number(11,2), CommunitySchoolSTExpenditure    number(11,2))";
           String crquery="create table  SchemeExpenditure(SCHEMEID     VARCHAR2(14),SCHEMENAME     VARCHAR2(100),YEARID     VARCHAR2(4) ,MONTHID     VARCHAR2(4)  ,DISTRICTID     VARCHAR2(5),  PROGRAMMEID     VARCHAR2(2)  ,PROGRAMMENAME     VARCHAR2(100),GOISCEXPENDITURE     NUMBER(11,2)  ,GOISTEXPENDITURE     NUMBER(11,2)  ,GOIGENEXPENDITURE     NUMBER(11,2)  ,GOISCHOOLSCEXPENDITURE     NUMBER(11,2)  ,GOISCHOOLSTEXPENDITURE     NUMBER(11,2)  ,GOISCHOOLGENEXPENDITURE     NUMBER(11,2)  ,STATESCEXPENDITURE     NUMBER(11,2)  ,STATESTEXPENDITURE     NUMBER(11,2)  ,STATEGENEXPENDITURE     NUMBER(11,2)  ,STATESCHOOLSCEXPENDITURE     NUMBER(11,2)  ,STATESCHOOLSTEXPENDITURE     NUMBER(11,2)  ,STATESCHOOLGENEXPENDITURE     NUMBER(11,2)  ,DDPSCEXPENDITURE     NUMBER(11,2)  ,DDPSTEXPENDITURE     NUMBER(11,2)  ,DDPGENEXPENDITURE     NUMBER(11,2)  ,DDPSCHOOLSCEXPENDITURE     NUMBER(11,2)  ,DDPSCHOOLSTEXPENDITURE     NUMBER(11,2)  ,DDPSCHOOLGENEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSTEXPENDITURE     NUMBER(11,2)  ,COMMUNITYGENEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCHOOLSCEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCHOOLSTEXPENDITURE     NUMBER(11,2) ,COMMUNITYSCHOOLGENEXPENDITURE     NUMBER(11,2) )";
         
          stmt22.executeUpdate(crquery);
          //System.out.println("crquery"+crquery);
	    }
       else
       {  
        String delquery="delete from SchemeExpenditure";
        stmt44.executeUpdate(delquery);
        conn.setAutoCommit(true);
        //System.out.println("delquery"+delquery);
       }

        String tblquery="create table Bank_Pao_exp_porting_tbl(WORK_ID varchar2(14),SumOfBILL_AMOUNT_CENTRAL number(11,2),NO_OF_HABS varchar2(3),WORK_NAME varchar2(100),DistrictId varchar2(5),month varchar2(5),CATEGORY_CODE varchar2(1))";
        stmt66.executeUpdate(tblquery);
        //System.out.println("tblquery"+tblquery);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//public static final String NRDWP_RELATED = "01,02,18,23,32,48,49,51,53,58,59,60";
  if(!myreptype.equals(null) && myreptype.equals("Schools"))
    {
      bankQuery = "SELECT DISTINCT A.WORK_ID ,SUM(A.BILL_AMOUNT_CENTRAL),B.NO_OF_HABS,B.WORK_NAME,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,b.category_code,SUBSTR(A.BANK_SEND_DATE ,4,3),SUBSTR(A.BANK_SEND_DATE ,8)  FROM RWS_BILL_BANK_BRIDGE_DET_TBL A,RWS_WORK_ADMN_TBL B  WHERE substr(B.WORK_ID,7,2)='11' AND A.TXID IS NOT NULL AND A.WORK_ID=B.WORK_ID and TO_DATE(a.bank_send_date,'dd-mon-yy')>='"+fromdate+"' and TO_DATE(a.bank_send_date,'dd-mon-yy')<='"+todate+"'  GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025'),b.category_code,SUBSTR(A.BANK_SEND_DATE ,4,3),SUBSTR(A.BANK_SEND_DATE ,8)";
    }
    else
     {
      bankQuery = "SELECT DISTINCT A.WORK_ID ,SUM(A.BILL_AMOUNT_CENTRAL),B.NO_OF_HABS,B.WORK_NAME,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,b.category_code,SUBSTR(A.BANK_SEND_DATE ,4,3),SUBSTR(A.BANK_SEND_DATE ,8)  FROM RWS_BILL_BANK_BRIDGE_DET_TBL A,RWS_WORK_ADMN_TBL B  WHERE TO_DATE(a.bank_send_date,'dd-mon-yy')>='"+fromdate+"' and TO_DATE(a.bank_send_date,'dd-mon-yy')<='"+todate+"' AND A.TXID IS NOT NULL AND A.WORK_ID=B.WORK_ID AND SUBSTR(A.WORK_ID,7,2)<>'11' and SUBSTR(A.WORK_ID,7,2)<>'12' GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025'),b.category_code,SUBSTR(A.BANK_SEND_DATE ,4,3),SUBSTR(A.BANK_SEND_DATE ,8)";
 
     }
    //String bankQuery = "SELECT DISTINCT A.WORK_ID ,SUM(A.BILL_AMOUNT_CENTRAL),B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,SUBSTR(A.BANK_SEND_DATE ,4,3),SUBSTR(A.BANK_SEND_DATE ,8)  FROM RWS_BILL_BANK_BRIDGE_DET_TBL A,RWS_WORK_ADMN_TBL B,rws_delhi_district_list_tbl c  WHERE c.dcode=substr(b.work_id,5,2) and SUBSTR(A.BANK_SEND_DATE ,4,3) IN ('AUG') AND substr(A.BANK_SEND_DATE ,8,2) ='12' AND A.TXID IS NOT NULL AND A.WORK_ID=B.WORK_ID AND SUBSTR(A.WORK_ID,7,2)<>'12' GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,SUBSTR(A.BANK_SEND_DATE ,4,3),SUBSTR(A.BANK_SEND_DATE ,8)";
  	System.out.println("bankQuery Query:"+bankQuery);        
       ResultSet rs99=stmt.executeQuery(bankQuery);
       PreparedStatement ps9=null;
       while(rs99.next())
		{ String insertquery=""; 
           bc++;
		String wid=rs99.getString(1);
		double amt=rs99.getDouble(2);
		String nohabs=rs99.getString(3);
		String wname=rs99.getString(4);
		String dcode=rs99.getString(5);
		String catcode=rs99.getString(6);
        String m=rs99.getString(7); y=rs99.getString(8);
         if(nohabs!=null)
         {    
          
	       insertquery="insert into Bank_Pao_exp_porting_tbl values (?,?,?,?,?,?,?) ";
	     // System.out.println("Insert Query:"+insertquery);
	     ps9=conn.prepareStatement(insertquery);
           ps9.setString(1, wid);
           ps9.setDouble(2, amt);
           ps9.setString(3, nohabs);
           ps9.setString(4, wname);
           ps9.setString(5, dcode);
           ps9.setString(6, m);
           ps9.setString(7, catcode);
	      ps9.executeUpdate();
          
         }
         else
         {    

	       insertquery="insert into Bank_Pao_exp_porting_tbl values (?,?,'0',?,?,?,?) ";
	     // System.out.println("Insert Query:"+insertquery);
	      ps9=conn.prepareStatement(insertquery);
           ps9.setString(1, wid);
           ps9.setDouble(2, amt);
           ps9.setString(3, wname);
           ps9.setString(4, dcode);
           ps9.setString(5, m);
           ps9.setString(6, catcode); 
	     ps9.executeUpdate();

		}
          // bc+= stmt99.executeUpdate(insertquery);
//System.out.println("bcount:"+bc);
      }//End of Bank


     if(!myreptype.equals(null) && myreptype.equals("schools"))
    {
        stateQuery = "SELECT  DISTINCT A.WORK_ID, SUM(A.BILL_AMOUT_STATE),B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,SUBSTR(A.state_SEND_DATE ,4,3),SUBSTR(A.state_SEND_DATE ,8)  FROM RWS_BILL_PAO_BRIDGE_DET_TBL A, RWS_WORK_ADMN_TBL B,rws_delhi_district_list_tbl c WHERE c.dcode=substr(b.work_id,5,2) and TO_DATE(a.state_send_date,'dd-mon-yy')>='"+fromdate+"' and TO_DATE(a.state_send_date,'dd-mon-yy')<='"+todate+"' AND  A.STATE_TXID  IS NOT NULL  AND A.WORK_ID=B.WORK_ID  AND SUBSTR(A.WORK_ID,7,2)='11' GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,SUBSTR(A.state_SEND_DATE ,4,3),SUBSTR(A.state_SEND_DATE ,8)";
    }
    else
	{
        stateQuery = "SELECT  DISTINCT A.WORK_ID, SUM(A.BILL_AMOUT_STATE),B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,SUBSTR(A.state_SEND_DATE ,4,3),SUBSTR(A.state_SEND_DATE ,8)  FROM RWS_BILL_PAO_BRIDGE_DET_TBL A, RWS_WORK_ADMN_TBL B,rws_delhi_district_list_tbl c WHERE c.dcode=substr(b.work_id,5,2) and TO_DATE(a.state_send_date,'dd-mon-yy')>='"+fromdate+"' and TO_DATE(a.state_send_date,'dd-mon-yy')<='"+todate+"' AND  A.STATE_TXID  IS NOT NULL  AND A.WORK_ID=B.WORK_ID  AND SUBSTR(A.WORK_ID,7,2)<>'11' and SUBSTR(A.WORK_ID,7,2)<>'12' GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,SUBSTR(A.state_SEND_DATE ,4,3),SUBSTR(A.state_SEND_DATE ,8)";
  	}
	   System.out.println("stateQuery Query:"+stateQuery);        
       ResultSet rs88=stmt11.executeQuery(stateQuery);
       while(rs88.next())
		{  String insertquery=""; sc++;
		String wid=rs88.getString(1);
		double amt=rs88.getDouble(2);
		String nohabs=rs88.getString(3);
		String wname=rs88.getString(4);
		String dcode=rs88.getString(5);
		String catcode=rs88.getString(6);
        String m=rs88.getString(7);
        y=rs88.getString(8);
         if(nohabs!=null)
         {    

	      insertquery="insert into Bank_Pao_exp_porting_tbl values (?,?,?,?,?,?,?) ";
	      //System.out.println("Insert Query:"+insertquery);
	       PreparedStatement ps6=conn.prepareStatement(insertquery);
	       ps6.setString(1, wid);
	       ps6.setDouble(2, amt);
	       ps6.setString(3, nohabs);
	       ps6.setString(4, wname);
	       ps6.setString(5, dcode);
	       ps6.setString(6, m);
	       ps6.setString(7, catcode); 
	       ps6.executeUpdate();
         }
         else
         {    

	      insertquery="insert into Bank_Pao_exp_porting_tbl values (?,?,'0',?,?,?,?) ";
	      //System.out.println("Insert Query:"+insertquery);
	      PreparedStatement ps8=conn.prepareStatement(insertquery);
	      ps8.setString(1, wid);
	      ps8.setDouble(2, amt);
	      ps8.setString(3, wname);
	      ps8.setString(4, dcode);
	      ps8.setString(5, m);
	      ps8.setString(6, catcode);
	      ps8.executeUpdate();
      
		}
      //sc+= stmt99.executeUpdate(insertquery);
       //System.out.println("sccount:"+sc);
      }//End of State


     /////////////////////////////////////////PORTING TO MAIN TBL/////////////////////////////////////////////////////////////////////////////

        //////////////////////////before this create belwo tbl////////////////////////////////////////////////////
           
            //CREATE table rws_delhi_district_list_tbl(DistrictId varchar2(5),DistrictName varchar2(50),dcode varchar2(2));

       //////////////////////////////////////////////////////////////////////////////////
			//System.out.println("Query:" + bankQuery);
			bankQuery="select * from Bank_Pao_exp_porting_tbl";				
			rs1 = stmt.executeQuery(bankQuery);
		    //System.out.println("StaRTING Process");
             while(rs1.next())
				{ 
                 flag1=true;
                // System.out.println("Statred Process");
                String work_id=rs1.getString(1);     ///01010411120008
                //System.out.println("Work Id"+work_id);
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
			     String mvspopuLationQuery="select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_EST_NEW_HAB_LNK_TBL b,rws_delhi_district_list_tbl c where b.work_id='"+work_id+"' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode  and  a.COVERAGE_STATUS <>'UI' ";
        		 String mvsSchoolpopuLationQuery="select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_WORK_SCHOOL_LNK_TBL b ,rws_delhi_district_list_tbl c  where b.work_id='"+work_id+"' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode and a.COVERAGE_STATUS <>'UI'";
				
bankAmount+=rs1.getDouble(2);

//1 PROJECTS (mvs)
//2 NORMAL   (svs)
				   
							if(work_id.substring(6,8).equals("11")){           //FOR SCHOOLS
							 //System.out.println("mvsSchoolpopuLationQuery"+mvsSchoolpopuLationQuery);
                               rs3=stmt1.executeQuery(mvsSchoolpopuLationQuery);
												}else {
 //System.out.println("mvspopuLationQuery:"+mvspopuLationQuery);
                               rs3=stmt1.executeQuery(mvspopuLationQuery);
												}
								
// System.out.println("Amount:"+bankAmount);
long gen=0,scpop=0,stpop=0;totalp=0;
boolean flag=false;
									while(rs3.next()){

								 value1=rs3.getInt(1);	 value2=rs3.getInt(2);	 value3=rs3.getInt(3);
			districtId=rs3.getString(4);
            //System.out.println("districtId:"+districtId);
						 totalp+=value1+value2+value3; //System.out.println("Total Poplation:"+totalp);

							gen+=value1;scpop+=value2;stpop+=value3;
									flag=true;

									}
						 if(flag){
								sca+=(bankAmount*scpop)/totalp;//System.out.println("SCA Poplation:"+sca);
	      					  sta+=(bankAmount*stpop)/totalp;//System.out.println("sta Poplation:"+sta);
			   				  plaina+=(bankAmount*gen)/totalp;
							}
 sca=Math.round(sca);
 sta=Math.round(sta);
plaina=Math.round(plaina);
                		
					//NRDWP Related (100%) 

       				  if(cateGoreyCode==1){          //MVS SCHEMES
  // System.out.println("MVS SCHEME");
                      
					if(programeCode==1 || programeCode==2 || programeCode==18 || programeCode==23 || programeCode==32 || programeCode==48 || programeCode==49 || programeCode==51 || programeCode==53 || programeCode==59 || programeCode==58|| programeCode==60)
					{  

										if(programeCode==58){
									     delhiProgramName="DDP";
											}
									else if(programeCode==51){
										delhiProgramID=21;
                                        delhiProgramName="NRDWP-Water Quality";
											}else if(programeCode==60){     //(NRDWP 0&M)
										delhiProgramID=27; 
   										delhiProgramName="NRDWP ( O & M) ";
											}else if(programeCode==59){
										delhiProgramID=24;
										delhiProgramName="NRDWP-Calamities";
											}else if(programeCode==18){
										delhiProgramID=14;
										delhiProgramName="ARWSP-Submission";
											}else if(programeCode==1 && (subprogrameCode==0 || subprogrameCode==1 || subprogrameCode==2 || subprogrameCode==3 || subprogrameCode==4|| subprogrameCode==6)){
											delhiProgramID=1;
											delhiProgramName="ARWSP";
											}else{
                        				 if(subprogrameCode==5){      //ARWS 15%--(NRDWP-O & M)
	 										delhiProgramID=27;
											delhiProgramName="NRDWP ( O & M) ";
												}else{                    //NRDWP RELATED
											delhiProgramID=19;
											delhiProgramName="NRDWP-Coverage";
										 } }
 				if(work_id.substring(6,8).equals("11")){  
				insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";  //correct
							}else{
                  if(programeCode==58){
insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0')";
				}else{
				insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
					}
							}
						
					}else if(programeCode==4 || programeCode==46 || programeCode==57 || programeCode==12 || programeCode==63 || programeCode==15 || programeCode==9){
               					  //State Exp.- NABARD(04), State Plan(46), World Bank(APRWSP-WB)57, HUDCO(12), TFC(63) (100%) & GOI 0%
								switch (programeCode){
                                case 4:
										delhiProgramID=22;
										delhiProgramName="NABARD";break;
								case 46:
										delhiProgramID=15;
										delhiProgramName="State Programs";break;
								case 57:
										delhiProgramID=25;
										delhiProgramName="World Bank";break;
                                case 12:
										delhiProgramID=15;
										delhiProgramName="State Programs";break;
 								case 15:
										delhiProgramID=07;
										delhiProgramName="12th Finance Commission Grants";break;
 								case 9:
										delhiProgramID=15;
										delhiProgramName="State Programs";break;
										}

	if(work_id.substring(6,8).equals("11")){  
				insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0')";
							}else{
  
				insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							}
			
					}
		}else{                //SVS SCHEMES
   //System.out.println("SVS SCHEME");


if(programeCode==1 || programeCode==2 || programeCode==18 || programeCode==23 || programeCode==32 || programeCode==48 || programeCode==49 || programeCode==51 || programeCode==53 || programeCode==59 || programeCode==58|| programeCode==60)
					{  
                        				// if(subprogrameCode==5){      //ARWS 15%--(NRDWP-O & M)
 										//delhiProgramID=27;
											//}else if(subprogrameCode==6){ //ARWS 5%--NRDWP SUSTAINBILITY 
											//delhiProgramID=1;
											//}else{                    //NRDWP RELATED
											//delhiProgramID=19;
										 //}
									if(programeCode==58){
									     delhiProgramName="DDP";
											}
									if(programeCode==51){
										delhiProgramID=21;
										delhiProgramName="NRDWP-Water Quality";
											}else if(programeCode==60){     //(NRDWP 0&M)
										delhiProgramID=27;
									    delhiProgramName="NRDWP ( O & M) ";
											}else if(programeCode==59){
										delhiProgramID=24;
										delhiProgramName="NRDWP-Calamities";
											}else if(programeCode==18){
										delhiProgramID=14;
										delhiProgramName="ARWSP-Submission";
											}else if(programeCode==1 && (subprogrameCode==0 || subprogrameCode==1 || subprogrameCode==2 || subprogrameCode==3 || subprogrameCode==4 || subprogrameCode==6)){
											delhiProgramID=1;
                                            delhiProgramName="ARWSP";
											}else{
                        				 if(subprogrameCode==5){      //ARWS 15%--(NRDWP-O & M)
 										delhiProgramID=27;
										delhiProgramName="NRDWP ( O & M)";
											}else{                    //NRDWP RELATED
											delhiProgramID=19;
											delhiProgramName="NRDWP-Coverage";

										 } }


				
						if(subprogrameCode==0 ||subprogrameCode==1 ){
									if(work_id.substring(6,8).equals("11")){  
			insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; //correct
										}else{
                 if(programeCode==58){
insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0')";
						}else {
			insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
					}
												 }
											}else if(subprogrameCode==2){
							if(work_id.substring(6,8).equals("11")){  
     		insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							}else{
       if(programeCode==58){
			insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0')";
				 }else{
			insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
 					}
				}
												  }
											else if(subprogrameCode==3 || subprogrameCode==4){     //if we get subprogrammes other than sc,plain,st we are taken as st 
					 							if(work_id.substring(6,8).equals("11")){  
					insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
											}else{
							if(programeCode==58){ 
insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0')";
						}else {
					insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
									}
											}
								 }
else if(subprogrameCode==5 || subprogrameCode==6){     //if we get subprogrammes other than sc,plain,st we are taken as st 
					 							if(work_id.substring(6,8).equals("11")){  
					//insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
											}else{
                       if(programeCode==58){ 
			insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0')";
}else {
					insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','20"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
     }
											}
								 }

			}
}
        // System.out.println("Records inserted:"+rcount);


          //System.out.println("Insert Query:"+insertQuery);
           if(!insertQuery.equals(" ")){
            
                rcount+=stmt3.executeUpdate(insertQuery);
               
				}
insertQuery=" ";bankAmount=0;plaina=0;sca=0;sta=0;delhiProgramID=0;delhiProgramName="";
          	
				}
if(flag1==true){
           System.out.println("Records inserted:"+rcount);
           out.println("<font face=verdana align=center size=2>"+rcount+" no.of Habitations exported Successfully! <a href=rws_financial_exp_porting_xls.jsp></font><font face=verdana size=3 color=red>Click here for Excel file</a>|<a href=../home.jsp>Home</a>|</font> ");
    
//pao details

			String sno = "";

//System.out.println("months*******"+months);

////////////////////////////////////////////////////////////////////////////////////////
 
}
///////////////////////////////////////////////////////////////////////////////////////////
else{%>
<!-- <tr bgcolor="#99E6FF"><td colspan="22" align="center">No records</td></tr>-->
<script>
          alert("No Records...");
          document.f1.action="./rws_financial_exp_porting_frm.jsp";
		  document.f1.submit();
</script>
<%}
          
} catch (Exception e) {
			e.printStackTrace();

		}finally{
	     try{
         String dropqry="drop table Bank_Pao_exp_porting_tbl";
          stmt55.executeUpdate(dropqry);
          conn.setAutoCommit(true);
          System.out.println("dropqry"+dropqry);

          String dropqry1="drop table rws_delhi_district_list_tbl";
          stmtdr.executeUpdate(dropqry1);
          conn.setAutoCommit(true);
          System.out.println("dropqry1"+dropqry1);
					}catch(Exception e){
						e.printStackTrace();
					}

					}
%> 
</form>
</BODY>

