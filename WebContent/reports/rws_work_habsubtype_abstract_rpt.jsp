<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
    String currentYear= dateFormat.format(currentDate).substring(0,4);
    String currentMonth = dateFormat.format(currentDate).substring(5,7);
    DecimalFormat ndf = new DecimalFormat("####.00");
    //stem.out.println("The Current Month::"+currentMonth);
    int nextYear = Integer.parseInt(currentYear);
    String financialyr="";
    String fixYear ="",fixNextYear="";
	String planCode = "1";
	////////System.out.println("planCode:"+planCode);
	String planQry = "",planQry1 = "";
	String planName = "PLAN & NON PLAN";
	if(planCode.equals("1"))
	{
		planQry = " plan_code = '1'";
		planQry1 = " and plan_code = '1'";
		planName = " PLAN ";
	}
	else if(planCode.equals("2"))
	{
		planQry = " plan_code = '2'";
		planQry1 = " and plan_code = '2'";
		planName = " NON PLAN ";
	}
	session.setAttribute("planCode",planCode);
	session.setAttribute("planName",planName);
	financialyr = "2011-12";
    session.setAttribute("financialyr",financialyr);
    ////////System.out.println("finyear"+financialyr+"---in drill ----"+request.getParameter("drill"));
   // ////////System.out.println("finyear"+financialyr);
   if(financialyr!=null && financialyr.equals("2011-12")){    
    fixYear = "01-Apr-2011";
	fixNextYear = "01-Apr-2012";
    }
	else if(financialyr!=null && financialyr.equals("2010-11")){    
    fixYear = "01-Apr-2010";
	fixNextYear = "01-Apr-2011";
    }
	else if(financialyr!=null && financialyr.equals("2010-11")){    
    fixYear = "01-Apr-2009";
	fixNextYear = "01-Apr-2010";
    }
    else {fixYear = "01-Apr-2008";
	fixNextYear = "01-Apr-2009";}
    nextYear++;
    String nextYear1 = ""+nextYear;
    String currentYearPeriod = currentYear + "-" + nextYear1;
    String currentYearPeriod1=currentYear + "-" + nextYear1.substring(2,4);
    java.util.Date d1 = dateFormat.parse(currentYear+"-03-31");
    String financialYearFrom="";
    String financialYearTo="";
    String drill = null;
    if(drill==null)drill="0";
    session.setAttribute("drill",drill);
	 ////////System.out.println("drill"+drill);
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
    //nic.watersoft.commons.Debug.println("financialYearTo:"+financialYearTo);
        	//Debug.println("***********************REPORT BEGINING***********************");
	String rDistrict="", rConstituency="", rMandal="", rPanchayat="", rVillage="", rHabitation="", distvalue="", distname="", conname="", convalue="", manvalue="", manname="", panvalue="", panname="", vilvalue="", vilname ="",excelnav = "";

	String query3="",query4="",query5="";
	String districtName="",mandalName="",panchayatName="",villageName="",constituencyName="",habitationName="",programCode="",workCategory="",workCategoryCode="",programName = "",subprogramCode="",subprogramName="",divisionCode=null,divname=null;
	if(request.getParameter("district")!=null)
	{
	rDistrict = request.getParameter("district");
	session.setAttribute("rDistrict",rDistrict);
	}
	if(request.getParameter("programCode")!=null)
	{
	programCode = request.getParameter("programCode");
	session.setAttribute("programCode",programCode);
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
	if(request.getParameter("subprogramCode")!=null)
	{
	subprogramCode = request.getParameter("subprogramCode");
	session.setAttribute("subprogramCode",subprogramCode);
	}
	if(request.getParameter("programName")!=null)
	{
	programName = request.getParameter("programName");
	session.setAttribute("programName",programName);
	}
	if(request.getParameter("subprogramName")!=null)
	{
	subprogramName = request.getParameter("subprogramName");
	session.setAttribute("subprogramName",subprogramName);
	}
	if(request.getParameter("workCategory")!=null)
	{
	workCategory = request.getParameter("workCategory");
	session.setAttribute("workCategory",workCategory);
	}
	if(request.getParameter("workCategoryCode")!=null)
	{
	workCategoryCode = request.getParameter("workCategoryCode");
	session.setAttribute("workCategoryCode",workCategoryCode);
	}
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

	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	ResultSet rs2 = null,rs21 = null,rs22 = null,rs44=null,rs55=null,rs51=null,rs52=null,prevrs=null,san=null;
	Statement stmt1 = null,stmt21 = null,stmt22 = null,prev=null,sss=null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
	boolean flag=true,flag1=false,flagp=true,flagn=true,flagd=true;
	//fields for total
	int gnspills=0,gspills=0,gtspills=0,ghabsan=0,ghabsan1=0,gtsno=0,gcomp=0,gcomm=0,ghabcov=0,gten=0,gagree=0,ggrnd=0;
	float gnspillamt=0,gspillamt=0,gtspamt=0,grevamt=0,gepreyr=0,geprev=0,gedur=0,gcum=0,getot=0;
	int gnspills1=0,gspills1=0,gtspills1=0,tnspillw=0,spillw=0,nspillw=0;
	float gnspillamt1=0,gspillamt1=0,gtspamt1=0,grevamt1=0;
	float estamtn=0,estamts=0,totestamt=0,estamtn1=0,estamts1=0,totestamt1=0,totexpend=0,totexpend1=0;

	//fields for total(Projects)	
	int gnspillsp=0,gspillsp=0,gtspillsp=0,ghabsanp=0,gtsnop=0,gcompp=0,gcommp=0,ghabcovp=0,gtenp=0,gagreep=0,ggrndp=0;
	int gnspillsp1=0,gspillsp1=0,gtspillsp1=0,ghabsanp1=0,gtsnop1=0,gcompp1=0,gcommp1=0,ghabcovp1=0,gtenp1=0,gagreep1=0,ggrndp1=0;
	float gnspillamtp=0,gspillamtp=0,gtspamtp=0,grevamtp=0,gepreyrp=0,geprevp=0,gedurp=0,gcump=0,getotp=0;
	float gnspillamtp1=0,gspillamtp1=0,gtspamtp1=0,grevamtp1=0,gepreyrp1=0,geprevp1=0,gedurp1=0,gcump1=0,getotp1=0;
		//fields for total(Normal)
	int gnspillsn=0,gspillsn=0,gtspillsn=0,ghabsann=0,gtsnon=0,gcompn=0,gcommn=0,ghabcovn=0,gtenn=0,gagreen=0,ggrndn=0;
	float gnspillamtn=0,gspillamtn=0,gtspamtn=0,grevamtn=0,gepreyrn=0,geprevn=0,gedurn=0,gcumn=0,getotn=0;
	int gnspillsn1=0,gspillsn1=0,gtspillsn1=0,ghabsann1=0,gtsnon1=0,gcompn1=0,gcommn1=0,ghabcovn1=0,gtenn1=0,gagreen1=0,ggrndn1=0;
	float gnspillamtn1=0,gspillamtn1=0,gtspamtn1=0,grevamtn1=0,gepreyrn1=0,geprevn1=0,gedurn1=0,gcumn1=0,getotn1=0;
			//fields for total(District Level)
		int gnspillsd=0,gspillsd=0,gtspillsd=0,ghabsand=0,gtsnod=0,gcompd=0,gcommd=0,ghabcovd=0,gtend=0,gagreed=0,ggrndd=0;
float gnspillamtd=0,gspillamtd=0,gtspamtd=0,grevamtd=0,gepreyrd=0,geprevd=0,gedurd=0,gcumd=0,getotd=0;
		int gnspillsdr=0,gspillsdr=0,gtspillsdr=0,ghabsandr=0,gtsnodr=0,gcompdr=0,gcommdr=0,ghabcovdr=0,gtendr=0,gagreedr=0,ggrnddr=0;
float gnspillamtdr=0,gspillamtdr=0,gtspamtdr=0,grevamtdr=0,gepreyrdr=0,geprevdr=0,gedurdr=0,gcumdr=0,getotdr=0;
		int gnspillsd1=0,gspillsd1=0,gtspillsd1=0,ghabsand1=0,gtsnod1=0,gcompd1=0,gcommd1=0,ghabcovd1=0,gtend1=0,gagreed1=0,ggrndd1=0;
float gnspillamtd1=0,gspillamtd1=0,gtspamtd1=0,grevamtd1=0,gepreyrd1=0,geprevd1=0,gedurd1=0,gcumd1=0,getotd1=0;
		int gnspillsdr1=0,gspillsdr1=0,gtspillsdr1=0,ghabsandr1=0,gtsnodr1=0,gcompdr1=0,gcommdr1=0,ghabcovdr1=0,gtendr1=0,gagreedr1=0,ggrnddr1=0;
float gnspillamtdr1=0,gspillamtdr1=0,gtspamtdr1=0,grevamtdr1=0,gepreyrdr1=0,geprevdr1=0,gedurdr1=0,gcumdr1=0,getotdr1=0;
	
int gnspillsdrsub=0,gspillsdrsub=0,gtspillsdrsub=0,ghabsandrsub=0,gtsnodrsub=0,gcompdrsub=0,gcommdrsub=0,ghabcovdrsub=0,gtendrsub=0,gagreedrsub=0,ggrnddrsub=0,tothabsanctioned=0;
float gnspillamtdrsub=0,gspillamtdrsub=0,gtspamtdrsub=0,grevamtdrsub=0,gepreyrdrsub=0,geprevdrsub=0,gedurdrsub=0,gcumdrsub=0,getotdrsub=0;
int gnspillsdrsub1=0,gspillsdrsub1=0,gtspillsdrsub1=0,ghabsandrsub1=0,gtsnodrsub1=0,gcompdrsub1=0,gcommdrsub1=0,ghabcovdrsub1=0,gtendrsub1=0,gagreedrsub1=0,ggrnddrsub1=0;
float gnspillamtdrsub1=0,gspillamtdrsub1=0,gtspamtdrsub1=0,grevamtdrsub1=0,gepreyrdrsub1=0,geprevdrsub1=0,gedurdrsub1=0,gcumdrsub1=0,getotdrsub1=0;
	Statement stmt4=null;
try
{
	String per = null;
	per = request.getParameter("per");
	if(per==null)per="ALL";
	String perQry = "";
	if(per!=null && !per.equals("ALL"))perQry = " and HAB_SUB_TYPE_40PC_CALC='"+per+"'";
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
<table border = 0 cellspacing = 0 cellpadding = 0 width=30% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr>
		<td class="textborder" align="center" colspan="8">Select Habitation Sub Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="per" onchange="this.form.submit()">
			<%if(per!=null && per.equals("ALL")){%>
				<option value="ALL" selected>ALL</option>
			<%}
			else
			{
			%>
				<option value="ALL">ALL</option>
			<%
			}%>

			<%if(per!=null && per.equals("SC")){%>
				<option value="SC" selected>SC</option>
			<%}
			else
			{
			%>
				<option value="SC">SC</option>
			<%
			}%>
			<%if(per!=null && per.equals("ST")){%>
				<option value="ST" selected>ST</option>
			<%}
			else
			{
			%>
				<option value="ST">ST</option>
			<%
			}%>
			<%if(per!=null && per.equals("PLAIN")){%>
				<option value="PLAIN" selected>PLAIN</option>
			<%}
			else
			{
			%>
				<option value="PLAIN">PLAIN</option>
			<%
			}%>
		</select>
		</font></td>
	</tr>
</table>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td>
				<td class="bwborder"><!-- <a href="./rws_work_habsubtype_abstract_excel.jsp?per=<%=per%>" target=_new">Excel</a> --></td>			
			</tr>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
	<% //if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1"))
stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
Statement stmtv1= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
Statement stmtv2= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

stmt21 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	   	stmt22 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		Statement pss=conn.createStatement();
	if(drill.equals("null") || drill.equals("0"))
	{
	excelnav = "0";
	////////System.out.println("First Drill");
	   try
	   {
	   %>

	   	<%@ include file="./rws_work_habsubtype_abstract_label.jsp"%>
	   	<%String qry1=null;
		
		qry1="SELECT DISTINCT D.DCODE AS A_CODE,D.DNAME AS A_NAME FROM RWS_WORK_ADMN_TBL A,RWS_ADMN_HAB_LNK_TBL AL,RWS_DISTRICT_TBL D WHERE A.WORK_ID=AL.WORK_ID AND D.DCODE=SUBSTR (AL.HAB_CODE,1,2) and D.DCODE=SUBSTR(A.WORK_ID,5,2) GROUP BY D.DCODE,D.DNAME order by dname";
		////////System.out.println("Test Qry is::"+qry1);
		
		rs1=stmt1.executeQuery(qry1);
		String view1="Create or Replace view spillworks"+session.getId().substring(1,10)+" as SELECT work_id,office_code,no_of_habs FROM RWS_WORK_ADMN_TBL W where  "+planQry+" and w.ADMIN_DATE < '"+fixYear+"' and w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '"+fixYear+"'))";
		view1 = "Create or Replace view spillworks"+session.getId().substring(1,10)+" as select distinct a.work_id,office_code,no_of_habs from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where a.work_id=b.work_id(+) and b.hab_code=hd.hab_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr (h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and a.work_id in (select work_id from rws_work_admn_tbl w where w.ADMIN_DATE < '"+fixYear+"' and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '"+fixYear+"') ) and a.plan_code='1' "+perQry+" and work_cancel_dt is null";
		////System.out.println("view1:"+view1);
		String view2="Create or Replace view newworks"+session.getId().substring(1,10)+" as SELECT work_id,office_code,no_of_habs FROM RWS_WORK_ADMN_TBL W where "+planQry+" and w.ADMIN_DATE >= '"+fixYear+"'";
		view2 = "Create or Replace view newworks"+session.getId().substring(1,10)+" as  select distinct a.work_id,office_code,no_of_habs from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where a.work_id=b.work_id(+) and b.hab_code=hd.hab_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr (h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and a.work_id in (select work_id from rws_work_admn_tbl w where w.ADMIN_DATE >= '"+fixYear+"') and a.plan_code='1' "+perQry+" and work_cancel_dt is null";
	   ////System.out.println("view1"+view1);
       ////System.out.println("view2"+view2);		
 	   	stmtv1.executeUpdate(view1);
 	   	stmtv2.executeUpdate(view2);   	
	   	
	   	
		while(rs1.next())
		{
		flag=false;flagn=false;flagd=false;
		%>
		<tr onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
        <td class=rptValue><%=++slno%></td>
		<td class=rptValue title=Click><b><%=rs1.getString(2)%></td>
		
	   	<% 
	   	String qry2=null;Statement stmt2=null;
						float spillamt=0,spillamt1=0,nspillamt=0,nspillamt1=0,tspamt=0,tspamt1=0;
						int tspills=0,spills=0,nspills=0;
						int tspills1=0,spills1=0,nspills1=0;
						float tspillamt=0,tspillamt1=0;
						float spillamtp=0,nspillamtp=0,tspamtp=0;
						float spillamtp1=0,nspillamtp1=0,tspamtp1=0;
						int tspillsp=0,tspillsp1=0,spillsp=0,nspillsp=0;
	
						float spillamtn=0,nspillamtn=0,tspamtn=0,nspillamtn1=0,spillamtn1=0,tspamtn1=0;
						int tspillsn=0,spillsn=0,nspillsn=0,tspillsn1=0;	

						float spillamtd=0,nspillamtd=0,tspamtd=0,tspamtd1=0,spillamtd1=0;
						int tspillsd=0,spillsd=0,nspillsd=0;
		    String qry21="select (select count(*) from spillworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"')a,(select sum(no_of_habs) from spillworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"')b from dual";	
			String qry22 = "select (select count(*) from newworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"')a,(select sum(no_of_habs) from newworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"')b from dual";
			//String qry22 ="select count(*) from newworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"'";
//	   ////System.out.println("query1"+qry21);
	   //////System.out.println("query2"+qry22);
	   	
 	   	rs21=stmt21.executeQuery(qry21);
 	   	rs22=stmt22.executeQuery(qry22);
	   	while(rs21.next()&& rs22.next())
					{
						////////System.out.println("in while");
 				  	    gspillsn=gspillsn+rs21.getInt(1);
						gnspillsn=gnspillsn+rs22.getInt(1);
 						gspillamtn=gspillamtn+spillamt;
					    gnspillamtn=gnspillamtn+nspillamt;
 						gtspamtn=gtspamtn+tspillamt;
						tothabsanctioned+=rs21.getInt(2)+rs22.getInt(2);
 					 %>
 					       <td class=rptValue align=right><%=rs21.getInt(1)%></td>
							<td class=rptValue align=right><%=rs22.getInt(1)%></td>
							<td class=rptValue align=right><%=rs21.getInt(1)+rs22.getInt(1)%></td>
							<td class=rptValue align=right><%=rs21.getInt(2)+rs22.getInt(2)%></td>

					<%
	   	}
	   	
			String qry44=null;Statement stmt44=null;
			String qry45=null;Statement stmt45=null;
			Statement stmtqqqq=null,stmtqqqq1=null;
			ResultSet rsqqqq=null,rsqqqq1=null;
			int spillSubtypePop = 0,spillPop=0,newSubtypePop=0,newPop=0;
			stmt44 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			stmt45 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			stmtqqqq = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				stmtqqqq1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				stmt45 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            try
            {
            qry44 = "select sum(a.sanction_amount) from rws_work_admn_tbl a,spillworks"+session.getId().substring(1,10)+" b where a.work_id=b.work_id and substr(a.work_id,5,2)='"+rs1.getString(1)+"'";
			//////System.out.println("qry44aaaaaaaaa"+qry44);
            
            rs44=stmt44.executeQuery(qry44);
  			qry45 = "select sum(a.sanction_amount) from rws_work_admn_tbl a,newworks"+session.getId().substring(1,10)+" b where a.work_id=b.work_id and substr(a.work_id,5,2)='"+rs1.getString(1)+"'";
            //////System.out.println("qry45"+qry45);
			
			rs55=stmt45.executeQuery(qry45);
			if(!per.equals("ALL"))
			{

				String qqqq = "select sum(case when HAB_SUB_TYPE_40PC_CALC='"+per+"' then census_plain_popu+census_sc_popu+census_st_popu else 0 end) as scpop,sum(census_plain_popu+census_sc_popu+census_st_popu) from spillworks"+session.getId().substring(1,10)+" a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where a.work_id=b.work_id and b.hab_code=c.hab_code and substr(a.work_id,5,2)='"+rs1.getString(1)+"'";
				String qqqq1 = "select sum(case when HAB_SUB_TYPE_40PC_CALC='"+per+"' then census_plain_popu+census_sc_popu+census_st_popu else 0 end) as scpop,sum(census_plain_popu+census_sc_popu+census_st_popu) from newworks"+session.getId().substring(1,10)+" a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where a.work_id=b.work_id and b.hab_code=c.hab_code and substr(a.work_id,5,2)='"+rs1.getString(1)+"'";
				
				rsqqqq = stmtqqqq.executeQuery(qqqq);
				rsqqqq1 = stmtqqqq1.executeQuery(qqqq1);
				spillSubtypePop = 0;spillPop=0;newSubtypePop=0;newPop=0;
				if(rsqqqq.next())
				{
					spillSubtypePop = rsqqqq.getInt(1);
					spillPop = rsqqqq.getInt(2);
				}
				if(rsqqqq1.next())
				{
					newSubtypePop = rsqqqq.getInt(1);
					newPop = rsqqqq.getInt(2);
				}
				
				rs55=stmt45.executeQuery(qry45);
				while(rs44.next()&& rs55.next())
				{
				estamtn=rs44.getFloat(1);
				estamtn = (spillSubtypePop*estamtn)/spillPop;
				estamtn1=estamtn1+estamtn;
				estamts=rs55.getFloat(1);
				estamts = (newSubtypePop*estamts)/newPop;
				estamts1=estamts1+estamts;
				totestamt=estamtn+estamts;
				totestamt1=totestamt1+totestamt;
				%>
				 <td class=rptValue align=right><%if(estamtn==0)out.println("<center>-</center>");else out.println(Math.round(estamtn*100)/100f);%></td>
				  <td class=rptValue align=right><%if(estamts==0)out.println("<center>-</center>");else out.println(Math.round(estamts*100)/100f);%></td>
				   <td class=rptValue align=right><%if(totestamt==0)out.println("<center>-</center>");else out.println(Math.round(totestamt*100)/100f);%></td>
				<%
				}
			}
			else
			{
				while(rs44.next()&& rs55.next())
				{
				estamtn=rs44.getFloat(1);
				estamtn1=estamtn1+rs44.getFloat(1);
				estamts=rs55.getFloat(1);
				estamts1=estamts1+rs55.getFloat(1);
				totestamt=rs44.getFloat(1)+rs55.getFloat(1);
				totestamt1=totestamt1+totestamt;
				%>
				 <td class=rptValue align=right><%if(estamtn==0)out.println("<center>-</center>");else out.println(Math.round(rs44.getFloat(1)*100)/100f);%></td>
				  <td class=rptValue align=right><%if(estamts==0)out.println("<center>-</center>");else out.println(Math.round(rs55.getFloat(1)*100)/100f);%></td>
				   <td class=rptValue align=right><%if(totestamt==0)out.println("<center>-</center>");else out.println(Math.round(totestamt*100)/100f);%></td>
				<%
				
				}
			}
		}catch(Exception e1)
       {
       e1.printStackTrace();
       }
       finally
       {
			if(rs44!=null){rs44.close();}
			if(stmt44!=null){stmt44.close();}
			if(rsqqqq!=null){rsqqqq.close();}
			if(stmtqqqq!=null){stmtqqqq.close();}
			if(rsqqqq1!=null){rsqqqq1.close();}
			if(stmtqqqq1!=null){stmtqqqq1.close();}
       }
       			
				
            WorksData1 worksData = new WorksData1();	
            
         // ArrayList progs=worksData.getAdminPrograms(reque,fb.getWorkId());
           float ddd = 0;
          ArrayList works=new ArrayList();
          ArrayList prog=null;
          String work="";
		    double expupto1 = 0,expdur1 = 0,preyearexp1 = 0;
            String qry52=null;Statement stmt52=null;
			prev = conn.createStatement();
            try
            {
            // in drill null
			if(prev!=null){prev.close();prev=null;}
		
			String aa = "select sum(expenditure_upto_the_pre_year) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id in (select work_id from spillworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"' union select work_id from newworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"')";
			/*if(prevrs!=null){
				//System.out.println("in iiiiiiiii");
				prevrs.close();//prevrs=null;}
		    	}*/
			ResultSet pssr= pss.executeQuery(aa);
			//if(prevrs.next()){preyearexp1=prevrs.getFloat(1);}
			if(pssr.next()){preyearexp1=pssr.getFloat(1);}
		String bb = "select sum(case when year<>'2010-11' then total else 0 end),sum(case when year='2010-11' then total else 0 end) from rws_exp_view where work_id in (select work_id from spillworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"' union select work_id from newworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"')";

			////////System.out.println("bb:"+bb);
			if(sss!=null){sss.close();sss=null;}
			sss = conn.createStatement(); 
			if(san!=null){san.close();prev=null;}
			san = sss.executeQuery(bb);
			if(san.next()){preyearexp1+=san.getFloat(1);expdur1=san.getFloat(2);}
			if(!per.equals("ALL"))
			{
				// (spillSubtypePop*estamtn)/spillPop;
				//////System.out.println("1:"+spillSubtypePop+newSubtypePop);

				preyearexp1 = ((spillSubtypePop+newSubtypePop)*preyearexp1)/(spillPop+newPop);
				expdur1 = ((spillSubtypePop+newSubtypePop)*expdur1)/(spillPop+newPop);
				//expdur1 = (spillSubtypePop*estamtn)*expdur1;
			}
			gepreyrdrsub1+=workData.round(preyearexp1,2);
			geprevdrsub1+=workData.round(expdur1,2);
            //qry52="SELECT work_id,office_code FROM RWS_WORK_ADMN_TBL W where w.plan_code ='"+planCode+"' and w.category_code='2' and w.ADMIN_DATE < '"+fixYear+"' and SUBSTR (w.work_id,5,2)='"+rDistrict+"' and w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION >= '"+fixYear+"' or DATE_OF_COMPLETION is null)) union SELECT work_id,office_code FROM RWS_WORK_ADMN_TBL W where w.plan_code ='"+planCode+"' and w.category_code='2' and w.ADMIN_DATE >= '"+fixYear+"' and SUBSTR (w.work_id,5,2)='"+rDistrict+"' ";
              //qry52="select work_id from spillworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"' union select work_id from newworks"+session.getId().substring(1,10)+" where substr (work_id,5,2) ='"+rs1.getString(1)+"' ";
             //stmt52 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            // ////////System.out.println("qry52"+qry52);
           //rs52=stmt52.executeQuery(qry52);
            /*while(rs52.next())
            {
             work=rs52.getString(1);
		    }  */
            ////////System.out.println("works size"+works.size());
             //gepreyrdr=gepreyrdr+ddd;
            }
            catch(Exception e)
            {
            e.printStackTrace();
            }
            finally
            {
				if(prevrs!=null){prevrs.close();prevrs=null;}
				if(prev!=null){prev.close();prev=null;}
				if(san!=null){san.close();prev=null;}
				if(sss!=null){sss.close();sss=null;}
            }
       			%>
					<td class=rptValue align=right><%=ndf.format(workData.round(preyearexp1,2))%></td>
					<td class=rptValue align=right><%=ndf.format(workData.round(expdur1,2))%></td>
					<td class=rptValue align=right><%=ndf.format((workData.round((preyearexp1+expdur1),2)))%></td>
				<%
			 String qry6=null;Statement stmt6=null; 
				stmt6 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				 
            try
            {
            qry6="SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN 1 ELSE 0 END) FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID and w.work_id in (select work_id from spillworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"' union select work_id from newworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"')";
            
            rs6=stmt6.executeQuery(qry6);
            while(rs6.next())
            {
           gtsnon=gtsnon+rs6.getInt(1);
			%>
			 <td class=rptValue align=right><%=rs6.getInt(1)%>
			<%
			
			}}catch(Exception e1)
       {
       e1.printStackTrace();
       }
       finally
       {
       if(rs6!=null){rs6.close();}
       if(stmt6!=null){stmt6.close();}
       }
			
				
				
		String qry8=null;Statement stmt8=null;
		 stmt8= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            try
            {
            qry8="SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN 1 ELSE 0 END) FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=G.WORK_ID and w.work_id in (select work_id from spillworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"' union select work_id from newworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"')";
			////System.out.println("qry8:"+qry8);
          
             rs8=stmt8.executeQuery(qry8);
            while(rs8.next())
            {
			ggrndn=ggrndn+rs8.getInt(1);
			%>
			<td class=rptValue align=right><%=rs8.getInt(1)%></td>
			
			<%
			}
			}catch(Exception e1)
       {
       e1.printStackTrace();
       }
       finally
       {
       if(rs8!=null){rs8.close();}
       if(stmt8!=null){stmt8.close();}
       }	
         String qry9=null;
		 Statement stmt9= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            try
            {
            //qry9="SELECT distinct SUM(CASE WHEN WC.work_id IS NOT NULL THEN 1 ELSE 0 END) FROM RWS_WORK_COMPLETION_TBL WC,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=WC.WORK_ID and wc.work_id in (select work_id from spillworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"' union select work_id from newworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"')";
			qry9 = "SELECT count(*) FROM rws_work_completion_tbl G,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=G.WORK_ID and w.work_id in (select work_id from spillworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"' union select work_id from newworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"') and date_of_completion is not null";
			////System.out.println("qry9:"+qry9);
           
             rs9=stmt9.executeQuery(qry9);
            if(rs9.next())
            {
               gcompn=gcompn+rs9.getInt(1);
			   gcompn1=gcompn1+rs9.getInt(1);
               %>
                 <!-- <td class=rptValue align=right><%=rs9.getInt(1)%></td> -->
                 <td class=rptValue align=right><%=rs9.getInt(1)%></td>

               <%
               }
			   else
				{
			%>
                 <td class=rptValue align=right>0</td>
               <%
				}
               }catch(Exception e1)
       {
				   ////System.out.println("error in qry9:"+e1.getMessage());
       e1.printStackTrace();
       }
       finally
       {
       if(rs9!=null){rs9.close();}
       if(stmt9!=null){stmt9.close();}
       }
       String qry4=null;
			
			try
			{
			//qry4="Select count(e.hab_code) from RWS_admn_HAB_LNK_TBL e where e.work_id in (select work_id from spillworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"' union select work_id from newworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"')";
			////////System.out.println(qry4);
			/*qry4 = "select (select sum(w.no_of_habs) from rws_work_completion_tbl wc, rws_work_admn_tbl w where w.work_id=wc.work_id and SUBSTR (w.work_id,5,2)='"+rs1.getString(1)+"' and date_of_completion<'"+fixYear+"' "+planQry1+" )as a, (select sum(w.no_of_habs) from rws_work_completion_tbl wc, rws_work_admn_tbl w where w.work_id=wc.work_id and SUBSTR (w.work_id,5,2)='"+rs1.getString(1)+"'  and date_of_completion>='"+fixYear+"' and date_of_completion<'"+fixNextYear+"' "+planQry1+")as b from dual";
			
			stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs4=stmt4.executeQuery(qry4);
            while(rs4.next())
	            {
	            ghabsann=ghabsann+rs4.getInt(1);
				ghabsann1=ghabsann1+rs4.getInt(2);*/
		}catch(Exception e1)
       {
       e1.printStackTrace();
       }
       finally
       {
       if(rs4!=null){rs4.close();}
       if(stmt4!=null){stmt4.close();}
       }
            
        String qry10=null; Statement stmt10=null;
		stmt10= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            try
            {
           // qry10="Select count(e.hab_code) from RWS_WORK_COMP_HAB_LNK_TBL e where e.work_id in (select work_id from spillworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"' union select work_id from newworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"')";
            ////////System.out.println("qry10:"+qry10);
            qry10="SELECT count(*) FROM rws_work_completion_tbl G,RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL gg WHERE W.WORK_ID=G.WORK_ID and g.WORK_ID=gG.WORK_ID and W.WORK_ID=Gg.WORK_ID and w.work_id in (select work_id from spillworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"' union select work_id from newworks"+session.getId().substring(1,10)+" where substr(work_id,5,2)='"+rs1.getString(1)+"') and date_of_completion is not null";
			////System.out.println("qry10:"+qry10);
			
             rs10=stmt10.executeQuery(qry10);
            while(rs10.next())
            {
			ghabcovn=ghabcovn+rs10.getInt(1);
			ghabcovn1=ghabcovn1+rs10.getInt(1);
			%>
			 <!-- <td class=rptValue align=right><%=rs10.getInt(1)%></td> -->
 			 <td class=rptValue align=right><%=rs10.getInt(1)%></td>
			<%
			}}catch(Exception e1)
       {
				 ////System.out.println("error in qry10:"+e1.getMessage());
       e1.printStackTrace();
       }
       finally
       {
       if(rs10!=null){rs10.close();}
       if(stmt10!=null){stmt10.close();}
       }
       }%>
		<tr>
<td colspan=2 class="btext">GrandTotal</td>
<td class="btext" align="right"><%=gspillsn%></td>
<td class="btext" align="right"><%=gnspillsn %></td>
<td class="btext" align="right"><%=gspillsn+gnspillsn%></td>
<td class="btext" align="right"><%=tothabsanctioned%></td>
<td class="btext" align="right"><%=ndf.format(Math.round(estamtn1*100)/100f)%></td>
<td class="btext" align="right"><%=ndf.format(Math.round(estamts1*100)/100f)%></td>
<td class="btext" align="right"><%=ndf.format(Math.round(totestamt1*100)/100f)%></td>
<td class="btext" align="right"><%=ndf.format(workData.round(gepreyrdrsub1,2))%></td>
<td class="btext" align="right"><%=ndf.format(workData.round(geprevdrsub1,2))%></td>
<td class="btext" align="right"><%=ndf.format(workData.round(gepreyrdrsub1,2)+workData.round(geprevdrsub1,2))%></td>
<td class="btext" align="right"><%=gtsnon%></td>
<td class="btext" align="right"><%=ggrndn%></td>
<!-- <td class="btext" align="right"><%=gcompn%></td> -->
<td class="btext" align="right"><%=gcompn1%></td>
<!-- <td class="btext" align="right"><%=ghabsann%></td> -->
<!-- <td class="btext" align="right"><%=ghabsann1%></td> -->
<!-- <td class="btext" align="right"><%=ghabcovn%></td> -->
<td class="btext" align="right"><%=ghabcovn1%></td>
</tr>
       <%
       Statement stmtdv1=null,stmtdv2=null;
stmtdv1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		stmtdv2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			try{	
		
		String dropqry1="drop VIEW spillworks"+session.getId().substring(1,10)+"";
		String dropqry2="drop VIEW newworks"+session.getId().substring(1,10)+"";
		stmtdv1.executeUpdate(dropqry1);
		stmtdv2.executeUpdate(dropqry2);
		}
		/*catch(SQLException se)
		{
			//System.out.println("Exception in dropView "+se.getMessage());
		}
		catch(Exception e)
		{
			//System.out.println("Exception in dropView "+e.getMessage());
		}*/
		finally
		{
		if(stmtdv2!=null){stmtdv2.close();}
        if(stmtdv1!=null){stmtdv1.close();}
		}
		}catch(Exception e1)
       {
       e1.printStackTrace();
       }
       finally
       {
        if(rs1!=null){rs1.close();}
        if(stmt1!=null){stmt1.close();}
       }     
       
       }
       
    } catch(Exception e)
{
	//Debug.println("Exception in drill is "+e);
	e.printStackTrace();
}
finally
{

	if(conn!=null)
	conn.close();
}
session.setAttribute("excelnav",excelnav);
%>
       </table>
     
<p align=left><font color=brown face=verdana size=2><b>

</b></font>
      </p>
</form>
<%@ include file = "footer.jsp" %>
</body>
</html>
      


	