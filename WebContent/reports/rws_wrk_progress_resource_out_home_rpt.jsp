<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<%@ include file ="conn.jsp" %>
<%	
	Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null;
	Statement ste1 = null,ste2=null,stmte=null,sse1=null;
	Statement st2 = null,st22=null,ss1=null,swc=null,pns=null;
	ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null,wcrs=null,pnrs;
	Statement stmt1 = null;
	ResultSet rs1 = null,rse=null;
	ResultSetMetaData rsm=null;
	String query=null,query2=null,querywc=null,querypn=null;
	//String[] record = null;
	int Count=0,Cnt=0,slno=0,sl=0,Counts=0,ano=0;
	//int start,end,limit = 3;
	//String assetType = request.getParameter("aType");
	
	//String dCode = request.getParameter("dcode");
	//String schCode = request.getParameter("scheme");
	String wCode = request.getParameter("work_id");
	String qurysdd="";
	
	//// ////System.out...println("programme Name "+pName);
	 
	 
try
{
%>	

<html>
<head>
 <script>
   // window.history.forward(1);
 </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.back(-1)">Back&nbsp;</a>
				<td class="bwborder"><a href="/pred/rws_login_frm.jsp">Home</a></td>
				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=18>Work Progress Integrated Report</td>	
</tr>

</table>
        <table>
		 <%String wid=request.getParameter("work_id");
        // //System.out..println("wid:"+wid);
		 String qry="select distinct work_name,programme_name,subprogramme_name,decode(aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') ,decode(plan_code,'1','PLAN','2','NON-PLAN','-'),decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-'),type_of_asset_name from rws_work_admn_tbl w,rws_programme_tbl p,rws_subprogramme_tbl s,rws_asset_type_tbl at where w.programme_code=p.programme_code and s.programme_code=p.programme_code and  w.programme_code=s.programme_code  and w.subprogramme_code=s.subprogramme_code and work_id='"+wid+"' and at.type_of_asset_code=substr(work_id,7,2) ";
		
         stmt=conn.createStatement();
		 ////System.out..println("qry:"+qry);
		 rs=stmt.executeQuery(qry);
		 if(rs.next())
	   {%>
            <tr><td class=btext>Work:<font face="verdana" size="2" color="black"> <%=wid%>-<%=rs.getString(1)%></font></td></tr>
			<tr><td  class=btext>Program:<font face="verdana" size="2" color="black"><%=rs.getString(2)%> </font> &nbsp;SubProgram:<font face="verdana" size="2" color="black"><%=rs.getString(3)%> </font></td></tr>
			 <tr><td class=btext>Plan/NonPlan:<font face="verdana" size="2" color="black"><%=rs.getString(5)%> </font> &nbsp; Type:<font face="verdana" size="2" color="black"><%=rs.getString(4)%> </font></td></tr> 
			 <tr><td class=btext>Work Category:<font face="verdana" size="2" color="black"><%=rs.getString(6)%> </font></td></tr>
 			 <tr><td class=btext>Scheme:<font face="verdana" size="2" color="black"><%=rs.getString("type_of_asset_name")%> </font></td></tr>
	   <%}
	   String qry1="select programme_name,subprogramme_name from rws_work_admn_prog_lnk_tbl w,rws_programme_tbl p,rws_subprogramme_tbl s where w.programme_code=p.programme_code and s.programme_code=p.programme_code and  w.programme_code=s.programme_code  and w.sub_programme_code =s.subprogramme_code and  work_id='"+wid+"' ";
	   Statement stmtl=conn.createStatement();
	   ////System.out..println("qry1:"+qry1);
	   ResultSet rsl=stmtl.executeQuery(qry1);
	   if(rsl.next())
	    { %>
            <tr><td class=btext>&nbsp;More than 1 Program:<font face="verdana" size="2" color="black"><%=rsl.getString(1)%> </font></td></tr>
			<tr><td class=btext>&nbsp;More than 1 SubProgram:<font face="verdana" size="2" color="black"><%=rsl.getString(2)%> </font></td></tr>
		<%}else{%>
		    &nbsp;
		<%}
		 if(rs!=null) rs.close();
		  if(stmt!=null) stmt.close();
		  if(rsl!=null) rsl.close();
		  if(stmtl!=null) stmtl.close();
		  %></table>
		<%--  <%@ include file="./rws_tech_chklist.jsp"%>
		 	<%@ include file="./rws_admin_chklist.jsp" %>
	   <%@ include file="./rws_tech_chklist.jsp"%>
		<%@ include file="./rws_workcompletion_chklist.jsp"%>
		<%@ include file="./rws_contract_chklist.jsp"%>
		<%@ include file="./rws_programsched_chklist.jsp"%>
		<%@ include file="./rws_workexpenditure_chklist.jsp"%>
		<%@ include file="./rws_scheme_integration_details_rpt.jsp"%>
		<%@ include file="./rws_wrk_commission_details.jsp"%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%@ include file="./rws_work_bill_details.rpt.jsp"%> --%>
		
		
		<%@ include file="/reports/rws_admin_chklist.jsp" %>
	   	<%@ include file="/reports/rws_tech_chklist.jsp"%>
		<%@ include file="/reports/rws_workcompletion_chklist.jsp"%>
		<%@ include file="/reports/rws_contract_chklist.jsp"%>
		<%@ include file="/reports/rws_programsched_chklist.jsp"%>
		<%@ include file="/reports/rws_workexpenditure_chklist.jsp"%>
		<%@ include file="/reports/rws_scheme_integration_details_rpt.jsp"%>
		<%@ include file="/reports/rws_wrk_commission_details.jsp"%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%@ include file="/reports/rws_work_bill_details.rpt.jsp"%>
		
<%
}//end of try brace
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		conn.close();
	}
%>

</form>
</body>

</html>
