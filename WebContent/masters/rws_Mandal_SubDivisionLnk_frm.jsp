<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="mandalSubdivisionForm" />
<SCRIPT LANGUAGE="JavaScript">

function resetfn()
{
if(mandalSubdivisionForm.district.value!="")
{
document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=resetForm";
	document.forms[0].submit();
	}
}

function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=data";
	document.forms[0].submit();
}
function viewfun()
{
  document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=View";
  document.forms[0].submit();
}

</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/MandalSubdivision.do?mode=Save" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Mandal SubDivision Link Entry Form" />
	<jsp:param name="TWidth" value="350" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
		style="border-collapse:collapse;"  width="390" >
<tr>
<td>
	<table  border=0  width="350"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
			<td  class="textborder" >
				<bean:message key="app.circle" /><font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:select property="coc" style="width:170px" 
							 styleClass="mycombo" onchange="javascript:getData()" >
				<html:option value="">SELECT...</html:option>
				<html:options collection="circles" name="labelValueBean" 
							  property="value" labelProperty="label" />
				</html:select>
			</td>
		</tr>
		<tr>
			<td class="textborder" >
				<bean:message key="app.district" /><font color="#FF6666">*</font>
			</td>
			<td class="textborder" ><FONT class=myfontclr>
				<html:text property="dname"  style="width:170px" readonly="true" /></FONT>
			</td>
			<html:hidden property="district" />
		</tr>
		<tr>
			<td  class="textborder" >
				<bean:message key="app.division" /><font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:select property="doc" style="width:170px" 
							 styleClass="mycombo" onchange="javascript:getData()" >
				<html:option value="">SELECT...</html:option>
				<html:options collection="divisions" name="labelValueBean" 
							  property="value" labelProperty="label" />
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
				<html:options collection="subdivisions" name="labelValueBean" 
							  property="value" labelProperty="label" />
				</html:select>
			</td>
		</tr>
		
		<tr>		
			<td class="textborder" >
				<bean:message key="app.mandal" /><font color="#FF6666">*</font>
			</td>
			<td class="bwborder" >
				<html:select property="mandal" styleClass="mycombo" 
							 style="width:140px" >
				<html:option value="">SELECT...</html:option>
				<html:options collection="mandals" name="rwsLocationBean" 
							  property="mandalCode" labelProperty="mandalName" />
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
		<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateMandalSubdivisionForm(mandalSubdivisionForm)"/>
		<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" onclick="resetfn()" />
 		<html:button property="mode" title="View the Fields" styleClass="btext" value="View" onclick="viewfun()" />
 	</td>



</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="350"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>