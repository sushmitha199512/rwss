<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<script language="JavaScript">
function fnSearch()
	{
	if(document.forms[0].complntno.value== "" || document.forms[0].complntno.value==null)
	{
	alert("Enter Complaint Number");
	return false;
	}
	else
	{
	document.forms[0].action="switch.do?prefix=/complaints&page=/ComplaintNo.do?mode=cview";
	document.forms[0].submit;
	}
	}

function fnSea()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/ComplaintNo.do?mode=get3";
	document.forms[0].submit;
}

function init()
{
document.forms[0].complntno.value='';
}
</script>
<body>
<%@ include file="/commons/rws_header2.jsp" %>
   <html:form action="ComplaintNo.do">
    <jsp:include page="/commons/TableHeaderComplaints.jsp">
	<jsp:param name="TableName" value="Complaints Status " />
	<jsp:param name="TWidth" value="315" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="355" align="center">
<tr>
<%String complaintnumber=(String)session.getAttribute("complaintnumber"); %>
<td align=center>Complaint Number<font color="#FF6666">*</font>:<html:text property="complntno" value="<%=complaintnumber%>" styleClass="mytext" style="width:80px"  maxlength="12"  onkeypress="upperOnly()" />
</td>
</tr>
    <tr>
	<td align=center>
	<html:submit property="mode" title=" Complaint Status"  styleClass="btext" value="Complaint Status" onclick="fnSearch();"/>
    <html:submit property="save" title=" Forget Complaint Number"  styleClass="btext" value="?" onclick="fnSea();"/></td>
	</tr>
	
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="315"/>
</jsp:include>
</table>
</html:form>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
</body>
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





