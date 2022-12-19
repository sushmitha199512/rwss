<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%String rdist=request.getParameter("district");
String planCode=request.getParameter("plancode");
if(rdist!=null )
{
	session.setAttribute(rdist,"rdist");
}
%>
<html>
<head>
</head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td>
				<td class="bwborder"><a href="./rws_works_name_notpaid_excel.jsp?district=<%=rdist%>&plancode=<%=planCode%>" target=_new">Excel</a></td>
				
			</tr>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
	
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=17>Value Of Works Done but Not Paid</td>	
	</tr>
	
	<tr>
	<td class=btext align="center">SNO</td>
	<td class=btext align="center">Work Id</td>
	<td class=btext align="center">Work Name</td>
	<td class=btext align="center">Programme Name</td>
	<td class=btext align="center">SubProgramme Name</td>	
	<td class=btext align="center">Habs Sanctioned</td>
	<td class=btext align="center">Estimation Cost</td>	
	<td class=btext align="center">Exp.Upto Last Fin.Year</td>
	<td class=btext align="center">Exp.During The Year</td>
	<td class=btext align="center">Total Expenditure</td>
	<td class=btext align="center">Value Of Work Done but Not Paid</td>
	</tr>
	<%
	 try{
	//String qq =(String)session.getAttribute("query");
	//System.out.println("qq:"+qq);
	//String finalqry = qq + "'"+request.getParameter("district")+"'";
	
	String s=""; int sno=1,count=0,columnTotal1=0;
	float prevyr=0,expupto=0,expduring=0,count1=0;
	DecimalFormat ndf = new DecimalFormat("####.00");
	Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null;
	ResultSet rs1=null,rs2=null,rs3=null;
	float total=0,value=0;
	double columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0;
	
	String planName="";
	String planQry = "";
	planName = "PLAN & NON PLAN";
	if(planCode.equals("1"))
	{
		planQry = "and plan_code = '1'";
		planName = " PLAN ";
	}
	else if(planCode.equals("2"))
	{
		planQry = "and plan_code = '2'";
		planName = " NON PLAN ";
	}
	String finalqry="select distinct a.work_id from rws_work_completion_tbl c,rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v where a.work_id=c.work_id  and a.work_id=v.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null "+planQry+" and substr(a.work_id,5,2)='"+request.getParameter("district")+"'";
	//System.out.println("final:"+finalqry);
	stmt=conn.createStatement();
	stmt1=conn.createStatement();
	stmt2=conn.createStatement();
	rs=stmt.executeQuery(finalqry);
	  while(rs.next())
	  {
	  %>
	    <tr>
	    <td class=rptvalue><%=sno++%></td>
		<td class=rptvalue><%=rs.getString(1)%></td>
		
	 <%
		 
	 //String query2="select a.work_name,a.no_of_habs,nvl(a.sanction_amount,'0') from rws_work_completion_tbl c, rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v where a.work_id=c.work_id and a.work_id=v.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and a.work_id='"+rs.getString(1)+"'";
	String query2="select a.work_name,a.no_of_habs,nvl(a.sanction_amount,'0'),p.programme_name,sp.subprogramme_name from rws_work_completion_tbl c, rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v,rws_programme_tbl p,rws_subprogramme_tbl sp where a.work_id=c.work_id and a.work_id=v.work_id and substr(a.work_id,1,2)=p.programme_code and substr(a.work_id,3,2)=sp.subprogramme_code and p.programme_code=sp.programme_code and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and a.work_id='"+rs.getString(1)+"'";
	
	//System.out.println("qsssssssssssssssss2"+query2);
	rs1=stmt1.executeQuery(query2);
	if(rs1.next())
	{
	 count=rs1.getInt(2);
	 count1=rs1.getFloat(3);
	 	 %>
	  	 <td class=rptvalue><%=rs1.getString(1).toUpperCase()%></td>
	  <td class=rptValue><%=rs1.getString(4)%></td>
	  <td class=rptValue><%=rs1.getString(5)%></td>
	
	 <%if(count>0){%><td class="rptValue" align="right"><%=count%></td><%}else{%><td>-</td><%}%>
	
	 <%if(count1>0.0){%><td  class="rptValue" align="right"><%=count1%></td><%}else{%><td>-</td><%}%>
	   
	 <%
	}
	String query3="select nvl(sum(v.expenditure_upto_the_pre_year),'0'), sum (case when d.year<>'2009-10' then total else 0 end),sum (case when d.year='2009-10' then total else 0 end) from rws_work_completion_tbl c, rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v,rws_exp_view d where a.work_id=c.work_id and a.work_id=v.work_id and a.work_id=d.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and a.work_id='"+rs.getString(1)+"'";
	//System.out.println("qssssssss3"+query3);
	rs2=stmt2.executeQuery(query3);
	if(rs2.next())
	{
	  prevyr=rs2.getFloat(1);
	  expupto=rs2.getFloat(2);
	  expduring=rs2.getFloat(3);
	   } 
	    float exp=prevyr+expupto; 
	     if(exp>0.0){%>
	    <td class=rptValue align="right"><%=ndf.format(Math.round(exp*100)/100f)%></td><%}else{%><td class=rptValue>-</td><%}
	    if(expduring>0.0){%>
	     <td class=rptValue align="right"><%=ndf.format(Math.round(expduring*100)/100f)%></td><%}else{%>
	     <td class=rptValue>-</td> <%}%>
	     <% float tot=exp+ expduring; 
	     if(tot>0.0){ %>
	     <td class=rptValue align="right"><%=ndf.format(Math.round(tot*100)/100f)%></td><%}else{ %>
	     <td class=rptValue>-</td><%}%>
		
	  <%
	  String query4="select nvl(V.VALUE_OF_WORK_NOT_PAID,'0') from rws_work_completion_tbl c, rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v,rws_exp_view d where a.work_id=c.work_id and a.work_id=v.work_id and a.work_id=d.work_id(+) and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and a.work_id='"+rs.getString(1)+"'";
	  stmt3=conn.createStatement();
	  //System.out.println("qsssssssssss4"+query4);
	  rs3=stmt3.executeQuery(query4);
	  if(rs3.next())
	  {
	   //System.out.println("aaaaaa:"+rs3.getString(1));
	    if(rs3.getString(1)!=null && !rs3.getString(1).equals(""))
	    {  value=rs3.getFloat(1);}
	    else {
	    //System.out.println("dddddddddddddddddddddddddddddd");
	     value=0;}
	 
	     if(value>0.0){%>
	   <td class=rptValue align="right"><%=value%></td><%}else{%>
	     <td class=rptValue>-</td> <%}%>
	
	  <%}
	  %><%
	    columnTotal1 += count;
	    columnTotal2 += count1;
	    columnTotal3 += exp;
		columnTotal4 +=expduring ;
		columnTotal5 +=tot;
		columnTotal6 += value;
	  }
	   	%>
	   	
	   	<tr>
			<td class=btext colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total</td>
			<td class=rptValue></td>
			<td class=rptValue></td>
			<td class=rptValue></td>
			<td class=rptValue align="right"><%=columnTotal1%></td>
			
			<td class=rptValue align="right"><%=ndf.format(Math.round(columnTotal2*100)/100f) %></td>
			<td class=rptValue align="right"><%=ndf.format(Math.round(columnTotal3*100)/100f)  %></td>
			<td class=rptValue align="right"><%=ndf.format(Math.round(columnTotal4*100)/100f)  %></td>
			<td class=rptValue align="right"><%=ndf.format(Math.round(columnTotal5*100)/100f) %></td>
			<td class=rptValue align="right"><%=ndf.format(Math.round(columnTotal6*100)/100f)  %></td>
			</tr>
		<%   
	    	
	}catch(Exception e)
	{
	  System.out.println("Exception in workname not paid report:"+e); 
    }
%>
	</table>
	<%@ include file = "footer.jsp" %>
	</body>
	</html>