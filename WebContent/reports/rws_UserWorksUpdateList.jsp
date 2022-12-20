<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_admin_authorization_struts.jsp"%>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>

<%

String reqFromDate = (String)request.getParameter("reqFromDate");
String reqToDate = (String)request.getParameter("reqToDate");
String reqOfcCode = (String)request.getParameter("reqOfcCode");
String reqLevel = (String) request.getParameter("reqLevel");
%>

<table  width=100%   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#ffffff">Updated Work Details......</font></B><font color="#FFFFFF"> <small>from <%=reqFromDate%><small> to </small><%=reqToDate%>

</small></font></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width=100% border=1 style="border-collapse:collapse" >

<tr>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.sno" /></font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">District</font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Mandal</font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Habitation</font></FONT></td> 
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Work Id</font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Work Name</font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">No. of Habitations</font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Sanction Amount (in Lakhs)</font></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Update Date</font></FONT></td>
	
</tr>

<%
	Connection conn2 = RwsOffices.getConn();
	String query2 = "";
	String query22 = "";
	
	
	if (reqFromDate.equals(reqToDate))
	{
		if(reqLevel.equals("circle"))
		{
			query2 = "select dist.dname,mdl.mname,hab.panch_name,wi.work_id,wa.WORK_NAME,wa.NO_OF_HABS,wa.SANCTION_AMOUNT,to_char(wi.update_date,'dd/mm/yyyy') as update_date "
				+"from rws_work_admn_tbl wa, rws_work_image_tbl wi, rws_district_tbl dist, rws_mandal_tbl mdl, rws_mandal_subdivision_tbl ms,rws_panchayat_raj_tbl hab "
				+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')= to_date('"+reqFromDate+"','dd/mm/yyyy') and dist.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) "
				+"and wa.LEAD_HABITATION=hab.panch_code and mdl.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and mdl.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and wa.work_id = wi.work_id "
				+"and ms.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and ms.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and ms.CIRCLE_OFFICE_CODE='"+reqOfcCode.substring(1,3)+"' order by update_date desc";
		}
		if(reqLevel.equals("div"))
		{
			query2 = "select dist.dname,mdl.mname,hab.panch_name,wi.work_id,wa.WORK_NAME,wa.NO_OF_HABS,wa.SANCTION_AMOUNT,to_char(wi.update_date,'dd/mm/yyyy') as update_date "
				+"from rws_work_admn_tbl wa, rws_work_image_tbl wi, rws_district_tbl dist, rws_mandal_tbl mdl, rws_mandal_subdivision_tbl ms,rws_panchayat_raj_tbl hab "
				+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')= to_date('"+reqFromDate+"','dd/mm/yyyy') and dist.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) "
				+"and wa.LEAD_HABITATION=hab.panch_code and mdl.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and mdl.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and wa.work_id = wi.work_id "
				+"and ms.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and ms.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and ms.CIRCLE_OFFICE_CODE='"+reqOfcCode.substring(1,3)+"' and "
				+"ms.DIVISION_OFFICE_CODE='"+reqOfcCode.substring(3,4)+"' order by update_date desc";
		}
		if(reqLevel.equals("subdiv"))
		{
			query2 = "select dist.dname,mdl.mname,hab.panch_name,wi.work_id,wa.WORK_NAME,wa.NO_OF_HABS,wa.SANCTION_AMOUNT,to_char(wi.update_date,'dd/mm/yyyy') as update_date "
				+"from rws_work_admn_tbl wa, rws_work_image_tbl wi, rws_district_tbl dist, rws_mandal_tbl mdl, rws_mandal_subdivision_tbl ms,rws_panchayat_raj_tbl hab "
				+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')= to_date('"+reqFromDate+"','dd/mm/yyyy') and dist.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) "
				+"and wa.LEAD_HABITATION=hab.panch_code and mdl.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and mdl.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and wa.work_id = wi.work_id "
				+"and ms.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and ms.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and ms.CIRCLE_OFFICE_CODE='"+reqOfcCode.substring(1,3)+"' and "
				+"ms.DIVISION_OFFICE_CODE='"+reqOfcCode.substring(3,4)+"' and ms.SUBDIVISION_OFFICE_CODE='"+reqOfcCode.substring(4,6)+"' order by update_date desc";
		}		
	}
	else
	{
		
		if(reqLevel.equals("circle"))
		{
			
			query2 = "select dist.dname,mdl.mname,hab.panch_name,wi.work_id,wa.WORK_NAME,wa.NO_OF_HABS,wa.SANCTION_AMOUNT,to_char(wi.update_date,'dd/mm/yyyy') as update_date "
				+"from rws_work_admn_tbl wa, rws_work_image_tbl wi, rws_district_tbl dist, rws_mandal_tbl mdl, rws_mandal_subdivision_tbl ms,rws_panchayat_raj_tbl hab "
				+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')>= to_date('"+reqFromDate+"','dd/mm/yyyy') and dist.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) "
				+"and to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')<= to_date('"+reqToDate+"','dd/mm/yyyy') "
				+"and wa.LEAD_HABITATION=hab.panch_code and mdl.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and mdl.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and wa.work_id = wi.work_id "
				+"and ms.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and ms.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and ms.CIRCLE_OFFICE_CODE='"+reqOfcCode.substring(1,3)+"' order by update_date desc";	
		}
		if(reqLevel.equals("div"))
		{
			query2 = "select dist.dname,mdl.mname,hab.panch_name,wi.work_id,wa.WORK_NAME,wa.NO_OF_HABS,wa.SANCTION_AMOUNT,to_char(wi.update_date,'dd/mm/yyyy') as update_date "
				+"from rws_work_admn_tbl wa, rws_work_image_tbl wi, rws_district_tbl dist, rws_mandal_tbl mdl, rws_mandal_subdivision_tbl ms,rws_panchayat_raj_tbl hab "
				+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')>= to_date('"+reqFromDate+"','dd/mm/yyyy') and dist.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) "
				+"and to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')<= to_date('"+reqToDate+"','dd/mm/yyyy') "
				+"and wa.LEAD_HABITATION=hab.panch_code and mdl.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and mdl.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and wa.work_id = wi.work_id "
				+"and ms.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and ms.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and ms.CIRCLE_OFFICE_CODE='"+reqOfcCode.substring(1,3)+"' and "
				+"ms.DIVISION_OFFICE_CODE='"+reqOfcCode.substring(3,4)+"' order by update_date desc";	
		}
		if(reqLevel.equals("subdiv"))
		{
			query2 = "select dist.dname,mdl.mname,hab.panch_name,wi.work_id,wa.WORK_NAME,wa.NO_OF_HABS,wa.SANCTION_AMOUNT,to_char(wi.update_date,'dd/mm/yyyy') as update_date "
				+"from rws_work_admn_tbl wa, rws_work_image_tbl wi, rws_district_tbl dist, rws_mandal_tbl mdl, rws_mandal_subdivision_tbl ms,rws_panchayat_raj_tbl hab "
				+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')>= to_date('"+reqFromDate+"','dd/mm/yyyy') and dist.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) "
				+"and to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')<= to_date('"+reqToDate+"','dd/mm/yyyy') "
				+"and wa.LEAD_HABITATION=hab.panch_code and mdl.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and mdl.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and wa.work_id = wi.work_id "
				+"and ms.dcode=SUBSTR(wa.LEAD_HABITATION,1,2) and ms.mcode=SUBSTR(wa.LEAD_HABITATION,6,2) and ms.CIRCLE_OFFICE_CODE='"+reqOfcCode.substring(1,3)+"' and "
				+"ms.DIVISION_OFFICE_CODE='"+reqOfcCode.substring(3,4)+"' and ms.SUBDIVISION_OFFICE_CODE='"+reqOfcCode.substring(4,6)+"' order by update_date desc";	
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
			<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("dname") %></FONT></td>
			<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("mname") %></FONT></td>
			<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("panch_name") %></FONT></td>
			<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("work_id") %></FONT></td>
			<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("work_name") %></FONT></td>
			<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("NO_OF_HABS") %></FONT></td>
			<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("SANCTION_AMOUNT") %></FONT></td>
			<td  class=mycborder1 align="left"><FONT class=myfontclr1><%=rs1.getString("update_date") %></FONT></td> 
		
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