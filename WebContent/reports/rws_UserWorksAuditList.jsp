<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_admin_authorization_struts.jsp"%>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<% //System.out.println("Entered into the UserAuditEntryList_frm.jsp");%>

<!--<table width=100%>
<tr><td align=right>
	<html:link page="/reports/rws_UserWorkAudit_frm.jsp">Back&nbsp;|&nbsp;</html:link>
    <a href="#" onclick="window.history.forward();">Back&nbsp;|&nbsp;</a>
    <a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
</tr>
</table>

--><%

String reqFromDate = (String)request.getParameter("reqFromDate");
String reqToDate = (String)request.getParameter("reqToDate");
String reqOfcCode = (String)request.getParameter("reqOfcCode");
String reqLevel = (String) request.getParameter("reqLevel");
%>

<table  width=100%   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#ffffff">Progress Report Accessed Logs
......</font></B><font color="#FFFFFF"> <small>from <%=reqFromDate%><small> to </small><%=reqToDate%>

</small></font></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width=100% border=1 style="border-collapse:collapse" >

<tr>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.sno" /></font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Circle</font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Division</font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Sub Division</font></FONT></td> 
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Access Date</font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Access Time</font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Browser</font></FONT></td>
	
</tr>

<%
	Connection conn2 = RwsOffices.getConn();
	String query2 = "";
	
	
	if (reqFromDate.equals(reqToDate))
	{
		if(reqLevel.equals("circle"))
		{
			query2 = "select c.CIRCLE_OFFICE_NAME,a.user_id,to_char(a.access_date,'dd/mm/yyyy') as access_date,a.access_time,a.page,a.browser,b.office_code "
				+"from rws_log_tbl a,rws_password_tbl b,rws_circle_office_tbl c "
				+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')= to_date('"+reqFromDate+"','dd/mm/yyyy') "
				+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code='"+reqOfcCode+"' and "
				+"SUBSTR(b.office_code,2,2)=c.circle_office_code";
		}
		if(reqLevel.equals("div"))
		{
			query2 = "select c.CIRCLE_OFFICE_NAME,d.DIVISION_OFFICE_NAME,a.user_id,to_char(a.access_date,'dd/mm/yyyy') as access_date,a.access_time,a.page,a.browser,b.office_code "
				+"from rws_log_tbl a,rws_password_tbl b,rws_circle_office_tbl c, rws_division_office_tbl d "
				+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')= to_date('"+reqFromDate+"','dd/mm/yyyy') "
				+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code='"+reqOfcCode+"' and "
				+"SUBSTR(b.office_code,2,2)=c.circle_office_code and SUBSTR(b.office_code,4,1) = d.DIVISION_OFFICE_CODE "
				+"and d.circle_office_code=c.circle_office_code";
		}
		if(reqLevel.equals("subdiv"))
		{
			query2 = "select c.CIRCLE_OFFICE_NAME,d.DIVISION_OFFICE_NAME,e.SUBDIVISION_OFFICE_NAME,a.user_id,to_char(a.access_date,'dd/mm/yyyy') as access_date,a.access_time,a.page,a.browser,b.office_code "
				+"from rws_log_tbl a,rws_password_tbl b,rws_circle_office_tbl c, rws_division_office_tbl d, rws_subdivision_office_tbl e "
				+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')= to_date('"+reqFromDate+"','dd/mm/yyyy') "
				+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code='"+reqOfcCode+"' and "
				+"SUBSTR(b.office_code,2,2)=c.circle_office_code and SUBSTR(b.office_code,4,1) = d.DIVISION_OFFICE_CODE "
				+"and d.circle_office_code=c.circle_office_code and SUBSTR(b.office_code,5,2) = e.SUBDIVISION_OFFICE_CODE "
				+"and e.circle_office_code=c.circle_office_code and d.division_office_code=e.division_office_code";
		}		
	}
	else
	{
		
		if(reqLevel.equals("circle"))
		{
			query2 = "select c.CIRCLE_OFFICE_NAME,a.user_id,to_char(a.access_date,'dd/mm/yyyy') as access_date,a.access_time,a.page,a.browser,b.office_code "
				+"from rws_log_tbl a,rws_password_tbl b,rws_circle_office_tbl c "
				+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')>= to_date('"+reqFromDate+"','dd/mm/yyyy') "
				+"and to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('"+reqToDate+"','dd/mm/yyyy') "
				+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code='"+reqOfcCode+"' and "
				+"SUBSTR(b.office_code,2,2)=c.circle_office_code";		
		}
		if(reqLevel.equals("div"))
		{
			query2 = "select c.CIRCLE_OFFICE_NAME,d.DIVISION_OFFICE_NAME,a.user_id,to_char(a.access_date,'dd/mm/yyyy') as access_date,a.access_time,a.page,a.browser,b.office_code "
				+"from rws_log_tbl a,rws_password_tbl b,rws_circle_office_tbl c, rws_division_office_tbl d "
				+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')>= to_date('"+reqFromDate+"','dd/mm/yyyy') "
				+"and to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('"+reqToDate+"','dd/mm/yyyy') "
				+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code='"+reqOfcCode+"' and "
				+"SUBSTR(b.office_code,2,2)=c.circle_office_code and SUBSTR(b.office_code,4,1) = d.DIVISION_OFFICE_CODE "
				+"and d.circle_office_code=c.circle_office_code";		
		}
		if(reqLevel.equals("subdiv"))
		{
			query2 = "select c.CIRCLE_OFFICE_NAME,d.DIVISION_OFFICE_NAME,e.SUBDIVISION_OFFICE_NAME,a.user_id,to_char(a.access_date,'dd/mm/yyyy') as access_date,a.access_time,a.page,a.browser,b.office_code "
				+"from rws_log_tbl a,rws_password_tbl b,rws_circle_office_tbl c, rws_division_office_tbl d, rws_subdivision_office_tbl e "
				+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')>= to_date('"+reqFromDate+"','dd/mm/yyyy') "
				+"and to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('"+reqToDate+"','dd/mm/yyyy') "
				+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code='"+reqOfcCode+"' and "
				+"SUBSTR(b.office_code,2,2)=c.circle_office_code and SUBSTR(b.office_code,4,1) = d.DIVISION_OFFICE_CODE "
				+"and d.circle_office_code=c.circle_office_code and SUBSTR(b.office_code,5,2) = e.SUBDIVISION_OFFICE_CODE "
				+"and e.circle_office_code=c.circle_office_code and d.division_office_code=e.division_office_code";		
		}
	}
	
	System.out.println("************query: "+query2);
	
	Statement stmt1 = conn2.createStatement();
	ResultSet rs1 = stmt1.executeQuery(query2);
	//PreparedStatement pst1 = conn2.prepareStatement(query2);
	//pst1.setString(1,request.getParameter("reqFromDate"));
	//pst1.setString(2,request.getParameter("reqToDate"));
	//ResultSet rs1 = pst1.executeQuery();
	int count=0;
	while(rs1.next())
	{
		count++;
	%>
		<tr align="center" >
		<td align="center" class="bwborder"><%= count%></td>
		<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("CIRCLE_OFFICE_NAME") %></FONT></td>
		<%
			if(reqLevel.equals("circle"))
			{
				%>
					<td align="center" class="bwborder"> - </td>
					<td align="center" class="bwborder"> - </td>
				<%
			}
			if(reqLevel.equals("div"))
			{
				%>
					<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("DIVISION_OFFICE_NAME") %></FONT></td>
					<td align="center" class="bwborder"> - </td>
				<%
			}
			if(reqLevel.equals("subdiv"))
			{
				%>
					<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("DIVISION_OFFICE_NAME") %></FONT></td>
					<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("SUBDIVISION_OFFICE_NAME") %></FONT></td>
				<%
			}
		%>
		<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("access_date") %></FONT></td> 
		<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("access_time") %></FONT></td>
		<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("browser") %></FONT></td>
		</tr>
	<%
		
	}
	if(count==0)
	{
		%>
		<tr><td align="center" colspan="8" class=myfontclr1><B><font class=myfontclr1>No Records To Display</font></B></td>
		<%
	}
%>

</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>