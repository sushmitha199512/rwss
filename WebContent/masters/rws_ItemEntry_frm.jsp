<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="itemForm" />
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="Item.do" >

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
		<FONT class=myfontclr>Item Code<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="itemCode" value="<%=(String)request.getAttribute(\"code\")%>" styleClass="mytext" maxlength="3" readonly="true"/>
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Item Name<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="itemName" value="" styleClass="mytext" maxlength="30" />
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
		<FONT class=myfontclr>Year</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="finyear" value="" styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Units</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="units" value="" styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Rate<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="rate" value="" styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		</table>

	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save"  onclick=" return validateItemForm(itemForm) "/>
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>