<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<!--<%@ page import="nic.watersoft.masters.RwsMasterData" %>-->
<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
    String currentYear= dateFormat.format(currentDate).substring(0,4);
    String currentMonth = dateFormat.format(currentDate).substring(5,7);
    int nextYear = Integer.parseInt(currentYear);
    nextYear++;
    String nextYear1 = ""+nextYear;
    String currentYearPeriod = currentYear + "-" + nextYear1;
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
    String fyear=dateFormat.format(currentDate).substring(0,4);
    int iyear=0;
    iyear= Integer.parseInt(fyear);
        if(Integer.parseInt(currentMonth)>=4)
	  {
		  fyear=fyear+"-"+(new Integer(iyear+1)).toString().substring(2,4);
         //System.out.println("FYEAR in >="+fyear);
	  }
	  else 
		  {
		        fyear=(new Integer(iyear-1)).toString()+"-"+fyear.toString().substring(2,4);
	            //System.out.println("FYEAR in else"+fyear);
          }
        	//Debug.println("***********************REPORT BEGINING***********************");
        	
	String rDistrict="",drill="",rDivisionName="",rConstituency="", rMandal="", rPanchayat="", rVillage="", rHabitation="", distvalue="", distname="", conname="", convalue="", manvalue="", manname="", panvalue="", panname="", vilvalue="", vilname ="";
	String districtName="",districtName1="",mandalName="",panchayatName="",villageName="",constituencyName="",habitationName="";
	String rDivision = request.getParameter("rDivision");
	String rDivisonName = request.getParameter("rDivisonName");

	if(session.getAttribute("rDistrict")!=null)
		{
			rDistrict = (String)session.getAttribute("rDistrict");
		}	
		if(session.getAttribute("districtName")!=null)
		{
			districtName = (String)session.getAttribute("districtName");
		}
		if(session.getAttribute("districtname")!=null)
		{
			districtName1 = (String)session.getAttribute("districtname");
		}
		if(session.getAttribute("constituency")!=null)
		{
			rConstituency = (String)session.getAttribute("constituency");
		}
		if(session.getAttribute("drill")!=null)
		{
			drill = (String)session.getAttribute("drill");
		}
		if(session.getAttribute("constituency1")!=null)
		{
			constituencyName = (String)session.getAttribute("constituency1");
		}
		if(session.getAttribute("rDivision")!=null)
		{
			rDivision = (String)session.getAttribute("rDivision");
		}
		if(session.getAttribute("rDivisionName")!=null)
		{
			rDivisonName = (String)session.getAttribute("rDivisionName");
		}

//	conname = request.getParameter("conname");	

	String query3="",query4="",query5="";
		
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	ResultSet rs2 = null,rs21 = null,rs22 = null;
	Statement stmt1 = null,stmt21 = null,stmt22 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
	boolean flag=true,flag1=false,flagp=true,flagn=true,flagd=true;
	//fields for total
	int gnspills=0,gspillsa=0,gnspillsa=0,gspills=0,gtspills=0,gtspillsa=0,ghabsan=0,ghabsana=0,gtsno=0,gcomp=0,gcomm=0,ghabcov=0,gten=0,gagree=0,ggrnd=0;
	double gnspillamt=0.0,gspillamt=0.0,gtspamt=0.0,gnspillamta=0.0,gspillamta=0.0,gtspamta=0.0,grevamt=0.0,gepreyr=0.0,geprev=0.0,gedur=0.0,gcum=0.0,getot=0.0;
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
	
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
<% 	
////System.out.println("rDistrict::"+rDistrict);
if(rDistrict != null)
	{
//	//System.out.println("in if");
	   try
	   {
	   %>
			<%@ include file="./rws_worksmonitoring_workstatus_label.jsp"%>
	   <%
		String qry1=null;
		if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
		{
			qry1="SELECT DISTINCT D.DCODE AS A_CODE,D.DNAME AS A_NAME FROM RWS_WORK_ADMN_TBL A,RWS_ADMN_HAB_LNK_TBL AL,RWS_DISTRICT_TBL D WHERE A.WORK_ID=AL.WORK_ID AND D.DCODE=SUBSTR (AL.HAB_CODE,1,2) and D.DCODE=SUBSTR(A.WORK_ID,5,2) GROUP BY D.DCODE,D.DNAME";
		}
		else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
		{
			qry1="SELECT DISTINCT D.division_office_code AS A_CODE,D.division_office_name AS A_NAME FROM RWS_WORK_ADMN_TBL A,RWS_ADMN_HAB_LNK_TBL AL,RWS_DIVISION_OFFICE_TBL D WHERE A.WORK_ID=AL.WORK_ID AND D.division_office_code=SUBSTR(A.WORK_ID,7,2) and d.circle_office_code='"+rDistrict+"' GROUP BY D.division_office_code,D.division_office_name";
		}
		else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
		{
			qry1="SELECT DISTINCT D.division_office_code AS A_CODE,D.division_office_name AS A_NAME FROM RWS_WORK_ADMN_TBL A,RWS_ADMN_HAB_LNK_TBL AL,RWS_DIVISION_OFFICE_TBL D WHERE A.WORK_ID=AL.WORK_ID AND D.division_office_code=SUBSTR(A.WORK_ID,7,2) and d.circle_office_code='"+rDistrict+"' and d.division_office_code='"+rConstituency+"'GROUP BY D.division_office_code,D.division_office_name";
		}		
		else if(drill.equals("2"))
		{
			qry1 = "SELECT DISTINCT D.division_office_code AS A_CODE,D.division_office_name AS A_NAME FROM RWS_WORK_ADMN_TBL A,RWS_ADMN_HAB_LNK_TBL AL,RWS_DIVISION_OFFICE_TBL D WHERE A.WORK_ID=AL.WORK_ID(+) AND D.division_office_code=SUBSTR (A.office_code,4,1) and d.circle_office_code='"+rDistrict+"' GROUP BY D.division_office_code,D.division_office_name";
		}
		else if(drill.equals("3"))
		{
			qry1 = "SELECT DISTINCT SD.SUBdivision_office_code AS A_CODE,SD.SUBdivision_office_name AS A_NAME FROM RWS_DIVISION_OFFICE_TBL D,RWS_SUBDIVISION_OFFICE_TBL SD WHERE SD.CIRCLE_OFFICE_CODE=D.CIRCLE_OFFICE_CODE AND D.DIVISION_OFFICE_CODE=SD.DIVISION_OFFICE_CODE AND SD.CIRCLE_OFFICE_CODE='"+rDistrict+"' AND SD.DIVISION_OFFICE_CODE='"+rDivision+"'";
		}
	//System.out.println("Test Qry is::"+qry1);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs1=stmt1.executeQuery(qry1);
		
		while(rs1.next())
		{
		flag=false;flagn=false;flagd=false;
		%>
		<tr onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
        <td class=rptValue><%=++slno%></td>
        <% if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
        	{
         %>
		<td class=rptValue nowrap><%=rs1.getString(2)%></td>	
		<%}
				else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
		{%>
						<td class=rptValue nowrap><%=rs1.getString(2)%></td>		
		<%}	else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
		{
		%>
					<td class=rptValue nowrap><%=rs1.getString(2)%></td>		
		<%}else if(drill.equals("2")){%>
				<td class=rptValue nowrap><%=rs1.getString(2)%></td>	
		<%}
		else if(drill.equals("3")){%>
				<td class=rptValue nowrap><%=rs1.getString(2)%></td>	
		<%}
		
		String qry2=null,qry21=null,qry22=null,qry21a=null,qry22a=null;Statement stmt2=null;
		float spillamt=0,nspillamt=0,tspamt=0,spillamta=0,nspillamta=0,tspamta=0;
		int tspills=0,spills=0,nspills=0,tspillsa=0,spillsa=0,nspillsa=0;
		try
		{
			if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
			{
				qry21 = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rs1.getString(1)+"' and w.plan_code='1'";
				qry22 = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rs1.getString(1)+"'  and w.plan_code='1'";			
				qry21a = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rs1.getString(1)+"'  and w.plan_code='2'";
				qry22a = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rs1.getString(1)+"'  and w.plan_code='2'";			
			}
			else if(rDistrict!=null && !rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
			{
				
				qry21 = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'and w.plan_code='1'";
				qry22 = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='1'";
				qry21a = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'and w.plan_code='2'";
				qry22a = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='2'";
			
			}
			else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
			{
				qry21 = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='1'";
				qry22 = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='1'";
				qry21a = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='2'";
				qry22a = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='2'";
			
			}
			else if(drill.equals("2"))
			{
				qry21 = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='1'";
				qry22 = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='1'";
				qry21a = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='2'";
				qry22a = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='2'";
				
			}
			else if(drill.equals("3"))
			{
				qry21 = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"' and w.plan_code='1'";
				qry22 = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"' and w.plan_code='1'";
				qry21a = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"' and w.plan_code='2'";
				qry22a = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearTo+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"' and w.plan_code='2'";
			}
			////System.out.println("1");
			////System.out.println("Q1:"+qry21);
			////System.out.println("Q2:"+qry22);
			stmt21 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
   	        stmt22 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			Statement stmt21a = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
   	        Statement stmt22a = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

			rs21=stmt21.executeQuery(qry21);
           	rs22=stmt22.executeQuery(qry22);                	
			ResultSet rs21a=stmt21a.executeQuery(qry21a);
			ResultSet rs22a=stmt22a.executeQuery(qry22a);   	
			while(rs21.next()&&rs22.next()&& rs21a.next()&&rs22a.next())
			{
						 spills=rs21.getInt(1);
						 gspills=gspills+spills;
						 nspills=rs22.getInt(1);
						 spillsa=rs21a.getInt(1);
						 gspillsa=gspillsa+spillsa;
						 nspillsa=rs22a.getInt(1);
						 gnspills=gnspills+nspills;
						 gnspillsa=gnspillsa+nspillsa;
						 tspills=tspills+rs21.getInt(1)+rs22.getInt(1);
						 tspillsa=tspillsa+rs21a.getInt(1)+rs22a.getInt(1);
						 gtspills=gtspills+tspills;
						 gtspillsa=gtspillsa+tspillsa;
						 spillamt=rs21.getFloat(2);
						 gspillamt=gspillamt+spillamt;
						 nspillamt=rs22.getFloat(2);
						 gnspillamt=gnspillamt+nspillamt;
                         tspamt=tspamt+rs21.getFloat(2)+rs22.getFloat(2);
                         gtspamt=gtspamt+tspamt;
                         
                         spillamta=rs21a.getFloat(2);
						 gspillamta=gspillamta+spillamta;
						 nspillamta=rs22a.getFloat(2);
						 gnspillamta=gnspillamta+nspillamta;
                         tspamta=tspamta+rs21a.getFloat(2)+rs22a.getFloat(2);
                         gtspamta=gtspamta+tspamta;
							%>
		<td class=rptValue align=right><%=rs21.getInt(1)%></td>
		<td class=rptValue align=right><%=rs22.getInt(1)%></td>
		<td class=rptValue align=right><%=tspills%></td>
		<td class=rptValue align=right><%=rs21a.getInt(1)%></td>
		<td class=rptValue align=right><%=rs22a.getInt(1)%></td>
		<td class=rptValue align=right><%=tspillsa%></td>
		<td class=rptValue align=right><%=Math.round(spillamt*100)/100f%></td>
		<td class=rptValue align=right><%=Math.round(nspillamt*100)/100f%></td>
		<td class=rptValue align=right><%=Math.round(tspamt*100)/100f%></td>
        <td class=rptValue align=right><%=Math.round(spillamta*100)/100f%></td>
		<td class=rptValue align=right><%=Math.round(nspillamta*100)/100f%></td>
		<td class=rptValue align=right><%=Math.round(tspamta*100)/100f%></td>

			<% }
			}
			catch(Exception e)
			{
			e.printStackTrace();
			}
			finally
			{
			if(rs21!=null)rs21.close();
			if(stmt21!=null)stmt21.close();
			if(rs22!=null)rs22.close();
			if(stmt22!=null)stmt22.close();

			}
			String qry3=null;
			Statement stmt3=null;
			try
			{
			if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
			{
				 qry3="select distinct SUM(CASE WHEN R.REV_SANCTION_AMOUNT IS NOT NULL THEN  R.REV_SANCTION_AMOUNT ELSE 0 END) FROM RWS_WORK_ADMN_TBL W,RWS_REVISED_ADM_SANC_TBL R WHERE W.WORK_ID=R.WORK_ID AND SUBSTR(R.WORK_ID,5,2)='"+rs1.getString(1)+"'";
			    ////System.out.println("query"+qry3);
			}
			else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
			{
				 qry3="select distinct SUM(CASE WHEN R.REV_SANCTION_AMOUNT IS NOT NULL THEN  R.REV_SANCTION_AMOUNT ELSE 0 END) FROM RWS_WORK_ADMN_TBL W,RWS_REVISED_ADM_SANC_TBL R WHERE W.WORK_ID=R.WORK_ID AND SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
			}
			else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
			{
				 qry3="select distinct SUM(CASE WHEN R.REV_SANCTION_AMOUNT IS NOT NULL THEN  R.REV_SANCTION_AMOUNT ELSE 0 END) FROM RWS_WORK_ADMN_TBL W,RWS_REVISED_ADM_SANC_TBL R WHERE W.WORK_ID=R.WORK_ID AND SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
			}
			else if(drill.equals("2"))
			{
				 qry3="select distinct SUM(CASE WHEN R.REV_SANCTION_AMOUNT IS NOT NULL THEN  R.REV_SANCTION_AMOUNT ELSE 0 END) FROM RWS_WORK_ADMN_TBL W,RWS_REVISED_ADM_SANC_TBL R WHERE W.WORK_ID=R.WORK_ID AND SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
			}
			else if(drill.equals("3"))
			{
				 qry3="select distinct SUM(CASE WHEN R.REV_SANCTION_AMOUNT IS NOT NULL THEN  R.REV_SANCTION_AMOUNT ELSE 0 END) FROM RWS_WORK_ADMN_TBL W,RWS_REVISED_ADM_SANC_TBL R WHERE W.WORK_ID=R.WORK_ID AND SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"'";
			}
			////System.out.println("Q3"+qry3);
			 stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		          rs3=stmt3.executeQuery(qry3);
            while(rs3.next())
            {
	             grevamt=grevamt+rs3.getFloat(1);
            %>
            
            <td class=rptValue align=right><%=rs3.getFloat(1)%></td>
        <%
        } 
            }
            catch(Exception e)
            {
	        e.printStackTrace();
            }
            finally
            {
            rs3.close();
            stmt3.close();
            }
            
            
            
			String qry4=null,qry4a=null;
			Statement stmt4=null;
	   try
	  {
		  if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
		  {
				qry4="Select distinct SUM(w.NO_OF_HABS) from rws_work_admn_tbl w WHERE SUBSTR(W.WORK_ID,5,2)='"+rs1.getString(1)+"' and w.plan_code='1'and w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) ";
				qry4a="Select distinct SUM(w.NO_OF_HABS) from rws_work_admn_tbl w WHERE SUBSTR(W.WORK_ID,5,2)='"+rs1.getString(1)+"'  and w.plan_code='2' and w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) ";
		  }
		  else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
		  {
				qry4="Select distinct SUM(w.NO_OF_HABS) from rws_work_admn_tbl w WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'and w.plan_code='1'and w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) ";
				qry4a="Select distinct SUM(w.NO_OF_HABS) from rws_work_admn_tbl w WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'and w.plan_code='2'and w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) ";
		  }
		  else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
		  {
				qry4="Select distinct SUM(w.NO_OF_HABS) from rws_work_admn_tbl w WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'and w.plan_code='1'and w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) ";		  
				qry4a="Select distinct SUM(w.NO_OF_HABS) from rws_work_admn_tbl w WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'and w.plan_code='2'and w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) ";		  
		  }
		  else if(drill.equals("2"))
		  {
				qry4="Select distinct SUM(w.NO_OF_HABS) from rws_work_admn_tbl w WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='1'and w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) ";
				qry4a="Select distinct SUM(w.NO_OF_HABS) from rws_work_admn_tbl w WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"' and w.plan_code='2'and w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) ";
		  }
		  else if(drill.equals("3"))
		  {
				qry4="Select distinct SUM(w.NO_OF_HABS) from rws_work_admn_tbl w WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"' and w.plan_code='1'and w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) ";
				qry4a="Select distinct SUM(w.NO_OF_HABS) from rws_work_admn_tbl w WHERE SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"' and w.plan_code='2'and w.ADMIN_DATE < '"+financialYearTo+"' and w.work_id not in (select work_id from rws_work_completion_tbl) ";
		  }
			stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			Statement stmt4a = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);			
		        rs4=stmt4.executeQuery(qry4);
		    ResultSet rs4a=stmt4a.executeQuery(qry4a);		        
		       while(rs4.next() && rs4a.next())
		      {
		          ghabsan=ghabsan+rs4.getInt(1);
   		          ghabsana=ghabsana+rs4a.getInt(1);
	            %>
			    <td class=rptValue align=right><%=rs4.getInt(1)%></td>
			    <td class=rptValue align=right><%=rs4a.getInt(1)%></td>			    
		<%} 
            }
            catch(Exception e)
            {
            e.printStackTrace();
            }
            finally
            {
            rs4.close();
            stmt4.close();
            }
            String qry5=null,qry5a=null,qry5b=null;Statement stmt5=null;
            try
            {
            if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
            {
				qry5="SELECT distinct SUM(CASE WHEN E.EXPENDITURE_UPTO IS NOT NULL and e.year = '"+fyear+"' THEN E.EXPENDITURE_UPTO  ELSE 0 END),SUM(CASE WHEN E.EXPENDITURE_DURING  IS NOT NULL and e.year = '"+fyear+"' and e.month = '"+currentMonth+"' THEN  E.EXPENDITURE_DURING  ELSE 0 END),SUM(CASE WHEN E1.EXPENDITURE_UPTO_THE_PRE_YEAR  IS NOT NULL  THEN  E1.EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END) FROM RWS_WORK_EXPENDITURE_TBL E,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL E1,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID=E1.WORK_ID AND E.WORK_ID=E1.WORK_ID AND W.PROGRAMME_CODE=E.PROGRAMME_CODE AND W.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE=E1.PROGRAMME_CODE AND substr(w.work_id,5,2)='"+rs1.getString(1)+"'";
				//qry5="select nvl(sum(EXPENDITURE_UPTO_THE_PRE_YEAR),0) as EXPENDITURE_UPTO_THE_PRE_YEAR from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where substr(work_id,5,2)='"+rs1.getString(1)+"'";
				//qry5a="select nvl(sum(EXPENDITURE_UPTO),0) as EXPENDITURE_UPTO from rws_work_expenditure_tbl where substr(work_id,5,2)='"+rs1.getString(1)+"' and year='"+fyear+"";
				//qry5b="";
			}
			else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
		  	{
				qry5="SELECT distinct SUM(CASE WHEN E.EXPENDITURE_UPTO IS NOT NULL and e.year = '"+fyear+"' THEN E.EXPENDITURE_UPTO  ELSE 0 END),SUM(CASE WHEN E.EXPENDITURE_DURING  IS NOT NULL and e.year = '"+fyear+"' and e.month = '"+currentMonth+"' THEN  E.EXPENDITURE_DURING  ELSE 0 END),SUM(CASE WHEN E1.EXPENDITURE_UPTO_THE_PRE_YEAR  IS NOT NULL  THEN  E1.EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END) FROM RWS_WORK_EXPENDITURE_TBL E,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL E1,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID=E1.WORK_ID AND E.WORK_ID=E1.WORK_ID AND W.PROGRAMME_CODE=E.PROGRAMME_CODE AND W.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE=E1.PROGRAMME_CODE AND SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
			}
  		    else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
		    {
				qry5="SELECT distinct SUM(CASE WHEN E.EXPENDITURE_UPTO IS NOT NULL and e.year = '"+fyear+"' THEN E.EXPENDITURE_UPTO  ELSE 0 END),SUM(CASE WHEN E.EXPENDITURE_DURING  IS NOT NULL and e.year = '"+fyear+"' and e.month = '"+currentMonth+"' THEN  E.EXPENDITURE_DURING  ELSE 0 END),SUM(CASE WHEN E1.EXPENDITURE_UPTO_THE_PRE_YEAR  IS NOT NULL  THEN  E1.EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END) FROM RWS_WORK_EXPENDITURE_TBL E,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL E1,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID=E1.WORK_ID AND E.WORK_ID=E1.WORK_ID AND W.PROGRAMME_CODE=E.PROGRAMME_CODE AND W.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE=E1.PROGRAMME_CODE AND SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
		    } 
			else if(drill.equals("2"))
			{
				qry5="SELECT distinct SUM(CASE WHEN E.EXPENDITURE_UPTO IS NOT NULL and e.year = '"+fyear+"' THEN E.EXPENDITURE_UPTO  ELSE 0 END),SUM(CASE WHEN E.EXPENDITURE_DURING  IS NOT NULL and e.year = '"+fyear+"' and e.month = '"+currentMonth+"' THEN  E.EXPENDITURE_DURING  ELSE 0 END),SUM(CASE WHEN E1.EXPENDITURE_UPTO_THE_PRE_YEAR  IS NOT NULL  THEN  E1.EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END) FROM RWS_WORK_EXPENDITURE_TBL E,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL E1,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID=E1.WORK_ID AND E.WORK_ID=E1.WORK_ID AND W.PROGRAMME_CODE=E.PROGRAMME_CODE AND W.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE=E1.PROGRAMME_CODE AND SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
			}
			else if(drill.equals("3"))
			{
				qry5="SELECT distinct SUM(CASE WHEN E.EXPENDITURE_UPTO IS NOT NULL and e.year = '"+fyear+"' THEN E.EXPENDITURE_UPTO  ELSE 0 END),SUM(CASE WHEN E.EXPENDITURE_DURING  IS NOT NULL and e.year = '"+fyear+"' and e.month = '"+currentMonth+"' THEN  E.EXPENDITURE_DURING  ELSE 0 END),SUM(CASE WHEN E1.EXPENDITURE_UPTO_THE_PRE_YEAR  IS NOT NULL  THEN  E1.EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END) FROM RWS_WORK_EXPENDITURE_TBL E,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL E1,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID=E1.WORK_ID AND E.WORK_ID=E1.WORK_ID AND W.PROGRAMME_CODE=E.PROGRAMME_CODE AND W.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE=E1.PROGRAMME_CODE AND SUBSTR(W.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"'";
			}
			//System.out.println("qry5:"+qry5);
	        stmt5 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs5=stmt5.executeQuery(qry5);
	        while(rs5.next())
		{
			gepreyr=gepreyr+rs5.getDouble(3);
			geprev=geprev+rs5.getDouble(1);
			gedur=gedur+rs5.getDouble(2);
			gcum=gcum+rs5.getDouble(1)+rs5.getDouble(2);
			getot=getot+rs5.getDouble(1)+rs5.getDouble(2)+rs5.getDouble(3);
            %>
            
            <td class=rptValue align=right><%=Math.round(rs5.getDouble(3)*100)/100d%></td>
            <td class=rptValue align=right><% if(currentMonth.equals("04"))out.println("<center>-</center>");else out.println(Math.round(rs5.getDouble(1)*100)/100d);%></td>
             <td class=rptValue align=right><%=Math.round(rs5.getDouble(2)*100)/100d%></td>
              <td class=rptValue align=right><%=Math.round((rs5.getDouble(1)+rs5.getDouble(2))*100)/100d%></td>
              <td class=rptValue align=right><%=Math.round((rs5.getDouble(1)+rs5.getDouble(2)+rs5.getDouble(3))*100)/100d%></td>
            <%}  
            }
            catch(Exception e)
            {
            e.printStackTrace();
            }
            finally
            {
            rs5.close();
            stmt5.close();
            }
            String qry6=null;Statement stmt6=null;
            try
            {
            if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
            {
			    qry6="SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.PROGRAMME_CODE=SUBSTR(E.WORK_ID,1,2) AND SUBSTR(E.WORK_ID,5,2)='"+rs1.getString(1)+"'";
			}
			else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
		  	{
			    qry6="SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.PROGRAMME_CODE=SUBSTR(E.WORK_ID,1,2) AND SUBSTR(E.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";			
			}
  		    else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
		    {
			    qry6="SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.PROGRAMME_CODE=SUBSTR(E.WORK_ID,1,2) AND SUBSTR(E.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";			
		    } 
		  	else if(drill.equals("2"))
			{
			    qry6="SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.PROGRAMME_CODE=SUBSTR(E.WORK_ID,1,2) AND SUBSTR(E.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";			
			}
			else if(drill.equals("3"))
			{
			    qry6="SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.PROGRAMME_CODE=SUBSTR(E.WORK_ID,1,2) AND SUBSTR(E.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"'";			
			}
            stmt6 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs6=stmt6.executeQuery(qry6);
            while(rs6.next())
            {
		     gtsno=gtsno+rs6.getInt(1);
	   %>
            <td class=rptValue align=right><%=rs6.getInt(1)%></td>
           <%} 
           }
           catch(Exception e)
           {
           e.printStackTrace();
           }
            finally
            {
            rs6.close();
            stmt6.close();
            }
           String qry7=null;Statement stmt7=null;
           try
           {
           if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
           {
           		qry7="SELECT distinct SUM(CASE WHEN CON.WORK_ID  IS NOT NULL THEN  1 ELSE 0 END)AS CON_TENDERED,SUM(CASE WHEN CON.AGREEMENT_DATE IS NOT NULL THEN 1  ELSE 0 END)AS CON_AGMT_ENT FROM RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=CON.WORK_ID AND SUBSTR(CON.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(CON.WORK_ID,5,2)='"+rs1.getString(1)+"'";
           }
           else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
		   {
           		qry7="SELECT distinct SUM(CASE WHEN CON.WORK_ID  IS NOT NULL THEN  1 ELSE 0 END)AS CON_TENDERED,SUM(CASE WHEN CON.AGREEMENT_DATE IS NOT NULL THEN 1  ELSE 0 END)AS CON_AGMT_ENT FROM RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=CON.WORK_ID AND SUBSTR(CON.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(CON.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
           }
  		    else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
		    {
           		qry7="SELECT distinct SUM(CASE WHEN CON.WORK_ID  IS NOT NULL THEN  1 ELSE 0 END)AS CON_TENDERED,SUM(CASE WHEN CON.AGREEMENT_DATE IS NOT NULL THEN 1  ELSE 0 END)AS CON_AGMT_ENT FROM RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=CON.WORK_ID AND SUBSTR(CON.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(CON.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
		    } 
		  	else if(drill.equals("2"))
           {
           		qry7="SELECT distinct SUM(CASE WHEN CON.WORK_ID  IS NOT NULL THEN  1 ELSE 0 END)AS CON_TENDERED,SUM(CASE WHEN CON.AGREEMENT_DATE IS NOT NULL THEN 1  ELSE 0 END)AS CON_AGMT_ENT FROM RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=CON.WORK_ID AND SUBSTR(CON.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(CON.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
           }
           	else if(drill.equals("3"))
           {
           		qry7="SELECT distinct SUM(CASE WHEN CON.WORK_ID  IS NOT NULL THEN  1 ELSE 0 END)AS CON_TENDERED,SUM(CASE WHEN CON.AGREEMENT_DATE IS NOT NULL THEN 1  ELSE 0 END)AS CON_AGMT_ENT FROM RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=CON.WORK_ID AND SUBSTR(CON.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(CON.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"'";
           }	
	        stmt7= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs7=stmt7.executeQuery(qry7);
		    while(rs7.next())
		    {
			    gten=gten+rs7.getInt(1);
			    gagree=gagree+rs7.getInt(2);
	     %>
            <td class=rptValue align=right><%=rs7.getInt(1)%></td>
            <td class=rptValue align=right><%=rs7.getInt(2)%></td>
           <%}  
           }
           catch(Exception e)
           {
           e.printStackTrace();
           }
           finally
           {
            rs7.close();
            stmt7.close();
           }
            String qry8=null;Statement stmt8=null;
            try
            {
            if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
            {
	            qry8="SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W   WHERE W.WORK_ID=G.WORK_ID AND SUBSTR(G.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(G.WORK_ID,5,2)='"+rs1.getString(1)+"'";
	        }
	        else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
		    {
	            qry8="SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W   WHERE W.WORK_ID=G.WORK_ID AND SUBSTR(G.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(G.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
	        }
  		    else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
		    {
	            qry8="SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W   WHERE W.WORK_ID=G.WORK_ID AND SUBSTR(G.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(G.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
		    } 
	        else if(drill.equals("2"))
	        {
	            qry8="SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W   WHERE W.WORK_ID=G.WORK_ID AND SUBSTR(G.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(G.WORK_ID,5,2)='"+rDistrict+"'and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
	        }
			else if(drill.equals("3"))
	        {
	            qry8="SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W   WHERE W.WORK_ID=G.WORK_ID AND SUBSTR(G.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(G.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"'";
	        }	            
            stmt8= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs8=stmt8.executeQuery(qry8);
            while(rs8.next())
            {
            ggrnd=ggrnd+rs8.getInt(1);
          %>
            <td class=rptValue align=right><%=rs8.getInt(1)%></td>
            <%}  
            }
            catch(Exception e)
            {
            e.printStackTrace();
            }
            finally
            {
            rs8.close();
            stmt8.close();
            }
            String qry9=null;Statement stmt9=null;
            try
            {
            if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
            {
	            qry9="SELECT distinct SUM(CASE WHEN WC.work_id IS NOT NULL THEN  1 ELSE 0 END),SUM(CASE WHEN WC.DATE_OF_COMM IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMPLETION_TBL WC,RWS_WORK_ADMN_TBL W   WHERE W.WORK_ID=WC.WORK_ID AND SUBSTR(WC.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(WC.WORK_ID,5,2)='"+rs1.getString(1)+"'";
            }
            else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
		    {
		       qry9="SELECT distinct SUM(CASE WHEN WC.work_id IS NOT NULL THEN  1 ELSE 0 END),SUM(CASE WHEN WC.DATE_OF_COMM IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMPLETION_TBL WC,RWS_WORK_ADMN_TBL W   WHERE W.WORK_ID=WC.WORK_ID AND SUBSTR(WC.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(WC.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
	        }
  		    else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
		    {
	            qry9="SELECT distinct SUM(CASE WHEN WC.work_id IS NOT NULL THEN  1 ELSE 0 END),SUM(CASE WHEN WC.DATE_OF_COMM IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMPLETION_TBL WC,RWS_WORK_ADMN_TBL W   WHERE W.WORK_ID=WC.WORK_ID AND SUBSTR(WC.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(WC.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
		    } 
            else if(drill.equals("2"))
            {
	            qry9="SELECT distinct SUM(CASE WHEN WC.work_id IS NOT NULL THEN  1 ELSE 0 END),SUM(CASE WHEN WC.DATE_OF_COMM IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMPLETION_TBL WC,RWS_WORK_ADMN_TBL W   WHERE W.WORK_ID=WC.WORK_ID AND SUBSTR(WC.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(WC.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
	        }
	        else if(drill.equals("3"))
            {
	            qry9="SELECT distinct SUM(CASE WHEN WC.work_id IS NOT NULL THEN  1 ELSE 0 END),SUM(CASE WHEN WC.DATE_OF_COMM IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMPLETION_TBL WC,RWS_WORK_ADMN_TBL W   WHERE W.WORK_ID=WC.WORK_ID AND SUBSTR(WC.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(WC.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"'";
	        }
	      //  //System.out.println("The Qry 9 is::"+qry9);
           stmt9= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs9=stmt9.executeQuery(qry9);
            while(rs9.next())
            {
		    gcomp=gcomp+rs9.getInt(1);
		    gcomm=gcomm+rs9.getInt(2);
            %>
            <td class=rptValue align=right><%=rs9.getInt(1)%></td>
             <td class=rptValue align=right><%=rs9.getInt(2)%></td>
            <%}  
            }
            catch(Exception e)
            {
            e.printStackTrace();
            }
            finally
            {
            rs9.close();
            stmt9.close();
            }
            
            String qry10=null; Statement stmt10=null;
            try
            {
            if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
            {
	            qry10="SELECT distinct count(distinct(hab_code))FROM RWS_EST_NEW_HAB_LNK_TBL E,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=E.WORK_ID AND SUBSTR(E.WORK_ID,5,2)='"+rs1.getString(1)+"'";
	        }
	        else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
		    {
	            qry10="SELECT distinct count(distinct(hab_code))FROM RWS_EST_NEW_HAB_LNK_TBL E,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=E.WORK_ID AND SUBSTR(E.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
	        }
  		    else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
		    {
	            qry10="SELECT distinct count(distinct(hab_code))FROM RWS_EST_NEW_HAB_LNK_TBL E,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=E.WORK_ID AND SUBSTR(E.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
		    } 
	        else if(drill.equals("2"))
	        {
	            qry10="SELECT distinct count(distinct(hab_code))FROM RWS_EST_NEW_HAB_LNK_TBL E,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=E.WORK_ID AND SUBSTR(E.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rs1.getString(1)+"'";
	        }
	        else if(drill.equals("3"))
	        {
	            qry10="SELECT distinct count(distinct(hab_code))FROM RWS_EST_NEW_HAB_LNK_TBL E,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=E.WORK_ID AND SUBSTR(E.WORK_ID,5,2)='"+rDistrict+"' and SUBSTR(W.office_code,4,1)='"+rDivision+"' and SUBSTR(W.office_code,5,2)='"+rs1.getString(1)+"'";
	        }
	        ////System.out.println("Query 10 is::"+qry10);
            stmt10= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs10=stmt10.executeQuery(qry10);
            while(rs10.next())
            {
            ghabcov=ghabcov+rs10.getInt(1);
            %>
            <td class=rptValue align=right><%=rs10.getInt(1)%></td>
                       <%}  
                       }
                       catch(Exception e)
                       {
                       e.printStackTrace();
                       }
                       finally
                       {
                       rs10.close();
                      stmt10.close();
                       }
            }//end of outer while
       }
       catch(Exception e1)
       {
       e1.printStackTrace();
       }
       finally
       {
       rs1.close();
       stmt1.close();
       }

}//FirstDrill If close
%>
</tr>

<tr>
<td colspan=2 class="btext">GrandTotal</td>
<td class="btext" align="right"><%=gspills%></td>
<td class="btext" align="right"><%=gnspills%></td>
<td class="btext" align="right"><%=gtspills%></td>
<td class="btext" align="right"><%=gspillsa%></td>
<td class="btext" align="right"><%=gnspillsa%></td>
<td class="btext" align="right"><%=gtspillsa%></td>
<td class="btext" align="right"><%=Math.round(gspillamt*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamt*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamt*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gspillamta*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamta*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamta*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(grevamt*100)/100f %></td>
<td class="btext" align="right"><%=ghabsan%></td>
<td class="btext" align="right"><%=ghabsana%></td>
<td class="btext" align="right"><%=Math.round(gepreyr*100)/100f%></td>
<td class="btext" align="right"><%if(geprev==0)out.println("<center>-</center>");else out.println(Math.round(geprev*100)/100f);%></td>
<td class="btext" align="right"><%=Math.round(gedur*100)/100f %></td>
<td class="btext" align="right"><%=Math.round(gcum*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(getot*100)/100f %></td>
<td class="btext" align="right"><%=gtsno%></td>
<td class="btext" align="right"><%=gten%></td>
<td class="btext" align="right"><%=gagree%></td>
<td class="btext" align="right"><%=ggrnd%></td>
<td class="btext" align="right"><%=gcomp%></td>
<td class="btext" align="right"><%=gcomm%></td>
<td class="btext" align="right"><%=ghabcov%></td>
</tr>	
<%

}
catch(Exception e)
{
	//Debug.println("Exception in drill is "+e);
	e.printStackTrace();
}
finally
{

	if(conn!=null)
	conn.close();
}
%>
</table>
<%            if(rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("-1"))
            {
%>
<p align=left><font color=brown face=verdana size=2><b>
Note: Completed Works is inclusive of the works taken up in the 
      current financial year.</b></font>
      </p>
 <%
	        }
	        else if(!rDistrict.equals("00") && drill.equals("1") && rConstituency.equals("00"))
            {
%>
<p align=left><font color=brown face=verdana size=2><b>
Note: 1. Completed Works is inclusive of the works taken up in the 
      current financial year.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      2. Habitions Covered is shown by individual division</b></font>
      </p>
 <%
}  		    else if(!rDistrict.equals("00") && drill.equals("1") && !rConstituency.equals("00"))
            {
%>
<p align=left><font color=brown face=verdana size=2><b>
Note: 1.Completed Works is inclusive of the works taken up in the 
      current financial year.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      2.Habitions Covered is shown by individual division</b></font>
      </p>
 <%
		    } 
	        else if(drill.equals("2"))
            {
%>
<p align=left><font color=brown face=verdana size=2><b>
Note: 1.Completed Works is inclusive of the works taken up in the 
      current financial year.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      2.Habitions Covered is shown by individual division</b></font>
      </p>
 <%
	        }	            
%>
</form>
<%@ include file = "footer.jsp" %>
</body>
</html>

