<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html>

<html:form action="Hoffice.do">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Head Of Office Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>Office Name:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	
	<html:select property="office" >
		<!--<html:option value="">SELECT...</html:option>-->
		<html:options  collection="offices" property="office" labelProperty="office" />
	</html:select>
	</td></tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>Head Of Office:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	
	<html:select property="designation">
		<!--<html:option value="">SELECT...</html:option>-->
		<html:options collection="designations" property="desgnCode" labelProperty="desgnName"/>
	</html:select>
	</td>
	</tr>
	
</table>
<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Update the Fields" styleClass="btext" value="update" />
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

