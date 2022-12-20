<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal"%>
<%@ page import="nic.watersoft.commons.AAPreport1"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData1" class="nic.watersoft.works.WorksData1" />



<script language="JavaScript"
	src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>


<script language="JavaScript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
</script>

<%

	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	DecimalFormat ndf = new DecimalFormat("####.##");
	DecimalFormat ndf1 = new DecimalFormat("##.##");
	String financialstartyr = "";

	double aas = 0;
	String pname = "";
	if (request.getParameter("pname") != null) {
		pname = request.getParameter("pname");
		session.setAttribute("pname", pname);
	}

	if (request.getParameter("finyear") != null) {
		financialstartyr = request.getParameter("finyear");
	}

	session.setAttribute("financialyr", financialstartyr);
	//////System.out.println("Changing");
	//schemes
	String scheme = "";
	if (request.getParameterValues("scheme") != null) {
		String[] schemes = request.getParameterValues("scheme");

		for (int i = 0; i < schemes.length; i++) {
			scheme += schemes[i] + ",";
		}
		//////System.out.println("programe::"+programe);
		scheme = scheme.substring(0, scheme.length() - 1);
		session.setAttribute("scheme", scheme);
		session.setAttribute("schemes",schemes);
	}
String lpcdrange=request.getParameter("lpcdrange");
session.setAttribute("lpcdrange",lpcdrange);




	String startyr = financialstartyr.substring(0, 4);
	String endyr = financialstartyr.substring(5, 9);
	String endyr1 = financialstartyr.substring(5, 9);
	String[] programes = request.getParameterValues("program");
	 session.setAttribute("programes",programes);
    String category=request.getParameter("category");
    ////System.out.println("category is "+category);
    session.setAttribute("category",category);
	String programe = "";
	String cat = "";
	for (int i = 0; i < programes.length; i++) {
		programe += programes[i] + ",";
	}
	
	//////System.out.println("programe::"+programe);
	programe = programe.substring(0, programe.length() - 1);
	
	session.setAttribute("programe", programe);
	
	//////System.out.println("programe::"+programe);

	
	int prevyear = 0, prevmon = 0;
	String fyear, fyear1;
	prevyear=Integer.parseInt(startyr)-1;
	String prevsyear=Integer.toString(prevyear);
	String prevmonth = RwsUtils.getPreviousMonth().toUpperCase();
	String cmonth = RwsUtils.getCurrentMont().toUpperCase();
	String nextmonth = RwsUtils.getNextMonth().toUpperCase();

	
	
	String sysdate = workData1.getDate();
	String sysmon = sysdate.substring(3, 5);
	int mon = Integer.parseInt(sysmon);
	//System.out.println("sysdate::"+sysdate);
	String sysyear = sysdate.substring(6, 10);
	int yy = Integer.parseInt(sysyear);
    System.out.println("startyr"+startyr);
	System.out.println("sysyear::"+sysyear);
	if (startyr.equals(sysyear) && cmonth.equals("APR")) {
		prevmonth = cmonth;
	}
	String startyr2 = "";
	java.util.Date d = new java.util.Date();
	if (d.getMonth() >= 3 && d.getMonth() <= 11) {
		endyr1 = startyr;

	} else {
		endyr1 = endyr;
	}

	System.out.println("Startyr:"+startyr);
	System.out.println("Startyr2:"+startyr2 );
	System.out.println("Endyr:"+endyr );

	System.out.println("Endyr2:"+endyr1);

	System.out.println("Get Cuurent MOnth:"+d.getMonth());

	String dcode = request.getParameter("district");
	String divCode = request.getParameter("divCode");

	if (dcode != null && !dcode.equals("")) {
		session.setAttribute("dcode", dcode);
		session.setAttribute("divCode", divCode);
	}
	String currentyr=(Integer.parseInt(startyr))+"-"+(Integer.parseInt(endyr));
	System.out.println("currentyr"+currentyr);
	String targetyr=(Integer.parseInt(startyr)+1)+"-"+(Integer.parseInt(endyr)+1);
	System.out.println("targetyr"+targetyr);
	
	String targetnextyr=(Integer.parseInt(startyr)+2)+"-"+(Integer.parseInt(endyr)+2);
	System.out.println("targetnextyr"+targetnextyr);
	
	String nexttonectnextyr=(Integer.parseInt(startyr)+3)+"-"+(Integer.parseInt(endyr)+3);
	System.out.println("targetnextyr"+nexttonectnextyr);
	
	String thisyr=startyr+"-"+endyr;
	 String probstrng="";
	 System.out.println("financialstarty anupamr"+financialstartyr);
	   if(financialstartyr.equals(currentyr)){
		   
		 
		   probstrng="PROB_EXP_NXT_YR";  
	   }
	if(financialstartyr.equals(targetyr)){
		probstrng="PROB_EXP_NXT_YR1";   
	   }
	if(financialstartyr.equals(targetnextyr)){
		probstrng="PROB_EXP_NXT_YR2";   
	}
	if(financialstartyr.equals(nexttonectnextyr)){
		probstrng="empty";   
	}
	
	String nxtstartyr=Integer.toString(Integer.parseInt(startyr)+1);
	String nxtendyr=Integer.toString(Integer.parseInt(endyr)+1);
	
	System.out.println("nxtstartyr"+nxtstartyr);
	System.out.println("nxtendyr"+nxtendyr);
	
	
	
	
	
	int currnnext=Integer.parseInt(sysyear)+1;
	System.out.println("currnnext"+currnnext);
	
	int currnnextnext=currnnext+1;
	
%>

<body>

<table border=0 cellspacing=0 cellpadding=0 width="60%"
	style="border-collapse: collapse">
	<caption>
	<table border=0 rules=none style="border-collapse: collapse"
		align="right">


		<%
			//1 PROJECTS (mvs)
			//2 NORMAL   (svs)
			if (loggedUser != null && !loggedUser.equals(Constants.SEC_USER)) {
		%>
		<tr>
			<td align="right" class="bwborder"><a
				href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
			<td class="bwborder"><a href="./rws_aap_frm1.jsp">Back|</a><a href="./rws_aap_lpcd_excel.jsp">Excel</a>
		</tr>


		<%
			}
		%>
	</table>
	</caption>
	
	<tr>
		<td class="bwborder" align="center"><font color="red"><b></b></font></td>
	</tr>
</table>
<table border=1 cellspacing=0 cellpadding=0 width="60%"
	bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff"
	align="center">
	<tr>
		<td align="center" class="gridhdbg" colspan="10">AAP Report (All Schemes) for(<%=sysyear%>-<%=currnnext%>)</td>
	</tr>
	<tr>
	
		
	<td align="center" class="gridhdbg" rowspan="2">Status</td>
	<td align="center" class="gridhdbg" rowspan="2">Type</td>
<td align="center" class="gridhdbg" rowspan="1" colspan="6">Habitations-Physical</td>
<td align="center" class="gridhdbg" rowspan="1" colspan="2">Financial(Rs. Lakhs)</td>
	
	</tr>
	<tr>
	<td align="center" class="gridhdbg">Habs As on 01/04/<%=sysyear%></td>
	<td align="center" class="gridhdbg">Population</td>
	<td align="center" class="gridhdbg">Achmt. During <%=financialstartyr%> (so far)</td>
	<td align="center" class="gridhdbg">Anticipated Achmt. During <%=sysyear%></td>
		<td align="center" class="gridhdbg">Achmt. During <%=currnnext%></td>
	
	<td align="center" class="gridhdbg">Target 2014-15(To be completed)</td>
	<td align="center" class="gridhdbg">Est. Cost of Schemes</td>
	<td align="center" class="gridhdbg">Probable Exp. During <%=sysyear%>-<%=currnnext%></td>
	</tr>
<tr>
	<%for(int i=1;i<11;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%
		
	} %>
	</tr>
	<%
		Statement stmt1=null,stmt2 = null, stmt3 = null,stmt4=null,stmt5=null,stmt6=null,stmt7 = null,stmt8=null,stmt9=null;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null, rs9 = null, rs10 = null, rs11 = null, rs12 = null, rs13 = null, rs14 = null, rs15 = null,rs16=null,rs17=null,rs18=null,rs19=null,rs20=null,rs21=null,rs22=null, rs23= null, rs24 = null, rs25 = null,rs26 = null,rs27 = null, rs28 = null,rs29 = null,rs30 = null,rs31 = null,rs32 = null,rs33 = null,rs34 = null,rs35 = null,rs36 = null,rs37=null,rs38=null,rs39=null,rs40=null;
		ArrayList aapdetails=new ArrayList();
		AAPreport1 aapbean=null;
		String temp="",dname="";
		
		try {
			
			//////System.out.println("jc4 is "+jc);

			//////System.out.println("lpcd range is "+lpcdrange);
			
			String estcostqry="select work_id,nvl(PROB_EXP_NXT_YR,0) from rws_work_admn_tbl where  work_cancel_dt is null  and to_date(TARGET_DATE_COMP)>='01-Apr-"+currnnext+"' and to_date(TARGET_DATE_COMP)<='31-Mar-"+currnnextnext+"' ";
			if(dcode!=null && !dcode.equals("00")){
				estcostqry+=" and substr(work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				estcostqry+=" and type_of_asset in("+scheme+") ";
			}
			estcostqry+=" and substr(work_id,1,2) in ("+programe+") order by  substr(work_id,5,2) ";
			System.out.println("estcostqry is "+estcostqry);
			Hashtable wrk_est_prob_hash = new Hashtable();

			
			stmt1=conn.createStatement();
			if(!probstrng.equals("empty")){
				rs12=stmt1.executeQuery(estcostqry);	
			
			
			while(rs12.next()){
				wrk_est_prob_hash.put(rs12.getString(1),rs12.getString(2));	
			}
			}
			if(stmt1!=null)
			{
				stmt1.close();
			}
			if(rs12!=null)
			{
				rs12.close();
			}
			String sancostqry="select work_id,nvl(sanction_amount,0) from rws_work_admn_tbl where  work_cancel_dt is null  and work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+sysyear+"'))  ";
			if(dcode!=null && !dcode.equals("00")){
				sancostqry+=" and substr(work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				sancostqry+=" and type_of_asset in("+scheme+") ";
			}
			sancostqry+=" and substr(work_id,1,2) in ("+programe+") order by  substr(work_id,5,2) ";
	    System.out.println("sancostqry is "+sancostqry);
			Hashtable wrk_san_prob_hash = new Hashtable();

			
			stmt1=conn.createStatement();
			rs12=stmt1.executeQuery(sancostqry);
			while(rs12.next()){
				wrk_san_prob_hash.put(rs12.getString(1),rs12.getString(2));	
			}
			
			if(stmt1!=null)
			{
				stmt1.close();
			}
			if(rs12!=null)
			{
				rs12.close();
			}
			///population
			String populationqry="select a.work_id,sum(nvl(CENSUS_PLAIN_POPU,0)),sum(nvl(CENSUS_SC_POPU,0)),sum(nvl(CENSUS_ST_POPU,0)) from RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where a.work_id=b.work_id and  b.hab_code=c.hab_code and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+sysyear+"')) and COVERAGE_STATUS <>'UI'  ";
			if(dcode!=null && !dcode.equals("00")){
				populationqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				populationqry+=" and type_of_asset in("+scheme+") ";
			}
			populationqry+=" and substr(a.work_id,1,2) in ("+programe+") group by a.work_id order by  substr(a.work_id,5,2) ";
			System.out.println("populationqry is "+populationqry);
			Hashtable wrk_poplation_hash = new Hashtable();
			stmt1=conn.createStatement();
			rs8=stmt1.executeQuery(populationqry);
			while(rs8.next()){
				int totalwrkpopulation=rs8.getInt(2)+rs8.getInt(3)+rs8.getInt(4);
				wrk_poplation_hash.put(rs8.getString(1),totalwrkpopulation);	
			}
			
			if(stmt1!=null)
			{
				stmt1.close();
			}
			if(rs8!=null)
			{
				rs8.close();
			}
			///expenditure
			String expendqry="select a.work_id,sum(voucher_Amt)/100000 from RWS_WORK_ADMN_TBL a ,rws_work_exp_voucher_tbl b where (to_date(admin_date) < '01-Apr-"+sysyear+"') and a.work_id=b.work_id and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+sysyear+"')) and to_date(VOUCHER_DT)>='01-Apr-"+sysyear+"' and to_date(VOUCHER_DT)<='31-Mar-"+currnnext+"' ";
			if(dcode!=null && !dcode.equals("00")){
				expendqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				expendqry+=" and type_of_asset in("+scheme+") ";
			}
			expendqry+=" and substr(a.work_id,1,2) in ("+programe+") group by a.work_id order by  substr(a.work_id,5,2) ";
			System.out.println("expendqry is "+expendqry);
			Hashtable wrk_expend_hash = new Hashtable();
			stmt1=conn.createStatement();
			rs8=stmt1.executeQuery(expendqry);
			while(rs8.next()){
				
				wrk_expend_hash.put(rs8.getString(1),rs8.getString(2));	
			}
			
			if(stmt1!=null)
			{
				stmt1.close();
			}
			if(rs8!=null)
			{
				rs8.close();
			}
			
			///expenditure dir
			String direxpendqry="select a.work_id,sum(voucher_Amt)/100000 from RWS_WORK_ADMN_TBL a ,RWS_WORK_DIRECT_VOUCHER_TBL b where (to_date(admin_date) < '01-Apr-"+sysyear+"') and a.work_id=b.work_id and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+sysyear+"')) and to_date(VOUCHER_DT)>='01-Apr-"+sysyear+"' and to_date(VOUCHER_DT)<='31-Mar-"+currnnext+"' ";
			if(dcode!=null && !dcode.equals("00")){
				direxpendqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				direxpendqry+=" and type_of_asset in("+scheme+") ";
			}
			direxpendqry+=" and substr(a.work_id,1,2) in ("+programe+") group by a.work_id order by  substr(a.work_id,5,2) ";
			System.out.println("expendqry is "+expendqry);
			Hashtable dirwrk_expend_hash = new Hashtable();
			stmt1=conn.createStatement();
			rs8=stmt1.executeQuery(direxpendqry);
			while(rs8.next()){
				
				dirwrk_expend_hash.put(rs8.getString(1),rs8.getString(2));	
			}
			
			if(stmt1!=null)
			{
				stmt1.close();
			}
			if(rs8!=null)
			{
				rs8.close();
			}
			//qa
					stmt3=conn.createStatement();
	
			String mainQueryqa="SELECT distinct a.work_id, nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),b.hab_code,nvl(total_water_supply,0)  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and  b.hab_code=c.hab_code and c.hab_code=d.hab_code and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+sysyear+"')) and COVERAGE_STATUS <>'UI' ";
			
			 
			if(dcode!=null && !dcode.equals("00")){
				mainQueryqa+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				mainQueryqa+=" and a.type_of_asset in("+scheme+") ";
			}
			mainQueryqa+=" and substr(a.work_id,1,2) in ("+programe+") order by  b.hab_code";

			
			
			
			System.out.println("Main query............"+mainQueryqa);
 int recCount=0;
			rs2=stmt3.executeQuery(mainQueryqa);
			while(rs2.next()){
				int total_pop=rs2.getInt(2)+rs2.getInt(3)+rs2.getInt(4);
				
				double water_supply=rs2.getDouble(6);
				double lpcd=water_supply/total_pop;
				double san_amnt=0.0,est_amnt=0.0,prob_expend=0.0,expend_befor=0.0,habshare=0.0,habprobshare=0.0,scper=0.0,totPop=0.0,stper=0.0,plainper=0.0,plainPop=0.0,scPop=0.0,stPop=0.0;
				int totalwrkpop=0;
				String habtype="";
				//////System.out.println("habcode is "+rs2.getString(5)+" and scpop is "+rs2.getInt(3)+" stpop is "+rs2.getInt(4)+" plainpop is "+rs2.getInt(2));
				plainPop=Double.parseDouble(rs2.getString(2));
				scPop=Double.parseDouble(rs2.getString(3));
				stPop=Double.parseDouble(rs2.getString(4));
				totPop=plainPop+scPop+stPop;
				plainper = (plainPop * 100/ totPop);
				scper = (scPop * 100/ totPop);
				stper = (stPop * 100/ totPop);
				
				
				if(recCount>0){
					int r=recCount-1;
					AAPreport1 aap=(AAPreport1)aapdetails.get(r);
					if(aap!=null && aap.getHabcode()!=null && aap.getHabcode().equals(rs2.getString(5))){
						continue;
					}
					}
				
				if(scper>=40.0){
					habtype+="SC";	
				}
				if(stper>=40.0){
					habtype+="ST";	
				}
				if(plainper>=40.0){
					habtype+="P";	
				}
				//////System.out.println("habcode is "+rs2.getString(5)+" and scper is "+scper+" stper is "+stper+" plainper is "+plainper);
				  if(wrk_est_prob_hash.get(rs2.getString(1))!=null){
	            	 
	          		
	          		prob_expend=Double.parseDouble((String) wrk_est_prob_hash.get(rs2.getString(1)));
	               }
				  if(wrk_san_prob_hash.get(rs2.getString(1))!=null){
	            	  
	          		san_amnt=Double.parseDouble((String) wrk_san_prob_hash.get(rs2.getString(1)));
	          		
	               }
	              if(wrk_poplation_hash.get(rs2.getString(1))!=null){
	            	  totalwrkpop=(Integer)wrk_poplation_hash.get(rs2.getString(1));
	              }
	              if(wrk_expend_hash.get(rs2.getString(1))!=null){
	            	    expend_befor=Double.parseDouble((String)wrk_expend_hash.get(rs2.getString(1)));
	              }
	              if(dirwrk_expend_hash.get(rs2.getString(1))!=null){
	            	    expend_befor+=Double.parseDouble((String)dirwrk_expend_hash.get(rs2.getString(1)));
	              }
	              est_amnt=san_amnt-expend_befor;
	              ////System.out.println("est_amnt:"+est_amnt);
	              ////System.out.println("san_amnt:"+san_amnt);////System.out.println("expend_befor:"+expend_befor);
	              
	              if(est_amnt>0 && total_pop>0 && totalwrkpop>0){
	              habshare=(est_amnt*total_pop)/totalwrkpop;
	              }else{
	            	  habshare=0;
	              }
	              
	              if(totalwrkpop>0 && prob_expend>0 && total_pop>0){
	              habprobshare=(prob_expend*total_pop)/totalwrkpop;
	              }else{
	            	  habprobshare=0;
	              }
				//////System.out.println("QA lpcd range is i.e "+water_supply+"/"+total_pop+"="+lpcd);
				//////System.out.println("habcode is "+rs2.getString(5)+" and habtype is "+habtype);
				 if(lpcdrange.equals("40")){
						
						//lpcd40
						if(lpcd>40){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs2.getString(1));
							aapbean.setHabcode(rs2.getString(5));
							aapbean.setStatus("FC");
							aapbean.setType("QA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
							recCount++;
							
							}
						if(lpcd==0){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs2.getString(1));
							aapbean.setHabcode(rs2.getString(5));
							aapbean.setStatus("NC");
							aapbean.setType("QA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
							recCount++;
							}
						if(lpcd>0 && lpcd<=10){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs2.getString(1));
							aapbean.setHabcode(rs2.getString(5));
							aapbean.setStatus("PC1");
							aapbean.setType("QA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
							recCount++;
							}
						if(lpcd>10 && lpcd<=20){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs2.getString(1));
							aapbean.setHabcode(rs2.getString(5));
							aapbean.setStatus("PC2");
							aapbean.setType("QA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
							recCount++;
							
							}
						if(lpcd>20 && lpcd<=30){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs2.getString(1));
							aapbean.setHabcode(rs2.getString(5));
							aapbean.setStatus("PC3");
							aapbean.setType("QA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
							recCount++;
							}
						if(lpcd>30 && lpcd<=40){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs2.getString(1));
							aapbean.setHabcode(rs2.getString(5));
							aapbean.setStatus("PC4");
							aapbean.setType("QA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
							recCount++;
							}
					}
					
					
					//lpcd55
					if(lpcdrange.equals("55")){
					if(lpcd>55){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs2.getString(1));
						aapbean.setHabcode(rs2.getString(5));
						aapbean.setStatus("FC");
						aapbean.setType("QA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
						}
					if(lpcd==0){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs2.getString(1));
						aapbean.setHabcode(rs2.getString(5));
						aapbean.setStatus("NC");
						aapbean.setType("QA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
						}
					if(lpcd>0 && lpcd<=13.25){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs2.getString(1));
						aapbean.setHabcode(rs2.getString(5));
						aapbean.setStatus("PC1");
						aapbean.setType("QA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
						}
					if(lpcd>13.25 && lpcd<=27.5){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs2.getString(1));
						aapbean.setHabcode(rs2.getString(5));
						aapbean.setStatus("PC2");
						aapbean.setType("QA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
						}
					if(lpcd>27.5 && lpcd<=41.25){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs2.getString(1));
						aapbean.setHabcode(rs2.getString(5));
						aapbean.setStatus("PC3");
						aapbean.setType("QA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
						}
					if(lpcd>41.25 && lpcd<=55){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs2.getString(1));
						aapbean.setHabcode(rs2.getString(5));
						aapbean.setStatus("PC4");
						aapbean.setType("QA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
						}
				
					}
				}
			
			if(stmt3!=null)
			{
				stmt3.close();
			}
			if(rs2!=null)
			{
				rs2.close();
			}
			
			
			///nqa
			String mainQuerynqa="select distinct a.work_id, CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU,b.hab_code,total_water_supply  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c  where a.work_id=b.work_id and  b.hab_code=c.hab_code and c.hab_code not in(select hab_code from RWS_HAB_CONTAMINATION_TBL)  and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and COVERAGE_STATUS <>'UI' ";
			 
			if(dcode!=null && !dcode.equals("00")){
				mainQuerynqa+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}

			if(scheme!=null && !scheme.equals(""))
			{
				mainQuerynqa+=" and a.type_of_asset in("+scheme+")";
			}
			
			mainQuerynqa+=" and substr(a.work_id,1,2) in ("+programe+") order by  b.hab_code ";

			//////System.out.println("Main query............"+mainQuerynqa);

			stmt6=conn.createStatement();

			rs3=stmt6.executeQuery(mainQuerynqa);
		
			while(rs3.next()){
				int total_pop=rs3.getInt(2)+rs3.getInt(3)+rs3.getInt(4);
				double water_supply=rs3.getDouble(6);
				double lpcd=water_supply/total_pop;
				//////System.out.println("NQA lpcd range is i.e "+water_supply+"/"+total_pop+"="+lpcd);
				double san_amnt=0.0,est_amnt=0.0,prob_expend=0.0,expend_befor=0.0,habshare=0.0,habprobshare=0.0,scper=0.0,totPop=0.0,stper=0.0,plainper=0.0,plainPop=0.0,scPop=0.0,stPop=0.0;
				int totalwrkpop=0;
				String habtype="";
				//////System.out.println("habcode is "+rs2.getString(5)+" and scpop is "+rs2.getInt(3)+" stpop is "+rs2.getInt(4)+" plainpop is "+rs2.getInt(2));
				plainPop=Double.parseDouble(rs3.getString(2));
				scPop=Double.parseDouble(rs3.getString(3));
				stPop=Double.parseDouble(rs3.getString(4));
				totPop=plainPop+scPop+stPop;
				plainper = (plainPop * 100/ totPop);
				scper = (scPop * 100/ totPop);
				stper = (stPop * 100/ totPop);
				
				if(recCount>0){
				int r=recCount-1;
				AAPreport1 aap=(AAPreport1)aapdetails.get(r);
				if(aap!=null && aap.getHabcode()!=null && aap.getHabcode().equals(rs3.getString(5))){
					continue;
				}
				}
				
				
				if(scper>=40.0){
					habtype+="SC";	
				}
				if(stper>=40.0){
					habtype+="ST";	
				}
				if(plainper>=40.0){
					habtype+="P";	
				}
				//////System.out.println("habcode is "+rs3.getString(5)+" and scper is "+scper+" stper is "+stper+" plainper is "+plainper);
				 if(wrk_est_prob_hash.get(rs3.getString(1))!=null){
	            	 
		          		
		          		prob_expend=Double.parseDouble((String) wrk_est_prob_hash.get(rs3.getString(1)));
		               }
					  if(wrk_san_prob_hash.get(rs3.getString(1))!=null){
		            	  
		          		san_amnt=Double.parseDouble((String) wrk_san_prob_hash.get(rs3.getString(1)));
		          		
		               }
	              if(wrk_poplation_hash.get(rs3.getString(1))!=null){
	            	  totalwrkpop=(Integer)wrk_poplation_hash.get(rs3.getString(1));
	              }
	              if(wrk_expend_hash.get(rs3.getString(1))!=null){
	            	  expend_befor=Double.parseDouble((String)wrk_expend_hash.get(rs3.getString(1)));
	              }
	              if(dirwrk_expend_hash.get(rs3.getString(1))!=null){
	            	    expend_befor+=Double.parseDouble((String)dirwrk_expend_hash.get(rs3.getString(1)));
	              }
	              est_amnt=san_amnt-expend_befor;
	              
	              
	              if(est_amnt>0 && total_pop>0 && totalwrkpop>0){
		              habshare=(est_amnt*total_pop)/totalwrkpop;
		              }else{
		            	  habshare=0;
		              }
		              
		              if(totalwrkpop>0 && prob_expend>0 && total_pop>0){
		              habprobshare=(prob_expend*total_pop)/totalwrkpop;
		              }else{
		            	  habprobshare=0;
		              }
	           //  //////System.out.println("habcode is "+rs3.getString(5)+" and habtype is "+habtype);
	             if(lpcdrange.equals("40")){
						
						//lpcd40
	            	 if(lpcd>40){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs3.getString(1));
							aapbean.setHabcode(rs3.getString(5));
							aapbean.setStatus("FC");
							aapbean.setType("NQA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							recCount++;
							aapdetails.add(aapbean);
							
							}
						if(lpcd==0){
							
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs3.getString(1));
							aapbean.setHabcode(rs3.getString(5));
							aapbean.setStatus("NC");
							aapbean.setType("NQA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
							recCount++;
						
							}
						if(lpcd>0 && lpcd<=10){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs3.getString(1));
							aapbean.setHabcode(rs3.getString(5));
							aapbean.setStatus("PC1");
							aapbean.setType("NQA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
						
							recCount++;
							}
						if(lpcd>10 && lpcd<=20){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs3.getString(1));
							aapbean.setHabcode(rs3.getString(5));
							aapbean.setStatus("PC2");
							aapbean.setType("NQA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
							recCount++;
							
							}
						if(lpcd>20 && lpcd<=30){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs3.getString(1));
							aapbean.setHabcode(rs3.getString(5));
							aapbean.setStatus("PC3");
							aapbean.setType("NQA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
							recCount++;
							
							}
						if(lpcd>30 && lpcd<=40){
							aapbean=new AAPreport1();
							aapbean.setWorkid(rs3.getString(1));
							aapbean.setHabcode(rs3.getString(5));
							aapbean.setStatus("PC4");
							aapbean.setType("NQA");
							aapbean.setSanamnt(habshare);
							aapbean.setProbamnt(habprobshare);
							aapbean.setHabtype(habtype);
							aapbean.setTotalpop(total_pop);
							aapdetails.add(aapbean);
						
							recCount++;
							}
					}
					
					
					//lpcd55
					if(lpcdrange.equals("55")){
					if(lpcd>55){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs3.getString(1));
						aapbean.setHabcode(rs3.getString(5));
						aapbean.setStatus("FC");
						aapbean.setType("NQA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
					
						}
					if(lpcd==0){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs3.getString(1));
						aapbean.setHabcode(rs3.getString(5));
						aapbean.setStatus("NC");
						aapbean.setType("NQA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
					
						recCount++;
						}
					if(lpcd>0 && lpcd<=13.25){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs3.getString(1));
						aapbean.setHabcode(rs3.getString(5));
						aapbean.setStatus("PC1");
						aapbean.setType("NQA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
						
						}
					if(lpcd>13.25 && lpcd<=27.5){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs3.getString(1));
						aapbean.setHabcode(rs3.getString(5));
						aapbean.setStatus("PC2");
						aapbean.setType("NQA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
						
						}
					if(lpcd>27.5 && lpcd<=41.25){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs3.getString(1));
						aapbean.setHabcode(rs3.getString(5));
						aapbean.setStatus("PC3");
						aapbean.setType("NQA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
						
						}
					if(lpcd>41.25 && lpcd<=55){
						aapbean=new AAPreport1();
						aapbean.setWorkid(rs3.getString(1));
						aapbean.setHabcode(rs3.getString(5));
						aapbean.setStatus("PC4");
						aapbean.setType("NQA");
						aapbean.setSanamnt(habshare);
						aapbean.setProbamnt(habprobshare);
						aapbean.setHabtype(habtype);
						aapbean.setTotalpop(total_pop);
						aapdetails.add(aapbean);
						recCount++;
						
						}
				
					}
				}
				
			
			if(stmt6!=null)
			{
				stmt6.close();
			}
			if(rs3!=null)
			{
				rs3.close();
			}
			

			///completed hab count
			String habcomptedqry="SELECT distinct a.work_id,b.hab_code  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c,rws_work_completion_tbl d,RWS_WORK_COMP_HAB_LNK_TBL   e,rws_complete_hab_view f  where a.work_id=b.work_id and b.hab_code=e.hab_code and b.hab_code=c.hab_code   and a.work_id=d.work_id and  to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' and work_cancel_dt is null  and b.hab_code=f.panch_code  ";
			if(dcode!=null && !dcode.equals("00")){
				habcomptedqry+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}

			if(scheme!=null && !scheme.equals(""))
			{
				habcomptedqry+=" and a.type_of_asset in("+scheme+")";
			}
			
			habcomptedqry+=" and substr(a.work_id,1,2) in ("+programe+") order by  substr(a.work_id,5,2) ";

			Hashtable qa_comp_hash = new Hashtable();
			 stmt7=conn.createStatement();
			 rs10=stmt7.executeQuery(habcomptedqry);
			 //System.out.println("habcomptedqry "+habcomptedqry);
				while(rs10.next()){
					////////System.out.println(rs10.getString(2)+rs10.getString(3)+"="+rs10.getInt(1));
					qa_comp_hash.put(rs10.getString(1)+rs10.getString(2),rs10.getString(2));
				}
				if(stmt7!=null)
				{
					stmt7.close();
				}
				if(rs10!=null)
				{
					rs10.close();
				}
			///target year
			
			String habtarget="SELECT distinct a.work_id,b.hab_code FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where a.work_id=b.work_id and b.hab_code=c.hab_code  and work_cancel_dt is null and coverage_status<>'UI' and to_date(TARGET_DATE_COMP)>='01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP)<='31-Mar-"+endyr+"' and AAP_TARGET_YEAR='"+financialstartyr+"'   ";
				if(dcode!=null && !dcode.equals("00")){
					habtarget+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}

				if(scheme!=null && !scheme.equals(""))
				{
					habtarget+=" and a.type_of_asset in("+scheme+")";
				}
				
				habtarget+=" and substr(a.work_id,1,2) in ("+programe+") order by b.hab_code  ";

				////System.out.println("habtarget "+habtarget);
				
				Hashtable qa_hab_target_hash = new Hashtable();
				 stmt7=conn.createStatement();
				 rs11=stmt7.executeQuery(habtarget);
				
					while(rs11.next()){
						////////System.out.println(rs11.getString(2)+rs11.getString(3)+"="+rs11.getInt(1));
						qa_hab_target_hash.put(rs11.getString(1)+rs11.getString(2),rs11.getString(2));
					}
					if(stmt7!=null)
					{
						stmt7.close();
					}
					if(rs11!=null)
					{
						rs11.close();
					}
					String thishabtarget="SELECT distinct a.work_id,b.hab_code FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where a.work_id=b.work_id and b.hab_code=c.hab_code  and work_cancel_dt is null and coverage_status<>'UI' and to_date(TARGET_DATE_COMP)>='01-Apr-"+nxtstartyr+"' and to_date(TARGET_DATE_COMP)<='31-Mar-"+nxtendyr+"' and AAP_TARGET_YEAR='"+targetyr+"' ";
					if(dcode!=null && !dcode.equals("00")){
						thishabtarget+=" and substr(a.work_id,5,2)='"+dcode+"'";
					}

					if(scheme!=null && !scheme.equals(""))
					{
						thishabtarget+=" and a.type_of_asset in("+scheme+")";
					}
					
					thishabtarget+=" and substr(a.work_id,1,2) in ("+programe+") order by  substr(a.work_id,5,2) ";

					//////System.out.println("thishabtarget "+thishabtarget);
					
					Hashtable qa_hab_targetthis_hash = new Hashtable();
					 stmt7=conn.createStatement();
					 rs11=stmt7.executeQuery(thishabtarget);
					
						while(rs11.next()){
							//////////System.out.println(rs11.getString(2)+rs11.getString(3)+"="+rs11.getInt(1));
							qa_hab_targetthis_hash.put(rs11.getString(1)+rs11.getString(2),rs11.getString(2));
						}
						if(stmt7!=null)
						{
							stmt7.close();
						}
						if(rs11!=null)
						{
							rs11.close();
						}
					session.setAttribute("aapdetails",aapdetails);
					session.setAttribute("qa_hab_targetthis_hash",qa_hab_targetthis_hash);

					session.setAttribute("qa_comp_hash",qa_comp_hash);
					session.setAttribute("qa_hab_target_hash",qa_hab_target_hash);
			int pop_pc1_qa=0,pop_pc2_qa=0,pop_pc3_qa=0,pop_pc4_qa=0,pop_fc_qa=0,pop_nc_qa=0;
			int hab_pc1_qa=0,hab_pc2_qa=0,hab_pc3_qa=0,hab_pc4_qa=0,hab_fc_qa=0,hab_nc_qa=0;
			int pop_pc1_nqa=0,pop_pc2_nqa=0,pop_pc3_nqa=0,pop_pc4_nqa=0,pop_fc_nqa=0,pop_nc_nqa=0;
			int hab_pc1_nqa=0,hab_pc2_nqa=0,hab_pc3_nqa=0,hab_pc4_nqa=0,hab_fc_nqa=0,hab_nc_nqa=0;
			double est_pc1_qa=0.0,est_pc2_qa=0.0,est_pc3_qa=0.0,est_pc4_qa=0.0,est_fc_qa=0.0,est_nc_qa=0.0;
			double prob_pc1_qa=0.0,prob_pc2_qa=0.0,prob_pc3_qa=0.0,prob_pc4_qa=0.0,prob_fc_qa=0.0,prob_nc_qa=0.0;
			double est_pc1_nqa=0.0,est_pc2_nqa=0.0,est_pc3_nqa=0.0,est_pc4_nqa=0.0,est_fc_nqa=0.0,est_nc_nqa=0.0;
			double prob_pc1_nqa=0.0,prob_pc2_nqa=0.0,prob_pc3_nqa=0.0,prob_pc4_nqa=0.0,prob_fc_nqa=0.0,prob_nc_nqa=0.0;
			int comhab_pc1_qa=0,comhab_pc2_qa=0,comhab_pc3_qa=0,comhab_pc4_qa=0,comhab_fc_qa=0,comhab_nc_qa=0;
			int comhab_pc1_nqa=0,comhab_pc2_nqa=0,comhab_pc3_nqa=0,comhab_pc4_nqa=0,comhab_fc_nqa=0,comhab_nc_nqa=0;
			int tarhab_pc1_qa=0,tarhab_pc2_qa=0,tarhab_pc3_qa=0,tarhab_pc4_qa=0,tarhab_fc_qa=0,tarhab_nc_qa=0;
			int tarhab_pc1_nqa=0,tarhab_pc2_nqa=0,tarhab_pc3_nqa=0,tarhab_pc4_nqa=0,tarhab_fc_nqa=0,tarhab_nc_nqa=0;
			int thishab_pc1_qa=0,thishab_pc2_qa=0,thishab_pc3_qa=0,thishab_pc4_qa=0,thishab_fc_qa=0,thishab_nc_qa=0;
			int thishab_pc1_nqa=0,thishab_pc2_nqa=0,thishab_pc3_nqa=0,thishab_pc4_nqa=0,thishab_fc_nqa=0,thishab_nc_nqa=0;


			
			if(category.equals("")){		
				for(int i=0;i<aapdetails.size();i++){
					String status=((AAPreport1)aapdetails.get(i)).getStatus();
					String type=((AAPreport1)aapdetails.get(i)).getType();
					String workid=((AAPreport1)aapdetails.get(i)).getWorkid();
					String habcode=((AAPreport1)aapdetails.get(i)).getHabcode();
					if(status.equals("FC") && type.equals("QA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_fc_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							
							thishab_fc_qa+=1;
							
							
						}
                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){
							
							
							tarhab_fc_qa+=1;
							////////////System.out.println(habcode+"--->"+tarvalues[0]+"@"+tarvalues[1]);
						}
						hab_fc_qa+=1;
						pop_fc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_fc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_fc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("FC") && type.equals("NQA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_fc_nqa+=1;
						}
                       if(qa_hab_target_hash.get(workid+habcode)!=null){
						thishab_fc_nqa+=1;
							
						}
                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
							tarhab_fc_nqa+=1;
							}
						hab_fc_nqa+=1;
						pop_fc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_fc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_fc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("NC") && type.equals("QA")){
						//////System.out.println("nc work ids "+workid);
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_nc_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_nc_qa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_nc_qa+=1;
								}
						hab_nc_qa+=1;
						pop_nc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_nc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_nc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("NC") && type.equals("NQA")){
						//////System.out.println("nc work ids "+workid);
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_nc_nqa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_nc_nqa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_nc_nqa+=1;
								}
						hab_nc_nqa+=1;
						pop_nc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_nc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_nc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC1") && type.equals("QA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc1_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc1_qa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc1_qa+=1;
								}
						hab_pc1_qa+=1;
						pop_pc1_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc1_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc1_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC1") && type.equals("NQA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc1_nqa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc1_nqa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc1_nqa+=1;
								}
						hab_pc1_nqa+=1;
						pop_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC2") && type.equals("QA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc2_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc2_qa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc2_qa+=1;
								}
						hab_pc2_qa+=1;
						pop_pc2_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc2_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc2_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC2") && type.equals("NQA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc2_nqa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc2_nqa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc2_nqa+=1;
								}
						hab_pc2_nqa+=1;
						pop_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC3") && type.equals("QA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc3_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc3_qa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc3_qa+=1;
								}
						hab_pc3_qa+=1;
						pop_pc3_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc3_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc3_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC3") && type.equals("NQA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc3_nqa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc3_nqa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc3_nqa+=1;
								}
						hab_pc3_nqa+=1;
						pop_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC4") && type.equals("QA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc4_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc4_qa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc4_qa+=1;
								}
						hab_pc4_qa+=1;
						pop_pc4_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc4_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc4_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC4") && type.equals("NQA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc4_nqa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc4_nqa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc4_nqa+=1;
								}
						hab_pc4_nqa+=1;
						pop_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
				}
					}		
							
					if(category.equals("SC")){		
						for(int i=0;i<aapdetails.size();i++){
							String status=((AAPreport1)aapdetails.get(i)).getStatus();
							String type=((AAPreport1)aapdetails.get(i)).getType();
							String habtype=((AAPreport1)aapdetails.get(i)).getHabtype();
							String workid=((AAPreport1)aapdetails.get(i)).getWorkid();
							String habcode=((AAPreport1)aapdetails.get(i)).getHabcode();
							////////////System.out.println(habcode+"habtype "+habtype);
							if(status.equals("FC") && type.equals("QA") && (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_qa+=1;
										}
								hab_fc_qa+=1;
								pop_fc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("FC") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_nqa+=1;
										}
								hab_fc_nqa+=1;
								pop_fc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("QA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_qa+=1;
										}
								hab_nc_qa+=1;
								pop_nc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_nqa+=1;
										}
								hab_nc_nqa+=1;
								pop_nc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("QA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_qa+=1;
										}
								hab_pc1_qa+=1;
								pop_pc1_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_nqa+=1;
										}
								hab_pc1_nqa+=1;
								pop_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("QA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_qa+=1;
										}
								hab_pc2_qa+=1;
								pop_pc2_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_nqa+=1;
										}
								hab_pc2_nqa+=1;
								pop_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("QA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_qa+=1;
										}
								hab_pc3_qa+=1;
								pop_pc3_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_nqa+=1;
										}
								hab_pc3_nqa+=1;
								pop_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("QA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_qa+=1;
										}
								hab_pc4_qa+=1;
								pop_pc4_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_nqa+=1;
										}
								hab_pc4_nqa+=1;
								pop_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
						}
							}				
					if(category.equals("ST")){		
						for(int i=0;i<aapdetails.size();i++){
							String status=((AAPreport1)aapdetails.get(i)).getStatus();
							String type=((AAPreport1)aapdetails.get(i)).getType();
							String habtype=((AAPreport1)aapdetails.get(i)).getHabtype();
							String workid=((AAPreport1)aapdetails.get(i)).getWorkid();
							String habcode=((AAPreport1)aapdetails.get(i)).getHabcode();
							//////////System.out.println(habcode+"habtype "+habtype);
							if(status.equals("FC") && type.equals("QA") && (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_qa+=1;
										}
								hab_fc_qa+=1;
								pop_fc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("FC") && type.equals("NQA")&&(habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_nqa+=1;
										}
								hab_fc_nqa+=1;
								pop_fc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("QA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_qa+=1;
										}
								hab_nc_qa+=1;
								pop_nc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("NQA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_nqa+=1;
										}
								hab_nc_nqa+=1;
								pop_nc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("QA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_qa+=1;
										}
								hab_pc1_qa+=1;
								
								pop_pc1_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("NQA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_nqa+=1;
										}
								hab_pc1_nqa+=1;
								pop_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("QA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_qa+=1;
										}
								hab_pc2_qa+=1;
								pop_pc2_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("NQA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_nqa+=1;
										}
								hab_pc2_nqa+=1;
								pop_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("QA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_qa+=1;
										}
								hab_pc3_qa+=1;
								pop_pc3_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("NQA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_nqa+=1;
										}
								hab_pc3_nqa+=1;
								pop_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("QA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_qa+=1;
										}
								hab_pc4_qa+=1;
								pop_pc4_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("NQA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_nqa+=1;
										}
								hab_pc4_nqa+=1;
								pop_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
						}
							}	
							
					if(category.equals("P")){		
						for(int i=0;i<aapdetails.size();i++){
							String status=((AAPreport1)aapdetails.get(i)).getStatus();
							String type=((AAPreport1)aapdetails.get(i)).getType();
							String habtype=((AAPreport1)aapdetails.get(i)).getHabtype();
							String workid=((AAPreport1)aapdetails.get(i)).getWorkid();
							String habcode=((AAPreport1)aapdetails.get(i)).getHabcode();
							//////System.out.println(habcode+"habtype "+habtype);
							if(status.equals("FC") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_qa+=1;
										}
								hab_fc_qa+=1;
								pop_fc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("FC") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_nqa+=1;
										}
								hab_fc_nqa+=1;
								pop_fc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_qa+=1;
										}
								hab_nc_qa+=1;
								pop_nc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_nqa+=1;
										}
								hab_nc_nqa+=1;
								pop_nc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_qa+=1;
										}
								hab_pc1_qa+=1;
								pop_pc1_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_nqa+=1;
										}
								hab_pc1_nqa+=1;
								pop_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_qa+=1;
										}
								hab_pc2_qa+=1;
								pop_pc2_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_nqa+=1;
										}
								hab_pc2_nqa+=1;
								pop_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_qa+=1;
										}
								hab_pc3_qa+=1;
								pop_pc3_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_nqa+=1;
										}
								hab_pc3_nqa+=1;
								pop_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_qa+=1;
										}
								hab_pc4_qa+=1;
								pop_pc4_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_nqa+=1;
										}
								hab_pc4_nqa+=1;
								pop_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
						}
							}		

			
			
		
			
				
			
			
			///printing loop query
			
	


	%><tr>
	
	<td class="gridbg1" style="text-align: center;" rowspan="2">NC</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_nc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_nc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_nc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_nc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_nc_qa+comhab_nc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=tarhab_nc_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_nc_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_nc_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_nc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_nc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_nc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_nc_nqa %></td>
		<td class="gridbg1" style="text-align: right;"><%=thishab_nc_nqa+comhab_nc_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_nc_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_nc_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_nc_nqa) %></td>
	</tr>
	<tr>
	<td class="gridbg1" style="text-align: center;" rowspan="2">PC1</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_pc1_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_pc1_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_pc1_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_pc1_qa %></td>
		<td class="gridbg1" style="text-align: right;"><%=thishab_pc1_qa+comhab_pc1_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=tarhab_pc1_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_pc1_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_pc1_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_pc1_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_pc1_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_pc1_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_pc1_nqa %></td>
			<td class="gridbg1" style="text-align: right;"><%=thishab_pc1_nqa+comhab_pc1_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_pc1_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_pc1_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_pc1_nqa) %></td>
	</tr>
	<tr>
	<td class="gridbg1" style="text-align: center;" rowspan="2">PC2</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_pc2_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_pc2_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_pc2_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_pc2_qa %></td>
			<td class="gridbg1" style="text-align: right;"><%=thishab_pc2_qa+comhab_pc2_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=tarhab_pc2_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_pc2_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_pc2_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_pc2_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_pc2_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_pc2_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_pc2_nqa %></td>
				<td class="gridbg1" style="text-align: right;"><%=thishab_pc2_nqa+comhab_pc2_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_pc2_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_pc2_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_pc2_nqa) %></td>
	</tr>
	<tr>
	<td class="gridbg1" style="text-align: center;" rowspan="2">PC3</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_pc3_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_pc3_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_pc3_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_pc3_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_pc3_qa+comhab_pc3_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=tarhab_pc3_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_pc3_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_pc3_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_pc3_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_pc3_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_pc3_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_pc3_nqa %></td>
		<td class="gridbg1" style="text-align: right;"><%=thishab_pc3_nqa+comhab_pc3_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_pc3_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_pc3_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_pc3_nqa) %></td>
	</tr>
	<tr>
	<td class="gridbg1" style="text-align: center;" rowspan="2">PC4</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_pc4_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_pc4_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_pc4_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_pc4_qa %></td>
		<td class="gridbg1" style="text-align: right;"><%=thishab_pc4_qa+comhab_pc4_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=tarhab_pc4_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_pc4_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_pc4_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_pc4_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_pc4_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_pc4_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_pc4_nqa %></td>
			<td class="gridbg1" style="text-align: right;"><%=thishab_pc4_nqa+comhab_pc4_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_pc4_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_pc4_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_pc4_nqa) %></td>
	</tr>
	<tr>
	<td class="gridbg1" style="text-align: center;" rowspan="2">FC</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_fc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_fc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_fc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_fc_qa %></td>
			<td class="gridbg1" style="text-align: right;"><%=thishab_fc_qa+comhab_fc_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=tarhab_fc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_fc_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_fc_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_fc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_fc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_fc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_fc_nqa %></td>
				<td class="gridbg1" style="text-align: right;"><%=thishab_fc_nqa+comhab_fc_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_fc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_fc_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_fc_nqa) %></td>
	</tr>
	<tr>
	<td class="gridhdbg" style="text-align: center;" rowspan="2">TOTAL</td>
	<td class="gridhdbg" style="text-align: center;">QA</td>
	<td class="gridhdbg" style="text-align: right;"><%=hab_nc_qa+hab_pc1_qa+hab_pc2_qa+hab_pc3_qa+hab_pc4_qa+hab_fc_qa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=pop_nc_qa+pop_pc1_qa+pop_pc2_qa+pop_pc3_qa+pop_pc4_qa+pop_fc_qa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=comhab_nc_qa+comhab_pc1_qa+comhab_pc2_qa+comhab_pc3_qa+comhab_pc4_qa+comhab_fc_qa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=thishab_nc_qa+thishab_pc1_qa+thishab_pc2_qa+thishab_pc3_qa+thishab_pc4_qa+thishab_fc_qa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=thishab_nc_qa+thishab_pc1_qa+thishab_pc2_qa+thishab_pc3_qa+thishab_pc4_qa+thishab_fc_qa+comhab_nc_qa+comhab_pc1_qa+comhab_pc2_qa+comhab_pc3_qa+comhab_pc4_qa+comhab_fc_qa %></td>
	
	<td class="gridhdbg" style="text-align: right;"><%=tarhab_nc_qa+tarhab_pc1_qa+tarhab_pc2_qa+tarhab_pc3_qa+tarhab_pc4_qa+tarhab_fc_qa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=ndf.format(est_nc_qa+est_pc1_qa+est_pc2_qa+est_pc3_qa+est_pc4_qa+est_fc_qa) %></td>
	<td class="gridhdbg" style="text-align: right;"><%=ndf.format(prob_nc_qa+prob_pc1_qa+prob_pc2_qa+prob_pc3_qa+prob_pc4_qa+prob_fc_qa) %></td>
	</tr>
	<tr>
	<td class="gridhdbg" style="text-align: center;">NQA</td>
	<td class="gridhdbg" style="text-align: right;"><%=hab_nc_nqa+hab_pc1_nqa+hab_pc2_nqa+hab_pc3_nqa+hab_pc4_nqa+hab_fc_nqa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=pop_nc_nqa+pop_pc1_nqa+pop_pc2_nqa+pop_pc3_nqa+pop_pc4_nqa+pop_fc_nqa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=comhab_nc_nqa+comhab_pc1_nqa+comhab_pc2_nqa+comhab_pc3_nqa+comhab_pc4_nqa+comhab_fc_nqa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=thishab_nc_nqa+thishab_pc1_nqa+thishab_pc2_nqa+thishab_pc3_nqa+thishab_pc4_nqa+thishab_fc_nqa %></td>
					<td class="gridhdbg" style="text-align: right;"><%=thishab_nc_nqa+thishab_pc1_nqa+thishab_pc2_nqa+thishab_pc3_nqa+thishab_pc4_nqa+thishab_fc_nqa+comhab_nc_nqa+comhab_pc1_nqa+comhab_pc2_nqa+comhab_pc3_nqa+comhab_pc4_nqa+comhab_fc_nqa %></td>
	
	<td class="gridhdbg" style="text-align: right;"><%=tarhab_nc_nqa+tarhab_pc1_nqa+tarhab_pc2_nqa+tarhab_pc3_nqa+tarhab_pc4_nqa+tarhab_fc_nqa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=ndf.format(est_nc_nqa+est_pc1_nqa+est_pc2_nqa+est_pc3_nqa+est_pc4_nqa+est_fc_nqa) %></td>
	<td class="gridhdbg" style="text-align: right;"><%=ndf.format(prob_nc_nqa+prob_pc1_nqa+prob_pc2_nqa+prob_pc3_nqa+prob_pc4_nqa+prob_fc_nqa) %></td>
	</tr>
	<%
	
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</table>
</body>
</html>
<%@ include file="/commons/rws_footer.jsp"%>