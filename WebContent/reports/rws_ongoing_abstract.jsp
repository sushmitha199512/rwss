<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<html>
<%
String catCode = request.getParameter("catCode");
DecimalFormat ndf=new DecimalFormat("####.00");
Calendar cal=Calendar.getInstance();
int year=cal.get(Calendar.YEAR);
%>
<head>
<title></title>

 </head>
<body bgcolor="#edf2f8">
<form action="rws_ongoing_abstract.jsp">
<BR>
<BR>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="40%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">List Of Ongoing Works Abstract</font></td>		
		</tr>
		<tr align="center">
			<td class = btext colspan="2">
				<font color=navy><b>Work Category</b> </font>
				<font color=red><b>*</b> </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<select name="catCode" style="width:150px" class="mycombo">
				<%if(catCode!=null && catCode.equals("1")){%>
					<option value="1" selected>Projects</option>
					<option value="2">Normal</option>				
				<%}
				else if(catCode!=null && catCode.equals("2")){%>
					<option value="1">Projects</option>
					<option value="2" selected>Normal</option>				
				<%}
				else
				{%>
				<option value="1" selected>Projects</option>
				<option value="2">Normal</option>				
				<%}%>
			</select>
			</td>
		</tr>
		<tr align="center">
			<td colspan=2 align=center>
				<input type=submit value="View Report" class = btext>
		</td>
		</tr>
		</table>
<%
if(catCode!=null)
{
	int col1=0,col2=0,col3=0,col4=0,col7=0,col8=0,col9=0,col12=0,col15=0,col18=0,col19=0,col20=0,col23=0,col26=0,col29=0,col30=0,col31=0,col34=0,col37=0;
	double col5=0.0,col6=0.0,col10=0.0,col11=0.0,col13=0.0,col14=0.0,col16=0.0,col17=0.0,col21=0.0,col22=0.0,col24=0.0,col25=0.0,col27=0.0,col28=0.0,col32=0.0,col33=0.0,col35=0.0,col36=0.0,col38=0.0,col39=0.0;
%>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
	<tr  align="center">
		<td align="center" class="btext" colspan="42" >District: All &nbsp; &nbsp;</td>
	</tr>	
	
	<tr align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District</td>
		<td class=btext rowspan = 2>Division</td>
		<td class=btext colspan=2>Total Works</td>
		<td class=btext colspan =2>Total Est. Cost</td>
		<td class=btext colspan =2>Total Sanctioned Habs</td>
	</tr>
	<tr align=center>
		<td class=btext>Not Grounded</td>
		<td class=btext>Grounded</td>
		<td class=btext>Not Grounded</td>
		<td class=btext>Grounded</td>
		<td class=btext>Not Grounded</td>
		<td class=btext>Grounded</td>
	</tr>
	<%
	String getDnameQuery = "select circle_office_code,division_office_code,dname,division_office_name from rws_division_office_tbl a,rws_district_tbl d where circle_office_code=dcode and circle_office_code<>'16' order by 1,2";
	////System.out.println("---------------------------------");
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery);
		ResultSet rs2 = ps1.executeQuery(); 
		int sno=1;
		Statement col1st = conn.createStatement();
		Statement col2st  = conn.createStatement();
		ResultSet col1rs = null,col2rs = null;
		int notWorks1=0,notHabs1=0,Works1=0,Habs1=0;
		double notCost1=0.0,Cost1=0.0;
		while(rs2.next())
		{ 
				
			%>
				<tr>
						<td class="rptValue"><%=sno++%></td>
						<td class="rptValue" nowrap><%=rs2.getString(3)%></td>
						<td class="rptValue" nowrap><%=rs2.getString(4)%></td>
		    <%
			String q1 = "SELECT no_of_habs,sanction_amount FROM RWS_WORK_ADMN_TBL W where (w.ADMIN_DATE < '01-Apr-"+year+"' or w.ADMIN_DATE >= '01-Apr-"+year+"') and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-Apr-"+year+"') and plan_code='1' and category_code!=3 and work_id not in(select work_id from rws_work_commencement_tbl where grounding_date is not null) and substr (office_code,2,2)='"+rs2.getString(1)+"' and substr (office_code,4,1)='"+rs2.getString(2)+"' and category_code='"+catCode+"' and work_cancel_dt is null";
			////System.out.println("q111:"+q1);
			col1rs = col1st.executeQuery(q1);

			String q2 = "SELECT no_of_habs,sanction_amount FROM RWS_WORK_ADMN_TBL W where (w.ADMIN_DATE < '01-Apr-"+year+"' or w.ADMIN_DATE >= '01- Apr-"+year+"') and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-Apr-"+year+"') and plan_code='1' and category_code!=3 and work_id in(select work_id from rws_work_commencement_tbl where grounding_date is not null) and substr (office_code,2,2)='"+rs2.getString(1)+"' and substr (office_code,4,1)='"+rs2.getString(2)+"' and category_code='"+catCode+"' and work_cancel_dt is null ";
			////System.out.println("q222:"+q2);
			col2rs = col2st.executeQuery(q2);
			int notWorks=0,notHabs=0,Works=0,Habs=0;
			double notCost=0.0,Cost=0.0;
			while(col1rs.next())
			{
				notWorks++;
				notCost += col1rs.getDouble(2);
				notHabs += col1rs.getInt(1);
			}
			
			while(col2rs.next())
			{
				Works++;
				Cost += col2rs.getDouble(2);
				Habs += col2rs.getInt(1);
			}
			notWorks1 += notWorks;
			notHabs1 += notHabs;
			Works1 += Works;
			Habs1 += Habs;
			notCost1 += notCost;
			Cost1 += Cost;
		%>
				 <td class=rptValue align=right><%=notWorks%></td>
				 <td class=rptValue align=right><%=Works%></td>
				 <td class=rptValue align=right><%=ndf.format(notCost)%></td>
				 <td class=rptValue align=right><%=ndf.format(Cost)%></td>
				 <td class=rptValue align=right><%=notHabs%></td>
				 <td class=rptValue align=right><%=Habs%></td>
			</tr>
		<%
	}
	%>
	<tr>
		<td class=btext align=center colspan=3>Total</td>
		<td class=btext align=right><%=notWorks1%></td>
		<td class=btext align=right><%=Works1%></td>
		<td class=btext align=right><%=ndf.format(notCost1)%></td>
		<td class=btext align=right><%=ndf.format(Cost1)%></td>
		<td class=btext align=right><%=notHabs1%></td>
		<td class=btext align=right><%=Habs1%></td>
	</tr>
	<%
}
%>
</TABLE>
<p  align="center">
<%@ include file="footer.jsp" %>
</p>
</form>
</BODY>
</HTML>


