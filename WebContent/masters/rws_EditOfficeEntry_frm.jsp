<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="officeForm" />
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
 <html:form action="Office.do?mode=edit" onsubmit="return validateOfficeForm(this)" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Office Entry Form" />
	<jsp:param name="TWidth" value="560" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols"  width="460" style="border-collapse:collapse;" >
<tr>
<td>
<table  border=0  width="596"  align=center  >
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Head Office<font color="#FF6666">*</font></FONT></td>
	<td  class=mycborder >
	<html:text property="hoc" styleClass="mytext" maxlength="15" readonly="true" />
	</td>
	<td  class=mycborder >
	<FONT class=myfontclr>Circle Office</FONT></td>
	<td  class=mycborder >
		<html:text property="coc" styleClass="mytext" maxlength="15" readonly="true" />
	</td>
	</tr>
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Division Office</FONT></td>
	<td  class=mycborder >
     <html:text property="doc" styleClass="mytext" maxlength="15" readonly="true" />
 		
	</td>
  
	<td  class=mycborder >
		<FONT class=myfontclr>Sub Division Office</FONT></td>
	<td  class=mycborder >
      <html:text property="sdoc" styleClass="mytext" maxlength="15" readonly="true" />
 	</td>
  
	</tr>
	</table>
		<hr style="color:#8A9FCD">
	<table  border=0  width="596"  align=center  style="margin-bottom:5;margin-top:5">
<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.roc" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="roc" styleClass="mytext" maxlength="5" readonly="true" /></td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.street" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="address"  styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.location" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="location"  styleClass="mytext" maxlength="20" />
		</td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.area" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="area"  styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.city" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="city"  styleClass="mytext" maxlength="20" />
		</td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.pin" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="pin"  styleClass="mytext" maxlength="6" onkeypress="return numeralsOnly()"/>
		</td>	  
		</tr>
		<tr >
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.phone" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder> 
		<html:text property="phone"  styleClass="mytext" maxlength="20" onkeypress="return numeralsOnly()" />
		</td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.fax" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="fax"  styleClass="mytext" maxlength="20" onkeypress="return numeralsOnly()"/>
		</td>
		</tr>
		<tr >
  		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.email" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="email"  styleClass="mytext" maxlength="40" />
		</td>	  
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.building" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:select property="building" styleClass="mycombo">
		<html:option value="">SELECT...</html:option>
		<html:option value="O">Own</html:option>
		<html:option value="R">Rented</html:option>
		</html:select>
		
		</td>
		</tr>
		<tr >
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.hof" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:select property="hof"  styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="desgns" name="rwsMaster" property="desgnCode" labelProperty="desgnAcr" />
		</html:select>
		</td>
		
  		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.project" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder>
		<html:select property="project" styleClass="mycombo">
		<html:option value="">SELECT...</html:option>
		<html:option value="R">Regular</html:option>
		<html:option value="P">Project</html:option>
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
	<html:submit title="Save the Fields" styleClass="btext" value="Save"  />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 
	</td>
</tr>
</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="560"/>
</jsp:include>

</html:form>
</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>


