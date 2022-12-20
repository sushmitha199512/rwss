<%@page import="nic.watersoft.masters.Rws_Habitation_Safe_Suplly_Form"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<form>
<%
String mcode="",pcode="",district="",temp="",tempconst="";
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
////System.out.println("dcode**********" +dcode);
if(request.getParameter("mandal")!=null){
 mcode=request.getParameter("mandal");
session.setAttribute("mcode",mcode);}
if(request.getParameter("panchayath")!=null){
 pcode=request.getParameter("panchayath");
session.setAttribute("pcode",pcode);}
DecimalFormat ndf = new DecimalFormat("####.##");
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

session.setAttribute("m", "mandal");
String mode="";
if(request.getParameter("mode")!=null && request.getParameter("mode")!=""){
	mode=request.getParameter("mode");
}
    String qry="";
    int styleCount=0;
    String style="";
int sno=1;
int cyear = Calendar.getInstance().get(Calendar.YEAR);
int cyearb = cyear-1;

String fromdate="1-4-"+cyearb;
String todate="31-3-"+cyear;

    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<!-- <td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td> -->
	<td ><a href="#" onClick="window.close();">Close  &nbsp; </td>
	<!-- <td ><a href="#" onClick="window.close();">Close | &nbsp; </td>
	  <td><a href="./rws_asset_hab_excel.jsp">Excel</a></td>   -->
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="gridhdbg" > RWS&S-Assets with Habs Information								
- Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=0 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan="3">Sl.No</td>
    <td class=gridhdbg rowspan="3">District</td>
    <!-- <td class=gridhdbg rowspan="2">Constituency</td> -->
    <td class=gridhdbg rowspan="3">Mandal</td>
    <td class=gridhdbg rowspan="3">Panchayat</td>
    <td class=gridhdbg rowspan="3">Habitation Code/Name</td>
    <td class=gridhdbg rowspan="1" colspan="5">Population</td>
    <td class=gridhdbg rowspan="3">House Holds</td>
    <td class=gridhdbg rowspan="3">House Conn</td>
    <td class=gridhdbg rowspan="1" colspan="16">Existing Assets(No.s)-Safe & Un-Safe in lead hab</td>
  <!--  <td class=gridhdbg rowspan="1" colspan="5">Existing Assets(No.s)-Safe & Un-Safe not in lead hab</td> -->
    <td class=gridhdbg rowspan="1" colspan="2">Level of supply(LPCD)</td>
	<td class=gridhdbg rowspan="1" colspan="1">Status</td>
	<td class=gridhdbg rowspan="3" >Updated Date</td>
	<%if(mode.equals("NSS")){ %>
	<td class=gridhdbg rowspan="3">Contamination Type</td>
	<%} %>
	<td class=gridhdbg rowspan="3" >No of OHSR</td>
	<td class=gridhdbg rowspan="3" >No of GLSR</td>
	<td class=gridhdbg rowspan="1" colspan="8">Population as on 01-04-<%= cyear %> </td>
	</tr>
	<tr>
	<td class=gridhdbg rowspan="2">Plain</td>
	<td class=gridhdbg rowspan="2">SC</td>
	<td class=gridhdbg rowspan="2">ST</td>
	<td class=gridhdbg rowspan="2">Minority</td>
	<td class=gridhdbg rowspan="2">Total</td>
	<td class=gridhdbg rowspan="2">CPWS No</td>
	<td class=gridhdbg rowspan="1" colspan="1">CPWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">PWS No</td>
	<td class=gridhdbg rowspan="1" colspan="2">PWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">MPWS No</td>
	<td class=gridhdbg rowspan="1" colspan="2">MPWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">Others(Direct Pump & Open Well) No</td>
	<td class=gridhdbg rowspan="1" colspan="2">Others(Direct Pump & Open Well) Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">HP/SHP's No</td>
	<td class=gridhdbg rowspan="1" colspan="2">HP/SHP's Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">HP/SHP Not Having Platforms</td>
	<td class=gridhdbg rowspan="2">HP/SHP Not Having Soakpits</td>
	<td class=gridhdbg rowspan="2">Safe</td>
	<td class=gridhdbg rowspan="2">Un-Safe</td>
	<!-- <td class=gridhdbg rowspan="2">Previous Year</td> -->
	<td class=gridhdbg rowspan="2">Current Year</td>
	
	<td class=gridhdbg rowspan="2">Actual Plain</td>
	<td class=gridhdbg rowspan="2">Actual SC</td>
	<td class=gridhdbg rowspan="2">Actual ST</td>
	<td class=gridhdbg rowspan="2">Total</td>
	<td class=gridhdbg rowspan="2">HouseHolds </td>
	<td class=gridhdbg rowspan="2">House Connections</td>
	<td class=gridhdbg rowspan="2">Safe LPCD </td>
	<td class=gridhdbg rowspan="2">Coverage Status</td>
	
	</tr>
       <tr>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	</tr>
<%
PreparedStatement preparedStatement=null;
ResultSet  resset=null;
String actualCovStatus;
double actualSafeLPCd,totalSuppUnsafe;
try
{
	Statement st1=null,st=null,statement=null;
	ResultSet rset=null,rset1=null,resultSet=null;
	st1=conn.createStatement();
	String constqry="select distinct dcode,mcode,CONSTITUENCY_NAME,CONSTITUENCY_CODE from RWS_CONSTITUENCY_TBL where dcode='"+dcode+"' ";
	if(mcode !=null && !mcode.equals("")){
		constqry+=" and mcode='"+mcode+"'";
	}
	constqry+=" order by dcode,mcode,CONSTITUENCY_CODE";
	//System.out.println("111="+constqry);
	rset1=st1.executeQuery(constqry);
	Hashtable const_hash=new Hashtable();
	while(rset1.next()){
		const_hash.put(rset1.getString(1)+rset1.getString(2), rset1.getString(3));
	}
	if(rset1!=null){
		rset1.close();
	}
	if(st1!=null){
		st1.close();
	}
	
	st1=conn.createStatement();
	String assetqry="select hab_code,TYPE_OF_ASSET_NAME,count(1) from RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b,rws_complete_hab_dyna_view c where a.hab_code=c.panch_code and a.TYPE_OF_ASSET_code=b.TYPE_OF_ASSET_code and substr(hab_code,1,2)='"+dcode+"'";
	if(mcode !=null && !mcode.equals("")){
		assetqry+=" and substr(hab_code,6,2)='"+mcode+"'";
	}
	if(pcode !=null && !pcode.equals("")){
		assetqry+=" and substr(hab_code,13,2)='"+pcode+"'";
	}
	if(mode !=null && !mode.equals("")){
		assetqry+=" and coverage_status='"+mode+"'";
	}
	assetqry+=" group by hab_code,TYPE_OF_ASSET_NAME";
	//System.out.println("333="+assetqry);
	rset1=st1.executeQuery(assetqry);
	Hashtable asset_hash=new Hashtable();
	while(rset1.next()){
		asset_hash.put(rset1.getString(1)+rset1.getString(2), rset1.getInt(3));
	}
	if(rset1!=null){
		rset1.close();
	}
	if(st1!=null){
		st1.close();
	}
	
	st1=conn.createStatement();
	String neassetqry="select c.hab_code,TYPE_OF_ASSET_NAME,count(distinct a.asset_code) from RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b,RWS_ASSET_HAB_TBL c where a.TYPE_OF_ASSET_code=b.TYPE_OF_ASSET_code and a.asset_code=c.asset_code and substr(c.hab_code,1,2)='"+dcode+"'";
	if(mcode !=null && !mcode.equals("")){
		neassetqry+=" and substr(c.hab_code,6,2)='"+mcode+"'";
	}
	if(pcode !=null && !pcode.equals("")){
		neassetqry+=" and substr(c.hab_code,13,2)='"+pcode+"'";
	}
	neassetqry+=" group by c.hab_code,TYPE_OF_ASSET_NAME";
	//System.out.println("444="+neassetqry);
	rset1=st1.executeQuery(neassetqry);
	Hashtable neasset_hash=new Hashtable();
	while(rset1.next()){
		neasset_hash.put(rset1.getString(1)+rset1.getString(2), rset1.getInt(3));
	}
	if(rset1!=null){
		rset1.close();
	}
	if(st1!=null){
		st1.close();
	}
	
	String mainqry="select dname,nvl(mname,'-'),nvl(pname,'-'),panch_code,nvl(panch_name,'-'),nvl(a.CENSUS_PLAIN_POPU,0),nvl(a.CENSUS_SC_POPU,0),nvl(a.CENSUS_ST_POPU,0),nvl(a.CENSUS_PLAIN_POPU,0)+nvl(a.CENSUS_SC_POPU,0)+nvl(a.CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0),nvl(a.SAFE_LPCD,0),nvl(a.UNSAFE_LPCD,0),nvl(a.PREVIOUS_YR_STATUS,'-'),nvl(a.coverage_status,'-'),dcode,mcode,pcode,panch_code,nvl(CENSUS_MINORITY_POPU,0) as minority,nvl(b.ACT_HOUSE_CONN,0) as ACT_HOUSE_CONN,nvl(b.ACT_HOUSE_HOLD,0) as ACT_HOUSE_HOLD,nvl(b.ACT_ST_POPU,0) as ACT_ST_POPU,nvl(b.ACT_PLAIN_POPU,0) as ACT_PLAIN_POPU,nvl(b.ACT_SC_POPU,0) as ACT_SC_POPU,nvl(b.ACT_TOT_POPU,0) as ACT_TOT_POPU,nvl(b.LPCD_ACT_POPU,0) as LPCD_ACT_POPU,nvl(b.ACT_COVERAGE_STATUS,'--') as ACT_COVERAGE_STATUS,nvl(b.GLSR_NO,0) as glsrTotal,nvl(b.OHSR_NO,0) as ohsrTotal  from rws_complete_hab_dyna_view a,rws_habitation_dir_dyna_tbl b where a.panch_code=b.hab_code and dcode='"+dcode+"' ";
	if(mcode !=null && !mcode.equals("")){
		mainqry+=" and mcode='"+mcode+"'";
	}
	if(pcode !=null && !pcode.equals("")){
		mainqry+=" and pcode='"+pcode+"'";
	}
	if(mode !=null && !mode.equals("")){
		mainqry+=" and a.coverage_status='"+mode+"'";
	}
	mainqry+=" order by dcode,mcode,pcode";
	//System.out.println("222="+mainqry);
	st=conn.createStatement();
rset=st.executeQuery(mainqry);
while(rset.next()){
	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	 int cpwscnt=0,pwscnt=0,mpwscnt=0,dpcnt=0,hpcnt=0,shpcnt=0,owcnt=0;
	 int necpwscnt=0,nepwscnt=0,nempwscnt=0,nedpcnt=0,nehpcnt=0,neshpcnt=0;
	 String constname="-";
	 if(const_hash.get(rset.getString(14)+rset.getString(15))!=null){
		 constname=(String)const_hash.get(rset.getString(14)+rset.getString(15));
	 }
	 if(asset_hash.get(rset.getString(4)+"CPWS")!=null){
		 cpwscnt=(Integer)asset_hash.get(rset.getString(4)+"CPWS");
	 }
	 if(asset_hash.get(rset.getString(4)+"PWS")!=null){
		 pwscnt=(Integer)asset_hash.get(rset.getString(4)+"PWS");
	 }
	 if(asset_hash.get(rset.getString(4)+"MPWS")!=null){
		 mpwscnt=(Integer)asset_hash.get(rset.getString(4)+"MPWS");
	 }
	 if(asset_hash.get(rset.getString(4)+"DIRECT PUMPING")!=null){
		 dpcnt=(Integer)asset_hash.get(rset.getString(4)+"DIRECT PUMPING");
	 }
	 if(asset_hash.get(rset.getString(4)+"HANDPUMPS")!=null){
		 hpcnt=(Integer)asset_hash.get(rset.getString(4)+"HANDPUMPS");
	 }
	 if(asset_hash.get(rset.getString(4)+"SHALLOW HAND PUMPS")!=null){
		 shpcnt=(Integer)asset_hash.get(rset.getString(4)+"SHALLOW HAND PUMPS");
	 }
	 if(asset_hash.get(rset.getString(4)+"OPEN WELLS")!=null){
		 owcnt=(Integer)asset_hash.get(rset.getString(4)+"OPEN WELLS");
	 }
	 int pwssafe=0,pwsunsafe=0,mpwssafe=0,mpwsunsafe=0,cpwssafe=0,cpwsunsafe=0,hpsafe=0,hpunsafe=0,shpsafe=0,shpunsafe=0,othsafe=0,othunsafe=0;
	 String pws="select sum(PWS_SUPPLY),sum(PWS_HAB_SUPPLY),sum(PWS_UNSAFE_SUPPLY),sum(MPWS_SUPPLY),sum(MPWS_HAB_SUPPLY),sum(MPWS_UNSAFE_SUPPLY),sum(CPWS_SUPPLY),sum(CPWS_HAB_SUPPLY),sum(HPS_OTH_SUPPLY),sum(HPS_OTH_SUPPLY_UNSAFE),sum(SHP_DK_SUPPLY_SAFE),sum(SHP_DK_SUPPLY),sum(OTHERS_SUPPLY_SAFE),sum(DP_HAB_SUPPLY),sum(OTHERS_SUPPLY) from rws_hab_supply_status_tbl a,rws_complete_hab_dyna_view c where a.hab_code=c.panch_code and hab_code='"+rset.getString(4)+"'";
	//System.out.println("pws----"+pws);
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(pws);
	 if(resultSet.next()){
		 pwssafe=resultSet.getInt(1)+resultSet.getInt(2);
		 pwsunsafe=resultSet.getInt(3);
		 mpwssafe=resultSet.getInt(4)+resultSet.getInt(5);
		 mpwsunsafe=resultSet.getInt(6);
		 cpwssafe=resultSet.getInt(7)+resultSet.getInt(8);
		 hpsafe=resultSet.getInt(9);
		 hpunsafe=resultSet.getInt(10);
		 shpsafe=resultSet.getInt(11);
		 shpunsafe=resultSet.getInt(12);
		 othsafe=resultSet.getInt(13)+resultSet.getInt(14);
		 othunsafe=resultSet.getInt(15);
		 
	 }
	 statement.close();
	 resultSet.close();
	 
	 
	 int households=0,houseconn=0;
	 String date="";
	 String house="select HOUSEHOLD_NO,NO_OF_HOUSECONN_GIVEN,nvl(to_char(UPDATE_DATE,'dd/mm/yyyy'),'--') from rws_habitation_dir_dyna_tbl a,rws_complete_hab_dyna_view c where a.hab_code=c.panch_code and hab_code='"+rset.getString(4)+"'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(house);
	 if(resultSet.next()){
		 households=resultSet.getInt(1);
		 houseconn=resultSet.getInt(2);
		 date=resultSet.getString(3);
		
		 
	 }
	 statement.close();
	 resultSet.close();
	 
	 int platforms=0;
	 String hpplatform="select count(PLATFORM_EXISTING) from RWS_HP_SUBCOMP_PARAM_TBL a,rws_complete_hab_dyna_view c where substr(hp_code,1,16)=c.panch_code and substr(hp_code,1,16)='"+rset.getString(4)+"' and PLATFORM_EXISTING='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(hpplatform);
	 if(resultSet.next()){
		 platforms+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 String shpplatform="select count(PLATFORM_EXISTING) from RWS_SHALLOWHANDPUMPS_TBL a,rws_complete_hab_dyna_view c where a.hab_code=c.panch_code and hab_code='"+rset.getString(4)+"' and PLATFORM_EXISTING='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(shpplatform);
	 if(resultSet.next()){
		 platforms+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 
	 int soakpit=0;
	 String hpsoakpits="select count(SOAK_PIT) from RWS_HP_SUBCOMP_PARAM_TBL a,rws_complete_hab_dyna_view c where substr(hp_code,1,16)=c.panch_code and substr(hp_code,1,16)='"+rset.getString(4)+"' and SOAK_PIT='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(hpsoakpits);
	 if(resultSet.next()){
		 soakpit+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 String shpsoakpits="select count(SOAK_PIT) from RWS_SHALLOWHANDPUMPS_TBL a,rws_complete_hab_dyna_view c where a.hab_code=c.panch_code and hab_code='"+rset.getString(4)+"' and SOAK_PIT='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(shpsoakpits);
	 if(resultSet.next()){
		 soakpit+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 String typeOfContamination="--";
	 
	 if(mode.equals("NSS")){
		 Rws_Habitation_Safe_Suplly_Form suplly_Form=null;
	 ArrayList  sources=new ArrayList();
		if(rset.getString(13).equals("NSS")){
			//				 String query="select to_char(max(prepared_on),'dd/mm/yyyy'),source_code from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and substr(source_code,1,16)='"+rset.getString(4)+"' and prepared_on>=to_date('01/01/2014','dd/mm/yyyy') group by source_code order by max(prepared_on) desc";

				 			 String query="select to_char(max(prepared_on),'dd/mm/yyyy'),source_code from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and substr(source_code,1,16)='"+rset.getString(4)+"' and to_date(to_char(prepared_on,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and to_date(to_char(prepared_on,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy')  group by source_code order by max(prepared_on) desc";

			     statement=conn.createStatement();
				 resultSet=statement.executeQuery(query);
				 while(resultSet.next()){
					 suplly_Form=new Rws_Habitation_Safe_Suplly_Form();					
					 String prepared_on=resultSet.getString(1);
					 String source_code=resultSet.getString(2);
					 suplly_Form.setPreparedOn(prepared_on);
					 suplly_Form.setSourceType(source_code);
					 sources.add(suplly_Form);
					 String flouride="SELECT A.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='13' AND a.TESTING_PARAMETER_CODE=c.TESTING_PARAMETER_CODE AND B.TEST_CODE=c.TEST_CODE AND to_number(TRIM(a.TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
					 preparedStatement=conn.prepareStatement(flouride);
					 preparedStatement.setString(1, source_code);
					 preparedStatement.setString(2, prepared_on);
					 resset=preparedStatement.executeQuery();
					 if(resset.next()){
						 typeOfContamination="FLOURIDE"; 
					 }
					 resset.close();
					 preparedStatement.close();
				 }
				 statement.close();
				 resultSet.close();
				 
				 if(typeOfContamination.equals("--")){
					 /* statement=conn.createStatement();
					 resultSet=statement.executeQuery(query); */
					 Iterator iterator=sources.iterator();
					 while(iterator.hasNext()){						 
						 suplly_Form=(Rws_Habitation_Safe_Suplly_Form)iterator.next();
						 String prepared_on=suplly_Form.getPreparedOn();
						 String source_code=suplly_Form.getSourceType();						 
						 String brakish="SELECT A.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='05' AND a.TESTING_PARAMETER_CODE=c.TESTING_PARAMETER_CODE AND B.TEST_CODE=c.TEST_CODE AND to_number(TRIM(a.TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
						 preparedStatement=conn.prepareStatement(brakish);
						 preparedStatement.setString(1, source_code);
						 preparedStatement.setString(2, prepared_on);
						 resset=preparedStatement.executeQuery();
						 if(resset.next()){
							 typeOfContamination="BRAKISH"; 
						 }
						 resset.close();
						 preparedStatement.close();
					 }
					 /* statement.close();
					 resultSet.close(); */
				 }
				
				  if(typeOfContamination.equals("--")){
					/*  statement=conn.createStatement();
					 resultSet=statement.executeQuery(query); */
					 Iterator iterator=sources.iterator();
					 while(iterator.hasNext()){
						 
						 suplly_Form=(Rws_Habitation_Safe_Suplly_Form)iterator.next();
						 String prepared_on=suplly_Form.getPreparedOn();
						 String source_code=suplly_Form.getSourceType();						 
						 String brakish="SELECT A.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='16' AND a.TESTING_PARAMETER_CODE=c.TESTING_PARAMETER_CODE AND B.TEST_CODE=c.TEST_CODE AND to_number(TRIM(a.TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
						 preparedStatement=conn.prepareStatement(brakish);
						 preparedStatement.setString(1, source_code);
						 preparedStatement.setString(2, prepared_on);
						 resset=preparedStatement.executeQuery();
						 if(resset.next()){
							 typeOfContamination="IRON"; 
						 }
						 resset.close();
						 preparedStatement.close();
					 }
					 /* statement.close();
				     resultSet.close(); */
				 }
				
				  
				  if(typeOfContamination.equals("--")){
						/*  statement=conn.createStatement();
						 resultSet=statement.executeQuery(query); */
						 Iterator iterator=sources.iterator();
						 while(iterator.hasNext()){
							 
							 suplly_Form=(Rws_Habitation_Safe_Suplly_Form)iterator.next();
							 String prepared_on=suplly_Form.getPreparedOn();
							 String source_code=suplly_Form.getSourceType();
							 
							 String brakish="SELECT A.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='15' AND a.TESTING_PARAMETER_CODE=c.TESTING_PARAMETER_CODE AND B.TEST_CODE=c.TEST_CODE AND to_number(TRIM(a.TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
							 preparedStatement=conn.prepareStatement(brakish);
							 preparedStatement.setString(1, source_code);
							 preparedStatement.setString(2, prepared_on);
							 resset=preparedStatement.executeQuery();
							 if(resset.next()){
								 typeOfContamination="NITRATE"; 
							 }
							 resset.close();
							 preparedStatement.close();
						 }
						 /* statement.close();
						 resultSet.close(); */
					 }
				//NSS hab with Linkage
				  if(typeOfContamination.equals("--")){
				  String nsshablink="select to_char(max(prepared_on),'dd/mm/yyyy'),a.source_code from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b,RWS_SOURCE_HABITATION_TBL c where a.test_id=b.test_id and a.source_code=c.source_code AND TEST_CODE='1' and HAB_CODE='"+rset.getString(4)+"' and prepared_on>=to_date('01/01/2014','dd/mm/yyyy') group by a.source_code order by max(prepared_on) desc ";
				  System.out.println(nsshablink);
					 statement=conn.createStatement();
					 resultSet=statement.executeQuery(nsshablink);
					 while(resultSet.next()){
						 suplly_Form=new Rws_Habitation_Safe_Suplly_Form();
						
						 String prepared_on=resultSet.getString(1);
						 String source_code=resultSet.getString(2);
						 suplly_Form.setPreparedOn(prepared_on);
						 suplly_Form.setSourceType(source_code);
						 sources.add(suplly_Form);
						 String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='13' AND A.TESTING_PARAMETER_VALUE > 1.5 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
						System.out.println(flouride);
						 preparedStatement=conn.prepareStatement(flouride);
						 preparedStatement.setString(1, source_code);
						 preparedStatement.setString(2, prepared_on);
						 resset=preparedStatement.executeQuery();
						 if(resset.next()){
							 typeOfContamination="FLOURIDE"; 
						 }
						 resset.close();
						 preparedStatement.close();
					 }
					 statement.close();
					 resultSet.close();
					 
					 if(typeOfContamination.equals("--")){
						 /* statement=conn.createStatement();
						 resultSet=statement.executeQuery(query); */
						 Iterator iterator=sources.iterator();
						 while(iterator.hasNext()){
							 
							 suplly_Form=(Rws_Habitation_Safe_Suplly_Form)iterator.next();
							 String prepared_on=suplly_Form.getPreparedOn();
							 String source_code=suplly_Form.getSourceType();
							 
							 String brakish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='05' AND A.TESTING_PARAMETER_VALUE > 2000 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
							 System.out.println(brakish);
							 preparedStatement=conn.prepareStatement(brakish);
							 preparedStatement.setString(1, source_code);
							 preparedStatement.setString(2, prepared_on);
							 resset=preparedStatement.executeQuery();
							 if(resset.next()){
								 typeOfContamination="BRAKISH"; 
							 }
							 resset.close();
							 preparedStatement.close();
						 }
						 /* statement.close();
						 resultSet.close(); */
					 }
					
					  if(typeOfContamination.equals("--")){
						/*  statement=conn.createStatement();
						 resultSet=statement.executeQuery(query); */
						 Iterator iterator=sources.iterator();
						 while(iterator.hasNext()){
							 
							 suplly_Form=(Rws_Habitation_Safe_Suplly_Form)iterator.next();
							 String prepared_on=suplly_Form.getPreparedOn();
							 String source_code=suplly_Form.getSourceType();
							 
							 String brakish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='16' AND A.TESTING_PARAMETER_VALUE > 1 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
							 System.out.println(brakish);
							 preparedStatement=conn.prepareStatement(brakish);
							 preparedStatement.setString(1, source_code);
							 preparedStatement.setString(2, prepared_on);
							 resset=preparedStatement.executeQuery();
							 if(resset.next()){
								 typeOfContamination="IRON"; 
							 }
							 resset.close();
							 preparedStatement.close();
						 }
						 /* statement.close();
					     resultSet.close(); */
					 }
					
					  
					  if(typeOfContamination.equals("--")){
							/*  statement=conn.createStatement();
							 resultSet=statement.executeQuery(query); */
							 Iterator iterator=sources.iterator();
							 while(iterator.hasNext()){
								 
								 suplly_Form=(Rws_Habitation_Safe_Suplly_Form)iterator.next();
								 String prepared_on=suplly_Form.getPreparedOn();
								 String source_code=suplly_Form.getSourceType();
								 
								 String brakish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='15' AND A.TESTING_PARAMETER_VALUE > 45 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
								 System.out.println(brakish);
								 preparedStatement=conn.prepareStatement(brakish);
								 preparedStatement.setString(1, source_code);
								 preparedStatement.setString(2, prepared_on);
								 resset=preparedStatement.executeQuery();
								 if(resset.next()){
									 typeOfContamination="NITRATE"; 
								 }
								 resset.close();
								 preparedStatement.close();
							 }
							 /* statement.close();
							 resultSet.close(); */
						 }
				  }
				  
			}
	 }
	 
	 
	 if(neasset_hash.get(rset.getString(4)+"CPWS")!=null){
		 necpwscnt=(Integer)neasset_hash.get(rset.getString(4)+"CPWS");
	 }
	 if(neasset_hash.get(rset.getString(4)+"PWS")!=null){
		 nepwscnt=(Integer)neasset_hash.get(rset.getString(4)+"PWS");
	 }
	 if(neasset_hash.get(rset.getString(4)+"MPWS")!=null){
		 nempwscnt=(Integer)neasset_hash.get(rset.getString(4)+"MPWS");
	 }
	 if(neasset_hash.get(rset.getString(4)+"DIRECT PUMPING")!=null){
		 nedpcnt=(Integer)neasset_hash.get(rset.getString(4)+"DIRECT PUMPING");
	 }
	 if(neasset_hash.get(rset.getString(4)+"HANDPUMPS")!=null){
		 nehpcnt=(Integer)neasset_hash.get(rset.getString(4)+"HANDPUMPS");
	 }
	 if(neasset_hash.get(rset.getString(4)+"SHALLOW HAND PUMPS")!=null){
		 neshpcnt=(Integer)neasset_hash.get(rset.getString(4)+"SHALLOW HAND PUMPS");
	 }
	 
	 district=rset.getString(1);
	 if(district.equals(temp)){
		 district="-";	 
	 }else{
		 district=rset.getString(1); 
	 }
	 
	
	%>
	<tr>
		 <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
		 <td class="<%=style%> "style="text-align: left;"> <%=district%></td>
		 <%-- <td class="<%=style%> "style="text-align: left;"> <%=constname%></td> --%>
		 <td class="<%=style%> "style="text-align: left;"> <%=rset.getString(2)%></td>
		 <td class="<%=style%> "style="text-align: left;"> <%=rset.getString(3)%></td>
		 <td class="<%=style%> "style="text-align: left;"> <%=rset.getString(4)%>/<%=rset.getString(5)%></td>
		 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt(6)%></td>
		 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt(7)%></td>
		 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt(8)%></td>
		 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt("minority")%></td>
		 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt(9)%></td>
		 <td class="<%=style%> "style="text-align: right;"> <%=households%></td>
		 <td class="<%=style%> "style="text-align: right;"> <%=houseconn%></td>
		 <td class="<%=style%> "style="text-align: right;"><%=cpwscnt %></td>
		 <td class="<%=style%> "style="text-align: right;"><%=cpwssafe %></td>
		<td class="<%=style%> "style="text-align: right;"><%=pwscnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=pwssafe %></td>
		<td class="<%=style%> "style="text-align: right;"><%=pwsunsafe %></td>
		<td class="<%=style%> "style="text-align: right;"><%=mpwscnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=mpwssafe %></td>
		<td class="<%=style%> "style="text-align: right;"><%=mpwsunsafe %></td>
		<td class="<%=style%> "style="text-align: right;"><%=dpcnt+owcnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=othsafe %></td>
		<td class="<%=style%> "style="text-align: right;"><%=othunsafe %></td>
		<td class="<%=style%> "style="text-align: right;"><%=hpcnt+shpcnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=hpsafe+shpsafe %></td>
		<td class="<%=style%> "style="text-align: right;"><%=hpunsafe+shpunsafe %></td>
		<td class="<%=style%> "style="text-align: right;"><%=platforms %></td>
		<td class="<%=style%> "style="text-align: right;"><%=soakpit %></td>
		<td class="<%=style%> "style="text-align: right;"> <%=rset.getDouble(10)%></td>
		<td class="<%=style%> "style="text-align: right;"> <%=rset.getDouble(11)%></td>
		<%-- <td class="<%=style%> "style="text-align: right;"> <%=rset.getString(12)%></td> --%>
		<td class="<%=style%> "style="text-align: right;"> <%=rset.getString(13)%></td>
		<td class="<%=style%> "style="text-align: right;"> <%=date%></td>
	 	<%if(mode.equals("NSS")){ %>
		<td class="<%=style%> "style="text-align: right;"> <%=typeOfContamination%></td>
		<%} %>
		 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt("ohsrTotal")%></td>
	 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt("glsrTotal")%></td>
		<td class="<%=style%> "style="text-align: right;"> <%=rset.getInt("ACT_PLAIN_POPU")%></td>
		<td class="<%=style%> "style="text-align: right;"> <%=rset.getInt("ACT_SC_POPU")%></td>
		<td class="<%=style%> "style="text-align: right;"> <%=rset.getInt("ACT_ST_POPU")%></td>
		<td class="<%=style%> "style="text-align: right;"> <%=rset.getInt("ACT_TOT_POPU")%></td>
		<td class="<%=style%> "style="text-align: right;"> <%=rset.getInt("ACT_HOUSE_HOLD")%></td>
		<td class="<%=style%> "style="text-align: right;"> <%=rset.getInt("ACT_HOUSE_CONN")%></td>
	 <td class="<%=style%> "style="text-align: right;"> <%=rset.getDouble("LPCD_ACT_POPU")%></td>
	 <% 
	 actualCovStatus = rset.getString("ACT_COVERAGE_STATUS");

	 if(actualCovStatus.equals("--")){
		 actualSafeLPCd = rset.getDouble("LPCD_ACT_POPU");

		 if(actualSafeLPCd <=0 ||  rset.getInt("ACT_TOT_POPU") <= 0)
		{
			actualCovStatus = "--";
			
		} else
		 if(actualSafeLPCd>0){
			 	
					//alert(lpcd_new_value+'andhra');
					if(actualSafeLPCd>0 && actualSafeLPCd<13.75)
					{
						actualCovStatus = "PC1";
					}
					else if(actualSafeLPCd>=13.75 && actualSafeLPCd<27.50)
					{
						actualCovStatus = "PC2";
					}
					else if(actualSafeLPCd>=27.50 && actualSafeLPCd<41.25)
					{
						actualCovStatus = "PC3";
					}
					else if(actualSafeLPCd>=41.25 && actualSafeLPCd<55)
					{
						actualCovStatus = "PC4";
					}
					else if(actualSafeLPCd>=55)
					{
						actualCovStatus = "FC";
					}
				
				
		 } else
			{
				//alert(lpcd_new_value+'and');
				totalSuppUnsafe = rset.getDouble(11);
				if(totalSuppUnsafe==0)
					actualCovStatus = "NC";
				else  if(totalSuppUnsafe>0)
					actualCovStatus = "NSS";
			} 
		 }%>
	 <td class="<%=style%> "style="text-align: right;"> <%=actualCovStatus%></td>
	
	</tr>
	
	<%temp=rset.getString(1);
}
if(rset!=null){
	rset.close();
}
if(st!=null){
	st.close();
}
}catch(Exception e)
		{
		e.printStackTrace();
		System.out.println("Exception in rws_asset_hab_rpt"+e);
		}finally{
			if(conn!=null)
				conn.close();
		}


%>
  
   
</table>
<table ALIGN=CENTER>
<tr>
					<td>
					<font color="green" size="2">Note:</font>
					
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">1. if Coverage status as on 1.4.2020 is "--" then please re-save the coverage automation form after checking actual total population and safe lpcd as 1.4.2020 values is not 0  </font>
					</td>
					</tr> 
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p><%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>