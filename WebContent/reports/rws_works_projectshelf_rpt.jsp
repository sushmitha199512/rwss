<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>

<html>
<%
Statement stmt1=null;
ResultSet rs1=null;
int sno=1;

%> 
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					
					
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=18>List of Ongoing Works(Completed) to be sent as Project Shelf 2010-11</td>		
	</tr>
	  <tr  align="center">
		<td align="center" class="btext" colspan="18" >District: ALL</td>
	</tr>	
	
	<tr align=center  align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Work Id</td>
		<td class=btext >Work Name</td>
		<td class=btext >Category</td>
		<td class=btext >Type</td>
		<td class=btext >Admin Date</td>
		<td class=btext >Admin No</td>
		<td class=btext >Cost</td>
		<td class=btext >Completion Date</td>
		<td class=btext >Coverage Status</td>
		<td class=btext >District</td>
		<td class=btext >Mandal</td>
		<td class=btext >Panchayat</td>
		<td class=btext >Village</td>
		<td class=btext >Habitation</td>
		
	</tr>	
	
	<% String qry= "select a.work_id,work_name,decode(category_code,'1','Projects','2','Normal','3','District Level') as cat,decode (aug_new_code,'1','Main Scheme','2','Augmentation') as type,to_char(admin_date,'dd/mm/yyyy') as admin,sanction_amount,admin_no,to_char(date_of_completion,'dd/mm/yyyy') as comp,d.*,e.coverage_status from RWS_WORK_admn_tbl a,rws_work_completion_tbl b,rws_admn_hab_lnk_tbl c,rws_complete_hab_view d,rws_habitation_directory_tbl e where a.work_id=b.work_id and date_of_completion>='01/APR/2010' and a.work_id not in (select work_id from RWS_DDWS_SCHEME_DATA_PORT where work_asset='W' and fin_year='2010-2011') and (programme_code<>49 and programme_code<>50 and programme_code<>51) and a.work_id in(select work_id from rws_work_commencement_tbl where grounding_date is not null) and a.work_id=c.work_id and c.hab_code=d.panch_code and c.hab_code=e.hab_code and d.panch_code=e.hab_code order by 1,2,3";
	
	   stmt=conn.createStatement();
	   rs=stmt.executeQuery(qry);
	   while(rs.next())
	   {%>
	    <tr>
				<td class=rptValue><%=sno++%></td>
				<td class="rptValue"><%=rs.getString("WORK_ID")%></td>
				<td class="rptValue"><%=rs.getString("WORK_NAME")%></td>
				<td class="rptValue"><%=rs.getString("CAT")%></td>
				<td class="rptValue"><%=rs.getString("TYPE")%></td>
				<td class="rptValue"><%=rs.getString("ADMIN")%></td>
				<td class="rptValue"><%=rs.getString("ADMIN_NO")%></td>
				<td class="rptValue" align="right"><%=rs.getString("SANCTION_AMOUNT")%></td>
				<td class="rptValue"><%=rs.getString("COMP")%></td>
				<td class="rptValue"><%=rs.getString("COVERAGE_STATUS")%></td>
				<td class="rptValue"><%=rs.getString(10)%></td>
				<td class="rptValue"><%=rs.getString(12)%></td>				
				<td class="rptValue"><%=rs.getString(14)%></td>
				<td class="rptValue"><%=rs.getString(16)%></td>
				<td class="rptValue"><%=rs.getString(18)%></td>
		</tr> 
    
	   <%
	   }
   	   if(rs1!=null){rs1.close();rs1=null;}
	   if(stmt1!=null){stmt1.close();stmt1=null;}
	%>
	</table>
	</body>
	</html>
<%@ include file = "connClose.jsp" %>
<%} finally{
}%>
