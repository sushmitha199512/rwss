<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="officeForm" />
<script language="JavaScript">

function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Office.do?mode=data";
	document.forms[0].submit();
}
//added this method on 14-07-2011 by swapna
function viewData()
{
	var h=officeForm.hoc.value;
	//alert("h:"+h);
	var c=officeForm.coc.value;
	//	alert("c:"+c);
	if(h==null || h=="0")
	{
		alert("Please Select Head Office Code");
		return false;
	}
	else if(c==null || c=="00")
	{
		alert("Please Select Circle Office Code");
		return false;
	}
	else 
	{
	document.forms[0].action="switch.do?prefix=/masters&page=/Office.do?mode=View";
	document.forms[0].submit();
}
}

function getRwsCode()
{
	var ocode=officeForm.hoc.value+officeForm.coc.value+officeForm.doc.value+officeForm.sdoc.value;
	officeForm.roc.value = ocode;
}			

</script>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="Office.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Office Entry Form" />
	<jsp:param name="TWidth" value="560" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" width="460" border="1" style="border-collapse:collapse;">
<tr>
<td>
	
	<table  border=0  width="596"  align=center  >
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Head Office<font color="#FF6666">*</font></FONT></td>
	<td  class=mycborder >
	<html:select property="hoc" styleClass="mycombo" style="width:170px" onchange="javascript:getData()" >
	<html:option value="0">SELECT...</html:option>
	<html:options collection="heads" name="labelValueBean" property="value" labelProperty="label" />	</html:select>
	</td>
	<td  class=mycborder >
	<FONT class=myfontclr>Circle Office</FONT></td>
	<td  class=mycborder >
		<html:select property="coc" style="width:170px" styleClass="mycombo" onchange="javascript:getData()" >
		<html:option value="00"><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="circlecodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	</tr>
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Division Office</FONT></td>
	<td  class=mycborder >
		<html:select property="doc" style="width:170px" styleClass="mycombo" onchange="javascript:getData()" >
		<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="divcodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
		
	</td>
	<td  class=mycborder >
		<FONT class=myfontclr>Sub Division Office</FONT></td>
	<td  class=mycborder >
		<html:select property="sdoc" styleClass="mycombo" style="width:170px" >
		<html:option value="00"><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="subdivcodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	</tr>
	</table>
	<hr style="color:#8A9FCD">
	<table  border=0  width="596"  align=center  style="margin-bottom:5;margin-top:0">
	<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.roc" /></FONT></td>
		<td  class=mycborder >
		<html:text property="roc" value="" styleClass="mytext" readonly="true" onfocus="javascript:getRwsCode()" /></td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.street" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="address" value="" styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.location" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="location" value="" styleClass="mytext" maxlength="20" />
		</td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.area" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="area" value="" styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.city" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="city" value="" styleClass="mytext" maxlength="20" />
		</td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.pin" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="pin" value="" styleClass="mytext" maxlength="6" onkeypress="return numeralsOnly()"/>
		</td>	  
		</tr>
		<tr >
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.phone" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="phone" value="" styleClass="mytext" maxlength="20"  onkeypress="return numeralsOnly()"/>
		</td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.fax" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="fax" value="" styleClass="mytext" maxlength="20" onkeypress="return numeralsOnly()" />
		</td>
		</tr>
		<tr >
  		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.email" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="email" value="" styleClass="mytext" maxlength="40" />
		</td>	  
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.building" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		
		<html:select property="building" styleClass="mycombo">
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:option value="O">OWN</html:option>
		<html:option value="R">RENTED</html:option>
		</html:select>
		
		</td>
		</tr>
		<tr >
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.hof" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:select property="hof" style="width:123px" styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="desgns" name="rwsMaster" property="desgnCode" labelProperty="desgnAcr" />
		</html:select>
		</td>
		
  		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.project" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		
		<html:select property="project" styleClass="mycombo">
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:option value="R">REGULAR</html:option>
		<html:option value="P">PROJECT</html:option>
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
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateOfficeForm(officeForm)" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:button property="mode" title="view the Fields" styleClass="btext" value="View" onclick="return viewData()" />
	 
	</td>
</tr>

</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="560"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>