<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="wqLabForm" />

<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/WaterLab.do?mode=data";
	document.forms[0].submit();
}
//-->
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="WaterLab.do" >

<%
			String csrfToken = "";
					nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
					csrfToken = valUtil.getCSRFCode();
					session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Quality Lab Entry Form" />
	<jsp:param name="TWidth" value="540" />
</jsp:include>

<table  bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"   width="580" >
<tr>
<td>
	<table  border=0  width="100%"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
	<td class="mycborder" colspan="6">
	
	<table  border=0   align=center width="100%">
	<tr>
	<td><FONT class=myfontclr nowrap>Head Office<font color="#FF6666">*</font></FONT></td>
	<td  class=mycborder >
	<html:select property="hoc" styleClass="mycombo" style="width:123px" onchange="javascript:getData()" >
	<html:option value="">SELECT...</html:option>
	<html:options collection="heads" name="labelValueBean" property="value" labelProperty="label" />	</html:select>
	</td>
	<td  class=mycborder >
	<FONT class=myfontclr>Circle</FONT></td>
	<td  class=mycborder >
		<html:select property="coc" style="width:123px" styleClass="mycombo" onchange="javascript:getData()" >
		<html:option value="00"><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="circlecodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
		</tr><tr>	<td  class=mycborder >
	<FONT class=myfontclr>Division</FONT></td>
	<td  class=mycborder >
		<html:select property="doc" style="width:123px" styleClass="mycombo" onchange="javascript:getData()" >
		<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="divcodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
		
	</td>	<td  class=mycborder >
	<FONT class=myfontclr>Mandal</FONT></td>
	<td  class=mycborder >
		<html:select property="mancode" style="width:123px" styleClass="mycombo"  >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="mandalcodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
		
	</td>
	</tr>
	<tr>
	<td><FONT class=myfontclr>Sub Division</FONT></td>
	<td  class=mycborder >
		<html:select property="subdivcode" style="width:123px" styleClass="mycombo"  >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="subdivisions" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
		
	</td>
	</tr>
	
	</table>
	<hr color="#8A9FCD">
	
<tr>
<td  class=mycborder nowrap>
		<FONT class=myfontclr>Lab Code<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="labCode" value="<%=(String)request.getAttribute(\"code\")%>" style="width:40px" readonly="true"/>
		</td>
		<%-- <html:hidden property="labCode" value="<%=(String)request.getAttribute(\"code\")%>"/> --%>
		<td  class=mycborder nowrap>
		<FONT class=myfontclr>Lab Name<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="labName" value=""  />
		</td>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Location<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="location" value=""  />
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr>Lab Head<font color="#FF6666">*</font></FONT></td>
		<td  class=mycborder >
		<html:select property="desgnCode" style="width:123px" styleClass="mycombo"  >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="desgns" name="rwsMaster" property="desgnCode" labelProperty="desgnAcr" />
		</html:select>
		</td>
		</tr>
		<tr>
		<td  class=mycborder nowrap>
		<FONT class=myfontclr>Year Of Establishment<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="labEstablishedYear" value=""  maxlength="4" onkeypress="return numeralsOnly()"/>
		</td>
		<td  class=mycborder nowrap>
		<FONT class=myfontclr>Contact Number</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="contactNum" value=""/>
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Level Code<font color="#FF6666">*</font></FONT></td>
		<td  class=mycborder >
		<html:select property="levelCode" style="width:123px" styleClass="mycombo"  >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:option value="02">State</html:option>
		<html:option value="03">District</html:option>
		<html:option value="04">Division</html:option>
		<html:option value="05">Sub Division</html:option>
		</html:select>	
</td>
<td  class=mycborder ><FONT class=myfontclr>Status</FONT></td>
<td>
		<html:select property="status" style="width:123px" styleClass="mycombo"  >
			<html:option value="I">I</html:option>
		<html:option value="UI">UI</html:option>
		</html:select>	
</td>	
		</tr>
		
	</table>
	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateWqLabForm(wqLabForm)" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="540"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>