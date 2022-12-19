<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%String userid=(String) session.getAttribute("userId"); %>
<script language="javascript">
var newWindow;
function openEditWindow(dcode,mcode,pcode,vcode,habCode,vol)
{
     var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
      var url = "/pred/smsmobile/TVM.do?mode=edit&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode+"&vcode="+vcode+"&habCode="+habCode+"&volunteer="+vol;
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
	 var url = "/pred/smsmobile/TVM.do?mode=excelView&dcode="+"<%= request.getAttribute("selectedDistrictCode")%>"+"&mcode="+"<%= request.getAttribute("selectedMandalCode")%>"+"&pcode="+"<%= request.getAttribute("selectedPanchayatCode")%>"+"&acode="+"&vcode="+"<%= request.getAttribute("selectedVillageCode")%>"+"&dname="+"<%= request.getAttribute("selectedDistrictName")%>"+"&mname="+"<%= request.getAttribute("selectedMandalName")%>"+"&pname="+"<%= request.getAttribute("selectedPanchayatName")%>"+"&vname="+"<%= request.getAttribute("selectedVillageName")%>";
	 var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=yes,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
}

</script>
<html:form action="/TVM.do">
<html:hidden property="init" value="false"/>
<table width="100%">
<tr>
<td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>  
<!-- <A HREF="switch.do?prefix=/smsmobile&page=/TVM.do">Back&nbsp;|&nbsp;</A> -->
<!-- <td align=right><A HREF="switch.do?prefix=/smsmobile&page=/TVM.do">Back&nbsp;|&nbsp;</A> -->
<a href="<rws:context page='/home.jsp'/>">Home&nbsp; |&nbsp;</a>
<a href="#1" onclick="openExcelWindow();">Excel&nbsp;</a>&nbsp;
</td>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td align="center"><B><font color="#FFFFFF">Habitation Tanker Volunteer Mapping List</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>
<td colspan="20" class="clrborder">
<% 
if(request.getAttribute("selectedDistrict")!=null)%>
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
	<td  class="clrborder" align=center>Tanker Reg.No</td>
	<td  class="clrborder" align=center>Volunteer Name</td>
	<td  class="clrborder" align=center>Volunteer Mobile</td>
	<td  class="clrborder" align=center ><bean:message key="app.op" /></td>
</tr>
<% int count=0;%>
<%-- <%
     session.getAttribute("habitationDetails") ;

%> --%>
<logic:empty name="habitationDetails"> 
	 <table>
		 <tr><td><h3 style="color: blue;">No data found</h3></td></tr>
	</table>
</logic:empty>
<logic:iterate id="habitationList" name="habitationDetails">
<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
<%if(request.getAttribute("selectedPanchayatCode").equals(""))
{%>
<td  class="bwborder">&nbsp;<bean:write name="habitationList" property="pcode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="pname" /></td>
<%} %>
<%if(request.getAttribute("selectedVillageCode").equals(""))
	{%>
<td  class="bwborder">&nbsp;<bean:write name="habitationList" property="vcode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="vname" /></td>
<%} %>
<td  class="bwborder">&nbsp;<bean:write name="habitationList" property="habCode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="habName" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="tRegno" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="volName" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="volMobile" /></td>
<td  class="bwborder" nowrap align="center">
   <%if(request.getAttribute("selectedPanchayatCode").equals(""))
	{%> 
  <a href="#1" onclick="openEditWindow('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<bean:write name='habitationList' property='pcode' />','<bean:write name='habitationList' property='vcode' />','<bean:write name='habitationList' property='habCode' />','<bean:write name='habitationList' property='volMobile' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>&nbsp;
  <%-- <a href="#1" onclick="fnDelete('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedConstituencyCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<%= request.getAttribute("selectedPanchayatCode") %>','<%= request.getAttribute("selectedVillageCode") %>','<bean:write name='habitationList' property='habCode' />');toggleColor(this) " style="color:blue">Delete&nbsp;</a>&nbsp; --%>
   <%} %>
  <%if(!request.getAttribute("selectedPanchayatCode").equals("") && request.getAttribute("selectedVillageCode").equals(""))
	{%>
  <a href="#1" onclick="openEditWindow('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<%= request.getAttribute("selectedPanchayatCode") %>','<bean:write name='habitationList' property='vcode' />','<bean:write name='habitationList' property='habCode' />','<bean:write name='habitationList' property='volMobile' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>&nbsp;
<%--   <a href="#1" onclick="fnDelete('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedConstituencyCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<%= request.getAttribute("selectedPanchayatCode") %>','<%= request.getAttribute("selectedVillageCode") %>','<bean:write name='habitationList' property='habCode' />');toggleColor(this) " style="color:blue">Delete&nbsp;</a>&nbsp;
 --%>  <%} %>
  <%if(!request.getAttribute("selectedPanchayatCode").equals("") && !request.getAttribute("selectedVillageCode").equals(""))
	{%>
  <a href="#1" onclick="openEditWindow('<%= request.getAttribute("selectedDistrictCode") %>','<%= request.getAttribute("selectedMandalCode") %>','<%= request.getAttribute("selectedPanchayatCode") %>','<%= request.getAttribute("selectedVillageCode") %>','<bean:write name='habitationList' property='habCode' />','<bean:write name='habitationList' property='volMobile' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>
  <%} %> 
</td>
</tr>
</logic:iterate>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

