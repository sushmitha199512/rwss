
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>



<style>
html, body{
  margin:0;
  padding:0;
  height:100%;
}
section {
  position: relative;
  border: 1px solid #000;
  padding-top: 37px;
  background: #500;
}
section.positioned {
  position: absolute;
  top:100px;
  left:100px;
  width:800px;
  box-shadow: 0 0 15px #333;
}
.container {
  overflow-y: auto;
  height: 800px;
}
table {
  border-spacing: 0;
  width:100%;
}
td + td {
  border-left:1px solid #eee;
}
td, th {
  border-bottom:1px solid #eee;
  background: #ddd;
  color: #000;
  padding: 10px 25px;
}
th {
  height: 0;
  line-height: 0;
  padding-top: 0;
  padding-bottom: 0;
  color: transparent;
  border: none;
  white-space: nowrap;
}
th div{
  position: absolute;
  background: transparent;
  color: #fff;
  padding: 9px 25px;
  top: 0;
  margin-left: -25px;
  line-height: normal;
  border-left: 1px solid #800;
}
th:first-child div{
  border: none;
}
</style>
<%

DecimalFormat ndf = new DecimalFormat("####.##");

		String name = (String)session.getAttribute("name");
		String type =(String)session.getAttribute("type");
		String query = "",query1="",query2="";

         String finYear=(String)session.getAttribute("finYear");
         String dcode=(String)request.getParameter("dcode");
         String dname=(String)request.getParameter("dname");
         session.setAttribute("dcode",dcode);
         java.util.Date currentDate = new java.util.Date();
			int cyear = currentDate.getYear() + 1900;
			int pyear = currentDate.getYear() + 1900 - 1;

//System.out.println("Year:"+finYear);
//2012-2013
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
		if (name.equals("Mandals") && type.equals("01")) {
			query = "SELECT d.dname,m.mname from rws_district_tbl d,rws_mandal_tbl m where d.dcode=m.dcode and d.dcode="+dcode+" order by m.mname";
		} else if (name.equals("Panchayats") && type.equals("02")) {
			query = "SELECT distinct dname,pname,mname from rws_complete_hab_View where dcode="+dcode+" order by pname";
		} else if (name.equals("Villages") && type.equals("03")) {
			query = "SELECT distinct ch.dname,ch.vname,ch.pname,ch.mname from rws_village_tBL a,rws_district_tbl d,rws_complete_hab_view ch  where ch.dcode=d.dcode and ch.vcode=a.vcode and d.dcode=a.dcode and d.dcode="+dcode+" order by ch.vname"; 
		} else if (name.equals("Habitations") && type.equals("04")) {
			query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View  h,"+habtable+" ch  where  ch.hab_code=h.panch_code and dcode="+dcode+" order by mname";
		}  
		 else if (name.equals("HabitationFC") && type.equals("05")) {
				query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View h  ,"+habtable+" ch  where  ch.hab_code=h.panch_code and dcode="+dcode+" and ch.COVERAGE_STATUS='FC' order by mname";
			}
		 else if (name.equals("HabitationPC4") && type.equals("06")) {
				query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View h ,"+habtable+" ch  where  ch.hab_code=h.panch_code and dcode="+dcode+" and ch.COVERAGE_STATUS='PC4' order by mname";
			}
		 else if (name.equals("HabitationPC3") && type.equals("07")) {
				query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View h ,"+habtable+" ch  where  ch.hab_code=h.panch_code and dcode="+dcode+" and ch.COVERAGE_STATUS='PC3' order by mname";
			}
		 else if (name.equals("HabitationPC2") && type.equals("08")) {
				query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View  h ,"+habtable+" ch  where  ch.hab_code=h.panch_code and dcode="+dcode+" and ch.COVERAGE_STATUS='PC2' order by mname";
			}
		 else if (name.equals("HabitationPC1") && type.equals("09")) {
				query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View  h,"+habtable+" ch  where  ch.hab_code=h.panch_code and  dcode="+dcode+" and ch.COVERAGE_STATUS='PC1' order by mname";
			}
		 else if (name.equals("HabitationNSS") && type.equals("10")) {
				query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View  h,"+habtable+" ch  where ch.hab_code=h.panch_code and  dcode="+dcode+" and ch.COVERAGE_STATUS='NSS' order by mname";
			}
		 else if (name.equals("HabitationNC") && type.equals("11")) {
				query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU from rws_complete_hab_View  h,"+habtable+" ch  where  ch.hab_code=h.panch_code and  dcode="+dcode+" and ch.COVERAGE_STATUS='NC' order by mname";
			}
		 else if (name.equals("PWS") && type.equals("12")) {
				query = "SELECT h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,to_char(m.DATE_CREATION,'dd/mm/yyyy'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE dcode="+dcode+" and M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' and  SUBSTR(SCHEME_CODE,17,3) LIKE '6%' and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "' group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by h.mname,h.pname,h.vname";
			}
		 else if (name.equals("MPWS") && type.equals("13")) {
				query = "SELECT h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,to_char(m.DATE_CREATION,'dd/mm/yyyy'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE dcode="+dcode+" and M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02'  and  (SUBSTR(SCHEME_CODE,17,3) LIKE '40%' or SUBSTR(SCHEME_CODE,17,3) LIKE '41%' or SUBSTR(SCHEME_CODE,17,3) LIKE '42%' or SUBSTR(SCHEME_CODE,17,3) LIKE '43%' or SUBSTR(SCHEME_CODE,17,3) LIKE '44%')   and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "' group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by h.mname,h.pname,h.vname";
			} 
		 else if (name.equals("CPWS") && type.equals("14")) {
				query = "SELECT h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,to_char(m.DATE_CREATION,'dd/mm/yyyy'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE dcode="+dcode+" and M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='03'  and  SUBSTR(SCHEME_CODE,17,3) LIKE '8%'  and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "' group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by h.mname,h.pname,h.vname";
			} 
		else if (name.equals("HandPumps") && type.equals("15")) {
				query = "SELECT h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,to_char(m.DATE_CREATION,'dd/mm/yyyy'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE dcode="+dcode+" and M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='04' and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%'or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%') and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "' group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by h.mname,h.pname,h.vname";
			}
		else if (name.equals("Labs") && type.equals("16")) {
			query = "select dname,c.CIRCLE_OFFICE_NAME,d.DIVISION_OFFICE_NAME,w.LAB_CODE,w.LAB_NAME,w.LOCATION,count(*),dcode from rws_water_quality_lab_tbl w,rws_district_tbl,rws_circle_office_tbl c,rws_division_office_tbl d where substr(w.OFFICE_CODE,2,2)=c.CIRCLE_OFFICE_CODE and substr(w.OFFICE_CODE,4,1)=d.DIVISION_OFFICE_CODE and c.CIRCLE_OFFICE_CODE=d.CIRCLE_OFFICE_CODE  and  dcode="+dcode+" and substr(w.office_code,2,2)=dcode and w.status<>'UI' group by dname,c.CIRCLE_OFFICE_NAME,d.DIVISION_OFFICE_NAME,w.LAB_CODE,w.LAB_NAME,w.LOCATION,dcode";
    		} 
      
		
		System.out.println("query"+query);
		
        

	%>



<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
               <td class="bwborder"><a href="javascript:window.history.go(-1);">Back</a>
</td>
	</tr>  
		</table>
	</caption>
<tr >
		<td align="center" class="gridhdbg"><%=dname %></td>
</tr>
</table>

<div class="container">
<table >
<thead>
<tr class="header">
<th  class=gridhdbg>SLNO   </th>
<%	if (name!=null&& name.equals("Mandals") && type.equals("01")) { %>
<th class=gridhdbg >Mandals </th>
<%} %>

<%	if (name.equals("Panchayats") && type.equals("02")) { %>
<td class=gridhdbg ><b>Panchayats</b></td>
<%} %>
  
  <%	if (name.equals("Villages") && type.equals("03")) { %>
<td class=gridhdbg ><b>Villages</b></td>
<%} %>

<%	if (  (name.equals("Habitations") && type.equals("04")) ||(name.equals("HabitationFC") && type.equals("05"))||(name.equals("HabitationPC4") && type.equals("06"))||(name.equals("HabitationPC3") && type.equals("07"))||(name.equals("HabitationPC2") && type.equals("08"))||(name.equals("HabitationPC1") && type.equals("09"))||(name.equals("HabitationNSS") && type.equals("10"))||(name.equals("HabitationNC") && type.equals("11"))) { %>
<td class=gridhdbg ><b>Mandal</b></td>
<td class=gridhdbg ><b>Panchayat</b></td>
<td class=gridhdbg ><b>Village</b></td>
<td class=gridhdbg ><b>Habitation Code</b></td>
<td class=gridhdbg ><b>Habitation Name</b></td>
<td class=gridhdbg ><b>Census Plain Population</b></td>
<td class=gridhdbg ><b>Census SC Population</b></td>
<td class=gridhdbg ><b>Census ST Population</b></td>
<%} %>


  <%	if ((name.equals("PWS") && type.equals("12"))||(name.equals("MPWS") && type.equals("13"))||(name.equals("CPWS") && type.equals("14"))||(name.equals("HandPumps") && type.equals("15"))) { %>
<td class=gridhdbg ><b>Mandal</b></td>
<td class=gridhdbg ><b>Panchayat</b></td>
<td class=gridhdbg ><b>Village</b></td>
<td class=gridhdbg ><b>Asset Code</b></td>
<td class=gridhdbg ><b>Asset Name</b></td>
<td class=gridhdbg ><b>Date of Creation</b></td>
<td class=gridhdbg ><b>Asset Status</b></td>
<td class=gridhdbg ><b>Latitude</b></td>
<td class=gridhdbg ><b>Longitude</b></td>
<td class=gridhdbg ><b>Elevation</b></td>
<td class=gridhdbg ><b>Way Point</b></td>
<%} %>

<%	if (name.equals("Labs") && type.equals("16")) { %>
<td class=gridhdbg ><b>Circle</b></td>
<td class=gridhdbg ><b>Division</b></td>
<td class=gridhdbg ><b>Lab Code</b></td>
<td class=gridhdbg ><b>Lab Name</b></td>
<td class=gridhdbg ><b>Location</b></td>
<td class=gridhdbg ><b>Total No.of Physico Chemical Tests</b></td>
<td class=gridhdbg ><b>Total No.of Bacteriological Tests</b></td>
<%} %>



</tr>
</thead>

<tbody>
	<%try
      { int count=1;
       Statement stmt1=null,stmt2=null,stmt3=null;
       ResultSet rs1=null,rs2=null,rs3=null;
       String qry="",phyqry="",bioqry="",phy="",bio="";
       int phytot=0,biotot=0;
     	Hashtable phy_hash = new Hashtable();
     	Hashtable bio_hash = new Hashtable();
     // phsiochemical labs qry
   
   	stmt2=conn.createStatement();
    if (name.equals("Labs") && type.equals("16")) {   	
    phyqry="select dname,w.lab_code,count(*) from rws_water_quality_lab_tbl w,RWS_WQ_TEST_RESULTS_TBL r,rws_district_tbl  where   w.LAB_CODE=r.LAB_CODE and r.TEST_CODE ='1' and substr(r.SOURCE_CODE ,1,2)=dcode  and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+ "' and dcode="+dcode+" group by dname,w.lab_code";
 
   	rs2=stmt2.executeQuery(phyqry);
   	//System.out.println("phyqry"+phyqry);
   	   while(rs2.next())
   	   {
   		phy_hash.put(rs2.getString(2),rs2.getString(3));
   			
   	   }
   	   if(stmt2!=null){
   		   stmt2.close();
   		}
   		if(rs2!=null){
   				rs2.close();
   		}  
    
   	  // biological labs qry
   	   
   	   	stmt3=conn.createStatement();
   	    bioqry="select dname,w.lab_code,count(*) from rws_water_quality_lab_tbl w,RWS_WQ_TEST_RESULTS_TBL r,rws_district_tbl  where  w.status<>'UI' and  w.LAB_CODE=r.LAB_CODE and r.TEST_CODE ='2' and substr(r.SOURCE_CODE ,1,2)=dcode  and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+ "' and dcode="+dcode+" group by dname,w.lab_code";
   	    
   	   	rs3=stmt3.executeQuery(bioqry);
   	   	//System.out.println("bioqry"+bioqry);
   	   	   while(rs3.next())
   	   	   {
   	   		bio_hash.put(rs3.getString(2),rs3.getString(3));
   	   			
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
      //System.out.println("qry***********"+query);
       rs1=stmt1.executeQuery(query);
        String style="";
       int styleCount=0;
       int workCount=0;
       double sanctionAmount=0;
       while(rs1.next())
       {
    	   String assettype="",assetstatus="";
          distname1 = ""+rs1.getString(1);
      
          if(styleCount%2==0)
			{
				 style="gridbg1";
			 }else
			 {
				 style="gridbg2";
			 }
			 styleCount++;
			 
			  
		%>
			    
                
               <% if ((name.equals("Mandals") && type.equals("01"))||name.equals("Panchayats") && type.equals("02")||name.equals("Villages") && type.equals("03")) {%> 
                <tr>
                
                <td class=<%=style %> style="text-align: left;">&nbsp;<%=count++%> </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%>   </td>
				 
				
				</tr>
				<%} %>
				
			<%	if ( (name.equals("Habitations") && type.equals("04"))||(name.equals("HabitationFC") && type.equals("05"))||(name.equals("HabitationPC4") && type.equals("06"))||(name.equals("HabitationPC3") && type.equals("07"))||(name.equals("HabitationPC2") && type.equals("08"))||(name.equals("HabitationPC1") && type.equals("09"))||(name.equals("HabitationNSS") && type.equals("10"))||(name.equals("HabitationNC") && type.equals("11"))) { %>
			<tr>
                
                <td class=<%=style %> style="text-align: left;">&nbsp;<%=count++%> </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(3)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(4)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(5)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(6)%>   </td>
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(7)%>   </td>
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(8)%>   </td>
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(9)%>   </td> 
				
				</tr>
				<%} %>
				
				<%	if ((name.equals("PWS") && type.equals("12"))||(name.equals("MPWS") && type.equals("13"))||(name.equals("CPWS") && type.equals("14"))||(name.equals("HandPumps") && type.equals("15"))) { 
					assettype=rs1.getString(15);
					//System.out.println("assettype="+assettype);
					if(assettype!=null && (assettype.equals("03") || assettype.equals("01"))){ 
						//System.out.println("in if");
						if(rs1.getInt(8)==1){
						assetstatus="Working";}
						else if(rs1.getInt(8)==2){
							assetstatus="Defunt";	
						}else{
							assetstatus="";	
						}
					}else{
						////System.out.println("in else"+rs1.getString(5));
						if(rs1.getInt(8)==1){
							assetstatus="Working";}
						else if(rs1.getInt(8)==2){
							assetstatus="Not Working";}
						else if(rs1.getInt(8)==3){
							assetstatus="Dried";}
						else if(rs1.getInt(8)==4){
							assetstatus="Seasonal";}
						else if(rs1.getInt(8)==5){
							assetstatus="Condemed";}
						else{
							assetstatus="";
						}
					}
					//System.out.println("assetstatus="+assetstatus);
				%>
			<tr>
                
                <td class=<%=style %> style="text-align: left;">&nbsp;<%=count++%> </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(3)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(4)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(5)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(6)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(7)%>   </td>
				
				<td class=<%=style %> style="text-align: left;"><%=assetstatus%>   </td>
				
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(9)%>   </td>
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(10)%>   </td>
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(11)%>   </td>
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(12)%>   </td> 
				
				</tr>
				<%} %>
			
				<%	if (name.equals("Labs") && type.equals("16")) {
					bio="0";
					phy="0";
					
					if(phy_hash.get(rs1.getString(4))!=null){
					    phy = (String) phy_hash.get(rs1.getString(4));
						//System.out.println("phyyyy"+phy);
				     }
					if(bio_hash.get(rs1.getString(4))!=null){
					    bio = (String) bio_hash.get(rs1.getString(4));
						//System.out.println("bioo"+bio);
				     }
				
					
					
					%>
				 <tr>
                <td class=<%=style %> style="text-align: left;">&nbsp;<%=count++%> </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(3)%>   </td> 
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(4)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(5)%>   </td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(6)%>   </td>
			    <td class=<%=style %> style="text-align: right;"><%=phy%></td>
				<td class=<%=style %> style="text-align: right;"><%=bio%></td>
				</tr>
				<%
				}
				
				%>
				
				
			 
		<% 
		if (name!=null &&(name.equals("Labs") && type.equals("16"))){ 
			 phytot+=Integer.parseInt(phy);
			 biotot+=Integer.parseInt(bio);
			}
           distname2 = distname1;
       }
      
       %>
       
       <tr>
                
             <%if (name.equals("Labs") && type.equals("16")) {
					%>
				    <td class=gridhdbg colspan=6 >Total: </td>
			        <td class=gridhdbg style="text-align: right;" ><%=phytot %>   </td>
			    	<td class=gridhdbg style="text-align: right;" ><%=biotot %>   </td>
			    
				<%} %>  
				
				</tr>
       <% 
       
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	</tbody>
	
</table>
</div>


</form>

