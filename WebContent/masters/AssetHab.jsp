<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="/pred/AssetData.do";
	document.forms[0].submit();
}

//-->
</SCRIPT>


<tr height="96%">
<td align="center" valign="middle">

<html:form action="Asset.do?mode=habs"  >


<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="590" align=center>
<tr>
<td>
<table  border=0  width="580"  align=center  >
<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.district" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="district" style="width:123px" styleClass="mycombo" onchange="javascript:getData()" >
	<html:option value=""><font class="myfontclr1">Select...</html:option>
	<html:options collection="dists" name="rwsMaster" property="dcode" labelProperty="dname" />
	</html:select>
		
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.mandal" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="mandal" styleClass="mycombo" style="width:123px" onchange="javascript:getData()">
	<html:option value="">Select...</html:option>
	<html:options collection="mandals" name="rwsMaster" property="mandalCode" labelProperty="distNoName" />
	</html:select>
	</td>
	</table>
	<table>
		<tr>
		<td class=mycborder>Select</td>
		<td  class=mycborder >
		<FONT class=myfontclr>Habitation Code<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr>Habitation Name<font color="#FF6666">*</font></FONT>
		</td>
		</tr>
		<% int count=0;%>
		<logic:iterate id="assethablist" name="assethabs">
		<tr>
		<%count++;%>
		<td><html:checkbox  property="check<%= count%>"></td>
		<td  class=mycborder1 align=center id="habcode<%=count%>">
		<FONT class=myfontclr1><bean:write name="assethablist" property="habCode" /></FONT>
		</td>
		<td  class=mycborder1 align=center id="habname<%=count%>">
		<FONT class=myfontclr1><bean:write name="assethablist" property="habCode" /></FONT>
		</td>
		</tr>
		</logic:iterate>
		</table>
	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Submit" onclick=" return winView() "/>
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 
	</td>
</tr>
</table>


</html:form>
</td>
</tr>
<%@ include file="/commons/rws_footer.jsp"%>


