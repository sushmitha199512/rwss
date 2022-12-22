



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ page import="nic.watersoft.reports.AssetHabLinkReportBean"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>


 <link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/rwsstyle.css'/>">

<SCRIPT LANGUAGE="JavaScript">


</script>
<html:html>

<HEAD>
<TITLE></TITLE>

<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
</HEAD>
<BODY>
<%int linkAssetCount;
  linkAssetCount=((java.util.ArrayList)request.getAttribute("linkAssets")).size();
  //System.out.println("linkAssetCount is"+linkAssetCount);
%>

<TABLE width="100%">
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="100%">ASSET HABITATION LINK REPORT</td>
</tr>
</TABLE>
<%String comp=null; 
comp=(String)request.getAttribute("AssetHabLinkComponet");%>

<%if(comp.equalsIgnoreCase("AssetHabLink"))
{ %>
<TABLE width="100" border=1 align="center">

<TR><td><A HREF="./AssetHabLink.do?subComp=mainAssets">Main Assets</A></td>
</TR>
<tr><td><A HREF="./AssetHabLink.do?subComp=linkedAssets">Linked Assets</A></td>
</TR>
</TABLE>
<%} %>

<%if(comp.equalsIgnoreCase("MainAssets"))
{ %>

   <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						
			
						<TH>S.No</TH>
						<th>Asset Code</th>
						<th>Asset Name</th>
						</THEAD>
					<logic:iterate id="pwsReport" name="AssetHabLinkReport"
						scope="request">
						
							<TR>
								<logic:iterate id="InnerIterate" name="pwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="InnerIterate" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
				</TABLE>

<%} %>

<%if(comp.equalsIgnoreCase("LinkAssets"))
{ %>

   <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						
			
						<TH>S.No</TH>
						<th>Asset Code</th>
						
						</THEAD>
					<logic:iterate id="pwsReport" name="AssetHabLinkReport"
						scope="request">
						
							<TR>
								<logic:iterate id="InnerIterate" name="pwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="InnerIterate" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
				</TABLE>

<%} %>

<%if(comp.equalsIgnoreCase("AssetHabLinkReport") && linkAssetCount!=0)
{ %>
<TABLE width="100%">
 <tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="100%">
<logic:present name="selectionCriteria" property="district" scope="request" >
District:<bean:write name="selectionCriteria" property="district" scope="request" ignore="true"/>
</logic:present>

<logic:present name="selectionCriteria" property="mandal" scope="request" >
&nbsp;&nbsp;Mandal:<bean:write name="selectionCriteria" property="mandal" scope="request" ignore="true"/>
</logic:present>

<logic:present name="selectionCriteria" property="panchayat" scope="request" >
&nbsp;&nbsp;Panchayat:<bean:write name="selectionCriteria" property="panchayat" scope="request" ignore="true"/>
</logic:present>

<logic:present name="selectionCriteria" property="village" scope="request" >
&nbsp;&nbsp;Village:<bean:write name="selectionCriteria" property="village" scope="request" ignore="true"/>
</logic:present>

<logic:present name="selectionCriteria" property="habitation" scope="request" >
&nbsp;&nbsp;Habitation:<bean:write name="selectionCriteria" property="habitation" scope="request" ignore="true"/>
</logic:present>
</td>
</tr>
</TABLE>


   <TABLE border="1" cellspacing="0" cellpadding="0" 
					bordercolor="#000000" style="border-collapse:collapse">
					
						<tr bgcolor="#8A9FCD" align="left"  class="textborder">
						<td rowspan="2" align="center" width="120">S.No.</td>
						<td colspan="5" align="center">No. Of Assets(Headworks)</td>
						<td colspan="5" align="center">No. Of Assets(Linked To The Habitation)</td>
						</tr>
						<tr bgcolor="#8A9FCD" align="left"  class="textborder">
						<td width="120">Scheme Code</td>
						<td width="120">Asset Name</td>
						<td width="120">Asset Location</td>
						<td width="120">Date Of Creation</td>
						<td width="120">Cost of Asset (Rs in Lakhs)</td>
						<td width="120">Scheme Code</td>
						<td width="120">Asset Name</td>
						<td width="120">Asset Location</td>
						<td width="120">Date Of Creation</td>
						<td width="120">Cost of Asset (Rs in Lakhs)</td>
						</tr>
			
						
						
					<logic:iterate id="pwsReport" name="linkAssets"
						scope="request">
						
							
					 			<tr>
					 			
					 				<TD class="mystyle1" width="120"><bean:write name="pwsReport" property="sno" ignore="true"/></td>
					 				<TD class="mystyle1" width="120"><a href="ComponentDrillDown.do?schemeCode=<%=((AssetHabLinkReportBean)pwsReport).getHw_scheme_code()%>&subComp=subCompDetails"><bean:write name="pwsReport" property="hw_scheme_code" ignore="true"/></td>
					 				<TD class="mystyle1" width="120"><a href="ComponentDrillDown.do?schemeCode=<%=((AssetHabLinkReportBean)pwsReport).getHw_scheme_code()%>&subComp=subCompDetails"><bean:write name="pwsReport" property="hw_asset_name" ignore="true"/></td>
					 				<TD class="mystyle1" width="120"><bean:write name="pwsReport" property="hw_asset_location" ignore="true"/></td>
					 				<TD class="mystyle1" width="120"><bean:write name="pwsReport" property="hw_date_creation" ignore="true"/></td>
					 				<TD class="mystyle1" width="120"><bean:write name="pwsReport" property="hw_asset_cost" ignore="true"/></td>
					 				<TD class="mystyle1" width="120"><a href="ComponentDrillDown.do?schemeCode=<%=((AssetHabLinkReportBean)pwsReport).getLinked_scheme_code()%>&subComp=subCompDetails"><bean:write name="pwsReport" property="linked_scheme_code" ignore="true"/></td>
					 				<TD class="mystyle1" width="120"><a href="ComponentDrillDown.do?schemeCode=<%=((AssetHabLinkReportBean)pwsReport).getLinked_scheme_code()%>&subComp=subCompDetails"><bean:write name="pwsReport" property="linked_asset_name" ignore="true"/></td>
					 				<TD class="mystyle1" width="120"><bean:write name="pwsReport" property="linked_asset_location" ignore="true"/></td>
					 				<TD class="mystyle1" width="120"><bean:write name="pwsReport" property="linked_date_creation" ignore="true"/></td>
					 				<TD class="mystyle1" width="120"><bean:write name="pwsReport" property="linked_asset_cost" ignore="true"/></td>
					 			</tr>
								</logic:iterate> 
								
				</TABLE>

<%} %>

<%if(comp.equalsIgnoreCase("AssetHabLinkReport") && linkAssetCount==0)
{ %>

 <TABLE border="1" cellspacing="0" cellpadding="0" 
					bordercolor="#000000" style="border-collapse:collapse">
					
						<tr bgcolor="#8A9FCD" align="left"  class="textborder">
						<td rowspan="2" align="center" width="120">S.No.</td>
						<td colspan="5" align="center">No. Of Assets(Headworks)</td>
						<td colspan="5" align="center">No. Of Assets(Linked To The Habitation)</td>
						</tr>
						<tr bgcolor="#8A9FCD" align="left"  class="textborder">
						<td width="120">Scheme Code</td>
						<td width="120">Asset Name</td>
						<td width="120">Asset Location</td>
						<td width="120">Date Of Creation</td>
						<td width="120">Cost of Asset</td>
						<td width="120">Scheme Code</td>
						<td width="120">Asset Name</td>
						<td width="120">Asset Location</td>
						<td width="120">Date Of Creation</td>
						<td width="120">Cost of Asset</td>
						<!-- <td>Asset Name</td>
						<td>Asset Location</td> -->
						</tr>
						<tr>
						<td colspan=20 align="center">No Assets Available</td></tr>
						</TABLE>
<%} %>

</BODY>

</html:html>
<%@ include file="/commons/rws_footer.jsp"%>
