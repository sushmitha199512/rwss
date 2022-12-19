<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="wqTestForm" />
<%@ include file="/commons/rws_header2.jsp" %>



<html:form action="WaterTest.do?mode=edit" onsubmit="return validateWqTestForm(this)">


<%
			String csrfToken = "";
					nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
					csrfToken = valUtil.getCSRFCode();
					session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />



<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Quality Test Entry Form" />
	<jsp:param name="TWidth" value="305" />
</jsp:include>

<table  bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"   width="340" >
<tr>
<td>
	<table  border=0  width="341"  align=center  style="margin-bottom:5;margin-top:5">
<tr>
<td  class=mycborder >
		<FONT class=myfontclr>Test Code<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="testCode"  style="width:200px" readonly="true"/>
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Test Name<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="testName"  style="width:200px" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Test Periodicity<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="testPeriod" styleClass="mycombo">
		<html:option value="">Please Select..</html:option>
		<html:option value="M">Monthly</html:option>
		<html:option value="Q">Quarterly</html:option>
		<html:option value="H">Halfearly</html:option>
		<html:option value="Y">Yearly</html:option>
		</html:select>
		</td>
		</tr>
		
	</table>
	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Save" onclick="return winView()" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="305"/>
</jsp:include>

</html:form>
</td>
</tr>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


