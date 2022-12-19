<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file = "conn.jsp" %>


<%	
	Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null;
	Statement st2 = null,st22=null,ss1=null,stcon=null;
	ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null;
	ResultSet rs1 = null,rscon=null;
	ResultSetMetaData rsm=null;
	String query=null,query2=null;
	int Count=0,Cnt=0,slno=0,sl=0,Counts=0,no=0;
	int sno=0;
	String qury1=null;	
    ResultSet rsw=null;
    int ano=0;
	
	st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	stcon = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);	    
	
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
	query="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-'),nvl(w.office_code,'-') as office_code,nvl(to_char(w.admin_date,'yyyy'),'-') as admin_date,decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation, decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,nvl(w.approved_under,'-') as approved_under,nvl(w.AUG_WORKID,'-') as aug_link,w.office_code,to_char(con.Agreement_date,'yyyy'),substr(w.office_code,4,1),substr(w.office_code,5,2),w.plan_code,w.category_code,w.aug_new_code,a.type_of_asset_code,a.type_of_asset_name,p.programme_code,p.programme_name,sp.programme_code,sp.subprogramme_name "+
	"from RWS_WORK_ADMN_TBL w,RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten,rws_asset_type_tbl a,rws_programme_tbl p,rws_subprogramme_tbl sp where substr(w.work_id,7,2)=a.type_of_asset_code and substr(w.work_id,1,2)=p.programme_code and substr(w.work_id,3,2)=sp.subprogramme_code and p.programme_code=sp.programme_code and w.work_id=con.work_id and con.work_id=ten.work_id  and work_cancel_dt is null";
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
	      query+=" and to_char(con.AGREEMENT_DATE,'yyyy')='"+yearCode+"' ";
      }
//      query+=" order by subStr(w.office_code,4,1),subStr(w.office_code,5,2),w.plan_code,w.category_code,a.type_of_asset_name,w.aug_new_code";
 query+=" order by subStr(w.office_code,4,1),subStr(w.office_code,5,2),w.plan_code,w.category_code,a.type_of_asset_code,w.aug_new_code,p.programme_code,p.programme_name,sp.programme_code,sp.subprogramme_name ";
    ////System.out.println("view query"+query);  
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs=stmt.executeQuery(query);	
	rs.setFetchSize(1000);
	rs.last();
 	Count = rs.getRow();
	rs.beforeFirst();

int colcount=14;
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
	
%>

<html>
<head>
<script>
  window.history.forward(1);
  </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0  width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=17>Contractor Management Report</td>	
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
	<TR><td class="rptHeading"  colspan="17" bgcolor="#edf2f8">Year(AGREEMENT_DATE): <%=yearCode %></td></TR>
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
	</tr>
	</table>
	<table><tr><td></td></tr></table>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">

		<tr align=center bgcolor="#ffffff" >
		<td  class= "btext" rowspan=2>S.NO</td>
		<td class="btext" rowspan=2>WorkId/WorkName</td>
<%  if(divName==null || divName.equals("null"))
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
	<td class="btext">Year(Prepared_On)</td>
<%  } %> 
		<td class="btext" rowspan=2>Tender<br>Notification Id</td>
		<td class="btext" rowspan=2>Tender Cost(In Lakhs)</td>
		<td class="btext" rowspan=2>Contractor Name</td>
		<td class="btext" rowspan=2>Tender<br>Accepted Date</td>
	    <td class="btext" rowspan=2>LOA<BR>issued on date</td>
		<td class="btext" rowspan=2>Agreement RefNo</td>
		<td class="btext" rowspan=2>Agreement Date</td>
		<td class="btext" rowspan=2>Agreement Duration<br> In Months</td>
		<td class="btext" rowspan=2>Agreement Value(in lakhs)</td>
		<td class="btext" rowspan=2>Site Handing<br>Over Date</td>
		<td class="btext" rowspan=2>Stipulated Date Of<br>Completion</td>
		<td class="btext" rowspan=2>Tender Percentage(Less/<BR>Excess/Est.Rates)</td>
		<td class="btext" colspan=5>Work Milestone</td>
        </tr>
	    
	    <tr>
	    <td class="btext" align="center">Slno</td>
	    <td class="btext" align="center">Milestone</td>
	    <td class="btext" align="center">Stage</td>
	    <td class="btext" align="center">TargetDate</td>
	    <td class="btext" align="center">Percent<br>Completed</td>
		</tr>

<%	
	int habs=1,habs1=0,ha=1;
	if(Count!=0)
	{
	while(rs.next())
	{	
	
String queryh="";
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
 }
	if(subdivName==null || subdivName.equals("null"))
	{
	subdivname=rh.getString(4);
}
}
String queryscheme = "select distinct a.type_of_asset_code,a.type_of_asset_name from RWS_WORK_ADMN_TBL w,rws_asset_type_tbl a where substr(w.work_id,7,2)=a.type_of_asset_code and w.work_id='"+rs.getString(2)+"'  "; 
//////System.out.println("query scheme:"+queryscheme);
ResultSet rscheme=scheme.executeQuery(queryscheme);
if(rscheme.next())
{
	if(schName==null || schName.equals("null"))
	{
		schname=rscheme.getString(2);
	}
}
String queryhh="select p.programme_code,p.programme_name,sp.subprogramme_code,sp.subprogramme_name from rws_work_admn_tbl w,rws_programme_tbl p,rws_subprogramme_tbl sp where p.programme_code=sp.programme_code and p.programme_code=substr(w.work_id,1,2) and sp.subprogramme_code=substr(w.work_id,3,2) and w.work_id='"+rs.getString(2)+"' "; 
//////System.out.println("query program"+queryhh);
ResultSet rq=qhh.executeQuery(queryhh);
if(rq.next())
{
	if(pName==null || pName.equals("null"))
	{
		pname=rq.getString(2);
	}
	if(spName==null || spName.equals("null")) 
	{
		subprog=rq.getString(4);
	}
}
//  qury1="select distinct ten.TENDER_IDNO,ten.TENDER_AMOUNT,nvl(ten.CONTRACTOR_NAME,'-'),nvl(to_char(con.TENDER_APPROVED_ON,'dd-mm-yyyy'),'-'),nvl(TO_CHAR(con.LOA_ISSUED_ON,'DD-MON-YYYY'),'-'),nvl(con.AGREEMENT_REFERENCE_NO,'-'),nvl(TO_CHAR(con.AGREEMENT_DATE,'DD-MON-YYYY'),'-'),nvl(con.AGREEMENT_DURATION,'0'),nvl(con.AGREEMENT_VALUE,'0'),nvl(TO_CHAR(con.SITE_HAND_OVER_DATE,'DD-MON-YYYY'),'-'),nvl(TO_CHAR(con.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),nvl(TENDER_PERCENT,'0') as tender_percentage from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.TENDER_IDNO=ten.TENDER_IDNO and con.work_id='"+rs.getString(2)+"' ";
	qury1=" SELECT a.TENDER_IDNO,TENDER_AMOUNT,nvl(c.CONTRACTOR_NAME_COMPANY,'-'),nvl(to_char(TENDER_APPROVED_ON,'dd/mm/yyyy'),'-')TENDER_APPROVED_ON,nvl(to_char(LOA_ISSUED_ON,'dd/mm/yyyy'),'-') LOA_ISSUED_ON ,nvl(AGREEMENT_REFERENCE_NO,'0'),nvl(to_char(AGREEMENT_DATE,'dd/mm/yyyy'),'-'),nvl(AGREEMENT_DURATION,'0'),nvl(AGREEMENT_VALUE,'0'),nvl(to_char(SITE_HAND_OVER_DATE,'dd/mm/yyyy'),'-')SITE_HAND_OVER_DATE,nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')DATE_OF_COMPLETION,nvl(TENDER_PERCENT,'0') as tender_percentage,decode (TENDER_COMMITTEE,'Y','01')TENDER_COMMITTEE from RWS_CONTRACTOR_SELECTION_TBL a,RWS_TENDER_APPL_TBL b ,rws_contractor_tbl c where a.work_id=b.work_id and  a.TENDER_IDNO=b.TENDER_IDNO and  a.contractor_code=c.CONTRACTOR_CODE (+)   and a.WORK_ID ='"+rs.getString(2)+"'";
	//"SELECT CONTRACTOR_NAME,TENDER_AMOUNT,to_char(RECIEVED_ON,'dd/mm/yyyy') RECIEVED_ON from rws_tender_appl_tbl where WORK_ID ='"+rs.getString(2)+"'";
  //  ////System.out.println("qury1"+qury1); 
       rs1 = st1.executeQuery(qury1);   
       rs1.beforeFirst();
	   while(rs1.next())
		{
	//	////System.out.println("inside rs1"+rs1.getString(1));
		sno++;
		%>
	  
		<tr>
		<td class=rptValue align="center"><%=sno%></td>
		<td class=rptValue align="center"><%=rs.getString(2)%>/<%=rs.getString(1)%></td>
	
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
	<td class="rptValue"><%=rs.getString(5)%></td>	
<%	}
	if(workcName==null || workcName.equals("null"))
	{
	%>
		<td class="rptValue"><%=rs.getString(7)%></td>	
<%	}	
	if(schName==null || schName.equals("null"))
	{
%>
	<td class="rptValue"><%=schname%></td>		
<%	}

	if(aName==null || aName.equals("null"))
	{
%>
	<td class="rptValue"><%=rs.getString(6)%></td>
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
		<td class="rptValue"><%=rs.getString(11)%></td>		
<%  }
%>			
		<td class=rptValue align="center" nowrap><%=rs1.getString(1)==null ? "-" : rs1.getString(1)%></td>
		<td class=rptValue align="center" nowrap><%=rs1.getString(2)==null ? "-" : rs1.getString(2)%></td>
		<td class=rptValue align="center" nowrap><%=rs1.getString(3)==null ? "-" : rs1.getString(3)%></td>
		<td class=rptValue align="center"><%=rs1.getString(4)==null ? "-" : rs1.getString(4)%></td>
		<td class=rptValue align="center" ><%=rs1.getString(5)==null ? "-" : rs1.getString(5)%></td>
		<td class=rptValue align="center" nowrap><%=rs1.getString(6)==null ? "-" : rs1.getString(6)%></td>
		<td class=rptValue align="center" nowrap><%=rs1.getString(7)==null ? "-" : rs1.getString(7)%></td>
		<td class=rptValue align="center"><%=rs1.getString(8)==null ? "-" : rs1.getString(8)%></td>
		<td class=rptValue align="center"><%=rs1.getString(9)==null ? "-" : rs1.getString(9)%></td></td>
		<td class=rptValue align="center"><%=rs1.getString(10)==null ? "-" : rs1.getString(10)%></td></td>
		<td class=rptValue align="center"><%=rs1.getString(11)==null ? "-" : rs1.getString(11)%></td></td>
	    <td class=rptValue align="center"><%=rs1.getString(12)==null ? "-" : rs1.getString(12)%></td></td>
<% 		String q="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),mil.PERCENT_COMPLETED from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and mil.work_id='"+rs.getString(2)+"'"; 
		////System.out.println("query milestonesss "+q);
        rs2 = st2.executeQuery(q);
        rs2.setFetchSize(500);
        rs2.last();
        Cnt = rs2.getRow();
        rs2.beforeFirst();
	    int serial=0;
	    if(Cnt!=0)
		{
		 while(rs2.next())
		 { 
		 serial++;
		 %>	   
		<td class=rptValue align="center"><%=serial%></td>
		<td class=rptValue align="left">&nbsp;<%=rs2.getString(1)%>&nbsp;</td>
		<td class=rptValue align="left">&nbsp;<%=rs2.getString(2)%>&nbsp;</td>
		<td class=rptValue align="left" nowrap>&nbsp;<%=rs2.getString(3)%>&nbsp;</td>
		<td class=rptValue align="right"><%=rs2.getString(4)==null ? "-" : rs2.getString(4)%>&nbsp;</td>
		</tr>
		<tr>
		<td colspan=<%=colcount%>>
		</tr>
<% 
		}
		}
		else
		{%>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="right">-</td>
		</tr>
<%    }
     } 
     }
	}
	else
	{%>
	 <tr bgcolor="#ffffff">
	 <td colspan=7></td>
	 <tr>
		<td class=rptValue colspan=18 align=center><a href="./rws_contractor_frm.jsp"><b>No Records</b></a></td>
		</tr>
		<% }
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

</form>
</body>
</html>