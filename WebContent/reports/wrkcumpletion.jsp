<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%	
	Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null;
	Statement st2 = null,st22=null,ss1=null;
	ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
	String query=null,query2=null;
	int Count=0,Cnt=0,sno=0,sl=0,Counts=0,no=0;
	String qury1="",q="";
	String queryhh="";

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
	String schCode = (String)request.getParameter("scheme");; 
	String aCode = (String)request.getParameter("augmentation");
	String pCode = (String)request.getParameter("programme"); 
	String spCode = (String)request.getParameter("subprogramme"); 
	String yearCode= (String)request.getParameter("year"); 
	
try
{
//query=" create or replace view WorkName as select distinct nvl(w.WORK_NAME,'-') as WORK_NAME,nvl(w.work_id,'-') as work_id,nvl(w.office_code,'-') as office_code,nvl(to_char(w.admin_date,'yyyy'),'-') as admin_date,decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation, decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,nvl(w.approved_under,'-') as approved_under,nvl(w.AUG_WORKID,'-') as aug_link from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg where w.work_id=prg.work_id(+)";
//String queryview=" create or replace view WorkName as select distinct nvl(w.WORK_NAME,'-') as WORK_NAME,nvl(w.work_id,'-') as work_id,nvl(w.office_code,'-') as office_code,nvl(to_char(w.admin_date,'yyyy'),'-') as admin_date,nvl(w.approved_under,'-') as approved_under,nvl(w.AUG_WORKID,'-') as aug_link from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg where w.work_id=prg.work_id(+) ";
	query="select distinct nvl(w.WORK_NAME,'-'), nvl(w.work_id,'-'),nvl(w.office_code,'-') as office_code,nvl(to_char(w.admin_date,'yyyy'),'-') as admin_date,decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation, decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,nvl(w.approved_under,'-') as approved_under,nvl(w.AUG_WORKID,'-') as aug_link,substr(w.office_code,4,1),substr(w.office_code,5,2),w.plan_code,w.category_code,w.aug_new_code,a.type_of_asset_code,a.type_of_asset_name,p.programme_code,p.programme_name,sp.programme_code,sp.subprogramme_name "+ 
	"from RWS_WORK_ADMN_TBL w,RWS_CONTRACTOR_SELECTION_TBL con,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMP_HAB_LNK_TBL LN,rws_asset_type_tbl a,rws_programme_tbl p,rws_subprogramme_tbl sp where substr(w.work_id,7,2)=a.type_of_asset_code and substr(w.work_id,1,2)=p.programme_code and substr(w.work_id,3,2)=sp.subprogramme_code and p.programme_code=sp.programme_code and w.work_id=con.work_id(+) and w.work_id=com.work_id and W.WORK_ID=COMM.WORK_ID AND W.WORK_ID=LN.WORK_ID(+) ";
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
	      query+=" and to_char(com.date_of_completion,'yyyy')='"+yearCode+"' ";
      }
     //  query+="order by substr(w.office_code,4,1),substr(w.office_code,5,2),nvl(to_char(w.admin_date,'yyyy'),'-'),w.plan_code,w.aug_new_code,w.category_code";
     	   query+="   order by subStr(w.office_code,4,1),subStr(w.office_code,5,2),w.plan_code,w.category_code,a.type_of_asset_code,w.aug_new_code,p.programme_code,p.programme_name,sp.programme_code,sp.subprogramme_name ";//and w.work_id='01051911110001'
  // System.out.println("QUERY "+query);
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs=stmt.executeQuery(query);
	
	rs.setFetchSize(1000);
	rs.last();
 	Count = rs.getRow();
	rs.beforeFirst();
	
 	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 	st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  	st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  	ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

int colcount=8;
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

	// rs = stmt.executeQuery(query);
	// rs.setFetchSize(500);
	// rs.last();
	// Count = rs.getRow();
	// rs.beforeFirst();
	%>

<html>
<head>
 <script>
   window.history.forward(1);
  </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"   bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_work_completion_frm.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				<td class="bwborder"><a href="./rws_work_completion_xls.jsp?district=<%=dCode%>&division=<%=divCode%>&subdivision=<%=subdivCode%>&work=<%=workccode%>&augmentation=<%=aCode%>&plan=<%=planCode%>&scheme=<%=schCode%>&programme=<%=pCode%>&subprogramme=<%=spCode%>&year=<%=yearCode%>&dName=<%=dName%>&divName=<%=divName%>&subdivName=<%=subdivName%>&workcName=<%=workcName%>&augName=<%=aName%>&PlanName=<%=planName%>&schName=<%=schName%>&progName=<%=pName%>&sprogName=<%=spName%>&yrName=<%=year%>" target="_new">Excel</a></td> 
			</tr>
		</table>
	</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=17>Work Completion Report</td>	
	</tr>
<% if(dCode!=null && !dCode.equals(""))
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
	<TR><td class="rptHeading"  colspan="17" bgcolor="#edf2f8">Year(date_of_completion): <%=yearCode %></td></TR>
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
<%	}%>	<%if(aName!=null && !aName.equals("null"))
	{	
%>
<tr bgcolor="#edf2f8"><td class="rptHeading" colspan="17">MainScheme/Augumentation/bMaintenance&nbsp;&nbsp;:<%=aName%></td></tr>
<%	}%> 
	</table>
	<table><tr><td></td></tr></table>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
		<tr align=center bgcolor="#ffffff" >
		<td  class= "btext" rowspan=2>S.NO</td>
		<td class="btext" rowspan=2>WorkId/WorkName</td>
		<%--<td class="btext" nowrap rowspan=2>Plan/<br>Non-Plan</td>
		<td class="btext" rowspan=2>Category</td>
		<td class="btext" rowspan=2>MainScheme/<br>Augumentation/<br>Maintenance</td> --%>
		<% if(divName==null || divName.equals("null"))
	{
	colcount++;
%>
	<td class="btext" rowspan=2>Division</td>		
<%  }
	if(subdivName==null || subdivName.equals("null"))
	{
	colcount++;
%>
	<td class="btext" rowspan=2>SubDivision</td>		
<%	}
	if(planName==null || planName.equals("null")) 
	{
	colcount++;
	%>
	<td class="btext" rowspan=2>Plan/Non-Plan</td>
<%	}
	if(workcName==null ||workcName.equals("null"))
	{
	colcount++;
	%>
	<td class="btext" rowspan=2>Work Category</td>
<%	}	
	if(schName==null || schName.equals("null"))
	{
	colcount++;
%>
	<td class="btext" rowspan=2>Scheme</td>
<%
	}
	if(aName==null || aName.equals("null"))
	{
	colcount++;
%>
	<td class="btext" rowspan=2>MainScheme/<br>Augumentation/<br>Maintenance</td>		
<%	}
	if(pName==null || pName.equals("null"))
	{
	colcount++;
	%>
		<td class="btext" rowspan=2>Programme</td>
<%	}	
	if(spName==null || spName.equals("null")) 
	{
	colcount++;
	%>
	<td class="btext" rowspan=2>SubProgramme</td>
<%	}
	if(yearCode==null || yearCode.equals("null") || yearCode.equals("") ) 
	{
	colcount++;
	%>
	<td class="btext" rowspan=2>Year(date_of_completion)</td>
<%  } %>  	
		<td class="btext" rowspan=2>Start Date</td>
		<td class="btext" rowspan=2>Stipulated Date Of<br>Completion</td>
		<td class="btext" rowspan=2>Actual Date Of<br>Completion</td>
		<td class="btext" rowspan=2>Date Of<br> Commissioning</td>
	    <td class="btext" rowspan=2>Remarks</td>
		<td class="btext" rowspan=2>Habitations/Schools/Labs<br>Benefitted</td>
		<td class="btext" rowspan=2>Details</td>
		<td class="btext" colspan=5>Population Benefitted</td>		
	    </tr>
	    
	    <tr>
	    <td class="btext">Plain</td>
	    <td class="btext">SC</td>
	    <td class="btext">ST</td>
	    <td class="btext">Total</td>
	    <td class="btext">Coverage Status</td>
	    
	    </tr>
	
<%	int habs=1,habs1=0,ha=1;
	if(Count!=0)
	{
	 while(rs.next())
	 {
	  sno++;
%>
	<tr>
		<td class=rptValue align="center"><%=sno%></td>
		<td class=rptValue align="right"><%=rs.getString(2)%>/<%=rs.getString(1)%></td>
<%
String queryh="";
if(rs.getString("office_code").substring(4,6).equals("00"))
{
	queryh="select div.division_office_code,div.division_office_name,sd.subdivision_office_code,sd.subdivision_office_name from RWS_WORK_ADMN_TBL w,rws_circle_office_tbl cir,rws_division_office_tbl div,rws_subdivision_office_tbl sd where cir.circle_office_code=div.circle_office_code and cir.circle_office_code=sd.circle_office_code and div.division_office_code=sd.division_office_code and substr(w.office_code,2,2) =cir.circle_office_code and substr(w.office_code,4,1)=div.division_office_code and w.work_id='"+rs.getString(2)+"'  ";
}
else
{
	queryh="select div.division_office_code,div.division_office_name,sd.subdivision_office_code,sd.subdivision_office_name from RWS_WORK_ADMN_TBL w,rws_circle_office_tbl cir,rws_division_office_tbl div,rws_subdivision_office_tbl sd where cir.circle_office_code=div.circle_office_code and cir.circle_office_code=sd.circle_office_code and div.division_office_code=sd.division_office_code and substr(w.office_code,2,2) =cir.circle_office_code and substr(w.office_code,4,1)=div.division_office_code and substr(w.office_code,5,2)=sd.subdivision_office_code and w.work_id='"+rs.getString(2)+"'  ";
}
////System.out.println("query hab"+queryh);
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
	<td class="rptValue"><%=rs.getString(5)%></td>	
<%	}
	if(workcName==null || workcName.equals("null"))
	{
%>
	<td class="rptValue"><%=rs.getString(7)%></td>	
<%	}	
String queryscheme = "select distinct a.type_of_asset_code,a.type_of_asset_name from RWS_WORK_ADMN_TBL w,rws_asset_type_tbl a where substr(w.work_id,7,2)=a.type_of_asset_code and w.work_id='"+rs.getString(2)+"'  "; 
////System.out.println("query scheme:"+queryscheme);
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
	<td class="rptValue"><%=rs.getString(6)%></td>
<%	}
queryhh="select p.programme_code,p.programme_name,sp.subprogramme_code,sp.subprogramme_name from rws_work_admn_tbl w,rws_programme_tbl p,rws_subprogramme_tbl sp where p.programme_code=sp.programme_code and p.programme_code=substr(w.work_id,1,2) and sp.subprogramme_code=substr(w.work_id,3,2) and w.work_id='"+rs.getString(2)+"' "; 
//System.out.println("query program"+queryhh);
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
		<td class="rptValue"><%=rs.getString(4)%></td>		
<%  }%>    	
		<%
	 if(rscheme.getString("type_of_asset_code").equals("11") )
		{
	   qury1="select distinct NVL(TO_CHAR(COMM.GROUNDING_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(CON.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMM,'DD-MON-YYYY'),'-'),count(ln.hab_code),nvl(COM.REMARKS,'-') as remarks from RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_school_LNK_TBL LN where con.work_id=COMM.WORK_ID AND CON.WORK_ID=COM.WORK_ID AND CON.WORK_ID=LN.WORK_ID AND CON.WORK_ID='"+rs.getString(2)+"' group by COMM.GROUNDING_DATE,CON.DATE_OF_COMPLETION, COM.DATE_OF_COMPLETION,COM.DATE_OF_COMM,com.remarks";
		}
		else  if(rscheme.getString("type_of_asset_code").equals("12") )
		{
			qury1=" select distinct NVL(TO_CHAR(COMM.GROUNDING_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(CON.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMM,'DD-MON-YYYY'),'-'),count(ln.lab_code),nvl(COM.REMARKS,'-') as remarks from RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_lab_LNK_TBL LN where con.work_id=COMM.WORK_ID AND CON.WORK_ID=COM.WORK_ID AND CON.WORK_ID=LN.WORK_ID AND CON.WORK_ID='"+rs.getString(2)+"' and ln.WORK_ID='"+rs.getString(2)+"'  group by COMM.GROUNDING_DATE,CON.DATE_OF_COMPLETION, COM.DATE_OF_COMPLETION,COM.DATE_OF_COMM,com.remarks";
		}
			else
			{
				qury1="select distinct NVL(TO_CHAR(COMM.GROUNDING_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(CON.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMM,'DD-MON-YYYY'),'-'),count(ln.hab_code),nvl(COM.REMARKS,'-') as remarks from RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMP_HAB_LNK_TBL LN where con.work_id=COMM.WORK_ID AND CON.WORK_ID=COM.WORK_ID AND CON.WORK_ID=LN.WORK_ID AND CON.WORK_ID='"+rs.getString(2)+"' group by COMM.GROUNDING_DATE,CON.DATE_OF_COMPLETION, COM.DATE_OF_COMPLETION,COM.DATE_OF_COMM,com.remarks";
			}

       //System.out.println(" select querysdsdsdsdsads "+qury1);
        rs1 = st1.executeQuery(qury1);
	    rs1.beforeFirst();
	    rs1.last();
        Cnt = rs1.getRow();
        rs1.beforeFirst();
        if(Cnt!=0)
        {
		 while(rs1.next())
		 {
%>
		<td class=rptValue align="center" nowrap>&nbsp;<%=rs1.getString(1)%>&nbsp;</td>
		<td class=rptValue align="center" nowrap>&nbsp;<%=rs1.getString(2)%>&nbsp;</td>
		<td class=rptValue align="center" nowrap>&nbsp;<%=rs1.getString(3)%>&nbsp;</td>
		<td class=rptValue align="center"><%=rs1.getString(4)%></td>
		<td class=rptValue><%=rs1.getString(6)%></td>
		<td class=rptValue align="center"><b><%=rs1.getString(5)%></b></td>
<%}
	}
	else
	{
%>
		<td class=rptValue align="center" nowrap>-</td>
		<td class=rptValue align="center" nowrap>-</td>
		<td class=rptValue align="center" nowrap>-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		
<%
	}  
%>
<% 
		/*String q="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_WORK_COMP_HAB_LNK_TBL ln,rws_habitation_directory_tbl h where ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"' and h.coverage_status is not null and h.coverage_status<>'UI' order by pr.panch_code"; 
		////System.out.println("query "+q);*/
			//System.out.println("query::: "+rscheme.getString("type_of_asset_code")+"NAME::"+rscheme.getString("type_of_asset_name"));
			if(rscheme.getString("type_of_asset_code").equals("11"))
		   {
		      q="select distinct pr.panch_code as panch_code,nvl(pr.panch_name,'-') as panch_name,nvl(CENSUS_PLAIN_POPU,'0') as CENSUS_PLAIN_POPU,nvl(CENSUS_SC_POPU,'0') as CENSUS_SC_POPU,nvl(CENSUS_ST_POPU,'0') as CENSUS_ST_POPU,nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') as total,nvl(coverage_status,'-') as coverage_status,ln.work_id as work_id,w.programme_code as programme_code,school_name  from RWS_PANCHAYAT_RAJ_TBL PR,rws_work_school_lnk_tbl  ln,rws_habitation_directory_tbl h,rws_work_admn_tbl w ,rws_school_master_tbl s where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and h.coverage_status is not null and h.coverage_status<>'UI'  and w.work_id='"+rs.getString(2)+"' and s.school_code=ln.school_code and h.hab_code=s.hab_code order by pr.panch_code ";
		  }
		 else if(rscheme.getString("type_of_asset_code").equals("12"))
		    {
			  q="select distinct division_office_code ,nvl(division_office_name,'-'),lab_name from rws_division_office_tbl d ,rws_work_lab_lnk_tbl ll,rws_water_quality_lab_tbl w  where ll.work_id='"+rs.getString(2)+"' and d.circle_office_code=substr(ll.work_id,5,2) and ll.lab_code=w.lab_code and substr(w.office_code,4,1)=d.division_office_code";
		  }
		else
			{
			   q="select distinct pr.panch_code as panch_code,nvl(pr.panch_name,'-') aspanch_name,nvl(CENSUS_PLAIN_POPU,'0') as CENSUS_PLAIN_POPU,nvl(CENSUS_SC_POPU,'0') as CENSUS_SC_POPU,nvl(CENSUS_ST_POPU,'0') as CENSUS_ST_POPU,nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') as total,nvl(coverage_status,'-') as coverage_status,ln.work_id as work_id,w.programme_code as programme_code  from RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,rws_work_admn_tbl w  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and h.coverage_status is not null and h.coverage_status<>'UI'  and w.work_id='"+rs.getString(2)+"' order by pr.panch_code ";//and programme_code='"+rr.getString(1)+"' ";
			}
			//System.out.println("query "+q);
        rs2 = st2.executeQuery(q);
        rs2.setFetchSize(500);
        rs2.last();
        Cnt = rs2.getRow();
        rs2.beforeFirst();
		if(Cnt!=0)
		{
			 int serial=0;
			 if(rscheme.getString("type_of_asset_code").equals("12"))
			 {%>
				<td class=btext align=center>Division/Lab Name</td>
			<%}else	if(rscheme.getString("type_of_asset_code").equals("11")){%>
				<td class=btext align=center>Hab Name/School Name</td>
			<%}else	{%>
				<td class=btext align=center>Hab Name</td>
				</tr>
			<%}
			 while(rs2.next())
			 { 
					serial++;
					if(rscheme.getString("type_of_asset_code").equals("11"))
				   {
				%>
				<tr>
					<td colspan=<%=colcount%>>
				</tr>
					<td class=rptValue><%=serial%>.&nbsp;<%=rs2.getString(2)%>/<%=rs2.getString(10)%></td>
					<td class=rptValue align="right"><%=rs2.getString(3)%></td>
					<td class=rptValue align="right"><%=rs2.getString(4)%></td>
					<td class=rptValue align="right" ><%=rs2.getString(5)%></td>
					<td class=rptValue align="right"><%=rs2.getString(6)%></td>
					<td class=rptValue align="center"><%=rs2.getString(7)%></td>
				</tr>
		<%	  }
				  else if(rscheme.getString("type_of_asset_code").equals("12")){
					%>
					<tr>
						<td colspan=<%=colcount%>>
						</tr>
						<td class=rptValue><%=serial%>.&nbsp;<%=rs2.getString(2)%>/<%=rs2.getString(3)%></td>
						<td class=rptValue align="right">-</td>
						<td class=rptValue align="right">-</td>
						<td class=rptValue align="right">-</td>
						<td class=rptValue align="right">-</td>
						<td class=rptValue align="right">-</td>
				</tr>
				<%	  }
				else{
					%>
					<tr>
						<td colspan=<%=colcount%>>
						</tr>
						<td class=rptValue><%=serial%>.&nbsp;<%=rs2.getString(2)%></td>
					<td class=rptValue align="right"><%=rs2.getString(3)%></td>
					<td class=rptValue align="right"><%=rs2.getString(4)%></td>
					<td class=rptValue align="right" ><%=rs2.getString(5)%></td>
					<td class=rptValue align="right"><%=rs2.getString(6)%></td>
					<td class=rptValue align="center"><%=rs2.getString(7)%></td>
				</tr>
				<%
				}
			}
	  }
	  else
	  {
%>
		<td class=rptValue align="right">-</td>
		<td class=rptValue align="right">-</td>
		<td class=rptValue align="right">-</td>
		<td class=rptValue align="right">-</td>
		<td class=rptValue align="right">-</td>
		<td class=rptValue align="right">-</td>
		</tr>
<%
	  }        
	}		
	}
	else
	{
%>
	 <tr bgcolor="#ffffff">
	 <td colspan=7></td>
	 <tr>
		<td class=rptValue colspan=21 align=center><a href="./rws_work_completion_frm.jsp"><b>No Records</b></a></td>
	</tr>
<%	 }
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
	conn.close();
	}
%>
</table>
<p class="rptHeading" align="right"><b>Total No of Records is:<%=sno%></b></p>
<input type="hidden" name="pass"> 
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>