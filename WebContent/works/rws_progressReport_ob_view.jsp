<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
var newWindow;
function openEditWindow(dcode,divcode,programmeCode,financialYear,openingBalance,closingBalance)
{

	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));

	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
			alert("Record cannot be edited. You do not have sufficient previlages");
			return;
	}
	
	 var url = "/pred/works/ProgressReportOBEntry.do?mode=editOpeningBalance&district="+dcode+"&division="+divcode+"&programme="+programmeCode+"&financialYear="+financialYear+"&openingBalance="+openingBalance+"&closingBalance="+closingBalance;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	 newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
	 newWindow.focus();
	
}
function openExcelWindow()
{

	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));

	 var url = "/pred/masters/Habitation.do?mode=excelView&dcode="+"<%= request.getAttribute("selectedDistrictCode")%>"+"&mcode="+"<%= request.getAttribute("selectedMandalCode")%>"+"&pcode="+"<%= request.getAttribute("selectedPanchayatCode")%>"+"&acode="+"<%= request.getAttribute("selectedConstituencyCode")%>"+"&vcode="+"<%= request.getAttribute("selectedVillageCode")%>"+"&dname="+"<%= request.getAttribute("selectedDistrictName")%>"+"&mname="+"<%= request.getAttribute("selectedMandalName")%>"+"&pname="+"<%= request.getAttribute("selectedPanchayatName")%>"+"&acode="+"<%= request.getAttribute("selectedConstituencyName")%>"+"&vname="+"<%= request.getAttribute("selectedVillageName")%>";
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=yes,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function fnDelete(dcode,divcode,programmeCode,financialYear)
{
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
			alert("Record cannot be deleted. You do not have sufficient previlages");
			return;
	}
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="/pred/works/ProgressReportOBEntry.do?mode=deleteOpeningBalance&district="+dcode+"&division="+divcode+"&programme="+programmeCode+"&financialYear="+financialYear;
		document.forms[0].submit();
	}
}





</script>
<html:form action="/ProgressReportOBEntry">
<html:hidden property="init" value="false"/>
<table width="100%">

<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp; |&nbsp;
</td>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td ><B><font color="#FFFFFF">Opening Balances</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>
    <td  class="clrborder" align=left>Sl.No
	<td  class="clrborder" align=center>District</td>
	<td  class="clrborder" align=center>Division</td>
	<td  class="clrborder" align=center>Programme</td>
	<td  class="clrborder" align=center>Financial Year</td>
	<td  class="clrborder" align=center>Opening Balance</td>
	<td  class="clrborder" align=center>Closing balance</td>
	
</tr>

<% int count=0;%>
<logic:iterate id="openingBalances" name="openingBalancesList">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
<td><bean:write name="openingBalances" property="dname" /></td>
<td><bean:write name="openingBalances" property="divisionName" /></td>
<td><bean:write name="openingBalances" property="programmeName" /></td>
<td><bean:write name="openingBalances" property="financialYear" /></td>
<td><bean:write name="openingBalances" property="openingBalance" /></td>
<td><bean:write name="openingBalances" property="closingBalance" /></td>
<td  class="bwborder" nowrap align="center">
  <a href="#1" onclick="openEditWindow('<bean:write name="openingBalances" property="district" />','<bean:write name="openingBalances" property="division" />','<bean:write name="openingBalances" property="programmeCode" />','<bean:write name="openingBalances" property="financialYear" />','<bean:write name="openingBalances" property="openingBalance" />','<bean:write name="openingBalances" property="closingBalance" />')" style="color:blue">Edit&nbsp;</a>|&nbsp;
  <a href="#1" onclick="fnDelete('<bean:write name="openingBalances" property="district" />','<bean:write name="openingBalances" property="division" />','<bean:write name="openingBalances" property="programmeCode" />','<bean:write name="openingBalances" property="financialYear" />')" style="color:blue">Delete&nbsp;</a>&nbsp;
</td> 

</tr>
</logic:iterate>

<%if(count==0){ %>
<tr><td colspan="6" align="center">No Records</td></tr>
<%} %>


</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>


