<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<script language="JavaScript">
function getData2()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/TotalComplaintsgeneric.do?mode=get2";
	document.forms[0].submit();
}
function fnSea()
{
if(document.forms[0].dist.value== "" || document.forms[0].dist.value==null)
    {
    alert("Select District");
    return false;
    }
   else if(document.forms[0].mand.value== "" || document.forms[0].mand.value==null)
   {
   alert("Select Mandal");
   return false;
   }
   else if(document.forms[0].panch.value== "" || document.forms[0].panch.value==null)
   {
   alert("Select Panchayat");
   return false;
   }
   
   else if(document.forms[0].fromDate.vaule=="" || document.forms[0].fromDate.value==null)
	{
	   alert("Select From date");
	   return false;
	}
	else if(document.forms[0].toDate.vaule=="" || document.forms[0].toDate.value==null)
	{
	   alert("Select To date");
	   return false;
	}
   else
   {
   

		document.forms[0].action="switch.do?prefix=/complaints&page=/TotalComplaintsgeneric.do?&mode=view";
		document.forms[0].submit;
   }
}
function init()
{
document.forms[0].dist.value="";
document.forms[0].mand.value="";
document.forms[0].panch.value="";

}
</script>
<body >
aaaaaa
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="TotalComplaintsgeneric.do">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Generic Grievance  Report   " />
	<jsp:param name="TWidth" value="315" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="315" align="center">
<tr >
<td>
 
   <fieldset>
   <legend></legend>
   <label>
   <table  border=0  width="340"  align=center  style="margin-bottom:0;margin-top:0"> 
   <tr>
   <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		<html:select property="dist" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="districts">
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
		</td>
		</tr>
		<tr>
		<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="mand" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<logic:present name="mandals">
			<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
		</td>
	</tr>
	<tr>
	   <td class="textborder" width="100">
	   <bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	   <td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()" >
		<html:option value="">SELECT...</html:option>
		<logic:present name="panchayats">
		<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
	    </td>
		</tr>
	<tr>	
   <td class="textborder">
   From Date<font color="#FF6666">*</font></td>
	<td class="textborder"><html:select property="fromDate" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
		<html:option value="">SELECT...</html:option>
		<logic:present name="fromdates">
		<html:options collection="fromdates" name="lavelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
	</td>
	</tr>
	<tr>
		<td class="textborder">
	To Date<font color="#FF6666">*</font></td>
		<td class="textborder"><html:select property="toDate" styleClass="mycombo" style="width:150px"  >
		<html:option value="">SELECT...</html:option>
		<logic:present name="todates">
		<html:options collection="todates"  name="labelValueBean" property="value" labelProperty="label" />
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
	<html:submit property="mode" title="View Report"  styleClass="btext" value="View Report" onclick="return fnSea();"/>
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




