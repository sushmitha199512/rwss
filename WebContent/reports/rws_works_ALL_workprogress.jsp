<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%	
	Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null,stmt3=null,st3=null;
	Statement ste1 = null,ste2=null,stmte=null,sse1=null,wid=null;
	Statement st2 = null,st22=null,ss1=null,swc=null,pns=null;
	ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null,wcrs=null,pnrs=null,rapp=null,wrs=null;
	Statement stmt1 = null,sh=null;
	ResultSet rs1 = null,rse=null,rh=null;
	ResultSetMetaData rsm=null;
	String query=null,query2=null,querywc=null,querypn=null;
	int Count=0,Cnt=0,slno=0,sl=0,Counts=0,ano=0;
	
	
	String dName = String.valueOf(session.getAttribute("dName"));
	String dCode = String.valueOf(session.getAttribute("dCode"));
	String divName = String.valueOf(session.getAttribute("divName"));
	String divCode = String.valueOf(session.getAttribute("divCode"));
	String subdivName = String.valueOf(session.getAttribute("subdivName"));
	String subdivCode = String.valueOf(session.getAttribute("subdivCode"));
	String schName = String.valueOf(session.getAttribute("schName"));
	String schCode = String.valueOf(session.getAttribute("schCode"));	
	String aName = String.valueOf(session.getAttribute("augName"));
	String aCode = String.valueOf(session.getAttribute("augCode"));	
	String pName = String.valueOf(session.getAttribute("progName")); 
	String pCode = String.valueOf(session.getAttribute("progCode")); 
	String spName = String.valueOf(session.getAttribute("sprogName")); 
	String spCode = String.valueOf(session.getAttribute("sprogCode")); 	 
	//String wName = String.valueOf(session.getAttribute("worksName")); 
	//String wCode = String.valueOf(session.getAttribute("worksCode")); 	
	String planCode = String.valueOf(session.getAttribute("PlanCode"));
	String planName = String.valueOf(session.getAttribute("PlanName"));
	String workcCode = String.valueOf(session.getAttribute("workcCode"));
	String workcName = String.valueOf(session.getAttribute("workcName"));
	String YearVal = String.valueOf(session.getAttribute("yearval"));
		 
	//swc = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	wid = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    pns = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	sh = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
%>	

<html>
<head>
 <script>
   window.history.forward(1);
 </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_works_ALL_integrated_rpt.jsp?mode=init">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=24>ALL Works Progress Integrated Report</td>	
</tr>

<%   
	String workCategory=null;
	String divisionName=null;
	String Plan=null;
	String Augumentation=null;
	String wCode="",wName="";
	String schemeName="";
	String divname="",subdivname="";
	String q="",sp="";
	String di="";
	String progname="",Subprogname="";
	String queryh="";
	int count=0;

try
{
	String worksquery=" select distinct nvl(w.work_id,'-'),nvl(w.work_Name,'-'),office_code,decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation,a.type_of_asset_code,a.type_of_asset_name from rws_work_admn_tbl w,rws_work_admn_prog_lnk_tbl p,rws_asset_type_tbl a where substr(w.work_id,7,2)=a.type_of_asset_code and w.work_id=p.work_id(+) and work_cancel_dt is null ";
	if(dCode!=null && !dCode.equals(""))
	{
		worksquery +=" and substr(w.office_code,2,2)='"+dCode+"'";
	}     
	if(divCode!=null && !divCode.equals(""))
	{
		worksquery +=" and substr(w.office_code,4,1)='"+divCode+"'";
	}
	if(subdivCode!=null && !subdivCode.equals(""))
	{
		worksquery +=" and  substr(w.office_code,5,2)='"+subdivCode+"'"; 
	}
	if(planCode!=null && !planCode.equals(""))
    {
	     worksquery+=" and w.PLAN_CODE='"+planCode+"' ";
    }
    if(workcCode!=null && !workcCode.equals(""))
    {
	     worksquery+=" and w.CATEGORY_CODE='"+workcCode+"' ";
    }
	if(schCode!=null && !schCode.equals(""))
    {
	     worksquery+=" and substr(w.work_id,7,2)='"+schCode+"' ";
    }
    if(aCode!=null && !aCode.equals(""))
    {
	    worksquery+=" and w.AUG_NEW_CODE ='"+aCode+"'  ";
    }
    if(pCode!=null && !pCode.equals(""))
    {
	    worksquery+=" and substr(w.work_id,1,2)='"+pCode+"' ";
    }
    if(spCode!=null && !spCode.equals(""))
    {
	    worksquery+=" and substr(w.work_id,3,2)='"+spCode+"' ";
    }
    if(YearVal!=null && !YearVal.equals(""))
    {
	    worksquery+=" and to_char(w.admin_date,'yyyy')='"+YearVal+"' ";
    }
    worksquery+=" order by nvl(w.work_id,'-'),nvl(work_name,'-') ";
	
	////System.out.println("query"+worksquery);
	wrs=wid.executeQuery(worksquery);
				////System.out.println(" wid statement in work progress ");
	try
	{
	while(wrs.next()) 
	{
		count++;
		////System.out.println("count "+count);
		wName=wrs.getString(2);	
		wCode=wrs.getString(1);	
	 	Plan=wrs.getString(4);
	   	workCategory=wrs.getString(5);
	    Augumentation=wrs.getString(6);
	   	schemeName=wrs.getString(8);
		////System.out.println("query"+wrs.getString("office_code").substring(4,6));
try{
   	di="";
	if(wrs.getString("office_code").substring(4,6).equals("00"))
	{
		queryh="select div.division_office_code,div.division_office_name,sd.subdivision_office_code,sd.subdivision_office_name from RWS_WORK_ADMN_TBL w,rws_circle_office_tbl cir,rws_division_office_tbl div,rws_subdivision_office_tbl sd where cir.circle_office_code=div.circle_office_code and cir.circle_office_code=sd.circle_office_code and div.division_office_code=sd.division_office_code and substr(w.office_code,2,2) =cir.circle_office_code and substr(w.office_code,4,1)=div.division_office_code and w.work_id='"+wrs.getString(1)+"'  ";
	}
	else
	{
		di="yes";
		queryh="select div.division_office_code,div.division_office_name,sd.subdivision_office_code,sd.subdivision_office_name from RWS_WORK_ADMN_TBL w,rws_circle_office_tbl cir,rws_division_office_tbl div,rws_subdivision_office_tbl sd where cir.circle_office_code=div.circle_office_code and cir.circle_office_code=sd.circle_office_code and div.division_office_code=sd.division_office_code and substr(w.office_code,2,2) =cir.circle_office_code and substr(w.office_code,4,1)=div.division_office_code and substr(w.office_code,5,2)=sd.subdivision_office_code and w.work_id='"+wrs.getString(1)+"'  ";
	}	
	////System.out.println("qiuery div"+queryh);
	////System.out.println(" sh statement in work progress ");
	rh=sh.executeQuery(queryh);
	if(rh.next())
	{
	 divname=rh.getString(2);
		if(di.equals("yes"))
		{
			subdivname=rh.getString(4); 
		}
		else
		{
			subdivname="-";
		}	
  	 }
	 else
	   {
		   divname="-";
		   subdivname="-";
	   }
	  }catch(Exception e)
	{
	}
	finally
	{
		if(rh!=null)rh.close();
			////System.out.println(" sh.close in work progress ");
		if(sh!=null)sh.close();
	}
	
  	sp="";
	if(wrs.getString(1).substring(2,4).equals("00"))
	{
		q="select p.programme_code,p.programme_name from rws_work_admn_tbl w,rws_programme_tbl p where p.programme_code=substr(w.work_id,1,2) and work_id='"+wrs.getString(1)+"' ";
	}
	else
	{
		sp="yes"; 
		q="select p.programme_code,p.programme_name,sp.subprogramme_code,sp.subprogramme_name from rws_work_admn_tbl w,rws_programme_tbl p,rws_subprogramme_tbl sp where  p.programme_code=sp.programme_code and p.programme_code=substr(w.work_id,1,2) and sp.subprogramme_code=substr(w.work_id,3,2) and work_id='"+wrs.getString(1)+"' ";
	}	 
  pnrs=pns.executeQuery(q);
  	////System.out.println(" pns statement in work progress ");
  try
  {	
   if(pnrs.next())
   {
    progname=pnrs.getString(2);
	if(sp.equals("yes"))
	{
		Subprogname=pnrs.getString(4);
	}
	else
	{
		Subprogname="-";
	}	
   }
   else
   {
	   progname="-";
	   Subprogname="-";
   }
    }catch(Exception e)
	{}
	finally
	{
		if(pnrs!=null)pnrs.close();
		
	////System.out.println(" pns.close in work progress ");
	}
   %>
<p>&nbsp;</p>
<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">

<tr bgcolor="#8A9FCD" align="center">
	<td align="left" class="rptHeading" colspan="1">S.No: <%=count%></td><td class="rptHeading" align="left" colspan=22>WORK: <font color="black"><%=wName%></td>	
</tr>
<tr  bgcolor="#edf2f8" align="left"><td class="rptHeading" colspan="11">Work_ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="black"><font color="black"><%=wCode%></font></td><td class="rptHeading" colspan="7"></td></tr>
<tr bgcolor="#edf2f8">

<%
   if(dCode!=null && !dCode.equals(""))
   { 
%>	
	<td class="rptHeading" colspan="11">District:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="black"><font color="black"><%=dName%></font></td>
	<%}
	if(divName!=null  && !divName.equals("null") && !divName.equals(""))
	{
	%>
		<td class="rptHeading" colspan="7" bgcolor="#edf2f8">Division:&nbsp;&nbsp;&nbsp;<font color="black"><%=divName%></td></tr>
	<%
	}else{
	%>
		<td class="rptHeading" colspan="7" bgcolor="#edf2f8">Division:&nbsp;&nbsp;&nbsp; <font color="black"><%=divname%></td></tr>
	<%
	}	
	if(subdivName!=null && !subdivName.equals("null") && !subdivName.equals(""))
	{
	%>
		<TR bgcolor="#edf2f8"><td  class="rptHeading" colspan="11" bgcolor="#edf2f8">SubDivision:&nbsp;&nbsp;<font color="black"><%=subdivName%></td>
	<%
	}else{%>
		<tr bgcolor="#edf2f8"><td  class="rptHeading" colspan="11" bgcolor="#edf2f8">SubDivision:&nbsp;&nbsp;<font color="black"><%=subdivname%></td>
	<%
	}
	if(schName!=null && !schName.equals("null"))
	{
	%>
		<td class="rptHeading" colspan="7" bgcolor="#edf2f8">Scheme:&nbsp;&nbsp;&nbsp;&nbsp;<font color="black"><%=schName%></td></tr>
	<%
	}else{
	%>
		<td  class="rptHeading" colspan="7" bgcolor="#edf2f8">Scheme:&nbsp;&nbsp;&nbsp;&nbsp;<font color="black"><%=schemeName%></td></tr>
	<%
	}
	if(planName!=null && !planName.equals("null"))
	{	
	%>
		<TR bgcolor="#edf2f8"><td class="rptHeading" colspan="11">Plan/Non-Plan:<font color="black"><%=planName%></td>
   <%}else{%>
		<TR bgcolor="#edf2f8"><td class="rptHeading" colspan="11" bgcolor="#edf2f8">Plan/Non-Plan:<font color="black"><%=Plan%></td>
	<%}	
	if(pName!=null && !pName.equals("null"))
	{%>
		<td  class="rptHeading" colspan="7" bgcolor="#edf2f8">Programme: <font color="black"><%=pName%></td></TR>
	<%}	else{%>
		<td class="rptHeading" colspan="7" bgcolor="#edf2f8">Programmme: <font color="black"><%=progname%></td></tr>
	<%}	
	if(spName!=null && !spName.equals("null")) 
	{
	%>
	<TR bgcolor="#edf2f8"><td  class="rptHeading" colspan="11" bgcolor="#edf2f8">SubProgramme: <font color="black"><%=spName%></td>
	<%		
	}else{%>
		<TR bgcolor="#edf2f8"><td class="rptHeading" colspan="11" bgcolor="#edf2f8">SubProgrammme:<font color="black"><%=Subprogname%></td>
	<%}%>
	<%if(aName!=null && !aName.equals("null"))
	{%>
		<td class="rptHeading" colspan="7" bgcolor="#edf2f8">MainScheme/Augumentation/Maintenance:<font color="black"><%=aName%></td>
	<%}else{%>
		<td class="rptHeading" colspan="7" bgcolor="#edf2f8">MainScheme/Augumentation/Maintenance:<font color="black"><%=Augumentation%></td>
	<%}   
     if(workcName!=null && !workcName.equals("null"))
	 {
	%>
	<tr bgcolor="#edf2f8"><td class="rptHeading" colspan="11">WorkCategory:<font color="black"><%=workcName%></td><td class="rptHeading" colspan="7">Year: <font color="black"><%=YearVal%></font></td>
	<%}else{%>
		<TR bgcolor="#edf2f8"><td class="rptHeading" colspan="11" bgcolor="#edf2f8">WorkCategory :<font color="black"><%=workCategory%></td><td class="rptHeading" colspan="7">Year: <font color="black"><%=YearVal%></font></td>
	<%}
%>	
	</table>

		<%@ include file="./rws_works_ALL_admin_chklist.jsp"%>
		<%@ include file="./rws_works_ALL_tech_chklist.jsp"%>
		<%@ include file="./rws_works_ALL_Source_chklist.jsp"%>
		<%@ include file="./rws_works_ALL_contract_chklist.jsp"%>
		<%@ include file="./rws_works_ALL_programsched_chklist.jsp"%>
		<%@ include file="./rws_works_ALL_workexpenditure_chklist.jsp"%>
		<%@ include file="./rws_works_ALL_workcompletion_chklist.jsp"%>
		<%@ include file="./rws_works_ALL_ddws_checklist.jsp" %>
	   	 
<%
 }  
	}
	catch(Exception e){
	//System.out.println("Exception in WorkProgress"+e.getMessage());
	}
	finally
	{
	 try
	 {
		if(pns!=null)pns.close();
		
		if(wrs!=null)wrs.close();
		////System.out.println("wid.close in work progress ");
		if(wid!=null)wid.close();
	}catch(Exception e){}
	}

}//end of try brace
	catch(Exception e)
	{
		conn.close();
		e.printStackTrace();
	}
	finally
	{		
		////System.out.println("conn Closed");
		conn.close();
	}
%>

</form>
</body>
<center><font color="navy" size=3><b>Designed & Developed by National Informatics Centre, AP State Centre</b></font></center>
</html>
