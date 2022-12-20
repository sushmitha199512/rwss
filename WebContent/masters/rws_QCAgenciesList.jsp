<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%String userid=(String) session.getAttribute("userId"); %>
<script language="javascript">
var newWindow;
function openEditWindow(dcode,mcode,pcode)
{
	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 var vagencycode=document.forms[0].agencycode.value; 
	 var vagencyname=document.forms[0].agencyname.value;
	var ad='<%=(String) session.getAttribute("userId")%>';
	if(ad!="admin"  && ad!="100000" && ad.substring(ad.length-3) != "000")
	{
		//if(dcode=="14" )
		//{
			alert("Record cannot be edited as it has been freezed");
			return;
		//}
	}
	
	 var url = "/pred/masters/qcagency.do?mode=QCAgencyEdit&agecode="+vagencycode+"&agename="+vagencyname;
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
	 var vagencycode=document.forms[0].agencycode.value;
	 var vagencyname=document.forms[0].agencyname.value;
	 var url = "/pred/masters/qcagency.do?mode=excelView&agecode="+vagencycode+"&agename="+vagencyname;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=yes,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		_New.close();
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
}
 
 function fnDelete(agentCode)
	{
	  if(confirm("Do You Want To Delete The Selected Record"))
	   {
		document.forms[0].action="switch.do?prefix=/masters&page=/qcagency.do?mode=delete&agentCode="+agentCode;
		document.forms[0].submit();
	   }
	}
 
<%-- function fnDelete(dcode,mcode,pcode)
{
	var ad='<%=(String) session.getAttribute("userId")%>';
	if(ad!="admin")
	{
			alert("Record cannot be deleted as it has been freezed");
			return;
	}

	if(confirm("Do You Want To Delete The Selected Record"))
	{
	document.forms[0].action="/pred/masters/Panchayat.do?mode=delete&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode;
	document.forms[0].submit();
	}
} --%>
/*
function fnDelete(dcode,mcode,pcode)
{

	 var width = 838;
	 var height = 600;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var url = "/pred/masters/Panchayat.do?mode=delete&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
*/
function toggleColor(that)
{
if(that.style.color=="blue")
	that.style.color="red";
else if(that.style.color=="red")
	that.style.color="blue"
}

</script>
<html:form action="/qcagency.do">
	<html:hidden property="init" value="false" />
	<table width="55%">
		<tr>
			<td align=right><a href="switch.do?prefix=/masters&page=/qcagency.do">Back</a>&nbsp;|&nbsp;
				<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;<a
				href="#1" onclick="openExcelWindow()">Excel</a></td>
		</tr>
	</table>
	<table width="55%" bgcolor="#8A9FCD">
		<tr>
			<td class=myfontclr><B><font color="#FFFFFF">Third Party Quality Control Agencies List</font></B></td></tr>
	</table>
	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="55%" border=1 style="border-collapse: collapse">
		<%-- <tr>
			<td colspan="20" class="clrborder">
				<%
					if (request.getAttribute("selectedDistrict") != null)
				%> District Name:
				<%=request.getAttribute("selectedDistrict")%>&nbsp;&nbsp;&nbsp; <%
 	if (request.getAttribute("selectedMandal") != null)
 %>
 				Mandal Name: <%=request.getAttribute("selectedMandal")%>
			</td>

		</tr> --%>
		<tr>
			<td class="clrborder" align=center>Sl.No</td>
			<td class="clrborder" align=center>Financial Year</td>
			<td class="clrborder" align=center>Agency Code</td>
			<td class="clrborder" align=center>Agency Name</td>
		<%if(userid.equals(Constants.ADMIN) || userid.equals(Constants.LAKH_USER)) {%>
			<td class="clrborder" align=center><bean:message key="app.op" /></td>
			<%} %>
		</tr>

		<%
			int count = 0;
		%>
		<logic:iterate id="qcagencyDetails" name="qcagencyDetails">

			<%
				count = count + 1;
			%>
			<tr align="center" id='tr<%=count%>'
				onmouseover="this.style.background='#E3E4FA'"
				onmouseout="this.style.background='WHITE'">
				<td class="bwborder"><%=count%></td>
				<td  align="left" class="bwborder"><bean:write name="qcagencyDetails" property="finyear" /></td>
				<td  align="left" class="bwborder"><bean:write name="qcagencyDetails" property="agencycode" /></td>
				<td class="bwborder" align=left><bean:write
						name="qcagencyDetails" property="agencyname" /></td>
				<% if(userid.equals(Constants.ADMIN) || userid.equals(Constants.LAKH_USER)||(userid.length()==6 && (userid.substring(userid.length()-3).equals("000") ))) {%>
				<td class="bwborder" nowrap align="center">
				
				<a href="./switch.do?prefix=/masters&page=/qcagency.do?mode=QCAgencyEdit&agencycode=<bean:write name='qcagencyDetails' property='agencycode' />&agencyname=<bean:write name='qcagencyDetails' property='agencyname' />&finyear=<bean:write name='qcagencyDetails' property='finyear' /> "
					style="color: blue">Edit</a><%-- &nbsp;&nbsp;|&nbsp;&nbsp;
					
				<a href="#1"  onclick="fnDelete('<bean:write name='qcagencyDetails' property='agencycode' />')"><font color="#990066">Delete</font></a> --%>
					<input type="hidden" name="agencycode" value='<bean:write name='qcagencyDetails' property='agencycode' />'>
					<input type="hidden" name="agencyname" value='<bean:write name='qcagencyDetails' property='agencyname' />'>
				</td>
				<%} %>
			</tr>
		</logic:iterate>

	</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>