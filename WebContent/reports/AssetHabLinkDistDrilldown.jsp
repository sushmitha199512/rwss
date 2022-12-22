<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ page import="nic.watersoft.reports.AssetHabLinkDrilldownBean"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>


 <link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/rwsstyle.css'/>">

<SCRIPT LANGUAGE="JavaScript">
function Print()
{
 alert("Print this page");
 window.print();
    
}


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
<%//System.out.println("in assethablinkdistdrilldown.jsp"); %>
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("linkAssets")).size();
//System.out.println("count="+count);
%>

<%if(count>1)
{ %>

<%String comp=(String)request.getAttribute("AssetHabLinkComponet"); %>

<%if(comp.equalsIgnoreCase("AssetHabLinkDistDrillDown")) 
{%>  
  <%//System.out.println("in district drill down"); %>


					
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >DISTRICT NAME</TH>
						<th>NO. OF HABITATIONS</th>
						<TH>NO. OF ASSETS(HEADWORKS)</TH>
						<TH>NO. OF ASSETS(LINKED TO THE HABITATION)</TH>
				
					</THEAD>
					<logic:iterate id="cpwsReport" name="linkAssets"
						scope="request" length="<%=Integer.toString(count-1)%>" >
							<TR>
						
							<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>	
							<td class="mystyle1"><a href="./reports/AssetHabLinkDistDrilldown.do?district=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=MandalDrilldown"><bean:write name="cpwsReport" property="name"/></a></td>
						    <td class="mystyle1"><a href="./reports/AssetHabLink.do?district=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=DistDrilldownDisplayAll"><bean:write name="cpwsReport" property="habitation"/></td>	
							<td class="mystyle1"><a href="./reports/AssetHabLink.do?district=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=DistDrilldownDisplayAll"><bean:write name="cpwsReport" property="asset"/></td>								
							<td class="mystyle1"><a href="./reports/AssetHabLink.do?district=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=DistDrilldownDisplayAll"><bean:write name="cpwsReport" property="linkAsset"/></td>	
							</TR>
					</logic:iterate>
					<TR>
						
							<td class="mystyle1">**</td>	
							<td class="mystyle1"><bean:write name="totalBean" property="name"/></td>
						    <td class="mystyle1"><bean:write name="totalBean" property="habitation"/></td>
						    
							<td class="mystyle1"><bean:write name="totalBean" property="asset"/></td>								
							<td class="mystyle1"><bean:write name="totalBean" property="linkAsset"/></td>	
							</TR>
				</TABLE>


<%} %>


 <%if(comp.equalsIgnoreCase("AssetHabLinkMandalDrillDown")) 
{%> 
  <%//System.out.println("in mandal drill down JSP"); %>
 <%//int count;
  count=((java.util.ArrayList)request.getAttribute("linkAssets")).size();
//System.out.println("count="+count);
%>

<TABLE width="100%">
 <tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="100%">District:<bean:write name="selectionCriteria" property="district" scope="request" ignore="true"/>
</td>
</tr>
</TABLE>

					
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<th>NO. OF HABITATIONS</th>
						<TH>NO. OF ASSETS(HEADWORKS)</TH>
						<TH>NO. OF ASSETS(LINKED TO THE HABITATION)</TH>
				
					</THEAD>
					<logic:iterate id="cpwsReport" name="linkAssets"
						scope="request" length="<%=Integer.toString(count-1)%>" >
							<TR>
						
							<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>	
							<td class="mystyle1"><a href="./AssetHabLinkDistDrilldown.do?mandal=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=PanchayatDrilldown"><bean:write name="cpwsReport" property="name"/></a></td>
						    <td class="mystyle1"><a href="./AssetHabLink.do?mandal=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=MandalDrilldownDisplayAll"><bean:write name="cpwsReport" property="habitation"/></td>	
							<td class="mystyle1"><a href="./AssetHabLink.do?mandal=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=MandalDrilldownDisplayAll"><bean:write name="cpwsReport" property="asset"/></td>								
							<td class="mystyle1"><a href="./AssetHabLink.do?mandal=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=MandalDrilldownDisplayAll"><bean:write name="cpwsReport" property="linkAsset"/></td>	
							</TR>
					</logic:iterate>
					<TR>
						
							<td class="mystyle1">**</td>	
							<td class="mystyle1"><bean:write name="totalBean" property="name"/></td>
						    <td class="mystyle1"><bean:write name="totalBean" property="habitation"/></td>
						    
							<td class="mystyle1"><bean:write name="totalBean" property="asset"/></td>								
							<td class="mystyle1"><bean:write name="totalBean" property="linkAsset"/></td>	
							</TR>
				</TABLE>


<%} %>



  <%if(comp.equalsIgnoreCase("AssetHabLinkPanchayatDrillDown")) 
{%> 
  <%//System.out.println("in panchayat drill down"); %>
 <%//int count;
  count=((java.util.ArrayList)request.getAttribute("linkAssets")).size();
//System.out.println("count="+count);
%>

<TABLE width="100%">
 <tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="100%">District:<bean:write name="selectionCriteria" property="district" scope="request" ignore="true"/>
&nbsp;&nbsp;Mandal:<bean:write name="selectionCriteria" property="mandal" scope="request" ignore="true"/>
</td>
</tr>
</TABLE>
					
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >PANCHAYAT NAME</TH>
						<th>NO. OF HABITATIONS</th>
						<TH>NO. OF ASSETS(HEADWORKS)</TH>
						<TH>NO. OF ASSETS(LINKED TO THE HABITATION)</TH>
				
					</THEAD>
					<logic:iterate id="cpwsReport" name="linkAssets"
						scope="request" length="<%=Integer.toString(count-1)%>" >
							<TR>
						
							<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>	
							<td class="mystyle1"><a href="./AssetHabLinkDistDrilldown.do?panchayat=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=VillageDrilldown"><bean:write name="cpwsReport" property="name"/></a></td>
						    <td class="mystyle1"><a href="./AssetHabLink.do?panchayat=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=PanchayatDrilldownDisplayAll"><bean:write name="cpwsReport" property="habitation"/></td>	
							<td class="mystyle1"><a href="./AssetHabLink.do?panchayat=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=PanchayatDrilldownDisplayAll"><bean:write name="cpwsReport" property="asset"/></td>								
							<td class="mystyle1"><a href="./AssetHabLink.do?panchayat=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=PanchayatDrilldownDisplayAll"><bean:write name="cpwsReport" property="linkAsset"/></td>	
							</TR>
					</logic:iterate>
					<TR>
						
							<td class="mystyle1">**</td>	
							<td class="mystyle1"><bean:write name="totalBean" property="name"/></td>
						    <td class="mystyle1"><bean:write name="totalBean" property="habitation"/></td>
						    
							<td class="mystyle1"><bean:write name="totalBean" property="asset"/></td>								
							<td class="mystyle1"><bean:write name="totalBean" property="linkAsset"/></td>	
							</TR>
				</TABLE>
<%} %>



  <%if(comp.equalsIgnoreCase("AssetHabLinkVillageDrillDown")) 
{%> 
  <%//System.out.println("in village drill down"); %>
 <%//int count;
  count=((java.util.ArrayList)request.getAttribute("linkAssets")).size();
//System.out.println("count="+count);
%>

<TABLE width="100%">
 <tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="100%">District:<bean:write name="selectionCriteria" property="district" scope="request" ignore="true"/>
&nbsp;&nbsp;Mandal:<bean:write name="selectionCriteria" property="mandal" scope="request" ignore="true"/>
&nbsp;&nbsp;Panchayat:<bean:write name="selectionCriteria" property="panchayat" scope="request" ignore="true"/>
</td>
</tr>
</TABLE>
  <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >VILLAGE NAME</TH>
						<th>NO. OF HABITATIONS</th>
						<TH>NO. OF ASSETS(HEADWORKS)</TH>
						<TH>NO. OF ASSETS(LINKED TO THE HABITATION)</TH>
				
				
					</THEAD>
					<logic:iterate id="cpwsReport" name="linkAssets"
						scope="request" length="<%=Integer.toString(count-1)%>" >
							<TR>
						
							<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>	
							<td class="mystyle1"><a href="./AssetHabLinkDistDrilldown.do?village=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=HabitationDrilldown"><bean:write name="cpwsReport" property="name"/></a></td>
						    <td class="mystyle1"><a href="./AssetHabLink.do?village=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=VillageDrilldownDisplayAll"><a href="AssetHabLinkDistDrilldown.do?village=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=HabitationDrilldown"><bean:write name="cpwsReport" property="habitation"/></td>	
							<td class="mystyle1"><a href="./AssetHabLink.do?village=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=VillageDrilldownDisplayAll"><bean:write name="cpwsReport" property="asset"/></td>								
							<td class="mystyle1"><a href="./AssetHabLink.do?village=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=VillageDrilldownDisplayAll"><bean:write name="cpwsReport" property="linkAsset"/></td>	
							</TR>
					</logic:iterate>
					<TR>
						
							<td class="mystyle1">**</td>	
							<td class="mystyle1"><bean:write name="totalBean" property="name"/></td>
						    <td class="mystyle1"><bean:write name="totalBean" property="habitation"/></td>
						    
							<td class="mystyle1"><bean:write name="totalBean" property="asset"/></td>								
							<td class="mystyle1"><bean:write name="totalBean" property="linkAsset"/></td>	
							</TR>
				</TABLE>
<%} %>



  <%if(comp.equalsIgnoreCase("AssetHabLinkHabitationDrillDown")) 
{%> 
  <%//System.out.println("AssetHabLinkHabitationDrillDown"); %>
 <%//int count;
  count=((java.util.ArrayList)request.getAttribute("linkAssets")).size();
//System.out.println("count="+count);
%>

<TABLE border=0 width=100%>
 <tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="100%">District:<bean:write name="selectionCriteria" property="district" scope="request" ignore="true"/>
&nbsp;&nbsp;Mandal:<bean:write name="selectionCriteria" property="mandal" scope="request" ignore="true"/>
&nbsp;&nbsp;Panchayat:<bean:write name="selectionCriteria" property="panchayat" scope="request" ignore="true"/>
&nbsp;&nbsp;Village:<bean:write name="selectionCriteria" property="village" scope="request" ignore="true"/>

</td>
</tr>
</TABLE>
<TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >HABITATION NAME</TH>
						
					<TH>NO. OF ASSETS(HEADWORKS)</TH>
					<TH>NO. OF ASSETS(LINKED TO THE HABITATION)</TH>
				
				
					</THEAD>
					<logic:iterate id="cpwsReport" name="linkAssets"
						scope="request" length="<%=Integer.toString(count-1)%>" >
							<TR>
						
							<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>	
							<td class="mystyle1"><a href="./AssetHabLink.do?habitation=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=AssetHabLinkReport2"><bean:write name="cpwsReport" property="name"/></a></td>
						    
							<td class="mystyle1"><a href="./AssetHabLink.do?habitation=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=AssetHabLinkReport2"><bean:write name="cpwsReport" property="asset"/></td>								
							<td class="mystyle1"><a href="./AssetHabLink.do?habitation=<%=((AssetHabLinkDrilldownBean)cpwsReport).getCode()%>&subComp=AssetHabLinkReport2"><bean:write name="cpwsReport" property="linkAsset"/></td>	
							</TR>
					</logic:iterate>
					<TR>
						
							<td class="mystyle1">**</td>	
							<td class="mystyle1"><bean:write name="totalBean" property="name"/></td>
						    
							<td class="mystyle1"><bean:write name="totalBean" property="asset"/></td>								
							<td class="mystyle1"><bean:write name="totalBean" property="linkAsset"/></td>	
							</TR>
				</TABLE>
<%} %>

<%} 
else
{%>
<TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
											
						<TH>NO. OF ASSETS(HEADWORKS)</TH>
						<TH>NO. OF ASSETS(LINKED TO THE HABITATION)</TH>
				
				
					</THEAD>
					<td colspan=10 align="center">NO RECORDS</td>
					</TABLE>
<%} %>


</BODY>
</html:html>
<%@ include file="/commons/rws_footer.jsp"%>