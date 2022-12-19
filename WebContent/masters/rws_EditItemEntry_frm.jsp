<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>




<html:form action="Item.do?mode=edit" onsubmit=" return winView() ">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Item Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"   width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.itemCode" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="itemCode"  styleClass="mytext" maxlength="3" readonly="true"/>
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Item Name</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="itemName"  styleClass="mytext" maxlength="30" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>District<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="distCode" style="width:123px" styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">Select...</html:option>
		<html:options collection="dists" name="rwsMaster" property="dcode" labelProperty="dname" />
		</html:select>
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.itemYear" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="finyear"  styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.units" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="units"  styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.rate" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="rate"  styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		</table>

	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Save"  />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>


