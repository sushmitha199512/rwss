<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<script language="JavaScript">
function getData2()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/TotalComplaintR.do?mode=get2";
	document.forms[0].submit();
}
function fnSea()
{
if(document.forms[0].dist.value== "0" || document.forms[0].dist.value==null)
    {
    alert("Select District");
    return false;
    }
   else if(document.forms[0].mand.value== "0" || document.forms[0].mand.value==null)
   {
   alert("Select Mandal");
   return false;
   }
   else if(document.forms[0].panch.value== "0" || document.forms[0].panch.value==null)
   {
   alert("Select Panchayat");
   return false;
   }
     else
   {
		document.forms[0].action="switch.do?prefix=/complaints&page=/TotalComplaintR.do?mode=view";
		document.forms[0].submit;
   }
}

function init()
{
document.forms[0].dist.value="0";
document.forms[0].mand.value="0";
document.forms[0].panch.value="0";
document.forms[0].asset.value="0";
}
</script>
<body >
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="TotalComplaintR.do">
<jsp:include page="/commons/TableHeaderComplaints.jsp">
	<jsp:param name="TableName" value="Complaints Status Report " />
	<jsp:param name="TWidth" value="315" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="315" align="center">
<tr >
<td>
    <fieldset>
   <legend><bean:message key="legend.habitationDetails"/></legend>
   <label>
		<table  border=0  width="340"  align=center  style="margin-bottom:0;margin-top:0"> 
		<tr>
		<td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		<html:select property="dist" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()" >
		<html:option value="0"><font class="myfontclr1">SELECT...</html:option>

		<logic:present name="districts">
		<html:options collection="districts" name="compForm" property="districtCode" labelProperty="districtName" />
		</logic:present>
		</html:select>
		</td>
		</tr>
		<tr>
		<td class="textborder" width="100">
		<bean:message key="app.mandal"/><font color="#FF6666">*</font>
		<td class="textborder" width="150">
		<html:select property="mand" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()">
		<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="mandals">
		<html:options collection="mandals" name="compForm" property="mandalCode" labelProperty="mandalName" />
		</logic:present>
		</html:select>
		</td>
		</tr>
		<tr>
		<td class="textborder" width="100">
		<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()" >
		<html:option value="0">SELECT...</html:option>
		<logic:present name="panchayats">
		<html:options collection="panchayats" name="compForm" property="panchayatCode" labelProperty="panchayatName" />
		</logic:present>
		</html:select>
		</td>
		</tr>
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		<tr>
		<td align=center>
		<html:submit property="mode" title="View Report"  styleClass="btext" value="View Report" onclick="fnSea();"/>
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




