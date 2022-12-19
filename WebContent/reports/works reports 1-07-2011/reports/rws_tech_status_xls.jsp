<%@ include file="/commons/rws_header1.jsp"%>
<%java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%	
	Statement st1 = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
    Statement s = null,s1=null;
	ResultSet r1 = null,r=null,r2=null;
	String query=null,query2=null;
	int Count=0,Cnt=0,slno=0;
	    
    st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    s1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);	
		    
    String dName = String.valueOf(session.getAttribute("dName"));
	String divName = String.valueOf(session.getAttribute("divName"));
	String subdivName = String.valueOf(session.getAttribute("subdivName"));
	String schName = String.valueOf(session.getAttribute("schName"));
	String aName = String.valueOf(session.getAttribute("augName"));	
	String pName = String.valueOf(session.getAttribute("progName")); 
	String spName = String.valueOf(session.getAttribute("sprogName")); 
	String planName = String.valueOf(session.getAttribute("PlanName"));
	String workcName = String.valueOf(session.getAttribute("workcName"));
	String year = String.valueOf(session.getAttribute("yrName"));
	
	String dCode = (String)request.getParameter("district");
	String divCode = (String)request.getParameter("division"); 
	String subdivCode = (String)request.getParameter("subdivision"); 
	String planCode = (String)request.getParameter("plan"); 
	String workccode = (String)request.getParameter("work"); 
	String schCode = (String)request.getParameter("scheme");
	String aCode = (String)request.getParameter("augmentation");
	String pCode = (String)request.getParameter("programme"); 
	String spCode = (String)request.getParameter("subprogramme"); 
	String yearCode= (String)request.getParameter("year"); 
	//////System.out.println("dname"+dName);

	
int colcount=5;
Statement scheme=conn.createStatement();
Statement qhh=conn.createStatement();
Statement sh=conn.createStatement();
String divname="";
String subdivname="";
String schname="";
String augname="";
String pname="";
String subprog="";
String yearval="";
	String qury="";
		
%>

<html>
<head>
 <script>
 	 window.history.forward(1);
  </script>
</head>

<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<body bgcolor="#edf2f8">

<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=16>Technical Sanction Report Details</font></td>	
	</tr>
<% if(subdivName!=null && !subdivName.equals(""))
   { 
%>
	<tr bgcolor="#edf2f8">
	<td class="rptHeading" colspan="17">District: <%=dName%></td>
	<%
	if(divName!=null && !divName.equals("null"))
	{
	%>
		<tr><td class="rptHeading" colspan="17" bgcolor="#edf2f8">Division: <%=divName%></td></TR>
	<%
	}
	if(subdivName!=null && !subdivName.equals("null"))
	{
	%>
		<TR><td  class="rptHeading" colspan="17" bgcolor="#edf2f8">SubDivision:<%=subdivName%></td></TR>
	<%
	}
	if(schName!=null && !schName.equals("null"))
	{
	%>
		<TR><td class="rptHeading" colspan="17" bgcolor="#edf2f8">Scheme: <%=schName%></td></tr>
	<%
	}
	if(aName!=null && !aName.equals("null"))
	{
	%>
	<TR><td class="rptHeading" colspan="17" bgcolor="#edf2f8">Augemntation: <%=aName%></td></tr>
		
	<%
	}
	if(pName!=null && !pName.equals("null"))
	{
	%>
		<TR><td  class="rptHeading" colspan="17" bgcolor="#edf2f8">Programme: <%=pName%></td></TR>
	<%
	}	
	if(spName!=null && !spName.equals("null")) 
	{
	%>
	<TR><td  class="rptHeading" colspan="17" bgcolor="#edf2f8">SubProgramme: <%=spName%></td></TR>
	<%		
	}
	if(yearCode!=null && !yearCode.equals("null") && !yearCode.equals("") ) 
	{
	%>
	<TR><td class="rptHeading"  colspan="17" bgcolor="#edf2f8">Year(Technical_Sanc_Date): <%=yearCode %></td></TR>
	<%
	}
	//if(dCode!=null && !dCode.equals("") && divCode!=null && !divCode.equals("") && subdivCode!=null && !subdivCode.equals(""))
	//{
	}%>
	</tr>
	<%if(planName!=null && !planName.equals("null"))
	{	
%>
<tr bgcolor="#edf2f8"><td class="rptHeading" colspan="17">Plan/Non-Plan &nbsp;&nbsp;&nbsp;&nbsp;:<%=planName%></td></tr>
<%	}%> 
	<%if(workcName!=null && !workcName.equals("null"))
	{	
%>
<tr bgcolor="#edf2f8"><td class="rptHeading" colspan="17">WorkCategory&nbsp;&nbsp;&nbsp;&nbsp;:<%=workcName%></td></tr>
<%	}%>
	<%if(aName!=null && !aName.equals("null"))
	{	
%>
<tr bgcolor="#edf2f8"><td class="rptHeading" colspan="17">MainScheme/Augumentation/bMaintenance&nbsp;&nbsp;:<%=aName%></td></tr>
<%	}%> 
	
	</table>
	<table><tr><td></td></tr></table>

	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
		<tr align=center bgcolor="#ffffff" align=center>
		<td class="btext">S.No</td>
		<td class="btext">WorkId/WorkName</td>
	
<% if(divName==null || divName.equals("null"))
	{
	colcount++;
%>
	<td class="btext">Division</td>		
<%  }
	if(subdivName==null || subdivName.equals("null"))
	{
	colcount++;
%>
	<td class="btext">SubDivision</td>		
<%	}
	if(planName==null || planName.equals("null")) 
	{
	colcount++;
	%>
	<td class="btext">Plan/Non-Plan</td>
<%	}
	if(workcName==null ||workcName.equals("null"))
	{
	colcount++;
	%>
	<td class="btext">Work Category</td>
<%	}	
	if(schName==null || schName.equals("null"))
	{
	colcount++;
%>
	<td class="btext">Scheme</td>
<%
	}
	if(aName==null || aName.equals("null"))
	{
	colcount++;
%>
	<td class="btext">MainScheme/<br>Augumentation/<br>Maintenance</td>		
<%	}
	if(pName==null || pName.equals("null"))
	{
	colcount++;
	%>
		<td class="btext">Programme</td>
<%	}	
	if(spName==null || spName.equals("null")) 
	{
	colcount++;
	%>
	<td class="btext">SubProgramme</td>
<%	}
	if(yearCode==null || yearCode.equals("null") || yearCode.equals("") ) 
	{
	colcount++;
	%>
	<td class="btext">Year(Technical_Sanc_Date)</td>
<%  } %>  		
		<td class="btext">Tech Sanction<br>Amt(Rs In Lakhs)</td>
		<td class="btext">TSNo/TSDate</td>
	    <td class="btext">SSRYear</td>
		<td class="btext">No Of Habs/Schools/<BR> Labs</td>
<td class="btext">Details</td>
		<td class="btext">Population</td>
		<td class="btext">Coverage Status</td>
		</tr>
<%try
{


	query="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),w.NO_OF_HABS,nvl (e.TS_AMOUNT,'0'),nvl(e.TS_NO,'0'),nvl(to_char(e.TS_DATE,'dd-mm-yyyy'),'-'),nvl(e.SSR_YEAR,'-'),decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation,to_char(e.TS_DATE,'yyyy'),w.office_code,substr(w.office_code,4,1),substr(w.office_code,5,2),w.plan_code,w.category_code,w.aug_new_code,a.type_of_asset_code,a.type_of_asset_name,p.programme_code,p.programme_name,sp.programme_code,sp.subprogramme_name,w.NO_OF_schools,w.NO_OF_LABS "+
		  "from RWS_WORK_ADMN_TBL w,RWS_NEW_EST_TBL e,RWS_EST_NEW_HAB_LNK_TBL ln,rws_asset_type_tbl a,rws_programme_tbl p,rws_subprogramme_tbl sp where substr(w.work_id,7,2)=a.type_of_asset_code and substr(w.work_id,1,2)=p.programme_code and substr(w.work_id,3,2)=sp.subprogramme_code and p.programme_code=sp.programme_code and w.work_id=e.work_id and e.work_id=ln.work_id and  work_cancel_dt is null and w.work_id in (select work_id from rws_work_admn_tbl)  ";
	if(dCode!=null && !dCode.equals(""))
	{
		query +=" and substr(w.office_code,2,2)='"+dCode+"'";
	}     
	if(divCode!=null && !divCode.equals(""))
	{
		query +=" and substr(w.office_code,4,1)='"+divCode+"'";
	}
	if(subdivCode!=null && !subdivCode.equals(""))
	{
		query +=" and  substr(w.office_code,5,2)='"+subdivCode+"'"; 
	}
	  if(planCode!=null && !planCode.equals(""))
      {
	      query+=" and w.PLAN_CODE='"+planCode+"' ";
      }
      if(workccode!=null && !workccode.equals(""))
      {
	      query+=" and w.CATEGORY_CODE='"+workccode+"' ";
      }
	  if(schCode!=null && !schCode.equals(""))
      {
	      query+=" and substr(w.work_id,7,2)='"+schCode+"' ";
      }
      if(aCode!=null && !aCode.equals(""))
      {
	      query+=" and w.AUG_NEW_CODE ='"+aCode+"'  ";
      }
      if(pCode!=null && !pCode.equals(""))
      {
	      query+=" and substr(w.work_id,1,2)='"+pCode+"' ";
      }
      if(spCode!=null && !spCode.equals(""))
      {
	      query+=" and substr(w.work_id,3,2)='"+spCode+"' ";
      }
      if(yearCode!=null && !yearCode.equals(""))
      {
	      query+=" and to_char(e.TS_DATE,'yyyy')='"+yearCode+"' ";
      }
  //   query+=" group by nvl(w.WORK_NAME,'-'),nvl (e.work_id,'-'),nvl(e.TS_AMOUNT,'0'),e.TS_NO,e.ts_date,e.ssr_year,w.plan_code,w.category_code,w.aug_new_code,to_char(e.prepared_on,'yyyy'),w.office_code order by substr(w.office_code,4,1),substr(w.office_code,5,2),w.plan_code,w.category_code,w.aug_new_code";
	   query+=" order by subStr(w.office_code,4,1),subStr(w.office_code,5,2),w.plan_code,w.category_code,a.type_of_asset_code,w.aug_new_code,p.programme_code,p.programme_name,sp.programme_code,sp.subprogramme_name ";
	//System.out.println("technical query  main"+query);
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs=stmt.executeQuery(query);
	////////System.out.println("Technical Sanc query"+query);
	rs.setFetchSize(1000);
	rs.last();
 	Count = rs.getRow();
 	//////System.out.println("Count "+Count);
	rs.beforeFirst();
	
	if(Count!=0)
	{
	try
	{
    while(rs.next())
	{
%>	
     <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%>/<br><%=rs.getString(1)%></td>
<%
//////System.out.println("work_id "+rs.getString(2));
String queryh="";
////////System.out.println("SUB ***** "+rs.getString("office_code").substring(4,6));
if(rs.getString("office_code").substring(4,6).equals("00"))
{
queryh="select div.division_office_code,div.division_office_name,sd.subdivision_office_code,sd.subdivision_office_name from RWS_WORK_ADMN_TBL w,rws_circle_office_tbl cir,rws_division_office_tbl div,rws_subdivision_office_tbl sd where cir.circle_office_code=div.circle_office_code and cir.circle_office_code=sd.circle_office_code and div.division_office_code=sd.division_office_code and substr(w.office_code,2,2) =cir.circle_office_code and substr(w.office_code,4,1)=div.division_office_code and w.work_id='"+rs.getString(2)+"'  ";
}
else
{
queryh="select div.division_office_code,div.division_office_name,sd.subdivision_office_code,sd.subdivision_office_name from RWS_WORK_ADMN_TBL w,rws_circle_office_tbl cir,rws_division_office_tbl div,rws_subdivision_office_tbl sd where cir.circle_office_code=div.circle_office_code and cir.circle_office_code=sd.circle_office_code and div.division_office_code=sd.division_office_code and substr(w.office_code,2,2) =cir.circle_office_code and substr(w.office_code,4,1)=div.division_office_code and substr(w.office_code,5,2)=sd.subdivision_office_code and w.work_id='"+rs.getString(2)+"'  ";
}
//////System.out.println("query hab"+queryh);
ResultSet rh=sh.executeQuery(queryh);
if(rh.next())
{
if(divName==null || divName.equals("null"))
{
divname=rh.getString(2);
subdivname=rh.getString(4);
%>
	<td class="rptValue"><%=rh.getString(2)%></td>		
<%  }
	if(subdivName==null || subdivName.equals("null"))
	{
%>
		<td class="rptValue"><%=rh.getString(4)%></td>		
<%	}
	
}
	if(planName==null || planName.equals("null")) 
	{
	
	%>
	<td class="rptValue"><%=rs.getString(8)%></td>	
<%	}
	if(workcName==null || workcName.equals("null"))
	{
	%>
		<td class="rptValue"><%=rs.getString(9)%></td>	
<%	}	
String queryscheme = "select distinct a.type_of_asset_code,a.type_of_asset_name from RWS_WORK_ADMN_TBL w,rws_asset_type_tbl a where substr(w.work_id,7,2)=a.type_of_asset_code and w.work_id='"+rs.getString(2)+"'  "; 
//////System.out.println("query scheme:"+queryscheme);
ResultSet rscheme=scheme.executeQuery(queryscheme);
if(rscheme.next())
{
	if(schName==null || schName.equals("null"))
	{
	schname=rscheme.getString(2); 
%>
	<td class="rptValue"><%=rscheme.getString(2)%></td>		
<%	}
}
	if(aName==null || aName.equals("null"))
	{
	augname=rs.getString(10);
%>
	<td class="rptValue"><%=rs.getString(10)%></td>
<%	}
String queryhh="select p.programme_code,p.programme_name,sp.subprogramme_code,sp.subprogramme_name from rws_work_admn_tbl w,rws_programme_tbl p,rws_subprogramme_tbl sp where p.programme_code=sp.programme_code and p.programme_code=substr(w.work_id,1,2) and sp.subprogramme_code=substr(w.work_id,3,2) and w.work_id='"+rs.getString(2)+"' "; 
//////System.out.println("query program"+queryhh);
ResultSet rq=qhh.executeQuery(queryhh);
if(rq.next())
{
	if(pName==null || pName.equals("null"))
	{
	pname=rq.getString(2);
%>
	<td class="rptValue"><%=rq.getString(2)%></td>		
<%	}
	if(spName==null || spName.equals("null")) 
	{ 
	subprog=rq.getString(4);
%>
	<td class="rptValue"><%=rq.getString(4)%></td>		
<%	}
}
if(yearCode==null || yearCode.equals("null") || yearCode.equals("")) 
{
	yearval=rs.getString(11);
%>
		<td class="rptValue"><%=rs.getString(11)%></td>		
<%  }%>    		
		<td class="rptValue" align="right"><%=rs.getFloat(4)%></td>
		<td class="rptValue"><%=rs.getString(5)%>/<br><%=rs.getString(6)%></td>			
		<td class=rptValue><%=rs.getString(7)%></td>
		<%//System.out.println("type of asset::"+rscheme.getString(1));
if(rscheme.getString(1).equals("11")){%>
<td class=rptValue align="center"><b><%=rs.getString(24)%></b></td>
<%}else if(rscheme.getString(1).equals("12")){%>
		<td class=rptValue align="center"><b><%=rs.getString(25)%></b></td>
		<%}else{%>
		<td class=rptValue align="center"><b><%=rs.getString(3)%></b></td>
		<%}%>
<% 
	if(rscheme.getString(1).equals("11"))
	{
	//qury="select distinct s.school_code,nvl(s.school_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') as total,nvl(coverage_status,'-') as c_status  from RWS_WORK_ADMN_TBL w,RWS_work_school_lnk_TBL ln,rws_school_master_tbl s,rws_habitation_directory_tbl h where ln.hab_code=s.hab_code(+)  and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"'  and h.coverage_status is not null and h.coverage_status<>'UI'  and w.work_id=ln.work_id ";
	qury="select distinct pr.panch_code as panch_code,nvl(pr.panch_name,'-') aspanch_name,nvl(CENSUS_PLAIN_POPU,'0') as CENSUS_PLAIN_POPU,nvl(CENSUS_SC_POPU,'0') as CENSUS_SC_POPU,nvl(CENSUS_ST_POPU,'0') as CENSUS_ST_POPU,nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') as total,nvl(coverage_status,'-') as coverage_status,ln.work_id as work_id,w.programme_code as programme_code,school_name  from RWS_PANCHAYAT_RAJ_TBL PR,rws_work_school_lnk_tbl  ln,rws_habitation_directory_tbl h,rws_work_admn_tbl w,rws_school_master_tbl s  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and h.coverage_status is not null and h.coverage_status<>'UI'  and w.work_id='"+rs.getString(2)+"' and s.school_code=ln.school_code and h.hab_code=s.hab_code order by pr.panch_code ";
	}
	else if(rscheme.getString(1).equals("12"))
	{
	  qury="select distinct division_office_code ,nvl(division_office_name,'-'),lab_name  from rws_division_office_tbl d ,rws_work_lab_lnk_tbl ll,rws_water_quality_lab_tbl w  where ll.work_id='"+rs.getString(2)+"' and d.circle_office_code=substr(ll.work_id,5,2) and ll.lab_code=w.lab_code and substr(w.office_code,4,1)=d.division_office_code";
	}
	else
	{
		  qury="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') as total,nvl(coverage_status,'-') as c_status  from RWS_WORK_ADMN_TBL w,RWS_NEW_EST_TBL e, RWS_EST_NEW_HAB_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h where w.work_id=e.work_id and e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"' and h.coverage_status is not null and h.coverage_status<>'UI'  order by pr.panch_code";
	}
////////System.out.println("QUERY "+rs.getString(3)+" workid "+rs.getString(2));
	//System.out.println("query PAN "+qury);
	rs1 = st1.executeQuery(qury);		
    rs1.setFetchSize(500);
    rs1.last();
    Count = rs1.getRow();
	rs1.beforeFirst();
	int sno=0;
	if(rs1.isBeforeFirst())
	{
		 if(rscheme.getString("type_of_asset_code").equals("12"))
			 {%>
				<td class=btext align=center>Division/Lab Name</td>
			<%}else	if(rscheme.getString("type_of_asset_code").equals("11")){%>
				<td class=btext align=center>Hab Name/School Name</td>
			<%}else	{%>
				<td class=btext align=center>Hab Name</td>
				</tr>
			<%}
		////////System.out.println("inside if");
	while(rs1.next())
	{
	////////System.out.println("inside while");
	
	if(rscheme.getString(1).equals("12"))
	{
%>
	<tr>
		<td colspan=<%=colcount+1%>></td>
		<td class="rptValue"><%=++sno%>.&nbsp;<%=rs1.getString(2)%>/<%=rs1.getString(3)%></td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		</tr>
		<%}else if(rscheme.getString(1).equals("11")){%>
		<tr>
		<td colspan=<%=colcount+1%>></td>
		<td class="rptValue"><%=++sno%>.&nbsp;<%=rs1.getString(2)%>/<%=rs1.getString(10)%></td>
		<td class="rptValue" align="right"><%=rs1.getString(3)%></td>
		<td class="rptValue" align="center"><%=rs1.getString(7)%></td>
			</tr>
			<%}else{%>
			<tr>
		<td colspan=<%=colcount+1%>></td>
		<td class="rptValue"><%=++sno%>.&nbsp;<%=rs1.getString(2)%></td>
		<td class="rptValue" align="right"><%=rs1.getString(3)%></td>
		<td class="rptValue" align="center"><%=rs1.getString(4)%></td>
			</tr>
<% }	}
}
else
{
%>
<tr>
		<td colspan=<%=colcount%>></td>
		<td class="rptValue"><%=++sno%>.&nbsp;-</td>
		<td class="rptValue">-</td>
		<td class="rptValue">-</td>
		
	</tr>
<%
}
//    String q1="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),count(ln.hab_code),nvl(e.rev_sanctioned_AMOUNT,'0'),nvl(e.rev_TS_NO,'0'),nvl(to_char(e.rev_TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-'),decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation from RWS_WORK_ADMN_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and e.work_id='"+rs.getString(2)+"' group by w.WORK_NAME,e.work_id,e.rev_sanctioned_AMOUNT,e.rev_TS_NO,e.rev_TS_DATE,e.SSR_YEAR,w.plan_code,w.category_code,w.aug_new_code";    String q1="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),count(ln.hab_code),nvl(e.rev_sanctioned_AMOUNT,'0'),nvl(e.rev_TS_NO,'0'),nvl(to_char(e.rev_TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-'),decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation from RWS_WORK_ADMN_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and e.work_id='"+rs.getString(2)+"' group by w.WORK_NAME,e.work_id,e.rev_sanctioned_AMOUNT,e.rev_TS_NO,e.rev_TS_DATE,e.SSR_YEAR,w.plan_code,w.category_code,w.aug_new_code";
String q1="";String q2 ="";
if(rscheme.getString(1).equals("11"))
	{
      q1="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),no_of_schools,nvl(e.rev_sanctioned_AMOUNT,'0'),nvl(e.rev_TS_NO,'0'),nvl(to_char(e.rev_TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-') from RWS_REVISED_ADM_SANC_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_school_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and e.work_id='"+rs.getString(2)+"' ";//group by w.WORK_NAME,e.work_id,e.rev_sanctioned_AMOUNT,e.rev_TS_NO,e.rev_TS_DATE,e.SSR_YEAR
	}
	else if(rscheme.getString(1).equals("12"))
	{
		q1="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),no_of_labs,nvl(e.rev_sanctioned_AMOUNT,'0'),nvl(e.rev_TS_NO,'0'),nvl(to_char(e.rev_TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-') from RWS_REVISED_ADM_SANC_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_lab_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and e.work_id='"+rs.getString(2)+"' ";
	}
	else
	{
		q1="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),no_of_habs,nvl(e.rev_sanctioned_AMOUNT,'0'),nvl(e.rev_TS_NO,'0'),nvl(to_char(e.rev_TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-') from RWS_REVISED_ADM_SANC_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and e.work_id='"+rs.getString(2)+"' ";
	}
//System.out.println("AAAAAAAAAA:"+q1);

   
	r= s.executeQuery(q1);
	//////System.out.println("revis "+q1);
	r.setFetchSize(500);
	r.last();
	int Counts = r.getRow();
	r.beforeFirst();
	
	if(Counts!=0)
	{
	try
	{
	 while(r.next())
	 {
	 //////////System.out.println("q1 "+r.getString(1));
%>	
    <tr bgcolor="#ffffff">
		<td class=rptValue rowspan=1></td>			
		<td class=rptValue rowspan=1><b><%=r.getString(1)%><br>(Revised To)</b></td>
 
		
<%if(divName==null || divName.equals("null"))
{
%>
	<td class="rptValue"><%=divname%></td>		
<%  }
	if(subdivName==null || subdivName.equals("null"))
	{
%>
		<td class="rptValue"><%=subdivname%></td>		
<%	}
	if(planName==null || planName.equals("null")) 
	{
%>
	<td class="rptValue"><%=rs.getString(8)%></td>	
<%	}
	if(workcName==null || workcName.equals("null"))
	{
	%>
		<td class="rptValue"><%=rs.getString(9)%></td>	
<%	}	

	if(schName==null || schName.equals("null"))
	{
	schname=rscheme.getString(2); 
%>
	<td class="rptValue"><%=schname%></td>		
<%	}
	if(aName==null || aName.equals("null"))
	{	
%>
	<td class="rptValue"><%=augname%></td>
<%	}
	if(pName==null || pName.equals("null"))
	{
%>
	<td class="rptValue"><%=pname%></td>		
<%	}
	if(spName==null || spName.equals("null")) 
	{ 
%>
	<td class="rptValue"><%=subprog%></td>		
<%	}
if(yearCode==null || yearCode.equals("null") || yearCode.equals("")) 
{
%>
	<td class="rptValue"><%=yearval%></td>		
<%}%> 
        <td class="rptValue"><%=r.getFloat(4)%></td>
		<td class="rptValue"><%=r.getString(5)%>/<br><%=r.getString(6)%></td>			
		<td class="rptValue"><%=r.getString(7)%></td>
		<td class=rptValue align="center"><b><%=r.getString(3)%></b></td>
	</tr>

<%
	if(rscheme.getString(1).equals("11"))
	{
	  q2 ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') AS TOTAL,nvl(coverage_status,'-') AS STATUS from  RWS_WORK_ADMN_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h where e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"' AND H.COVERAGE_STATUS IS NOT NULL AND H.COVERAGE_STATUS<>'UI' order by pr.panch_code";
	}
	else if(rscheme.getString(1).equals("11"))
	{
      q2 ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') AS TOTAL,nvl(coverage_status,'-') AS STATUS from RWS_WORK_ADMN_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h where e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"' AND H.COVERAGE_STATUS IS NOT NULL AND H.COVERAGE_STATUS<>'UI' order by pr.panch_code";
	 }
   else
	{
	  q2 ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') AS TOTAL,nvl(coverage_status,'-') AS STATUS from RWS_WORK_ADMN_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h where e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"' AND H.COVERAGE_STATUS IS NOT NULL AND H.COVERAGE_STATUS<>'UI' order by pr.panch_code";
	}
//System.out.println("AAAAAAAAAA:"+q2);

		
		r2 = s1.executeQuery(q2);
		////////System.out.println("revised query "+q2);
        r2.setFetchSize(500);
        r2.last();
        int Countss = r2.getRow();
		r2.beforeFirst();
		int sln=0;
		try{
		while(r2.next())
		{
 if(rscheme.getString(1).equals("11"))
    {%>
		<td colspan=<%=colcount%>></td>
		<td class="rptValue"><%=++sln%>.&nbsp;<%=r2.getString(2)%>/<%=r2.getString(5)%></td>
		<td class="rptValue" align="right"><%=r2.getString(3)%></td>
		<td class="rptValue" align="center"><%=r2.getString(4)%></td>
		</tr>
	<%}else  if(rscheme.getString(1).equals("11")){%>
	<td colspan=<%=colcount%>></td>
		<td class="rptValue"><%=++sln%>.&nbsp;<%=r2.getString(2)%>/<%=r2.getString(3)%></td>
		<td class="rptValue" align="right">-</td>
		<td class="rptValue" align="center">-</td>
		</tr>
		<%}else{%>
		<td colspan=<%=colcount%>></td>
		<td class="rptValue"><%=++sln%>.&nbsp;<%=r2.getString(2)%></td>
		<td class="rptValue" align="right"><%=r2.getString(3)%></td>
		<td class="rptValue" align="center"><%=r2.getString(4)%></td>
		</tr>
<%	}	  }
		}catch(Exception ee)
		{
			////////System.out.println("Exception e1 "+ee.getMessage());
		}	
		finally
		{
			r2.close();
			//s1.close();
		}
		 }
		 
		 }catch(Exception ee1)
		{
			////////System.out.println("Exception ee1 "+ee1.getMessage());
		}	
		finally
		{
			rs1.close();
			//st1.close();
		}
	    } 
	   
      }
      }catch(Exception e)
	    {
	    	//////////System.out.println("Exception e2 "+e.getMessage());
	    }
	    finally
	    { 
	    	rs.close();
		 	stmt.close(); 
	    }
       
	}
	else
	{
%>
	 <tr bgcolor="#ffffff">
		<td class=rptValue colspan=6 align=center><a href="./rws_tech_status_form.jsp"><b>No Records</b></a></td>
<%	}
 }
 catch(Exception e)
 {
	//////////System.out.println("Exception e3 "+e.getMessage());
 }
 finally
 {
 	
    conn.close();
 }
%>
</table>
<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>
<!--<input type="hidden" name="pass"> -->
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
