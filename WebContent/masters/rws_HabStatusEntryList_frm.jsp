<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
var newWindow;
function openEditWindow(habCode)
{

	 var width = 838;
	 var height = 600;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}
function toggleColor(that)
{
if(that.style.color=="blue")
that.style.color="red";
else if(that.style.color=="red")
that.style.color="blue"

}



</script>
<form>
<html:hidden property="init" value="false"/>
<table width="100%">

<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
<a href="<rws:context page='/home.jsp'/>">Home</a>
</td>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">HabStatus Form</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>
    <td  class="clrborder" align=left  rowspan="2">Sl.No</td>
	<td  class="clrborder" align=center rowspan="2">Mandal</td>
	<td  class="clrborder" align=center rowspan="2">Panchayat</td>
	<td  class="clrborder" align=center rowspan="2">Village</td>
	<td  class="clrborder" align=center rowspan="2">PR Hab</td>
	<td  class="clrborder" align=center rowspan="2">Habitation</td>
	<td  class="clrborder" align=center colspan="7">Census Population</td>
	<td  class="clrborder" align=center colspan="5">Population Covered</td>
	<td  class="clrborder" align=center rowspan="2">Coverage<br>Status</td>
	<td  class="clrborder" align=center colspan="2">GLSR</td>
	<td  class="clrborder" align=center colspan="2">OHSR</td>
	<td  class="clrborder" align=center rowspan="2">Scheme Sources</td>
	<td  class="clrborder" align=center rowspan="2">Remarks</td>
	<td  class="clrborder" align=center rowspan="2">Last<br>Updated</td>
	<td  class="clrborder" align=center rowspan="2"><bean:message key="app.op" /></td>
</tr>
<tr>
  	<td  class="clrborder" align=center >Year</td>
	<td  class="clrborder" align=center >Plain</td>
	<td  class="clrborder" align=center >Sc</td>
	<td  class="clrborder" align=center >St</td>
	<td  class="clrborder" align=center >Total</td>
	<td  class="clrborder" align=center >Floating</td>
	<td  class="clrborder" align=center >Net</td>
	<td  class="clrborder" align=center >Date</td>
	<td  class="clrborder" align=center >Plain</td>
	<td  class="clrborder" align=center >Sc</td>
	<td  class="clrborder" align=center >St</td>
	<td  class="clrborder" align=center >Total</td>
	<td  class="clrborder" align=center >GLSR No</td>
	<td  class="clrborder" align=center >GLSR Quantity</td>
	<td  class="clrborder" align=center >OHSR No</td>
	<td  class="clrborder" align=center >OHSR Quantity</td>
	
</tr>
<% int count=0;%>
<logic:iterate id="habstatuslist" name="habstatus">
<% count=count+1;%>
<!-- <tr align="left" id='tr<%=count%>' onmouseover="this.style.background='FFFFCC'" onmouseout="this.style.background='WHITE'"> -->
<tr align="left" id='tr<%=count%>' onclick="toggleRowColor(this)">

<td  class="bwborder" ><%=count %></td>
<td  class="bwborder"><bean:write name="habstatuslist" property="mandalName" /></td>
<td  class="bwborder"><bean:write name="habstatuslist" property="panchayat" /></td>
<td  class="bwborder"><bean:write name="habstatuslist" property="villName" /></td>
<td  class="bwborder"><bean:write name="habstatuslist" property="habCode" /></td>
<td  class="bwborder" nowrap><bean:write name="habstatuslist" property="habName" /></td>
<td  class="bwborder" align=center><bean:write name="habstatuslist" property="censusYear" /></td>
<td  class="bwborder" align=left><bean:write name="habstatuslist" property="censusPop" /></td>
<td  class="bwborder" align=left><bean:write name="habstatuslist" property="censusSc" /></td>
<td  class="bwborder" align=left><bean:write name="habstatuslist" property="censusSt" /></td>
<td  class="bwborder" align=left><bean:write name="habstatuslist" property="totalPop" /></td>
<td  class="bwborder" align=left><bean:write name="habstatuslist" property="floatPop" /></td>
<td  class="bwborder" align=left><bean:write name="habstatuslist" property="netPop" /></td>
<td  class="bwborder" align=center><bean:write name="habstatuslist" property="habYear" /></td>
<td  class="bwborder" align=left><bean:write name="habstatuslist" property="popCovered" /></td>
<td  class="bwborder" align=left><bean:write name="habstatuslist" property="scCovered" /></td>
<td  class="bwborder" align=left><bean:write name="habstatuslist" property="stCovered" /></td>
<td  class="bwborder" align=left><bean:write name="habstatuslist" property="totalCovered" /></td>
<td  class="bwborder" nowrap align="left"><bean:write name="habstatuslist" property="coveredStatus" /></td>
<td  class="bwborder" nowrap align="left"><bean:write name="habstatuslist" property="glsrno" /></td>
<td  class="bwborder" nowrap align="left"><bean:write name="habstatuslist" property="glsrqty" /></td>
<td  class="bwborder" nowrap align="left"><bean:write name="habstatuslist" property="ohsrno" /></td>
<td  class="bwborder" nowrap align="left"><bean:write name="habstatuslist" property="ohsrqty" /></td>
<td  class="bwborder" nowrap align="left"><bean:write name="habstatuslist" property="schemesource" /></td>
<td  class="bwborder" nowrap align="center"><bean:write name="habstatuslist" property="remarks" /></td>
<td  class="bwborder" nowrap align="center"><bean:write name="habstatuslist" property="updateDate" /></td>
<td  class="bwborder" nowrap align="center">
<!--  <a href="/pred/masters/habStatusEditFrm.do?habCode=<bean:write name='habstatuslist' property='habCode' />"><font color="#6600CC">Edit&nbsp;</font></a>&nbsp;-->
 <a href="#1" onclick="toggleColor(this);openEditWindow('<bean:write name='habstatuslist' property='habCode' />') " style="color:blue">Edit&nbsp;</a>&nbsp;
<!-- <a href="./HabStatus.do?mode=delete&habCode=<bean:write name='habstatuslist' property='habCode' />" onclick="return deleteRec()"><font color="#990066">Delete</font></a> -->
<!-- comment above line and added this line by sadiq for disable the delete option<font color="#990066">Delete</font></a>-->
</td>
</tr>
</logic:iterate>

</table>
</form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

