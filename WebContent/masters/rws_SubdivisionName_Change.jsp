<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivisionCon.do&mode=msName";
	document.forms[0].submit();
}
<!-- function fnSave()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivisionCon.do&mode=Save1";
	document.forms[0].submit();
} -->
//-->
</SCRIPT>

 <html:form action="/MandalSubdivisionCon.do?mode=Save1" > 

	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
	
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value=" SubDivision Name Change Form" />
	<jsp:param name="TWidth" value="350" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
		style="border-collapse:collapse;"  width="390" >
<tr>
<td>
	<table  border=0  width="350"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
			<td  class="textborder" >
				District<font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:select property="dcode" style="width:170px" 
							 styleClass="mycombo" onchange="javascript:getData()" >
				<html:option value="">SELECT...</html:option>
				<html:options collection="dists" name="labelValueBean" 
							  property="value" labelProperty="label" />
				</html:select>
			</td>
		</tr>
		
		<tr>
			<td  class="textborder" >
				<bean:message key="app.division" /><font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:select property="doc" style="width:170px" 
							 styleClass="mycombo" onchange="javascript:getData()" >
				<html:option value="">SELECT...</html:option>
				<logic:present name="divisions">
				<html:options collection="divisions" name="labelValueBean" 
							  property="value" labelProperty="label" />
				  </logic:present>
				</html:select>
			</td>
		</tr>
		<tr>
			<td  class="textborder" >
				<bean:message key="app.subdivision" /><font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:select property="sdoc" style="width:170px" 
							 styleClass="mycombo" >
				<html:option value="">SELECT...</html:option>
				<logic:present name="subdivisions">
				<html:options collection="subdivisions" name="labelValueBean" 
							  property="value" labelProperty="label" />
				</logic:present>
				</html:select>
			</td>
		</tr>
				<tr>
			<td class="textborder" align="left"  colspan="2"><font color="blue">SubDivision Name Changed To</font></td></tr>
		<tr>
			<td class="textborder" >New SubDivision Name</td>
			<td class="textborder" ><FONT class=myfontclr>
				<html:text property="sdname"  style="width:170px" onkeypress="upperOnly()"/></FONT>
			</td>
			
		</tr>
</table>
	<tr>
	<td colspan="2" align="center">
		<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save"  />
		<html:reset title="Clear all the Fields" styleClass="btext" value="Reset"  />
 
 	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="350"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>