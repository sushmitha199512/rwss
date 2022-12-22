<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<script language="JavaScript">
<%
	 Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String transdate=null;
	transdate=dateFormat.format(systemdate);
%>
function isSaveAttended()
{
if(document.forms[0].attenby.value=="0" || document.forms[0].attenby.value==null)
{
alert("Select Attended By");
return false;
}
 else  if(document.forms[0].complntstatus.value=="0" || document.forms[0].complntstatus.value==null)
{
alert("Select Complaint Status");

return false;
}
 else if(document.forms[0].remarksby.value == " " || document.forms[0].remarksby.value==null)
{
alert("Enter Remarks");
return false;
}
else
{
return true;
document.forms[0].action="switch.do?prefix=/complaints&page=/Attend.do&mode=save";
document.forms[0].submit();
}
}
</script>
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="Attend.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeaderComplaints.jsp">
	<jsp:param name="TableName" value="Complaints Attend Entry Form" />
	<jsp:param name="TWidth" value="100%" />
	</jsp:include>
	</td>
</tr>
</thead>
<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="780" >
<tr>
<td>
	<table  border=0  width="100%">
<tr>
<td class="textborder">Source Name	
		</td>
		<td class="textborder" >
		<html:text property="assetName" readonly="true" style="width:180px" value="<%=(String)session.getAttribute("assetname")%>" /></td>
		</tr>
		<tr>
		<td class="textborder">Source Code
		</td>
		<td class="textborder" >
		<html:text property="SourceCode" readonly="true" style="width:180px" value="<%=(String)session.getAttribute("sourcecode")%>" /></td>
		<td class="textborder">Complaint Number
		</td>
		<td class="textborder" >
		<html:text property="complntno" readonly="true" value="<%=(String)session.getAttribute("complaintno")%>" /></td>
		</tr>
		<tr>
		<td class="textborder">Problem Type
		</td>
		<td class="textborder" >
		<html:text property="categoryName" readonly="true" style="width:180px" value="<%=(String)session.getAttribute("categoryname")%>" /></td>
		<td class="textborder">Complaint Date
		</td>
		<td class="textborder" >
		<html:text property="complntdt" readonly="true" value="<%=(String)session.getAttribute("complaintdate")%>" /></td>
		</tr>
		<tr>
		<td class="textborder" width="100">Complaint Attended By<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" width="150">
		<html:select property="attenby" styleClass="mycombo" style="width:150px"  >
		<html:option value="0"><font class="myfontclr1">Select</html:option>
		<html:option value="CE RWS"><font class="myfontclr1">CE RWS</html:option>
		<html:option value="Engineer"><font class="myfontclr1">Engineer</html:option>
		</html:select>
		</td>
		<td class="textborder">Complaint Attended Date
		</td>
		<td class="textborder" >
		<html:text property="attendt" value="<%=transdate%>"  readonly="true"/><a href="javascript:showCalendar(document.CompForm.attendt);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
		</td>
		</tr>
		<tr>
		<td class="textborder" width="100">Status<font color="#FF6666"></font></td>
		<td class="textborder" width="150">
		<html:select property="complntstatus" styleClass="mycombo" style="width:150px"  >
		<html:option value="0"><font class="myfontclr1">Select</html:option>
		<html:option value="Working"><font class="myfontclr1">Working</html:option>
		<html:option value="Not Working"><font class="myfontclr1">Not Working</html:option>
		<html:option value="Condemned"><font class="myfontclr1">Condemned</html:option>
		<html:option value="Dried"><font class="myfontclr1">Dried</html:option>
		<html:option value="Others"><font class="myfontclr1">Others</html:option>
		</html:select>
		</td>
		<td class="textborder">Remarks<font color="#FF6666">*</font>
		</td>
		<td class="textborder" >
		<html:textarea property="remarksby" rows="5" cols="20"  />
		</td>
		</tr>
				</table>
		</td>
		</tr>
		<tr>
		<td class="textborder" align=center>			 
		<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return isSaveAttended();" />
				</td>
	</tr>
	</table>
</td>
</tr>
</tbody>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>


