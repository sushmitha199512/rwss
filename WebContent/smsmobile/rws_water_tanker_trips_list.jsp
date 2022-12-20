<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%String userid=(String) session.getAttribute("userId"); %>
<html:form action="/tankerTrips.do">
	<html:hidden property="init" value="false" />
	<table width="55%">
		<tr>
			<td align=right><a href="switch.do?prefix=/smsmobile&page=/tankerTrips.do&mode=data&special=reset">Back&nbsp;|&nbsp;</A>
				<a href="<rws:context page='/home.jsp'/>">Home</a></td>
		</tr>
	</table>
	<table width="55%" bgcolor="#8A9FCD">
		<tr>
			<td class=myfontclr><B><font color="#FFFFFF">Target Number of Trips List</font></B></td>
	</table>
	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="55%" border=1
		style="border-collapse: collapse">
		<tr>
			<td colspan="20" class="clrborder">
				 District Name:
				<bean:write name="tankerTripsForm" property="districtName" /> &nbsp;&nbsp;&nbsp;
 				Mandal Name: <bean:write name="tankerTripsForm" property="mandalName" />
			</td>
		</tr>
		<tr>
			<td class="clrborder" align=left>Sl.No
			<td class="clrborder" align=center>Habitation Code</td>
			<td class="clrborder" align=center>Habitation Name</td>
			<td class="clrborder" align=center>No. of Trips</td>
			<td class="clrborder" align=center>Date</td>
			<td class="clrborder" align=center>Action</td>
		</tr>
		<%
			int count = 0;
		%>
		<logic:iterate id="tankerTripsList" name="tankerTripsForm" property="tankerTripDetails">
			<%
				count = count + 1;
			%>
			<tr align="left" id='tr<%=count%>'	onmouseover="this.style.background='#E3E4FA'"	onmouseout="this.style.background='WHITE'">
					<td class="bwborder"><%=count%></td>
					<td class="bwborder"><bean:write name="tankerTripsList" property="habCode" /></td>
				  	<td class="bwborder"><bean:write name="tankerTripsList" property="habName" /></td>
				    <td class="bwborder"><bean:write name="tankerTripsList" property="noOfTrips" /></td>
				    <td class="bwborder"><bean:write name="tankerTripsList" property="date" /></td>
				   	<td class="bwborder" nowrap align="center">
				   		<a href="./switch.do?prefix=/smsmobile&page=/tankerTrips.do?mode=get&habCode=<bean:write name='tankerTripsList' property='habCode' />"	style="color: blue">Edit&nbsp;</a> 
					</td>			
			</tr>
		</logic:iterate>
	</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

