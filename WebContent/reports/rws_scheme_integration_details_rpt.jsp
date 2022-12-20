
<%@page import="java.util.*" %>
<%
String workid=request.getParameter("work_id");
//System.out.println("workid:"+workid);

%>
<html>
<body>
<form>
<p align=left>


<% 
int sno=1;
try
{
	 String wqry="select asset_code,asset_name,asset_cost,location,to_char(date_creation,'dd/mm/yyyy'),decode(Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED')  from rws_asset_mast_tbl where asset_code='"+workid+"'";
   //System.out.println("wqry:"+wqry);
   Statement  wstmt=conn.createStatement();
	ResultSet wrs=wstmt.executeQuery(wqry);
	boolean exist=false;
	if(wrs.next())
	{
		exist=true;
		%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr  align="center">
		<td align="left" class="rptHeading" colspan=8>VII.Asset Details</font></td>	
	</tr>
<tr>
                <td class=btext>Sl.No</td>
                <td class=btext >Asset Name</td>
                <td class=btext>Asset Cost</td> 
			    <td class=btext>Asset Location</td> 
			    <td class=btext>Date of Creation</td> 
				<td class=btext>Asset Status</td> 
			   </tr>
			  
	 <tr>
	 <td class=rptvalue><%=sno++%></td>
	
	 <td class=rptvalue nowrap><%=wrs.getString(2)%></td>
	 <td class=rptvalue nowrap><%=wrs.getString(3)%></td>
	 <td class=rptvalue nowrap><%=wrs.getString(4)%></td>
	 <td class=rptvalue nowrap><%=wrs.getString(5)%></td>
	 <td class=rptvalue nowrap><%=wrs.getString(6)%></td>
</tr>	 

<%}%>
</table><br>
<%	
String aqry="select dname,mname,pname,vname,panch_name,decode (type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','04','HANDPUMPS','05','SHALLOW HAND PUMPS','06','OPEN WELLS', '07','PONDS','08','OTHERS')as aname from rws_complete_hab_view a ,rws_asset_mast_tbl b where a.panch_code=b.hab_code and b.asset_code='"+workid+"'";
Statement  atstmt=conn.createStatement();
ResultSet atrs=wstmt.executeQuery(aqry);
String det=null;


if(atrs.next())
{
	det="districtname="+atrs.getString(1)+"&mandalname="+atrs.getString(2)+"&panchayatname="+atrs.getString(3)+"&villagename="+atrs.getString(4)+"&panchname="+atrs.getString(5)+"&typeassetname="+atrs.getString(6)+" ";
}
 	

String asttype=workid.substring(6,8);
String assetcode=det+"&assetcode="+workid;
	if(exist){
	nic.watersoft.reports.rws_asset_CheckList_Data dd= new nic.watersoft.reports.rws_asset_CheckList_Data();
  String aa = dd.getCheckListAssetData(workid,workid.substring(6,8),conn); 
 // System.out.println("aa:"+aa);
   String[] aaa = aa.split("/");
	if(asttype!=null && (asttype.equals("01") || asttype.equals("02") || asttype.equals("03") )) {

	
	%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr  align="center">
		<td align="left" class="rptHeading" colspan=8>VIII.Asset Components</font></td>	
	</tr><tr>
				<td class=btext align=center><b>SOURCE</b></td>
			    <td class=btext align=center><b>HEAD WORKS</b></td>
				<td class=btext align=center><b>PIPELINE</b></td>
				<td class=btext align=center><b>SR.RESERVOIRS</b></td>
				<td class=btext align=center><b>OTHERS</b></td>
				<td class=btext align=center><b>PUMPING</b></td> 
				</tr>
				<tr>
	
<%
 

   
	if(!aaa[0].equals("--") || !aaa[1].equals("--")){%>
		
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
        
       <%if(!aaa[0].equals("--")){
		   String surfacesrc="assetReports/rws_source_tbl.jsp?"+assetcode+"&sourcetypecode=1";
		   
		   %>

		<td><font size=1>SUBSURFACE SOURCE</font></td>
		<td><font size=1><a href="<%=surfacesrc%>"><%=aaa[0]%></font></a></td></tr>
		<%}
		if(!aaa[1].equals("--")){
		String surfacesrc1="assetReports/rws_source_tbl.jsp?"+assetcode+"&sourcetypecode=2";%><tr class="mystyle1">
		<td><font size=1>SURFACE SOURCE</font></td>
		<td><font size=1><a href="<%=surfacesrc1%>"><%=aaa[1]%></a></font></td></tr>
		<%}
		}
		else
	   {
			%>
			<td align="center" valign="top" class=rptValue>
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue align=center>-</td>
			<%
	   }%>
		</table></td>
		 <%if(!aaa[2].equals("--") || !aaa[3].equals("--") ||  !aaa[4].equals("--") ||  !aaa[5].equals("--") ||  !aaa[6].equals("--") ||   !aaa[7].equals("--") ||  !aaa[8].equals("--") ||  !aaa[9].equals("--") ||  !aaa[10].equals("--") ||   !aaa[11].equals("--") ||  !aaa[12].equals("--") ){%>
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
	
		<%if(!aaa[2].equals("--")){
			String rawwater="assetReports/rws_rawwater_rpt.jsp?"+assetcode;
			%> <tr class="mystyle1">
		<td><font size=1>RAW WATER COLLECTION WELL</font></td>
		<td><font size=1><a href="<%=rawwater%>"><%=aaa[2]%></a></font></td></tr>
		<%}
		if(!aaa[3].equals("--")){
			String sstank="assetReports/rws_sstank_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>SS TANK</font></td>
		<td><font size=1><a href="<%=sstank%>"><%=aaa[3]%></a></font></td></tr>
		<%}
		if(!aaa[4].equals("--")){String ssfilter="assetReports/rws_ssfilter_rpt.jsp?"+assetcode+"&type=SS";%> <tr class="mystyle1">
		<td><font size=1>SS FILTER</font></td>
		<td><font size=1><a href="<%=ssfilter%>"><%=aaa[4]%></a></font></td></tr>
		<%}
		if(!aaa[5].equals("--")){ String rsfilter="assetReports/rws_rsfilter_rpt.jsp?"+assetcode+"&type=RS";%> <tr class="mystyle1">
		<td><font size=1>RS FILTER</font></td>
		<td><font size=1><a href="<%=rsfilter%>"><%=aaa[5]%></a></font></td></tr>
		<%}
		if(!aaa[6].equals("--")){ String rwsump="assetReports/rws_sump_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>SUMP</font></td>
		<td><font size=1><a href="<%=rwsump%>"><%=aaa[6]%></a></font></td></tr>
		<%}
		if(!aaa[7].equals("--")){ String fpbridge="assetReports/rws_footpathbridge_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>FOOT PATH BRIDGE</font></td>
		<td><font size=1><a href="<%=fpbridge%>"><%=aaa[7]%></a></font></td></tr>
		<%}
		if(!aaa[8].equals("--")){ String pumphousestr="assetReports/rws_pumphouse_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>PUMP HOUSE</font></td>
		<td><font size=1><a href="<%=pumphousestr%>"><%=aaa[8]%></a></font></td></tr>
		<%}
		if(!aaa[9].equals("--")){String watchman="assetReports/rws_watchmanquarter_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>WATCHMAN QUARTER</font></td>
		<td><font size=1><a href="<%=watchman%>"><%=aaa[9]%></a></font></td></tr>
		<%}
		if(!aaa[10].equals("--")){String clearwater="assetReports/rws_clearwater_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>CLEAR WATER COLLECTION WELL</font></td>
		<td><font size=1><a href="<%=clearwater%>"><%=aaa[10]%></a></font></td></tr>
		<%}
		if(!aaa[11].equals("--")){String microfilter="assetReports/rws_microfilter_rpt.jsp?"+assetcode+"&type=MS";%> <tr class="mystyle1">
		<td><font size=1>MICRO FILTER</font></td>
		<td><font size=1><a href="<%=microfilter%>"><%=aaa[11]%></a></font></td></tr>
		<%}
		if(!aaa[12].equals("--")){ String roplants="assetReports/rws_roplants_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>RO PLANTS</font></td>
		<td><font size=1><a href="<%=roplants%>"><%=aaa[12]%></a></font></td></tr>
		<%}
		}
		else
	   {
			%>
			<td align="center" valign="top">
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue align=center>-</td>
		<%}%></table></td>
		 <%if(!aaa[13].equals("--") ||  !aaa[14].equals("--") ||  !aaa[15].equals("--")){%>
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
		<%
		if(!aaa[13].equals("--")){ String pumpingmainstr="assetReports/rws_pumpingmain_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>PUMPING MAIN</font></td>
		<td><font size=1><a href="<%=pumpingmainstr%>"><%=aaa[13]%></font></td></tr>
		<%}
		if(!aaa[14].equals("--")){ String gravity="assetReports/rws_gravitymain_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>GRAVITY MAIN</font></td>
		<td><font size=1><a href="<%=gravity%>"><%=aaa[14]%></font></td></tr>
		<%}
		if(!aaa[15].equals("--")){ String distribution="assetReports/rws_distribution_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>DISTRIBUTION</font></td>
		<td><font size=1><a href="<%=distribution%>"><%=aaa[15]%></font></td></tr>
		<%}
	   }
		else
	   {
			%>
			<td align="center" valign="top">
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue align=center>-</td>
			<%
	   }%>
		</table></td>
		<%if(!aaa[16].equals("--")  || !aaa[17].equals("--") ||  !aaa[18].equals("--") ||  !aaa[19].equals("--") || !aaa[20].equals("--") || !aaa[21].equals("--") ){%>
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
		<%
		if(!aaa[16].equals("--")){String ohsrstr="assetReports/rws_ohsr_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>OHSR</font></td>
		<td><font size=1><a href="<%=ohsrstr%>"><%=aaa[16]%></font></td></tr>
		<%}
		if(!aaa[17].equals("--")){String ohbrstr="assetReports/rws_ohbr_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>OHBR</font></td>
		<td><font size=1><a href="<%=ohbrstr%>"><%=aaa[17]%></font></td></tr>
		<%}
		if(!aaa[18].equals("--")){String glsr="assetReports/rws_glsr_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>GLSR</font></td>
		<td><font size=1><a href="<%=glsr%>"><%=aaa[18]%></font></td></tr>
		<%}
		if(!aaa[19].equals("--")){ String glbr="assetReports/rws_glbr_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>GLBR</font></td>
		<td><font size=1><a href="<%=glbr%>"><%=aaa[19]%></font></td></tr>
		<%}
		if(!aaa[20].equals("--")){ String bptstr="assetReports/rws_bpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>BPT</font></td>
		<td><font size=1><a href="<%=bptstr%>"><%=aaa[20]%></font></td></tr>
		<%}
		if(!aaa[21].equals("--")){ String cisterns="assetReports/rws_cisterns_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>CISTERNS</font></td>
		<td><font size=1><a href="<%=cisterns%>"><%=aaa[21]%></font></td></tr>
		<%}
		}
		else
	   {
			%>
			<td align="center" valign="top">
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue align=center>-</td>
			<%
	   }%>
		</table></td>
		 <%if(!aaa[22].equals("--")  || !aaa[23].equals("--") ||  !aaa[24].equals("--")){%>
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
		<%
		if(!aaa[22].equals("--")){ String miscstr="assetReports/rws_other_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>MISCELLANEOUS</font></td>
		<td><font size=1><a href="<%=miscstr%>"><%=aaa[22]%></font></td></tr>
		<%}
		if(!aaa[23].equals("--")){ String chlorinestr="assetReports/rws_chlorination_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>CHLORINATION</font></td>
		<td><font size=1><a href="<%=chlorinestr%>"><%=aaa[23]%></font></td></tr>
		<%}
		if(!aaa[24].equals("--")){ String ondmstr="assetReports/rws_oandm_rpt.jsp?"+assetcode;%> <tr class="mystyle1">
		<td><font size=1>O AND M</font></td>
		<td><font size=1><a href="<%=ondmstr%>"><%=aaa[24]%></font></td></tr>
		<%}
		}
		else
	   {
			%>
			<td align="center" valign="top">
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue align=center>-</td>
			<%
	   }%>
		</table></td>
		<%
		if(!aaa[25].equals("--")){String pumpsets="assetReports/rws_pumpsets_rpt.jsp?"+assetcode;%>
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
		<td><font size=1>PUMPSETS</font></td>
		<td><font size=1><a href="<%=pumpsets%>"><%=aaa[25]%></font></td></tr>
		<%}
				else
	   {
			%>
			<td align="center" valign="top">
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1"><tr><td colspan=2 class=rptValue align=center>-</td>
			<%
	   }%>
		</table></td>
		


 <%}else if(asttype!=null && asttype.equals("04")){
 
// System.out.println("in type 04");
 if(!aaa[0].equals("--")){
		String hpumpstr="assetReports/rws_handpumps_rpt.jsp?"+assetcode;
		%>
		<td align="center" valign="top">
		<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr  align="center">
		<td align="left" class="rptHeading" colspan=8>VIII.Asset Components</font></td>	
	</tr><tr class="mystyle1">
		<td class=btext >BORE WELL</a></td>
		<td><font size=1><a href="<%=hpumpstr%>"><%=aaa[0]%></a></font></td></tr>
		<%}   
		else
	   {
			%>
			<td align="center" valign="top" class=rptValue>
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue>-</td>
			<%
	   }
 }else if(asttype!=null && asttype.equals("05")){
 
// System.out.println("in type 04");
 if(!aaa[0].equals("--")){
		
		%>
		<td align="center" valign="top">
		<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr  align="center">
		<td align="left" class="rptHeading" colspan=8>VIII.Asset Components</font></td>	
	</tr><tr class="mystyle1">
		<td class=btext >SHALLOW HANDPUMP </a></td>
		<td><font size=1><%=aaa[0]%></a></font></td></tr>
		<%}   
		else
	   {
			%>
			<td align="center" valign="top" class=rptValue>
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue>-</td>
			<%
	   }
 }else if(asttype!=null && asttype.equals("06")){
 

 if(!aaa[0].equals("--")){
		String openwell="assetReports/rws_openwell_rpt.jsp?"+assetcode;
		%>
		<td align="center" valign="top">
		<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr  align="center">
		<td align="left" class="rptHeading" colspan=8>VIII.Asset Components</font></td>	
	</tr><tr class="mystyle1">
		<td class=btext >OPEN WELL </a></td>
		<td><font size=1><a href="<%=openwell%>"><%=aaa[0]%></a></font></td></tr>
		<%}   
		else
	   {
			%>
			<td align="center" valign="top" class=rptValue>
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue>-</td>
			<%
	   }
 }	 else if(asttype!=null && asttype.equals("07")){
 
 if(!aaa[0].equals("--")){
		String ponds="assetReports/rws_ponds_rpt.jsp?"+assetcode;
		%>
		<td align="center" valign="top">
		<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr  align="center">
		<td align="left" class="rptHeading" colspan=8>VIII.Asset Components</font></td>	
	</tr><tr class="mystyle1">
		<td class=btext >PONDS</a></td>
		<td><font size=1><a href="<%=ponds%>"><%=aaa[0]%></a></font></td></tr>
		<%}   
		else
	   {
			%>
			<td align="center" valign="top" class=rptValue>
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue>-</td>
			<%
	   }
 }
else if(asttype!=null && asttype.equals("08")){
 
 if(!aaa[0].equals("--")){
		String others="assetReports/rws_others_rpt.jsp?"+assetcode;
		%>
		<td align="center" valign="top">
		<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr  align="center">
		<td align="left" class="rptHeading" colspan=8>VIII.Asset Components</font></td>	
	</tr><tr class="mystyle1">
		<td class=btext >OTHERS</a></td>
		<td><font size=1><a href="<%=others%>"><%=aaa[0]%></a></font></td></tr>
		<%}   
		else
	   {
			%>
			<td align="center" valign="top" class=rptValue>
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue>-</td>
			<%
	   }
 }


 }
 
 }catch(Exception e)
 {
 } finally
 {
 }


 %>