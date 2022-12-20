<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
var newWindow;
function openEditWindow(dcode,acode,mcode,pcode,vcode,habCode)
{

	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var url = "/pred/masters/ChangeHabitationCode.do?mode=habitationEdit&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode+"&acode="+acode+"&vcode="+vcode+"&habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function fnDelete(dcode,acode,mcode,pcode,vcode,habCode)
{
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="/pred/masters/ChangeHabitationCode.do?mode=delete&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode+"&acode="+acode+"&vcode="+vcode+"&habCode="+habCode;
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
<html:form action="/Habitation.do">
<html:hidden property="init" value="false"/>
<table width="100%">

<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
<a href="<rws:context page='/home.jsp'/>">Home</a>
</td>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td ><B><font color="#FFFFFF">Habitation List</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>
<td colspan="20" class="clrborder">
<%if(request.getAttribute("selectedDistrict")!=null)%>
District Name: <%= request.getAttribute("selectedDistrict") %>&nbsp;&nbsp;&nbsp;
<%if(request.getAttribute("selectedMandal")!=null)%>
Mandal Name: <%= request.getAttribute("selectedMandal") %>
</td>
</tr>
<tr>
    <td  class="clrborder" align=left>Sl.No
	
	<td  class="clrborder" align=center>District Code</td>
	<td  class="clrborder" align=center>District Name</td>
	<td  class="clrborder" align=center>Constituency Code</td>
	<td  class="clrborder" align=center>Constituency Name</td>
	<td  class="clrborder" align=center>Mandal Code</td>
	<td  class="clrborder" align=center>Mandal Name</td>
	<td  class="clrborder" align=center>Panchayat Code</td>
	<td  class="clrborder" align=center>Panchayat Name</td>
	<td  class="clrborder" align=center>Village Code</td>
	<td  class="clrborder" align=center>Village Name</td>
	<td  class="clrborder" align=center>Habitation Code</td>
	<td  class="clrborder" align=center>Habitation Name</td>
	
	<td  class="clrborder" align=center ><bean:message key="app.op" /></td>
</tr>

<% int count=0;%>
<logic:iterate id="habitationList" name="habitationDetails">

<% count=count+1;%>
<tr align="left" >
<td  class="bwborder" ><%=count %></td>
<td>&nbsp;<bean:write name="habitationList" property="dcode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="dname" /></td>
<td>&nbsp;<bean:write name="habitationList" property="constituencyCode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="constituencyName" /></td>
<td>&nbsp;<bean:write name="habitationList" property="mcode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="mname" /></td>
<td>&nbsp;<bean:write name="habitationList" property="pcode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="pname" /></td>
<td>&nbsp;<bean:write name="habitationList" property="vcode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="vname" /></td>
<td>&nbsp;<bean:write name="habitationList" property="habCode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="habName" /></td>

<td  class="bwborder" nowrap align="center">

 <a href="#1" onclick="openEditWindow('<bean:write name='habitationList' property='dcode' />','<bean:write name='habitationList' property='constituencyCode' />','<bean:write name='habitationList' property='mcode' />','<bean:write name='habitationList' property='pcode' />','<bean:write name='habitationList' property='vcode' />','<bean:write name='habitationList' property='habCode' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>|&nbsp;
  <a href="#1" onclick="fnDelete('<bean:write name='habitationList' property='dcode' />','<bean:write name='habitationList' property='constituencyCode' />','<bean:write name='habitationList' property='mcode' />','<bean:write name='habitationList' property='pcode' />','<bean:write name='habitationList' property='vcode' />','<bean:write name='habitationList' property='habCode' />');toggleColor(this) " style="color:blue">Delete&nbsp;</a>&nbsp;

</td>
</tr>
</logic:iterate>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

