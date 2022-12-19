<%@ include file="/commons/rws_header1.jsp"%>
<%java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%	
	ResultSetMetaData rsm=null;
	String query=null,query2=null;
	Statement st1=null;
	ResultSet rs1=null,rs2=null;
	String qury1=null;
	Statement ss=null;
    ResultSet rr=null,rsw=null;
    int Count=0,Cnt=0,slno=0,sl=0,Counts=0,no=0,ano=0;
	
	String dName = (String)request.getParameter("dName");
	String divName = (String)request.getParameter("divName");
	String subdivName = (String)request.getParameter("subdivName");
	String schName = (String)request.getParameter("schName");
	//String schName = (String)session.getAttribute("schName");
	//System.out.println("scheme in excelssss:"+schName);
	String aName = (String)request.getParameter("augName");	
			//System.out.println("aName in excel:"+aName);
	String pName = (String)request.getParameter("progName"); 
	String spName = (String)request.getParameter("sprogName"); 
	String planName = (String)request.getParameter("PlanName");
		//System.out.println("planName in excel:"+planName);
	String workcName = (String)request.getParameter("workcName");
	String year = (String)request.getParameter("yrName");
	
	String dCode = (String)request.getParameter("district");
	String divCode = (String)request.getParameter("division"); 
	String subdivCode = (String)request.getParameter("subdivision"); 
	String planCode = (String)request.getParameter("plan"); 
	String workccode = (String)request.getParameter("work"); 
	String schCode = (String)request.getParameter("scheme");
	//System.out.println("planName in excel:"+planName);
	String aCode = (String)request.getParameter("augmentation");
	String pCode = (String)request.getParameter("programme"); 
	String spCode = (String)request.getParameter("subprogramme"); 
	String yearCode= (String)request.getParameter("year"); 

////System.out.println("workccode"+workccode);

int colcount=6;
Statement scheme=conn.createStatement();
Statement qhh=conn.createStatement();
Statement sh=conn.createStatement();
Statement stmt1=conn.createStatement();
String divname="";
String subdivname="";
String schname="";
String augname="";
String pname="";
String subprog="";
String yearval="";
String qury2="";

%>

<html>
<head>

<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<script>
  	window.history.forward(1);
  </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="17">Administrative Sanction Excel Report</td>	
	</tr>
	<tr bgcolor="#edf2f8">	
<%
if(dCode!=null && !dCode.equals(""))
   { 
   %>
	<td class="rptHeading" colspan="17" bgcolor="#edf2f8">District Name: <%=dName%></td></tr>
	<%
	if(divName!=null && !divName.equals("null"))
	{
	%>
		<tr><td class="rptHeading" colspan="17" bgcolor="#edf2f8">Division Name: <%=divName%></td></tr>
	<%
	}
	if(subdivName!=null && !subdivName.equals("null"))
	{
	%>
		<tr><td  class="rptHeading" colspan="17" bgcolor="#edf2f8">SubDivision Name:<%=subdivName%></td></tr>
	<%
	}
	
	if(schName!=null && !schName.equalsIgnoreCase("null"))
	{
			%>
		<tr><td class="rptHeading" colspan="17" bgcolor="#edf2f8">Schemeeeee: <%=schName%></td></tr>
	<%
	}
	if(aName!=null && !aName.equals("null"))
	{
	%>
	<tr><td class="rptHeading" colspan="17" bgcolor="#edf2f8">Augemntation: <%=aName%></td></tr>
	 
	<%
	}
	if(pName!=null && !pName.equals("null"))
	{
	%>
		<tr><td  class="rptHeading" colspan="17" bgcolor="#edf2f8">Programme Name: <%=pName%></td></tr>
	<%
	}	
	if(spName!=null && !spName.equals("null")) 
	{
	%>
	<tr><td  class="rptHeading" colspan="17" bgcolor="#edf2f8">SubProgramme Name: <%=spName%></td></tr> 
	<%		
	}
	if(yearCode!=null && !yearCode.equals("null") && !yearCode.equals("") ) 
	{
	%>
		<tr><td class="rptHeading" colspan="17" bgcolor="#edf2f8">Year: <%=yearCode %></td></tr>
	<% 
	}
	}
	if(planName!=null && !planName.equals("null"))
	{	
%>
<tr bgcolor="#edf2f8"><td class="rptHeading" colspan="17">Plan/Non-Plan &nbsp;&nbsp;&nbsp;&nbsp;:<%=planName%></td></tr>
<%	}
	if(workcName!=null  && !workcName.equals("null") && !workccode.equals(""))
	{	
%>
	<tr bgcolor="#edf2f8"><td class="rptHeading" colspan="17">WorkCategory&nbsp;&nbsp;&nbsp;&nbsp;:<%=workcName%></td></tr>
<%	}%>
	<%if(aName!=null && !aName.equals("null"))
	{	
%>
	<tr><td class="rptHeading" colspan="17" bgcolor="#edf2f8">MainScheme/Augumentation/Maintenance&nbsp;&nbsp;:<%=aName%></td></tr>
<%	}%> 
		
	</table>
	<table><tr><td></td></tr></table>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">

			<tr align=center bgcolor="#ffffff">
			<td class= "btext">S.NO</td>
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
	if(workcName==null || workcName.equals("null"))
	{
	colcount++;
	%>
	<td class="btext">Work Category</td>
<%	}	
	if(yearCode==null || yearCode.equals("null") || yearCode.equals("") ) 
	{
	//colcount++;
	%>
	<td class="btext">Year(Admin_Sanc)</td>
<%  }
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
<%	}%>	
	<td class="btext">Augumentation_Link</td>
<%
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
	//colcount++;
	%>
<td class="btext">Year(Admin_Sanc)</td>
<%  } %>  
			<td class="btext" >Sanction Amt<br>(Rs In Lakhs)</td>
			<td class="btext" >Programme Name (more than one prog)</td><%colcount++;%>
            <td class="btext" >Sanction amount (more than one prog)</td><%colcount++;%>
			<td class="btext">SanctionNo/SanctionDate</td>
		    <td class="btext">No_Of_Habs/<br>Schools/Labs</td>
			<td class="btext">Details </td>
			<td class="btext">Plain<br>Pop</td>
			<td class="btext">SC<br>Pop</td>
			<td class="btext">ST<br>Pop</td>
			<td class="btext">Total</td>
			<td class="btext">CoverageStatus</td>
			</tr>
<%	
try
{
	query="select distinct nvl(w.WORK_NAME,'-'), nvl(w.work_id,'-'),nvl(w.office_code,'-') as office_code,nvl(to_char(w.admin_date,'yyyy'),'-') as admin_date,decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation, decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,nvl(w.approved_under,'-') as approved_under,nvl(w.AUG_WORKID,'-') as aug_link,a.type_of_asset_code,substr(w.office_code,4,1),substr(w.office_code,5,2),nvl(a.type_of_asset_name,'-') as asset_name,w.category_code,w.aug_new_code,w.plan_code from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg,rws_asset_type_tbl a  where w.work_id=prg.work_id(+) and substr(w.work_id,7,2)=a.type_of_asset_code and work_cancel_dt is null";//and w.work_id='"+rswork.getString(2)+"'
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
	      query+=" and to_char(w.admin_date,'yyyy')='"+yearCode+"' ";
	  }
	
	query+=" order by substr(w.office_code,4,1),substr(w.office_code,5,2),a.type_of_asset_code,w.category_code,w.aug_new_code,w.plan_code";
	
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 	 //System.out.println("view queryssssss"+query);
	rs=stmt.executeQuery(query);
	rs.setFetchSize(1000);
	rs.last();
 	Count = rs.getRow();
	rs.beforeFirst();
	if(Count!=0)
	{
	while(rs.next())							                                                                   
	{
%>	
	    <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%>/<br><%=rs.getString(1)%></td>
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
	//System.out.println("querysss2:"+queryh);
	ResultSet rh=sh.executeQuery(queryh);
	if(rh.next())
	{
	if(divName==null || divName.equals("null"))
	{	
	divname=rh.getString(2);
	subdivname=rh.getString(4); 
%>
		<td class="rptValue" nowrap><%=rh.getString(2)%></td>		
<%  }
	if(subdivName==null || subdivName.equals("null"))
	{
%>
		<td class="rptValue" nowrap><%=rh.getString(4)%></td>		
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
	if(schName==null || schName.equals("null"))
	{
%>
	<td class="rptValue"><%=rs.getString(13)%></td>		
<%	}
	if(aName==null || aName.equals("null"))
	{
%>
	<td class="rptValue"><%=rs.getString(6)%></td>
<%	}%>
	<td class=rptValue align="center"><%=rs.getString(9)%></td>  
<%
     int sno=0,habs=1,habs1=0,serial=0,ha=1;
     
	String q="";
	String sp="";

	//System.out.println("asset:::"+rs.getString("type_of_asset_code"));
	if(rs.getString(2).substring(2,4).equals("00"))
	{
		q="select p.programme_code,p.programme_name,w.sanction_amount,to_char (admin_date,'dd/mm/yyyy') as admin_date,w.admin_no";
		if(rs.getString("type_of_asset_code").equals("11") )
		{
		q+=",no_of_schools as count";
		}
		else 	if(rs.getString("type_of_asset_code").equals("12") )
		{
			q+=",no_of_labs as count";
		}
		else
		{
			q+=",no_of_habs as count";
		}
		q+=",w.work_id from rws_work_admn_tbl w,rws_programme_tbl p where  p.programme_code=substr(w.work_id,1,2) and work_id='"+rs.getString(2)+"' ";
	}
		
	else
	{
		sp="yes"; 
		 q="select p.programme_code,p.programme_name,w.sanction_amount,to_char (admin_date,'dd/mm/yyyy') as admin_date,w.admin_no";
		if(rs.getString("type_of_asset_code").equals("11") )
		{
		q+=",no_of_schools as count";
		}
		else 	if(rs.getString("type_of_asset_code").equals("12") )
		{
			q+=",no_of_labs as count";
		}
		else
		{
			q+=",no_of_habs as count";
		}
		q+=",w.work_id,sp.subprogramme_code,sp.subprogramme_name from rws_work_admn_tbl w,rws_programme_tbl p,rws_subprogramme_tbl sp where  p.programme_code=sp.programme_code and p.programme_code=substr(w.work_id,1,2) and sp.subprogramme_code=substr (w.work_id,3,2) and work_id='"+rs.getString(2)+"' ";
	}	
	//System.out.println("q programme Code"+q);
	if(pCode!=null && !pCode.equals(""))
    {
	      q+=" and substr(w.work_id,1,2)='"+pCode+"' ";
      }
      if(spCode!=null && !spCode.equals(""))
      {
	      q+=" and substr(w.work_id,3,2)='"+spCode+"' ";
      }
	//q+=" group by w.programme_code, p.programme_name,nvl(w.SANCTION_AMOUNT,'0'),nvl(to_char (w.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.ADMIN_NO,'0'),w.work_id,sp.subprogramme_code,nvl(sp.subprogramme_name,'-')  order by nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";	
   //// //System.out.println("querye  "+q);
    ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    rr = ss.executeQuery(q);
    rr.setFetchSize(500);
	rr.last();
	habs1=rr.getRow();
	//.out.println("habCount$$$$$$$ "+rr.getRow());
	
	 if(habs1!=0)
	 {
		rr.beforeFirst();
		Statement ss5=null;
		ResultSet rss=null;
		 
			while(rr.next())
			{
			sno++;

	if(pName==null || pName.equals("null"))
	{
		if(rr.getString(2)!=null)
		{
			pname=rr.getString(2);
%>
				<td class="rptValue"><%=rr.getString(2)%></td>
<%		}else{%>
				<td class="rptValue">-</td>
<%		}
	}	
	if(spName==null || spName.equals("null"))
	{
	if(sp.equals("yes"))
	{
			subprog=rr.getString(9);
%>
		<td class="rptValue"><%=rr.getString(9)%></td>
<%	}
	else{%>
		<td class="rptValue">-</td>
<%
	}	
	} 
	if(yearCode==null || yearCode.equals("null") || yearCode.equals("") ) 
	{
	%>
	<td class="rptValue" ><%=rs.getString(4)%></td>
<%  } %> 
			<td class="rptValue" align="right"><%=rr.getFloat(3)%></td>	
  <%StringBuffer  ary=new StringBuffer("");
	  ary.append("select p.programme_name,sanction_amount from rws_work_admn_prog_lnk_tbl a,rws_programme_tbl p where a.programme_code=p.programme_code and work_id='"+rs.getString(2)+"' ");
	//System.out.println("ary:"+ary);
	  rs2=stmt1.executeQuery(ary.toString());
	  //colcount++;
	  if(rs2.next())
		{
		   
		  %>
		  <td class="rptValue" ><%=rs2.getString(1)%></td>
          <td class="rptValue" align="right"><%=rs2.getString(2)%></td>
		<%}
	  else {
		
		  %>
	         <td class="rptValue">-</td>
			 <td class="rptValue">-</td>
			 
	  <%}
          if(rs2!=null) rs2.close();
	 
	%>

			<td class="rptValue"><%=rr.getString(5)%>&nbsp;/ &nbsp;<%=rr.getString(4)%></td>
<%		 if(ha==habs1)
		 {
%>
		<td class=rptValue  align="center"><b><%=rr.getInt(6)%></b></td>
<%
			if(ha==habs1)
			{			
			//String qury2="select * from CensusPopulation where work_id='"+rs.getString(2)+"' and programme_code='"+rr.getString(1)+"' ";
			if(rs.getString("type_of_asset_code").equals("11"))
		   {
		      qury2="select distinct pr.panch_code as panch_code,nvl(pr.panch_name,'-') aspanch_name,nvl(CENSUS_PLAIN_POPU,'0') as CENSUS_PLAIN_POPU,nvl(CENSUS_SC_POPU,'0') as CENSUS_SC_POPU,nvl(CENSUS_ST_POPU,'0') as CENSUS_ST_POPU,nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') as total,nvl(coverage_status,'-') as coverage_status,ln.work_id as work_id,w.programme_code as programme_code,school_name  from RWS_PANCHAYAT_RAJ_TBL PR,rws_work_school_lnk_tbl  ln,rws_habitation_directory_tbl h,rws_work_admn_tbl w,rws_school_master_tbl s  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and h.coverage_status is not null and h.coverage_status<>'UI'  and w.work_id='"+rs.getString(2)+"' and s.school_code=ln.school_code and h.hab_code=s.hab_code order by pr.panch_code ";
		  }
		 else if(rs.getString("type_of_asset_code").equals("12"))
		    {
			  qury2="select distinct division_office_code ,nvl(division_office_name,'-'),lab_name  from rws_division_office_tbl d ,rws_work_lab_lnk_tbl ll,rws_water_quality_lab_tbl w  where ll.work_id='"+rs.getString(2)+"' and d.circle_office_code=substr(ll.work_id,5,2) and ll.lab_code=w.lab_code and substr(w.office_code,4,1)=d.division_office_code";
		  }
		else
			{
			   qury2="select distinct pr.panch_code as panch_code,nvl(pr.panch_name,'-') aspanch_name,nvl(CENSUS_PLAIN_POPU,'0') as CENSUS_PLAIN_POPU,nvl(CENSUS_SC_POPU,'0') as CENSUS_SC_POPU,nvl(CENSUS_ST_POPU,'0') as CENSUS_ST_POPU,nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') as total,nvl(coverage_status,'-') as coverage_status,ln.work_id as work_id,w.programme_code as programme_code  from RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,rws_work_admn_tbl w  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and h.coverage_status is not null and h.coverage_status<>'UI'  and w.work_id='"+rs.getString(2)+"' order by pr.panch_code ";//and programme_code='"+rr.getString(1)+"' ";
			}
			//System.out.println("qury2sssss"+qury2);
		 	ss5 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		    rss = ss5.executeQuery(qury2);
		   	rss.setFetchSize(500);
		    rss.beforeFirst();
			 
if(rss.isBeforeFirst())
   {
             if(rs.getString("type_of_asset_code").equals("12"))
			 {%>
				<td class=btext align=center>Division/Lab Name</td>
			<%}else	if(rs.getString("type_of_asset_code").equals("11")){%>
				<td class=btext align=center>Hab Name/School Name</td>
			<%}else	{%>
				<td class=btext align=center>Hab Name</td>
				</tr>
			<%}
		while(rss.next())
		{
			serial++;
			// //System.out.println("serial No  "+serial );
			
				if(rs.getString("type_of_asset_code").equals("11"))
				   {%>
					<tr>
					<td colspan=<%=colcount%>>

					<td class=rptValue><%=serial%>.&nbsp;<%=rss.getString(2)%>/<%=rss.getString(10)%></td>
					<td class=rptValue align="right"><%=rss.getInt(3)%></td>
					<td class=rptValue align="right"><%=rss.getInt(4)%></td>
					<td class=rptValue align="right"><%=rss.getInt(5)%></td>
					<td class=rptValue align="right"><%=rss.getInt(6)%></td>
					<td class=rptValue align="center" ><%=rss.getString(7)%></td>
					</tr>
				<%}else  if(rs.getString("type_of_asset_code").equals("12")){%>
						<tr>
						<td colspan=<%=colcount%>>
						<td class=rptValue><%=serial%>.&nbsp;<%=rss.getString(2)%>/<%=rss.getString(3)%></td>
						<td class=rptValue align="center">-</td>
						<td class=rptValue align="center">-</td>
						<td class=rptValue align="center">-</td>
						<td class=rptValue align="center">-</td>
						<td class=rptValue align="center">-</td>
						</tr>
				<%}else{%>
						<tr>
						<td colspan=<%=colcount%>>

						<td class=rptValue><%=serial%>.&nbsp;<%=rss.getString(2)%></td>
						<td class=rptValue align="right"><%=rss.getInt(3)%></td>
						<td class=rptValue align="right"><%=rss.getInt(4)%></td>
						<td class=rptValue align="right"><%=rss.getInt(5)%></td>
						<td class=rptValue align="right"><%=rss.getInt(6)%></td>
						<td class=rptValue align="center" ><%=rss.getString(7)%></td>
						</tr>
            <% }
			
		    
	   }
	   if(rss!=null) rss.close();
	   }
	   else
	   {
	  %>
			<td class=rptValue >&nbsp;-</td>
			<td class=rptValue align="center">-</td>
			<td class=rptValue align="center">-</td>
			<td class=rptValue align="center">-</td>
			<td class=rptValue align="center">-</td>
			<td class=rptValue align="center">-</td>

					
<%
	   }
	   }
	     
	   } 
	   else
	   {			 
%>
		<td colspan=6></td>
<%
       }
%>		
<% 	ha++; 
	}
	if(rr!=null)
		 rr.close();
	}
	
	
//*******************************************************************************************

	
	Statement s=null;
	ResultSet r=null;

	String q1="select distinct nvl(w.work_id,'-') as work_id,nvl(w.work_name,'-') as work_name,type_of_asset from RWS_REVISED_ADM_SANC_TBL w,rws_revised_adm_prog_lnk_tbl prg where w.work_id=prg.work_id(+) and w.work_id='"+rs.getString(2)+"'";
	//System.out.println("q1 in revised "+q1);
	s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    r= s.executeQuery(q1);
	r.setFetchSize(500);
	r.last();
	Counts = r.getRow();
	r.beforeFirst();
	
	if(Counts!=0)
	{
		while(r.next())
		{
%>	
	    <tr bgcolor="#ffffff">
		<td class="rptValue"></td>			
		<td class="rptValue"><b><%=r.getString(2)%><br>(Revised To)</b></td>
<%
	if(divName==null || divName.equals("null"))
	{	
%>
	<td class="rptValue"><%=rh.getString(2)%></td>		
<%  }
	if(subdivName==null || subdivName.equals("null"))
	{
%>
	<td class="rptValue"><%=rh.getString(4)%></td>		
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
	<td class="rptValue"><%=rs.getString(13)%></td>		
<%	}
	if(aName==null || aName.equals("null"))
	{
%>
	<td class="rptValue"><%=rs.getString(6)%></td>
<%	}
%>
 <td class=rptValue align="center"><%=rs.getString(9)%></td> 
<%
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
	
  		int sn=0,habss=1,habss1=0,serials=0,no1=0,haa=1;
		Statement s1=null;
		ResultSet r1=null;
	  	
	String q4="";
	String qury3="";
		Statement ss1=null;
	    ResultSet rr1=null;
//		String q4="select distinct w.programme_code as programme_code,p.programme_name as programme_name,nvl(w.Rev_SANCTION_AMOUNT,'0') as Rev_SANCTION_AMOUNT,nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') as REV_ADMIN_DATE,nvl(w.REV_ADMIN_NO,'0') as REV_ADMIN_NO,count(ln.hab_code) as count,w.work_id as work_id from RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_programme_tbl p,RWS_REVISED_ADM_SANC_TBL w where w.work_id=ln.work_id and w.programme_code=p.programme_code  and  w.work_id='"+rs.getString(2)+"'  group by w.programme_code, p.programme_name,nvl(w.Rev_SANCTION_AMOUNT,'0'),nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.REV_ADMIN_NO,'0'),w.work_id order by nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
          if(r.getString(3).equals("11"))
			{
		       q4="select distinct nvl(w.Rev_SANCTION_AMOUNT,'0') as Rev_SANCTION_AMOUNT ,nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') as REV_ADMIN_DATE,nvl(w.REV_ADMIN_NO,'0') as REV_ADMIN_NO,(no_of_schools) as count from  rws_rev_school_lnk_tbl ln,RWS_REVISED_ADM_SANC_TBL w where w.work_id=ln.work_id  and w.work_id='"+rs.getString(2)+"' order by nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
			}
			else  if(r.getString(3).equals("12"))
			{
               q4="select distinct nvl(w.Rev_SANCTION_AMOUNT,'0') as  Rev_SANCTION_AMOUNT,nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') as REV_ADMIN_DATE,nvl(w.REV_ADMIN_NO,'0') as REV_ADMIN_NO,(no_of_labs) as count,w.work_id as work_id from  rws_rev_lab_lnk_tbl  ln,RWS_REVISED_ADM_SANC_TBL w where w.work_id=ln.work_id  and w.work_id='"+rs.getString(2)+"' order by nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
			}
			else
			{
			  q4="select distinct nvl(w.Rev_SANCTION_AMOUNT,'0') as Rev_SANCTION_AMOUNT,nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') as REV_ADMIN_DATE,nvl(w.REV_ADMIN_NO,'0') as REV_ADMIN_NO,(no_of_habs) as count,w.work_id as work_id from RWS_REV_ADM_SANC_HAB_LNK_TBL ln,RWS_REVISED_ADM_SANC_TBL w where w.work_id=ln.work_id  and w.work_id='"+rs.getString(2)+"' order by nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
			}

		//System.out.println("q4 in revised"+q4);
        ss1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rr1 = ss1.executeQuery(q4);
        rr1.setFetchSize(500);
		rr1.last();
		habss1=rr1.getRow();
		if(habss1!=0)
		{
		rr1.beforeFirst();
		Statement st22=null;	
		ResultSet rss1=null;
		while(rr1.next())
		{
			sn++;
			if(haa==habss1)
			{
				if(r.getString(3).equals("11"))
				{
			      qury3="select distinct pr.panch_code as panch_code,nvl(pr.panch_name,'-') as panch_name,nvl(CENSUS_PLAIN_POPU,'0') as PLAIN_POPU,nvl(CENSUS_SC_POPU,'0') as SC_POPU,nvl(CENSUS_ST_POPU,'0') as ST_POPU,nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') as total,nvl(coverage_status,'-') as coverage_status,ln.work_id as work_id,w.programme_code as programme_code,school_name  from RWS_PANCHAYAT_RAJ_TBL PR,RWS_REV_school_LNK_TBL ln,rws_habitation_directory_tbl h,RWS_REVISED_ADM_SANC_TBL w ,rws_school_master_tbl s where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and h.coverage_status<>'UI' and h.coverage_status is not null and  w.work_id='"+rs.getString(2)+"' and s.school_code=ln.school_code and h.hab_code=s.hab_code order by pr.panch_code";
				}
				else if(r.getString(3).equals("12"))
				{
			       qury3="select distinct division_office_code ,nvl(division_office_name,'-'),lab_name  from rws_division_office_tbl d ,rws_rev_lab_lnk_tbl ll,rws_water_quality_lab_tbl w  where ll.work_id='"+rs.getString(2)+"' and d.circle_office_code=substr(ll.work_id,5,2) and ll.lab_code=w.lab_code and substr(w.office_code,4,1)=d.division_office_code";
				}
				else
				{
                   qury3="select distinct pr.panch_code as panch_code,nvl(pr.panch_name,'-') as panch_name,nvl(CENSUS_PLAIN_POPU,'0') as PLAIN_POPU,nvl(CENSUS_SC_POPU,'0') as SC_POPU,nvl(CENSUS_ST_POPU,'0') as ST_POPU,nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') as total,nvl(coverage_status,'-') as coverage_status,ln.work_id as work_id,w.programme_code as programme_code  from RWS_PANCHAYAT_RAJ_TBL PR,RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,RWS_REVISED_ADM_SANC_TBL w  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and h.coverage_status<>'UI' and h.coverage_status is not null and  w.work_id='"+rs.getString(2)+"'  order by pr.panch_code";
				}
			//System.out.println("qury3 in revised "+qury3);
			st22 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    	    rss1 = st22.executeQuery(qury3);
        	rss1.setFetchSize(500);
	        rss1.beforeFirst();
			}
%>		
		
		<td class="rptValue" align="right"><%=rr1.getFloat(1)%></td>	
		<td class="rptValue" align="right">-</td>	
			<td class="rptValue" align="right">-</td>	
		<td class="rptValue"><%=rr1.getString(3)%>&nbsp;/ &nbsp;<%=rr1.getString(2)%></td>
<%		 if(haa==habss1)
		 {
%>
		<td class=rptValue align="center"><b><%=rr1.getInt(4)%></b></td>
<% 
			while(rss1.next())
			{
			no1++;
		
				//if(no1==1)
				//{
			if(r.getString(3).equals("11"))
			{%>
				<tr>
				<td colspan=<%=colcount%>>
				<td class=rptValue ><%=no1%>.&nbsp;<%=rss1.getString(2)%>/<%=rss1.getString(10)%></td>
				<td class=rptValue align="right"><%=rss1.getString(3)%></td>
				<td class=rptValue align="right"><%=rss1.getString(4)%></td>
				<td class=rptValue align="right"><%=rss1.getString(5)%></td>
				<td class=rptValue align="right"><%=rss1.getString(6)%></td>
				<td class=rptValue align="center"><%=rss1.getString(7)%></td>
				</tr>
			<%}else if(r.getString(3).equals("12")){%>
				<tr>
				<td colspan=<%=colcount%>>
				<td class=rptValue ><%=no1%>.&nbsp;<%=rss1.getString(2)%>/<%=rss1.getString(3)%></td>
				<td class=rptValue align="right">-</td>
				<td class=rptValue align="right">-</td>
				<td class=rptValue align="right">-</td>
				<td class=rptValue align="right">-</td>
				<td class=rptValue align="right">-</td>
				</tr>
			<%}else {%>
				<tr>
				<td colspan=<%=colcount%>>
				<td class=rptValue ><%=no1%>.&nbsp;<%=rss1.getString(2)%></td>
				<td class=rptValue align="right"><%=rss1.getString(3)%></td>
				<td class=rptValue align="right"><%=rss1.getString(4)%></td>
				<td class=rptValue align="right"><%=rss1.getString(5)%></td>
				<td class=rptValue align="right"><%=rss1.getString(6)%></td>
				<td class=rptValue align="center"><%=rss1.getString(7)%></td>
				</tr>
<% }
	
 		} 
	   if(rss1!=null)
		   rss1.close();
	   
			
	   } 
		 else
			{
			 
%>
		<td colspan=6></td>
<%		 	
			}
%>
	</tr>
	<tr>
		<td colspan=3>
	</tr>
<%	 haa++; 
	}
    
	if(rr1!=null)
		rr1.close();
	}

	}
	if(r!=null)
		 r.close();
	
	}
	//********************************************************************************
}//end of main while
if(rs!=null)
    rs.close();


// close of main resultset
}
else
{	
%>
	 <tr bgcolor="#ffffff">
	 <td colspan=7></td>
	 <tr>
		<td class=rptValue colspan=7 align=center><a href="./rws_admn_status_form.jsp"><b>No Records</b></a></td>
	</tr>
<% }
//} 
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		conn.close();
	
		if(ss!=null)
		 ss.close();
		
	}
%>
</table>
<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>
<input type="hidden" name="pass"> 
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
