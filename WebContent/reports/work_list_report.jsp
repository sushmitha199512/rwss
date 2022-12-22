<%@ include file="/commons/rws_header1.jsp"%>

<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
	    DecimalFormat ndf = new DecimalFormat("####.00");
    String currentYear= dateFormat.format(currentDate).substring(0,4);
    String currentMonth = dateFormat.format(currentDate).substring(5,7);
    //stem.out.println("The Current Month::"+currentMonth);
    int nextYear = Integer.parseInt(currentYear);
    nextYear++;
    String nextYear1 = ""+nextYear;
    String currentYearPeriod = currentYear + "-" + nextYear1;
    float gepreyrdrsub1=0,geprevdrsub1=0;
    java.util.Date d1 = dateFormat.parse(currentYear+"-03-31");
    String financialYearFrom="";
    String financialYearTo="";
    if(currentDate.after(d1))
    {
    financialYearFrom="01-APR-"+currentYear;
    financialYearTo="31-Mar-"+(Integer.parseInt(currentYear)+1);
    }
    else
    {
    financialYearTo="01-APR-"+(Integer.parseInt(currentYear)-1);
    financialYearFrom="31-Mar-"+currentYear;
    }
    String catCode = request.getParameter("catCode");
	////////System.out.println("Cat code:"+catCode);
	String catName = "";
	if(catCode!=null && catCode.equals("1"))
	{
		catName = " PROJECT ";
	}
	else if(catCode!=null && catCode.equals("2"))
	{
		catName = " NORMAL ";
	}
	else if(catCode!=null && catCode.equals("3"))
	{
		catName = " DISTRICT LEVEL ";
	}
	session.setAttribute("catCode",catCode);
	session.setAttribute("catName",catName);
	String planCode = request.getParameter("planNonplan");
	////////System.out.println("planCode:"+planCode);
	String planQry = "";
	String planName = "PLAN & NON PLAN";
	if(planCode!=null && planCode.equals("1"))
	{
		planQry = "and plan_code = '1'";
		planName = " PLAN ";
	}
	else if(planCode!=null && planCode.equals("2"))
	{
		planQry = "and plan_code = '2'";
		planName = " NON PLAN ";
	}
	    String financialyr="";
    String fixYear ="",fixNextYear="";

	
	String rDistrict="", rConstituency="", rMandal="", rPanchayat="", rVillage="", rHabitation="", distvalue="", distname="", conname="", convalue="", manvalue="", manname="", panvalue="", panname="", vilvalue="", vilname ="";
	
	rDistrict = request.getParameter("district");
	rConstituency = request.getParameter("constituency");
	String query3="",query4="",query5="",hab="",hab_code="";
	
	String districtName="",mandalName="",panchayatName="",villageName="",constituencyName="",habitationName="",work_id="",workCategory="",programName = "",subprogramCode="",divisionCode="",divname="",subdivisionCode="",subdivname="";
	if(request.getParameter("work_id")!=null)
	{
	work_id = request.getParameter("work_id");
	session.setAttribute("work_id",work_id);
	}
	if(request.getParameter("hab_code")!=null)
	{
	hab_code = request.getParameter("hab_code");
	session.setAttribute("hab_code",hab_code);
	}
	
	if(request.getParameter("hab")!=null)
	{
	hab = request.getParameter("hab");
	session.setAttribute("hab",hab);
	}
	//System.out.println("Hab:"+hab);
	if(request.getParameter("district")!=null)
	{
	rDistrict = request.getParameter("district");
	session.setAttribute("rDistrict",rDistrict);
	}
	if(request.getParameter("division")!=null)
	{
	divisionCode = request.getParameter("division");
	session.setAttribute("divisionCode",divisionCode);
	}
	if(request.getParameter("divname")!=null)
	{
	divname = request.getParameter("divname");
	session.setAttribute("divname",divname);
	}
	if(request.getParameter("subdivision")!=null)
	{
	subdivisionCode = request.getParameter("subdivision");
	session.setAttribute("subdivisionCode",subdivisionCode);
	}
	if(request.getParameter("subdivname")!=null)
	{
	subdivname = request.getParameter("subdivname");
	session.setAttribute("subdivname",subdivname);
	}
	 if(request.getParameter("finyear")!=null){
    financialyr=request.getParameter("finyear");
    session.setAttribute("financialyr",financialyr);
    } else{
    financialyr=(String)session.getAttribute("financialyr");
    
    }
	   // ////////System.out.println("finyear"+financialyr);
	 if(financialyr!=null && financialyr.equals("2011-12")){    
    fixYear = "01-Apr-2011";
	fixNextYear = "01-Apr-2012";
    }
	 else  if(financialyr!=null && financialyr.equals("2010-11")){    
    fixYear = "01-Apr-2010";
	fixNextYear = "01-Apr-2011";
    }
  else if(financialyr!=null && financialyr.equals("2009-10")){    
    fixYear = "01-Apr-2009";
	fixNextYear = "01-Apr-2010";
    }
    else {fixYear = "01-Apr-2008";
	fixNextYear = "01-Apr-2009";}
	districtName = (String)session.getAttribute("districtName");
	constituencyName = (String)session.getAttribute("constituencyName");	
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	ResultSet rs2 = null,prevrs=null,san=null;
	Statement stmt1 = null,prev=null,sss=null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
	boolean flag=true,flag1=false,flagp=true,flagn=true,flagd=true;
	
	int gnspills=0,gspills=0,gtspills=0,ghabsan=0,gtsno=0,gcomp=0,gcomm=0,ghabcov=0,gten=0,gagree=0,ggrnd=0;
	float gnspillamt=0,gspillamt=0,gtspamt=0,grevamt=0,gepreyr=0,geprev=0,gedur=0,gcum=0,getot=0;
	

try
{
%>
<html>
<head>
<!-- 
<script>
	window.history.forward(1);
</script>
 -->
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			

	<% 
	//////System.out.println("hab value::"+hab);
	if(!hab.equals("1") && !hab.equals("2"))
	{
		Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null;
       // System.out.println("Work Id Report start here11111111111111111");
	   %>
	  
		</table>
	</caption>
	   	<%@ include file="rws_worksmonitoring_work_id_report.jsp"%>
<%
	try
		{
	String view1="SELECT work_id,office_code,no_of_habs FROM RWS_WORK_ADMN_TBL W where w.category_code='"+catCode+"' "+planQry+" and w.ADMIN_DATE < '"+fixYear+"'  and SUBSTR (w.office_code,2,2)='"+rDistrict+"' and SUBSTR(w.office_code,4,1)='"+divisionCode+"' and SUBSTR(w.office_code,5,2)='"+subdivisionCode+"' and w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '"+fixYear+"')) union SELECT work_id,office_code,no_of_habs FROM RWS_WORK_ADMN_TBL W where w.category_code='"+catCode+"' "+planQry+" and w.ADMIN_DATE >= '"+fixYear+"' and SUBSTR (w.office_code,2,2)='"+rDistrict+"' and SUBSTR(w.office_code,4,1)='"+divisionCode+"' and SUBSTR(w.office_code,5,2)='"+subdivisionCode+"'";
		Statement stmtv1= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
 	   ////System.out.println(view1);
	    	//   //////System.out.println(view2);
 	   ResultSet totalrs = stmtv1.executeQuery(view1);
 	  // 	stmtv2.executeUpdate(view2);
String qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",qry7="";
while(totalrs.next())
		{
	//////System.out.println("next tr");
		%>
		<tr>

		<%
			qry1 = "select distinct nvl(w.work_id,'-'),nvl(w.WORK_NAME,'-') from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg where w.work_id='"+totalrs.getString(1)+"'";
			qry1 = "select distinct nvl(work_id,'-'),nvl(WORK_NAME,'-') ,b.programme_name,c.subprogramme_name,no_of_habs from rws_work_admn_tbl a,rws_programme_tbl b,rws_subprogramme_tbl c where work_id='"+totalrs.getString(1)+"' and b.programme_code='"+totalrs.getString(1).substring(0,2)+"' and b.programme_code=c.programme_code and c.subprogramme_code='"+totalrs.getString(1).substring(2,4)+"'";
		//////System.out.println("qry1:"+qry1);
		if(stmt1!=null)stmt1.close();
  		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs1=stmt1.executeQuery(qry1);
  		if(rs1.next())
		{
			//////System.out.println("1");
  	%>
		<td class=rptValue ><%=++slno%></td>
		<td class=rptValue ><%=rs1.getString(1)%></td>
		<td class=rptValue ><%=rs1.getString(2)%></td>
		<td class=rptValue ><%=rs1.getString(3)%></td>
		<td class=rptValue ><%=rs1.getString(4)%></td>

		<%

		qry2 = "select nvl(prg.ADMIN_NO,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.SANCTION_AMOUNT,'0') from rws_work_admn_tbl prg where prg.work_id="+rs1.getString(1)+"";
//		//////System.out.println("THe 2nd Query is::"+qry2);		
		if(stmt2!=null)stmt2.close();
		stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs2=stmt2.executeQuery(qry2);
		if(rs2.next())
		{
%>
		<td class=rptValue ><%=rs2.getString(1)%></td>
		<td class=rptValue  nowrap><%=rs2.getString(2)%></td>
		<td class=rptValue ><%=rs2.getString(3)%></td>
		
	<%
 		 }
 		 else
 		 {
 		 %>
			<td class=rptValue ><center>-</center></td>
			<td class=rptValue ><center>-</center></td> 		 			
			<td class=rptValue ><center>-</center></td>

 		 <%
 		 }
		 String qq=" select programme_name,subprogramme_name from RWS_WORK_ADMN_PROG_LNK_TBL  a,rws_programme_tbl p,rws_subprogramme_tbl s	where a.programme_code=p.programme_code and  p.programme_code=s.programme_code and  work_id='"+rs1.getString(1)+"' ";
      Statement  stmtqq = conn.createStatement();
	  ////System.out.println("THe qq Query is::"+qq);		
		ResultSet rsqq=stmtqq.executeQuery(qq);
		if(rsqq.next()){
			%>
			<td class=rptValue ><center><%=rsqq.getString(1)%></center></td>
			<td class=rptValue ><center><%=rsqq.getString(2)%></center></td> 		 			
		<%
		}else{%>
			<td class=rptValue ><center>-</center></td>
			<td class=rptValue ><center>-</center></td> 		 			
		<%}
		qry3 = "select nvl(TS_NO,'0'),nvl(to_char(TS_DATE,'dd-mm-yyyy'),'-'),nvl(TS_AMOUNT,'0') from RWS_NEW_EST_TBL where work_id="+rs1.getString(1)+"";
	//	//////System.out.println("THe 3nd Query is::"+qry3);		
if(stmt3!=null)stmt3.close();
		stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs3=stmt3.executeQuery(qry3);
		if(rs3.next())
		{
%>
  		<td class=rptValue  nowrap><%=rs3.getString(1)%></td>
		<td class=rptValue  nowrap><%=rs3.getString(2)%></td>
		<td class=rptValue ><%=rs3.getString(3)%></td>
	<%
		}
		else
 		 {
 		 %>
			<td class=rptValue ><center>-</center></td>
			<td class=rptValue ><center>-</center></td> 		 			
			<td class=rptValue ><center>-</center></td>
 		 <%
 		 }
		 qry3 = "select source_name from rws_source_iden_fin_tbl where work_id="+rs1.getString(1)+"";
	//	//////System.out.println("THe 3nd Query is::"+qry3);		
if(stmt3!=null)stmt3.close();
		stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs3=stmt3.executeQuery(qry3);
		if(rs3.next())
		{
%>
  		<td class=rptValue  nowrap><%=rs3.getString(1)%></td>
	<%
		}
		else
 		 {
 		 %>
			<td class=rptValue ><center>-</center></td>
 		 <%
 		 }
		 String stipDate = "";
		qry4 = "select distinct ten.CONTRACTOR_NAME,nvl(to_char(ten.RECIEVED_ON,'dd-mm-yyyy'),'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.TENDER_IDNO=ten.TENDER_IDNO and con.work_id='"+rs1.getString(1)+"'";
		qry4="select distinct ten.CONTRACTOR_NAME_COMPANY,AGREEMENT_REFERENCE_NO,AGREEMENT_DURATION,nvl(to_char (con.AGREEMENT_DATE ,'dd-mm-yyyy'),'-'),nvl(to_char (con.SITE_HAND_OVER_DATE,'dd-mm-yyyy'),'-'),nvl(to_char (con.DATE_OF_COMPLETION ,'dd-mm-yyyy'),'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_CONTRACTOR_TBL ten where con.CONTRACTOR_CODE =ten.CONTRACTOR_CODE and con.work_id='"+rs1.getString(1)+"'";
		//////System.out.println("THe 4nd Query is::"+qry4);		
if(stmt4!=null)stmt4.close();
		stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs4=stmt4.executeQuery(qry4);
		if(rs4.next())
		{
			stipDate = rs4.getString(6);
%>
  		<td class=rptValue ><%if(rs4.getString(1)==null) out.println("<center>-</center>"); else out.println(rs4.getString(1));%></td>
		<td class=rptValue  nowrap><%if(rs4.getString(2)==null) out.println("<center>-</center>"); else out.println(rs4.getString(2));%></td>
		<td class=rptValue  nowrap><%if(rs4.getString(3)==null) out.println("<center>-</center>"); else out.println(rs4.getString(3));%></td>
		<td class=rptValue  nowrap><%if(rs4.getString(4)==null) out.println("<center>-</center>"); else out.println(rs4.getString(4));%></td>
		<td class=rptValue  nowrap><%if(rs4.getString(5)==null) out.println("<center>-</center>"); else out.println(rs4.getString(5));%> </td>

	<%
		}
		else
		{
		%>
			<td class=rptValue ><center>-</center></td>
			<td class=rptValue ><center>-</center></td>
			<td class=rptValue ><center>-</center></td>
			<td class=rptValue ><center>-</center></td>
			<td class=rptValue ><center>-</center></td>
		<%
		}%>

	

        <%qry5="SELECT distinct SUM(CASE WHEN E.EXPENDITURE_UPTO IS NOT NULL and e.year = '"+currentYearPeriod+"' THEN E.EXPENDITURE_UPTO  ELSE 0 END),SUM(CASE WHEN E.EXPENDITURE_DURING  IS NOT NULL and e.year = '"+currentMonth+"' and e.month = '"+currentMonth+"' THEN  E.EXPENDITURE_DURING  ELSE 0 END),SUM(CASE WHEN E1.EXPENDITURE_UPTO_THE_PRE_YEAR  IS NOT NULL  THEN  E1.EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END) FROM RWS_WORK_EXPENDITURE_TBL E,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL E1,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID=E1.WORK_ID AND E.WORK_ID=E1.WORK_ID AND W.PROGRAMME_CODE=E.PROGRAMME_CODE AND W.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.WORK_ID='"+rs1.getString(1)+"'";
		double expupto1 = 0,expdur1 = 0,preyearexp1 = 0;
		WorksData1 workData = new WorksData1();	
		if(prev!=null){prev.close();prev=null;}
			prev = conn.createStatement();
			String aa = "select sum(expenditure_upto_the_pre_year) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id='"+rs1.getString(1)+"'";
			////System.out..println("aa:"+aa);
			if(prevrs!=null){prevrs.close();prevrs=null;}
			prevrs = prev.executeQuery(aa);
			if(prevrs.next()){preyearexp1=prevrs.getFloat(1);}


			String bb = "select sum(case when year<>'2009-10' then total else 0 end),sum(case when year='2009-10' then total else 0 end) from rws_exp_view where work_id='"+rs1.getString(1)+"'";

			////System.out..println("bb:"+bb);
			if(sss!=null){sss.close();sss=null;}
			sss = conn.createStatement();
			if(san!=null){san.close();prev=null;}
			san = sss.executeQuery(bb);
			if(san.next()){preyearexp1+=san.getFloat(1);expdur1=san.getFloat(2);}
			gepreyrdrsub1+=workData.round(preyearexp1,2);
			geprevdrsub1+=workData.round(expdur1,2);
//		//////System.out.println("Query 5 is::"+qry5);
if(stmt5!=null)stmt5.close();
		stmt5 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs5=stmt5.executeQuery(qry5);
		if(rs5.next())
		{%>
			<!--<td class=rptValue align=right><%=ndf.format(workData.round(preyearexp1,2))%></td>
			<td class=rptValue align=right><%=ndf.format(workData.round(expdur1,2))%></td>-->
		   <td class=rptValue align=center><%=ndf.format((workData.round((preyearexp1+expdur1),2)))%></td>	
		 <%
		 }
	
		qry6 = "select distinct nvl(remarks,'-'),NVL(TO_CHAR (DATE_OF_COMPLETION,'DD-MM-YYYY'),'-'),NVL(TO_CHAR(DATE_OF_COMM,'DD- MM-YYYY'),'-') from RWS_WORK_COMPLETION_TBL where WORK_ID='"+rs1.getString(1)+"'";
		////////System.out.println("THe 6nd Query is::"+qry6);		
if(stmt6!=null)stmt6.close();
		stmt6 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs6=stmt6.executeQuery(qry6);
		String remarks = "";
		if(rs6.next())
		{
			remarks = rs6.getString(1);
			%>
			<td class=rptValue align="center"  nowrap><%=stipDate%></td>	
	  		<td class=rptValue align="center"  nowrap><%=rs6.getString(2)%></td>
	 		<td class=rptValue align="center"  nowrap><%=rs6.getString(3)%></td>
			<!-- <td class=rptValue  align="center" title="Click to Get Habitation Details"><b><a href="work_list_report.jsp?hab=2&work_id=<%=rs1.getString(1)%>"><%=rs1.getString(5)%></a></b></td> -->	
<%

	}
	else
	{
	%>
		  	<td class=rptValue ><center>-</center></td>
		  	<td class=rptValue ><center>-</center></td>
		  	<td class=rptValue ><center>-</center></td>
	<%
	}
	qry7 = "select count(hab_code) from RWS_ADMN_HAB_LNK_TBL where work_id="+rs1.getString(1)+"";
	//////System.out.println("Query 777777777 is::"+qry7);
//	String qry8 = "select hl.hab_code from rws_new_est_tbl est,rws_est_new_hab_lnk_tbl hl where est.work_id=hl.work_id and hl.work_id="+rs1.getString(1)+"";
	////////System.out.println("Qry7 is::"+qry7);
	if(stmt7!=null)stmt7.close();
	stmt7 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs7 = stmt7.executeQuery(qry7);
	if(rs7.next())
	{
		if(!rs7.getString(1).equals("0")){
	%>
	<td class=rptValue  align="center" title="Click to Get Sanctioned Habitation Details"><b><a href="javascript: void(0)"  onclick="window.open('work_list_report.jsp?hab=2&work_id=<%=rs1.getString(1)%>',  'windowname1',  'width=500, height=550,resizable=true'); return false;"><%=rs7.getString(1)%></a></b></td>
	<%
	}
	else
		{
%>
			<td class=rptValue ><center>-</center></td>
<%
		}
	}
	qry7 = "select count(hab_code) from RWS_WORK_COMP_HAB_LNK_TBL where work_id="+rs1.getString(1)+"";
	////////System.out.println("Query 7 is::"+qry7);
//	String qry8 = "select hl.hab_code from rws_new_est_tbl est,rws_est_new_hab_lnk_tbl hl where est.work_id=hl.work_id and hl.work_id="+rs1.getString(1)+"";
	////////System.out.println("Qry7 is::"+qry7);
	if(stmt7!=null)stmt7.close();
	stmt7 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs7 = stmt7.executeQuery(qry7);
	if(rs7.next())
	{if(!rs7.getString(1).equals("0")){
	%>
	  		<!-- <td class=rptValue  align="center" title="Click to Get Habitation Details"><b><a href="work_list_report.jsp?hab=1&work_id=<%=rs1.getString(1)%>"><%=rs7.getString(1)%></a></b></td>	 -->
			<td class=rptValue  align="center" title="Click to Get Benefited Habitation Details"><b><a href="javascript: void(0)"  onclick="window.open('work_list_report.jsp?hab=1&work_id=<%=rs1.getString(1)%>',  'windowname1',  'width=500, height=550,resizable=true'); return false;"><%=rs7.getString(1)%></a></b></td>
			
	<%
	}
	else
	{
	%>
			  	<td class=rptValue ><center>-</center></td>
			  	
	<%}
	}
%>
<td class=rptValue align="center"  nowrap>
<%
	if(remarks==null) 
		out.println("<center>-</center>");
	else if(remarks!=null && remarks.equals(""))
		out.println("<center>-</center>");
	else
		out.println(remarks);
%>
</td>
</tr>
<%
}
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	
  		//while
}//if
else if(hab.equals("1"))
{
//System.out.println("Work Id Report start here22222222222222222222");
int Cnt = 0;
////System.out.println("In hab 1");
%>
<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="rws_worksmonitoring_progstatus_select.jsp">Back|</a></td>
				<td class="bwborder"><a href="work_id_report_excel.jsp" target="_new">Excel|</a></td>
				 
			</tr>
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=8>Benefited Habitation Details Report for Work ID - <%=work_id%></td>	
	</tr>
	           <tr>
       <td colspan=1 class="btext">S.No.</td>
	   <td colspan=1 class="btext">Habitation Code</td>
   	   <td colspan=1 class="btext">Habitation Name</td>
	   <td colspan=1 class="btext">Plain</td>
	   <td colspan=1 class="btext">SC</td>
	   <td colspan=1 class="btext">ST</td>
	   <td colspan=1 class="btext">Total</td>
	   <td colspan=1 class="btext">Coverage Status</td>
	   </tr>
<%
String p = "select hab_code from RWS_WORK_COMP_HAB_LNK_TBL where work_id="+work_id+"";
//System.out.println("The Query P is22222 ::"+p);
Statement stmtp = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
ResultSet rsp = stmtp.executeQuery(p);
Statement stmt8 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
Statement stmt88 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
int sno = 0;
while(rsp.next())
{
	String q="select nvl(h1.CENSUS_PLAIN_POPU,'0'), nvl(h1.CENSUS_SC_POPU,'0'),nvl (h1.CENSUS_ST_POPU,'0'),nvl(h1.CENSUS_PLAIN_POPU,'0')+ nvl(h1.CENSUS_SC_POPU,'0')+nvl (h1.CENSUS_ST_POPU,'0'),nvl(h1.coverage_status,'-') from rws_habitation_directory_tbl h1 where h1.hab_code="+rsp.getString(1)+"";
	String qq="select panch_name from RWS_PANCHAYAT_RAJ_TBL where panch_code="+rsp.getString(1)+"";
	//System.out.println("The Query Q is2222 ::"+q);
  // System.out.println("The Query QQ is 22222::"+qq);
    ResultSet rss9 = stmt8.executeQuery(q);	
    ResultSet rss99 = stmt88.executeQuery(qq);
    while(rss9.next())
    {
    rss99.next();
    sno++;
    %>
    	<tr>
			<td class=rptValue><%=sno%></td>
			<td class=rptValue><%=rsp.getString(1)%></td>
			<td class=rptValue><%=rss99.getString(1)%></td>
			<td class=rptValue><%=rss9.getString(1)%></td>
			<td class=rptValue><%=rss9.getString(2)%></td>
			<td class=rptValue><%=rss9.getString(3)%></td>
			<td class=rptValue><%=rss9.getString(4)%></td>
			<td class=rptValue><%=rss9.getString(5)%></td>
		</tr>
    <%
    }
}
}
else if(hab.equals("2"))
{//System.out.println("Work Id Report start here333333333333333333333");
int Cnt = 0;
////System.out.println("In hab 2");
%>
<tr align="right">
				 
			</tr>
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=8>Sanctioned Habitation Details Report for Work ID - <%=work_id%></td>	
	</tr>
	           <tr>
       <td colspan=1 class="btext">S.No.</td>
	   <td colspan=1 class="btext">Habitation Code</td>
   	   <td colspan=1 class="btext">Habitation Name</td>
	   <td colspan=1 class="btext">Plain</td>
	   <td colspan=1 class="btext">SC</td>
	   <td colspan=1 class="btext">ST</td>
	   <td colspan=1 class="btext">Total</td>
	   <td colspan=1 class="btext">Coverage Status</td>
	   </tr>
<%
String p = "select hab_code from RWS_ADMN_HAB_LNK_TBL where work_id="+work_id+"";
//System.out.println("The Query Q is3333 ::"+p);
Statement stmtp = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
ResultSet rsp = stmtp.executeQuery(p);
Statement stmt8 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
Statement stmt88 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
int sno = 0;
while(rsp.next())
{
	String q="select nvl(h1.CENSUS_PLAIN_POPU,'0'), nvl(h1.CENSUS_SC_POPU,'0'),nvl (h1.CENSUS_ST_POPU,'0'),nvl(h1.CENSUS_PLAIN_POPU,'0')+ nvl(h1.CENSUS_SC_POPU,'0')+nvl (h1.CENSUS_ST_POPU,'0'),nvl(h1.coverage_status,'-') from rws_habitation_directory_tbl h1 where h1.hab_code="+rsp.getString(1)+"";
	String qq="select panch_name from RWS_PANCHAYAT_RAJ_TBL where panch_code="+rsp.getString(1)+"";
	//System.out.println("The Query Q is333 ::"+q);
	//System.out.println("The Query QQ is333 ::"+qq);
    ResultSet rss9 = stmt8.executeQuery(q);	
    ResultSet rss99 = stmt88.executeQuery(qq);
    while(rss9.next())
    {
    rss99.next();
    sno++;
    %>
    	<tr>
			<td class=rptValue><%=sno%></td>
			<td class=rptValue><%=rsp.getString(1)%></td>
			<td class=rptValue><%=rss99.getString(1)%></td>
			<td class=rptValue><%=rss9.getString(1)%></td>
			<td class=rptValue><%=rss9.getString(2)%></td>
			<td class=rptValue><%=rss9.getString(3)%></td>
			<td class=rptValue><%=rss9.getString(4)%></td>
			<td class=rptValue><%=rss9.getString(5)%></td>
		</tr>
    <%
    }
}
}
}//try
catch(Exception e)
{
	e.printStackTrace();
}
finally
{

	if(conn!=null)
	conn.close();
}
%>

</form>
</body>
</html>
