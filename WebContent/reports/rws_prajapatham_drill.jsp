<%@ include file="/commons/rws_prajapatham_header1.jsp"%>
<%@ include file="/commons/rws_prajapatham_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("***********************REPORT BEGINING***********************");
	String rDistrict="", rConstituency="", rMandal="", rPanchayat="", rVillage="", rHabitation="", distvalue="", distname="", conname="", convalue="", manvalue="", manname="", panvalue="", panname="", vilvalue="", vilname ="";
	
	rDistrict = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	rVillage = request.getParameter("village");
	rHabitation=request.getParameter("habitation");
	rConstituency = request.getParameter("constituency");
	
	//String districtName = (String)session.getAttribute("districtName");
	//String mandalName = (String)session.getAttribute("mandalName");
	//String panchayatName = (String)session.getAttribute("panchayatName");
	//String villageName = (String)session.getAttribute("villageName");
	//String constituencyName = (String)session.getAttribute("constituencyName");	
	//String habitationName = (String)session.getAttribute("habName");	
	
	String districtName="",mandalName="",panchayatName="",villageName="",constituencyName="",habitationName="";
	
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
	mandalName = (String)session.getAttribute("mandalName");
	panchayatName = (String)session.getAttribute("panchayatName");
	villageName = (String)session.getAttribute("villageName");
	constituencyName = (String)session.getAttribute("constituencyName");	
	habitationName = (String)session.getAttribute("habName");	
	
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	Statement stmt1 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;

	//int[] gcount = new int[8];
	//int[] gcount1= new int[8];
	//String[] coveragestatus = {"FC","NC","NSS","PC1","PC2","PC3","PC4","UI"};
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
			<tr align="right">
			    <td class="bwborder"><a href="../home.jsp?loginMode=prajapatham">Home|</a></td>
				<td class="bwborder"><a href="./rws_prajapatham_selectHab_frm.jsp">Back|</a></td>
				<!--<td class="bwborder"><a href="./constituency_excelrpt.jsp?district=<%=rDistrict%>&constituency=<%=rConstituency%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>" target="_new">Excel|</a></td>-->
				 
			</tr>
		</table>
	</caption>
<% 
	//stmt = conn.createStatement();
    
	if(rDistrict != null && rDistrict.equals("00"))
	{
			
		query2="SELECT DISTINCT d.Dcode,d.DNAME,SUM(Case When P.WORK_ID is not null  then 1 Else 0 End) as WORK_ID, SUM(Case When P.ESTIMATE_COST is not null then P.ESTIMATE_COST Else 0 End) as ESTIMATE_COST ,SUM(Case When P.EXP_UPTO_THE_PRE_MONTH is not null then P.EXP_UPTO_THE_PRE_MONTH Else 0 End) as EXP_UPTO_THE_PRE_MONTH ,SUM(Case When P.EXP_DUR_THE_MONTH is not null then P.EXP_DUR_THE_MONTH  Else 0 End) AS EXP_DUR_THE_MONTH ,SUM(Case When P.EXP_TO_BE_INCURRED is not null then P.EXP_TO_BE_INCURRED Else 0 End) AS EXP_TO_BE_INCURRED, SUM(Case When P.GROUND_DATE  is not null then 1  Else 0 End) AS GROUND_DATE , SUM(Case When P.COMPLETION_DATE  is not null then 1  Else 0 End) AS COMPLETION_DATE,count(*) from rws_district_tbl d,rws_prajapadam_tbl P where d.dcode=substr(P.hab_code,1,2) group by d.dcode,d.dname";
        //System.out.println("first query2 is "+query2);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		query2="SELECT DISTINCT C.CONSTITUENCY_CODE,C.CONSTITUENCY_NAME,SUM(Case When P.WORK_ID is not null  then 1 Else 0 End) as WORK_ID, SUM(Case When P.ESTIMATE_COST is not null then P.ESTIMATE_COST Else 0 End) as ESTIMATE_COST ,SUM(Case When P.EXP_UPTO_THE_PRE_MONTH is not null then P.EXP_UPTO_THE_PRE_MONTH Else 0 End) as EXP_UPTO_THE_PRE_MONTH ,SUM(Case When P.EXP_DUR_THE_MONTH is not null then P.EXP_DUR_THE_MONTH  Else 0 End) AS EXP_DUR_THE_MONTH ,SUM(Case When P.EXP_TO_BE_INCURRED is not null then P.EXP_TO_BE_INCURRED Else 0 End) AS EXP_TO_BE_INCURRED, SUM(Case When P.GROUND_DATE  is not null then 1  Else 0 End) AS GROUND_DATE , SUM(Case When P.COMPLETION_DATE  is not null then 1  Else 0 End) AS COMPLETION_DATE,count(*)FROM RWS_CONSTITUENCY_TBL C, rws_prajapadam_tbl P WHERE SUBSTR(P.HAB_CODE,1,2) = C.DCODE AND C.DCODE = '"+rDistrict+"' AND SUBSTR(P.HAB_CODE,3,3) = C.CONSTITUENCY_CODE GROUP BY C.CONSTITUENCY_CODE,C.CONSTITUENCY_NAME";
        //System.out.println("first query2 is "+query2);
	
     stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00"))
	{
		
     
	  	query2="SELECT DISTINCT C.CONSTITUENCY_CODE,C.CONSTITUENCY_NAME,SUM(Case When P.WORK_ID is not null  then 1 Else 0 End) as WORK_ID, SUM(Case When P.ESTIMATE_COST is not null then P.ESTIMATE_COST Else 0 End) as ESTIMATE_COST ,SUM(Case When P.EXP_UPTO_THE_PRE_MONTH is not null then P.EXP_UPTO_THE_PRE_MONTH Else 0 End) as EXP_UPTO_THE_PRE_MONTH ,SUM(Case When P.EXP_DUR_THE_MONTH is not null then P.EXP_DUR_THE_MONTH  Else 0 End) AS EXP_DUR_THE_MONTH ,SUM(Case When P.EXP_TO_BE_INCURRED is not null then P.EXP_TO_BE_INCURRED Else 0 End) AS EXP_TO_BE_INCURRED, SUM(Case When P.GROUND_DATE  is not null then 1  Else 0 End) AS GROUND_DATE , SUM(Case When P.COMPLETION_DATE  is not null then 1  Else 0 End) AS COMPLETION_DATE,count(*)FROM RWS_CONSTITUENCY_TBL C, rws_prajapadam_tbl P WHERE SUBSTR(P.HAB_CODE,1,2) = C.DCODE AND C.DCODE = '"+rDistrict+"' AND SUBSTR(P.HAB_CODE,3,3) = C.CONSTITUENCY_CODE GROUP BY C.CONSTITUENCY_CODE,C.CONSTITUENCY_NAME";
	    //System.out.println("first query2 is "+query2);
     stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && rMandal.equals("-1"))
	{
		query2="SELECT DISTINCT m.mcode,M.MNAME,SUM(Case When P.WORK_ID is not null  then 1 Else 0 End) as WORK_ID, SUM(Case When P.ESTIMATE_COST is not null then P.ESTIMATE_COST Else 0 End) as ESTIMATE_COST ,SUM(Case When P.EXP_UPTO_THE_PRE_MONTH is not null then P.EXP_UPTO_THE_PRE_MONTH Else 0 End) as EXP_UPTO_THE_PRE_MONTH ,SUM(Case When P.EXP_DUR_THE_MONTH is not null then P.EXP_DUR_THE_MONTH  Else 0 End) AS EXP_DUR_THE_MONTH ,SUM(Case When P.EXP_TO_BE_INCURRED is not null then P.EXP_TO_BE_INCURRED Else 0 End) AS EXP_TO_BE_INCURRED, SUM(Case When P.GROUND_DATE  is not null then 1  Else 0 End) AS GROUND_DATE , SUM(Case When P.COMPLETION_DATE  is not null then 1  Else 0 End) AS COMPLETION_DATE, count(*)  FROM RWS_MANDAL_TBL M, RWS_CONSTITUENCY_TBL C,   rws_prajapadam_tbl P WHERE SUBSTR(P.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '" + rDistrict + "' AND SUBSTR(P.HAB_CODE,6,2) = M.MCODE AND C.DCODE = M.DCODE AND SUBSTR(P.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+rConstituency+"' GROUP BY m.mcode,m.mname";
        //System.out.println("first query2 is "+query2);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		
         query2="SELECT DISTINCT m.mcode,M.MNAME,SUM(Case When P.WORK_ID is not null  then 1 Else 0 End) as WORK_ID, SUM(Case When P.ESTIMATE_COST is not null then P.ESTIMATE_COST Else 0 End) as ESTIMATE_COST ,SUM(Case When P.EXP_UPTO_THE_PRE_MONTH is not null then P.EXP_UPTO_THE_PRE_MONTH Else 0 End) as EXP_UPTO_THE_PRE_MONTH ,SUM(Case When P.EXP_DUR_THE_MONTH is not null then P.EXP_DUR_THE_MONTH  Else 0 End) AS EXP_DUR_THE_MONTH ,SUM(Case When P.EXP_TO_BE_INCURRED is not null then P.EXP_TO_BE_INCURRED Else 0 End) AS EXP_TO_BE_INCURRED, SUM(Case When P.GROUND_DATE  is not null then 1  Else 0 End) AS GROUND_DATE , SUM(Case When P.COMPLETION_DATE  is not null then 1  Else 0 End) AS COMPLETION_DATE, count(*)  FROM RWS_MANDAL_TBL M, RWS_CONSTITUENCY_TBL C,   rws_prajapadam_tbl P WHERE SUBSTR(P.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '" + rDistrict + "' AND SUBSTR(P.HAB_CODE,6,2) = M.MCODE AND C.DCODE = M.DCODE AND SUBSTR(P.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+rConstituency+"' GROUP BY m.mcode,m.mname";
		  //System.out.println("first query2 is "+query2);
		  stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		
		query2="SELECT DISTINCT PY.PCODE,PY.PNAME,SUM(Case When P.WORK_ID is not null  then 1 Else 0 End) as WORK_ID, SUM(Case When P.ESTIMATE_COST is not null then P.ESTIMATE_COST Else 0 End) as ESTIMATE_COST ,SUM(Case When P.EXP_UPTO_THE_PRE_MONTH is not null then P.EXP_UPTO_THE_PRE_MONTH Else 0 End) as EXP_UPTO_THE_PRE_MONTH ,SUM(Case When P.EXP_DUR_THE_MONTH is not null then P.EXP_DUR_THE_MONTH  Else 0 End) AS EXP_DUR_THE_MONTH ,SUM(Case When P.EXP_TO_BE_INCURRED is not null then P.EXP_TO_BE_INCURRED Else 0 End) AS EXP_TO_BE_INCURRED, SUM(Case When P.GROUND_DATE  is not null then 1  Else 0 End) AS GROUND_DATE , SUM(Case When P.COMPLETION_DATE  is not null then 1  Else 0 End) AS COMPLETION_DATE,count(*) FROM RWS_PANCHAYAT_TBL PY, RWS_CONSTITUENCY_TBL C,  rws_prajapadam_tbl P  WHERE SUBSTR(P.HAB_CODE,1,2) = PY.DCODE AND PY.DCODE = '"+rDistrict+"' AND  SUBSTR(P.HAB_CODE,6,2) = PY.MCODE and PY.MCODE ='"+rMandal+"' AND  SUBSTR(P.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+rConstituency+"' and C.DCODE = PY.DCODE AND SUBSTR(P.HAB_CODE,13,2) = PY.PCODE GROUP BY PY.PCODE,PY.PNAME";

             //System.out.println("first query2 is "+query2);
           stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && rPanchayat.equals("00") && rVillage.equals("-1"))
	{
		
		query2="SELECT DISTINCT PY.PCODE,PY.PNAME,SUM(Case When P.WORK_ID is not null  then 1 Else 0 End) as WORK_ID, SUM(Case When P.ESTIMATE_COST is not null then P.ESTIMATE_COST Else 0 End) as ESTIMATE_COST ,SUM(Case When P.EXP_UPTO_THE_PRE_MONTH is not null then P.EXP_UPTO_THE_PRE_MONTH Else 0 End) as EXP_UPTO_THE_PRE_MONTH ,SUM(Case When P.EXP_DUR_THE_MONTH is not null then P.EXP_DUR_THE_MONTH  Else 0 End) AS EXP_DUR_THE_MONTH ,SUM(Case When P.EXP_TO_BE_INCURRED is not null then P.EXP_TO_BE_INCURRED Else 0 End) AS EXP_TO_BE_INCURRED, SUM(Case When P.GROUND_DATE  is not null then 1  Else 0 End) AS GROUND_DATE , SUM(Case When P.COMPLETION_DATE  is not null then 1  Else 0 End) AS COMPLETION_DATE,count(*) FROM RWS_PANCHAYAT_TBL PY, RWS_CONSTITUENCY_TBL C,  rws_prajapadam_tbl P  WHERE SUBSTR(P.HAB_CODE,1,2) = PY.DCODE AND PY.DCODE = '"+rDistrict+"' AND  SUBSTR(P.HAB_CODE,6,2) = PY.MCODE and PY.MCODE ='"+rMandal+"' AND  SUBSTR(P.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+rConstituency+"' and C.DCODE = PY.DCODE AND SUBSTR(P.HAB_CODE,13,2) = PY.PCODE GROUP BY PY.PCODE,PY.PNAME";


		     //System.out.println("first query2 is "+query2);
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && rVillage.equals("-1"))
	{
		
        query2="SELECT DISTINCT V.Vcode,V.VNAME,SUM(Case When P.WORK_ID is not null  then 1 Else 0 End) as WORK_ID, SUM(Case When P.ESTIMATE_COST is not null then P.ESTIMATE_COST Else 0 End) as ESTIMATE_COST ,SUM(Case When P.EXP_UPTO_THE_PRE_MONTH is not null then P.EXP_UPTO_THE_PRE_MONTH Else 0 End) as EXP_UPTO_THE_PRE_MONTH ,SUM(Case When P.EXP_DUR_THE_MONTH is not null then P.EXP_DUR_THE_MONTH  Else 0 End) AS EXP_DUR_THE_MONTH ,SUM(Case When P.EXP_TO_BE_INCURRED is not null then P.EXP_TO_BE_INCURRED Else 0 End) AS EXP_TO_BE_INCURRED, SUM(Case When P.GROUND_DATE  is not null then 1  Else 0 End) AS GROUND_DATE , SUM(Case When P.COMPLETION_DATE  is not null then 1  Else 0 End) AS COMPLETION_DATE,count(*) from rws_village_tbl v,rws_prajapadam_tbl P,rws_constituency_tbl C where substr(P.hab_code,1,2)=v.dcode and v.dcode='"+rDistrict+"' and v.mcode=substr(P.hab_code,6,2) and v.MCODE ='"+rMandal+"' and v.pcode='"+rPanchayat+"' and substr(P.hab_code,13,2)=v.pcode and v.vcode=substr(P.hab_code,8,3) AND SUBSTR(P.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+rConstituency+"' and C.DCODE = v.DCODE GROUP BY v.vCODE,v.vNAME";

		//System.out.println("first query2 is "+query2);
		stmt1 =conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		

		 query2="SELECT DISTINCT V.Vcode,V.VNAME,SUM(Case When P.WORK_ID is not null  then 1 Else 0 End) as WORK_ID, SUM(Case When P.ESTIMATE_COST is not null then P.ESTIMATE_COST Else 0 End) as ESTIMATE_COST ,SUM(Case When P.EXP_UPTO_THE_PRE_MONTH is not null then P.EXP_UPTO_THE_PRE_MONTH Else 0 End) as EXP_UPTO_THE_PRE_MONTH ,SUM(Case When P.EXP_DUR_THE_MONTH is not null then P.EXP_DUR_THE_MONTH  Else 0 End) AS EXP_DUR_THE_MONTH ,SUM(Case When P.EXP_TO_BE_INCURRED is not null then P.EXP_TO_BE_INCURRED Else 0 End) AS EXP_TO_BE_INCURRED, SUM(Case When P.GROUND_DATE  is not null then 1  Else 0 End) AS GROUND_DATE , SUM(Case When P.COMPLETION_DATE  is not null then 1  Else 0 End) AS COMPLETION_DATE,count(*) from rws_village_tbl v,rws_prajapadam_tbl P,rws_constituency_tbl C where substr(P.hab_code,1,2)=v.dcode and v.dcode='"+rDistrict+"' and v.mcode=substr(P.hab_code,6,2) and v.MCODE ='"+rMandal+"' and v.pcode='"+rPanchayat+"' and substr(P.hab_code,13,2)=v.pcode and v.vcode=substr(P.hab_code,8,3) AND SUBSTR(P.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+rConstituency+"' and C.DCODE = v.DCODE GROUP BY v.vCODE,v.vNAME";


		//System.out.println("first query2 is "+query2);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && !rVillage.equals("00"))
	{
		

		query2="SELECT DISTINCT P.HAB_CODE,PRJ.PANCH_NAME,SUM(Case When P.WORK_ID is not null  then 1 Else 0 End) as WORK_ID, SUM(Case When P.ESTIMATE_COST is not null then P.ESTIMATE_COST Else 0 End) as ESTIMATE_COST ,SUM(Case When P.EXP_UPTO_THE_PRE_MONTH is not null then P.EXP_UPTO_THE_PRE_MONTH Else 0 End) as EXP_UPTO_THE_PRE_MONTH ,SUM(Case When P.EXP_DUR_THE_MONTH is not null then P.EXP_DUR_THE_MONTH  Else 0 End) AS EXP_DUR_THE_MONTH ,SUM(Case When P.EXP_TO_BE_INCURRED is not null then P.EXP_TO_BE_INCURRED Else 0 End) AS EXP_TO_BE_INCURRED, SUM(Case When P.GROUND_DATE  is not null then 1  Else 0 End) AS GROUND_DATE , SUM(Case When P.COMPLETION_DATE  is not null then 1  Else 0 End) AS COMPLETION_DATE,count(*) FROM RWS_CONSTITUENCY_TBL C, rws_prajapadam_tbl P, RWS_PANCHAYAT_RAJ_TBL PRJ WHERE P.HAB_CODE = PRJ.PANCH_CODE AND SUBSTR(P.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(P.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(P.HAB_CODE,13,2) = '"+rPanchayat+"' AND SUBSTR(P.HAB_CODE,8,3) = '"+rVillage+"' AND C.DCODE = SUBSTR(P.HAB_CODE,1,2) AND SUBSTR(P.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+rConstituency+"' GROUP BY P.HAB_CODE,PRJ.PANCH_NAME";



		//System.out.println("first query2 is "+query2);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
	}
	//rs = stmt.executeQuery(query);
	//System.out.println("query2 is "+query2);
	rs2 = stmt1.executeQuery(query2);
%>
<%@ include file="./rws_prajapatham_label.jsp"%>
<%	
	int NoOfWorksTotal=0,GroundedTotal=0,CompletedTotal=0;
	float EstimatedCostTotal=0,ExpUptoPrevMonthTotal=0,ExpDuringTheMonthTotal=0,ExpToBeIncurTotal=0,Total_Total=0;
	while(rs2.next())
	{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>


	<%	if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1"))
		{		
%>		
		<td class=rptValue><a href="./rws_prajapatham_drill.jsp?distvalue=<%=rs2.getString(1)%>&distname=
		<%=rs2.getString(2)%>&district=<%=rs2.getString(1)%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&constituency=<%=rConstituency%>"><%=rs2.getString(2)%></a></td>
<%
		}
		if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{			
%>		
		<td class=rptValue><a href="./rws_prajapatham_drill.jsp?district=<%=rDistrict%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&constituency=<%=rs2.getString(1)%>&convalue=<%=rs2.getString(1)%>&conname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
		
		
		
		
		if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{	
			
%>		
		<td class=rptValue><a href="./rws_prajapatham_drill.jsp?district=<%=rDistrict%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&constituency=<%=rs2.getString(1)%>&convalue=<%=rs2.getString(1)%>&conname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
		if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{	
			
%>		
		<td class=rptValue><a href="./rws_prajapatham_drill.jsp?district=<%=rDistrict%>&mandal=<%=rs2.getString(1)%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&constituency=<%=rConstituency%>&manvalue=<%=rs2.getString(1)%>&manname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
		
		
		
		
		
		if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && rMandal.equals("00") && rPanchayat.equals("-1") && rVillage.equals("-1"))
		{			
%>		
		<td class=rptValue><a href="./rws_prajapatham_drill.jsp?district=<%=rDistrict%>&mandal=<%=rs2.getString(1)%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&constituency=<%=rConstituency%>&manvalue=<%=rs2.getString(1)%>&manname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
		if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1") && rVillage.equals("-1"))
		{
			
%>		
		<td class=rptValue>
		<a href="./rws_prajapatham_drill.jsp?district=<%=rDistrict%>&mandal=<%=rMandal%>&panchayat=<%=rs2.getString(1)%>&village=<%=rVillage%>&constituency=<%=rConstituency%>&panvalue=<%=rs2.getString(1)%>&panname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
		
		
		
		
		
		if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1")  && rPanchayat.equals("00") && rVillage.equals("-1"))
		{	
			
%>		
		<td class=rptValue><a href="./rws_prajapatham_drill.jsp?district=<%=rDistrict%>&mandal=<%=rMandal%>&panchayat=<%=rs2.getString(1)%>&village=<%=rVillage %>&constituency=<%=rConstituency%>&panvalue=<%=rs2.getString(1)%>&panname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
		if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1")  && !rPanchayat.equals("00") && rVillage.equals("-1"))
		{			
%>		
		<td class=rptValue><a href="./rws_prajapatham_drill.jsp?district=<%=rDistrict%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rs2.getString(1)%>&constituency=<%=rConstituency%>&vilvalue=<%=rs2.getString(1)%>&vilname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
		
		
		
		
		
		if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1")  && !rPanchayat.equals("00") && rVillage.equals("00") && !rVillage.equals("-1"))
		{			
%>		
		<td class=rptValue><a href="./rws_prajapatham_drill.jsp?district=<%=rDistrict%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rs2.getString(1)%>&constituency=<%=rConstituency%>&vilvalue=<%=rs2.getString(1)%>&vilname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1")&& !rPanchayat.equals("00") && !rVillage.equals("00")  && !rVillage.equals("-1") )
		{
%>		
		<td class=rptValue><a href="./rws_prajapatham_rpt.jsp?district=<%=rDistrict%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&habitation=<%=rs2.getString(1)%>&constituency=<%=rConstituency%>&habvalue=<%=rs2.getString(1)%>&habname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%><%="-"%><%=rs2.getString(1)%></a></td>
<%
		}
		
%>	
		
			
		 
		  
		  <td class=rptValue><%=rs2.getInt(3)%></td>
			<% NoOfWorksTotal+=rs2.getInt(3); %>
			<td class=rptValue><%=rs2.getFloat(4)%></td>
			<% EstimatedCostTotal+=rs2.getFloat(4); %>
			<td class=rptValue><%=rs2.getFloat(5)%></td>
			<% ExpUptoPrevMonthTotal+=rs2.getFloat(5); %>
			<td class=rptValue><%=rs2.getFloat(6)%></td>
			<% ExpDuringTheMonthTotal+=rs2.getFloat(6); %>
			<td class=rptValue><%=rs2.getFloat(5)+rs2.getFloat(6)%></td>
			<% Total_Total+=rs2.getFloat(5)+rs2.getFloat(6); %>
			<td class=rptValue><%=rs2.getFloat(7)%></td>
			<% ExpToBeIncurTotal+=rs2.getFloat(7); %>
			<td class=rptValue><%=rs2.getInt(8)%></td>
			<% GroundedTotal+=rs2.getInt(8); %>
			<td class=rptValue><%=rs2.getInt(9)%></td>
			<% CompletedTotal+=rs2.getInt(9); %>
			
			</tr>
<%
			}
			rs2.close();
			

		
int grandtotal=0;

//grandtotal=EXIST_CPWSTotal+EXIST_PWSTotal+EXIST_DIRECT_PUMPINGTotal+EXIST_BOREWELLSTotal+EXIST_OTHERSTotal;

%>
</tr>

    
	<tr>
		
		<td class=btext>&nbsp;</td>
		<td class=btext>&nbsp;</td>
		<td class=btext><%=NoOfWorksTotal%></td>
		<td class=btext><%=EstimatedCostTotal%></td>
		<td class=btext><%=ExpUptoPrevMonthTotal%></td>
		<td class=btext><%=ExpDuringTheMonthTotal%></td>
		<td class=btext><%=Total_Total%></td>
		<td class=btext><%=ExpToBeIncurTotal%></td>
		
		
		<td class=btext><%=GroundedTotal%></td>
		<td class=btext><%=CompletedTotal%></td>
		
	</tr>
</table>
<%
		
}
	
catch(Exception e)
{
	//System.out.println("Exception in drill is "+e);
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
