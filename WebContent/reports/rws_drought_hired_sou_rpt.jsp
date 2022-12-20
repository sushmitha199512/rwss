<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<head>
    <%-- <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       <link href="<rws:context page='/resources/HabScoreCardDesign/Style.css' />" rel="stylesheet" type="text/css" />
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Header.js' />"></script> --%>
<style>
.gridbgAbove75 {
	background-color:#4CC417; text-align:center;  border-bottom:1px #b0b0b0 solid;  border-left:1px #b0b0b0 solid; vertical-align:middle; font-size:10px;  font-weight:400; height:20px; padding-left:5px; padding-right:5px; padding:4px;
}
.gridbg50_75 {
	background-color:#1589FF; text-align:center;  border-bottom:1px #b0b0b0 solid;  border-left:1px #b0b0b0 solid; vertical-align:middle; font-size:10px;  font-weight:400; height:20px; padding-left:5px; padding-right:5px; padding:4px;
}
.gridbg25_50 {
	background-color:yellow; text-align:center;  border-bottom:1px #b0b0b0 solid;  border-left:1px #b0b0b0 solid; vertical-align:middle; font-size:10px;  font-weight:400; height:20px; padding-left:5px; padding-right:5px; padding:4px;
}
.gridbgless25 {
	background-color:#F62817; text-align:center;  border-bottom:1px #b0b0b0 solid;  border-left:1px #b0b0b0 solid; vertical-align:middle; font-size:10px;  font-weight:400; height:20px; padding-left:5px; padding-right:5px; padding:4px;
}
</style>
<script language="JavaScript">
	function viewWorks(URL) {

		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}

	function wopen(url, name, w, h) {
		w += 32;
		h += 96;
		var win = window.open(url, name, 'width=' + w + ', height=' + h + ', '
				+ 'location=yes, menubar=no, '
				+ 'status=yes, toolbar=no, scrollbars=yes, resizable=yes');

		win.focus();
	}
</script>
</head>
<form>
<%

DecimalFormat ndf = new DecimalFormat("####.00");
   nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//String loggedUser = user.getUserId();

	StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());
	
Statement stmt1=null;
ResultSet rs1=null;
String dcode=request.getParameter("dcode");
String statusDate=request.getParameter("statusDate");
String mode=request.getParameter("mode");
if(request.getParameter("mode")!=null){
	mode=request.getParameter("mode");
}
else{
	mode="districts";
}


int year = Calendar.getInstance().get(Calendar.YEAR);

%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">		

			<tr>
				<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
				<td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;</a></td>


	
			<tr align="right">
<td class="bwborder"></td>
				
			
			</tr>  
		</table>
	</caption>
	<%if(mode.equals("districts")){ 
	//System.out.println("hgf");
	%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg" colspan='14'>Water Supplied through Hired Sources(test)</td>
		
		
</tr>
</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr align=center>
	
	               <td class=gridhdbg >Sl.No</td>
	               <td class=gridhdbg >District</td> 
				   <!-- <td class=gridhdbg colspan="8">Category-A</td>
				   <td class=gridhdbg rowspan="2" colspan="4">Category-B</td>
			   	   <td class=gridhdbg rowspan="2" colspan="4">Category-C</td>
			   	   
	</tr>
	<tr align=center>
	
	               <td class=gridhdbg colspan="4">Target</td>
				   <td class=gridhdbg colspan="4">Achievement</td>
 -->				   
	
	
	              <!--  <td class=gridhdbg>Mandals</td> -->
				  <!--  <td class=gridhdbg>Panchayats</td>
			   	   <td class=gridhdbg>Habitations</td>
			   	   <td class=gridhdbg>Population</td> -->
			   	   <td class=gridhdbg>No of Habitations</td>
				   <!-- <td class=gridhdbg>Population Served</td> -->
				   <td class=gridhdbg>Population Served</td>
			   	   <td class=gridhdbg>No.of Sources hired</td>
			   	   <td class=gridhdbg>Quantity in KL</td>
			   	   <!-- <td class=gridhdbg>Mandals</td>
				   <td class=gridhdbg>Panchayats</td>
			   	   <td class=gridhdbg>Habitations</td>
			   	   <td class=gridhdbg>Population</td>
			   	   <td class=gridhdbg>Mandals</td>
				   <td class=gridhdbg>Panchayats</td>
			   	   <td class=gridhdbg>Habitations</td>
			   	   <td class=gridhdbg>Population</td> -->
	</tr>
	<tr align=center>
	
	               <td class=gridhdbg>1</td>
				   <td class=gridhdbg>2</td>
			   	   <td class=gridhdbg>3</td>
			   	   <td class=gridhdbg>4</td>
			   	   <td class=gridhdbg>5</td>
				   <td class=gridhdbg>6</td>
			   	  <!--  <td class=gridhdbg>7</td>
			   	   <td class=gridhdbg>8</td>
			   	   <td class=gridhdbg>9</td>
				   <td class=gridhdbg>10</td>
			   	   <td class=gridhdbg>11</td>
			   	   <td class=gridhdbg>12</td>
			   	   <td class=gridhdbg>13</td>
			   	   <td class=gridhdbg>14</td>
			   	    <td class=gridhdbg>15</td>
			   	   <td class=gridhdbg>16</td>
			   	   <td class=gridhdbg>17</td>
			   	   <td class=gridhdbg>18</td> -->
			   	  <!--  <td class=gridhdbg>19</td> -->
	</tr>
<%
String query="";
int sno=1;
int catA=0,catB=0,catC=0,catAMan=0,catBMan=0,catCMan=0,catAPan=0,catBPan=0,catCPan=0,catAPop=0,catBPop=0,catCPop=0;
int catATot=0,catBTot=0,catCTot=0,catAManTot=0,catBManTot=0,catCManTot=0,catAPanTot=0,catBPanTot=0,catCPanTot=0,catAPopTot=0,catBPopTot=0,catCPopTot=0;
int catAAchHabs=0,catAAchPop=0,catAAchHirSou=0,catAAchQty=0;
int catAAchHabsTot=0,catAAchPopTot=0,catAAchHirSouTot=0,catAAchQtyTot=0;
try
{
	
	query="select dcode,dname from rws_district_tbl ";
	if(!dcode.equals("ALL")){
		query+=" where dcode='"+dcode+"'";
	}
	query+=" order by dcode";
	
  stmt1=conn.createStatement();
  
  rs1=stmt1.executeQuery(query);
  
  
  while (rs1.next())
	{
	  /* catAPan=0;
	  catBPan=0;
	  catCPan=0;
	  String catAQuerry="select count(distinct substr(habcode,6,2)),count(habcode),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+CENSUS_MINORITY_POPU) from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+rs1.getString("dcode")+"' and TRANSPORTATION='Y'  and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE and YEAR='"+year+"'";
	  stmt=conn.createStatement();
	  rs=stmt.executeQuery(catAQuerry);
	  if(rs.next()){
		  String manQuery="select mcode from rws_mandal_tbl where dcode='"+rs1.getString("dcode")+"'";
		  Statement statement=conn.createStatement();
		  ResultSet resultSet=statement.executeQuery(manQuery);
		  while(resultSet.next()){
		  
		  String catAPanQuerry="select count(distinct substr(habcode,13,2)) from RWS_DROUGHT_HABITATION_TBL  where substr(habcode,1,2)='"+rs1.getString("dcode")+"' and substr(habcode,6,2)='"+resultSet.getString("mcode")+"' and TRANSPORTATION='Y'  and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE and YEAR='"+year+"'";
		// System.out.println(catAPanQuerry);
		  Statement statement1=conn.createStatement();
		  ResultSet resultSet1=statement1.executeQuery(catAPanQuerry);
		  if(resultSet1.next()){
			  catAPan+=resultSet1.getInt(1);
		  }
		  statement1.close();
		  resultSet1.close();
		  }
		  statement.close();
		  resultSet.close();
		  catAMan=rs.getInt(1);
		  
		  catA=rs.getInt(2);
		  catAPop=rs.getInt(3);
	  }
	  stmt.close();
	  rs.close();
	   */
	  
	  //String catAAchievement="select  count(distinct habitation_code) as habs,sum(nvl(POPULATION_SER_TRANSPORT,0)) as popServ,sum(nvl(TANKER_NO_OF_TRIPS,'0')) as noOfTrips,sum(nvl(tanker_qty,0)) as qty from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' AND  TO_CHAR(date_of_entry,'YYYY')='"+year+"' and ((POPULATION_SER_TRANSPORT) >0 or ( TANKER_NO_OF_TRIPS)>0 or  (tanker_qty)>0) AND substr(habitation_code,1,2)='"+rs1.getString("dcode")+"' and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE AND date_of_entry<=to_date('"+statusDate+"','dd/mm/yyyy')";
	  String catAAchievement="select  count(habitation_code) as habs,sum(nvl(POPULATION_SER_PVT_HIRED,'0')) as popServ,sum(nvl(PVT_SOURCES_HIRED_NO,'0')) as hiresou,sum(nvl(PVT_SOURCES_QTY,0)) as qty from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' AND  TO_CHAR(date_of_entry,'YYYY')='"+year+"' and ((POPULATION_SER_PVT_HIRED) >0 or ( PVT_SOURCES_HIRED_NO)>0 or  (PVT_SOURCES_QTY)>0) AND substr(habitation_code,1,2)='"+rs1.getString("dcode")+"' and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE AND date_of_entry=to_date('"+statusDate+"','dd/mm/yyyy')";
	 System.out.println(catAAchievement);
	  stmt=conn.createStatement();
	  rs=stmt.executeQuery(catAAchievement);
	  if(rs.next()){
		  catAAchHabs=rs.getInt("habs");
		  catAAchPop=rs.getInt("popServ");
		  catAAchHirSou=rs.getInt("hiresou");
		  catAAchQty=rs.getInt("qty");
	  }
	  stmt.close();
	  rs.close();
	/*   String catBQuerry="select count(distinct substr(habcode,6,2)),count(habcode),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+CENSUS_MINORITY_POPU) from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+rs1.getString("dcode")+"' and TRANSPORTATION='Y' and to_date('"+statusDate+"','dd/mm/yyyy') not between FRM_DATE and TO_DATE and YEAR='"+year+"' and FRM_DATE>to_date('"+statusDate+"','dd/mm/yyyy')";
	  stmt=conn.createStatement();
	  rs=stmt.executeQuery(catBQuerry);
	  if(rs.next()){
		  String manQuery="select mcode from rws_mandal_tbl where dcode='"+rs1.getString("dcode")+"'";
		  Statement statement=conn.createStatement();
		  ResultSet resultSet=statement.executeQuery(manQuery);
		  while(resultSet.next()){
		  
		  String catBPanQuerry="select count(distinct substr(habcode,13,2)) from RWS_DROUGHT_HABITATION_TBL  where substr(habcode,1,2)='"+rs1.getString("dcode")+"' and substr(habcode,6,2)='"+resultSet.getString("mcode")+"' and TRANSPORTATION='Y'  and to_date('"+statusDate+"','dd/mm/yyyy') not between FRM_DATE and TO_DATE and YEAR='"+year+"' and FRM_DATE>to_date('"+statusDate+"','dd/mm/yyyy')";
		  Statement statement1=conn.createStatement();
		  ResultSet resultSet1=statement1.executeQuery(catBPanQuerry);
		  if(resultSet1.next()){
			  catBPan+=resultSet1.getInt(1);
		  }
		  statement1.close();
		  resultSet1.close();
		  }
		  statement.close();
		  resultSet.close();
		  catBMan=rs.getInt(1);
		  
		  catB=rs.getInt(2);
		  catBPop=rs.getInt(3);
	  }
	  stmt.close();
	  rs.close();
	  
	  String catCQuerry="select count(distinct substr(habcode,6,2)),count(habcode),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+CENSUS_MINORITY_POPU) from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+rs1.getString("dcode")+"' and TRANSPORTATION='N' and YEAR='"+year+"'";
	  stmt=conn.createStatement();
	  rs=stmt.executeQuery(catCQuerry);
	  if(rs.next()){
		  String manQuery="select mcode from rws_mandal_tbl where dcode='"+rs1.getString("dcode")+"'";
		  Statement statement=conn.createStatement();
		  ResultSet resultSet=statement.executeQuery(manQuery);
		  while(resultSet.next()){
		  
		  String catCPanQuerry="select count(distinct substr(habcode,13,2)) from RWS_DROUGHT_HABITATION_TBL  where substr(habcode,1,2)='"+rs1.getString("dcode")+"' and substr(habcode,6,2)='"+resultSet.getString("mcode")+"' and TRANSPORTATION='N' and YEAR='"+year+"'";
		  Statement statement1=conn.createStatement();
		  ResultSet resultSet1=statement1.executeQuery(catCPanQuerry);
		  if(resultSet1.next()){
			  catCPan+=resultSet1.getInt(1);
		  }
		  statement1.close();
		  resultSet1.close();
		  }
		  statement.close();
		  resultSet.close();
		  catCMan=rs.getInt(1);
		  
		  catC=rs.getInt(2);
		  catCPop=rs.getInt(3);
	  }
	  stmt.close();
	  rs.close(); */
	 
		%>
				<tr >
				<td class=gridbg2 align="center"><%=sno++%></td>
				<td class=gridbg2 ><a href="rws_drought_hired_sou_rpt.jsp?mode=mandals&dcode=<%=rs1.getString("dcode")%>&dname=<%=rs1.getString("dname")%>&statusDate=<%=statusDate%>"><%=rs1.getString("dname")%></a></td>
				<%-- <td class=gridbgAbove75 align="right"><%=catAMan%></td>
				<td class=gridbgAbove75 align="right"><%=catAPan%></td>
				<td class=gridbgAbove75 align="right"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=districts&mode1=A&dcode=<%=rs1.getString("dcode")%>&dname=<%=rs1.getString("dname")%>&statusDate=<%=statusDate%>')"><%=catA%></a></td>
				<td class=gridbgAbove75 align="right"><%=ndf.format(catAPop/100000)%></td>
				<td class=gridbgAbove75 align="right"><%=catAPop%></td>  --%>
				<td class=gridbgAbove75 align="right"><%=catAAchHabs%></td>
				 <td class=gridbgAbove75 align="right"><%=catAAchPop%></td> 
				<!-- <td class=gridbgAbove75 align="right"></td> -->
				<td class=gridbgAbove75 align="right"><%=catAAchQty%></td>
				<td class=gridbgAbove75 align="right"><%=catAAchHirSou%></td>
				<%-- <td class=gridbg25_50 align="right"><%=catBMan%></td>
				<td class=gridbg25_50 align="right"><%=catBPan%></td>
				<td class=gridbg25_50 align="right"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=districts&mode1=B&dcode=<%=rs1.getString("dcode")%>&dname=<%=rs1.getString("dname")%>&statusDate=<%=statusDate%>')"><%=catB%></a></td>
				<td class=gridbg25_50 align="right"><%=catBPop%></td>
				<td class=gridbg50_75 align="right"><%=catCMan%></td>
				<td class=gridbg50_75 align="right"><%=catCPan%></td>
				<td class=gridbg50_75 align="right"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=districts&mode1=C&dcode=<%=rs1.getString("dcode")%>&dname=<%=rs1.getString("dname")%>&statusDate=<%=statusDate%>')"><%=catC%></a></td>
				<td class=gridbg50_75 align="right"><%=catCPop%></td> --%>
                </tr>
				
				
	<%
	/* catATot+=catA;
	catBTot+=catB;
	catCTot+=catC;
	catAManTot+=catAMan;
	catBManTot+=catBMan;
	catCManTot+=catCMan;
	catAPanTot+=catAPan;
	catBPanTot+=catBPan;
	catCPanTot+=catCPan;
	catAPopTot+=catAPop;
	catBPopTot+=catBPop;
	catCPopTot+=catCPop; */
	catAAchHabsTot+=catAAchHabs;
	catAAchPopTot+=catAAchPop;
	catAAchHirSouTot+=catAAchHirSou;
	catAAchQtyTot+=catAAchQty;
	} %>

	<tr>
	<td class="gridhdbg" colspan="2" style="text-align: right;">Total:</td>
	<%-- <td class="gridhdbg" style="text-align: right;"><%=catAManTot %></td>
	<td class="gridhdbg" style="text-align: right;"><%=catAPanTot %></td>
	<td class="gridhdbg" style="text-align: right; background-color: yellow;"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=districts&mode1=ALLA&dname=ALL&statusDate=<%=statusDate%>')"><%=catATot %></a></td>
	<td class="gridhdbg" style="text-align: right;"><%=catAPopTot %></td> --%>
	<td class="gridhdbg" style="text-align: right;"><%=catAAchHabsTot %></td>
	<td class="gridhdbg" style="text-align: right;"><%=catAAchPopTot %></td> 
	<!-- <td class="gridhdbg" style="text-align: right;"></td> -->
	<td class="gridhdbg" style="text-align: right;"><%=catAAchQtyTot %></td>
	<td class="gridhdbg" style="text-align: right;"><%=catAAchHirSouTot %></td>
	<%-- <td class="gridhdbg" style="text-align: right;"><%=catBManTot %></td>
	<td class="gridhdbg" style="text-align: right;"><%=catBPanTot %></td>
	<td class="gridhdbg" style="text-align: right; background-color: yellow;"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=districts&mode1=ALLB&dname=ALL&statusDate=<%=statusDate%>')"><%=catBTot %></a></td>
	<td class="gridhdbg" style="text-align: right;"><%=catBPopTot %></td> 
	<td class="gridhdbg" style="text-align: right;"><%=catCManTot %></td>
	<td class="gridhdbg" style="text-align: right;"><%=catCPanTot %></td>
	<td class="gridhdbg" style="text-align: right; background-color: yellow;"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=districts&mode1=ALLC&dname=ALL&statusDate=<%=statusDate%>')"><%=catCTot %></a></td>
	<td class="gridhdbg" style="text-align: right;"><%=catCPopTot %></td>  --%> 
    </tr>
	<%
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	try
	{
		if(rs1 != null )
		{
			rs1.close();
		}
		if(stmt1 != null )
		{
			stmt1.close();
		}
		
		if( conn != null )
		{
			conn.close();
		}
	}
	catch(Exception r)
	{
		r.printStackTrace();
	}
}

%>
</table>
<%}
else if(mode.equals("mandals")){ 
String dname=request.getParameter("dname") ;
%>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg" colspan='5'>Water Supplied through Hired Sources(test) for District: <%=request.getParameter("dname") %></td>
		
		
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
	
	               <td class=gridhdbg >Sl.No</td>
	               <td class=gridhdbg >Mandal</td> 
				  <!--  <td class=gridhdbg colspan="7">Category-A</td>
				   <td class=gridhdbg rowspan="2" colspan="3">Category-B</td>
			   	   <td class=gridhdbg rowspan="2" colspan="3">Category-C</td> -->
	<!-- 		   	   
	</tr>
	<tr align=center>
	
	               <td class=gridhdbg colspan="3">Target</td>
				   <td class=gridhdbg colspan="4">Achievement</td> -->
				   
	
	              
				  <!--  <td class=gridhdbg>Panchayats</td>
			   	   <td class=gridhdbg>Habitations</td>
			   	   <td class=gridhdbg>Population</td> -->
			   	  <td class=gridhdbg>No of Habitations</td>
				   <!-- <td class=gridhdbg>Population Served</td> -->
				   <td class=gridhdbg>Population Served</td>
			   	   <td class=gridhdbg>No.of Sources hired</td>
			   	   <td class=gridhdbg>Quantity in KL</td>
			   	  <!--  <td class=gridhdbg>Panchayats</td>
			   	   <td class=gridhdbg>Habitations</td>
			   	   <td class=gridhdbg>Population</td>
			   	   <td class=gridhdbg>Panchayats</td>
			   	   <td class=gridhdbg>Habitations</td>
			   	   <td class=gridhdbg>Population</td> -->
	</tr>
	<tr align=center>
	
	               <td class=gridhdbg>1</td>
				   <td class=gridhdbg>2</td>
			   	   <td class=gridhdbg>3</td>
			   	   <td class=gridhdbg>4</td>
			   	   <td class=gridhdbg>5</td>
				   <td class=gridhdbg>6</td>
			   	  <!--  <td class=gridhdbg>7</td>
			   	   <td class=gridhdbg>8</td>
			   	   <td class=gridhdbg>9</td>
				   <td class=gridhdbg>10</td>
			   	   <td class=gridhdbg>11</td>
			   	   <td class=gridhdbg>12</td>
			   	   <td class=gridhdbg>13</td>
			   	   <td class=gridhdbg>14</td>
			   	   <td class=gridhdbg>15</td> -->
			   	   <!-- <td class=gridhdbg>16</td> -->
			   	   
	</tr>
<%
String query="";
int sno=1;
 int catA=0,catB=0,catC=0,catAPan=0,catBPan=0,catCPan=0,catAPop=0,catBPop=0,catCPop=0;
int catATot=0,catBTot=0,catCTot=0,catAPanTot=0,catBPanTot=0,catCPanTot=0,catAPopTot=0,catBPopTot=0,catCPopTot=0;
int catAAchHabs=0,catAAchPop=0,catAAchHirSou=0,catAAchQty=0; 
int catAAchHabsTot=0,catAAchPopTot=0,catAAchHirSouTot=0,catAAchQtyTot=0;
try
{
//String dcode=request.getParameter("dcode");
query="select mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by mcode";
System.out.println("query"+query);
stmt1=conn.createStatement();
rs1=stmt1.executeQuery(query);


while (rs1.next())
{
  /* String catAQuerry="select count(distinct substr(habcode,13,2)),count(habcode),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+CENSUS_MINORITY_POPU) from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and TRANSPORTATION='Y' and substr(habcode,6,2)='"+rs1.getString("mcode")+"' and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE and YEAR='"+year+"'";
  //System.out.println(catAQuerry);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(catAQuerry);
  if(rs.next()){
	  catAPan =rs.getInt(1);
	  catA=rs.getInt(2);
	  catAPop=rs.getInt(3);
  }
  stmt.close();
  rs.close(); */
  //String catAAchievement="select  count(distinct habitation_code) as habs,sum(nvl(POPULATION_SER_TRANSPORT,0)) as popServ,sum(nvl(TANKER_NO_OF_TRIPS,'0')) as noOfTrips,sum(nvl(tanker_qty,0)) as qty from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' AND  TO_CHAR(date_of_entry,'YYYY')='"+year+"' and ((POPULATION_SER_TRANSPORT) >0 or ( TANKER_NO_OF_TRIPS)>0 or  (tanker_qty)>0) AND substr(habitation_code,1,2)='"+dcode+"' and substr(habcode,6,2)='"+rs1.getString("mcode")+"' and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE AND date_of_entry<=to_date('"+statusDate+"','dd/mm/yyyy')";
  String catAAchievement="select  count(habitation_code) as habs,sum(nvl(POPULATION_SER_PVT_HIRED,'0')) as popServ,sum(nvl(PVT_SOURCES_HIRED_NO,'0')) as hiresou,sum(nvl(PVT_SOURCES_QTY,0)) as qty from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' AND  TO_CHAR(date_of_entry,'YYYY')='"+year+"' and ((POPULATION_SER_PVT_HIRED) >0 or ( PVT_SOURCES_HIRED_NO)>0 or  (PVT_SOURCES_QTY)>0) AND substr(habitation_code,1,2)='"+dcode+"' and substr(habcode,6,2)='"+rs1.getString("mcode")+"' and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE AND date_of_entry=to_date('"+statusDate+"','dd/mm/yyyy')";
 // System.out.println(catAAchievement);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(catAAchievement);
  if(rs.next()){
	  catAAchHabs=rs.getInt("habs");
	  catAAchPop=rs.getInt("popServ");
	  catAAchHirSou=rs.getInt("hiresou");
	  catAAchQty=rs.getInt("qty");
  }
  stmt.close();
  rs.close();
 /*  String catBQuerry="select count(distinct substr(habcode,13,2)),count(habcode),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+CENSUS_MINORITY_POPU) from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and TRANSPORTATION='Y' and substr(habcode,6,2)='"+rs1.getString("mcode")+"' and to_date('"+statusDate+"','dd/mm/yyyy') not between FRM_DATE and TO_DATE and YEAR='"+year+"' and FRM_DATE>to_date('"+statusDate+"','dd/mm/yyyy')";
  stmt=conn.createStatement();
  rs=stmt.executeQuery(catBQuerry);
  if(rs.next()){
	  catBPan =rs.getInt(1);
	  catB=rs.getInt(2);
	  catBPop=rs.getInt(3);
  }
  stmt.close();
  rs.close();
  
  String catCQuerry="select count(distinct substr(habcode,13,2)),count(habcode),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+CENSUS_MINORITY_POPU) from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and TRANSPORTATION='N' and substr(habcode,6,2)='"+rs1.getString("mcode")+"' and YEAR='"+year+"'";
  stmt=conn.createStatement();
  rs=stmt.executeQuery(catCQuerry);
  if(rs.next()){
	  catCPan =rs.getInt(1);
	  catC=rs.getInt(2);
	  catCPop=rs.getInt(3);
  }
  stmt.close();
  rs.close(); */
	%>
			<tr >
			<td class=gridbg2 align="center"><%=sno++%></td>
			<td class=gridbg2 ><a href="rws_drought_hired_sou_rpt.jsp?mode=panchayats&dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=rs1.getString("mcode")%>&mname=<%=rs1.getString("mname")%>&statusDate=<%=statusDate%>"><%=rs1.getString("mname")%></a></td>
			<%-- <td class=gridbgAbove75 align="right"><%=catAPan%></td>
			<td class=gridbgAbove75 align="right"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=mandals&mode1=A&dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=rs1.getString("mcode")%>&mname=<%=rs1.getString("mname")%>&statusDate=<%=statusDate%>')"><%=catA%></a></td>
			<td class=gridbgAbove75 align="right"><%=catAPop%></td> --%>
			<td class=gridbgAbove75 align="right"><%=catAAchHabs%></td>
			<td class=gridbgAbove75 align="right"><%=catAAchPop%></td>
			<td class=gridbgAbove75 align="right"><%=catAAchQty%></td>
			<td class=gridbgAbove75 align="right"><%=catAAchHirSou%></td>
			<%-- <td class=gridbg25_50 align="right"><%=catBPan%></td>
			<td class=gridbg25_50 align="right"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=mandals&mode1=B&dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=rs1.getString("mcode")%>&mname=<%=rs1.getString("mname")%>&statusDate=<%=statusDate%>')"><%=catB%></a></td>
			<td class=gridbg25_50 align="right"><%=catBPop%></td>
			<td class=gridbg50_75 align="right"><%=catCPan%></td>
			<td class=gridbg50_75 align="right"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=mandals&mode1=C&dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=rs1.getString("mcode")%>&mname=<%=rs1.getString("mname")%>&statusDate=<%=statusDate%>')"><%=catC%></a></td>
			<td class=gridbg50_75 align="right"><%=catCPop%></td> --%>
            </tr>
		
<%
/* catATot+=catA;
catBTot+=catB;
catCTot+=catC;
catAPanTot+=catAPan;
catBPanTot+=catBPan;
catCPanTot+=catCPan;
catAPopTot+=catAPop;
catBPopTot+=catBPop;
catCPopTot+=catCPop; */
catAAchPopTot+=catAAchPop;
catAAchHabsTot+=catAAchHabs;
catAAchHirSouTot+=catAAchHirSou;
catAAchQtyTot+=catAAchQty;
} %>

<tr>
<td class="gridhdbg" colspan="2" style="text-align: right;">Total:</td>
<%-- <td class="gridhdbg" style="text-align: right;"><%=catAPanTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=catATot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(catAPopTot/100000) %></td> --%>
<td class="gridhdbg" style="text-align: right;"><%=catAAchHabsTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=catAAchPop %></td> 
<td class="gridhdbg" style="text-align: right;"><%=catAAchHirSouTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=catAAchQtyTot %></td>

<%-- <td class="gridhdbg" style="text-align: right;"><%=catBPanTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=catBTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(catBPopTot/100000) %></td> 
<td class="gridhdbg" style="text-align: right;"><%=catCPanTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=catCTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(catCPopTot/100000) %></td>   --%>
</tr>
<%
}
catch(Exception e)
{
e.printStackTrace();
}
finally
{
try
{
	if(rs1 != null )
	{
		rs1.close();
	}
	if(stmt1 != null )
	{
		stmt1.close();
	}
	
	if( conn != null )
	{
		conn.close();
	}
}
catch(Exception r)
{
	r.printStackTrace();
}
}

%>
</table>
<%}else if(mode.equals("panchayats")){ 
	String dname=request.getParameter("dname") ;
	String mname=request.getParameter("mname") ;
	%>

		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan='5'>Water Supplied through Hired Sources(test) for District: <%=request.getParameter("dname") %> and Mandal: <%=request.getParameter("mname") %></td>
			
			
	</tr>
	</table>
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr align=center>
	
	               <td class=btext >Sl.No</td>
	               <td class=btext >Panchayat</td> 
				   <!-- <td class=btext colspan="6">Category-A</td>
				   <td class=btext colspan="2">Category-B</td>
			   	   <td class=btext colspan="2">Category-C</td> -->
<!-- 			   	   
	</tr>
	<tr align=center> -->
	
	            <!--    <td class=btext>Habitations</td>
			   	   <td class=btext>Population</td> -->
			   	   <td class=gridhdbg>No of Habitations</td>
				   <!-- <td class=gridhdbg>Population Served</td> -->
				   <td class=gridhdbg>Population Served</td>
			   	   <td class=gridhdbg>No.of Sources hired</td>
			   	   <td class=gridhdbg>Quantity in KL</td>
			   	   <!-- <td class=btext>Habitations</td>
			   	   <td class=btext>Population</td>
			   	   <td class=btext>Habitations</td>
			   	   <td class=btext>Population</td> -->
	</tr>
	<%
	String query="";
	int sno=1;
	int catA=0,catB=0,catC=0,catAPop=0,catBPop=0,catCPop=0;
	int catATot=0,catBTot=0,catCTot=0,catAPopTot=0,catBPopTot=0,catCPopTot=0;
	int catAAchHabs=0,catAAchPop=0,catAAchHirSou=0,catAAchQty=0;
	int catAAchHabsTot=0,catAAchPopTot=0,catAAchHirSouTot=0,catAAchQtyTot=0;
	try
	{
	//String dcode=request.getParameter("dcode");
	String mcode=request.getParameter("mcode");
	query="select pcode,pname from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+mcode+"' order by mcode";

	stmt1=conn.createStatement();

	rs1=stmt1.executeQuery(query);


	 while (rs1.next())
	{
	 /*  String catAQuerry="select count(habcode),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+CENSUS_MINORITY_POPU) from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and TRANSPORTATION='Y' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+rs1.getString("pcode")+"' and sysdate between FRM_DATE and TO_DATE and YEAR='"+year+"'";
	  stmt=conn.createStatement();
	  rs=stmt.executeQuery(catAQuerry);
	  if(rs.next()){
		  catA=rs.getInt(1);
		  catAPop=rs.getInt(2);
	  }
	  stmt.close();
	  rs.close(); */
	  
	  String catAAchievement="select  count(habitation_code) as habs,sum(nvl(POPULATION_SER_PVT_HIRED,'0')) as popServ,sum(nvl(PVT_SOURCES_HIRED_NO,'0')) as hiresou,sum(nvl(PVT_SOURCES_QTY,0)) as qty from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' AND  substr(habcode,13,2)='"+rs1.getString("pcode")+"' and TO_CHAR(date_of_entry,'YYYY')='"+year+"' and ((POPULATION_SER_PVT_HIRED) >0 or ( PVT_SOURCES_HIRED_NO)>0 or  (PVT_SOURCES_QTY)>0) AND substr(habitation_code,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE AND date_of_entry=to_date('"+statusDate+"','dd/mm/yyyy')";
	  // System.out.println(catAAchievement);
	   stmt=conn.createStatement();
	   rs=stmt.executeQuery(catAAchievement);
	   if(rs.next()){
	 	  catAAchHabs=rs.getInt("habs");
	 	  catAAchPop=rs.getInt("popServ");
	 	  catAAchHirSou=rs.getInt("hiresou");
	 	  catAAchQty=rs.getInt("qty");
	   }
	   stmt.close();
	   rs.close();
	  
	/*   String catBQuerry="select count(habcode),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+CENSUS_MINORITY_POPU) from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and TRANSPORTATION='Y' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+rs1.getString("pcode")+"' and sysdate not between FRM_DATE and TO_DATE and YEAR='"+year+"'";
	  stmt=conn.createStatement();
	  rs=stmt.executeQuery(catBQuerry);
	  if(rs.next()){
		  catB=rs.getInt(1);
		  catBPop=rs.getInt(2);
	  }
	  stmt.close();
	  rs.close();
	  
	  String catCQuerry="select count(habcode),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+CENSUS_MINORITY_POPU) from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and TRANSPORTATION='N' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+rs1.getString("pcode")+"' and YEAR='"+year+"'";
	  stmt=conn.createStatement();
	  rs=stmt.executeQuery(catCQuerry);
	  if(rs.next()){
		  catC=rs.getInt(1);
		  catCPop=rs.getInt(2);
	  }
	  stmt.close();
	  rs.close(); */
		%>
				<tr >
			<td class=gridbg2 align="center"><%=sno++%></td>
			<td class=gridbg2 ><%-- <a href="rws_drought_hab_category_rpt.jsp?mode=panchayats&dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=rs1.getString("mcode")%>&mname=<%=rs1.getString("mname")%>"> --%><%=rs1.getString("pname")%><!-- </a> --></td>
			
			<%-- <td class=gridbgAbove75 align="right"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=mandals&mode1=A&dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=mcode%>&mname=<%=mname%>&pcode=<%=rs1.getString("pcode")%>&pname=<%=rs1.getString("pname")%>&statusDate=<%=statusDate%>')"><%=catA%></a></td>
			<td class=gridbgAbove75 align="right"><%=catAPop%></td> --%>
			<td class=gridbgAbove75 align="right"><%=catAAchHabs%></td>
			<td class=gridbgAbove75 align="right"><%=catAAchPop%></td>
			<td class=gridbgAbove75 align="right"><%=catAAchQty%></td>
			<td class=gridbgAbove75 align="right"><%=catAAchHirSou%></td>
			<%-- <td class=gridbg25_50 align="right"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=mandals&mode1=B&dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=mcode%>&mname=<%=mname%>&pcode=<%=rs1.getString("pcode")%>&pname=<%=rs1.getString("pname")%>&statusDate=<%=statusDate%>')"><%=catB%></a></td>
			<td class=gridbg25_50 align="right"><%=catBPop%></td>
			
			<td class=gridbg50_75 align="right"><a href="#" onclick="viewWorks('rws_drought_category_habs_drill_rpt.jsp?mode=mandals&mode1=C&dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=mcode%>&mname=<%=mname%>&pcode=<%=rs1.getString("pcode")%>&pname=<%=rs1.getString("pname")%>&statusDate=<%=statusDate%>')"><%=catC%></a></td>
			<td class=gridbg50_75 align="right"><%=catCPop%></td> --%>
            </tr>
				
				
	<%
	/* catATot+=catA;
	catBTot+=catB;
	catCTot+=catC;
	catAPopTot+=catAPop;
	catBPopTot+=catBPop;
	catCPopTot+=catCPop; */
	catAAchPopTot+=catAAchPop;
	catAAchHabsTot+=catAAchHabs;
	catAAchHirSouTot+=catAAchHirSou;
	catAAchQtyTot+=catAAchQty;
	
	}%>

	<tr>
<td class="gridhdbg" colspan="2" style="text-align: right;">Total:</td>
<%-- <td class="gridhdbg" style="text-align: right;"><%=catATot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(catAPopTot/100000) %></td> --%>
<td class="gridhdbg" style="text-align: right;"><%=catAAchHabsTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=catAAchPop %></td> 
<td class="gridhdbg" style="text-align: right;"><%=catAAchHirSouTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=catAAchQtyTot %></td>
<%-- <td class="gridhdbg" style="text-align: right;"><%=catBTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(catBPopTot/100000) %></td> 
<td class="gridhdbg" style="text-align: right;"><%=catCTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(catCPopTot/100000) %></td>   --%>
</tr>
	<%
	}
	catch(Exception e)
	{
	e.printStackTrace();
	}
	finally
	{
	try
	{
		if(rs1 != null )
		{
			rs1.close();
		}
		if(stmt1 != null )
		{
			stmt1.close();
		}
		
		if( conn != null )
		{
			conn.close();
		}
	}
	catch(Exception r)
	{
		r.printStackTrace();
	}
	}

	%>
	</table>
	<%} %>
</form>

<%@ include file="/commons/rws_footer.jsp" %>

