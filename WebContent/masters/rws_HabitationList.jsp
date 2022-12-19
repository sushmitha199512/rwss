<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%String userid=(String) session.getAttribute("userId"); %>
<script language="javascript">
var newWindow;
function openEditWindow(dcode,acode,mcode,pcode,vcode,habCode,habName)
{

	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));

	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin"  && ad!="100000" && ad.substring(ad.length-3) != "000")
	{
		//if(dcode=="14" )
		//{
			alert("Record cannot be edited as it has been freezed");
			return;
		//}
	}
	
	 var url = "/pred/masters/Habitation.do?mode=habitationEdit&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode+"&acode="+acode+"&vcode="+vcode+"&habCode="+habCode;
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
function fnDelete(dcode,dname,acode,aname,mcode,mname,pcode,pname,vcode,vname,habCode,habName)
{
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
			alert("Record cannot be deleted as it has been freezed");
			return;
	}
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="/pred/masters/Habitation.do?mode=delete&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode+"&acode="+acode+"&vcode="+vcode+"&habCode="+habCode+"&districtName="+dname+"&constituencyName="+aname+"&mandalName="+mname+"&panchayatName="+pname+"&villageName="+vname+"&habName="+habName;
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
that.style.color="blue";

}



</script>
<html:form action="/Habitation.do">
<html:hidden property="init" value="false"/>
<table width="100%">

<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp; |&nbsp;
<a href="#1" onclick="openExcelWindow('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedConstituencyCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<%= request.getAttribute("selectedPanchayatCode") %>','<%= request.getAttribute("selectedVillageCode") %>');">Excel&nbsp;</a>&nbsp;
</td>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td ><B><font color="#FFFFFF">Habitation List</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>
<td colspan="20" class="clrborder">
<%if(request.getAttribute("selectedDistrict")!=null)%>
District Code: <%= request.getAttribute("selectedDistrictCode") %>&nbsp;&nbsp;&nbsp;
District Name: <%= request.getAttribute("selectedDistrictName") %>&nbsp;&nbsp;&nbsp;

Mandal Code: <%= request.
getAttribute("selectedMandalCode") %>&nbsp;&nbsp;&nbsp;
Mandal Name: <%= request.getAttribute("selectedMandalName") %>&nbsp;&nbsp;&nbsp;
<%if(!request.getAttribute("selectedPanchayatCode").equals(""))
{%>
Panchayat Code: <%= request.getAttribute("selectedPanchayatCode") %>&nbsp;&nbsp;&nbsp;
Panchayat Name: <%= request.getAttribute("selectedPanchayatName") %>&nbsp;&nbsp;&nbsp;
<%} %>
<%if(!request.getAttribute("selectedVillageCode").equals(""))
{%>
Village Code: <%= request.getAttribute("selectedVillageCode") %>&nbsp;&nbsp;&nbsp;
Village Name: <%= request.getAttribute("selectedVillageName") %>&nbsp;&nbsp;&nbsp;
<%} %>

</td>
</tr>

<tr>
    <td  class="clrborder" align=left>Sl.No
	<%if(request.getAttribute("selectedPanchayatCode").equals(""))
	{%>
	<td  class="clrborder" align=center>Panchayat Code</td>
	<td  class="clrborder" align=center>Panchayat Name</td>
	<%}%>
	<%if(request.getAttribute("selectedVillageCode").equals(""))
	{%>
	<td  class="clrborder" align=center>Village Code</td>
	<td  class="clrborder" align=center>Village Name</td>
	<%} %>
	<td  class="clrborder" align=center>Habitation Code</td>
	<td  class="clrborder" align=center>Habitation Name</td>
	<%if(userid.equals(Constants.ADMIN) || userid.equals(Constants.LAKH_USER)||(userid.length()==6 && (userid.substring(userid.length()-3).equals("000") ))) {%>
	<td  class="clrborder" align=center ><bean:message key="app.op" /></td>
	<%} %>
</tr>

<% int count=0;%>
<logic:iterate id="habitationList" name="habitationDetails">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
<%if(request.getAttribute("selectedPanchayatCode").equals(""))
{%>
<td>&nbsp;<bean:write name="habitationList" property="pcode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="pname" /></td>
<%} %>
<%if(request.getAttribute("selectedVillageCode").equals(""))
	{%>
<td>&nbsp;<bean:write name="habitationList" property="vcode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="vname" /></td>
<%} %>
<td>&nbsp;<bean:write name="habitationList" property="habCode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="habName" /></td>
<%if(userid.equals(Constants.ADMIN) || userid.equals(Constants.LAKH_USER)||(userid.length()==6 && (userid.substring(userid.length()-3).equals("000") ))) {%>
<td  class="bwborder" nowrap align="center">

  <%if(request.getAttribute("selectedPanchayatCode").equals(""))
	{%>
  <a href="#1" onclick="openEditWindow('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedConstituencyCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<bean:write name='habitationList' property='pcode' />','<bean:write name='habitationList' property='vcode' />','<bean:write name='habitationList' property='habCode' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>&nbsp;
  <%-- <a href="#1" onclick="fnDelete('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedConstituencyCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<%= request.getAttribute("selectedPanchayatCode") %>','<%= request.getAttribute("selectedVillageCode") %>','<bean:write name='habitationList' property='habCode' />');toggleColor(this) " style="color:blue">Delete&nbsp;</a>&nbsp; --%>
  <%} %>
  <%if(!request.getAttribute("selectedPanchayatCode").equals("") && request.getAttribute("selectedVillageCode").equals(""))
	{%>
  <a href="#1" onclick="openEditWindow('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedConstituencyCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<%= request.getAttribute("selectedPanchayatCode") %>','<bean:write name='habitationList' property='vcode' />','<bean:write name='habitationList' property='habCode' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>|&nbsp;
 <%--  <a href="#1" onclick="fnDelete('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedConstituencyCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<%= request.getAttribute("selectedPanchayatCode") %>','<%= request.getAttribute("selectedVillageCode") %>','<bean:write name='habitationList' property='habCode' />');toggleColor(this) " style="color:blue">Delete&nbsp;</a>&nbsp; --%>
  <%} %>
  <%if(!request.getAttribute("selectedPanchayatCode").equals("") && !request.getAttribute("selectedVillageCode").equals(""))
	{%>
  <a href="#1" onclick="openEditWindow('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedConstituencyCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<%= request.getAttribute("selectedPanchayatCode") %>','<%= request.getAttribute("selectedVillageCode") %>','<bean:write name='habitationList' property='habCode' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>
  <%} %>

</td>
<%} %>
</tr>
</logic:iterate>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

