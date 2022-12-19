
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>

<html>
		<%DecimalFormat ndf = new DecimalFormat("####.00");
		double coverage=0.0;
		int thabs=0,mhabs=0,yhabs=0,phabs=0;
		double chabs=0.0;
		nic.watersoft.commons.RwsUser user=null;
		user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		String loggedUser = user.getUserId();
		System.out.println("user:::"+loggedUser);
		String query = null;
		int sno=1;
		java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.util.Date currentDate = new java.util.Date();
		String currentMonth = dateFormat.format(currentDate).substring(5,7);
		//System.out.println("The Current Month::"+currentMonth);
		String dname =(String)session.getAttribute("dname");
		//	System.out.println("dname::::::::>>>>>>>>>>>"+dname);
		String dcode = (String)session.getAttribute("dcode");
		String month =(String)session.getAttribute("month");
		//	System.out.println("month::::::::>>>>>>>>>>>"+month);
		String pmonth =(String)session.getAttribute("pmonth");
		String date=""+session.getAttribute("serversysdate");
		String yr=date.substring(6,10);
		String nextyr=""+(Integer.parseInt(yr)+1);
		//System.out.println("year::"+yr);
		//	System.out.println("nextyr::"+nextyr);
		//	System.out.println("docein condition"+request.getParameter("district"));
	
%>
		<table>
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="rptHeading" colspan=5><font style="text-transform: uppercase;">Coverage of Habitations During the Year <%=yr%>-<%=nextyr%> </font></td>		
		</tr>
		</table>
<body bgcolor="#edf2f8">
 <form action="rws_habitation_Progresses_rpt.jsp"> 
		<%
		if(dcode!=null && !dcode.equals("All")){%>
		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
	<tr align=center>
	<td class=btext rowspan = 2>Sl.No</td>
	<td class=btext rowspan = 2>No.of <br>Target HAbs</td>
	<td class=btext colspan=2>Coverage of Habs</td>
	<td class=btext  rowspan = 2>% Of Coverage<br>(4/2)</td>
	</tr>
	<tr align=center>
	<td class=btext>During the<br> Month: <%=month%></td>
	<td class=btext>During the Year</td>
	</tr>
	<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext>4</td><td align="center" class=btext>5</td></tr>
<%
		String  Query =" select (Select count(distinct hab_code) from RWS_admn_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  and  a.work_id not in (select work_id from  rws_work_completion_tbl where (date_of_completion<'01-Apr-"+yr+"'  or date_of_completion is null )) and substr(b.work_id,5,2)='"+dcode+"') as a,(Select count(distinct hab_code) from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  and  a.work_id in (select work_id from  rws_work_completion_tbl where date_of_completion>='01-Apr-"+yr+"' and date_of_completion is not null and to_char(date_of_completion,'MON') = TO_CHAR(SYSDATE,'MON')) and substr(b.work_id,5,2)='"+dcode+"') as b,(Select count(distinct hab_code) from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  and  a.work_id in (select work_id from  rws_work_completion_tbl where date_of_completion>='01-Apr-"+yr+"' and date_of_completion<'31-mar-"+nextyr+"'  and date_of_completion is not null )  and substr(b.work_id,5,2)='"+dcode+"') as c from dual";
		//	System.out.println("q:::"+Query);
		Statement stmt1 = conn.createStatement();
		ResultSet rs1 = stmt1.executeQuery(Query); 

		while(rs1.next())
		{ %>
				        <tr>
						<td class="rptValue"><%=sno++%></td>
						<td class="rptValue" align="right"><%=rs1.getString(1)%></td>
						<td class="rptValue" align="right"><%=rs1.getString(2)%></td>
						<td class="rptValue" align="right"><%=rs1.getString(3)%></td>
							<% double a=rs1.getDouble(1);
							double b=rs1.getDouble(3);
							coverage=(b/a)*100;
							%>
						<td class="rptValue" align="right"><%=ndf.format(coverage)%></td>
						</tr>
		            													
						<%	}%>


	</table>
	<%}else if(dcode!=null && dcode.equals("All")){%>
		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
	<tr align=center>
		<td class=btext rowspan = 2>Sl.No</td>
			<td class=btext rowspan = 2>District Name</td>
		<td class=btext rowspan = 2>No.of <br>Target HAbs</td>
		<td class=btext colspan=3>Coverage of Habs</td>
		<td class=btext  rowspan = 2>% Of Coverage<br>(6/3)</td>
	</tr>
	<tr align=center>
	<td class=btext>Previous Month:<%=pmonth%></td>
		<td class=btext>During the <br> Month:<%=month%></td>
		<td class=btext>During the Year</td>
	</tr>
	<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext>4</td><td align="center" class=btext>5</td> <td align="center" class=btext>6</td><td align="center" class=btext>7</td></tr>
<%
	String q="select dcode,dname from rws_district_tbl where dcode<>'16' ";
	Statement stmt2 = conn.createStatement();
	ResultSet rs2 = stmt2.executeQuery(q); 
	// System.out.println("q:::"+q);
	while(rs2.next())
	{
			 
	String  Query1=" select (Select count(distinct hab_code) from RWS_admn_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  and  a.work_id not in (select work_id from  rws_work_completion_tbl where (date_of_completion<'01-Apr-"+yr+"'  or date_of_completion is null )) and substr(b.work_id,5,2)="+rs2.getString(1)+") as a,(Select count(distinct hab_code) from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  and  a.work_id in (select work_id from  rws_work_completion_tbl where date_of_completion>='01-Apr-"+yr+"' and date_of_completion is not null and to_char(date_of_completion,'MON') = TO_CHAR(SYSDATE,'MON')) and substr(b.work_id,5,2)="+rs2.getString(1)+") as b,(Select count(distinct hab_code) from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  and  a.work_id in (select work_id from  rws_work_completion_tbl where date_of_completion>='01-Apr-"+yr+"' and date_of_completion<'31-mar-"+nextyr+"'  and date_of_completion is not null )  and substr(b.work_id,5,2)="+rs2.getString(1)+") as c ,(Select count(distinct hab_code) from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  and  a.work_id in (select work_id from  rws_work_completion_tbl where date_of_completion>='01-Apr-"+yr+"' and date_of_completion is not null and to_char(date_of_completion,'MON') = '"+pmonth+"') and substr(b.work_id,5,2)="+rs2.getString(1)+") as d from dual";
	//System.out.println("qQuery1Query1Query1Query1:::"+Query1);
	
		Statement stmt1 = conn.createStatement();
		ResultSet rs1 = stmt1.executeQuery(Query1); 
		while(rs1.next())
		{ %>
				        <tr>
						<td class="rptValue"><%=sno++%></td>
						<td class="rptValue"  ><%=rs2.getString(2)%></td>
						<td class="rptValue"  align="right"><%=rs1.getString(1)%></td>
						<td class="rptValue"  align="right"><%=rs1.getString(4)%></td>
						<td class="rptValue"  align="right"><%=rs1.getString(2)%></td>
						<td class="rptValue"  align="right"><%=rs1.getString(3)%></td>
							<% double a1=rs1.getDouble(1);
							double b1=rs1.getDouble(3);
						 coverage=(b1/a1)*100;
							%>
						<td class="rptValue" align="right"><%=ndf.format(coverage)%></td>
						</tr>
		 <%
						
						thabs+=Integer.parseInt(rs1.getString(1));
						mhabs+=Integer.parseInt(rs1.getString(2));
						yhabs+=Integer.parseInt(rs1.getString(3));
							phabs+=Integer.parseInt(rs1.getString(4));
						chabs+=coverage;
		}}%>
						
						<tr>
						<td class="btext" colspan="2" align="right" >Total : </td>
						<td class="btext"  align="right"><%=thabs%></td>
								<td class="btext"  align="right"><%=phabs%></td>
						<td class="btext"  align="right"><%=mhabs%></td>
						<td class="btext" align="right"><%=yhabs%></td>
						<td class="btext" align="right"><%=ndf.format(chabs)%></td>
						</tr>
													
					
	</table>
	
<%}%>
