<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<script>
function fnView()
{
	if(document.forms[0].district.value=='')
		{
		alert("Please Select District");
		return false;
		}

		else
		{
			//alert("in");
		document.forms[0].dname.value = document.forms[0].district.options[document.forms[0].district.selectedIndex].text;
		//alert(document.forms[0].dname.value);
		//	document.forms[0].mode.value = "report";
		document.forms[0].action= "rws_habitation_Progresses_rpt.jsp";
		document.forms[0].submit();
}
}
</script>
<html>
<%DecimalFormat ndf = new DecimalFormat("####.00");
	double coverage=0.0;
	int thabs=0,mhabs=0,yhabs=0 ,phabs=0;
	double chabs=0.0;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	//System.out.println("user:::"+loggedUser);
	String dcode = request.getParameter("district");
	if(dcode!=null)
	{
		session.setAttribute("dcode",dcode);
	}
	//System.out.println("dcode value::"+dcode);
	String query = null;
	int sno=1;
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.util.Date currentDate = new java.util.Date();
	String currentMonth = dateFormat.format(currentDate).substring(5,7);
//	System.out.println("The Current Month::"+currentMonth);
String date=""+session.getAttribute("serversysdate");
//System.out.println("datedatedate::"+date);
String yr=date.substring(6,10);
		String nextyr=""+(Integer.parseInt(yr)+1);
		System.out.println("year::"+yr);
		System.out.println("nextyr::"+nextyr);
		//System.out.println("docein condition"+request.getParameter("district"));
		String premonth=""+(Integer.parseInt(currentMonth)-1);
        System.out.println("The previous Month::"+premonth);
	String month="",pmonth="";
	if(currentMonth.equals("01"))
	{
		month="JANUARY";
	}
	else if(currentMonth.equals("02"))
	{
		month="FEBUARY";
	}
	else if(currentMonth.equals("03"))
	{
		month="MARCH";
	}
	else if(currentMonth.equals("04"))
	{
		month="APRIL";
	}
	else if(currentMonth.equals("05"))
	{
		month="MAY";
	}
	else if(currentMonth.equals("06"))
	{
		month="JUNE";
	}
	else if(currentMonth.equals("07"))
	{
		month="JULY";
	}
	else if(currentMonth.equals("08"))
	{
		month="AUGUST";
	}
	else if(currentMonth.equals("09"))
	{
		month="SEPTEMBER";
	}
	else if(currentMonth.equals("10"))
	{
		month="OCTOBER";
	}
	else if(currentMonth.equals("11"))
	{
		month="NOVEMBER";
	}
	else if(currentMonth.equals("12"))
	{
		month="DECEMBER";
	}
	//System.out.println("mmm:::"+month);
	if(month!=null)
	{
		session.setAttribute("month",month);
	}
	if(premonth.equals("1"))
	{
		pmonth="JAN";
	}
	else if(premonth.equals("2"))
	{
		pmonth="FEB";
	}
	else if(premonth.equals("3"))
	{
		pmonth="MAR";
	}
	else if(premonth.equals("4"))
	{
		pmonth="APR";
	}
	else if(premonth.equals("5"))
	{
		pmonth="MAY";
	}
	else if(premonth.equals("6"))
	{
		pmonth="JUN";
	}
	else if(premonth.equals("7"))
	{
		pmonth="JUL";
	}
	else if(premonth.equals("8"))
	{
		pmonth="AUG";
	}
	else if(premonth.equals("9"))
	{
		pmonth="SEP";
	}
	else if(premonth.equals("10"))
	{
		pmonth="OCT";
	}
	else if(premonth.equals("11"))
	{
		pmonth="NOV";
	}
	else if(premonth.equals("12"))
	{
		pmonth="DEC";
	}
//	System.out.println("pppppppmmm:::"+pmonth);
	if(pmonth!=null)
	{
		session.setAttribute("pmonth",pmonth);
	}
%>
<head>
<title></title>

 </head>
<body>
 <form > 
<BR>
<BR>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="40%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					<a href="./rws_habitation_Progresses_xls.jsp" target="_new">Excel </a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">Coverage of Habitations During the Year <%=yr%>-<%=nextyr%></font></td>		
		</tr>
		
		<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" >
			<option value="">-Select-</option> 
			<% if(request.getParameter("district")!=null && request.getParameter("district").equals("All")){%>
			<option value="All" selected>All</option>
			<%}else{%>
			<option value="All">All</option><%}
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode))
				{
				%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				<%
				}
				else
				{
				%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
				<%
				}
				}
				rs.close();			
				stmt.close();
				}
		else
		{
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
			dcode=rs.getString(1);
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%>
		</tr>
		<tr align="center">
		<td colspan=2 align=center>
		<input type=submit value="View Report" class = btext  onclick="fnView()">
		</td>
		</tr>
		</table>
		<br>
		<br>
		<%
		
		if(request.getParameter("district")!=null && !request.getParameter("district").equals("All") && !request.getParameter("district").equals("")){%>
		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<tr align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>No.of Target HAbs</td>
		<td class=btext colspan=2>Coverage of Habs</td>
		<td class=btext  rowspan = 2>% Of Coverage<br>(4/2)</td>
		</tr>
		<tr align=center>
		<td class=btext>During the Month: <%=month%></td>
		<td class=btext>During the Year</td>
		</tr>
		<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext>4</td><td align="center" class=btext>5</td></tr>
     <%
	String  Query =" select (Select count(distinct hab_code) from RWS_admn_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  and  a.work_id not in (select work_id from  rws_work_completion_tbl where (date_of_completion<'01-Apr-"+yr+"'  or date_of_completion is null )) and substr(b.work_id,5,2)='"+request.getParameter("district")+"') as a,(Select count(distinct hab_code) from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  and  a.work_id in (select work_id from  rws_work_completion_tbl where date_of_completion>='01-Apr-"+yr+"' and date_of_completion is not null and to_char(date_of_completion,'MON') = TO_CHAR(SYSDATE,'MON')) and substr(b.work_id,5,2)='"+request.getParameter("district")+"') as b,(Select count(distinct hab_code) from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  and  a.work_id in (select work_id from  rws_work_completion_tbl where date_of_completion>='01-Apr-"+yr+"' and date_of_completion<'31-mar-"+nextyr+"'  and date_of_completion is not null )  and substr(b.work_id,5,2)='"+request.getParameter("district")+"') as c from dual";
	//System.out.println("q:::"+Query);
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
		<%}%>
		</table>
	<%}else if(request.getParameter("district")!=null && request.getParameter("district").equals("All")){%>
		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<tr align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District Name</td>
		<td class=btext rowspan = 2>No.of Target HAbs</td>
		<td class=btext colspan=3>Coverage of Habs</td>
		<td class=btext  rowspan = 2>% Of Coverage<br>(6/3)</td>
		</tr>
		<tr align=center>
		<td class=btext>Previous Month:<%=pmonth%></td>
		<td class=btext>Current Month:<%=month%></td>
		<td class=btext>During the Year</td>
		</tr>
		<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext>4</td><td align="center" class=btext>5</td> <td align="center" class=btext>6</td><td align="center" class=btext>7</td></tr>
<%
		String q="select dcode,dname from rws_district_tbl where dcode<>'16' ";
		Statement stmt2 = conn.createStatement();
		ResultSet rs2 = stmt2.executeQuery(q); 
		 //System.out.println("q:::"+q);
		while(rs2.next())
	{
			// System.out.println("in while::");
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
	<input type="hidden" name="dname">
<%}%>
<%@ include file = "footer.jsp" %>