<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
function toggleRowColor(that)
{
	if(that)
	{
		if(that.style.background=="#ffffcc")
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background="#ffffcc";
		else that.style.background="#ffffcc";

	}

}
var newWindow;
function openEditWindow(habCode)
{

	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var url = "/pred/masters/ContaminationDetails.do?mode=edit&habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function openExcelWindow()
{

	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	
	 var url = "/pred/masters/ContaminationDetails.do?mode=excelView&dcode="+<%= session.getAttribute("selectedDistrictInContaminationDetails")%>;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=yes,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function funcDelete(habCode)
{
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="/pred/masters/ContaminationDetails.do?mode=delete&habCode="+habCode;
		document.forms[0].submit();
	}
}
/*
function fnDelete(dcode,mcode,pcode)
{

	 var width = 838;
	 var height = 600;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var url = "/pred/masters/Panchayat.do?mode=delete&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
*/
function toggleColor(that)
{
	if(that.style.color=="blue")
	that.style.color="red";
	else if(that.style.color=="red")
	that.style.color="blue"

}

/*
function highlightSelectedRow(rowIndex)
{
alert(document.getElementById(rowIndex).style.bgcolor);
document.getElementById(rowIndex).style.border='1px solid yellow';
}
*/

function highlightSelectedRow(that)
{

	that.style.border="3px red solid";
}

</script>
<html:form action="/ContaminationDetails.do">
<html:hidden property="init" value="false"/>
<table width="100%">

<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp<a href="#1" onclick="openExcelWindow()">Excel</a>
</td>
</tr>
</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="55%" border=1 style="border-collapse:collapse" >
<tr>
<td colspan="20" class="clrborder">
<%if(request.getAttribute("selectedDistrict")!=null)%>
District Name: <%= request.getAttribute("selectedDistrict") %>&nbsp;&nbsp;&nbsp;

</td>



</tr>
<tr><td class=myfontclr bgcolor="#8A9FCD" colspan=14><B><font color="#FFFFFF">Contamintaion Details List</font></B></td>
<tr>
    <td  class="clrborder" align=left>Sl.No
	
	<!-- <td  class="clrborder" align=center>District Code</td> -->
	<!-- <td  class="clrborder" align=center>District Name</td> -->
	<td  class="clrborder" align=center>Mandal Name</td>
	<td  class="clrborder" align=center>Panchyat Name</td>
	<td  class="clrborder" align=center>Village Name</td>
	<td  class="clrborder" align=center>Hab Code</td>
	<td  class="clrborder" align=center>Hab Name</td>
	<td  class="clrborder" align=center>Floride Contamination(PPM)</td>
	<td  class="clrborder" align=center>Brakish Contamination(PPM)</td>
	<td  class="clrborder" align=center>Iron Contamination(PPM)</td>
	<td  class="clrborder" align=center>Aresenic Contamination(PPM)</td>
	<td  class="clrborder" align=center>Nitrate Contamination(PPM)</td>
	<td  class="clrborder" align=center>Status Date</td>
	<td  class="clrborder" align=center ><bean:message key="app.op" /></td>
</tr>

<% int count=0;%>
<logic:iterate id="contaminationDetailsList" name="contaminationDetails">

<% count=count+1;%>
<!-- <div id='tr<%=count%>' onclick="highlightSelectedRow('tr<%=count%>')" > -->

<!-- <tr align="left" id='tr<%=count%>' onmouseover="this.style.background='CCCCFF'" onmouseout="this.style.background='WHITE'" >-->
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<!-- <tr align="left" id='tr<%=count%>' onclick="toggleRowColor(this)"> -->
<td  class="bwborder" ><%=count %></td>
<td class="bwborder" align=left><bean:write name="contaminationDetailsList" property="mname" /></td>
<td class="bwborder" align=left><bean:write name="contaminationDetailsList" property="pname" /></td>
<td class="bwborder" align=left><bean:write name="contaminationDetailsList" property="vname" /></td>
<td class="bwborder" align=left><bean:write name="contaminationDetailsList" property="habCode" /></td>
<td  class="bwborder" align=left><bean:write name="contaminationDetailsList" property="habName" /></td>
<td  class="bwborder" align=left><bean:write name="contaminationDetailsList" property="flourideContamination" /></td>
<td  class="bwborder" align=left><bean:write name="contaminationDetailsList" property="brakishContamination" /></td>
<td  class="bwborder" align=left><bean:write name="contaminationDetailsList" property="ironContamination" /></td>
<td  class="bwborder" align=left><bean:write name="contaminationDetailsList" property="aresenicContamination" /></td>
<td  class="bwborder" align=left><bean:write name="contaminationDetailsList" property="nitrateContamination" /></td>
<td  class="bwborder" align=left><bean:write name="contaminationDetailsList" property="statusDate" /></td>
<td  class="bwborder" nowrap align="center"><a href="#1" onclick="openEditWindow('<bean:write name="contaminationDetailsList" property="habCode" />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>|
<a href="#1" onclick="funcDelete('<bean:write name="contaminationDetailsList" property="habCode" />');toggleColor(this) " style="color:blue">Delete&nbsp;</a>&nbsp;
</td>
</tr>
<!-- </div> -->
</logic:iterate>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

