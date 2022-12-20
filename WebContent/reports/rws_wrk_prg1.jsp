<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<!--<%@ page import="nic.watersoft.masters.RwsMasterData" %>-->
<%@ include file = "conn.jsp" %>
<%
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
    String currentYear= dateFormat.format(currentDate).substring(0,4);
    String currentMonth = dateFormat.format(currentDate).substring(5,7);
    //stem.out.println("The Current Month::"+currentMonth);
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

        	//Debug.println("***********************REPORT BEGINING***********************");
	String rDistrict="", rConstituency="", rMandal="", rPanchayat="", rVillage="", rHabitation="", distvalue="", distname="", conname="", convalue="", manvalue="", manname="", panvalue="", panname="", vilvalue="", vilname ="",excelnav = "";

	String query3="",query4="",query5="";
	String districtName="",mandalName="",panchayatName="",villageName="",constituencyName="",habitationName="",programCode="",workCategory="",workCategoryCode="",programName = "",subprogramCode="",subprogramName="";

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
	ResultSet rs2 = null,rs21 = null,rs22 = null;
	Statement stmt1 = null,stmt21 = null,stmt22 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
	boolean flag=true,flag1=false,flagp=true,flagn=true,flagd=true;
	//fields for total
	int gnspills=0,gspills=0,gtspills=0,ghabsan=0,ghabsan1=0,gtsno=0,gcomp=0,gcomm=0,ghabcov=0,gten=0,gagree=0,ggrnd=0;
	float gnspillamt=0,gspillamt=0,gtspamt=0,grevamt=0,gepreyr=0,geprev=0,gedur=0,gcum=0,getot=0;
	int gnspills1=0,gspills1=0,gtspills1=0;
	float gnspillamt1=0,gspillamt1=0,gtspamt1=0,grevamt1=0;

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
	
int gnspillsdrsub=0,gspillsdrsub=0,gtspillsdrsub=0,ghabsandrsub=0,gtsnodrsub=0,gcompdrsub=0,gcommdrsub=0,ghabcovdrsub=0,gtendrsub=0,gagreedrsub=0,ggrnddrsub=0;
float gnspillamtdrsub=0,gspillamtdrsub=0,gtspamtdrsub=0,grevamtdrsub=0,gepreyrdrsub=0,geprevdrsub=0,gedurdrsub=0,gcumdrsub=0,getotdrsub=0;
int gnspillsdrsub1=0,gspillsdrsub1=0,gtspillsdrsub1=0,ghabsandrsub1=0,gtsnodrsub1=0,gcompdrsub1=0,gcommdrsub1=0,ghabcovdrsub1=0,gtendrsub1=0,gagreedrsub1=0,ggrnddrsub1=0;
float gnspillamtdrsub1=0,gspillamtdrsub1=0,gtspamtdrsub1=0,grevamtdrsub1=0,gepreyrdrsub1=0,geprevdrsub1=0,gedurdrsub1=0,gcumdrsub1=0,getotdrsub1=0;
	
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
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
	<% //if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1"))
	if(rDistrict != null && rDistrict.equals("00")&& programCode.equals(""))
	{
	excelnav = "1";
	//System.out.println("First Drill");
	   try
	   {
	   %>

	   	<%@ include file="rws_worksmonitoring_progstatus_label.jsp"%>
	   <%
		String qry1=null;
		/*qry1="SELECT DISTINCT SP.PROGRAMME_CODE,P.PROGRAMME_NAME,SP.WORK_CATEGORY FROM RWS_PROGRAMME_TBL P,RWS_SUBPROGRAMME_TBL SP WHERE SP.PROGRAMME_CODE=P.PROGRAMME_CODE order BY SP.WORK_CATEGORY DESC";*/
		qry1="SELECT DISTINCT W.PROGRAMME_CODE,P.PROGRAMME_NAME,w.CATEGORY_CODE,cat.category_name FROM RWS_PROGRAMME_TBL P,RWS_WORK_ADMN_TBL W,rws_work_category_tbl cat WHERE P.PROGRAMME_CODE=W.PROGRAMME_CODE and w.category_code=cat.category_code and w.CATEGORY_code is not null order BY w.CATEGORY_code asc";
		//System.out.println("Test Qry is::"+qry1);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs1=stmt1.executeQuery(qry1);
		
		while(rs1.next())
		{
			String Progcode=rs1.getString(1);
            String Progname=rs1.getString(2);
			String wrkCat=rs1.getString(3);
			
			if(rs1.getString(3).equals("1")&& flag==true)
			{
			//Debug.println("flag1 is"+flag);
			flag=false;flagn=false;flagd=false;
		%>
		<tr><td class=btext colspan=2>PROJECTS</td></tr>
		<%
		}
		
		if(rs1.getString(3).equals("2")&& flag==false)
		{
		%>
		<tr>
<td colspan=2 class="btext">GrandTotal(Projects)</td>
<td class="btext" align="right"><%=gspillsp%></td>
<td class="btext" align="right"><%=gnspillsp %></td>
<td class="btext" align="right"><%=gtspillsp%></td>
<td class="btext" align="right"><%=gspillsp1%></td>
<td class="btext" align="right"><%=gnspillsp1%></td>
<td class="btext" align="right"><%=gtspillsp1%></td>
<td class="btext" align="right"><%=Math.round(gspillamtp*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamtp*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamtp*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gspillamtp1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamtp1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamtp1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(grevamtp*100)/100f %></td>
<td class="btext" align="right"><%=ghabsanp%></td>
<td class="btext" align="right"><%=ghabsanp1%></td>
<td class="btext" align="right"><%=Math.round(gepreyrp*100)/100f%></td>
<td class="btext" align="right"><%if(geprevp==0)out.println("<center>-</center>");else out.println(Math.round(geprevp*100)/100f);%></td>
<td class="btext" align="right"><%=Math.round(gedurp*100)/100f %></td>
<td class="btext" align="right"><%=Math.round(gcump*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(getotp*100)/100f %></td>
<td class="btext" align="right"><%=gtsnop %></td>
<td class="btext" align="right"><%=gtenp%></td>
<td class="btext" align="right"><%=gagreep %></td>
<td class="btext" align="right"><%=ggrndp%></td>
<td class="btext" align="right"><%=gcompp %></td>
<td class="btext" align="right"><%=gcommp%></td>
<td class="btext" align="right"><%=ghabcovp%></td>
</tr>
		<%
		//Debug.println("flag3 is"+flag);
		flag=true;flagp=false;flagd=false;flagn=true;
		%>
		<tr><td class=btext colspan=2>NORMAL</td></tr>
		<%
		}
		if(rs1.getString(3).equals("3")&& flag==true)
		{
		%>
		<tr>
<td colspan=2 class="btext">GrandTotal(Normal)</td>
<td class="btext" align="right"><%=gspillsn%></td>
<td class="btext" align="right"><%=gnspillsn %></td>
<td class="btext" align="right"><%=gtspillsn%></td>
<td class="btext" align="right"><%=gspillsn1%></td>
<td class="btext" align="right"><%=gnspillsn1 %></td>
<td class="btext" align="right"><%=gtspillsn1%></td>
<td class="btext" align="right"><%=Math.round(gspillamtn*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamtn*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamtn*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gspillamtn1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamtn1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamtn1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(grevamtn*100)/100f %></td>
<td class="btext" align="right"><%=ghabsann%></td>
<td class="btext" align="right"><%=ghabsann1%></td>
<td class="btext" align="right"><%=Math.round(gepreyrn*100)/100f%></td>
<td class="btext" align="right"><%if(geprevn==0)out.println("<center>-</center>");else out.println(Math.round(geprevn*100)/100f);%></td>
<td class="btext" align="right"><%=Math.round(gedurn*100)/100f %></td>
<td class="btext" align="right"><%=Math.round(gcumn*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(getotn*100)/100f %></td>
<td class="btext" align="right"><%=gtsnon %></td>
<td class="btext" align="right"><%=gtenn%></td>
<td class="btext" align="right"><%=gagreen %></td>
<td class="btext" align="right"><%=ggrndn%></td>
<td class="btext" align="right"><%=gcompn %></td>
<td class="btext" align="right"><%=gcommn%></td>
<td class="btext" align="right"><%=ghabcovn %></td>
</tr>
		<%
		//Debug.println("flag3 is"+flag);
		flag=false;	flagp=false;flagn=false;flagd=true;
		%>
		<tr><td class=btext colspan=2>DISTRICT LEVEL</td></tr>
		<%
		}
		 %>	
		
		<tr onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
        <td class=rptValue><%=++slno%></td>
		<td class=rptValue><a href="rws_wrk_prg1.jsp?programCode=<%=rs1.getString(1)%>&programName=<%=rs1.getString(2)%>&workCategory=<%=rs1.getString(4)%>&workCategoryCode=<%=rs1.getString(3) %>"><%=rs1.getString(2)%></a>
		
		
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
					try
						{
  					String qry21 = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT,w.plan_code FROM RWS_WORK_ADMN_TBL W where SUBSTR(W.WORK_ID,1,2) ="+rs1.getString(1)+"  and w.category_code='"+rs1.getString(3)+"' group by w.plan_code ";
					String qry22 = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W where W.PROGRAMME_CODE="+rs1.getString(1)+" and w.category_code = '"+rs1.getString(3)+"'";
					//System.out.println("qry21 in 1 is::"+qry21);
					 //System.out.println("qry22 in 1 is::"+qry22);					
					stmt21 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
 					stmt22 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
                	rs21=stmt21.executeQuery(qry21);
                	rs22=stmt22.executeQuery(qry22);                	
					while(rs21.next()&&rs22.next())
			{
 						 if(rs21.getString(3).equals("1"))spills=rs21.getInt(1);
 						 if(rs21.getString(3).equals("2"))spills1=rs21.getInt(1);						 						 
						 if(rs21.getString(3).equals("1"))gspills=gspills+spills;
						 if(rs21.getString(3).equals("2"))gspills1=gspills1+spills1;						 
						 if(rs21.getString(3).equals("1"))nspills=rs22.getInt(1);
						 if(rs21.getString(3).equals("2"))nspills1=rs22.getInt(1);
						 if(rs21.getString(3).equals("1"))gnspills=gnspills+nspills;
						 if(rs21.getString(3).equals("2"))gnspills1=gnspills1+nspills1;
						 if(rs21.getString(3).equals("1"))tspills=tspills+rs21.getInt(1)+rs22.getInt(1);
						 if(rs21.getString(3).equals("2"))tspills1=tspills1+rs21.getInt(1)+rs22.getInt(1);
						 if(rs21.getString(3).equals("1"))gtspills=gtspills+tspills;
						 if(rs21.getString(3).equals("2"))gtspills1=gtspills1+tspills1;
												 
						if(rs21.getString(3).equals("1"))spillamt=rs21.getFloat(2);
						if(rs21.getString(3).equals("2"))spillamt1=rs21.getFloat(2);						 						 
						if(rs21.getString(3).equals("1"))gspillamt=gspillamt+spillamt;
						if(rs21.getString(3).equals("2"))gspillamt1=gspillamt1+spillamt1;						 
						if(rs21.getString(3).equals("1"))nspillamt=rs22.getFloat(2);
						if(rs21.getString(3).equals("2"))nspillamt1=rs22.getFloat(2);
						if(rs21.getString(3).equals("1"))gnspillamt=gnspillamt+nspillamt;
						if(rs21.getString(3).equals("2"))gnspillamt1=gnspillamt1+nspillamt1;

						if(rs21.getString(3).equals("1"))tspillamt=tspillamt+rs21.getFloat(2)+rs22.getFloat(2);
						if(rs21.getString(3).equals("2"))tspillamt1=tspillamt1+rs21.getFloat(2)+rs22.getFloat(2);
						if(rs21.getString(3).equals("1"))gtspamt=gtspamt+tspillamt;
						if(rs21.getString(3).equals("2"))gtspamt1=gtspamt1+tspillamt1;

                         if(flagp==true)
                         {
							if(rs21.getString(3).equals("1"))spills=rs21.getInt(1);
							if(rs21.getString(3).equals("2"))spills1=rs21.getInt(1);
							if(rs21.getString(3).equals("1"))gspillsp=gspillsp+spills;
							if(rs21.getString(3).equals("2"))gspillsp1=gspillsp1+spills;
							if(rs21.getString(3).equals("1"))nspills=rs22.getInt(1);
							if(rs21.getString(3).equals("2"))nspills1=rs22.getInt(1);
							if(rs21.getString(3).equals("1"))gnspillsp=gnspillsp+nspills;
							if(rs21.getString(3).equals("2"))gnspillsp1=gnspillsp1+nspills1;
							if(rs21.getString(3).equals("1"))tspillsp=tspillsp+rs21.getInt(1)+rs22.getInt(1);
							if(rs21.getString(3).equals("2"))tspillsp1=tspillsp1+rs21.getInt(1)+rs22.getInt(1);
							if(rs21.getString(3).equals("1"))gtspillsp=gtspillsp+tspillsp;
							if(rs21.getString(3).equals("2"))gtspillsp1=gtspillsp1+tspillsp;						 
							spillamtp=rs21.getFloat(2);
							if(rs21.getString(3).equals("1"))gspillamtp=gspillamtp+spillamtp;
							if(rs21.getString(3).equals("2"))gspillamtp1=gspillamtp1+spillamtp;
							nspillamtp=rs22.getFloat(2);
							if(rs21.getString(3).equals("1"))gnspillamtp=gnspillamtp+nspillamtp;
							if(rs21.getString(3).equals("2"))gnspillamtp1=gnspillamtp1+nspillamtp;					  	 
							if(rs21.getString(3).equals("1"))tspamtp=tspamtp+rs21.getFloat(2)+rs22.getFloat(2);
							if(rs21.getString(3).equals("2"))tspamtp=tspamtp+rs21.getFloat(2)+rs22.getFloat(2);							
							if(rs21.getString(3).equals("1"))gtspamtp=gtspamtp+tspamtp;
							if(rs21.getString(3).equals("2"))gtspamtp1=gtspamtp1+tspamtp;
				 
                         }
						
						if(flagn==true){
if(rs21.getString(3).equals("1"))spills=rs21.getInt(1);
if(rs21.getString(3).equals("2"))spills1=rs21.getInt(1);
if(rs21.getString(3).equals("1"))gspillsn=gspillsn+spills;
if(rs21.getString(3).equals("2"))gspillsn1=gspillsn1+spills1;
if(rs21.getString(3).equals("1"))nspills=rs22.getInt(1);
if(rs21.getString(3).equals("2"))nspills1=rs22.getInt(1);
if(rs21.getString(3).equals("1"))gnspillsn=gnspillsn+nspills;
if(rs21.getString(3).equals("2"))gnspillsn1=gnspillsn1+nspills1;
if(rs21.getString(3).equals("1"))tspillsn=tspillsn+rs21.getInt(1)+rs22.getInt(1);
if(rs21.getString(3).equals("2"))tspillsn1=tspillsn1+rs21.getInt(1)+rs22.getInt(1);
if(rs21.getString(3).equals("1"))gtspillsn=gtspillsn+tspillsn;
if(rs21.getString(3).equals("2"))gtspillsn1=gtspillsn1+tspillsn1;
spillamtn=rs21.getFloat(2);				 
if(rs21.getString(3).equals("1"))gspillamtn=gspillamtn+spillamtn;
if(rs21.getString(3).equals("2"))gspillamtn1=gspillamtn1+spillamtn;						
nspillamtn=rs22.getFloat(2);
if(rs21.getString(3).equals("1"))gnspillamtn=gnspillamtn+nspillamtn;
if(rs21.getString(3).equals("2"))gnspillamtn1=gnspillamtn1+nspillamtn;						
if(rs21.getString(3).equals("1"))tspamtn=tspamtn+rs21.getFloat(2)+rs22.getFloat(2);
if(rs21.getString(3).equals("2"))tspamtn1=tspamtn1+rs21.getFloat(2)+rs22.getFloat(2);
if(rs21.getString(3).equals("1"))gtspamtn=gtspamtn+tspamtn;
if(rs21.getString(3).equals("2"))gtspamtn1=gtspamtn1+tspamtn1;
}

						if(flagd==true){
						spills=rs21.getInt(1);
						if(rs21.getString(3).equals("1"))gspillsd=gspillsd+spills;
						if(rs21.getString(3).equals("2"))gspillsd1=gspillsd1+spills;						
						nspills=rs22.getInt(1);
						if(rs21.getString(3).equals("1"))gnspillsd=gnspillsd+nspills;
						if(rs21.getString(3).equals("2"))gnspillsd1=gnspillsd1+nspills;
						tspillsd=tspillsd+rs21.getInt(1)+rs22.getInt(1);
						if(rs21.getString(3).equals("1"))gtspillsd=gtspillsd+tspillsd;
						if(rs21.getString(3).equals("2"))gtspillsd1=gtspillsd1+tspillsd;
						if(rs21.getString(3).equals("1"))spillamtd=rs21.getFloat(2);
						if(rs21.getString(3).equals("2"))spillamtd1=rs21.getFloat(2);
						if(rs21.getString(3).equals("1"))gspillamtd=gspillamtd+spillamtd;
						if(rs21.getString(3).equals("2"))gspillamtd1=gspillamtd1+spillamtd1;
						nspillamtd=rs22.getFloat(2);
						if(rs21.getString(3).equals("1"))gnspillamtd=gnspillamtd+nspillamtd;
						if(rs21.getString(3).equals("2"))gnspillamtd1=gnspillamtd1+nspillamtd;						
						if(rs21.getString(3).equals("1"))tspamtd=tspamtd+rs21.getFloat(2)+rs22.getFloat(2);
						if(rs21.getString(3).equals("2"))tspamtd1=tspamtd1+rs21.getFloat(2)+rs22.getFloat(2);						
						if(rs21.getString(3).equals("1"))gtspamtd=gtspamtd+tspamtd;
						if(rs21.getString(3).equals("2"))gtspamtd1=gtspamtd1+tspamtd1;						
						}
						if(rs21.getString(3).equals("1"))
						{
					%>
							<td class=rptValue align=right><%=rs21.getInt(1)%></td>
							<td class=rptValue align=right><%=rs22.getInt(1)%></td>
							<td class=rptValue align=right><%=tspills%></td>
							<td class=rptValue align=right>0</td>
							<td class=rptValue align=right>0</td>
							<td class=rptValue align=right>0</td>
					<%
						}
						else if(rs21.getString(3).equals("2"))
						{
					%>
							<td class=rptValue align=right>0</td>
							<td class=rptValue align=right>0</td>
							<td class=rptValue align=right>0</td>
							<td class=rptValue align=right><%=rs21.getInt(1)%></td>
							<td class=rptValue align=right><%=rs22.getInt(1)%></td>
							<td class=rptValue align=right><%=tspills%></td>
					<%
						} 
						if(rs21.getString(3).equals("1"))
						{
					%>
							<td class=rptValue align=right><%=Math.round(spillamt*100)/100f%></td>
							<td class=rptValue align=right><%=Math.round(nspillamt*100)/100f%></td>
							<td class=rptValue align=right><%=Math.round(tspillamt*100)/100f%></td>
							<td class=rptValue align=right>0.0</td>
							<td class=rptValue align=right>0.0</td>
							<td class=rptValue align=right>0.0</td>
					<% 
						}
						else if(rs21.getString(3).equals("2"))
						{
					%>
							<td class=rptValue align=right>0.0</td>
							<td class=rptValue align=right>0.0</td>
							<td class=rptValue align=right>0.0</td>
							<td class=rptValue align=right><%=Math.round(spillamt1*100)/100f%></td>
							<td class=rptValue align=right><%=Math.round(nspillamt1*100)/100f%></td>
							<td class=rptValue align=right><%=Math.round(tspillamt1*100)/100f%></td>
					<%
						}
					%>
	
			<% 
			
			}
			}
			catch(Exception e)
			{
			e.printStackTrace();
			}
			finally
			{
			rs21.close();
			stmt21.close();
			rs22.close();
			stmt22.close();

			}
			String qry3=null;
			Statement stmt3=null;
			try
			{

			qry3="select distinct SUM(CASE WHEN R.REV_SANCTION_AMOUNT IS NOT NULL THEN  R.REV_SANCTION_AMOUNT ELSE 0 END)FROM RWS_WORK_ADMN_TBL W,RWS_REVISED_ADM_SANC_TBL R WHERE W.WORK_ID=R.WORK_ID AND R.PROGRAMME_CODE=W.PROGRAMME_CODE AND R.PROGRAMME_CODE='"+rs1.getString(1)+"' and W.category_code='"+rs1.getString(3)+"'";

			 stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs3=stmt3.executeQuery(qry3);
            while(rs3.next())
            {
             grevamt=grevamt+rs3.getFloat(1);
             if(flagp==true){
                          grevamtp=grevamtp+rs3.getFloat(1);}
                          
                                       if(flagn==true){
                          grevamtn=grevamtn+rs3.getFloat(1);}

			               if(flagd==true){
                          grevamtd=grevamtd+rs3.getFloat(1);}
            %>
            <td class=rptValue align=right><%=rs3.getFloat(1)%></td>
           
           
            <%} 
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
			String qry4=null;
			Statement stmt4=null;
			try
			{
			qry4="Select distinct SUM(w.NO_OF_HABS),w.plan_code from rws_work_admn_tbl w where w.programme_code='"+rs1.getString(1)+"'  and w.category_code='"+rs1.getString(3)+"' group by w.plan_code";
			//System.out.println(qry4);
			stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs4=stmt4.executeQuery(qry4);
            int rs4count = 0;
            while(rs4.next()){rs4count++;}
            stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs4=stmt4.executeQuery(qry4);
            if(rs4count == 1)
            {
	            while(rs4.next())
	            {
		            if(rs4.getString(2).equals("1"))ghabsan=ghabsan+rs4.getInt(1);
		            if(rs4.getString(2).equals("2"))ghabsan1=ghabsan1+rs4.getInt(1);
		            if(flagp==true){
							if(rs4.getString(2).equals("1"))ghabsanp=ghabsanp+rs4.getInt(1);
							if(rs4.getString(2).equals("2"))ghabsanp1=ghabsanp1+rs4.getInt(1);
							}
		            if(flagn==true){
   							if(rs4.getString(2).equals("1"))ghabsann=ghabsann+rs4.getInt(1);
   							if(rs4.getString(2).equals("2"))ghabsann1=ghabsann1+rs4.getInt(1);   							
   							}
			        if(flagd==true){
			        if(rs4.getString(2).equals("1"))ghabsand=ghabsand+rs4.getInt(1);
			        if(rs4.getString(2).equals("2"))ghabsand1=ghabsand1+rs4.getInt(1);
			        }
		            
		            if(rs4.getString(2).equals("1")){
		            %>
		                 <td class=rptValue align=right><%=rs4.getInt(1)%></td>
						 <td class=rptValue align=right>0</td>
		            <%
		            }
		            else if(rs4.getString(2).equals("2"))
		            {
		            %>
		            <td class=rptValue align=right>0</td>
					<td class=rptValue align=right><%=rs4.getInt(1)%></td>
		            <%
		            }
	            } 
            }
            else if(rs4count > 1)
            {
	            while(rs4.next())
	            {
		            if(rs4.getString(2).equals("1"))ghabsan=ghabsan+rs4.getInt(1);
   		            if(rs4.getString(2).equals("2"))ghabsan1=ghabsan1+rs4.getInt(1);
		            if(flagp==true){
							if(rs4.getString(2).equals("1"))ghabsanp=ghabsanp+rs4.getInt(1);
							if(rs4.getString(2).equals("2"))ghabsanp1=ghabsanp1+rs4.getInt(1);
							}
		            if(flagn==true){
   							if(rs4.getString(2).equals("1"))ghabsann=ghabsann+rs4.getInt(1);
   							if(rs4.getString(2).equals("2"))ghabsann1=ghabsann1+rs4.getInt(1);   							
   							}
			        if(flagd==true){
			        if(rs4.getString(2).equals("1"))ghabsand=ghabsand+rs4.getInt(1);
			        if(rs4.getString(2).equals("2"))ghabsand1=ghabsand1+rs4.getInt(1);
			        }
		            
		            if(rs4.getString(2).equals("1")){
		            %>
		                 <td class=rptValue align=right><%=rs4.getInt(1)%></td>
		            <%
		            }
		            else if(rs4.getString(2).equals("2"))
		            {
		            %>
		            <td class=rptValue align=right><%=rs4.getInt(1)%></td>
		
		            <%
		            }
	            } 
            
            	
            }
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
            String qry5=null;Statement stmt5=null;
            try
            {
            qry5="SELECT distinct SUM(CASE WHEN E.EXPENDITURE_UPTO IS NOT NULL and e.year = '"+currentYearPeriod+"' THEN E.EXPENDITURE_UPTO  ELSE 0 END),SUM(CASE WHEN E.EXPENDITURE_DURING  IS NOT NULL and e.year = '"+currentMonth+"' and e.month = '"+currentMonth+"' THEN  E.EXPENDITURE_DURING  ELSE 0 END),SUM(CASE WHEN E1.EXPENDITURE_UPTO_THE_PRE_YEAR  IS NOT NULL  THEN  E1.EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END) FROM RWS_WORK_EXPENDITURE_TBL E,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL E1,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID=E1.WORK_ID AND E.WORK_ID=E1.WORK_ID AND W.PROGRAMME_CODE=E.PROGRAMME_CODE AND W.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE='"+rs1.getString(1)+"'and w.category_code='"+rs1.getString(3)+"'";
//            System.out.println(qry5);
             stmt5 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs5=stmt5.executeQuery(qry5);
            while(rs5.next())
            {
            gepreyr=gepreyr+rs5.getFloat(3);
            geprev=geprev+rs5.getFloat(1);
            gedur=gedur+rs5.getFloat(2);
            gcum=gcum+rs5.getFloat(1)+rs5.getFloat(2);
            getot=getot+rs5.getFloat(1)+rs5.getFloat(2)+rs5.getFloat(3);
            if(flagp==true){
		    gepreyrp=gepreyrp+rs5.getFloat(3);
            geprevp=geprevp+rs5.getFloat(1);
            gedurp=gedurp+rs5.getFloat(2);
            gcump=gcump+rs5.getFloat(1)+rs5.getFloat(2);
            getotp=getotp+rs5.getFloat(1)+rs5.getFloat(2)+rs5.getFloat(3);
	 }
	     if(flagn==true){
		    gepreyrn=gepreyrn+rs5.getFloat(3);
            geprevn=geprevn+rs5.getFloat(1);
            gedurn=gedurn+rs5.getFloat(2);
            gcumn=gcumn+rs5.getFloat(1)+rs5.getFloat(2);
            getotn=getotn+rs5.getFloat(1)+rs5.getFloat(2)+rs5.getFloat(3);
	 }

	     if(flagd==true){
		    gepreyrd=gepreyrd+rs5.getFloat(3);
            geprevd=geprevd+rs5.getFloat(1);
            gedurd=gedurd+rs5.getFloat(2);
            gcumd=gcumd+rs5.getFloat(1)+rs5.getFloat(2);
            getotd=getotd+rs5.getFloat(1)+rs5.getFloat(2)+rs5.getFloat(3);
	 }
            %>
            <td class=rptValue align=right><%=Math.round(rs5.getFloat(3)*100)/100f%></td>
            <td class=rptValue align=right><% if(currentMonth.equals("04"))out.println("<center>-</center>");else out.println(Math.round(rs5.getFloat(1)*100)/100f);%></td>
             <td class=rptValue align=right><%=Math.round(rs5.getFloat(2)*100)/100f%></td>
              <td class=rptValue align=right><%=Math.round((rs5.getFloat(1)+rs5.getFloat(2))*100)/100f%></td>
              <td class=rptValue align=right><%=Math.round((rs5.getFloat(1)+rs5.getFloat(2)+rs5.getFloat(3))*100)/100f%></td>
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
            qry6="SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.PROGRAMME_CODE=SUBSTR(E.WORK_ID,1,2) AND SUBSTR(E.WORK_ID,1,2)='"+rs1.getString(1)+"' and W.category_code='"+rs1.getString(3)+"'";
            stmt6 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs6=stmt6.executeQuery(qry6);
            while(rs6.next())
            {
             gtsno=gtsno+rs6.getInt(1);
             if(flagp==true){gtsnop=gtsnop+rs6.getInt(1);}
             if(flagn==true){gtsnon=gtsnon+rs6.getInt(1);}
             if(flagd==true){gtsnod=gtsnop+rs6.getInt(1);}            %>
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
            qry7="SELECT distinct SUM(CASE WHEN CON.WORK_ID  IS NOT NULL THEN  1 ELSE 0 END)AS CON_TENDERED,SUM(CASE WHEN CON.AGREEMENT_DATE IS NOT NULL THEN 1  ELSE 0 END)AS CON_AGMT_ENT FROM RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_ADMN_TBL W  "+
				" WHERE W.WORK_ID=CON.WORK_ID AND SUBSTR(CON.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(CON.WORK_ID,1,2)='"+rs1.getString(1)+"' and W.CATEGORY_CODE='"+rs1.getString(3)+"'";
          stmt7= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs7=stmt7.executeQuery(qry7);
            while(rs7.next())
            {
            gten=gten+rs7.getInt(1);
            gagree=gagree+rs7.getInt(2);
            if(flagp==true){
		      gtenp=gtenp+rs7.getInt(1);
            gagreep=gagreep+rs7.getInt(2);
            }
                        if(flagn==true){
		      gtenn=gtenn+rs7.getInt(1);
            gagreen=gagreen+rs7.getInt(2);
            }

	                if(flagd==true){
		      gtend=gtend+rs7.getInt(1);
            gagreed=gagreed+rs7.getInt(2);
            }%>
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
            qry8="SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W  "+
				" WHERE W.WORK_ID=G.WORK_ID AND SUBSTR(G.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(G.WORK_ID,1,2)='"+rs1.getString(1)+"' and W.CATEGORY_CODE='"+rs1.getString(3)+"'";
            stmt8= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs8=stmt8.executeQuery(qry8);
            while(rs8.next())
            {
            ggrnd=ggrnd+rs8.getInt(1);
			if(flagp==true){ggrndp=ggrndp+rs8.getInt(1);} 
			if(flagn==true){ggrndn=ggrndn+rs8.getInt(1);} 
			if(flagd==true){ggrndd=ggrndd+rs8.getInt(1);} 
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
            qry9="SELECT distinct SUM(CASE WHEN WC.work_id IS NOT NULL THEN  1 ELSE 0 END),SUM(CASE WHEN WC.DATE_OF_COMM IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMPLETION_TBL WC,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=WC.WORK_ID AND SUBSTR(WC.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(WC.WORK_ID,1,2)='"+rs1.getString(1)+"' and W.CATEGORY_CODE='"+rs1.getString(3)+"'";
           stmt9= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs9=stmt9.executeQuery(qry9);
            while(rs9.next())
            {
            gcomp=gcomp+rs9.getInt(1);
            gcomm=gcomm+rs9.getInt(2);
			if(flagp==true){
            gcompp=gcompp+rs9.getInt(1);
            gcommp=gcommp+rs9.getInt(2);
            }	
            		if(flagn==true){
            gcompn=gcompn+rs9.getInt(1);
            gcommn=gcommn+rs9.getInt(2);
            }

	    			if(flagd==true){
            gcompd=gcompd+rs9.getInt(1);
            gcommd=gcommd+rs9.getInt(2);
            }            %>
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
            qry10="SELECT distinct count(distinct(hab_code))FROM RWS_EST_NEW_HAB_LNK_TBL E,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND SUBSTR(E.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(E.WORK_ID,1,2)='"+rs1.getString(1)+"' and W.CATEGORY_CODE='"+rs1.getString(3)+"' and e.work_id in (select work_id from rws_work_completion_tbl)";
            //System.out.println("qry10:"+qry10);
            stmt10= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs10=stmt10.executeQuery(qry10);
            while(rs10.next())
            {
            ghabcov=ghabcov+rs10.getInt(1);
            if(flagp==true){ghabcovp=ghabcovp+rs10.getInt(1);}
            if(flagn==true){ghabcovn=ghabcovn+rs10.getInt(1);}
			if(flagd==true){ghabcovd=ghabcovd+rs10.getInt(1);}
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


	
	%>
</tr>

<tr>
<td colspan=2 class="btext">GrandTotal(DistLevel)</td>
<td class="btext" align="right"><%=gspillsd%></td>
<td class="btext" align="right"><%=gnspillsd%></td>
<td class="btext" align="right"><%=gtspillsd%></td>
<td class="btext" align="right"><%=gspillsd1%></td>
<td class="btext" align="right"><%=gnspillsd1%></td>
<td class="btext" align="right"><%=gtspillsd1%></td>
<td class="btext" align="right"><%=Math.round(gspillamtd*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamtd*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamtd*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gspillamtd1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamtd1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamtd1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(grevamtd*100)/100f %></td>
<td class="btext" align="right"><%=ghabsand%></td>
<td class="btext" align="right"><%=ghabsand1%></td>
<td class="btext" align="right"><%=Math.round(gepreyrd*100)/100f%></td>
<td class="btext" align="right"><%if(geprevd==0)out.println("<center>-</center>");else out.println(Math.round(geprevd*100)/100f);%></td>
<td class="btext" align="right"><%=Math.round(gedurd*100)/100f %></td>
<td class="btext" align="right"><%=Math.round(gcumd*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(getotd*100)/100f %></td>
<td class="btext" align="right"><%=gtsnod%></td>
<td class="btext" align="right"><%=gtend%></td>
<td class="btext" align="right"><%=gagreed%></td>
<td class="btext" align="right"><%=ggrndd%></td>
<td class="btext" align="right"><%=gcompd %></td>
<td class="btext" align="right"><%=gcommd%></td>
<td class="btext" align="right"><%=ghabcovd%></td>
</tr>
<tr>
<td colspan=2 class="btext">GrandTotal</td>
<td class="btext" align="right"><%=gspills%></td>
<td class="btext" align="right"><%=gnspills%></td>
<td class="btext" align="right"><%=gtspills%></td>
<td class="btext" align="right"><%=gspills1%></td>
<td class="btext" align="right"><%=gnspills1%></td>
<td class="btext" align="right"><%=gtspills1%></td>
<td class="btext" align="right"><%=Math.round(gspillamt*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamt*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamt*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gspillamt1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamt1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamt1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(grevamt1*100)/100f %></td>
<td class="btext" align="right"><%=ghabsan%></td>
<td class="btext" align="right"><%=ghabsan1%></td>
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

	//sub progrmmme drill code
	//if(rDistrict != null && rDistrict.equals("00")&& !programCode.equals(""))
	else if(subprogramCode==null || subprogramCode=="")
	{
	//System.out.println("2nd drillsas");
	excelnav = "2";
	%>

<%
	   try
	   {
	   %>
	   		<%@ include file="rws_worksmonitoring_progstatus_labelfirst.jsp"%>
	   <%
		String qry1=null;
//		qry1="SELECT  SP.PROGRAMME_CODE, SP.SUBPROGRAMME_CODE,SP.SUBPROGRAMME_NAME,sp.work_category FROM RWS_SUBPROGRAMME_TBL SP WHERE SP.PROGRAMME_CODE="+programCode+" AND SP.WORK_CATEGORY='"+workCategory+"' AND sp.WORK_CATEGORY IS NOT NULL";
qry1 = "SELECT DISTINCT W.subPROGRAMME_CODE,sub.subPROGRAMME_NAME,w.CATEGORY_CODE FROM RWS_subPROGRAMME_TBL sub,RWS_WORK_ADMN_TBL W WHERE sub.PROGRAMME_CODE=W.PROGRAMME_CODE and sub.subPROGRAMME_CODE=W.subPROGRAMME_CODE and w.programme_code='"+programCode+"' and w.category_code='"+workCategoryCode+"' and w.CATEGORY_code is not null order BY w.CATEGORY_code asc";
		//System.out.println("qry1::"+qry1);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs1=stmt1.executeQuery(qry1);
			%>	<tr><td class=btext colspan=2 nowrap>Programme Name - <%=programName%></td></tr>
	<%
		while(rs1.next())
		{
		//System.out.println("Programme Name::"+programName);
		//System.out.println("Programme Code"+rs1.getString(1));
		//System.out.println("Subprogramme Code"+rs1.getString(2));
		%>	
		<tr onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
		<td class=rptValue><%=++slno%></td>
		<td class=rptValue><%if(rs1.getString(2).equals("-"))out.println(programName);else out.println(rs1.getString(2));%></td>
		<%

						String qry2=null;Statement stmt2=null;
				
						float spillamt=0,nspillamt=0,tspamt=0,spillamt1=0,nspillamt1=0,tspamt1=0,tspillamt=0,tspillamt1=0;
						int tspills=0,spills=0,nspills=0,spills1=0,nspills1=0,tspills1=0;
				
					try
						{
//           qry2="Select distinct SUM(CASE WHEN w.ADMIN_DATE <= '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE > '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE <= '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT,SUM(CASE WHEN w.ADMIN_DATE > '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN "+" w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W where W.PROGRAMME_CODE="+rs1.getString(1)+" and W.SUBPROGRAMME_CODE="+rs1.getString(2)+" and W.work_category='"+workCategory+"'";
	 		//System.out.println("Query2 in Drill is::"+qry2);
	// stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
      //   rs2=stmt2.executeQuery(qry2);
	
//	while(rs2.next())
	//		{
				String qry21="",qry22="";
				//qry21 = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W,RWS_SUBPROGRAMME_TBL sub WHERE SUBSTR(W.WORK_ID,1,2) ='"+rs1.getString(1)+"' and (sub.work_category='"+workCategory+"' and sub.programme_code='"+rs1.getString(1)+"' and sub.subprogramme_code='"+rs1.getString(2)+"') and sub.programme_code=w.programme_code and sub.subprogramme_code=w.subprogramme_code ";
				qry21 = "SELECT SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 1 ELSE 0 END),SUM(CASE WHEN w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END) AS A_SPILL_OVER_AMT,w.plan_code FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,1,2) ='"+programCode+"' and SUBSTR(W.WORK_ID,3,2) ='"+rs1.getString(1)+"' and  w.category_code='"+rs1.getString(3)+"' group by w.plan_code ";
				//System.out.println("qry21 in 2::"+qry21);
				qry22 = "Select distinct SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END) AS A_NON_SPILL_OVER,SUM(CASE WHEN w.ADMIN_DATE >= '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END) AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W where W.PROGRAMME_CODE="+programCode+" and SUBSTR(W.WORK_ID,3,2) ='"+rs1.getString(1)+"' and w.category_code='"+rs1.getString(3)+"'";
				//System.out.println("qry22 in 2::"+qry22);
				 stmt21 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
 				 stmt22 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
                	rs21=stmt21.executeQuery(qry21);
                	rs22=stmt22.executeQuery(qry22);                	
					while(rs21.next()&&rs22.next())
					{
						 if(rs21.getString(3).equals("1")) spills=rs21.getInt(1);
						 if(rs21.getString(3).equals("2")) spills1=rs21.getInt(1);
						  if(rs21.getString(3).equals("1"))gspillsdr=gspillsdr+spills;
  						  if(rs21.getString(3).equals("2"))gspillsdr1=gspillsdr1+spills1;
						 if(rs21.getString(3).equals("1"))nspills=rs22.getInt(1);
						 if(rs21.getString(3).equals("2"))nspills1=rs22.getInt(1);
						 if(rs21.getString(3).equals("1"))gnspillsdr=gnspillsdr+nspills;
						 if(rs21.getString(3).equals("2"))gnspillsdr1=gnspillsdr1+nspills;
						 if(rs21.getString(3).equals("1"))tspills=tspills+rs21.getInt(1)+rs22.getInt(1);
						 if(rs21.getString(3).equals("2"))tspills1=tspills1+rs21.getInt(1)+rs22.getInt(1);
						 if(rs21.getString(3).equals("1"))gtspillsdr=gtspillsdr+tspills;
						 if(rs21.getString(3).equals("2"))gtspillsdr1=gtspillsdr1+tspills1;
						if(rs21.getString(3).equals("1"))spillamt=rs21.getFloat(2);
						if(rs21.getString(3).equals("2"))spillamt1=rs21.getFloat(2);						 						 
						if(rs21.getString(3).equals("1"))gspillamtdr=gspillamtdr+spillamt;
						if(rs21.getString(3).equals("2"))gspillamtdr1=gspillamtdr1+spillamt1;						 
						if(rs21.getString(3).equals("1"))nspillamt=rs22.getFloat(2);
						if(rs21.getString(3).equals("2"))nspillamt1=rs22.getFloat(2);
						if(rs21.getString(3).equals("1"))gnspillamtdr=gnspillamtdr+nspillamt;
						if(rs21.getString(3).equals("2"))gnspillamtdr1=gnspillamtdr1+nspillamt1;
						if(rs21.getString(3).equals("1"))tspillamt=tspillamt+rs21.getFloat(2)+rs22.getFloat(2);
						if(rs21.getString(3).equals("2"))tspillamt1=tspillamt1+rs21.getFloat(2)+rs22.getFloat(2);
						if(rs21.getString(3).equals("1"))gtspamtdr=gtspamtdr+tspillamt;
						if(rs21.getString(3).equals("2"))gtspamtdr1=gtspamtdr1+tspillamt1;
						if(rs21.getString(3).equals("1"))
						{
					%>
							<td class=rptValue align=right title=Click><b><a href="rws_wrk_prg1.jsp?programCode=<%=programCode%>&programName=<%=programName%>&subprogramName=<%=rs1.getString(2)%>&workCategory=<%=workCategory%>&workCategoryCode=<%=rs1.getString(3)%>&subprogramCode=<%=rs1.getString(1)%>"><%=rs21.getInt(1)%></a></b></td>
							<td class=rptValue align=right><%=rs22.getInt(1)%></td>
							<td class=rptValue align=right><%=tspills%></td>
							<td class=rptValue align=right>0</td>
							<td class=rptValue align=right>0</td>
							<td class=rptValue align=right>0</td>
					<%
						}
						else if(rs21.getString(3).equals("2"))
						{
					%>
							<td class=rptValue align=right>0</td>
							<td class=rptValue align=right>0</td>
							<td class=rptValue align=right>0</td>
							<td class=rptValue align=right title=Click><b><a href="rws_wrk_prg1.jsp?programCode=<%=programCode%>&programName=<%=programName%>&subprogramName=<%=rs1.getString(3)%>&workCategory=<%=workCategory%>&subprogramCode=<%=rs1.getString(2)%>"><%=rs21.getInt(1)%></a></b></td>
							<td class=rptValue align=right><%=rs21.getInt(1)%></td>
							<td class=rptValue align=right><%=rs22.getInt(1)%></td>
							<td class=rptValue align=right><%=tspills%></td>
					<%
						} 
						if(rs21.getString(3).equals("1"))
						{
					%>
							<td class=rptValue align=right><%=Math.round(spillamt*100)/100f%></td>
							<td class=rptValue align=right><%=Math.round(nspillamt*100)/100f%></td>
							<td class=rptValue align=right><%=Math.round(tspillamt*100)/100f%></td>
							<td class=rptValue align=right>0.0</td>
							<td class=rptValue align=right>0.0</td>
							<td class=rptValue align=right>0.0</td>
					<% 
						}
						else if(rs21.getString(3).equals("2"))
						{
					%>
							<td class=rptValue align=right>0.0</td>
							<td class=rptValue align=right>0.0</td>
							<td class=rptValue align=right>0.0</td>
							<td class=rptValue align=right><%=Math.round(spillamt1*100)/100f%></td>
							<td class=rptValue align=right><%=Math.round(nspillamt1*100)/100f%></td>
							<td class=rptValue align=right><%=Math.round(tspillamt1*100)/100f%></td>
					<%
						}
					%>
			<% }
			}
			catch(Exception e)
			{
			e.printStackTrace();
			}
			finally
			{
				rs21.close();
				stmt21.close();
				rs22.close();
				stmt22.close();
			}
			String qry3=null;
			Statement stmt3=null;
			try
			{
			qry3="select distinct SUM(CASE WHEN R.REV_SANCTION_AMOUNT IS NOT NULL THEN  R.REV_SANCTION_AMOUNT ELSE 0 END)FROM RWS_WORK_ADMN_TBL W,RWS_REVISED_ADM_SANC_TBL R WHERE W.WORK_ID=R.WORK_ID AND R.PROGRAMME_CODE=W.PROGRAMME_CODE AND W.PROGRAMME_CODE='"+programCode+"'  and W.SUBPROGRAMME_CODE='"+rs1.getString(1)+"' and W.category_code='"+rs1.getString(3)+"'";
			 stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs3=stmt3.executeQuery(qry3);
            while(rs3.next())
            {
             grevamtdr=grevamtdr+rs3.getFloat(1);
            %>
            <td class=rptValue align=right><%=rs3.getFloat(1)%></td>
           
           
            <%} 
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
            
			String qry4=null;
			Statement stmt4=null;
			try
			{
		//	qry4=" Select distinct SUM(w.NO_OF_HABS),w.plan_code from rws_work_admn_tbl w where SUB.PROGRAMME_CODE='"+rs1.getString(1)+"'  and SUB.SUBPROGRAMME_CODE='"+rs1.getString(2)+"' and SUB.work_category='"+workCategory+"' and w.programme_code=sub.programme_code and w.subprogramme_code=sub.subprogramme_code";
			qry4=" Select distinct SUM(w.NO_OF_HABS),w.plan_code from rws_work_admn_tbl w where w.programme_code='"+programCode+"' and w.SUBPROGRAMME_CODE='"+rs1.getString(1)+"' and w.category_code='"+rs1.getString(3)+"' group by w.plan_code";
			
			//System.out.println("query4 is::"+qry4);
			stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            int rs4count = 0;
            rs4=stmt4.executeQuery(qry4);
            while(rs4.next()){rs4count++;}
            stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs4=stmt4.executeQuery(qry4);
            if(rs4count == 1)
            {
	            while(rs4.next())
	            {
		            if(rs4.getString(2).equals("1"))ghabsandr=ghabsandr+rs4.getInt(1);
		            if(rs4.getString(2).equals("2"))ghabsandr1=ghabsandr1+rs4.getInt(1); 
		            if(rs4.getString(2).equals("1")){
		            %>
		                 <td class=rptValue align=right><%=rs4.getInt(1)%></td>
						 <td class=rptValue align=right>0</td>
		            <%
		            }
		            else if(rs4.getString(2).equals("2"))
		            {
		            %>
		            <td class=rptValue align=right>0</td>
					<td class=rptValue align=right><%=rs4.getInt(1)%></td>
		            <%
		            }
	            } 
            }
            else if(rs4count > 1)
            {
	            while(rs4.next())
	            {
		            if(rs4.getString(2).equals("1"))ghabsandr=ghabsandr+rs4.getInt(1);
   		            if(rs4.getString(2).equals("2"))ghabsandr1=ghabsandr1+rs4.getInt(1);
		            
		            if(rs4.getString(2).equals("1")){
		            %>
		                 <td class=rptValue align=right><%=rs4.getInt(1)%></td>
		            <%
		            }
		            else if(rs4.getString(2).equals("2"))
		            {
		            %>
		            <td class=rptValue align=right><%=rs4.getInt(1)%></td>
		
		            <%
		            }
	            } 
            
            	
            }
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
            String qry5=null;Statement stmt5=null;
            try
            {
            qry5="SELECT distinct SUM(CASE WHEN E.EXPENDITURE_UPTO IS NOT NULL and e.year = '"+currentYearPeriod+"' THEN E.EXPENDITURE_UPTO  ELSE 0 END),SUM(CASE WHEN E.EXPENDITURE_DURING  IS NOT NULL and e.year = '"+currentMonth+"' and e.month = '"+currentMonth+"' THEN  E.EXPENDITURE_DURING  ELSE 0 END),SUM(CASE WHEN E1.EXPENDITURE_UPTO_THE_PRE_YEAR  IS NOT NULL  THEN  E1.EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END) FROM RWS_WORK_EXPENDITURE_TBL E,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL E1,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID=E1.WORK_ID AND E.WORK_ID=E1.WORK_ID AND W.PROGRAMME_CODE=E.PROGRAMME_CODE AND W.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE='"+programCode+"'  and W.SUBPROGRAMME_CODE='"+rs1.getString(1)+"' and W.category_code='"+rs1.getString(3)+"'";
             stmt5 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs5=stmt5.executeQuery(qry5);
            while(rs5.next())
            {
            gepreyrdr=gepreyrdr+rs5.getFloat(3);
            geprevdr=geprevdr+rs5.getFloat(1);
            gedurdr=gedurdr+rs5.getFloat(2);
            gcumdr=gcumdr+rs5.getFloat(1)+rs5.getFloat(2);
            getotdr=getotdr+rs5.getFloat(1)+rs5.getFloat(2)+rs5.getFloat(3);
            %>
            <td class=rptValue align=right><%=Math.round(rs5.getFloat(3)*100)/100f%></td>
            <td class=rptValue align=right><% if(currentMonth.equals("04"))out.println("<center>-</center>");else out.println(Math.round(rs5.getFloat(1)*100)/100f);%></td>
             <td class=rptValue align=right><%=Math.round(rs5.getFloat(2)*100)/100f%></td>
              <td class=rptValue align=right><%=Math.round((rs5.getFloat(1)+rs5.getFloat(2))*100)/100f%></td>
              <td class=rptValue align=right><%=Math.round((rs5.getFloat(1)+rs5.getFloat(2)+rs5.getFloat(3))*100)/100f%></td>
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
            qry6="SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.PROGRAMME_CODE=SUBSTR(E.WORK_ID,1,2) AND SUBSTR(E.WORK_ID,1,2)='"+programCode+"' and SUBSTR(E.WORK_ID,3,2)='"+rs1.getString(1)+"' and W.category_code='"+rs1.getString(3)+"'";
            //System.out.println("Query6::"+qry6);
            stmt6 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs6=stmt6.executeQuery(qry6);
            while(rs6.next())
            {
             gtsnodr=gtsnodr+rs6.getInt(1);
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
            qry7="SELECT distinct SUM(CASE WHEN CON.WORK_ID  IS NOT NULL THEN  1 ELSE 0 END)AS CON_TENDERED,SUM(CASE WHEN CON.AGREEMENT_DATE IS NOT NULL THEN 1  ELSE 0 END)AS CON_AGMT_ENT FROM RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=CON.WORK_ID AND SUBSTR(CON.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(CON.WORK_ID,3,2)='"+rs1.getString(1)+"' and SUBSTR(CON.WORK_ID,1,2)='"+programCode+"' and W.CATEGORY_code='"+rs1.getString(3)+"'";
            stmt7= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs7=stmt7.executeQuery(qry7);
            while(rs7.next())
            {
            gtendr=gtendr+rs7.getInt(1);
            gagreedr=gagreedr+rs7.getInt(2);
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
            qry8="SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=G.WORK_ID AND SUBSTR(G.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(G.WORK_ID,1,2)='"+programCode+"' and SUBSTR(G.WORK_ID,3,2)='"+rs1.getString(1)+"' and W.CATEGORY_code='"+rs1.getString(3)+"'";
            stmt8= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs8=stmt8.executeQuery(qry8);
            while(rs8.next())
            {
            ggrnddr=ggrnddr+rs8.getInt(1);
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
            qry9="SELECT distinct SUM(CASE WHEN WC.work_id IS NOT NULL THEN  1 ELSE 0 END),SUM(CASE WHEN WC.DATE_OF_COMM IS NOT NULL THEN  1 ELSE 0 END) FROM RWS_WORK_COMPLETION_TBL WC,RWS_WORK_ADMN_TBL W  "+" WHERE W.WORK_ID=WC.WORK_ID AND SUBSTR(WC.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(WC.WORK_ID,1,2)='"+programCode+"' and SUBSTR(WC.WORK_ID,3,2)='"+rs1.getString(1)+"' and W.CATEGORY_code='"+rs1.getString(3)+"'";
                      //System.out.println("Query 9 is:"+qry9);
 		    stmt9= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs9=stmt9.executeQuery(qry9);
            while(rs9.next())
            {
            gcompdr=gcompdr+rs9.getInt(1);
            gcommdr=gcommdr+rs9.getInt(2);
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
            qry10="SELECT distinct count(distinct(hab_code))FROM RWS_EST_NEW_HAB_LNK_TBL E,RWS_WORK_ADMN_TBL W  "+" WHERE W.WORK_ID=E.WORK_ID AND SUBSTR(E.WORK_ID,1,2)=W.PROGRAMME_CODE AND SUBSTR(E.WORK_ID,1,2)='"+programCode+"'  and SUBSTR(E.WORK_ID,3,2)='"+rs1.getString(1)+"' and W.CATEGORY_code='"+rs1.getString(3)+"' and e.work_id in (select work_id from rws_work_completion_tbl)";
//            System.out.println("qry10:"+qry10);
	    stmt10= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs10=stmt10.executeQuery(qry10);
            while(rs10.next())
            {
            ghabcovdr=ghabcovdr+rs10.getInt(1);
		
            %>
            <td class=rptValue align=right><%=rs10.getInt(1)%></td>
                       <%  }
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
                                                //System.out.println("watch0");
            }//end of outer while
                                //     System.out.println("watch1");
	   }
	   
       catch(Exception e1)
       {
       e1.printStackTrace();
       }
       finally
       {
       rs1.close();
       stmt1.close();
       }%>
       <tr>
<td colspan=2 class="btext">GrandTotal</td>
<td class="btext" align="right"><%=gspillsdr%></td>
<td class="btext" align="right"><%=gnspillsdr%></td>
<td class="btext" align="right"><%=gtspillsdr%></td>
<td class="btext" align="right"><%=gspillsdr1%></td>
<td class="btext" align="right"><%=gnspillsdr1%></td>
<td class="btext" align="right"><%=gtspillsdr1%></td>
<td class="btext" align="right"><%=Math.round(gspillamtdr*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamtdr*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamtdr*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gspillamtdr1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gnspillamtdr1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(gtspamtdr1*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(grevamtdr*100)/100f %></td>
<td class="btext" align="right"><%=ghabsandr%></td>
<td class="btext" align="right"><%=ghabsandr1%></td>
<td class="btext" align="right"><%=Math.round(gepreyrdr*100)/100f%></td>
<td class="btext" align="right"><%if(geprevdr==0)out.println("<center>-</center>");else out.println(Math.round(geprevdr*100)/100f);%></td>
<td class="btext" align="right"><%=Math.round(gedurdr*100)/100f %></td>
<td class="btext" align="right"><%=Math.round(gcumdr*100)/100f%></td>
<td class="btext" align="right"><%=Math.round(getotdr*100)/100f %></td>
<td class="btext" align="right"><%=gtsnodr%></td>
<td class="btext" align="right"><%=gtendr%></td>
<td class="btext" align="right"><%=gagreedr%></td>
<td class="btext" align="right"><%=ggrnddr%></td>
<td class="btext" align="right"><%=gcompdr%></td>
<td class="btext" align="right"><%=gcommdr%></td>
<td class="btext" align="right"><%=ghabcovdr%></td>
</tr>
<%}
	else if(subprogramCode!=null || subprogramCode!="")
		{
				//System.out.println("2nd drill1");
			excelnav = "3";
		try
	   {
	   //System.out.println("Report Starts");
	   %>
	   		<%@ include file="rws_worksmonitoring_progstatus_labelsecond.jsp"%>
	   <%
		String qry1=null;
			   //System.out.println("Report Starts1");
		/*if(subprogramCode.equals("00"))
		{
//			qry1="SELECT distinct w.work_id,w.work_name FROM RWS_WORK_ADMN_TBL W, RWS_SUBPROGRAMME_TBL sub WHERE SUBSTR(W.WORK_ID,1,2) ='"+programCode+"' and (sub.work_category='"+workCategory+"' and sub.programme_code='"+programCode+"') and w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) and sub.programme_code=w.programme_code and sub.subprogramme_code=w.subprogramme_code ";
	//		qry1 = "SELECT distinct w.work_id,w.work_name,w.plan_code FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,1,2) ='"+programCode+"' and SUBSTR (W.WORK_ID,3,2) ='"+subprogramCode+"' and w.ADMIN_DATE < '01-APR-2008' and w.work_id not in (select work_id from rws_work_completion_tbl) and w.category_code='"+workCategoryCode+"'";
	*/qry1 = "SELECT distinct w.work_id,w.work_name,w.plan_code FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,1,2) ='"+programCode+"' and SUBSTR (W.WORK_ID,3,2) ='"+subprogramCode+"' and w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) and w.category_code='"+workCategoryCode+"'";
	/*
		}
		else
		{*/
		qry1 = "SELECT distinct w.work_id,w.work_name,w.plan_code FROM RWS_WORK_ADMN_TBL W WHERE SUBSTR(W.WORK_ID,1,2) ='"+programCode+"' and SUBSTR (W.WORK_ID,3,2) ='"+subprogramCode+"' and w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) and w.category_code='"+workCategoryCode+"'";
	//		qry1="SELECT distinct w.work_id,w.work_name,w.plan_code FROM RWS_WORK_ADMN_TBL W, RWS_SUBPROGRAMME_TBL sub WHERE SUBSTR(W.WORK_ID,1,2) ='"+programCode+"' and W.SUBPROGRAMME_CODE='"+subprogramCode+"' and (sub.work_category='"+workCategory+"' and sub.programme_code='"+programCode+"' and sub.subprogramme_code='"+subprogramCode+"') and w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) and sub.programme_code=w.programme_code and sub.subprogramme_code=w.subprogramme_code";
		/*}*/
		//qry1 = "select work_id,work_name from rws_work_admn_tbl w,RWS_SUBPROGRAMME_TBL sub where sub.programme_code="+programCode+"  and sub.SUBPROGRAMME_CODE ="+subprogramCode+" and sub.work_category='"+workCategory+"' and w.programme_code=sub.programme_code and w.subprogramme_code=sub.subprogramme_code";
		nic.watersoft.commons.Debug.println("The Query1 in 3 is::"+qry1);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs1=stmt1.executeQuery(qry1);
		//System.out.println("Sub Programme Name::"+programName);
		
			%>	
			<tr><td class=btext colspan=3 nowrap>Sub Program - <%if(subprogramName.equals("-"))out.println(programName); else out.println(subprogramName);%></td></tr>
	<%
	String hab = "0";
	session.setAttribute("hab",hab);
		while(rs1.next())
		{
		//System.out.println("Query1 is::"+qry1);
		//System.out.println("Programme Code"+rs1.getString(1));
		//System.out.println("Subprogramme Code"+rs1.getString(2));
		%>	
		<tr onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
		<td class=rptValue><%=++slno%></td>
		<td class=rptValue><a href="work_id_report1.jsp?work_id=<%=rs1.getString(1)%>"><%=rs1.getString(1)%></a></td>
		<td class=rptValue><%=rs1.getString(2)%></td>
		<%

						String qry2=null;Statement stmt2=null;
				
						float spillamt=0,nspillamt=0,tspamt=0;
						int tspills=0,spills=0,nspills=0;
				
					try
						{
			String qry21 = "SELECT distinct CASE WHEN w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) THEN 'Y' ELSE '--' END as A_SPILL_OVER,CASE WHEN w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl) AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END AS A_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W,RWS_SUBPROGRAMME_TBL sub WHERE w.work_id='"+rs1.getString(1)+"' and sub.programme_code=w.programme_code and sub.subprogramme_code=w.subprogramme_code ";
			String qry22 = "Select distinct CASE WHEN w.ADMIN_DATE >= '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL THEN 'Y' ELSE '--' END AS A_NON_SPILL_OVER,CASE WHEN w.ADMIN_DATE >= '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN  w.SANCTION_AMOUNT ELSE 0 END AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W,RWS_SUBPROGRAMME_TBL sub where  w.work_id="+rs1.getString(1)+" and sub.programme_code=w.programme_code and sub.subprogramme_code=w.subprogramme_code ";
	 //		System.out.println("Query21 in Drill is::"+qry21);
	 	//	System.out.println("Query22 in Drill is::"+qry22);
				 stmt21 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
 				 stmt22 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
                	rs21=stmt21.executeQuery(qry21);
                	rs22=stmt22.executeQuery(qry22);                	
					while(rs21.next()&&rs22.next())
					{
//			qry2="Select distinct CASE WHEN w.ADMIN_DATE <= '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END AS A_SPILL_OVER,CASE WHEN w.ADMIN_DATE > '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL THEN 1 ELSE 0 END AS A_NON_SPILL_OVER,CASE WHEN w.ADMIN_DATE <= '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN w.SANCTION_AMOUNT ELSE 0 END AS A_SPILL_OVER_AMT,CASE WHEN w.ADMIN_DATE > '"+financialYearFrom+"' and w.ADMIN_DATE IS NOT NULL AND w.SANCTION_AMOUNT IS NOT NULL THEN "+" w.SANCTION_AMOUNT ELSE 0 END AS A_NON_SPILL_OVER_AMT FROM RWS_WORK_ADMN_TBL W where W.WORK_ID="+rs1.getString(1)+" and W.work_category='"+workCategory+"'";

//	 stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
  //       rs2=stmt2.executeQuery(qry2);
	
//	while(rs2.next())
	//		{
//				spills=rs21.getInt(1);
		//		gspillsdrsub=gspillsdrsub+spills;
		//		nspills=rs22.getInt(1);
		//		gnspillsdrsub=gnspillsdrsub+nspills;
		//		tspills=tspills+rs21.getInt(1)+rs22.getInt(1);
		//		gtspillsdrsub=gtspillsdrsub+tspills;
				spillamt=rs21.getFloat(2);
				gspillamtdrsub=gspillamtdrsub+spillamt;
				nspillamt=rs22.getFloat(2);
				gnspillamtdrsub=gnspillamtdrsub+nspillamt;
				tspamt=tspamt+rs21.getFloat(2)+rs22.getFloat(2);
				gtspamtdrsub=gtspamtdrsub+tspamt;

			%>
		<td class=rptValue align=right><center><%=rs21.getString(1)%></center></td>
		<td class=rptValue align=right><center><%=rs22.getString(1)%></center></td>
		<td class=rptValue align=right><center>--</center></td>
		<td class=rptValue align=right><%=Math.round(spillamt*100)/100f%></td>
		<td class=rptValue align=right><%=Math.round(nspillamt*100)/100f%></td>
		<td class=rptValue align=right><%=Math.round(tspamt*100)/100f%></td>

			<% }
			}
			catch(Exception e)
			{
			e.printStackTrace();
			}
			finally
			{
			rs21.close();
			stmt21.close();
			rs22.close();
			stmt22.close();
			}
			String qry3=null;
			Statement stmt3=null;
			try
			{
			qry3="select distinct SUM(CASE WHEN R.REV_SANCTION_AMOUNT IS NOT NULL THEN  R.REV_SANCTION_AMOUNT ELSE 0 END)FROM RWS_WORK_ADMN_TBL W,RWS_REVISED_ADM_SANC_TBL R WHERE W.WORK_ID=R.WORK_ID AND R.PROGRAMME_CODE=W.PROGRAMME_CODE AND W.WORK_ID="+rs1.getString(1)+" and W.work_category='"+workCategory+"'";
//			nic.watersoft.commons.Debug.println("Query3 ios:"+qry3);
			 stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs3=stmt3.executeQuery(qry3);
            while(rs3.next())
            {
             grevamtdrsub=grevamtdrsub+rs3.getFloat(1);
            %>
            <td class=rptValue align=right><%=rs3.getFloat(1)%></td>
            <%} 
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
            
			String qry4=null;
			Statement stmt4=null;
			try
			{
			qry4 = "select distinct SUM(NO_OF_HABS) from rws_work_admn_tbl w,RWS_SUBPROGRAMME_TBL sub  where w.programme_code="+programCode+" and w.subprogramme_code="+subprogramCode+" and sub.work_category='PROJECTS' and w.programme_code=sub.programme_code and w.subprogramme_code=sub.subprogramme_code and w.WORK_ID="+rs1.getString(1)+"";
//			qry4=" Select distinct SUM(NO_OF_HABS) from rws_work_admn_tbl where WORK_ID="+rs1.getString(1)+" ";
	//		nic.watersoft.commons.Debug.println("Query 4 is : "+qry4);
			stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs4=stmt4.executeQuery(qry4);
            while(rs4.next())
            {
            ghabsandrsub=ghabsandrsub+rs4.getInt(1);
            %>
            <td class=rptValue align=right><%=rs4.getInt(1)%></td>
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
            String qry5=null;Statement stmt5=null;
			//System.out.println("Watch");
            try
            {
            qry5="SELECT distinct SUM(CASE WHEN E.EXPENDITURE_UPTO IS NOT NULL and e.year = '"+currentYearPeriod+"' THEN E.EXPENDITURE_UPTO  ELSE 0 END),SUM(CASE WHEN E.EXPENDITURE_DURING  IS NOT NULL and e.year = '"+currentMonth+"' and e.month = '"+currentMonth+"' THEN  E.EXPENDITURE_DURING  ELSE 0 END),SUM(CASE WHEN E1.EXPENDITURE_UPTO_THE_PRE_YEAR  IS NOT NULL  THEN  E1.EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END) FROM RWS_WORK_EXPENDITURE_TBL E,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL E1,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID=E1.WORK_ID AND E.WORK_ID=E1.WORK_ID AND W.PROGRAMME_CODE=E.PROGRAMME_CODE AND W.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.WORK_ID='"+rs1.getString(1)+"'";
//            System.out.println("The Expe Query is::"+qry5);
             stmt5 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs5=stmt5.executeQuery(qry5);
            while(rs5.next())
            {
            gepreyrdrsub=gepreyrdrsub+rs5.getFloat(3);
            geprevdrsub=geprevdrsub+rs5.getFloat(1);
            gedurdrsub=gedurdrsub+rs5.getFloat(2);
            gcumdrsub=gcumdrsub+rs5.getFloat(1)+rs5.getFloat(2);
            getotdrsub=getotdrsub+rs5.getFloat(1)+rs5.getFloat(2)+rs5.getFloat(3);
            %>
            <td class=rptValue align=right><%=Math.round(rs5.getFloat(3)*100)/100f%></td>
            <td class=rptValue align=right><% if(currentMonth.equals("04"))out.println("<center>-</center>");else out.println(Math.round(rs5.getFloat(1)*100)/100f);%></td>
             <td class=rptValue align=right><%=Math.round(rs5.getFloat(2)*100)/100f%></td>
              <td class=rptValue align=right><%=Math.round((rs5.getFloat(1)+rs5.getFloat(2))*100)/100f%></td>
              <td class=rptValue align=right><%=Math.round((rs5.getFloat(1)+rs5.getFloat(2)+rs5.getFloat(3))*100)/100f%></td>
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
qry6="SELECT distinct CASE WHEN E.TS_NO IS NOT NULL THEN  'Y' ELSE '--' END FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID='"+rs1.getString(1)+"' and W.work_category='"+workCategory+"'";

			//System.out.println("Query6::"+qry6);
			stmt6 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs6=stmt6.executeQuery(qry6);
            if(rs6.next())
            {
//             gtsnodrsub=gtsnodrsub+rs6.getInt(1);
%>
            <td class=rptValue align=right><center>Y</center></td>
           <%}
           else{
           %>
            <td class=rptValue align=right><center>--</center></td>
           <%
           } 
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
	        qry7="SELECT distinct CASE WHEN CON.WORK_ID  IS NOT NULL THEN 'Y' ELSE '--' END AS CON_TENDERED,CASE WHEN CON.AGREEMENT_DATE IS NOT NULL THEN 'Y'  ELSE '--' END AS CON_AGMT_ENT FROM RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_ADMN_TBL W  "+	" WHERE W.WORK_ID=CON.WORK_ID AND CON.WORK_ID='"+rs1.getString(1)+"' and W.WORK_CATEGORY='"+workCategory+"'";
			stmt7= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs7=stmt7.executeQuery(qry7);
            if(rs7.next())
            {
//            gtendrsub=gtendrsub+rs7.getInt(1);
  //          gagreedrsub=gagreedrsub+rs7.getInt(2);
%>
            <td class=rptValue align=right><center>Y</center></td>
            <td class=rptValue align=right><center>Y</center></td>
           <%}else
           {
           %>
            <td class=rptValue align=right><center>--</center></td>
            <td class=rptValue align=right><center>--</center></td>
           <%
           }  
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
            qry8="SELECT distinct CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN  'Y' ELSE '--' END FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W  WHERE W.WORK_ID=G.WORK_ID AND G.WORK_ID='"+rs1.getString(2)+"' and W.WORK_CATEGORY='"+workCategory+"'";
            stmt8= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs8=stmt8.executeQuery(qry8);
            if(rs8.next())
            {
    //        ggrnddrsub=ggrnddrsub+rs8.getInt(1);
           %>
            <td class=rptValue align=right><center>Y</center></td>
            <%}
            else
            {%>
            <td class=rptValue align=right><center>--</center></td>
            <%
            }  
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
            qry9="SELECT distinct CASE WHEN WC.work_id IS NOT NULL THEN  'Y' ELSE '--' END,CASE WHEN WC.DATE_OF_COMM IS NOT NULL THEN  'Y' ELSE '--' END FROM RWS_WORK_COMPLETION_TBL WC,RWS_WORK_ADMN_TBL W  "+" WHERE W.WORK_ID=WC.WORK_ID AND WC.WORK_ID='"+rs1.getString(1)+"' and W.plan_code='"+rs1.getString(3)+"'";
            //System.out.println("Query 9 is:"+qry9);
            stmt9= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs9=stmt9.executeQuery(qry9);
            if(rs9.next())
            {
//            gcompdrsub=gcompdr+rs9.getInt(1);
  //          gcommdrsub=gcommdr+rs9.getInt(2);
            %>
            <td class=rptValue align=right><center>Y</center></td>
             <td class=rptValue align=right><center>Y</center></td>
            <%}
            else
            {%>
            <td class=rptValue align=right><center>--</center></td>
             <td class=rptValue align=right><center>--</center></td>
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
			qry10="SELECT distinct count(distinct(hab_code))FROM RWS_EST_NEW_HAB_LNK_TBL E,RWS_WORK_ADMN_TBL W  "+" WHERE W.WORK_ID=E.WORK_ID AND E.WORK_ID='"+rs1.getString(1)+"' and W.WORK_CATEGORY='"+workCategory+"'";
//			System.out.println("The Query 10 is:"+qry10);
		    stmt10= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
             rs10=stmt10.executeQuery(qry10);
            if(rs10.next())
            {
//            ghabcovdrsub=ghabcovdr+rs10.getInt(1);
		
            %>
            <td class=rptValue align=right><%=rs10.getInt(1)%></td>
                       <%  }
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
                                                //System.out.println("watch0");
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
}
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
session.setAttribute("excelnav",excelnav);
%>
</table>
<p align=left><font color=brown face=verdana size=2><b>
Note: Completed Works is inclusive of the works taken up in the 
      current financial year.</b></font>
      </p>
</form>
<%@ include file = "footer.jsp" %>
</body>
</html>
