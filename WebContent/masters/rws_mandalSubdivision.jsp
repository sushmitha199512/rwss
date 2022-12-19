<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivisionCon.do&mode=data";
	document.forms[0].submit();
}
function saveData()
{
if(document.forms[0].dcode.value=="" || document.forms[0].dcode.value==null)
{
alert("Select District");
return false;
}
else if(document.forms[0].mandal.value=="" || document.forms[0].mandal.value==null)
{
alert("Select Mandal");
return false;
}   
else if(document.forms[0].doc.value=="" || document.forms[0].doc.value==null)
{
alert("Select Division");
return false;
}   
else if(document.forms[0].sdoc.value=="" || document.forms[0].sdoc.value==null)
{
alert("Select SubDivision");
return false;
}   

else
{

   
	document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivisionCon.do&mode=save";
	document.forms[0].submit();
}
}
//-->
</SCRIPT>
<!DOCTYPE html:form PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>	
<body>
<html:form action="/MandalSubdivisionCon.do" >
	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
	<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "RIGHT">			
			<tr align="right">
				<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>			
			</tr>  
		</table>
	</caption>
	</table>
	<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
		<jsp:param name="TableName" value="Mandal SubDivision Change Form" />
		<jsp:param name="TWidth" value="350" />
	</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="390" >
<tr>
  <td>
	<table  border=0  width="350"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
			<td  class="textborder" >
				District<font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:select property="dcode" style="width:170px" styleClass="mycombo" onchange="javascript:getData()" >
				<html:option value="">SELECT...</html:option>
				<html:options collection="dists" name="labelValueBean" property="value" labelProperty="label" />
				</html:select>
			</td>
		</tr>
		<tr>		
			<td class="textborder" >
			Mandal<font color="#FF6666">*</font>
			</td>
			<td class="bwborder" >
				<html:select property="mandal" styleClass="mycombo"  onchange="javascript:getData()"
							 style="width:170px" >
				<html:option value="">SELECT...</html:option>
				<html:options collection="mandals" name="labelValueBean" 
							  property="value" labelProperty="label" />
				</html:select>
			</td>
		</tr>
		<tr>
			<td class="textborder" align="left"  colspan="2"><font color="blue">Present Division & SubDivision:</font></td></tr>
		<tr>
			<td class="textborder" >Division</td>
			<td class="textborder" ><FONT class=myfontclr>
				<html:text property="dname"  style="width:170px" readonly="true" /></FONT>
			</td>
			<html:hidden property="dnameCode" />
		</tr>
		<tr>
			<td class="textborder"  >SubDivision</td>
			<td class="textborder" ><FONT class=myfontclr>
				<html:text property="sdname"  style="width:170px" readonly="true" /></FONT>
			</td>
			<html:hidden property="sdnameCode" />
		</tr>
		<tr>
			<td class="textborder" align="left"  colspan="2"><font color="blue">Proposed Division & SubDivision:</font></td></tr>
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
				<html:select property="sdoc" style="width:170px" styleClass="mycombo" >
					<html:option value="">SELECT...</html:option>
					<logic:present name="subdivisions">
						<html:options collection="subdivisions" name="labelValueBean" property="value" labelProperty="label" />
					</logic:present>
				</html:select>
			</td>
		</tr>
</table>
	<tr>
		<td colspan="2" align="center">
			<html:button property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return saveData()" />
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
</body>
</html>