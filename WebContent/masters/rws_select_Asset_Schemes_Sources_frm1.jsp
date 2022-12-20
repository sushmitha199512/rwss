<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@page import="java.sql.*, java.util.*, java.util.Date, java.text.* " %>
<%@page import="nic.watersoft.wquality.*"%>
<%@page import="nic.watersoft.masters.*"%>
<%@page import="javax.sql.DataSource" %>

<%
	
	String source = request.getParameter("source");
System.out.println("Source is"+source);
	String habCode=request.getParameter("habCode");
	//String print=request.getParameter("printString");
	//System.out.println("print:"+print);
	
%>
<html>
<title> WaterSoft </title>
<head>
<script>
window.history.forward(1);
function fnsubmit()
{
	
}

function sourceSelected(index)
{

	var sourceCode=document.forms[0].elements["SOURCESLIST["+index+"].assetCode"].value;
	//alert("scode:"+sourceCode);
	var sourceTypeCode=document.forms[0].elements["SOURCESLIST["+index+"].assettype"].value;//alert("stypecode"+sourceTypeCode);
	var assetName=document.forms[0].elements["SOURCESLIST["+index+"].assetName"].value;
	window.opener.document.forms[0].action="switch.do?prefix=/masters&page=/conversionOfSchemes.do&mode=data&assetTypeCode="+sourceTypeCode+"&assetCode="+sourceCode+"&assetName="+assetName;
	//alert(" after open");
	window.opener.document.forms[0].submit();
	window.close();


}

</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<p align="center">
<font face=verdana size=2><b><%=request.getParameter("printString")%></b></font>
</p>
<table border = 0 cellspacing = 0 cellpadding = 0 width=50% bordercolor=#000000 style="border-collapse:collapse">
	<tr>
		<td class="textborder" align="center" colspan="8">&nbsp;</td>
	</tr>
	<tr>
		<td class="textborder" align="center" colspan="8">Select Assets&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<select name="source" onchange="this.form.submit()">			
					<option value="" >Select..</option>
					<option value="01" >PWS</option>
					<option value="02" >MPWS</option>
					<option value="03" >CPWS</option>
					<option value="04" >Hand Pump</option>				
				<!-- <option value="09" >Direct Pumping</option> -->
			</select>
		</td>
	</tr>
</table>
<BR>
<%
if(source!=null && !source.equals("")){
	RwsWQualityData rwsdata=new RwsWQualityData(); 
	DataSource dataSource;
	rws_ConversionOfScheme_EntryAct_DAO conversionSchemeDAO=new rws_ConversionOfScheme_EntryAct_DAO();
	java.util.ArrayList sourcelist =new  java.util.ArrayList();
	sourcelist=conversionSchemeDAO.getSelectedAssets(source,habCode);
	request.setAttribute("sourcelist",sourcelist);
   int count=0;
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=25>Assets in Above Selected Habitation</td>	
	</tr>
	<tr align = center>
		<td class=btext >Sl.No</td>
		<td class=btext >select</td>
		<td class=btext >Asset Code</td>
		<td class=btext >Asset Name</td> 
       	<td class=btext >Asset Type</td>
 		<td class=btext >Habitation </td>
		<td class=btext >Location</td>
		<td class=btext >Status</td>
	</tr>
<nested:iterate id="SOURCESLIST" name="sourcelist" indexId="ndx">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >

<td  class="bwborder" > <%=count %></td>
<td  class="bwborder" >
<input type="radio" name="radio1" onclick="<%= "javascript : sourceSelected(" +ndx +")" %>" ></td>
<td  class="bwborder" align=left nowrap>
<nested:hidden name="SOURCESLIST" property="assetCode" indexed="true"/> 
<nested:write name="SOURCESLIST" property="assetCode" /></td>

 <td class="bwborder" align=left nowrap>
<nested:hidden name="SOURCESLIST" property="assetName" indexed="true"/> 
<nested:write name="SOURCESLIST" property="assetName" /></td> 
<td  class="bwborder" align=left nowrap>
<nested:hidden name="SOURCESLIST" property="assettype" indexed="true"/> 
<nested:write name="SOURCESLIST" property="assettype" /></td>


<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="habitation" /></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="location" /></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="assetstatus" /></td>

</tr>
</nested:iterate>
	<% if(count==0) 
		{%>
		<tr><td  align="center"  colspan=11> No Records </td></tr>
		<%}
		%>
</table>
<%}
	else
	{
		%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=25>Assets</td>	
	</tr>
	<tr align = center>
		<td class=btext >Sl.No</td>
		<td class=btext >Asset Code</td>
		<td class=btext >Asset Name</td> 
        <td class=btext >Asset Type</td>
   		<td class=btext >Habitation </td>
		<td class=btext >Location</td>
		<td class=btext >Status</td>
	</tr>	
	</table>
<%}%>

	
</form>
</body>
</html>

