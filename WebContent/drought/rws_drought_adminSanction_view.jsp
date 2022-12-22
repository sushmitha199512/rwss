<%@ include file="/commons/rws_header1.jsp"%>
<%
String proposalId=(String)request.getAttribute("proposalId");



%>


<script language="JavaScript">

function fnShowHabs(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/drought&page=/AdminstrativeSanctionSaveForm.do?mode=showHabs&proposalId="+proposalId;
	var properties = "width=748,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}

function fnDelete(count)
{
var proposalId=document.getElementById("work["+count+"].proposalId").value
var url="switch.do?prefix=/drought&page=/AdminstrativeSanctionSaveForm.do?mode=Delete&proposalId="+proposalId+"&circleOfficeCode="+document.forms[0].circleOfficeCode.value;
if(confirm("Do you want to Delete Details regarding  WorkId?"+proposalId))
{
document.forms[0].action=url;
document.forms[0].submit();
}
}
function fnEdit(count)
{   
    var index=count;
    var proposalId=document.getElementById("work["+count+"].proposalId").value;
    var habId=document.getElementById("work["+count+"].noOfHabs").value;
	var url="switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=edit&proposalId="+proposalId+"&habId="+habId+"&index="+index;
	var properties = "width=900,height=632,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
}
</script>
<%@ include file="/commons/rws_header2.jsp"%>
<html:form action="AdminstrativeSanctionSaveForm.do">
<html:hidden property="circleOfficeCode"/>
</html:form>
<table width="100%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/drought&page=/AdminstrativeSanction.do&mode=null">Back</a> 
	</td>
</tr>	
</thead>
<tbody>
<tr>
	<td class="reportTitle">Drought Works List</td>
</tr>
</tbody>
</table>
<table width="100%" align="center" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead class="reportHead">
<tr>
	<th><bean:message key="app.sno"/></th>
	<th><bean:message key="app.workname" /></th>
    <th>Work Type</th>
	<th>Work Id</th>
	<th>Habitation Code</th>
	<th>Sanctioned Amount</th>
	<th>Admin No.</th>
	<th>Admin Date</th>
	<th>Work Category</th>
 	<th>Scheme</th>
 	<th>Plan Type</th>
    <th>Augmentation ID</th>
 	<th width="15%" >Programme</th>
 	<th>Sub Programme</th>
	<th>Prepared By</th>
	<th>Prepared On</th>
	<th>Office Code</th>
    <th>TechSanction No.</th>
    <th>TechSanction Amt</th>
    <th>TechSanction Date</th>
    <th>SSR Year</th>
	<th>Source Hab Code</th>
	<th>Asset Code</th>
	<th>Existing</th>
	<th>Site Hand Over Date</th>
	<th>Grounding Date</th>
	<th>Expenditure UPTO</th>			
	<th>Expenditure Upto Date</th>
	<th>Value of Work not Paid</th>
	<th>Work Completion Date</th>
	<th>Final Completion Date</th>
	<th>Work Commencement Date</th>
    <th>Approved Under</th>
    <th>Remarks</th>
	<th>Select</th>
    <th>Delete</th>
</tr>
</thead><%int count=1;%>
<tbody class="reportBody">
<%   java.util.Collection a = (java.util.Collection)session.getAttribute("AdministrativeSanctionList1"); 
     int x=a.size();
     
if(a.size()>0)
{                   %>
<logic:iterate id="work" name="AdministrativeSanctionList1">
<tr>
    <td width="135"><%=count++%></td>
	<td width="135"><bean:write name="work" property="proposalName" /></td>
    <td width="135"><bean:write name="work" property="workType" /></td>
	<td width="135"><bean:write name="work" property="proposalId" /><html:text  property="proposalId" name="work"  style="width:0px" indexed="true"/></td>
    <td width="135"><bean:write name="work" property="noOfHabs" /><html:text  property="noOfHabs" name="work"  style="width:0px" indexed="true"/></td>
    <td width="135"><bean:write name="work" property="sanctionedAmount" /></td>
    <td width="135"><bean:write name="work" property="adminNo" /></td>
    <td width="135"><bean:write name="work" property="adminDate" /></td>
    <td width="135"><bean:write name="work" property="workCat" /></td>
    <td width="135"><bean:write name="work" property="typeOfAsset" /></td>
    <td width="135"><bean:write name="work" property="plan" /></td>	
    <td width="135"><bean:write name="work" property="wrkType" /></td>	
    <td width="135"><bean:write name="work" property="programmeName" /></td>
	<td width="135"><bean:write name="work" property="subprogrammeName"/></td>
   	<td width="135"><bean:write name="work" property="preparedBy" /></td>
	<td width="135"><bean:write name="work" property="preparedOn" /></td>
	<td width="135"><bean:write name="work" property="officeCode" /></td>
    <td width="135"><bean:write name="work" property="tsno" /></td>
	<td width="135"><bean:write name="work" property="tsdate" /></td>
	<td width="135"><bean:write name="work" property="tsamt" /></td>
	<td width="135"><bean:write name="work" property="ssryr" /></td>
	<td width="135"><bean:write name="work" property="srhabcode" /></td>
	<td width="135"><bean:write name="work" property="astcode" /></td>
	<td width="135"><bean:write name="work" property="newext" /></td>
	<td width="135"><bean:write name="work" property="sitedate" /></td>
	<td width="135"><bean:write name="work" property="grounddate" /></td>
	<td width="135"><bean:write name="work" property="expupto" /></td>
	<td width="135"><bean:write name="work" property="expuptodate" /></td>
	<td width="135"><bean:write name="work" property="notpaidvalue" /></td>
	<td width="135"><bean:write name="work" property="compdate" /></td>
	<td width="135"><bean:write name="work" property="fincompdate" /></td>			
    <td width="135"><bean:write name="work" property="commdate" /></td>	
    <td width="135"><bean:write name="work" property="prooved" /></td>
    <td width="135"><bean:write name="work" property="remarks" /></td>	
 	<td align="center" nowrap><a href="#" onclick="fnEdit(<%=count-2 %>)">Edit</a>&nbsp;</td>
    <td align="center" nowrap><a href="#" onclick="fnDelete(<%=count-2 %>)">Delete</a>&nbsp;</td>
</tr>
</logic:iterate>
<%}
else
{
%>
<tr><td colspan=38 align=center>No Records</td></tr>
<%
}
 %>
</tbody>
</table>

<br>

<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />

<%@ include file="/commons/rws_alert.jsp"%>