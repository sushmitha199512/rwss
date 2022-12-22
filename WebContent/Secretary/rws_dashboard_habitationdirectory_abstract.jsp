
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript"
	src="/pred/resources/javascript/tinybox.js"></script>
<script type="text/javascript">
function viewReport(URL){
	
	 TINY.box.show({url:URL,boxid:'frameless',width:1000,height:600,fixed:true,maskid:'bluemask',maskopacity:40,closejs:function(){embedVisible();closeJS()}});

}
</script>

<%

DecimalFormat ndf = new DecimalFormat("####.##");

		String name = request.getParameter("name");
		String type = request.getParameter("type");
		
		String query = "";
		java.util.Date currentDate = new java.util.Date();
		int cyear = currentDate.getYear() + 1900;
		int pyear = currentDate.getYear() + 1900 - 1;
         String finYear=(String)request.getParameter("finYear");
         session.setAttribute("finYear",finYear);
         session.setAttribute("name",name);
         session.setAttribute("type",type);
         
         
         nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
         String userid = users.getUserId();
         String officeCode=users.getOfficeCode();
            
         
         
         
         
         
String fyears[]=finYear.split("-");


String habtable = "RWS_HABITATION_DIRECTORY_TBL";
if (finYear != null) {
	String fy = fyears[0].substring(2, 4);

	if (fyears[0].equals(String.valueOf(cyear))) {
		habtable = "RWS_HABITATION_DIRECTORY_TBL";
	} else if (fyears[0].equals(String.valueOf(pyear))) {
		habtable = "RWS_HABITATION_DIR_HIS_TBL";
	} else if (Integer.parseInt(fyears[0]) > 2005) {
		habtable = "RWS_HABITATION_DIR_HIS" + fyears[0] + "_TBL";
	} else {
		habtable = "RWS_HABITATION_DIRECTORY_TBL";
	}
}
		if (name!=null && name.equals("Mandals") && type.equals("01")) {
			query = "select d.dname,count(*),d.dcode from rws_district_tbl d,rws_mandal_tbl m where d.dcode=m.dcode group by d.dname,d.dcode order by d.dname";
		} else if (name.equals("Panchayats") && type.equals("02")) {
			query = "select dname,count(distinct dcode||mcode||pcode),dcode  from rws_complete_hab_View group by dcode,dname";
		} else if (name.equals("Villages") && type.equals("03")) {
			query = "select dname,count(distinct dcode||mcode||pcode||vcode),dcode  from rws_complete_hab_View group by dcode,dname"; 
		} else if (name.equals("Habitations") && type.equals("04")) {
			query = "select  d.dname,count(*),d.dcode from rws_district_tbl d,rws_complete_hab_view h ,"+habtable+" ch  where  ch.hab_code=h.panch_code and d.dcode=h.dcode group by d.dname,d.dcode order by d.dname";
		} else if (name.equals("HabitationFC") && type.equals("05")) {
			query = "select  d.dname,count(*),d.dcode from rws_district_tbl d,rws_complete_hab_view h,"+habtable+" ch  where  ch.hab_code=h.panch_code and  d.dcode=h.dcode and ch.safe_lpcd>=55 group by d.dname,d.dcode order by d.dname";
		} else if (name.equals("HabitationPC4") && type.equals("06")) {
			query = "select  d.dname,count(*),d.dcode from rws_district_tbl d,rws_complete_hab_view h ,"+habtable+" ch  where  ch.hab_code=h.panch_code and  d.dcode=h.dcode and ch.safe_lpcd>=41.25 and ch.safe_lpcd<55  group by d.dname,d.dcode order by d.dname";
		} else if (name.equals("HabitationPC3") && type.equals("07")) {
			query = "select  d.dname,count(*),d.dcode from rws_district_tbl d,rws_complete_hab_view h ,"+habtable+" ch  where  ch.hab_code=h.panch_code and  d.dcode=h.dcode and ch.safe_lpcd>=27.50 and ch.safe_lpcd<41.25  group by d.dname,d.dcode order by d.dname";
		} else if (name.equals("HabitationPC2") && type.equals("08")) {
			query = "select  d.dname,count(*),d.dcode from rws_district_tbl d,rws_complete_hab_view h ,"+habtable+" ch  where  ch.hab_code=h.panch_code and  d.dcode=h.dcode and ch.safe_lpcd>=13.75 and ch.safe_lpcd<27.50 group by d.dname,d.dcode order by d.dname";
		} else if (name.equals("HabitationPC1") && type.equals("09")) {
			query = "select  d.dname,count(*),d.dcode from rws_district_tbl d,rws_complete_hab_view h ,"+habtable+" ch  where  ch.hab_code=h.panch_code and  d.dcode=h.dcode and ch.safe_lpcd>0 and ch.safe_lpcd<13.75  group by d.dname,d.dcode order by d.dname";
		} else if (name.equals("HabitationNSS") && type.equals("10")) {
			query = "select  d.dname,count(*),d.dcode from rws_district_tbl d,rws_complete_hab_view h ,"+habtable+" ch  where  ch.hab_code=h.panch_code and  d.dcode=h.dcode and ch.safe_lpcd=0 and ch.unsafe_lpcd<>0  group by d.dname,d.dcode order by d.dname";
		} else if (name.equals("HabitationNC") && type.equals("11")) {
			query = "select  d.dname,count(*),d.dcode from rws_district_tbl d,rws_complete_hab_view h ,"+habtable+" ch  where  ch.hab_code=h.panch_code and  d.dcode=h.dcode and ch.safe_lpcd=0 and ch.unsafe_lpcd=0 group by d.dname,d.dcode order by d.dname";
		} else if (name.equals("PWS") && type.equals("12")) {
			//query = "SELECT h.dname,COUNT(*),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' and  SUBSTR(SCHEME_CODE,17,3) LIKE '6%' and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "' group by h.dname,h.dcode order by h.dname";
			query = "SELECT h.dname,count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE M.TYPE_OF_ASSET_CODE='01'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"+ fyears[1]+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
		} else if (name.equals("MPWS") && type.equals("13")) {
			//query = "SELECT h.dname,COUNT(*),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' and  (SUBSTR(SCHEME_CODE,17,3) LIKE '40%' or SUBSTR(SCHEME_CODE,17,3) LIKE '41%' or SUBSTR(SCHEME_CODE,17,3) LIKE '42%' or SUBSTR(SCHEME_CODE,17,3) LIKE '43%' or SUBSTR(SCHEME_CODE,17,3) LIKE '44%')  and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "'group by h.dname,h.dcode order by h.dname";
			query = "SELECT h.dname,count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE  M.TYPE_OF_ASSET_CODE='02'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"+ fyears[1]+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
		} else if (name.equals("CPWS") && type.equals("14")) {
			//query = "SELECT h.dname,COUNT(*),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='03' and  SUBSTR(SCHEME_CODE,17,3) LIKE '8%' and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "'group by h.dname,h.dcode order by h.dname";
			query = "SELECT h.dname,count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE M.TYPE_OF_ASSET_CODE='03'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"+ fyears[1]+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
		} else if (name.equals("HandPumps") && type.equals("15")) {
			//query = "SELECT h.dname,COUNT(*),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='04' and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%'or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%') and  M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "'group by h.dname,h.dcode order by h.dname";
			query = "SELECT h.dname,count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE M.TYPE_OF_ASSET_CODE='04'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"+ fyears[1]+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
		} else if (name.equals("Labs") && type.equals("16")) {
			query = "select dname,count(*),dcode from rws_water_quality_lab_tbl,rws_district_tbl where substr(office_code,2,2)=dcode and status<>'UI' group by dname,dcode order by dname";
		} else if (name.equals("PhysicoChemical") && type.equals("17")) {
			query = "select dname,count(*),dcode from RWS_WQ_TEST_RESULTS_TBL r,rws_district_tbl  where substr(r.source_code,1,2)=dcode  and test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+"' group by dname,dcode order by dname";
		} else if (name.equals("Bacteriological") && type.equals("18")) {
			query = "select dname,count(*),dcode from RWS_WQ_TEST_RESULTS_TBL r,rws_district_tbl  where substr(r.source_code,1,2)=dcode  and test_code='2' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+"' group by dname,dcode order by dname";
		} else if (name.equals("TotSources") && type.equals("19")) {
			query="select dname,count(distinct source_code),dcode from RWS_WQ_TEST_RESULTS_TBL r,rws_district_tbl d where substr(r.source_code,1,2)=dcode  and  to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+ "' group by dname,dcode order by dname";
		}
		else if (name.equals("Flouride") && type.equals("20")) {
			query="select dname,count(distinct source_code),dcode from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l,rws_district_tbl d where substr(r.source_code,1,2)=dcode  and r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='13' AND TESTING_PARAMETER_VALUE > 1.5) group by dname,dcode order by dname";
		} 
		else if (name.equals("Brakish") && type.equals("21")) {
			query="select dname,count(distinct source_code),dcode from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l,rws_district_tbl d where substr(r.source_code,1,2)=dcode  and r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='05' AND TESTING_PARAMETER_VALUE > 2000) group by dname,dcode order by dname";
		} 
		else if (name.equals("Iron") && type.equals("22")) {
			query="select dname,count(distinct source_code),dcode from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l,rws_district_tbl d where substr(r.source_code,1,2)=dcode  and r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='16' AND TESTING_PARAMETER_VALUE > 0.3) group by dname,dcode order by dname";
		}
		else if (name.equals("Nitrate") && type.equals("23")) {
			query="select dname,count(distinct source_code),dcode from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l,rws_district_tbl d where substr(r.source_code,1,2)=dcode  and r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='15' AND TESTING_PARAMETER_VALUE > 45) group by dname,dcode order by dname";
		}

	%>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<tr >
		<td align="center" class="gridhdbg" ><%=name %></td><td align="right" class="gridhdbg" ></td>
</tr>
</table>
<table   bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>

<%if (name.equals("Mandals") && type.equals("01")) {%>
<td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Mandals</b></td>
<% }%>


<%if (name.equals("Panchayats") && type.equals("02")) { %>
  <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Panchayats</b></td>
<% }%>

<%if (name.equals("Villages") && type.equals("03")) { %>
  <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Villages</b></td>
<% }%>


<% if (name.equals("Habitations") && type.equals("04")) { %>
  <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Habitations</b></td>
<% }%>

<%if (name.equals("HabitationFC") && type.equals("05")) { %>
  <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Habitations FC </b></td>
<% }%>

<%if (name.equals("HabitationPC4") && type.equals("06")) { %>
  <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Habitations PC4</b></td>
<% }%>
  
  <%if (name.equals("HabitationPC3") && type.equals("07")) { %>
  <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Habitations PC3</b></td>
<% }%>
  
  <%if (name.equals("HabitationPC2") && type.equals("08")) { %>
  <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Habitations PC2</b></td>
<% }%>
  
  
  <%if (name.equals("HabitationPC1") && type.equals("09")) { %>
  <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Habitations PC1</b></td>
<% }%>
  
  
  <%if (name.equals("HabitationNSS") && type.equals("10")) { %>
  <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Habitations NSS</b></td>
<% }%>
  
  
  <%if (name.equals("HabitationNC") && type.equals("11")) { %>
  <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No Of Habitations NC</b></td>
<% }%>
  
  <%if (name.equals("PWS") && type.equals("12")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>PWS Assets</b></td>
<% }%>
 <%if (name.equals("MPWS") && type.equals("13")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>MPWS Assets</b></td>
<% }%>

 <%if (name.equals("CPWS") && type.equals("14")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>CPWS Assets</b></td>
<% }%>

 <%if (name.equals("HandPumps") && type.equals("15")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>HandPumps Assets</b></td>
<% }%>

<%if (name.equals("Labs") && type.equals("16")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>No.of Labs</b></td>
<td class=gridhdbg ><b>No.of Physico Chemical Tests</b></td>
<td class=gridhdbg ><b>No.of Bacteriological Tests</b></td>
<% }%>


<%if (name.equals("PhysicoChemical") && type.equals("17")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>Physico Chemical</b></td>
<% }%>

<%if (name.equals("Bacteriological") && type.equals("18")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>Bacteriological</b></td>
<% }%>
<%if (name.equals("TotSources") && type.equals("19")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>Tot Sources</b></td>
<% }%>
<%if (name.equals("Flouride") && type.equals("20")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>Tot Sources</b></td>
<% }%>
<%if (name.equals("Brakish") && type.equals("21")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>Tot Sources</b></td>
<% }%>
<%if (name.equals("Iron") && type.equals("22")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>Tot Sources</b></td>
<% }%>
<%if (name.equals("Nitrate") && type.equals("23")) { %>
    <td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>Tot Sources</b></td>
<% }%>
</tr>

	<%try
      { 
		int count=1;
      Statement stmt1=null,stmt2=null,stmt3=null;
      ResultSet rs1=null,rs2=null,rs3=null;
       String qry="",phyqry="",bioqry="",phy="",bio="";
       Hashtable phy_hash = new Hashtable();
    	Hashtable bio_hash = new Hashtable();
       // phsiochemical labs qry
     
     	stmt2=conn.createStatement();
      if (name.equals("Labs") && type.equals("16")) {   	
      phyqry="select dname,count(*),dcode from RWS_WQ_TEST_RESULTS_TBL r,rws_district_tbl,rws_water_quality_lab_tbl w   where  w.LAB_CODE=r.LAB_CODE and substr(r.source_code,1,2)=dcode  and test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+"' group by dname,dcode order by dname";
    
     	
     	rs2=stmt2.executeQuery(phyqry);
     	   while(rs2.next())
     	   {
     		phy_hash.put(rs2.getString(3),rs2.getString(2));
     			
     	   }
     	   if(stmt2!=null){
     		   stmt2.close();
     		}
     		if(rs2!=null){
     	      		rs2.close();
     		}  
     	  // biological labs qry
     	   
     	   	stmt3=conn.createStatement();	
     	    bioqry="select dname,count(*),dcode from RWS_WQ_TEST_RESULTS_TBL r,rws_district_tbl,rws_water_quality_lab_tbl w   where  w.LAB_CODE=r.LAB_CODE and substr(r.source_code,1,2)=dcode  and test_code='2' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+"' group by dname,dcode order by dname";
     	   	rs3=stmt3.executeQuery(bioqry);
     	   	   while(rs3.next())
     	   	   {
     	   		bio_hash.put(rs3.getString(3),rs3.getString(2));
     	   			
     	   	   }
     	   	   if(stmt3!=null){
     	   		   stmt3.close();
     	   		}
     	   		if(rs3!=null){
     	   				rs3.close();
     	   		}  
      }    
     		
       stmt1=conn.createStatement();
       String distname1="",distname2="";
       rs1=stmt1.executeQuery(query);
       String style="";
       int styleCount=0;
       
       int mandalCount=0,panchcount=0,villagecount=0,habcount=0,habFCcount=0,habPC4count=0,habPC3count=0,habPC2count=0,habPC1count=0,habNSScount=0,habNCcount=0;
       int pwscount=0,mpwscount=0,cpwscount=0,handpumpscount=0,labscount=0,phycount=0,bactcount=0,totSourcesCount=0,flouride=0,brakish=0,iron=0,nitrate=0;
       int phytot=0,biotot=0;
       double sanctionAmount=0;
       while(rs1.next())
       {
    	   
    	   if(officeCode!=null && officeCode.equals("100000")){
    		   
    	   }else{
    		   
    		   if(officeCode!=null && officeCode.substring(1,3).equals(rs1.getString(3))){
    			   
    		   }else{
    			   continue;
    		   }
    	   }
    	   
          distname1 = ""+rs1.getString(1);
	      
          if(styleCount%2==0)
			{
			 style="gridbg1";
			 }else
			 {
				 style="gridbg2";
			 }
			 styleCount++;
			 if (name.equals("Mandals") && type.equals("01")) { 
			 mandalCount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("Panchayats") && type.equals("02")) { 
			 panchcount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("Villages") && type.equals("03")) { 
				 villagecount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("Habitations") && type.equals("04")) { 
				 habcount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("HabitationFC") && type.equals("05")) {
				 habFCcount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("HabitationPC4") && type.equals("06")) {
				 habPC4count+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("HabitationPC3") && type.equals("07")) {
				 habPC3count+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("HabitationPC2") && type.equals("08")) {
				 habPC2count+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("HabitationPC1") && type.equals("09")) {
				 habPC1count+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("HabitationNSS") && type.equals("10")) {
				 habNSScount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("HabitationNC") && type.equals("11")) {
				 habNCcount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("PWS") && type.equals("12")) {
				 pwscount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("MPWS") && type.equals("13")) {
				 mpwscount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("CPWS") && type.equals("14")) {
				 cpwscount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("HandPumps") && type.equals("15")) {
				 handpumpscount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("Labs") && type.equals("16")) {
				 labscount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("PhysicoChemical") && type.equals("17")) {
				 phycount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("Bacteriological") && type.equals("18")) {
				 bactcount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("TotSources") && type.equals("19")) {
				 totSourcesCount+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("Flouride") && type.equals("20")) {
				 flouride+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("Brakish") && type.equals("21")) {
				 brakish+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("Iron") && type.equals("22")) {
				 iron+=Integer.parseInt(rs1.getString(2));
			 }
			 if (name.equals("Nitrate") && type.equals("23")) {
				 nitrate+=Integer.parseInt(rs1.getString(2));
			 }
		%>
			    
                
                
              <% if ((name.equals("Mandals") && type.equals("01"))|| (name.equals("Panchayats") && type.equals("02"))||(name.equals("Villages") && type.equals("03"))|| (name.equals("Habitations") && type.equals("04")) ||(name.equals("HabitationFC") && type.equals("05"))||(name.equals("HabitationPC4") && type.equals("06"))||(name.equals("HabitationPC3") && type.equals("07"))||(name.equals("HabitationPC2") && type.equals("08"))||(name.equals("HabitationPC1") && type.equals("09"))||(name.equals("HabitationNSS") && type.equals("10"))||(name.equals("HabitationNC") && type.equals("11"))|| (name.equals("PWS") && type.equals("12"))||(name.equals("MPWS") && type.equals("13"))||(name.equals("CPWS") && type.equals("14"))||(name.equals("HandPumps") && type.equals("15"))){ %>
  				  <tr>
                
                <td class=<%=style %> style="text-align: left;"><%=count++%> </td>
				<td class=<%=style %> style="text-align: left;"><a href="#"	onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_div_abstract.jsp?dcode=<%=rs1.getString(3) %>&dname=<%=rs1.getString(1) %>&finYear=<%=finYear%>')" ><%=rs1.getString(1)%></a></td>    
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(2)%></td>
				
				</tr>
             
             <% } %>    
                
                
              <% if ((name.equals("PhysicoChemical") && type.equals("17")) || (name.equals("Bacteriological") && type.equals("18")))
              {
              %> 
				
			   
               <tr>
                <td class=<%=style %> style="text-align: left;"><%=count++%> </td>
  				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(1)%></td>    
  				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(2)%></td>
   				</tr>
  				
		     <%} %> 
		     <% if (name.equals("TotSources") && type.equals("19"))
              {
              %> 
				
			   
               <tr>
                <td class=<%=style %> style="text-align: left;"><%=count++%> </td>
  				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(1)%></td>    
  				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(2)%></td>
   				</tr>
  				
		     <%} %> 
		     <% if (name.equals("Flouride") && type.equals("20"))
              {
              %> 
				
			   
               <tr>
                <td class=<%=style %> style="text-align: left;"><%=count++%> </td>
  				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(1)%></td>    
  				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(2)%></td>
   				</tr>
  				
		     <%} %> 
		     <% if (name.equals("Brakish") && type.equals("21"))
              {
              %> 
				
			   
               <tr>
                <td class=<%=style %> style="text-align: left;"><%=count++%> </td>
  				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(1)%></td>    
  				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(2)%></td>
   				</tr>
  				
		     <%} %> 
		     <% if (name.equals("Iron") && type.equals("22"))
              {
              %> 
				
			   
               <tr>
                <td class=<%=style %> style="text-align: left;"><%=count++%> </td>
  				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(1)%></td>    
  				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(2)%></td>
   				</tr>
  				
		     <%} %>
		     
		     <% if (name.equals("Nitrate") && type.equals("23"))
              {
              %> 
				
			   
               <tr>
                <td class=<%=style %> style="text-align: left;"><%=count++%> </td>
  				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(1)%></td>    
  				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(2)%></td>
   				</tr>
  				
		     <%} %> 
            	  
  				<% if (name!=null &&(name.equals("Labs") && type.equals("16"))){ 
  				
  				if(phy_hash.get(rs1.getString(3))!=null){
					 phy = (String) phy_hash.get(rs1.getString(3));
				    }
  				
				if(bio_hash.get(rs1.getString(3))!=null){
				    bio = (String) bio_hash.get(rs1.getString(3));
					
				    }
			
  			
  				
  				%>
  				  <tr>
                
                <td class=<%=style %> style="text-align: left;"><%=count++%> </td>
				<td class=<%=style %> style="text-align: left;"><a href="#"	onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_div_abstract.jsp?dcode=<%=rs1.getString(3) %>&dname=<%=rs1.getString(1) %>')" ><%=rs1.getString(1)%></a></td>    
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(2)%></td>
				<td class=<%=style %> style="text-align: right;"><%=phy%></td>
				<td class=<%=style %> style="text-align: right;"><%=bio%></td>
					
				</tr>
             
             <% } %>    	
             
            	 
				
			
				
		<% 
		if (name!=null &&(name.equals("Labs") && type.equals("16"))){ 
		 phytot+=Integer.parseInt(phy);
		 biotot+=Integer.parseInt(bio);
		}
           distname2 = distname1;
       }
       
       %>
       
       <tr>
                <%if (name.equals("Mandals") && type.equals("01")) { %>
                <td class=gridhdbg colspan=2 >Total: </td>
				<td class=gridhdbg style="text-align: right;" ><%=mandalCount %>   </td>
				<%} %>
				<%if (name.equals("Panchayats") && type.equals("02")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=panchcount %>   </td>
				<%} %>
				
				<%if (name.equals("Villages") && type.equals("03")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=villagecount %>   </td>
				<%} %>
				
				<%if (name.equals("Habitations") && type.equals("04")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=habcount %>   </td>
				<%} %>
				
			    <%if (name.equals("HabitationFC") && type.equals("05")) {  %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=habFCcount%>   </td>
				<%} %>
				
				<%if (name.equals("HabitationPC4") && type.equals("06")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=habPC4count %>   </td>
				<%} %>
				
				<%if (name.equals("HabitationPC3") && type.equals("07")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=habPC3count %>   </td>
				<%} %>
				
				<%if (name.equals("HabitationPC2") && type.equals("08")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=habPC2count %>   </td>
				<%} %>
				
				<%if (name.equals("HabitationPC1") && type.equals("09")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=habPC1count %>   </td>
				<%} %>
				
				<%if (name.equals("HabitationNSS") && type.equals("10")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=habNSScount %>   </td>
				<%} %>
				
				<%if (name.equals("HabitationNC") && type.equals("11")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=habNCcount %>   </td>
				<%} %>
				
				<%if (name.equals("PWS") && type.equals("12")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=pwscount %>   </td>
				<%} %>
				
				<%if (name.equals("MPWS") && type.equals("13")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=mpwscount %>   </td>
				<%} %>
								
				<%if (name.equals("CPWS") && type.equals("14")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=cpwscount %>   </td>
				<%} %>
				
				<%if (name.equals("HandPumps") && type.equals("15")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=handpumpscount %>   </td>
				<%} %>
				
				
				<%if (name.equals("Labs") && type.equals("16")) {
					%>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=labscount %>   </td>
			        <td class=gridhdbg style="text-align: right;" ><%=phytot %>   </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=biotot %>   </td>
			    
				<%} %>
				
				<%if (name.equals("PhysicoChemical") && type.equals("17")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=phycount %>   </td>
				<%} %>
				
				<%if (name.equals("Bacteriological") && type.equals("18")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=bactcount %>   </td>
				<%} %>
				<%if (name.equals("TotSources") && type.equals("19")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=totSourcesCount %>   </td>
				<%} %>
				<%if (name.equals("Flouride") && type.equals("20")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=flouride %>   </td>
				<%} %>
				<%if (name.equals("Brakish") && type.equals("21")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=brakish %>   </td>
				<%} %>
				<%if (name.equals("Iron") && type.equals("22")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=iron %>   </td>
				<%} %>
				<%if (name.equals("Nitrate") && type.equals("23")) { %>
				    <td class=gridhdbg colspan=2 >Total: </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=nitrate %>   </td>
				<%} %>
				</tr>
       <% 
       
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

