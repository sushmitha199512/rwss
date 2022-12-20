<%@ include file="/commons/rws_header1.jsp"%>
<%


System.out.println("pushkar view");

%>


<script language="JavaScript">



function fnDelete(count)
{
var proposalId=document.getElementById("work["+count+"].proposalId").value;
var url="switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=Delete&proposalId="+proposalId+"&circleOfficeCode="+document.forms[0].circleOfficeCode.value;
if(confirm("Do you want to Delete Details regarding  WorkId?"+proposalId))
{
document.forms[0].action=url;
document.forms[0].submit();
}
}
function fnEdit(count)
{   
   //  alert(count);
    var index=count;
  //  alert("index.."+index);
    var proposalId=document.getElementById("work["+count+"].proposalId").value;
   // alert("proposalId.."+proposalId);
    var habId=document.getElementById("work["+count+"].habCode").value;
   // alert("habId.."+habId);
    
    alert("You are going to Edit details for Pushkar WorkId.."+proposalId);

    document.forms[0].action = "switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=edit&proposalId="+proposalId+"&habId="+habId+"&index="+index;
		
	 document.forms[0].submit();
	//="switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=edit&proposalId="+proposalId+"&habId="+habId+"&index="+index;
    // alert(url);
	//var properties = "width=900,height=632,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				 //  + "scrollbars=yes,copyhistory=no,resizable=yes";
	//var newWindow = window.open(url, "", properties);
}
</script>
<%@ include file="/commons/rws_header2.jsp"%>
<html:form action="PushkarWork.do">
<html:hidden property="circleOfficeCode"/>
</html:form>
<table width="100%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/pushkar&page=/PushkarWork.do&mode=null">Back</a> 
	</td>
</tr>	
</thead>
<tbody>
<tr>
	<td class="reportTitle">Pushkar Works List</td>
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
	<th>Ghat Type</th>
	<th>PushkarCode</th>
	<th width="15%" >Programme</th>
 	<th>Sub Programme</th>
    <th>Prepared On</th>
	<th>Tender Invited</th>
    <th>Tender Amount</th>
    <th>Tender Approved</th>
    <th>Tender Approved Amount</th>
	<th>Agreement Conclude</th>
	<th>Agreement Amount</th>
	<th>Physical Stage</th>
	<th>Value of Work Done</th>
	<th>Value of Work Done Date</th>
	<th>Probable Date of Completion</th>
	<th>Date of Completion</th>
	<th>Expenditure</th>
    <th>Remarks</th>
	<th>Select</th>
    <th>Delete</th>

</tr>
</thead><%int count=1;%>
<tbody class="reportBody">
<%   java.util.ArrayList a = (java.util.ArrayList)session.getAttribute("pushkarview"); 
     int x=a.size();
     
System.out.println("a.size in view "+  x  );
if(a.size()>0)
{                   %>
<logic:iterate id="work" name="pushkarview">
<tr>
    <td width="135"><%=count++%></td>
	<td width="135"><bean:write name="work" property="proposalName" /></td>
    <td width="135"><bean:write name="work" property="workType" /></td>
	<td width="135"><bean:write name="work" property="proposalId" /><html:text  property="proposalId" name="work"  style="width:0px" indexed="true"/></td>
    <td width="135"><bean:write name="work" property="habCode" /><html:text  property="habCode" name="work"  style="width:0px" indexed="true"/></td>
    <td width="135"><bean:write name="work" property="sanctionAmout" /></td>
    <td width="135"><bean:write name="work" property="adminiStrativeNum" /></td>
    <td width="135"><bean:write name="work" property="adminiStrativeDate" /></td>
    <td width="135"><bean:write name="work" property="ghatType" /></td>
    <td width="135"><bean:write name="work" property="pushkarCode" /></td>
    <td width="135"><bean:write name="work" property="programs" /></td>
    <td width="135"><bean:write name="work" property="subPrograms" /></td>	
    <td width="135"><bean:write name="work" property="preparedOn" /></td>
	<td width="135"><bean:write name="work" property="tenderinvited" /></td>
	<td width="135"><bean:write name="work" property="tsno" /></td>
	<td width="135"><bean:write name="work" property="tenderaprvd" /></td>
	<td width="135"><bean:write name="work" property="tenderappamount" /></td>
	<td width="135"><bean:write name="work" property="agreeconcluded" /></td>
	<td width="135"><bean:write name="work" property="agreeamount" /></td>
	<td width="135"><bean:write name="work" property="physicaldetails" /></td>
	<td width="135"><bean:write name="work" property="workdonevalue" /></td>
	<td width="135"><bean:write name="work" property="workdonedate" /></td>
	<td width="135"><bean:write name="work" property="prbleDateCompletion" /></td>
	<td width="135"><bean:write name="work" property="dateOfCompletion" /></td>
	<td width="135"><bean:write name="work" property="expenditure" /></td>
	<td width="135"><bean:write name="work" property="remarks" /></td>
		
 	<td align="center" nowrap><a href="#" onclick="fnEdit(<%=count-2%>)">Edit</a>&nbsp;</td>
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