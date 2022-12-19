
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
String workid=request.getParameter("workid");
stmt=conn.createStatement();
%>
<table width="100%">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=rptValue> Work Id:&nbsp;<%=workid%></td></tr></table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse" >

<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Major <BR>Mile <BR>Stone <BR>Code</td>
			<td class=btext>Mile Stone Name<BR>(Major Component) </td>
			<td class=btext>Mile Stone Stage Name<BR>(Type of Item)</td>
			<td class=btext>Target Date</td>
			<td class=btext>Achievement Date</td>
			<td class=btext>% of Component to be <br> executed in the MileStone(s)<br> w.r.to total <br>Work Estimate Cost</td>
			<td class=btext>Work- % Achievement <BR>for this Mile <BR>Stone(s) till date</td>
			</tr>

<%
int count=0;
String qry="select milestone_name,milestone_stage_name,to_char(target_date,'dd/mm/yyyy'),to_char(achieve_date,'dd/mm/yyyy'),PERCENT_COMPLETED_WORK,PERCENT_COMPLETED,MAJOR_MILESTONE_CODE,MILESTONE_SLNO from rws_milestone_target_ach_tbl a,rws_milestone_tbl b,rws_milestone_stage_tbl c where a.milestone_code=b.milestone_code and b.milestone_code=c.milestone_code and a.milestone_stage_code=c.milestone_stage_code and work_id='"+workid+"' order by MAJOR_MILESTONE_CODE,MILESTONE_SLNO";
rs=stmt.executeQuery(qry);
while(rs.next())
{ %>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue align="center"><%=rs.getString("MAJOR_MILESTONE_CODE")%></td>
<!-- <td class=rptValue><%=rs.getString("MILESTONE_SLNO")%></td> -->
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<%if(rs.getString(4)!=null && !rs.getString(4).equals("")){%>
<td class=rptValue><%=rs.getString(4)%></td>
<%}else {%> <td class=rptValue>-</td><%}
if(rs.getString(5)!=null && !rs.getString(5).equals("")){%>
<td class=rptValue><%=rs.getString(5)%></td>
<%}else {%> <td class=rptValue>-</td><%}
if(rs.getString(6)!=null && !rs.getString(6).equals("")){%>
<td class=rptValue><%=rs.getString(6)%></td>
<%}else {%> <td class=rptValue>-</td><%}%>
</tr>
<% } 
%>
</table>