<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
var newWindow;
function fnGetProgDet(locId,broId)
{
	
	locId=locId.value;
	broId=broId.value;
	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var url = "switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=getLocProgDetails&locId="+locId+"&broId="+broId;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=yes,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
}
function openEditWindow(locId,broId)
{
	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var ad='<%= (String)session.getAttribute("userId")%>';
	
	
	 
	 var url = "switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=edit&broId="+broId+"&locId="+locId;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function openEditWindow1(locId,circleLocId,broId)
{
//alert(locId);
//alert(circleLocId);
//alert(broId);
	 
	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var ad='<%= (String)session.getAttribute("userId")%>';
	
	
	 
	 var url = "switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=edit&broId="+broId+"&locId="+locId+"&circleLocId="+circleLocId;
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
	 
	 var dcode=document.forms[0].dcode[0].value;
	 var mcode=document.forms[0].mcode[0].value;
	 var pcode=document.forms[0].pcode[0].value;
	 
	 var url = "/pred/masters/Village.do?mode=excelView&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=yes,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function fnDelete(locId)
{
	
	
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=delete&locId="+locId;
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



</script>



<!-- code to be deleted -->

<!-- end of code to be deleted -->
<html:form action="/broDetails.do">
<html:hidden property="init" value="false"/>
<table width="100%">

<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
<a href="<rws:context page='/home.jsp'/>">Home</a>
 
</td>
</tr>
</table>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="55%" border=1 style="border-collapse:collapse" >

<tr bgcolor="#8A9FCD" ><td class=myfontclr colspan="20"><B><font color="#FFFFFF">LOC Details List</font></B></td></tr>
<tr>
    <td  class="clrborder" align=left>Sl.No
	
	<td  class="clrborder" align=center nowrap>LOC Id</td>
	<logic:equal name="RWS_USER" property="officeName" value="Circle Office">
	<td  class="clrborder" align=center nowrap>Circle Loc Id</td>
	</logic:equal>			    
	<td  class="clrborder" align=center nowrap>LOC Reference</td>
	<td  class="clrborder" align=center nowrap>LOC Date</td>
	<td  class="clrborder" align=center nowrap>LOC Amount</td>
	<td  class="clrborder" align=center nowrap>DWA Authorisation</td>
	<td  class="clrborder" align=center nowrap>DWA Authorisation Date</td>
	<td  class="clrborder" align=center nowrap>BRO Id</td>
	<td  class="clrborder" align=center nowrap>LOC Programme Details</td>
	<td  class="clrborder" align=center nowrap><bean:message key="app.op" /></td>
</tr>

<% int count=0;%>
<logic:iterate id="locDetails" name="locDetailsListFromView">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>

<td nowrap>&nbsp;<bean:write name="locDetails" property="locId" />
<html:hidden name="locDetails" property="locId" indexed="true" />
<html:hidden name="locDetails" property="broId" indexed="true" />
</td>
<logic:equal name="RWS_USER" property="officeName" value="Circle Office">
	<td  class="bwborder" align=left nowrap><bean:write name="locDetails" property="circleLocId" /></td>
</logic:equal>			    
<td  class="bwborder" align=left nowrap><bean:write name="locDetails" property="locReference" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="locDetails" property="locRelDate" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="locDetails" property="locAmount" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="locDetails" property="dwaAuthorisationReference" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="locDetails" property="dwaAuthorisationDate" /></td>
<td  class="bwborder" align=left nowrap ><bean:write name="locDetails" property="broId" /></td>


<td><html:button property="mode" value="..." style="width:90px" styleClass="btext" title="Click Here" onclick='<%= "javascript:fnGetProgDet(document.getElementById(\'locDetails["+(count-1)+"].locId\'),document.getElementById(\'locDetails["+(count-1)+"].broId\'))" %>'/></td>

<td  class="bwborder" nowrap align="center">
 <logic:notEqual name="RWS_USER" property="officeName" value="Circle Office">
 <a href="#3" onclick="openEditWindow('<bean:write name='locDetails' property='locId' />','<bean:write name='locDetails' property='broId' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>|&nbsp;
 </logic:notEqual>
 <logic:equal name="RWS_USER" property="officeName" value="Circle Office">
 <a href="#2" onclick="openEditWindow1('<bean:write name='locDetails' property='locId' />','<bean:write name='locDetails' property='circleLocId' />','<bean:write name='locDetails' property='locId' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>|&nbsp;
 </logic:equal>
 <a href="#1" onclick="fnDelete('<bean:write name='locDetails' property='locId' />');toggleColor(this)" style="color:blue">Delete&nbsp;</a>&nbsp;
 </td>
</tr>
</logic:iterate>
<%if(count==0){ %>
<tr><td colspan=20 class="bwborder" align=center>No Records</td></tr>
<%} %>

</table>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

