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
	 
	var ad='<%=(String) session.getAttribute("userId")%>';
	if(ad!="admin"  && ad!="100000" && ad.substring(ad.length-3) != "000")
	{
		//if(dcode=="14" )
		//{
			alert("Record cannot be edited as it has been freezed");
			return;
		//}
	}
	
	 var url = "/pred/masters/Panchayat.do?mode=panchayatEdit&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode;
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
	 
	 var dcode=document.forms[0].dcode[0].value;
	 var mcode=document.forms[0].mcode[0].value;
	 
	 var url = "/pred/masters/Panchayat.do?mode=excelView&dcode="+dcode+"&mcode="+mcode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=yes,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function fnDelete(dcode,mcode,pcode)
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
}
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
<html:form action="/Panchayat.do">
	<html:hidden property="init" value="false" />
	<table width="100%">

		<tr>
			<td align=right><A
				HREF="switch.do?prefix=/masters&page=/Panchayat.do">Back&nbsp;|&nbsp;</A>
				<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp<a
				href="#1" onclick="openExcelWindow()">Excel</a></td>
		</tr>
	</table>
	<table width="55%" bgcolor="#8A9FCD">
		<tr>
			<td class=myfontclr><B><font color="#FFFFFF">Panchayat
						List</font></B></td>
	</table>
	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="55%" border=1
		style="border-collapse: collapse">
		<tr>
			<td colspan="20" class="clrborder">
				<%
					if (request.getAttribute("selectedDistrict") != null)
				%> District Name:
				<%=request.getAttribute("selectedDistrict")%>&nbsp;&nbsp;&nbsp; <%
 	if (request.getAttribute("selectedMandal") != null)
 %>
 				Mandal Name: <%=request.getAttribute("selectedMandal")%>
			</td>

		</tr>
		<tr>
			<td class="clrborder" align=left>Sl.No
			<td class="clrborder" align=center>Panchayat Code</td>
			<td class="clrborder" align=center>Panchayat Name</td>
		<%if(userid.equals(Constants.ADMIN) || userid.equals(Constants.LAKH_USER)) {%>
			<td class="clrborder" align=center><bean:message key="app.op" /></td>
			<%} %>
		</tr>

		<%
			int count = 0;
		%>
		<logic:iterate id="panchayatList" name="panchayatDetails">

			<%
				count = count + 1;
			%>
			<tr align="left" id='tr<%=count%>'
				onmouseover="this.style.background='#E3E4FA'"
				onmouseout="this.style.background='WHITE'">
				<td class="bwborder"><%=count%></td>
				<td><bean:write name="panchayatList" property="pcode" /></td>
				<td class="bwborder" align=left><bean:write
						name="panchayatList" property="pname" /></td>
				<%if(userid.equals(Constants.ADMIN) || userid.equals(Constants.LAKH_USER)||(userid.length()==6 && (userid.substring(userid.length()-3).equals("000") ))) {%>
				<td class="bwborder" nowrap align="center"><a href="./switch.do?prefix=/masters&page=/Panchayat.do?mode=panchayatEdit&dcode=<bean:write name='panchayatList' property='dcode' />&mcode=<bean:write name='panchayatList' property='mcode' />&pcode=<bean:write name='panchayatList' property='pcode' /> "
					style="color: blue">Edit&nbsp;</a> <input type="hidden"
					name="dcode"
					value='<bean:write name='panchayatList' property='dcode' />'>
					<input type="hidden" name="mcode"
					value='<bean:write name='panchayatList' property='mcode' />'>


				</td>
				
				<%} %>
			</tr>
		</logic:iterate>

	</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

