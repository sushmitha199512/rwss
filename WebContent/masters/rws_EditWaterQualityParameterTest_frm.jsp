<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="wqPTestForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="WaterPTest.do?mode=edit"  onsubmit="return validateWqPTestForm(this)">  

	<%
			String csrfToken = "";
					nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
					csrfToken = valUtil.getCSRFCode();
					session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />


<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Quality Parameter Test Form" />
	<jsp:param name="TWidth" value="385" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"   width="420" >
<tr>
<td>
	<table  border=0  width="420"  align=center  style="margin-bottom:5;margin-top:5">
<tr>
<td  class=mycborder >
		<FONT class=myfontclr>Test Code<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="testCode" style="width:200px" readonly="true"/>
		</td>
		</tr>
		<tr>
		<td  class=mycborder>
		<FONT class=myfontclr>Testing Parameter Code<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="testPCode" style="width:200px" readonly="true"/>
		</td>
		</tr>
		<tr>
		<td  class=mycborder>
		<FONT class=myfontclr>Testing Parameter Name<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="testPName" style="width:200px" />
		
		</td>
		</tr>
		<tr >
		<td  class=mycborder>
		<FONT class=myfontclr>Desired permissible value<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="minPerVal"  styleClass="mytext" style="width:200px" onkeypress="return numeralsOnly(event)"/>
		</td>
		</tr>
		<tr >
		<td  class=mycborder>
		<FONT class=myfontclr>Maximum permissible value<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="maxPerVal"  styleClass="mytext"  style="width:200px" onkeypress="return numeralsOnly(event)" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Undesirable Effect Outside the Desirable Limit</FONT>
		</td>
		<td  class=mycborder >
		<html:textarea property="undesirableEffect"  style="width:150px;height:80px"  />
		
		</td>
		</tr>
	</table>
	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Save"  onclick="return winView()" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="385"/>
</jsp:include>

</html:form>
</td>
</tr>



<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


