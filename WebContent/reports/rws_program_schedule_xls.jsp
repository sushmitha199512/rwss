<%@ include file="/commons/rws_header1.jsp"%>
<% java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd/MM/yyyy");%>
<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%	
	Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null;
	Statement st2 = null,st22=null,ss1=null;
	ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null;
	//Statement stmt1 = null;
	ResultSet rs1 = null;
	//ResultSet rs2 = null;
	ResultSetMetaData rsm=null;
	
	String query=null,query2=null;
	//String[] record = null;
	int Count=0,Cnt=0,slno=0,sl=0,Counts=0,no=0;
	int sno=0;//code added 03-04-08
	st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
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
	query="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-'),nvl(w.office_code,'-') as office_code,nvl(to_char(w.admin_date,'yyyy'),'-') as admin_date,decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation, decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,nvl(w.approved_under,'-') as approved_under,nvl(w.AUG_WORKID,'-') as aug_link,substr(w.office_code,4,1),substr(w.office_code,5,2), "+
	"w.plan_code,w.category_code,w.aug_new_code,a.type_of_asset_code,a.type_of_asset_name,p.programme_code,p.programme_name,sp.programme_code,sp.subprogramme_name from RWS_WORK_ADMN_TBL w,RWS_work_commencement_tbl work,rws_asset_type_tbl a,rws_programme_tbl p,rws_subprogramme_tbl sp where substr(w.work_id,7,2)=a.type_of_asset_code and w.work_id=work.work_id and substr(w.work_id,1,2)=p.programme_code and substr(w.work_id,3,2)=sp.subprogramme_code and p.programme_code=sp.programme_code  and work_cancel_dt is null";
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
      if(yearCode!=null && !yearCode.equals("") && !yearCode.equals(" -"))
      {
	      query+=" and to_char(w.admin_date,'yyyy')='"+yearCode+"' ";
      }
      query+=" order by subStr(w.office_code,4,1),subStr(w.office_code,5,2),w.plan_code,w.category_code,a.type_of_asset_code,w.aug_new_code,p.programme_code,p.programme_name,sp.programme_code,sp.subprogramme_name";
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs=stmt.executeQuery(query);
	////System.out.println("view query"+query);
	rs.setFetchSize(1000);
	rs.last();
 	Count = rs.getRow();
	rs.beforeFirst();

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
	
	%> 

<html>
<head>
<script>
  window.history.forward(1);
  </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=17>Programme Schedule Report Details</td>	
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
	<TR><td class="rptHeading"  colspan="17" bgcolor="#edf2f8">Year(Admin_Sanc_Year): <%=yearCode %></td></TR>
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
	<td class="btext" rowspan=2>year(Admin_Sanc_Year)</td>
<%  } %>  
		<td class="btext" rowspan=2>SubDivision<br>Assigned to</td>
		<td class="btext" rowspan=2>Engineer(s)<br>Assigned to</td>
		<td class="btext" rowspan=2 nowrap>Work Start<br>Date</td>
		<td class="btext" colspan=6>Work Milestone</td>
        </tr>
	   
	   <tr>
	   <td class="btext">Slno</td>
	   <td class="btext">Milestone</td>
	   <td class="btext">Stage</td>
	   <td class="btext">TargetDate</td>
	   <td class="btext">Achievement<br>Date</td>
	   <td class="btext">Percent<br>Completed</td>
	   </tr>
	
<%	int habs=1,habs1=0,ha=1;//int sno=0;
	if(Count!=0)
	{
	while(rs.next())
	{
	 /*String qury1="select distinct sd.subdivision_office_name, com.officer_assigned_to,com.grounding_date,m.milestone_name, st.milestone_stage_name,mil.TARGET_DATE,mil.ACHIEVE_DATE,mil.PERCENT_COMPLETED from rws_work_commencement_tbl com,rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st,rws_subdivision_office_tbl sd  where substr(com.office_code,5,2)=sd.subdivision_office_code and m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and com.work_id='"+rs.getString(2)+"'";*/
	 /*String qury1="select distinct sd.subdivision_office_name,NVL(com.officer_assigned_to,'-'),NVL(To_Char (com.grounding_date,'DD-MON-YYYY'),'-') from rws_work_commencement_tbl com,rws_subdivision_office_tbl sd where substr(com.office_code,2,2) =sd.circle_office_code and substr(com.office_code,4,1)=sd.division_office_code and substr(com.office_code,5,2) =sd.subdivision_office_code and com.work_id='"+rs.getString(1)+"'";*/

	 String qury1="select distinct sd.subdivision_office_name,NVL(com.officer_assigned_to,'-'),NVL(com.officer_assigned_to1,'-'),NVL(com.officer_assigned_to2,'-'),NVL(com.officer_assigned_to3,'-'),NVL(To_Char(com.grounding_date,'DD-MON-YYYY'),'-') from rws_work_commencement_tbl com,rws_subdivision_office_tbl sd where substr(com.office_code,2,2) =sd.circle_office_code and substr(com.office_code,4,1)=sd.division_office_code and substr(com.office_code,5,2) =sd.subdivision_office_code and com.work_id='"+rs.getString(2)+"'";
	 ////System.out.println("qury1"+qury1);
	 rs1 = st1.executeQuery(qury1);
     rs1.beforeFirst();
     rs1.last();
     int Cnt1 = rs1.getRow();
     rs1.beforeFirst();
	//out.println(qury1);
	
	String qury2="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(mil.ACHIEVE_DATE,'DD-MON-YYYY'),'-'),nvl(mil.PERCENT_COMPLETED,'0') from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and mil.work_id='"+rs.getString(2)+"'";
	////System.out.println("qury2 milwstone "+qury2);        
      
     rs2 = st2.executeQuery(qury2);
     rs2.last();
     Cnt = rs2.getRow();
     rs2.beforeFirst();
	
     if(rs1.next())		{
%>
		<tr>
		<td class=rptValue align="center"><%=++sno%></td>
		<td class=rptValue align="center"><%=rs.getString(2)%>-<%=rs.getString(1)%></td>
		<%
		String queryh="";
//////System.out.println("SUB ***** "+rs.getString("office_code").substring(4,6));
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
	augname=rs.getString(6);
%>
	<td class="rptValue"><%=rs.getString(6)%></td>
<%	}
String queryhh="select p.programme_code,p.programme_name,sp.subprogramme_code,sp.subprogramme_name from rws_work_admn_tbl w,rws_programme_tbl p,rws_subprogramme_tbl sp where p.programme_code=sp.programme_code and p.programme_code=substr(w.work_id,1,2) and sp.subprogramme_code=substr(w.work_id,3,2) and w.work_id='"+rs.getString(2)+"' "; 
////System.out.println("query program"+queryhh);
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
yearval=rs.getString(4);
%>
		<td class="rptValue"><%=rs.getString(4)%></td>		
<%  }%> 	
		<%--<td class=rptValue align="center" nowrap>&nbsp;<%=rs.getString(3)%>&nbsp;</td>
		<td class=rptValue align="center">&nbsp;<%=rs.getString(5)%>&nbsp;</td>
		<td class=rptValue align="center"><%=rs.getString(4)%></td>		 --%>
		<td class=rptValue align="center"><%=rs1.getString(1)%></td>
		<td class=rptValue align="left" nowrap><%=rs1.getString(2)%><br><%=rs1.getString(3)%><br><%=rs1.getString(4)%><br><%=rs1.getString(5)%></td>
		<td class=rptValue align="center" nowrap><%=rs1.getString(6)%></td>
		
<%
	if(Cnt!=0)
	{
	 	int serial=0;
		while(rs2.next())
		{	
		serial++;
		if(serial>1)
		{		
		%>
		<td colspan=<%=colcount%>></td>
		<%} %>
	    <td class=rptValue align="center"><%=serial%></td>
		<td class=rptValue align="left"><%=rs2.getString(1)%></td>
		<td class=rptValue align="left"><%=rs2.getString(2)%></td>
		<td class=rptValue align="left" nowrap><%=rs2.getString(3)%></td>
		<td class=rptValue align="left"><%=rs2.getString(4)%></td>
		<td class=rptValue align="center"><%=rs2.getString(5)%></td>
		</tr>
		
<%		}
		}
		else
		{
%>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		</tr>
<%		 }
         
		} 
	
	}
	}	
	else
	{
%>
	 <tr bgcolor="#ffffff">
	 <td colspan=7></td>
	 <tr>
		<td class=rptValue colspan=10 align=center><a href="./rws_program_sched_frm.jsp"><b>No Records</b></a></td>
		</tr>
<%	}
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
