
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@ page contentType="application/vnd.ms-excel" %>

<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
<%
	DecimalFormat ndf = new DecimalFormat("####.00");
    String planCode = request.getParameter("planNonplan");
	String planQry = "";
	String planName = "PLAN & NON PLAN";
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
	session.setAttribute("planCode",planCode);
	session.setAttribute("planName",planName);
    String drill = request.getParameter("drill");
    if(drill==null)drill="0";
    session.setAttribute("drill",drill);
	
	String rDistrict="";

	String query3="",query4="",query5="";
	String districtName="";
	if(request.getParameter("district")!=null)
	{
	rDistrict = request.getParameter("district");
	session.setAttribute("rDistrict",rDistrict);
	}
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null,rs2 = null,rs3=null,rs4=null,rs5=null;
	Statement stmt1 = null,stmt2 = null,stmt3 = null,stmt4=null,sss=null;
	int slno = 0,columnTotal1=0,columnTotal2=0;
	float total=0,value=0;
	double columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0;
	

%>
<html>
<head>
</head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
	
	<tr align="center">
		<td align="center" class="rptHeading" colspan=10><b>Value Of Works Done but Not Paid</b></td>	
	</tr>
	
	<tr>
	<td class=btext align="center">SNO</td>
	<td class=btext align="center">District</td>
	<td class=btext align="center">No.of Works</td>
	<td class=btext align="center">Habs Sanctioned</td>	
	<td class=btext align="center">Estimation Cost</td>	
	<td class=btext align="center">Exp. Upto Last Fin. Year</td>
	<td class=btext align="center">Exp. During The Year</td>
	<td class=btext align="center">Total Expenditure</td>
	<td class=btext align="center">Value Of Work Done but Not Paid</td>
		
	
	
	<%
	  try
	   {
	    if(rDistrict!=null && rDistrict.equals("00")){
	   int count=0,count1=0;
	   float samt=0,prevyr=0,expupto=0,expduring=0;
	  query="SELECT DISTINCT DCODE ,DNAME FROM RWS_DISTRICT_TBL  WHERE DCODE <> '16'  order by dcode";
	  stmt=conn.createStatement();
	  rs1=stmt.executeQuery(query);
	  session.setAttribute("query","select distinct a.work_id from rws_work_completion_tbl c,rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v where a.work_id=c.work_id  and a.work_id=v.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and work_cancel_dt is null  "+planQry+" and substr(a.work_id,5,2)=");
	  while(rs1.next())
	  { %>
         <tr onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
        <td class=rptValue><%=++slno%></td>
        <td class=rptValue><%=rs1.getString(2)%></td>
        <%
        
	   query1="select distinct a.work_id from rws_work_completion_tbl c,rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v where a.work_id=c.work_id  and a.work_id=v.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and work_cancel_dt is null  and substr(a.work_id,5,2)='"+rs1.getString(1)+"' "+planQry+"" ;
	   //,nvl(sum(a.no_of_habs),'0') from rws_work_admn_tbl a, rws_work_completion_tbl b,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL c where a.work_id=b.work_id and b.date_of_completion is not null and a.work_id=c.work_id and b.work_id=c.work_id and c.VALUE_OF_WORK_NOT_PAID >0 and substr(a.work_id,5,2)='"+rs1.getString(1)+"'" ;
	    
	   stmt1=conn.createStatement();
	  //System.out.println("query1:"+query1);
	   rs2=stmt1.executeQuery(query1);
	  String workid="";int i=0;
	 while(rs2.next()){ 
	     count++;
	     
	  	 // workid=rs2.getString(1);
	   }
	   
	   
	   %><td class=rptValue><%=count%></td><%
	
	 
	 	query2="select nvl(sum(a.no_of_habs),'0'),nvl(sum(a.sanction_amount),'0') from rws_work_completion_tbl c,  rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v where a.work_id=c.work_id and a.work_id=v.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and work_cancel_dt is null  and substr(a.work_id,5,2)='"+rs1.getString(1)+"' "+planQry+"";
	   	//"select nvl(sum(a.sanction_amount),'0'),nvl(sum(c.expenditure_upto_the_pre_year),'0'), sum(case when e.year<>'2009-10' then total else 0 end),nvl(sum(case when e.year='2009-10' then total else 0 end),'0'),nvl(sum(c.VALUE_OF_WORK_NOT_PAID),'0'),count(b.date_of_completion)  from rws_work_admn_tbl a, rws_work_completion_tbl b,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL c,rws_exp_view e where a.work_id=b.work_id and b.date_of_completion is not null and a.work_id=c.work_id and b.work_id=c.work_id and c.VALUE_OF_WORK_NOT_PAID >0 and substr(a.work_id,5,2)='"+rs1.getString(1)+"'" ;
	   	stmt2=conn.createStatement();
	  // ////System.out.println("query2:"+query2);
	    rs3=stmt2.executeQuery(query2); 
	    if(rs3.next())
	    {
	     count1=rs3.getInt(1);
	     samt=rs3.getFloat(2);
	    
	    }
	  %>
	    <td class=rptValue><%=count1%></td>
	    <td class=rptValue><%=samt%></td>
	    <%
	    
	    query3="select nvl(sum(v.expenditure_upto_the_pre_year),'0'), sum (case when d.year<>'2009-10' then total else 0 end),sum(case when d.year='2009-10' then total else 0 end) from rws_work_completion_tbl c, rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v,rws_exp_view d where a.work_id=c.work_id and a.work_id=v.work_id and a.work_id=d.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and work_cancel_dt is null  and substr(a.work_id,5,2)='"+rs1.getString(1)+"'  "+planQry+" ";
	    stmt3=conn.createStatement();
	      // ////System.out.println("query3:"+query3);
	     rs4=stmt3.executeQuery(query3); 
	    if(rs4.next())
	    {
	     prevyr=rs4.getFloat(1);
	     expupto=rs4.getFloat(2);
	     expduring=rs4.getFloat(3);
	    }
	    float exp=prevyr+expupto;%>
	    <td class=rptValue><%=ndf.format(Math.round(exp*100)/100f)%></td>
	     <td class=rptValue><%=ndf.format(Math.round(expduring*100)/100f)%></td>
	     <% float tot=exp+ expduring;%>
	     <td class=rptValue><%=ndf.format(Math.round(tot*100)/100f)%></td>
	     
	    <% 
	    
	    //
	    query4="select  sum(V.VALUE_OF_WORK_NOT_PAID) from rws_work_completion_tbl c, rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v,rws_exp_view d where a.work_id=c.work_id  and a.work_id=v.work_id and a.work_id=d.work_id(+) and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and work_cancel_dt is null  and substr(a.work_id,5,2)='"+rs1.getString(1)+"' "+planQry+" ";
	  	stmt4=conn.createStatement();
	  	 	//////System.out.println("query4:"+query4);
	    rs5=stmt4.executeQuery(query4); 
	   	if(rs5.next()){
	     value=rs5.getFloat(1);
	    }
	   %>
	   <td class=rptValue><%=value%></td>
	   <%
	   	columnTotal1 += count;columnTotal2 += count1;
	    columnTotal3 += samt;
		columnTotal4 += exp;
		columnTotal5 += expduring;
		columnTotal6 += tot;
	    columnTotal7 += value;   
	    count=0;
	    count1=0;
	    samt=0;
	    value=0;
	   	}
	  
	   	%>
	   	
	   	<tr>
			<td class=btext align=center colspan="2">Total</td>
			<td class=rptValue><%=columnTotal1%></td>
			<td class=rptValue><%=columnTotal2%></td>
			<td class=rptValue><%=ndf.format(Math.round(columnTotal3*100)/100f)%></td>
			<td class=rptValue><%=ndf.format(Math.round(columnTotal4*100)/100f)%></td>
			<td class=rptValue><%=ndf.format(Math.round(columnTotal5*100)/100f)%></td>
			<td class=rptValue><%=ndf.format(Math.round(columnTotal6*100)/100f)%></td>
			<td class=rptValue><%=ndf.format(Math.round(columnTotal3*100)/100f)%></td> 
			
	   <%}
	   else if(rDistrict!=null && !rDistrict.equals("00"))
	   {
	   int count=0,count1=0;
	   float samt=0,prevyr=0,expupto=0,expduring=0;
	  query="SELECT DISTINCT DCODE ,DNAME FROM RWS_DISTRICT_TBL  WHERE DCODE='"+rDistrict+"'";
	  stmt=conn.createStatement();
	  rs1=stmt.executeQuery(query);
	  if(rs1.next())
	  { %>
         <tr onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
        <td class=rptValue><%=++slno%></td>
        <td class=rptValue><%=rs1.getString(2)%></td>
        <%
        
	   query1="select distinct a.work_id from rws_work_completion_tbl c,rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v where a.work_id=c.work_id  and a.work_id=v.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and work_cancel_dt is null  and substr(a.work_id,5,2)='"+rs1.getString(1)+"' "+planQry+"" ;
	   
	   
	   //,nvl(sum(a.no_of_habs),'0') from rws_work_admn_tbl a, rws_work_completion_tbl b,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL c where a.work_id=b.work_id and b.date_of_completion is not null and a.work_id=c.work_id and b.work_id=c.work_id and c.VALUE_OF_WORK_NOT_PAID >0 and substr(a.work_id,5,2)='"+rs1.getString(1)+"'" ;
	    
	   stmt1=conn.createStatement();
	   //////System.out.println("query1:"+query1);
	   rs2=stmt1.executeQuery(query1);
	   
	 while(rs2.next()){
	     count++;
	     rs2.getString(1);
	   }
	  ////System.out.println("count:"+count);
	   %><td class=rptValue><%=count%></td><%
	   
	   	query2="select nvl(sum(a.no_of_habs),'0'),nvl(sum(a.sanction_amount),'0') from rws_work_completion_tbl c,  rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v where a.work_id=c.work_id and a.work_id=v.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and work_cancel_dt is null  and substr(a.work_id,5,2)='"+rs1.getString(1)+"' "+planQry+"";
	   	//"select nvl(sum(a.sanction_amount),'0'),nvl(sum(c.expenditure_upto_the_pre_year),'0'), sum(case when e.year<>'2009-10' then total else 0 end),nvl(sum(case when e.year='2009-10' then total else 0 end),'0'),nvl(sum(c.VALUE_OF_WORK_NOT_PAID),'0'),count(b.date_of_completion)  from rws_work_admn_tbl a, rws_work_completion_tbl b,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL c,rws_exp_view e where a.work_id=b.work_id and b.date_of_completion is not null and a.work_id=c.work_id and b.work_id=c.work_id and c.VALUE_OF_WORK_NOT_PAID >0 and substr(a.work_id,5,2)='"+rs1.getString(1)+"'" ;
	   	stmt2=conn.createStatement();
	   	//////System.out.println("query2:"+query2);
	    rs3=stmt2.executeQuery(query2); 
	    if(rs3.next())
	    {
	     count1=rs3.getInt(1);
	     samt=rs3.getFloat(2);
	    
	    }
	    %>
	    <td class=rptValue><%=count1%></td>
	    <td class=rptValue><%=samt%></td>
	    <%
	    
	    query3="select nvl(sum(v.expenditure_upto_the_pre_year),'0'), sum (case when d.year<>'2009-10' then total else 0 end),sum(case when d.year='2009-10' then total else 0 end) from rws_work_completion_tbl c, rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v,rws_exp_view d where a.work_id=c.work_id and a.work_id=v.work_id and a.work_id=d.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null  and work_cancel_dt is null  and substr(a.work_id,5,2)='"+rs1.getString(1)+"'  "+planQry+" ";
	    stmt3=conn.createStatement();
	     rs4=stmt3.executeQuery(query3); 
	    if(rs4.next())
	    {
	     prevyr=rs4.getFloat(1);
	     expupto=rs4.getFloat(2);
	     expduring=rs4.getFloat(3);
	    }
	    float exp=prevyr+expupto; %>
	    <td class=rptValue><%=ndf.format(Math.round(exp*100)/100f)%></td>
	     <td class=rptValue><%=ndf.format(Math.round(expduring*100)/100f)%></td>
	     <% float tot=exp+ expduring;%>
	     <td class=rptValue><%=ndf.format(Math.round(tot*100)/100f)%></td>
	    <% 
	    query4="select sum(V.VALUE_OF_WORK_NOT_PAID) from rws_work_completion_tbl c, rws_work_admn_tbl a , RWS_WORK_EXP_UPTO_PRE_YEAR_TBl v,rws_exp_view d where a.work_id=c.work_id  and a.work_id=v.work_id and a.work_id=d.work_id and v.VALUE_OF_WORK_NOT_PAID > 0 and date_of_completion is not null and work_cancel_dt is null  and substr(a.work_id,5,2)='"+rs1.getString(1)+"' "+planQry+" ";
	  	stmt4=conn.createStatement();
	    rs5=stmt4.executeQuery(query4); 
	   	if(rs5.next()){
	     value=rs5.getFloat(1);
	    }
        %><td class=rptValue><%=value%></td>
	   <%
	   	columnTotal1 += count;columnTotal2 += count1;
	    columnTotal3 += samt;
		columnTotal4 += exp;
		columnTotal5 += expduring;
		columnTotal6 += tot;
	    columnTotal7 += value;   
	    count=0;
	    count1=0;
	    samt=0;
	    value=0;
	   	}
	  
	   	%>
	   	
	   	<tr>
			<td class=btext align=center colspan="2">Total</td>
			<td class=rptValue><%=columnTotal1%></td>
			<td class=rptValue><%=columnTotal2%></td>
			<td class=rptValue><%=ndf.format(Math.round(columnTotal3*100)/100f)%></td>
			<td class=rptValue><%=ndf.format(Math.round(columnTotal4*100)/100f)%></td>
			<td class=rptValue><%=ndf.format(Math.round(columnTotal5*100)/100f)%></td>
			<td class=rptValue><%=ndf.format(Math.round(columnTotal6*100)/100f)%></td>
			<td class=rptValue><%=ndf.format(Math.round(columnTotal3*100)/100f)%></td> 
			
			
	   <%}
	   
	   } catch(Exception e)
	   	{
	   	 //System.out.println("Exception in value of work done but not paid report:" +e);
	   	}finally{
	   	rs5.close();rs4.close();rs3.close();rs2.close();rs1.close();
	   stmt4.close();stmt3.close();stmt2.close();stmt1.close();stmt.close();
	   	conn.close();
	   	}
	   	%>
</tr>

</table>    

</body>
</html>
      


	