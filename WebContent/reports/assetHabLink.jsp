



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>

<%@ include file="/commons/rws_header1.jsp" %>


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
<%int mainAssetsCount;
  mainAssetsCount=((java.util.ArrayList)request.getAttribute("mainAssets")).size();
 //System.out.println("mainAssetCount is"+mainAssetsCount);
%>
<TABLE>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="850">ASSET HABITATION LINK REPORT</td>
</tr>
</TABLE>
<%String comp=null; 
comp=(String)request.getAttribute("AssetHabLinkComponet");%>

<%if(comp.equalsIgnoreCase("AssetHabLink"))
{ %>
<TABLE width="100" border=1 align="center">

<TR><td><A HREF="./reports/AssetHabLink.do?subComp=mainAssets">Main Assets</A></td>
</TR>
<tr><td><A HREF="./reports/AssetHabLink.do?subComp=linkedAssets">Linked Assets</A></td>
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

<%if(comp.equalsIgnoreCase("AssetHabLinkReport") && (mainAssetsCount!=0 || linkAssetCount!=0))
{ %>



   <TABLE border="1" cellspacing="0" cellpadding="0" 
					bordercolor="#000000" style="border-collapse:collapse">
					
						<tr bgcolor="#8A9FCD" align="left"  class="textborder">
						<td rowspan="2" align="center" width="120">S.No.</td>
						<td colspan="4" align="center">Main Assets</td>
						<td colspan="4" align="center">Link Assets</td>
						</tr>
						<tr bgcolor="#8A9FCD" align="left"  class="textborder">
						<td width="120">Asset Code</td>
						<td width="120">Asset Name</td>
						<td width="120">Asset Location</td>
						<td width="120">Date of Creation</td>
						<td width="120">Asset Code</td>
						<td width="120">Asset Name</td>
						<td width="120">Asset Location</td>
						<td width="120">Date of Creation</td>
						</tr>
			<tr><td colspan="5">
						<table border="1" bordercolor="black" style="border-collapse:collapse" cellspacing="0" cellpadding="0" >
						
					<logic:iterate id="pwsReport" name="mainAssets"
						scope="request">
						
							<TR >
								<logic:iterate id="InnerIterate" name="pwsReport" 
									offset="offset">
									<TD class="mystyle1" width="120"><bean:write name="InnerIterate" ignore="true"/></TD>
								</logic:iterate>
							</TR>
					
					</logic:iterate> 
					</table>	
					</td>
					<td colspan="4">
					
					<table border="1" bordercolor="black" style="border-collapse:collapse" cellspacing="0" cellpadding="0" >
						
					<logic:iterate id="pwsReport" name="linkAssets"
						scope="request">
						
							<TR >
								<logic:iterate id="InnerIterate" name="pwsReport" 
									offset="offset">
									<TD class="mystyle1" width="107"><bean:write name="InnerIterate" ignore="true"/></TD>
								</logic:iterate>
							</TR>
					
					</logic:iterate> 
					</table>	
					
					
					
					</td>
					</tr>
				</TABLE>

<%} %>

<%if(comp.equalsIgnoreCase("AssetHabLinkReport") && mainAssetsCount==0 && linkAssetCount==0)
{ %>
 <TABLE border="1" cellspacing="0" cellpadding="0" 
					bordercolor="#000000" style="border-collapse:collapse">
					
						<tr bgcolor="#8A9FCD" align="left"  class="textborder">
						<td rowspan="2" align="center" width="60">S.No.</td>
						<td colspan="3" align="center">Main Assets</td>
						<td colspan="3" align="center">Linked Assets</td>
						</tr>
						<tr bgcolor="#8A9FCD" align="left"  class="textborder">
						<td width="120">Asset Code</td>
						<td width="120">Asset Name</td>
						<td width="120">Asset Location</td>
						<td width="120">Date of Creation</td>
						<td width="120">Asset Code</td>
						<td width="120">Asset Name</td>
						<td width="120">Asset Location</td>
						<td width="120">Date of Creation</td>
						<!-- <td>Asset Name</td>
						<td>Asset Location</td> -->
						</tr>
						<tr>
						<td colspan=20 align="center">No Assets Available</td></tr>
						</TABLE>
<%} %>

</BODY>

</html:html>

