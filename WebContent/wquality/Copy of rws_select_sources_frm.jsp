<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@	page import="java.sql.*, java.util.*, java.util.Date, java.text.* " %>
<%
	
	String source = request.getParameter("source");
	String habCode=request.getParameter("habCode");
	
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
	//alert("in :"+index);
if(document.forms[0].ftklab.value=="ftk"){
var sourceCode=document.getElementById("SOURCESLIST["+index+"].sourceCode").value;
//alert("scode:"+sourceCode);
var sourceTypeCode=document.getElementById("SOURCESLIST["+index+"].sourceTypeCode").value;
//alert("stypecode:"+sourceTypeCode);
opener.document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=selectSource&ftklab=ftk&sourceTypeCode="+sourceTypeCode+"&sourceCode="+sourceCode;
opener.document.forms[0].submit();
self.close();}
else if(document.forms[0].ftklab.value=="lab"){
var sourceCode=document.getElementById("SOURCESLIST["+index+"].sourceCode").value;
//alert("scode"+sourceCode);
var sourceTypeCode=document.getElementById("SOURCESLIST["+index+"].sourceTypeCode").value;
//alert("stypecode"+sourceTypeCode);

opener.document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=selectSource&ftklab=lab&sourceTypeCode="+sourceTypeCode+"&sourceCode="+sourceCode;
//alert(" after open");
opener.document.forms[0].submit();
self.close();}


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
		<td class="textborder" align="center" colspan="8">Select Source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<select name="source" onchange="this.form.submit()">
			<option value="">Select..</option>
			<%
				if(source!=null && source.equals("SS")){%>
				<option value="SS" selected>Sub Surface</option>
				<option value="SU">Surface</option>
				<option value="HP">Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO">Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}
			else if(source!=null && source.equals("SU")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" selected>Surface</option>
				<option value="HP">Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO">Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}
			else if(source!=null && source.equals("HP")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="HP" selected>Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO">Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}else if(source!=null && source.equals("OW")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="HP" >Hand Pump</option>
				<option value="OW" selected>Open Well</option>
				<option value="PO">Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}else if(source!=null && source.equals("PO")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="HP" >Hand Pump</option>
				<option value="OW" >Open Well</option>
				<option value="PO" selected>Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
				<%}else if(source!=null && source.equals("SHP")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="HP" >Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO" >Ponds</option>
				<option value="SHP" selected>Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
				<%} else {%>
				<option value="SS" >Sub Surface</option>
				<option value="SU">Surface</option>
				<option value="HP">Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO">Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}
			%>
		</select>
		</td>
	</tr>
</table>
<BR>
<%
if(source!=null && !source.equals("")){
	nic.watersoft.wquality.RwsWQualityData rwsdata=new  nic.watersoft.wquality.RwsWQualityData(); 
	java.util.ArrayList sourcelist =new  java.util.ArrayList();
	sourcelist=rwsdata.getSelectedSources(source,habCode);
	request.setAttribute("sourcelist",sourcelist);
	System.out.println("size:"+sourcelist.size());
int count=0;
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=25>Sources in Above Selected Habitation</td>	
	</tr>
	<tr align = center>
		<td class=btext >Sl.No</td>
		<td class=btext >select</td>
		<td class=btext >Source Code </td>
		<td class=btext >Location</td>
		<td class=btext >Status</td>
		
	</tr>
<input type=hidden name=ftklab value="<%=request.getParameter("ftklab")%>">
<nested:iterate id="SOURCESLIST" name="sourcelist" indexId="ndx">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >

<td  class="bwborder" > <%=count %></td>
<td  class="bwborder" >
<input type="radio" name="radio1" onclick="<%= "javascript: sourceSelected("+ ndx +")"%>" ></td>
<td>
<nested:hidden name="SOURCESLIST" property="sourceCode" indexed="true"/> 
<nested:write name="SOURCESLIST" property="sourceCode" /></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="location" /></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="assetStatus" /></td>
<nested:hidden name="SOURCESLIST" property="sourceTypeCode" indexed="true" />
<nested:hidden name="SOURCESLIST" property="sourceTypeName" indexed="true" />
</tr>
</nested:iterate>
	<% if(count==0) 
		{%>
		<tr><td  align="center"  colspan=5> No Records </td></tr>
		<%}%>
</table>
<%}
	else
	{
		%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=25>Sources</td>	
	</tr>
	<tr align = center>
		<td class=btext >Sl.No</td>
		<td class=btext >select</td>
		<td class=btext >Source Code </td>
		<td class=btext >Location</td>
		<td class=btext >Status</td>
	</tr>
	
	</table>
<%}%>

</form>
</body>
</html>

