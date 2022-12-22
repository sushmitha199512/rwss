<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
function fnDelete(dcode)
{
	
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
			alert("Record cannot be deleted as it has been freezed");
			return;
	}
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		return true;
	}
	else{
		return false;
		}
}
</script>
<html:form action="/TankerRegistration.do">
<html:hidden property="init" value="false"/>
<table width="10%">

<tr><td align=right style="wi" ><a href="<rws:context page='/home.jsp'/>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Home|</a>
 </td><td align=right><a href="javascript:history.go(-1)">Back</a>
 </td>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Tanker Details View</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >

<tr>
    <td  class="btext" align=left>Sl.No
	<td  class="btext" align=center>District</td>
	<td  class="btext" align=center>Mandal</td>
	<td  class="btext" align=center>Panchayat</td>
	<td  class="btext" align=center>HabCode</br>/HabName</td>
	<td  class="btext" align=center>Tanker Reg No.</td>
	<td  class="btext" align=center>Tanker RC No.</td>
	<td  class="btext" align=center>Tanker RC Name	</td>
	<td  class="btext" align=center>Tanker Capacity(in KLtrs)</td>
	<td  class="btext" align=center>Tanker Owner Name</td>
	
	<td  class="btext" align=center>Tanker Owner Mobile NO</td>
	<td  class="btext" align=center>Remarks</td>
	<td  class="btext" align=center>Action</td>
	
</tr>

<% int count=0;%>
<logic:iterate id="tankerDetails" name="tankerDetails">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td   class="bwborder" align=left><%=count %></td>

<td   class="bwborder" align=left>
<bean:write name="tankerDetails" property="districtName" /></td>

<td   class="bwborder" align=left>
<bean:write name="tankerDetails" property="mandal" /></td>

<td   class="bwborder" align=left>
<bean:write name="tankerDetails" property="panchayat" /></td>

<td class="rptValue"  align=left>
<bean:write name="tankerDetails" property="habCode" />
<br/>/<bean:write name="tankerDetails" property="habName" /></td>

<td   class="bwborder" align=left>
<bean:write name="tankerDetails" property="tankerRegNo" /></td>

<td   class="bwborder" align=left>
<bean:write name="tankerDetails" property="tankerRCNo" /></td>

<td   class="bwborder" align=left>
<bean:write name="tankerDetails" property="tankerRCName" /></td>

<td   class="bwborder" align=left>
<bean:write name="tankerDetails" property="tankerCapacity" /></td>

<td   class="bwborder" align=left>
<bean:write name="tankerDetails" property="tankerOwnerName" /></td>

<td   class="bwborder" align=left>
<bean:write name="tankerDetails" property="tankerOwnerMobileNumber" /></td>

<td   class="bwborder" align=left>
<bean:write name="tankerDetails" property="remarks" /></td>
<td>
<a href="switch.do?prefix=/smsmobile&page=/TankerRegistration.do?mode=edit&habCode=<bean:write name="tankerDetails" property="habCode" />&tankerRegNo=<bean:write name="tankerDetails" property="tankerRegNo" />"  style="color:blue">Edit</a>&nbsp;<a href="switch.do?prefix=/smsmobile&page=/TankerRegistration.do?mode=delete&habCode=<bean:write name="tankerDetails" property="habCode" />&tankerRegNo=<bean:write name="tankerDetails" property="tankerRegNo" />"  style="color:blue" onclick="return fnDelete()">|Delete&nbsp;</a>
</td>
</tr>
</logic:iterate>

<%
  if(count==0){
%>

<tr align="left"  onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  colspan="11" align="center" class="btext" > No Records</td>
</tr>
<%  } %>



</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

