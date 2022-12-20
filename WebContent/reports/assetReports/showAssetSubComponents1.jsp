<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<head>
<title>W A T E R S O F T</title>
<style type="text/css">
A.nodec { text-decoration: none; }
</style>
<script language="JavaScript">
function fnClose()
{
	window.close();
}
function popWinOpen1(a,b)
{
	var zURL="rws_view_bw.jsp?assetCode="+a+"&schemeCode="+b;
	var zWidth=800,zHeight=400;
	var popFeatures = "width=" + zWidth + ",height=" + zHeight + ",toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1";
	myWin = window.open(zURL,'expenditure1',popFeatures);
	myWin.focus();

}
</script>
</head>
<body>
<jsp:declaration>
public String getAssetScheme(String result)
{

return result;
}
</jsp:declaration>
<%
	 String assetcode= request.getParameter("assetcode");
 	 String typeOfAssetCode= request.getParameter("typeassetcode");
 	 String typeassetname=request.getParameter("typeassetname");
 	 String districtcode=request.getParameter("districtcode");
 	 String mandalcode=request.getParameter("mandalcode");
 	 String panchayatcode=request.getParameter("panchayatcode");
 	 String villagecode=request.getParameter("villagecode");
 	 String districtname=request.getParameter("districtname");
 	 String mandalname=request.getParameter("mandalname");
 	 String panchayatname=request.getParameter("panchayatname");
 	 String villagename=request.getParameter("villagename");
 	 String panchcode=request.getParameter("panchcode");
 	 String panchname=request.getParameter("panchname");
 	 String hrefstring="typeassetcode="+typeOfAssetCode+"&districtname="+districtname+"&mandalname="+mandalname+"&panchayatname="+panchayatname+"&villagename="+villagename+"&assetcode="+assetcode+"&districtcode="+districtcode+"&mandalcode="+mandalcode+"&panchayatcode="+panchayatcode+"&villagecode="+villagecode+"&typeassetname="+typeassetname+"&habcode="+panchcode+"&panchname="+panchname;
 	 
	 String schemeTbl = "";
	 if(typeOfAssetCode!=null && (typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))) 
		 schemeTbl = " rws_asset_scheme_tbl ";
	else if(typeOfAssetCode!=null && typeOfAssetCode.equals("04"))
		schemeTbl = " RWS_HANDPUMP_ASSET_VIEW ";
	else if(typeOfAssetCode!=null && (typeOfAssetCode.equals("05") || typeOfAssetCode.equals("06") || typeOfAssetCode.equals("07")))
		 schemeTbl = " rws_asset_scheme_tbl ";
		 else if(typeOfAssetCode!=null||  typeOfAssetCode.equals("08"))
		 schemeTbl="rws_asset_scheme_tbl";
		 
		 
		 
		

%>
<form action="<%= request.getRequestURI() %>" method="get">

	<%--

    <% while (enumeration.hasMoreElements()) { %>
	<pg:item><%= enumeration.nextElement() %><br></pg:item>
    <% } %>

   --%>
   <table border = 0 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" >
   <caption>
    <tr bgcolor="#edf2f8">
    	<td class="bwborder" align="right" ><a href="javascript:history.go(-1)">Back |</a>
				&nbsp;&nbsp;<a href="/pred/home.jsp">Home</a></td>
			</tr></caption>
   </table>
   <table border=1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse">
   <caption>
   <tr bgcolor="#edf2f8" align="center">
		<td class=rptValue colspan=3><font color="navy">Asset:<%=typeassetname%>&nbsp;District:<%=districtname%>&nbsp;Mandal:<%=mandalname%>&nbsp;Panchayat:<%=panchayatname%>&nbsp;Village:<%=villagename%></td>
	
	</tr>
   </caption>
   </table>
    <table border = 1 bordercolor="black" style="border-collapse:collapse" bgcolor="#ffffff" >
 <tr bgcolor="#8A9FCD" align="center">
		 <td align="center" class="rptHeading" colspan=11><font color="white">Asset  SubComponent Report</font></td>	
   </tr>
    <tr bgcolor="#8A9FCD" align="center">
    <td align="center" class="rptHeading">AssetName</td>
   <%if(typeOfAssetCode!=null && (typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))) 
	 {%><td align="center" class="rptHeading"><b>SOURCE</b></td>
   <td align="center" class="rptHeading"><b>HEAD WORKS</b></td>
    <td align="center" class="rptHeading"><b>PIPELINE</b></td>
<% if(!typeOfAssetCode.equals("09")){%>    
    <td align="center" class="rptHeading"><b>SR.RESERVOIRS</b></td>
    <%} %>
    <td align="center" class="rptHeading"><b>OTHERS</b></td>
    <td align="center" class="rptHeading"><b>PUMPING</b></td><tr>
	<%}
	else if(typeOfAssetCode!=null && typeOfAssetCode.equals("04")){
	%><td align="center" class="rptHeading"><b>HAND PUMPS</b></td>
	<%}
	else if(typeOfAssetCode!=null && typeOfAssetCode.equals("05")){
	%><td align="center" class="rptHeading"><b>SHALLOW HAND PUMPS</b></td>
	<%}
		else if(typeOfAssetCode!=null && typeOfAssetCode.equals("06")){
	%><td align="center" class="rptHeading"><b>OPEN WELLS</b></td>
	<%}
		else if(typeOfAssetCode!=null && typeOfAssetCode.equals("07")){
	%><td align="center" class="rptHeading"><b>PONDS</b></td>
	<%}
	%></tr>
	<%
		String query="select distinct nvl(a.asset_name,'- '),a.hab_code,a.asset_code,a.TYPE_OF_ASSET_CODE,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name,a. division_office_code dc,a.subdivision_office_code sdc,nvl(do.division_office_name,'-')dn,nvl (sdo.subdivision_office_name,'-') sdn,substr(s.scheme_code,17,3),nvl(a.LOCATION,'-')LOCATION,nvl(a.ASSET_COST,'0')ASSET_COST,nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-') as DATE_CREATION,decode(type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','04','HANDPUMPS','05','SHALLOW HAND PUMPS','06','OPEN WELLS', '07','PONDS','08','OTHERS','09','DIRECT PUMPING') AS ANAME from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_asset_mast_tbl a,"+schemeTbl+" s,rws_division_office_tbl do,rws_subdivision_office_tbl sdo where a.asset_code=s.asset_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and type_of_asset_code='"+typeOfAssetCode+"' and d.dcode=do.circle_office_code and d.dcode=sdo.circle_office_code and do.circle_office_code=sdo.circle_office_code and a.division_office_code=do.division_office_code and a.division_office_code=sdo.division_office_code and do.division_office_code=sdo.division_office_code and a.subdivision_office_code=sdo.subdivision_office_code and hd.hab_code=a.hab_code and a.asset_code='"+assetcode+"' order by d.dname,nvl (do.division_office_name,'-'),nvl (sdo.subdivision_office_name,'-'),m.mname,p.pname,v.vname,h.panch_name";
	
		//System.out.println("QUERYFOR OTHERS"+query);
	 int slno = 0;
	stmt=conn.createStatement();


   rs=stmt.executeQuery(query);
    Statement stmt2=null;
	slno = 0;
   while(rs.next())
   { 
     ////////System.out.println(" in wuhile loop  00");
	%>
   <tr>
   <td class=rptvalue><font size=2><%=rs.getString(1).toUpperCase()%></font></td>
      <%
       	// nic.watersoft.reports.rws_asset_CheckList_Data d= new nic.watersoft.reports.rws_asset_CheckList_Data();
		 nic.watersoft.reports.rws_asset_CheckList_Data dd= new nic.watersoft.reports.rws_asset_CheckList_Data();
		String aa = dd.getCheckListAssetData(assetcode,typeOfAssetCode,conn);
		//String chkddata=dd.getCheckListDataOne(rs.getString(3),rs.getString("TYPE_OF_ASSET_CODE"),rs.getString("hab_code"),rs.getString("scheme_code"));
	     String[] aaa = aa.split("/");%>
	     <%
	 if(typeOfAssetCode!=null && (typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))) 
	 {
			if(!aaa[0].equals("--") || !aaa[1].equals("--")){%>
			
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
			
		   <%if(!aaa[0].equals("--")){
		   String surfacesrc="rws_source_tbl.jsp?"+hrefstring+"&sourcetypecode=1";
		   %>
			<td><font size=1>SUBSURFACE SOURCE</font></td>
			<td><font size=1><a href="<%=surfacesrc%>"><%=aaa[0]%></a></font></td></tr>
			<%}
			if(!aaa[1].equals("--")){
			String surfacesrc1="rws_source_tbl.jsp?"+hrefstring+"&sourcetypecode=2";
			%><tr class="mystyle1">
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
					 <tr><td colspan=2 class=rptValue>-</td>
				<%
		   }%>
			</table></td>
			 <%if(!aaa[2].equals("--") || !aaa[3].equals("--") ||  !aaa[4].equals("--") ||  !aaa[5].equals("--") ||  !aaa[6].equals("--") ||   !aaa[7].equals("--") ||  !aaa[8].equals("--") ||  !aaa[9].equals("--") ||  !aaa[10].equals("--") ||   !aaa[11].equals("--") ||  !aaa[12].equals("--") ){
			 %>
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
		
			<%if(!aaa[2].equals("--")){
			String rawwater="rws_rawwater_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>RAW WATER COLLECTION WELL</font></td>
			<td><font size=1><a href="<%=rawwater%>"><%=aaa[2]%></a></font></td></tr>
			<%}
			if(!aaa[3].equals("--")){
			String sstank="rws_sstank_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>SS TANK</font></td>
			<td><font size=1><a href="<%=sstank%>"><%=aaa[3]%></a></font></td></tr>
			<%}
			if(!aaa[4].equals("--")){
			String ssfilter="rws_ssfilter_rpt.jsp?"+hrefstring+"&type=SS";
			%> <tr class="mystyle1">
			<td><font size=1>SS FILTER</font></td>
			<td><font size=1><a href="<%=ssfilter%>"><%=aaa[4]%></a>
			</font></td></tr>
			<%}
			if(!aaa[5].equals("--")){
			String rsfilter="rws_rsfilter_rpt.jsp?"+hrefstring+"&type=RS";
			//String hrefstring="typeassetcode="+typeassetcode+"districtname="+districtname+"&mandalname="+mandalname+"&panchayatname="+panchayatname+"&villagename="+villagename+"&assetcode="+assetcode+"&districtcode="+districtcode+"&mandalcode="+mandalcode+"&panchayatcode="+panchayatcode+"&villagecode="+villagecode+"&typeassetname="+typeassetname+"&rs="+rs22.getString(2);
			%> <tr class="mystyle1">
			<td><font size=1>RS FILTER</font></td>
			<td><font size=1><a href="<%=rsfilter%>"><%=aaa[5]%></a></font></td>
			<td class=rptValue></td>
			<%}
			if(!aaa[6].equals("--")){
			String rwsump="rws_sump_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>SUMP</font></td>
			<td><font size=1><a href="<%=rwsump%>"><%=aaa[6]%></a></font></td></tr>
			<%}
			if(!aaa[7].equals("--")){
			String fpbridge="rws_footpathbridge_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>FOOT PATH BRIDGE</font></td>
			<td><font size=1><a href="<%=fpbridge%>"><%=aaa[7]%></a></font></td></tr>
			<%}
			if(!aaa[8].equals("--")){
			String pumphousestr="rws_pumphouse_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>PUMP HOUSE</font></td>
			<td><font size=1><a href="<%=pumphousestr%>"><%=aaa[8]%></a></font></td></tr>
			<%}
			if(!aaa[9].equals("--")){
			String watchman="rws_watchmanquarter_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>WATCHMAN QUARTER</font></td>
			<td><font size=1><a href="<%=watchman%>"><%=aaa[9]%></a></font></td></tr>
			<%}
			if(!aaa[10].equals("--")){
			String clearwater="rws_clearwater_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>CLEAR WATER COLLECTION WELL</font></td>
			<td><font size=1><a href="<%=clearwater%>"><%=aaa[10]%></a></font></td></tr>
			<%}
			if(!aaa[11].equals("--")){
			String microfilter="rws_microfilter_rpt.jsp?"+hrefstring+"&type=MS";
			%> <tr class="mystyle1">
			<td><font size=1>MICRO FILTER</font></td>
			<td><font size=1><a href="<%=microfilter%>"><%=aaa[11]%></a></font></td></tr>
			<%}
			if(!aaa[12].equals("--")){
			String roplants="rws_roplants_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
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
					 <tr><td colspan=2 class=rptValue>-</td>
			<%}%></table></td>
			 <%if(!aaa[13].equals("--") ||  !aaa[14].equals("--") ||  !aaa[15].equals("--")){%>
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
			<%
			if(!aaa[13].equals("--")){
			String pumpingmainstr="rws_pumpingmain_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>PUMPING MAIN</font></td>
			<td><font size=1><a href="<%=pumpingmainstr%>"><%=aaa[13]%></a></font></td></tr>
			<%}
			if(!aaa[14].equals("--")){
			String gravity="rws_gravitymain_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>GRAVITY MAIN</font></td>
			<td><font size=1><a href="<%=gravity%>"><%=aaa[14]%></a></font></td></tr>
			<%}
			if(!aaa[15].equals("--")){
			String distribution="rws_distribution_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>DISTRIBUTION</font></td>
			<td><font size=1><a href="<%=distribution%>"><%=aaa[15]%></a></font></td></tr>
			<%}
		   }
			else
		   {
				%>
				<td align="center" valign="top">
				<table width="130" border="0" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
					 <tr><td colspan=2 class=rptValue>-</td>
				<%
		   }%>
			</table></td>
			<%if(!aaa[16].equals("--")  || !aaa[17].equals("--") ||  !aaa[18].equals("--") ||  !aaa[19].equals("--") || !aaa[20].equals("--") || !aaa[21].equals("--") ){%>
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
			<%
			if(!aaa[16].equals("--")){
			String ohsrstr="rws_ohsr_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>OHSR</font></td>
			<td><font size=1><a href="<%=ohsrstr%>"><%=aaa[16]%></a></font></td></tr>
			<%}
			if(!aaa[17].equals("--")){
			String ohbrstr="rws_ohbr_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>OHBR</font></td>
			<td><font size=1><a href="<%=ohbrstr%>"><%=aaa[17]%></a></font></td></tr>
			<%}
			if(!aaa[18].equals("--")){
			String glsr="rws_glsr_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>GLSR</font></td>
			<td><font size=1><a href="<%=glsr%>"><%=aaa[18]%></a></font></td></tr>
			<%}
			if(!aaa[19].equals("--")){
			String glbr="rws_glbr_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>GLBR</font></td>
			<td><font size=1><a href="<%=glbr%>"><%=aaa[19]%></a></font></td></tr>
			<%}
			if(!aaa[20].equals("--")){
			String bptstr="rws_bpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>BPT</font></td>
			<td><font size=1><a href="<%=bptstr%>"><%=aaa[20]%></a></font></td></tr>
			<%}
			if(!aaa[21].equals("--")){
			String cisterns="rws_cisterns_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>CISTERNS</font></td>
			<td><font size=1><a href="<%=cisterns%>">
			<%=aaa[21]%></a>
			</font></td></tr>
			<%}
			}
		%>
			 <%if(!aaa[22].equals("--")  || !aaa[23].equals("--") ||  !aaa[24].equals("--")){%>
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
			<%
			if(!aaa[22].equals("--")){
			String miscstr="rws_other_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>MISCELLANEOUS</font></td>
			<td><font size=1><a href="<%=miscstr%>">			
			<%=aaa[22]%></a>
			</font></td></tr>
			<%}
			if(!aaa[23].equals("--")){
			String chlorinestr="rws_chlorination_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>CHLORINATION</font></td>
			<td><font size=1><a href="<%=chlorinestr%>"><%=aaa[23]%></a></font></td></tr>
			<%}
			if(!aaa[24].equals("--")){
			String ondmstr="rws_oandm_rpt.jsp?"+hrefstring;
			%> <tr class="mystyle1">
			<td><font size=1>O AND M</font></td>
			<td><font size=1>
			<a href="<%=ondmstr%>">
			<%=aaa[24]%></a>
			</font></td></tr>
			<%}
			}
			else
		   {
				%>
				<td align="center" valign="top">
				<table width="130" border="0" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
					 <tr><td colspan=2 class=rptValue>-</td>
				<%
		   }%>
			</table></td>
			<%
			if(!aaa[25].equals("--")){
			String pumpsets="rws_pumpsets_rpt.jsp?"+hrefstring;

			%>
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
			<td><font size=1>PUMPSETS</font></td>
			<td><font size=1><a href="<%=pumpsets%>"><%=aaa[25]%></a></font></td></tr>
			<%}
					else
		   {
				%>
				<td align="center" valign="top">
				<table width="130" border="0" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1"><tr><td colspan=2 class=rptValue>-</td>
				<%
		   }
	}
	else if(typeOfAssetCode!=null && typeOfAssetCode.equals("04"))
	   {
		if(!aaa[0].equals("--")){
		String hpumpstr="rws_handpumps_rpt.jsp?"+hrefstring;
		%>
		<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
								<tr class="mystyle1">
		<td><a href=""><font size=1 face="verdana">BORE WELL</font></a></td>
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
	   }
	else if(typeOfAssetCode!=null && typeOfAssetCode.equals("05"))
	   {
		if(!aaa[0].equals("--")){%>
		<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
								<tr class="mystyle1">
		<td><font size=1 face="verdana">SHALLOW HAND PUMP</font></td>
		<td><font size=1><%=aaa[0]%></font></td></tr>
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
	   else if(typeOfAssetCode!=null && typeOfAssetCode.equals("06"))
	   {
		if(!aaa[0].equals("--")){
		String openwell="rws_openwell_rpt.jsp?"+hrefstring;
		%>
		<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
								<tr class="mystyle1">
		<td><font size=1 face="verdana">OPEN WELL</a></td>
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
	   }
	   else if(typeOfAssetCode!=null && typeOfAssetCode.equals("07"))
	   {
		if(!aaa[0].equals("--")){
		String ponds="rws_ponds_rpt.jsp?"+hrefstring;
		%>
		<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
								<tr class="mystyle1">
		<td><font size=1 face="verdana">PONDS</font></td>
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
	   else if(typeOfAssetCode!=null && typeOfAssetCode.equals("08")){
	   if(!aaa[0].equals("--")){
	   String others="rws_others_rpt.jsp?"+hrefstring;
		%>
		<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
								<tr class="mystyle1">
		<td><font size=1 face="verdana">OTHERS</font></td>
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
	   
	   %></table></td>


 <%}
 	if(rs!=null)rs.close();
	if(stmt!=null)stmt.close();
//	if(conn!=null)conn.close();
%> 
</table>
 
<%@ include file="/commons/rws_footer.jsp" %>
</table>
</center>
</body>
</html>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
