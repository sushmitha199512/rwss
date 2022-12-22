<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
try
{
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
   
    String currentYear= dateFormat.format(currentDate).substring(0,4);
    String currentMonth = dateFormat.format(currentDate).substring(5,7);
    System.out.println("The Current nela ::"+currentMonth);
    int nextYear = Integer.parseInt(currentYear);
    nextYear++;
    String nextYear1 = ""+nextYear;
    String currentYearPeriod = currentYear + "-" + nextYear1;
    System.out.println("Current Year Period ::"+currentYearPeriod);
    java.util.Date d1 = dateFormat.parse(currentYear+"-03-31");
    String financialYearFrom="";
    String financialYearTo="";
    //System.out.println("financialYearFrom:= ");
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
       
     //System.out.println("financialYearFrom:= " +financialYearFrom);
     //System.out.println("financialYearTo:= " +financialYearTo);
	//Debug.println("***********************REPORT BEGINING***********************");
	String rDistrict="", rConstituency="", rMandal="", rPanchayat="", rVillage="", rHabitation="", distvalue="", distname="", conname="", convalue="", manvalue="", manname="", panvalue="", panname="", vilvalue="", vilname ="";
	String districtName="",mandalName="",panchayatName="",villageName="",constituencyName="",habitationName="";
	
	rDistrict = request.getParameter("district");
	distname= request.getParameter("distname");
	
	rConstituency = request.getParameter("constituency");
	conname = request.getParameter("conname");	
	String query3="",query4="",query5="";
		
	if(request.getParameter("distname")!=null)
	{
	districtName = request.getParameter("distname");
	session.setAttribute("districtName",districtName);
	}
	if(request.getParameter("manname")!=null)
	{
	mandalName = request.getParameter("manname");
	session.setAttribute("mandalName",mandalName);
	}
	if(request.getParameter("panname")!=null)
	{
	panchayatName = request.getParameter("panname");
	session.setAttribute("panchayatName",panchayatName);
	}
	if(request.getParameter("vilname")!=null)
	{
	villageName = request.getParameter("vilname");
	session.setAttribute("villageName",villageName);
	}
	if(request.getParameter("conname")!=null)
	{
	constituencyName = request.getParameter("conname");	
	session.setAttribute("constituencyName",constituencyName);
	}
	if(request.getParameter("habName")!=null)
	{
	habitationName = request.getParameter("habName");
	session.setAttribute("habName",habitationName);
	}		
	districtName = (String)session.getAttribute("districtName");
	constituencyName = (String)session.getAttribute("constituencyName");	
		
	String query=null, query1 = null,query2=null,qry=null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	Statement stmt1 = null;
	Statement st1 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
	

%>
<html>
<head>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="./rws_worksmonitoring_workstatus_select.jsp">Back|</a></td>
			</tr>
		</table>
	</caption>
	
 
<% 	if(rDistrict != null && rDistrict.equals("00"))
	{
		query2 = "SELECT distinct A_CODE,A_NAME,WE_EXPENDITURE_UPTO,WE_EXPENDITURE_DURING,WE_EXPENDITURE_PRE_YEAR ,CON_AGMT_ENT,CON_TENDERED,CON_COMPLETED,CON_GROUNDED,WC_COMPLETED,WC_COMMISSIONED,A2_HAB_COUNT,A3_HAB_COUNT,RA_SANCTION_AMOUNT,E_NO_SANC,"+
		"SUM(CASE WHEN A1.ADMIN_DATE <= '"+financialYearFrom+"' and a1.admin_date is not null THEN 1 ELSE 0 END) AS A_SPILL_OVER,"+
		"SUM(CASE WHEN A1.ADMIN_DATE >= '"+financialYearFrom+"' and A1.ADMIN_DATE <= '"+financialYearTo+"' and a1.admin_date is not null THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,"+
		"SUM(CASE WHEN A1.ADMIN_DATE <= '"+financialYearFrom+"' and a1.admin_date is not null AND A1.SANCTION_AMOUNT IS NOT NULL THEN A1.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT,"+
		"SUM(CASE WHEN A1.ADMIN_DATE >= '"+financialYearFrom+"' and A1.ADMIN_DATE <= '"+financialYearTo+"' and a1.admin_date is not null AND A1.SANCTION_AMOUNT IS NOT NULL THEN A1.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL A1,"+
		"(SELECT A.WORK_ID AS A_WORK_ID,COUNT(distinct(A.WORK_ID)) AS A_COUNT,D.DCODE AS A_CODE,D.DNAME AS A_NAME FROM RWS_WORK_ADMN_TBL A,RWS_ADMN_HAB_LNK_TBL   "+
		"AL,RWS_DISTRICT_TBL D WHERE A.WORK_ID=AL.WORK_ID AND D.DCODE=SUBSTR(AL.HAB_CODE,1,2) and D.DCODE=SUBSTR(A.WORK_ID,5,2) GROUP BY A.WORK_ID,D.DCODE,D.DNAME),"+
		"(SELECT D.DCODE AS A2_CODE,D.DNAME AS A2_NAME,COUNT(DISTINCT(HAB_CODE)) AS A2_HAB_COUNT "+
		"FROM RWS_WORK_ADMN_TBL A2,RWS_ADMN_HAB_LNK_TBL AL2,RWS_DISTRICT_TBL D WHERE A2.WORK_ID=AL2.WORK_ID AND D.DCODE=SUBSTR(AL2.HAB_CODE,1,2)  GROUP BY D.DCODE,D.DNAME) ,"+
		"(SELECT D.DCODE AS A3_CODE,D.DNAME AS A3_NAME,COUNT(DISTINCT(HAB_CODE)) AS A3_HAB_COUNT "+
		"FROM RWS_WORK_ADMN_TBL A3,RWS_WORK_COMP_HAB_LNK_TBL AL3,RWS_DISTRICT_TBL D WHERE A3.WORK_ID=AL3.WORK_ID AND D.DCODE=SUBSTR(AL3.HAB_CODE,1,2)  GROUP BY D.DCODE,D.DNAME),"+
		"(SELECT RA_CODE,RA_NAME,SUM(CASE WHEN RA1.ESTIMATE_COST IS NOT NULL THEN RA1.ESTIMATE_COST  "+
		"ELSE 0 END)AS RA_ESTIMATE_AMOUNT,SUM(CASE WHEN RA1.REV_SANCTION_AMOUNT IS NOT NULL THEN  RA1.REV_SANCTION_AMOUNT ELSE 0 END)AS RA_SANCTION_AMOUNT,COUNT(DISTINCT(RA1.WORK_ID))AS RA_COUNT  FROM RWS_REVISED_ADM_SANC_TBL RA1,"+
		"(SELECT RA.WORK_ID AS  RA_WORK_ID,COUNT(distinct(RA.WORK_ID))AS RA_COUNT,D.DCODE AS RA_CODE,D.DNAME AS RA_NAME FROM RWS_REVISED_ADM_SANC_TBL  RA,RWS_REV_ADM_SANC_HAB_LNK_TBL RAL,RWS_DISTRICT_TBL D WHERE RA.WORK_ID=RAL.WORK_ID  AND D.DCODE=SUBSTR(RAL.HAB_CODE,1,2) GROUP BY RA.WORK_ID,D.DCODE,D.DNAME"+
		") WHERE  RA1.WORK_ID=RA_WORK_ID GROUP BY RA_CODE,RA_NAME),"+
		"(SELECT E_CODE,E_NAME,SUM(CASE WHEN E1.TS_NO  IS NOT NULL THEN  1 ELSE 0 END)AS E_NO_SANC,SUM(CASE WHEN E1.SANCTIONED_AMOUNT   IS  NOT NULL THEN E1.SANCTIONED_AMOUNT   "+
		"ELSE 0 END)AS E_SANCTION_AMOUNT,COUNT(distinct(E1.WORK_ID))AS  E_COUNT FROM RWS_NEW_EST_TBL   E1,"+
		"(SELECT E.WORK_ID AS  E_WORK_ID,D.DCODE AS E_CODE,D.DNAME AS E_NAME,COUNT(distinct(E.WORK_ID))AS E_COUNT FROM RWS_NEW_EST_TBL  "+
		"E,RWS_EST_NEW_HAB_LNK_TBL   EL,RWS_DISTRICT_TBL D WHERE E.WORK_ID=EL.WORK_ID AND  D.DCODE=SUBSTR(EL.HAB_CODE,1,2) GROUP BY E.WORK_ID,D.DCODE,D.DNAME) WHERE  E1.WORK_ID=E_WORK_ID GROUP BY E_CODE,E_NAME)EST,"+
		"(SELECT CON_CODE,CON_NAME,SUM(CASE WHEN CON1.AGREEMENT_DATE IS NOT NULL THEN 1  ELSE 0 "+
		"END)AS CON_AGMT_ENT,SUM(CASE WHEN CON1.WORK_ID  IS NOT NULL THEN  1 ELSE 0 END)AS CON_TENDERED,COUNT(DISTINCT(CON1.WORK_ID))AS CON_COUNT ,SUM(CASE WHEN DATE_OF_COMPLETION IS NOT NULL AND TO_CHAR(DATE_OF_COMPLETION,'DD-MON-YY')<SYSDATE THEN 1 ELSE 0 END)AS CON_COMPLETED,SUM(CASE WHEN DATE_OF_COMPLETION IS NOT NULL AND "+
		"TO_CHAR(AGREEMENT_DATE ,'DD-MON-YY')<SYSDATE THEN 1 ELSE 0 END)AS CON_GROUNDED  FROM RWS_CONTRACTOR_SELECTION_TBL CON1,"+
		"(SELECT CON.WORK_ID AS  CON_WORK_ID,COUNT(distinct(CON.WORK_ID))AS CON_COUNT,D.DCODE AS CON_CODE,D.DNAME AS CON_NAME FROM RWS_CONTRACTOR_SELECTION_TBL "+
		" CON,RWS_ADMN_HAB_LNK_TBL AL,RWS_DISTRICT_TBL D WHERE CON.WORK_ID=AL.WORK_ID  AND D.DCODE=SUBSTR(AL.HAB_CODE,1,2) GROUP BY CON.WORK_ID,D.DCODE,D.DNAME) WHERE  CON1.WORK_ID=CON_WORK_ID GROUP BY CON_CODE,CON_NAME"+
		" )CON ,"+
		"(SELECT WC_CODE,WC_NAME,SUM(CASE WHEN WC1.DATE_OF_COMPLETION   IS NOT NULL AND DATE_OF_COMPLETION <SYSDATE THEN  1 ELSE 0 END)AS WC_COMPLETED,SUM(CASE WHEN WC1.DATE_OF_COMM  IS  NOT NULL AND WC1.DATE_OF_COMM  <SYSDATE THEN 1   ELSE 0 END)AS "+
		" WC_COMMISSIONED FROM RWS_WORK_COMPLETION_TBL   WC1,"+
		"(SELECT WC.WORK_ID AS  WC_WORK_ID,D.DCODE AS WC_CODE,D.DNAME AS WC_NAME FROM RWS_WORK_COMPLETION_TBL  WC,RWS_ADMN_HAB_LNK_TBL   AL,RWS_DISTRICT_TBL D WHERE "+
		" WC.WORK_ID=AL.WORK_ID AND  D.DCODE=SUBSTR(AL.HAB_CODE,1,2) GROUP BY WC.WORK_ID,D.DCODE,D.DNAME) WHERE  WC1.WORK_ID=WC_WORK_ID GROUP BY WC_CODE,WC_NAME"+
		" )WORKCOMP,"+ 
		"(SELECT WE_CODE,WE_NAME,SUM(CASE WHEN WE1.EXPENDITURE_UPTO IS NOT NULL and we1.year = '"+currentYearPeriod+"' THEN WE1.EXPENDITURE_UPTO  ELSE 0 END)AS WE_EXPENDITURE_UPTO,SUM(CASE WHEN WE1.EXPENDITURE_DURING  IS NOT NULL and we1.year = '"+currentMonth+"' and we1.month = '"+currentMonth+"' THEN  WE1.EXPENDITURE_DURING  ELSE 0 END)AS WE_EXPENDITURE_DURING   FROM RWS_WORK_EXPENDITURE_TBL WE1,"+
		" (SELECT WE.WORK_ID AS  WE_WORK_ID,COUNT(distinct(WE.WORK_ID))AS WE_COUNT,D.DCODE AS WE_CODE,D.DNAME AS WE_NAME FROM  RWS_WORK_EXPENDITURE_TBL WE,RWS_ADMN_HAB_LNK_TBL  AL,RWS_DISTRICT_TBL D WHERE   WE.WORK_ID=AL.WORK_ID  AND D.DCODE=SUBSTR(AL.HAB_CODE,1,2)    GROUP BY WE.WORK_ID,D.DCODE,D.DNAME"+
		" )WHERE  WE1.WORK_ID=WE_WORK_ID GROUP BY WE_CODE,WE_NAME)WORKEXP, "+
		//code added
		"("+
		"select substr(expprev.work_id,5,2)AS expprev_coc,SUM(CASE WHEN EXPENDITURE_UPTO_THE_PRE_YEAR IS NOT NULL THEN  EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END)AS WE_EXPENDITURE_PRE_YEAR from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL expprev group by substr(expprev.work_id,5,2)"+
		")EXPPREV "+
		
		
		//end of code added
		"WHERE EXPPREV.expprev_coc(+)=SUBSTR(A1.WORK_ID,5,2)  AND A1.WORK_ID=A_WORK_ID AND A_CODE=A2_CODE AND A_CODE=A3_CODE(+) AND A_CODE=RA_CODE (+) AND A_CODE=E_CODE(+)  AND A_CODE=CON_CODE(+) AND A_CODE=WC_CODE(+) AND A_CODE=WE_CODE(+) GROUP BY A_CODE,A_NAME,A2_HAB_COUNT,A3_HAB_COUNT,RA_SANCTION_AMOUNT,E_NO_SANC,CON_AGMT_ENT,CON_TENDERED ,CON_COMPLETED "+",CON_GROUNDED,WC_COMPLETED,WC_COMMISSIONED,WE_EXPENDITURE_UPTO,WE_EXPENDITURE_DURING,WE_EXPENDITURE_PRE_YEAR ";
			
		System.out.println("rdistrict  in query2 "+query2);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	}
	//for CONSTITUENCY
	if((rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1")) || (rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00")))
	{     
	 query2="SELECT distinct A_CODE,A_NAME,WE_EXPENDITURE_UPTO,WE_EXPENDITURE_DURING,EXPPREV.WE_EXPENDITURE_PRE_YEAR ,CON_AGMT_ENT,CON_TENDERED,CON_COMPLETED,CON_GROUNDED,WC_COMPLETED,WC_COMMISSIONED,A2_HAB_COUNT,A3_HAB_COUNT,RA_SANCTION_AMOUNT,E_NO_SANC,"+
	 "SUM(CASE WHEN A1.ADMIN_DATE <= '"+financialYearFrom+"' and a1.admin_date is not null THEN 1 ELSE 0 END) AS A_SPILL_OVER,"+
	 "SUM(CASE WHEN A1.ADMIN_DATE >= '"+financialYearFrom+"' and A1.ADMIN_DATE <= '"+financialYearTo+"' and a1.admin_date is not null  THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,"+
	 "SUM(CASE WHEN A1.ADMIN_DATE <= '"+financialYearFrom+"' and a1.admin_date is not null AND A1.SANCTION_AMOUNT IS NOT NULL THEN A1.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT,"+
	 "SUM(CASE WHEN A1.ADMIN_DATE >= '"+financialYearFrom+"' and A1.ADMIN_DATE <= '"+financialYearTo+"' and a1.admin_date is not null AND A1.SANCTION_AMOUNT IS NOT NULL THEN A1.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL A1,"+
	 "(SELECT A.WORK_ID AS A_WORK_ID,COUNT(distinct(A.WORK_ID)) AS A_COUNT,D.DIVISION_OFFICE_CODE AS A_CODE,D.DIVISION_OFFICE_NAME AS A_NAME FROM RWS_WORK_ADMN_TBL A,RWS_ADMN_HAB_LNK_TBL   "+
	 " AL,RWS_DIVISION_OFFICE_TBL D WHERE A.WORK_ID=AL.WORK_ID AND D.CIRCLE_OFFICE_CODE=SUBSTR(AL.HAB_CODE,1,2)  and D.DIVISION_OFFICE_CODE= SUBSTR(A.OFFICE_CODE,4,1) AND D.CIRCLE_OFFICE_CODE='"+rDistrict+"' GROUP BY A.WORK_ID,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME) ,(SELECT D.DIVISION_OFFICE_CODE AS A2_CODE,D.DIVISION_OFFICE_NAME AS A2_NAME,COUNT(DISTINCT(HAB_CODE)) AS A2_HAB_COUNT "+
	 " FROM RWS_WORK_ADMN_TBL A2,RWS_ADMN_HAB_LNK_TBL AL2,RWS_DIVISION_OFFICE_TBL D WHERE A2.WORK_ID=AL2.WORK_ID AND D.CIRCLE_OFFICE_CODE=SUBSTR(AL2.HAB_CODE,1,2) and D.DIVISION_OFFICE_CODE= SUBSTR(A2.OFFICE_CODE,4,1) AND D.CIRCLE_OFFICE_CODE='"+rDistrict+"' GROUP BY D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME) ,(SELECT D.DIVISION_OFFICE_CODE AS A3_CODE,D.DIVISION_OFFICE_NAME AS A3_NAME,COUNT(DISTINCT(HAB_CODE)) AS A3_HAB_COUNT "+
	 " FROM RWS_WORK_ADMN_TBL A3,RWS_WORK_COMP_HAB_LNK_TBL AL3,RWS_DIVISION_OFFICE_TBL D WHERE A3.WORK_ID=AL3.WORK_ID AND D.CIRCLE_OFFICE_CODE=SUBSTR(AL3.HAB_CODE,1,2) and D.DIVISION_OFFICE_CODE= SUBSTR(A3.OFFICE_CODE,4,1) AND D.CIRCLE_OFFICE_CODE='"+rDistrict+"' GROUP BY D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME),(SELECT RA_CODE,RA_NAME,SUM(CASE WHEN RA1.ESTIMATE_COST IS NOT NULL THEN RA1.ESTIMATE_COST  "+
	 " ELSE 0 END)AS RA_ESTIMATE_AMOUNT,SUM(CASE WHEN RA1.REV_SANCTION_AMOUNT IS NOT NULL THEN  RA1.REV_SANCTION_AMOUNT ELSE 0 END)AS RA_SANCTION_AMOUNT,COUNT(DISTINCT(RA1.WORK_ID))AS RA_COUNT  FROM RWS_REVISED_ADM_SANC_TBL RA1,"+
	 " (SELECT RA.WORK_ID AS  RA_WORK_ID,COUNT(distinct(RA.WORK_ID))AS RA_COUNT,D.DIVISION_OFFICE_CODE AS RA_CODE,D.DIVISION_OFFICE_NAME AS RA_NAME FROM RWS_REVISED_ADM_SANC_TBL  RA,RWS_REV_ADM_SANC_HAB_LNK_TBL RAL,RWS_DIVISION_OFFICE_TBL D WHERE RA.WORK_ID=RAL.WORK_ID  AND D.CIRCLE_OFFICE_CODE=SUBSTR(RAL.HAB_CODE,1,2) and D.DIVISION_OFFICE_CODE=SUBSTR(RA.OFFICE_CODE,4,1) AND D.CIRCLE_OFFICE_CODE='"+rDistrict+"' GROUP BY RA.WORK_ID,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME"+
	 " ) WHERE  RA1.WORK_ID=RA_WORK_ID GROUP BY RA_CODE,RA_NAME),(SELECT E_CODE,E_NAME,SUM(CASE WHEN E1.TS_NO IS NOT NULL THEN  1 ELSE 0 END)AS E_NO_SANC,SUM(CASE WHEN E1.SANCTIONED_AMOUNT   IS  NOT NULL THEN E1.SANCTIONED_AMOUNT   "+
	 " ELSE 0 END)AS E_SANCTION_AMOUNT,COUNT(distinct(E1.WORK_ID))AS  E_COUNT FROM RWS_NEW_EST_TBL  E1,(SELECT E.WORK_ID AS  E_WORK_ID,D.DIVISION_OFFICE_CODE AS E_CODE,D.DIVISION_OFFICE_NAME AS E_NAME,COUNT(distinct(E.WORK_ID))AS E_COUNT FROM RWS_NEW_EST_TBL  "+
	 " E,RWS_EST_NEW_HAB_LNK_TBL EL,RWS_DIVISION_OFFICE_TBL D WHERE E.WORK_ID=EL.WORK_ID AND  D.CIRCLE_OFFICE_CODE=SUBSTR(EL.HAB_CODE,1,2) and D.DIVISION_OFFICE_CODE=SUBSTR(E.OFFICE_CODE,4,1) AND D.CIRCLE_OFFICE_CODE='"+rDistrict+"' GROUP BY E.WORK_ID,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME) WHERE  E1.WORK_ID=E_WORK_ID GROUP BY E_CODE,E_NAME)EST,(SELECT CON_CODE,CON_NAME,SUM(CASE WHEN CON1.AGREEMENT_DATE IS NOT NULL THEN 1  ELSE 0 "+
	 " END)AS CON_AGMT_ENT,SUM(CASE WHEN CON1.WORK_ID  IS NOT NULL THEN  1 ELSE 0 END)AS CON_TENDERED,COUNT(DISTINCT(CON1.WORK_ID))AS CON_COUNT ,SUM(CASE WHEN DATE_OF_COMPLETION IS NOT NULL AND TO_CHAR(DATE_OF_COMPLETION,'DD-MON-YY')<SYSDATE THEN 1 ELSE 0 END)AS CON_COMPLETED,SUM(CASE WHEN DATE_OF_COMPLETION IS NOT NULL AND "+
	 " TO_CHAR(AGREEMENT_DATE ,'DD-MON-YY')<SYSDATE THEN 1 ELSE 0 END)AS CON_GROUNDED  FROM RWS_CONTRACTOR_SELECTION_TBL CON1,(SELECT CON.WORK_ID AS  CON_WORK_ID,COUNT(distinct(CON.WORK_ID))AS CON_COUNT,D.DIVISION_OFFICE_CODE AS CON_CODE,D.DIVISION_OFFICE_NAME AS CON_NAME FROM RWS_CONTRACTOR_SELECTION_TBL "+
	 " CON,RWS_ADMN_HAB_LNK_TBL AL,RWS_DIVISION_OFFICE_TBL D,RWS_WORK_ADMN_TBL A WHERE CON.WORK_ID=AL.WORK_ID  AND AL.WORK_ID=A.WORK_ID AND D.CIRCLE_OFFICE_CODE=SUBSTR(AL.HAB_CODE,1,2) AND D.DIVISION_OFFICE_CODE= SUBSTR(A.OFFICE_CODE,4,1) AND D.CIRCLE_OFFICE_CODE='"+rDistrict+"' GROUP BY CON.WORK_ID,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME) WHERE  CON1.WORK_ID=CON_WORK_ID GROUP BY CON_CODE,CON_NAME"+
	 " )CON ,(SELECT WC_CODE,WC_NAME,SUM(CASE WHEN WC1.DATE_OF_COMPLETION   IS NOT NULL AND DATE_OF_COMPLETION <SYSDATE THEN  1 ELSE 0 END)AS WC_COMPLETED,SUM(CASE WHEN WC1.DATE_OF_COMM  IS  NOT NULL AND WC1.DATE_OF_COMM  <SYSDATE THEN 1   ELSE 0 END)AS "+" WC_COMMISSIONED FROM RWS_WORK_COMPLETION_TBL   WC1,(SELECT WC.WORK_ID AS  WC_WORK_ID,D.DIVISION_OFFICE_CODE AS WC_CODE,D.DIVISION_OFFICE_NAME AS WC_NAME FROM RWS_WORK_COMPLETION_TBL  WC,RWS_ADMN_HAB_LNK_TBL AL,RWS_DIVISION_OFFICE_TBL D ,RWS_WORK_ADMN_TBL A  WHERE "+
	 " WC.WORK_ID=AL.WORK_ID AND  AL.WORK_ID=A.WORK_ID AND D.CIRCLE_OFFICE_CODE=SUBSTR(AL.HAB_CODE,1,2) AND D.DIVISION_OFFICE_CODE=SUBSTR(A.OFFICE_CODE,4,1) AND D.CIRCLE_OFFICE_CODE='"+rDistrict+"' GROUP BY WC.WORK_ID,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME) WHERE  WC1.WORK_ID=WC_WORK_ID GROUP BY WC_CODE,WC_NAME"+
	 " )WORKCOMP, "+
	 "(SELECT WE_CODE,WE_NAME,SUM(CASE WHEN WE1.EXPENDITURE_UPTO IS NOT NULL THEN WE1.EXPENDITURE_UPTO  ELSE 0 END)AS WE_EXPENDITURE_UPTO,SUM(CASE WHEN WE1.EXPENDITURE_DURING  IS NOT NULL THEN  WE1.EXPENDITURE_DURING  ELSE 0 END)AS WE_EXPENDITURE_DURING   FROM RWS_WORK_EXPENDITURE_TBL WE1,"+
	 " (SELECT WE.WORK_ID AS  WE_WORK_ID,COUNT(distinct(WE.WORK_ID))AS WE_COUNT,D.DIVISION_OFFICE_CODE AS WE_CODE,D.DIVISION_OFFICE_NAME AS WE_NAME FROM  RWS_WORK_EXPENDITURE_TBL WE,RWS_ADMN_HAB_LNK_TBL  AL,RWS_DIVISION_OFFICE_TBL D,RWS_WORK_ADMN_TBL A WHERE WE.WORK_ID=AL.WORK_ID  AND AL.WORK_ID =A.WORK_ID AND  D.CIRCLE_OFFICE_CODE=SUBSTR(AL.HAB_CODE,1,2) AND  D.DIVISION_OFFICE_CODE=SUBSTR(A.OFFICE_CODE,4,1) AND D.CIRCLE_OFFICE_CODE='"+rDistrict+"'    GROUP BY WE.WORK_ID,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME"+
	 " )WHERE  WE1.WORK_ID=WE_WORK_ID GROUP BY WE_CODE,WE_NAME)WORKEXP,"+
	 //code added
	 "("+
	 "select substr(expprev.work_id,5,2)AS expprev_coc,substr(workadmn.office_code,4,1)AS expprev_doc,SUM(CASE WHEN EXPENDITURE_UPTO_THE_PRE_YEAR IS NOT NULL THEN  EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END)AS WE_EXPENDITURE_PRE_YEAR from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL expprev,RWS_WORK_ADMN_TBL WORKADMN where WORKADMN.WORK_ID=EXPPREV.WORK_ID group by substr(expprev.work_id,5,2),substr(workadmn.office_code,4,1)"+
	 ")EXPPREV"+
			 
	 //end of code added
	 " WHERE EXPPREV.expprev_coc(+)=substr(A_WORK_ID,5,2) AND A1.WORK_ID=A_WORK_ID and EXPPREV.expprev_doc(+)=A_CODE AND A1.WORK_ID=A_WORK_ID AND A_CODE=A2_CODE AND A_CODE=A3_CODE(+) AND A_CODE=RA_CODE (+) AND A_CODE=E_CODE (+)  AND A_CODE=CON_CODE(+) AND A_CODE=WC_CODE(+) AND A_CODE=WE_CODE(+) GROUP BY A_CODE,A_NAME,A2_HAB_COUNT,A3_HAB_COUNT,RA_SANCTION_AMOUNT,E_NO_SANC,CON_AGMT_ENT,CON_TENDERED ,CON_COMPLETED "+",CON_GROUNDED,WC_COMPLETED,WC_COMMISSIONED,WE_EXPENDITURE_UPTO,WE_EXPENDITURE_DURING,EXPPREV.WE_EXPENDITURE_PRE_YEAR";
	 //Debug.println("query is "+query2);
	// System.out.println("query2 in rdistrict "+query2);
	 stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	}

	//FOR HABITATION
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1"))
	{
	//System.out.println("in qry");
		/*query2="SELECT DISTINCT A.work_name AS A_WNAME, CASE WHEN TO_CHAR(A.ADMIN_DATE,'DD-MON-YYYY') < '"+financialYearFrom+"' THEN 'Y' ELSE '--' END AS A_SPILL_OVER,CASE WHEN TO_CHAR (A.ADMIN_DATE,'DD-MON-YYYY') >= '"+financialYearFrom+"' THEN 'Y' ELSE '--' END AS A_NON_SPILL_OVER,CASE WHEN TO_CHAR(A.ADMIN_DATE,'DD-MON-YYYY') < '"+financialYearFrom+"' AND A.SANCTION_AMOUNT IS NOT NULL THEN A.SANCTION_AMOUNT ELSE 0 END AS A_SPILL_OVER_AMT,CASE WHEN TO_CHAR(A.ADMIN_DATE,'DD-MON-YYYY') >= '"+financialYearFrom+"' AND A.SANCTION_AMOUNT IS NOT NULL THEN A.SANCTION_AMOUNT ELSE 0 END AS A_NON_SPILL_OVER_AMT,A.No_of_habs AS NO_OF_HABS,R.REV_SANCTION_AMOUNT as RA_SANCTION_AMOUNT, Ex.EXPENDITURE_UPTO_THE_PRE_YEAR as WE_EXPENDITURE_PRE_YEAR,Ex.EXPENDITURE_UPTO as WE_EXPENDITURE_UPTO, Ex.EXPENDITURE_DURING AS WE_EXPENDITURE_DURING,CASE WHEN T.TS_NO IS NOT NULL THEN 'Y' ELSE '--' END AS E_NO_SANC,CASE WHEN CON.AGREEMENT_DATE IS NOT NULL THEN 'Y' ELSE '--' END AS CON_AGMT_ENT, CASE WHEN CON.WORK_ID IS NOT NULL THEN 'Y' ELSE '--' END AS CON_TENDERED, CASE WHEN WC.DATE_OF_COMPLETION IS NOT NULL AND TO_CHAR(WC.DATE_OF_COMPLETION,'DD-MON-YY') < SYSDATE THEN 'Y' ELSE '--' END AS WC_COMPLETED, CASE WHEN CON.DATE_OF_COMPLETION IS NOT NULL AND TO_CHAR (AGREEMENT_DATE ,'DD-MON-YY') < SYSDATE THEN 'Y' ELSE '--' END AS CON_GROUNDED,CASE WHEN WC.DATE_OF_COMM IS NOT NULL AND WC.DATE_OF_COMM < SYSDATE THEN 'Y' ELSE '--' END AS WC_COMMISSIONED FROM "+"RWS_WORK_ADMN_TBL A,RWS_REVISED_ADM_SANC_TBL R,RWS_WORK_EXPENDITURE_TBL ex,RWS_NEW_EST_TBL T,RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMPLETION_TBL WC WHERE A.WORK_ID=R.WORK_ID(+) AND A.OFFICE_CODE=R.OFFICE_CODE(+) AND SUBSTR (A.OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR (A.OFFICE_CODE,4,1)='"+rConstituency+"' and ex.work_id(+)=a.work_id AND T.WORK_ID(+)=a.work_id AND A.OFFICE_CODE =T.OFFICE_CODE(+) and CON.work_id(+)=a.work_id and WC.work_id(+)=a.work_id";*/ 
        query2="SELECT DISTINCT A.work_name AS A_WNAME,"+
         "CASE WHEN A.ADMIN_DATE <= '"+financialYearFrom+"' and a.admin_date is not null THEN 'Y' ELSE '--' END AS A_SPILL_OVER,"+
         "CASE WHEN A.ADMIN_DATE >= '"+financialYearFrom+"' and A.ADMIN_DATE <= '"+financialYearTo+"' and a.admin_date is not null THEN 'Y' ELSE '--' END AS A_NON_SPILL_OVER,"+
         "CASE WHEN A.ADMIN_DATE <= '"+financialYearFrom+"' and a.admin_date is not null AND A.SANCTION_AMOUNT IS NOT NULL THEN A.SANCTION_AMOUNT ELSE 0 END AS A_SPILL_OVER_AMT,"+
         "CASE WHEN A.ADMIN_DATE >= '"+financialYearFrom+"' and A.ADMIN_DATE <= '"+financialYearTo+"' and a.admin_date is not null AND A.SANCTION_AMOUNT IS NOT NULL THEN A.SANCTION_AMOUNT ELSE 0 END AS A_NON_SPILL_OVER_AMT,"+
         "A.No_of_habs AS NO_OF_HABS,R.REV_SANCTION_AMOUNT as RA_SANCTION_AMOUNT,Ex1.EXPENDITURE_UPTO_THE_PRE_YEAR as WE_EXPENDITURE_PRE_YEAR,Ex.EXPENDITURE_UPTO as WE_EXPENDITURE_UPTO,Ex.EXPENDITURE_DURING AS WE_EXPENDITURE_DURING,"+
         "CASE WHEN T.TS_NO IS NOT NULL THEN 'Y' ELSE '--' END AS E_NO_SANC,CASE WHEN CON.AGREEMENT_DATE IS NOT NULL THEN 'Y' ELSE '--' END AS CON_AGMT_ENT, CASE WHEN CON.WORK_ID IS NOT NULL THEN 'Y' ELSE '--' END AS CON_TENDERED,"+
         "CASE WHEN WC.DATE_OF_COMPLETION IS NOT NULL AND TO_CHAR(WC.DATE_OF_COMPLETION,'DD-MON-YY') < SYSDATE THEN 'Y' ELSE '--' END AS WC_COMPLETED,"+
         "CASE WHEN CON.DATE_OF_COMPLETION IS NOT NULL AND TO_CHAR (AGREEMENT_DATE ,'DD-MON-YY') < SYSDATE THEN 'Y' ELSE '--' END AS CON_GROUNDED,"+
         "CASE WHEN WC.DATE_OF_COMM IS NOT NULL AND WC.DATE_OF_COMM < SYSDATE THEN 'Y' ELSE '--' END AS WC_COMMISSIONED FROM RWS_WORK_ADMN_TBL A,RWS_REVISED_ADM_SANC_TBL R,RWS_WORK_EXPENDITURE_TBL ex,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL Ex1,RWS_NEW_EST_TBL T,"+
         "RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMPLETION_TBL WC WHERE A.WORK_ID=R.WORK_ID(+) AND A.OFFICE_CODE=R.OFFICE_CODE(+) AND SUBSTR(A.OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR(A.OFFICE_CODE,4,1)='"+rConstituency+"' and Ex1.work_id(+)=a.work_id and ex.work_id(+)=a.work_id AND T.WORK_ID(+)=a.work_id AND A.OFFICE_CODE =T.OFFICE_CODE(+) and CON.work_id(+)=a.work_id and WC.work_id(+)=a.work_id";
        qry= "select distinct a.work_name,count(WC1.hab_code) as hab_count FROM RWS_WORK_ADMN_TBL A,RWS_REVISED_ADM_SANC_TBL R,RWS_WORK_EXPENDITURE_TBL ex,RWS_NEW_EST_TBL T,RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMPLETION_TBL WC,RWS_WORK_COMP_HAB_LNK_TBL WC1 WHERE A.WORK_ID=R.WORK_ID(+) AND A.OFFICE_CODE=R.OFFICE_CODE(+) AND SUBSTR (A.OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR(A.OFFICE_CODE,4,1)='"+rConstituency+"' and ex.work_id(+)=a.work_id AND T.WORK_ID(+)=a.work_id AND A.OFFICE_CODE =T.OFFICE_CODE(+) and CON.work_id(+)=a.work_id and WC.work_id(+)=a.work_id AND WC1.work_id(+)=a.work_id group by a.work_name";
		st1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs1 = st1.executeQuery(qry);
		//System.out.println("in qry"+qry);
	}
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs2 = stmt1.executeQuery(query2);
	//System.out.println("query2 is "+query2);
%>

<%@ include file="./rws_worksmonitoring_workstatus_label.jsp"%>

<%	float spillamt=0,nonspillamt=0,totalspillamt=0,totRevisedSanctionAmt=0;
	float expprev=0,expupto=0,expdur=0,cumexp=0,totexp=0;
	int spillover=0,nonspillover=0,totalspills=0,habsanction=0,tsanc=0,conten=0,conagmt=0,congr=0,concom=0,concomm=0,concount=0;
	String code="",name="",wname="";
	int ii=1;
	while(rs2.next())
	{		
	 ++ slno;
	 //System.out.println("slno"+slno);
%>
	<tr onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
	<td class=rptValue><%=slno%></td>
<%	if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1"))
	{	
	//System.out.println("(1)");
	//System.out.println("rs2.getString(1) "+rs2.getString(1));
	//System.out.println("rs2.getString(A_NAME) "+rs2.getString("A_NAME"));
	//System.out.println("rs2.getString(A_NAME) "+rs2.getString("A_CODE"));	
%>		
	<td class=rptValue><a href="./rws_worksmonitoring_workstatus_drill.jsp?distvalue=<%=rs2.getString(1)%>&distname=
	<%=rs2.getString("A_NAME")%>&district=<%=rs2.getString("A_CODE")%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&constituency=<%=rConstituency%>"><%=rs2.getString("A_NAME")%></a></td>
<%	
	}
	//System.out.println("(2 rest)");
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1") || rDistrict!= null && !rDistrict.equals("00") && rConstituency.equals("00")) 
	{			
%>
	<td class=rptValue align="left"><a href="./rws_worksmonitoring_workstatus_drill.jsp?district=<%=rDistrict%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&constituency=<%=rs2.getString("A_CODE")%>&convalue=<%=rs2.getString("A_CODE")%>&conname=<%=rs2.getString("A_NAME")%>"><%=rs2.getString("A_NAME")%></a></td>
<%	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00"))
	{
	//System.out.println("(3 rest)");
%>		
	<td class=rptValue align="left"><%=rs2.getString("A_WNAME")%></td>
<%//Debug.println("1"); %>
	<td class=rptValue align="right"><%=rs2.getString("A_SPILL_OVER")%></td>
<% //Debug.println("2"); %>
	<td class=rptValue align="right"><%=rs2.getString("A_NON_SPILL_OVER")%></td>
<%//Debug.println("3"); %>
	<td class=rptValue align="right">--</td>
<%//Debug.println("4"); %>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("A_SPILL_OVER_AMT"))*100)/100f%></td>
<%//Debug.println("5"); %>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("A_NON_SPILL_OVER_AMT"))*100)/100f%></td>	
<%//Debug.println("6"); %>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("A_SPILL_OVER_AMT")+rs2.getFloat("A_NON_SPILL_OVER_AMT"))*100)/100f%></td>		
<%//Debug.println("7"); %>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("RA_SANCTION_AMOUNT"))*100)/100f%></td>
<%//Debug.println("8"); %>
	<td class=rptValue align="right"><%=rs2.getInt("NO_OF_HABS")%></td>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("WE_EXPENDITURE_PRE_YEAR"))*100)/100f%></td>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("WE_EXPENDITURE_UPTO"))*100)/100f%></td>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("WE_EXPENDITURE_DURING"))*100)/100f%></td>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("WE_EXPENDITURE_UPTO")+rs2.getFloat("WE_EXPENDITURE_DURING"))*100)/100f%></td>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("WE_EXPENDITURE_PRE_YEAR")+rs2.getFloat("WE_EXPENDITURE_UPTO")+rs2.getFloat("WE_EXPENDITURE_DURING"))*100)/100f%></td>
	<td class=rptValue align="right"><%=rs2.getString("E_NO_SANC")%></td>
	<td class=rptValue align="right"><%=rs2.getString("CON_TENDERED")%></td>
	<td class=rptValue align="right"><%=rs2.getString("CON_AGMT_ENT")%></td>
	<td class=rptValue align="right"><%=rs2.getString("CON_GROUNDED")%></td>
	<td class=rptValue align="right"><%=rs2.getString("WC_COMPLETED")%></td>
	<td class=rptValue align="right"><%=rs2.getString("WC_COMMISSIONED")%></td>
<%//try 
	 // {	
	  	//rs1.next();
	if(rs1.next()==false)
	{		
	%>
		<td class=rptValue align="right">--</td>
	<%}
	 else{ 
		 //System.out.println("else");
		 //System.out.println("rs1 "+ii++);
 %>
 	<td class=rptValue align="right"><%=rs1.getInt("hab_count")%></td>
	 		
<%   }//end of if
	 //}
//catch(SQLException e)
	 //{		
		//System.out.println("Exception e "+e);
	 //}	
	}
	else {
%>	    
<%//Debug.println("1");
	//System.out.println("(1)");%>
	<td class=rptValue align="right"><%=rs2.getInt("A_SPILL_OVER")%></td>
<% 	spillover=spillover+rs2.getInt("A_SPILL_OVER");
	//Debug.println("2");
	//System.out.println("(2)");%>
	<td class=rptValue align="right"><%=rs2.getInt("A_NON_SPILL_OVER")%></td>
<%	nonspillover=nonspillover+rs2.getInt("A_NON_SPILL_OVER");
	//Debug.println("3");
	//System.out.println("(3)");%>
	<td class=rptValue align="right"><%=rs2.getInt("A_SPILL_OVER")+rs2.getInt("A_NON_SPILL_OVER")%></td>
<%	totalspills=totalspills+rs2.getInt("A_SPILL_OVER")+rs2.getInt("A_NON_SPILL_OVER");
	 //Debug.println("4");
	 //System.out.println("(4)");%>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("A_SPILL_OVER_AMT"))*100)/100f%></td>
<%	spillamt=spillamt+rs2.getFloat("A_SPILL_OVER_AMT");
	//Debug.println("5");
	//System.out.println("(5)");%>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("A_NON_SPILL_OVER_AMT"))*100)/100f%></td>	
<%  nonspillamt=nonspillamt+rs2.getFloat("A_NON_SPILL_OVER_AMT");
	//Debug.println("6");
	//System.out.println("(6)");%>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("A_SPILL_OVER_AMT")+rs2.getFloat("A_NON_SPILL_OVER_AMT"))*100)/100f%></td>		
<%  totalspillamt=totalspillamt+rs2.getFloat("A_SPILL_OVER_AMT")+rs2.getFloat("A_NON_SPILL_OVER_AMT");
	//Debug.println("7");
	//System.out.println("(7)");%>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("RA_SANCTION_AMOUNT"))*100)/100f%></td>
<%//Debug.println("8"); 
	totRevisedSanctionAmt=totRevisedSanctionAmt+rs2.getFloat("RA_SANCTION_AMOUNT");
%>
	<td class=rptValue align="right"><%=rs2.getInt("A2_HAB_COUNT")%></td>
<%	habsanction=habsanction+rs2.getInt("A2_HAB_COUNT"); 
//System.out.println("(8)");%>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("WE_EXPENDITURE_PRE_YEAR"))*100)/100f%></td>
<%	expprev=expprev+rs2.getFloat("WE_EXPENDITURE_PRE_YEAR");
	expupto=expupto+rs2.getFloat("WE_EXPENDITURE_UPTO");
%>
	<td class=rptValue align="right"><%if(currentMonth.equals("04"))out.println("<center>-</center>");else out.println(rs2.getFloat("WE_EXPENDITURE_UPTO"));%></td>
<%  //Debug.println("11"); 
	expdur=expdur+rs2.getFloat("WE_EXPENDITURE_DURING");
%>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("WE_EXPENDITURE_DURING"))*100)/100f%></td>
<%//Debug.println("12");
	cumexp=cumexp+rs2.getFloat("WE_EXPENDITURE_UPTO")+rs2.getFloat("WE_EXPENDITURE_DURING");
	totexp=totexp+rs2.getFloat("WE_EXPENDITURE_PRE_YEAR")+rs2.getFloat("WE_EXPENDITURE_UPTO")+
	rs2.getFloat("WE_EXPENDITURE_DURING");
	//System.out.println("(9)"); 
%>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("WE_EXPENDITURE_UPTO")+rs2.getFloat("WE_EXPENDITURE_DURING"))*100)/100f%></td>
	<td class=rptValue align="right"><%=Math.round((rs2.getFloat("WE_EXPENDITURE_PRE_YEAR")+rs2.getFloat("WE_EXPENDITURE_UPTO")+rs2.getFloat("WE_EXPENDITURE_DURING"))*100)/100f%></td> 
<%
	tsanc=tsanc+rs2.getInt("E_NO_SANC");
    conten=conten+rs2.getInt("CON_TENDERED");
	conagmt=conagmt+rs2.getInt("CON_AGMT_ENT");
	congr=congr+rs2.getInt("CON_GROUNDED");
    concom=concom+rs2.getInt("WC_COMPLETED");
	concomm=concomm+rs2.getInt("WC_COMMISSIONED");
	concount=concount+rs2.getInt("A3_HAB_COUNT");
	//System.out.println("(10)"); 
%>
	<td class=rptValue align="right"><%=rs2.getInt("E_NO_SANC")%></td>
	<td class=rptValue align="right"><%=rs2.getInt("CON_TENDERED")%></td>
	<td class=rptValue align="right"><%=rs2.getInt("CON_AGMT_ENT")%></td>
	<td class=rptValue align="right"><%=rs2.getInt("CON_GROUNDED")%></td>
	<td class=rptValue align="right"><%=rs2.getInt("WC_COMPLETED")%></td>
	<td class=rptValue align="right"><%=rs2.getInt("WC_COMMISSIONED")%></td>
    <td class=rptValue align="right"><%=rs2.getInt("A3_HAB_COUNT")%></td>
<%//System.out.println("(11)"); 
}
%>
	</tr>
<% 	}
 	if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1") ||
	(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1") || rDistrict!= null && !rDistrict.equals("00") && rConstituency.equals("00")) )
	{
%>
	 <tr class="btext">
		 <td class=btext colspan=2>GrandTotal</td>
		 <td class=btext align="right"><%=spillover%></td>
		 <td class=btext align="right"><%=nonspillover%></td>
         <td class=btext align="right"><%=totalspills%></td>
		 <td class=btext align="right"><%=Math.round(spillamt*100)/100f%></td>
		 <td class=btext align="right"><%=Math.round(nonspillamt*100)/100f%></td>
		 <td class=btext align="right"><%=Math.round(totalspillamt*100)/100f%></td>
		 <td class=btext align="right"><%=Math.round(totRevisedSanctionAmt*100)/100f%></td>
		 <td class=btext align="right"><%=habsanction%></td>
		 <td class=btext align="right"><%=Math.round(expprev*100)/100f%></td>
		 <td class=btext align="right"><%if(expupto==0)out.println("<center>-</center>");else out.println(Math.round(expupto*100)/100f);%></td>
		 <td class=btext align="right"><%=Math.round(expdur*100)/100f%></td>
		 <td class=btext align="right"><%=Math.round(cumexp*100)/100f%></td>
		 <td class=btext align="right"><%=Math.round(totexp*100)/100f%></td>
		 <td class=btext align="right"><%=tsanc%></td>
		 <td class=btext align="right"><%=conten%></td>
		 <td class=btext align="right"><%=conagmt%></td>
		 <td class=btext align="right"><%=congr%></td>
		 <td class=btext align="right"><%=concom%></td>
		 <td class=btext align="right"><%=concomm%></td>
		 <td class=btext align="right"><%=concount%></td>
	 </tr>
<%}
	if(slno==0){
%>
	<tr>
		<td class="rptValue" colspan="25" align="center"><a href="./rws_worksmonitoring_workstatus_select.jsp"><b>No Records</b></a></td>
	</tr>
<%}   
  rs2.close();
%>
</tr>
</table>
<%	
}	
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