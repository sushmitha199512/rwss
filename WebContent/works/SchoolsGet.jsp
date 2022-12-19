<%System.out.println("****************************school get*****************************");%>
<%@page import="nic.watersoft.works.rws_works_WorkStatus_bean"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%@	page import="javax.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>

<% 		
int count = 0;
String workId=request.getParameter("workId");
System.out.println("1");
String a = request.getParameter("habs");
System.out.println("2");
//DataSource ds=getDataSource(request);
WorksData1 worksData = new WorksData1();
System.out.println("3");
ArrayList schoolList = worksData.viewSchoolList(workId,"","","",a);
System.out.println("4");
//
if(schoolList!=null){
System.out.println("ssssss:"+schoolList.size());
	%>
<tr>
<td colspan=2 align=center><b><font size=2 face=verdana color=blue>
<u>Schools List for the Above Selected Habs</u></font><BR>
<font size=2 face=verdana color=red>
Note:** Please Select All the Schools at Once and Click 'Add the Selected School to this Work' button.<BR>
The Selected Schools Only Linked with this Work.
</font></b>
</td>
</tr>

<tr>
<td colspan=2>
<table border="1" cellspacing=0 cellpadding=0 width="740"
						align="center" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
<TR>
	<td class="btext" nowrap align=center>S.No.</TD>
	<td class="btext" nowrap align=center>Select</TD>
	<td class="btext" nowrap align=center>Panchayat</TD>
	<td class="btext" nowrap align=center>Village</TD>
	<td class="btext" nowrap align=center>Habitation</TD>
	<td class="btext" nowrap align=center>Habitation Name</TD>
	<td class="btext" nowrap align=center>School Code</TD>
	<td class="btext" nowrap align=center>School Name</TD>
	<td class="btext" nowrap align=center>Category</TD>
	<td class="btext" nowrap align=center>Classification</TD>
	<td class="btext" nowrap align=center>Total Students</TD>
</TR>
<%
for(int i=0;i<schoolList.size();i++)
{
	rws_works_WorkStatus_bean rs = (rws_works_WorkStatus_bean)schoolList.get(i);%>
<tr  onclick="toggleRowColor(this)">
<td class="bwborder" align="center"><%= ++count %></td>
		 <TD class="bwborder" align="center">
		 <%if(rs.getAlreadyExists()!=null && rs.getAlreadyExists().equals("Y")){%>
				<input type="checkbox" name="school"  value="<%=rs.getSchoolHabCode()%>" checked="true"/>
				<%}else{%>
				<input type="checkbox" name="school"  value="<%=rs.getSchoolHabCode()%>"/>
				<%}%>
		 </TD>
		
		<td class="bwborder" align="left" nowrap><%=rs.getPanchayat()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getVillage()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getHabitation()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getHabName()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getSchoolCode()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getSchoolName()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getCategory()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getClassification()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getTotStudents()%></td>
</tr>
<%}%>	
</TABLE>
</td>
</tr>
<%}%>
<input type="hidden" name="resultCount" value="<%=--count%>">
