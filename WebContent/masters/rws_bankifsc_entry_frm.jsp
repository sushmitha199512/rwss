<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
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
document.forms[0].action="switch.do?prefix=/masters&page=/Ifsc.do&mode=view";
document.forms[0].submit();
}
function isSaveAttended1()
{
//alert("save");
if(document.forms[0].accountNumber.value == null || document.forms[0].accountNumber.value=="")
{
alert("Enter Account Number");
return false;
}
else if(document.forms[0].accountholderName.value== null || document.forms[0].accountholderName.value== "")
{
alert("Enter Account Holder Name");
return false;
}
else if(document.forms[0].personAddress.value== null || document.forms[0].personAddress.value== "")
{
alert("Enter Address");
return false;
}
else if(document.forms[0].personAccount.value== null || document.forms[0].personAccount.value== "")
{
alert("Enter Person Operating Account");
return false;
}



else
{
document.forms[0].action="switch.do?prefix=/masters&page=/Ifsc.do&mode=save";
document.forms[0].submit();
}
}
function init()
{
document.forms[0].bankName="";
document.forms[0].branchName="";
document.forms[0].accountNumber="";
document.forms[0].bankAddress="";
}


</script>
<%@ include file="/commons/rws_header2.jsp" %>
<body  onload="javascript:init();">
<html:form action="/Ifsc.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Remitter Details Entry Form" />
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
	   style="border-collapse:collapse;" width="280" >
<tr align="center">
<td>
	<table  border=0  width="100%">
<tr>
		<td class="textborder">IFSC Code<font color=red>*</font>
		</td>
		<td class="textborder" >
		<html:text property="ifscCode"  maxlength="11"   /><html:button property="mode" title="Enter IFSC Code" styleClass="btext" value="Enter" onclick="return isSaveAttended();" /></td>
		</tr>
		<tr>
		<td class="textborder">Bank Name
		</td>
		<td class="textborder" >
		<html:text property="bankName" readonly="true"  size="40" /></td>
		</tr>
        <tr>
		<td class="textborder">Bank Address
		</td>
		<td class="textborder" >
       
		<html:textarea property="bankAddress"  readonly="true"  cols="30" rows="2"   /></td>
		</tr>
 
		<tr>
		<td class="textborder">Branch Name
		</td>
		<td class="textborder" >
		<html:text property="branchName"  readonly="true"    size="40" /></td>
		</tr>
		<tr>
		<td class="textborder">Account Number<font color=red>*</font>
		</td>
		<td class="textborder" >
		<html:text property="accountNumber" onkeypress="return numeralsOnly(event)"    size="40" /></td>
		</tr>
        <tr>
		<td class="textborder">Name<font color=red>*</font>
		</td>
		<td class="textborder" >
		<html:text property="accountholderName" onkeypress="return alpha(event)" size="40"  /></td>
		</tr>
		
		<tr>
		<td class="textborder">Address<font color=red>*</font>
		</td>
		<td class="textborder" >
		<html:textarea property="personAddress"  onkeypress="upperOnly()"   rows="2" cols="30" /></td>
		</tr>
		

		
<tr>
		<td class="textborder">Person Operating A/C<font color=red>*</font>
		</td>
		<td class="textborder" >
		<html:text property="personAccount"  onkeypress="return alpha(event)"   size="40" /></td>

		</tr>
		

		


		</table>
		</td>
		</tr>
		<tr>
		<td class="textborder" align=center>			 
		<html:button property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return isSaveAttended1();" />
				</td>
	</tr>
	</table>
</td>
</tr>
</tbody>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>

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



