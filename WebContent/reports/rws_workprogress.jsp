<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%	
	Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null,stmt3=null;
	Statement ste1 = null,ste2=null,stmte=null,sse1=null,wid=null;
	Statement st2 = null,st22=null,ss1=null,swc=null,pns=null;
	ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null,wcrs=null,pnrs=null,rapp=null,wrs=null;
	Statement stmt1 = null;
	ResultSet rs1 = null,rse=null;
	ResultSetMetaData rsm=null;
	String query=null,query2=null,querywc=null,querypn=null,qurysdd=null;
	//String[] record = null;
	int Count=0,Cnt=0,slno=0,sl=0,Counts=0,ano=0;
	//int start,end,limit = 3;
	//String assetType = request.getParameter("aType");
	
	String dName = String.valueOf(session.getAttribute("dName"));
	if( dName == null || dName.equals("") )
	{
		session.setAttribute("dName",dName);
	}
	String dCode = String.valueOf(session.getAttribute("dCode"));
//	System.out.println("dCode:"+dCode);
    if( dCode == null || dCode.equals("") )
	{
		session.setAttribute("dCode",dCode);
	}
	String divName = String.valueOf(session.getAttribute("divName"));

	String divCode = String.valueOf(session.getAttribute("divCode"));
	//System.out.println("divCode:"+divCode);
	String subdivName = String.valueOf(session.getAttribute("subdivName"));
	String subdivCode = String.valueOf(session.getAttribute("subdivCode"));
//System.out.println("subdivCode:"+subdivCode);
	String schName = String.valueOf(session.getAttribute("schName"));
	if( schName == null || schName.equals("") )
	{
		session.setAttribute("schName",schName);
	}
	//System.out.println("schName  in main 1:"+schName);
	String schCode = String.valueOf(session.getAttribute("schCode"));	
	String aName = String.valueOf(session.getAttribute("augCode"));
//System.out.println("Work Categoryaaaaannn:"+aName);
	String aCode = String.valueOf(session.getAttribute("augName"));	
	//System.out.println("Work Categoryaaaaacccc:"+aCode);
	String pName = String.valueOf(session.getAttribute("progName")); 
	String pCode = String.valueOf(session.getAttribute("progCode")); 
	String spName = String.valueOf(session.getAttribute("sprogName")); 
	String spCode = String.valueOf(session.getAttribute("sprogCode")); 	 
	String wName = String.valueOf(session.getAttribute("worksName")); 
	String wCode = String.valueOf(session.getAttribute("worksCode")); 	
	String planCode = String.valueOf(session.getAttribute("PlanCode"));
	String planName = String.valueOf(session.getAttribute("PlanName"));
//System.out.println("Work Categoryppppp:"+planName);
	String workcCode = String.valueOf(session.getAttribute("workcCode"));
	//System.out.println("Work Category:"+workcCode);
	String workcName = String.valueOf(session.getAttribute("workcName"));
	//System.out.println("Work Category:"+workcName);
	
	//////////System.out.println("work code Befor"+wCode);
	////System.out.println("work Name"+wName);
	
//	////System.out.println("Div Name"+divName);
	if(divName==null || divName.equals("null"))
	{
		divName=" -";
	}
	if(subdivName==null || subdivName.equals("null"))
	{
		subdivName=" -";
	}
	if(schName==null || schName.equals("null"))
	{
		schName=" -";
	}
	if(aName==null || aName.equals("null"))
	{
		aName=" -";
	}
	if(pName==null || pName.equals("null"))
	{
		pName=" -";
	}	
	if(spName==null || spName.equals("null")) 
	{
		spName=" -";
	}
	if(wName==null || wName.equals("null"))
	{
		wName=" -";
	}
	
	
try
{
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
				<td class="bwborder"><a href="./rws_integrated_rpt.jsp?mode=init">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=24>Work Progress Integrated Report</td>	
</tr>

<%   
String workCategory=null;
String divisionName=null;
String Plan=null;
String Category=null;
String Augumentation=null;

/*String workidquery="select distinct nvl(w.WORK_NAME,'-'), nvl(w.work_id,'-') from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg where w.work_id=prg.work_id(+) ";//and w.work_id='"+wCode+"'" ;
      if(schName!=null && !schName.equals(""))
      {
	      workidquery+=" and substr(w.work_id,7,2)='"+schCode+"' ";
      }
      if(aName!=null && !aName.equals(""))
      {
	      workidquery+=" and w.AUG_NEW_CODE ='"+aCode+"'  ";
      }
      if(pName!=null && !pName.equals(""))
      {
	      workidquery+=" and substr(w.work_id,1,2)='"+pCode+"' ";
      }
      if(spName!=null && !spName.equals(""))
      {
	      workidquery+=" and substr(w.work_id,3,4)='"+spCode+"' ";
      }
      //System.out.println("Query WorkId "+workidquery);
	wid = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	wrs=wid.executeQuery(workidquery);
	if(wrs.next())
	{
		wName=rs.getString(1);	
		wCode=rs.getString(2);	
	}	

*/
 /*swc = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 querywc="select work_category from rws_subprogramme_tbl where programme_code=substr('"+wCode+"',1,2) and subprogramme_code=substr('"+wCode+"',3,2)"; 	
 wcrs=swc.executeQuery(querywc);
 while(wcrs.next())
 {
   	workCategory=wcrs.getString(1);
   	////System.out.println("workCategory"+workCategory);
 }
   	 */
   pns = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
   //querypn="SELECT D.DIVISION_OFFICE_NAME,decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation,decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category FROM RWS_DIVISION_OFFICE_TBL D,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID='"+wCode+"' AND SUBSTR(W.OFFICE_CODE,1,1) =D.HEAD_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,2,2)=D.CIRCLE_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,4,1)=D.DIVISION_OFFICE_CODE"; 
	//querypn = "SELECT D.DIVISION_OFFICE_NAME,SD.SUBDIVISION_OFFICE_NAME,decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation,decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,A.TYPE_OF_ASSET_NAME,P.PROGRAMME_NAME,SP.SUBPROGRAMME_NAME  FROM RWS_DIVISION_OFFICE_TBL D,RWS_SUBDIVISION_OFFICE_TBL SD,RWS_WORK_ADMN_TBL W,rws_ASSET_TYPE_TBL A,RWS_PROGRAMME_TBL P,RWS_SUBPROGRAMME_TBL SP WHERE P.PROGRAMME_CODE=W.PROGRAMME_CODE AND P.PROGRAMME_CODE=SP.PROGRAMME_CODE AND SP.SUBPROGRAMME_CODE=W.SUBPROGRAMME_CODE AND A.TYPE_OF_ASSET_CODE=SUBSTR(W.WORK_ID,7,2) AND W.WORK_ID='"+wCode+"' AND SUBSTR(W.OFFICE_CODE,1,1) =D.HEAD_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,2,2)=D.CIRCLE_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,4,1)=SD.DIVISION_OFFICE_CODE(+) AND SUBSTR(W.OFFICE_CODE,1,1) =SD.HEAD_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,2,2)=SD.CIRCLE_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,4,1)=SD.DIVISION_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,5,2)=SD.SUBDIVISION_OFFICE_CODE AND D.DIVISION_OFFICE_CODE=SD.DIVISION_OFFICE_CODE";
	querypn="SELECT D.DIVISION_OFFICE_NAME,SD.SUBDIVISION_OFFICE_NAME,decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation,decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,A.TYPE_OF_ASSET_NAME,P.PROGRAMME_NAME,SP.SUBPROGRAMME_NAME  FROM RWS_DIVISION_OFFICE_TBL D,RWS_SUBDIVISION_OFFICE_TBL SD,RWS_WORK_ADMN_TBL W,rws_ASSET_TYPE_TBL A,RWS_PROGRAMME_TBL P,RWS_SUBPROGRAMME_TBL SP WHERE P.PROGRAMME_CODE=W.PROGRAMME_CODE AND P.PROGRAMME_CODE=SP.PROGRAMME_CODE AND SP.SUBPROGRAMME_CODE=W.SUBPROGRAMME_CODE AND A.TYPE_OF_ASSET_CODE=SUBSTR(W.WORK_ID,7,2) AND W.WORK_ID='"+wCode+"' AND SUBSTR(W.OFFICE_CODE,1,1) =D.HEAD_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,2,2)=D.CIRCLE_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,4,1)=SD.DIVISION_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,1,1) =SD.HEAD_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,2,2)=SD.CIRCLE_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,4,1)=SD.DIVISION_OFFICE_CODE AND SUBSTR(W.OFFICE_CODE,5,2)=SD.SUBDIVISION_OFFICE_CODE AND D.DIVISION_OFFICE_CODE=SD.DIVISION_OFFICE_CODE and substr(office_code,5,2)<>'00' union SELECT D.DIVISION_OFFICE_NAME,'-',decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation,decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,A.TYPE_OF_ASSET_NAME,P.PROGRAMME_NAME,SP.SUBPROGRAMME_NAME  FROM RWS_DIVISION_OFFICE_TBL D,RWS_WORK_ADMN_TBL W,rws_ASSET_TYPE_TBL A,RWS_PROGRAMME_TBL P,RWS_SUBPROGRAMME_TBL SP WHERE P.PROGRAMME_CODE=W.PROGRAMME_CODE AND P.PROGRAMME_CODE=SP.PROGRAMME_CODE AND SP.SUBPROGRAMME_CODE=W.SUBPROGRAMME_CODE AND A.TYPE_OF_ASSET_CODE=SUBSTR(W.WORK_ID,7,2) AND W.WORK_ID='"+wCode+"' AND SUBSTR(W.OFFICE_CODE,2,2)=D.CIRCLE_OFFICE_CODE and SUBSTR(W.OFFICE_CODE,2,2)=D.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=d.division_office_code and substr(office_code,5,2)='00'";
	//System.out.println("query:: in main:::"+querypn);
   pnrs=pns.executeQuery(querypn);
   while(pnrs.next())
   {
	   divisionName=pnrs.getString("DIVISION_OFFICE_NAME");
	   divName = divisionName;
	   subdivName = pName =pnrs.getString("subdivision_office_name");
	   Plan=pnrs.getString("plan");
	   Category=pnrs.getString("category");
	  // System.out.println("category:::::::::"+Category);
	   Augumentation=pnrs.getString("Augumentation");
	   	//   System.out.println("Augumentation:::::::::"+Augumentation);
	   schName = pnrs.getString("TYPE_OF_ASSET_NAME");
	   	 //  System.out.println("schName:::ssss::::::"+schName);
		   if( schName == null || schName.equals("null") )
	{
		schName = request.getParameter("schName");
		// System.out.println("schName:::ssss::::22::"+schName);
		session.setAttribute("schName",schName);
	}
	   pName =pnrs.getString("programme_name");
	   spName =pnrs.getString("subprogramme_name");
	  
   }
   if(dCode!=null&&!dCode.equals("-1")&& divCode.equals("") && subdivCode.equals(""))
   { //System.out.println("in district selection");
%>
	<tr bgcolor="#edf2f8" >
		<td  class="rptHeading" colspan=12>District Name&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;: <%=dName%>&nbsp;&nbsp;&nbsp;&nbsp;</td><td class="rptHeading" colspan=6>Scheme&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=schName%></td></tr>
		<tr bgcolor="#edf2f8"><td class="rptHeading" colspan=12>Division Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=divName%></td><td class="rptHeading" colspan=6>Work Category&nbsp;&nbsp;: <%=Category%></td></tr>
		<tr bgcolor="#edf2f8"><td  class="rptHeading" colspan=12>Work  ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=wCode%></td>
 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<td  class="rptHeading" colspan=6>Work Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=wName%></td>
		<tr bgcolor="#edf2f8"><td  class="rptHeading" colspan=12>Programme Name: <%=pName%></td><td  class="rptHeading" colspan=6>SubProgramme Name: <%=spName%></td>
	</tr>
<%	}
	else if(dCode!=null &&!dCode.equals("-1") && !divCode.equals("") && subdivCode.equals(""))
	{ //System.out.println("in division selection");
%>
	<tr bgcolor="#edf2f8" >
		<td  class="rptHeading" colspan=12>District Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=dName%>&nbsp;&nbsp;&nbsp;&nbsp;</td><td class="rptHeading" colspan=6>Scheme&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=schName%></td></tr bgcolor="#edf2f8">
		<tr bgcolor="#edf2f8"><td class="rptHeading" colspan=12>Division Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=divName%></td><td class="rptHeading" colspan=6>Work Category&nbsp;&nbsp;: <%=workcName%></td></tr>
		<tr bgcolor="#edf2f8"><td class="rptHeading" colspan=12>Work  ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=wCode%></td>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<td  class="rptHeading" colspan=6>Work Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=wName%></td>
		<tr bgcolor="#edf2f8"><td  class="rptHeading" colspan=12>Programme Name: <%=pName%></td><td  class="rptHeading" colspan=6>SubProgramme Name: <%=spName%></td>
<%
	} else if(dCode!=null && !dCode.equals("") && !divCode.equals("") && !subdivCode.equals(""))
	{//System.out.println("in sub division selection");
	%>
		<tr bgcolor="#edf2f8" >
		<td  class="rptHeading" colspan=12>District Name&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;: <%=dName%>&nbsp;&nbsp;&nbsp;&nbsp;</td><td class="rptHeading" colspan=12>Scheme&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=schName%></td></tr bgcolor="#edf2f8">
		<tr bgcolor="#edf2f8"><td  class="rptHeading" colspan=12>Division Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=divName%></td><td class="rptHeading" colspan=12>Work Category&nbsp;&nbsp;: <%=Category%></td></tr>
		<tr bgcolor="#edf2f8"><td  class="rptHeading" colspan=12>SubDivision Name:<%=subdivName%></td><td class="rptHeading" colspan=12 ></td></tr>
		<tr bgcolor="#edf2f8"><td  class="rptHeading" colspan=12 nowrap>Work  ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<%=wCode%></td>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<td  class="rptHeading" colspan=12>Work Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=wName%></td>
		<tr bgcolor="#edf2f8"><td  class="rptHeading" colspan=12>Programme Name: <%=pName%></td><td  class="rptHeading" colspan=12>SubProgramme Name: <%=spName%></td>
	<%}%>
	</tr>
	<tr bgcolor="#edf2f8"><td class="rptHeading" colspan=12>Plan/Non-Plan &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<%=Plan%></td><td class="rptHeading" colspan=8>MainScheme/Augumentation/Maintenance&nbsp;&nbsp;:<%=Augumentation%></td></tr>
	</table>
<%session.setAttribute("schName",schName);
	//System.out.println("schName  in main 2:"+schName);
	
	%>
		<%@ include file="./rws_admin_chklist.jsp" %>
	   	<%@ include file="./rws_tech_chklist.jsp"%>
 	   	<%@ include file="./rws_Source_chklist.jsp"%>
		<%@ include file="./rws_contract_chklist.jsp"%>
		<%@ include file="./rws_programsched_chklist.jsp"%>
		<%@ include file="./rws_workexpenditure_chklist.jsp"%>
		<%@ include file="./rws_workcompletion_chklist.jsp"%>
		<%@ include file="./rws_ddws_checklist.jsp" %>
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
<center><font color="navy" size=3><b>Designed & Developed by National Informatics Centre, AP State Centre</b></font></center>
</html>
