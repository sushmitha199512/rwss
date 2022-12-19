<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ page session="false" %>
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
<body bgcolor="#ffffff">
<jsp:declaration>

public String getAssetScheme(String result)
{

return result;
}
</jsp:declaration>
<%
	 String assetcode= request.getParameter("assetCode");
 	 String typeOfAssetCode= request.getParameter("typeOfAssetCode");
	 String schemeTbl = "";
	 if(typeOfAssetCode!=null && (typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))) 
		 schemeTbl = " rws_asset_scheme_tbl ";
	else if(typeOfAssetCode!=null && typeOfAssetCode.equals("04"))
		schemeTbl = " RWS_HANDPUMP_ASSET_VIEW ";
	else if(typeOfAssetCode!=null && (typeOfAssetCode.equals("05") || typeOfAssetCode.equals("06") || typeOfAssetCode.equals("07")))
		 schemeTbl = " rws_asset_scheme_tbl ";

%>
<form action="<%= request.getRequestURI() %>" method="get">
<center>

</td>
</tr>

</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=white style="border-collapse:collapse" bgcolor="#ffffff" align = "center">

<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="javascript:fnClose()">Close</a></td>
			</tr>
		</table>
	</caption>
	<%--

    <% while (enumeration.hasMoreElements()) { %>
	<pg:item><%= enumeration.nextElement() %><br></pg:item>
    <% } %>

   --%>
    <table border = 1 bordercolor="black" style="border-collapse:collapse" bgcolor="#ffffff" >
 <tr bgcolor="#8A9FCD" align="center">
		 <td align="center" class="rptHeading" colspan=11><font color="white">Asset Check List - SubComponent Report</font></td>	
   </tr>
    <tr bgcolor="#8A9FCD" align="center">
    <td align="center" class="rptHeading">AssetName</td>
   <%if(typeOfAssetCode!=null && (typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))) 
	 {%><td align="center" class="rptHeading"><b>SOURCE</b></td>
   <td align="center" class="rptHeading"><b>HEAD WORKS</b></td>
    <td align="center" class="rptHeading"><b>PIPELINE</b></td>
    <td align="center" class="rptHeading"><b>SR.RESERVOIRS</b></td>
    <td align="center" class="rptHeading"><b>OTHERS</b></td>
    <td align="center" class="rptHeading"><b>PUMPING</b></td>
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
	
	 int slno = 0;
	stmt=conn.createStatement();
	 //////System.out.println("qry:"+query);

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
			
		   <%if(!aaa[0].equals("--")){%>

			<td><font size=1>SUBSURFACE SOURCE</font></td>
			<td><font size=1><%=aaa[0]%></font></td></tr>
			<%}
			if(!aaa[1].equals("--")){%><tr class="mystyle1">
			<td><font size=1>SURFACE SOURCE</font></td>
			<td><font size=1><%=aaa[1]%></font></td></tr>
			<%}
			}
			else
		   {
				%>
				<td align="center" valign="top" class=rptValue>
				<table width="130" border="0" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
					 <tr><td colspan=2 class=rptValue></td>
				<%
		   }%>
			</table></td>
			 <%if(!aaa[2].equals("--") || !aaa[3].equals("--") ||  !aaa[4].equals("--") ||  !aaa[5].equals("--") ||  !aaa[6].equals("--") ||   !aaa[7].equals("--") ||  !aaa[8].equals("--") ||  !aaa[9].equals("--") ||  !aaa[10].equals("--") ||   !aaa[11].equals("--") ||  !aaa[12].equals("--") ){%>
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
		
			<%if(!aaa[2].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>RAW WATER COLLECTION WELL</font></td>
			<td><font size=1><%=aaa[2]%></font></td></tr>
			<%}
			if(!aaa[3].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>SS TANK</font></td>
			<td><font size=1><%=aaa[3]%></font></td></tr>
			<%}
			if(!aaa[4].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>SS FILTER</font></td>
			<td><font size=1><%=aaa[4]%></font></td></tr>
			<%}
			if(!aaa[5].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>RS FILTER</font></td>
			<td><font size=1><%=aaa[5]%></font></td></tr>
			<%}
			if(!aaa[6].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>SUMP</font></td>
			<td><font size=1><%=aaa[6]%></font></td></tr>
			<%}
			if(!aaa[7].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>FOOT PATH BRIDGE</font></td>
			<td><font size=1><%=aaa[7]%></font></td></tr>
			<%}
			if(!aaa[8].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>PUMP HOUSE</font></td>
			<td><font size=1><%=aaa[8]%></font></td></tr>
			<%}
			if(!aaa[9].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>WATCHMAN QUARTER</font></td>
			<td><font size=1><%=aaa[9]%></font></td></tr>
			<%}
			if(!aaa[10].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>CLEAR WATER COLLECTION WELL</font></td>
			<td><font size=1><%=aaa[10]%></font></td></tr>
			<%}
			if(!aaa[11].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>MICRO FILTER</font></td>
			<td><font size=1><%=aaa[11]%></font></td></tr>
			<%}
			if(!aaa[12].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>RO PLANTS</font></td>
			<td><font size=1><%=aaa[12]%></font></td></tr>
			<%}
			}
			else
		   {
				%>
				<td align="center" valign="top">
				<table width="130" border="0" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
					 <tr><td colspan=2 class=rptValue></td>
			<%}%></table></td>
			 <%if(!aaa[13].equals("--") ||  !aaa[14].equals("--") ||  !aaa[15].equals("--")){%>
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
			<%
			if(!aaa[13].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>PUMPING MAIN</font></td>
			<td><font size=1><%=aaa[13]%></font></td></tr>
			<%}
			if(!aaa[14].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>GRAVITY MAIN</font></td>
			<td><font size=1><%=aaa[14]%></font></td></tr>
			<%}
			if(!aaa[15].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>DISTRIBUTION</font></td>
			<td><font size=1><%=aaa[15]%></font></td></tr>
			<%}
		   }
			else
		   {
				%>
				<td align="center" valign="top">
				<table width="130" border="0" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
					 <tr><td colspan=2 class=rptValue></td>
				<%
		   }%>
			</table></td>
			<%if(!aaa[16].equals("--")  || !aaa[17].equals("--") ||  !aaa[18].equals("--") ||  !aaa[19].equals("--") || !aaa[20].equals("--") || !aaa[21].equals("--") ){%>
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
			<%
			if(!aaa[16].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>OHSR</font></td>
			<td><font size=1><%=aaa[16]%></font></td></tr>
			<%}
			if(!aaa[17].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>OHBR</font></td>
			<td><font size=1><%=aaa[17]%></font></td></tr>
			<%}
			if(!aaa[18].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>GLSR</font></td>
			<td><font size=1><%=aaa[18]%></font></td></tr>
			<%}
			if(!aaa[19].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>GLBR</font></td>
			<td><font size=1><%=aaa[19]%></font></td></tr>
			<%}
			if(!aaa[20].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>BPT</font></td>
			<td><font size=1><%=aaa[20]%></font></td></tr>
			<%}
			if(!aaa[21].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>CISTERNS</font></td>
			<td><font size=1><%=aaa[21]%></font></td></tr>
			<%}
			}
			else
		   {
				%>
				<td align="center" valign="top">
				<table width="130" border="0" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
					 <tr><td colspan=2 class=rptValue></td>
				<%
		   }%>
			</table></td>
			 <%if(!aaa[22].equals("--")  || !aaa[23].equals("--") ||  !aaa[24].equals("--")){%>
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
			<%
			if(!aaa[22].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>MISCELLANEOUS</font></td>
			<td><font size=1><%=aaa[22]%></font></td></tr>
			<%}
			if(!aaa[23].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>CHLORINATION</font></td>
			<td><font size=1><%=aaa[23]%></font></td></tr>
			<%}
			if(!aaa[24].equals("--")){%> <tr class="mystyle1">
			<td><font size=1>O AND M</font></td>
			<td><font size=1><%=aaa[24]%></font></td></tr>
			<%}
			}
			else
		   {
				%>
				<td align="center" valign="top">
				<table width="130" border="0" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
					 <tr><td colspan=2 class=rptValue></td>
				<%
		   }%>
			</table></td>
			<%
			if(!aaa[25].equals("--")){%>
			<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1">
			<td><font size=1>PUMPSETS</font></td>
			<td><font size=1><%=aaa[25]%></font></td></tr>
			<%}
					else
		   {
				%>
				<td align="center" valign="top">
				<table width="130" border="0" bordercolor="black"
					style="border-collapse:collapse;">  
			<tr class="mystyle1"><tr><td colspan=2 class=rptValue></td>
				<%
		   }
	}
	else if(typeOfAssetCode!=null && typeOfAssetCode.equals("04"))
	   {
		if(!aaa[0].equals("--")){%>
		<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
								<tr class="mystyle1">
		<td><a href="javascript:popWinOpen1('<%=rs.getString(3)%>','<%=rs.getString(19)%>')"><font size=1 face="verdana">BORE WELL</font></a></td>
		<td><font size=1><%=aaa[0]%></font></td></tr>
		<%}   
		else
	   {
			%>
			<td align="center" valign="top" class=rptValue>
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue></td>
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
				 <tr><td colspan=2 class=rptValue></td>
			<%
	   }
	   } 
	   else if(typeOfAssetCode!=null && typeOfAssetCode.equals("06"))
	   {
		if(!aaa[0].equals("--")){%>
		<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
								<tr class="mystyle1">
		<td><font size=1 face="verdana">OPEN WELL</a></td>
		<td><font size=1><%=aaa[0]%></font></td></tr>
		<%}   
		else
	   {
			%>
			<td align="center" valign="top" class=rptValue>
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue></td>
			<%
	   }
	   }
	   else if(typeOfAssetCode!=null && typeOfAssetCode.equals("07"))
	   {
		if(!aaa[0].equals("--")){%>
		<td align="center" valign="top">
				<table width="130" border="1" bordercolor="black"
					style="border-collapse:collapse;">  
								<tr class="mystyle1">
		<td><font size=1 face="verdana">PONDS</font></td>
		<td><font size=1><%=aaa[0]%></font></td></tr>
		<%}   
		else
	   {
			%>
			<td align="center" valign="top" class=rptValue>
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue></td>
			<%
	   }
	   }%>
		</table></td>


 <%}
 	if(rs!=null)rs.close();
	if(stmt!=null)stmt.close();
//	if(conn!=null)conn.close();
%> </table>
 <table>
 <tr><td>
<tr><td>
<font style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;"><%@ include file = "footer.jsp" %></font>
</td></tr>
</center>
</body>
</html>
<%@ include file="connClose.jsp" %>
<%}finally{}%>