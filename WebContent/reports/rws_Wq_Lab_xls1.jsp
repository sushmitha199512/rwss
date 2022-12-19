<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>

<html>
<%




int mb=0,mc=0,mt=0,umb=0,umc=0,umt=0,t=0,t2=0,pb=0,pc=0,pt=0;
double coverage=0.0;
boolean flag=false;
int tt1=0, sno=1;
String q1 = null;
String mode = (String)session.getAttribute("mode");
// System.out.println("mode:::"+mode);
double gt=0.0,t1=0.0;

String dcode = (String)session.getAttribute("dcode");
//System.out.println("dcode>>>>>>>>>>>"+dcode);
//String mon=request.getParameter("month");
DecimalFormat ndf = new DecimalFormat("####.00");
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date currentDate = new java.util.Date();
String currentMonth = dateFormat.format(currentDate).substring(5,7);
//System.out.println("The Current Month::"+currentMonth);
WorksData1 wd = new WorksData1();
int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
String month=(String)session.getAttribute("month");
//	System.out.println("month>>>>>>>>>>>"+month);
String pmonth=(String)session.getAttribute("pmonth");
String dname=(String)session.getAttribute("dname");
//System.out.println("dname>>>>>>>>>>>"+dname);
String y=(String)session.getAttribute("year");
String ye=(String)session.getAttribute("ye");
 String mnth=(String)session.getAttribute("mnth");
 String query="";
%>
<body bgcolor="#edf2f8">
 <form  > 		
		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="rptHeading" colspan=10><font style="text-transform: uppercase;"> Water Quality Lab Tests Report District:<%=dname%></font></td>		
		</tr>
	<tr align=center>
	<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District</td>
		<td class=btext rowspan = 2>Location of the Laboratory</td>
		<td class=btext   rowspan = 2>Yearly Target no. of Samples<br> (@ 300nos. Per Month  for each Laboratory)</td>
<%	if(year1==Integer.parseInt(ye))
	{ %>
		<td class=btext  colspan=3>Achievement of Previous Month:<%=pmonth%></td>
		<td class=btext  colspan=3>Achievement During the Month:<%=month%></td>
		<td class=btext  colspan=3>Achievement Up to the month<br> (Cumulative):<%=month%></td>
		<td class=btext  rowspan = 2>% Of Achievement against the Target<br> (12/3)</td>
		<%}else{%>
		<td class=btext  colspan=3>Achievement upto Year</td>
		<td class=btext  rowspan = 2>% Of Achievement against the Target<br> (6/3)</td>
		<%}%>
		</tr>
		<%if(ye!=null && year1==Integer.parseInt(ye))
			{ %>
	<tr align=center>
	<td class=btext>B</td>
	<td class=btext>C</td>
	<td class=btext>Total</td>
	<td class=btext>B</td>
	<td class=btext>C</td>
	<td class=btext>Total</td>
	<td class=btext>B</td>
	<td class=btext>C</td>
	<td class=btext>Total</td>
	</tr>
	<tr><td align="center" class="btext">1</td><td align="center" class="btext">2</td><td align="center" class="btext">3</td><td align="center" class="btext">4</td><td align="center" class="btext">5</td><td align="center" class="btext">6</td><td align="center" class="btext">7</td><td align="center" class="btext">8</td><td align="center" class="btext">9</td><td align="center" class="btext">10</td><td align="center" class="btext">11</td><td align="center" class="btext">12</td><td align="center" class="btext">13</td></tr>
	<%}else{%>
		</tr>
		<tr align=center>
		<td class=btext>B</td>
		<td class=btext>C</td>
		<td class=btext>Total</td>
		</tr>
		<tr><td align="center" class="btext">1</td><td align="center" class="btext">2</td><td align="center" class="btext">3</td><td align="center" class="btext">4</td><td align="center" class="btext">5</td><td align="center" class="btext">6</td><td align="center" class="btext">7</td></tr>
		<%}%>
	
	<%	////System.out.println("user55555:::"+loggedUser);
	////System.out.println("a::"+request.getParameter("district"));
	//	//System.out.println("b:"+request.getParameter("month"));
		//	//System.out.println("c:"+request.getParameter("year"));
		String Query="";
		String dcode11=(String)session.getAttribute("dcode");
		System.out.println("dcode11"+dcode11);
		
		if(dcode11.equals("00"))
		{
			//Query ="select lab_code,substr(office_code,2,2),location from  RWS_WATER_QUALITY_LAB_TBL";
	Query="select lab_code,substr(office_code,2,2),location,dname from RWS_WATER_QUALITY_LAB_TBL,rws_district_tbl where substr(office_code,2,2)=dcode and status<>'UI' AND STATUS IS NOT NULL order by substr(office_code,2,2)";
		}
		else
		{
	  Query =" select lab_code,substr(office_code,2,2),location,dname from  RWS_WATER_QUALITY_LAB_TBL ,rws_district_tbl b  where substr(office_code,2,2)='"+dcode11+"'and substr(office_code,2,2)=dcode AND status<>'UI' AND STATUS IS NOT NULL order by substr(office_code,2,2)";
		}
	    System.out.println("sriiiiiiq:::"+Query);
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		ResultSet rs1 = stmt1.executeQuery(Query); 
	    int targetSum=0; 
		while(rs1.next())
		{ 
targetSum+=3600;
			if(year1==Integer.parseInt(ye))
			{
	       ////System.out.println("in current year"+year1);
		  // 	//System.out.println("pppppppmmm22222222:::"+pmonth);
			  q1="select (select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='2'  and substr(test_id,4,2)='"+y+"' and to_char(prepared_on,'MON')='"+mnth+"' )as a,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='1'  and substr(test_id,4,2)='"+y+"' and to_char(prepared_on,'MON')='"+mnth+"') as b,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='2'   and substr(test_id,4,2)='"+y+"') as c,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='1'   and substr(test_id,4,2)='"+y+"') as d,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='2'  and substr(test_id,4,2)='"+y+"' and to_char(prepared_on,'MON')='"+pmonth+"')as e,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='1'  and substr(test_id,4,2)='"+y+"' and to_char(prepared_on,'MON')='"+pmonth+"')as f from dual";
			}else{
			 q1="select (select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='2'   and substr(test_id,4,2)='"+y+"') as c,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='1'   and substr(test_id,4,2)='"+y+"') as d from dual";
			}
			System.out.println("q1 for bc ::"+q1);
			ResultSet rs2 = stmt2.executeQuery(q1);
 
			while(rs2.next())
			{ 
     
			if(year1==Integer.parseInt(ye))
			{%>
			<tr>
			<td class="rptValue" align="center"><%=sno++%></td>
			<td class="btext" align="left"><%=rs1.getString(4)%></td>
			<td class="btext" nowrap align="left"><%=rs1.getString(3)%></td>
			<td class="rptValue" nowrap align="center">3600</td>
			<td class="rptValue" align="right"><%=rs2.getString(5)%></td>
			<td class="rptValue" align="right"><%=rs2.getString(6)%></td>
			<%  t2=rs2.getInt(5)+rs2.getInt(6);%>
				<td class="rptValue" nowrap align="right"><%=t2%></td>
			<td class="rptValue" align="right"><%=rs2.getString(1)%></td>
			<td class="rptValue" align="right"><%=rs2.getString(2)%></td>
			<%  t=rs2.getInt(1)+rs2.getInt(2);%>
			<td class="rptValue" nowrap align="right"><%=t%></td>
			<td class="rptValue"  align="right"><%=rs2.getString(3)%></td>
			<td class="rptValue" align="right" ><%=rs2.getString(4)%></td>
			<%  t1=rs2.getInt(3)+rs2.getInt(4);
			tt1=rs2.getInt(3)+rs2.getInt(4);%>
			<td class="rptValue" align="right"><%=tt1%></td>
			<% coverage=(t1/3600)*100;
			////System.out.println("t2::"+coverage);%>
			<td class="rptValue"  align="right"><%=ndf.format(coverage)%></td>
			
			</tr>
			<%}else{%>
			<tr>
			<td class="rptValue" align="center"><%=sno++%></td>
			<td class="btext" align="left"><%=rs1.getString(4)%></td>
			<td class="btext" nowrap align="left"><%=rs1.getString(3)%></td>
			<td class="rptValue" nowrap align="center">3600</td>
			<td class="rptValue"  align="right"><%=rs2.getString(1)%></td>
			<td class="rptValue" align="right" ><%=rs2.getString(2)%></td>
			<%  t1=rs2.getInt(1)+rs2.getInt(2);
			tt1=rs2.getInt(1)+rs2.getInt(2);%>
			<td class="rptValue" align="right"><%=tt1%></td>
			<% coverage=(t1/3600)*100;
			////System.out.println("t2::"+coverage);%>
			<td class="rptValue"  align="right"><%=ndf.format(coverage)%></td>
			
			</tr>
			<%}	
			if(year1==Integer.parseInt(ye))
			{
			pb+=Integer.parseInt(rs2.getString(5));
			pc+=Integer.parseInt(rs2.getString(6));
			pt+=t2;
			mb+=Integer.parseInt(rs2.getString(1));
			mc+=Integer.parseInt(rs2.getString(2));
			mt+=t;
			umb+=Integer.parseInt(rs2.getString(3));
			umc+=Integer.parseInt(rs2.getString(4));
			umt+=t1;
			
			//gt=(umt/targetSum)*100;
			}else
			{
            umb+=Integer.parseInt(rs2.getString(1));
			umc+=Integer.parseInt(rs2.getString(2));
			umt+=t1;
			//gt+=coverage;
			}
			}}


    
//System.out.println("targetSum"+targetSum+"UMT:"+umt);
gt=umt*100/targetSum;

	
			if(request.getParameter("district")!=null  && !ye.equals("") && year1==Integer.parseInt(ye))
			{%>
                         <tr>
						<td class="btext" colspan="3" align="right" >Total : </td>
						<td class="btext"  align="right"></td>
						<td class="btext"  align="right"><%=pb%></td>
						<td class="btext"  align="right"><%=pc%></td>
						<td class="btext" align="right"><%=pt%></td>
						<td class="btext"  align="right"><%=mb%></td>
						<td class="btext"  align="right"><%=mc%></td>
						<td class="btext" align="right"><%=mt%></td>
						<td class="btext" align="right"><%=umb%></td>
						<td class="btext" align="right"><%=umc%></td>
						<td class="btext" align="right"><%=umt%></td>
					<td class="btext" align="right"><%=ndf.format(gt)%></td>
						</tr>
					<%}else
					{%>
					 <tr>
						<td class="btext" colspan="3" align="right" >Total : </td>
						<td class="btext"  align="right"></td>
						<td class="btext" align="right"><%=umb%></td>
						<td class="btext" align="right"><%=umc%></td>
						<td class="btext" align="right"><%=umt%></td>
						<td class="btext" align="right"><%=ndf.format(gt)%></td>
						</tr>
						<%}%>

	</table>
	
	<input type="hidden" name="mode">
	<input type="hidden" name="dname">
	</form>
	</body>

<%@ include file = "footer.jsp" %>
</html>