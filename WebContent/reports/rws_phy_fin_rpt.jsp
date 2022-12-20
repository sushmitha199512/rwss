<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal"%>
<%@ include file="conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />



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
	System.out.println("Changing");
	//schemes
	String scheme = "";
	if (request.getParameterValues("scheme") != null) {
		String[] schemes = request.getParameterValues("scheme");

		for (int i = 0; i < schemes.length; i++) {
			scheme += schemes[i] + ",";
		}
		//System.out.println("programe::"+programe);
		scheme = scheme.substring(0, scheme.length() - 1);
		session.setAttribute("scheme", scheme);
	}

	String startyr = financialstartyr.substring(0, 4);
	String endyr = financialstartyr.substring(5, 9);
	String endyr1 = financialstartyr.substring(5, 9);
	String[] programes = request.getParameterValues("program");
    String category=request.getParameter("category");
	String programe = "";
	String cat = "";
	for (int i = 0; i < programes.length; i++) {
		programe += programes[i] + ",";
	}
	
	//System.out.println("programe::"+programe);
	programe = programe.substring(0, programe.length() - 1);
	
	session.setAttribute("programe", programe);
	
	//System.out.println("programe::"+programe);

	String sysdate = workData.getDate();
	String sysmon = sysdate.substring(3, 5);
	int mon = Integer.parseInt(sysmon);
	//System.out.println("sysdate::"+sysdate);
	String sysyear = sysdate.substring(6, 10);
	int yy = Integer.parseInt(sysyear);
	//System.out.println("startyr"+startyr);
	//System.out.println("sysyear::"+sysyear);
	int prevyear = 0, prevmon = 0;
	String fyear, fyear1;
	prevyear=Integer.parseInt(startyr)-1;
	String prevsyear=Integer.toString(prevyear);
	String prevmonth = RwsUtils.getPreviousMonth().toUpperCase();
	String cmonth = RwsUtils.getCurrentMont().toUpperCase();
	String nextmonth = RwsUtils.getNextMonth().toUpperCase();

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

	//System.out.println("Startyr:"+startyr);
	//System.out.println("Startyr2:"+startyr2 );
	//System.out.println("Endyr:"+endyr );

	//System.out.println("Endyr2:"+endyr1);

	//System.out.println("Get Cuurent MOnth:"+d.getMonth());

	String dcode = request.getParameter("district");
	String divCode = request.getParameter("divCode");

	if (dcode != null && !dcode.equals("")) {
		session.setAttribute("dcode", dcode);
		session.setAttribute("divCode", divCode);
	}

	//System.out.println("dcode"+dcode);
	//System.out.println("DivCode"+divCode);
%>

<body>

<table border=0 cellspacing=0 cellpadding=0 width="80%"
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
			<td class="bwborder"><a href="./rws_phy_fin_frm.jsp">Back|</a>
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
<table border=1 cellspacing=0 cellpadding=0 width="80%"
	bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff"
	align="center">
	<tr>
		<td align="center" class="gridhdbg" colspan="36">Physical and
		Financial Report for(<%=financialstartyr%>)--<%=pname%> .</td>
	</tr>
	<tr>
	<td align="center" class="gridhdbg" rowspan="4">Sl.No</td>
	<td align="center" class="gridhdbg" rowspan="4">District</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="2">Other than sub plan</td>
	<td align="center" class="gridhdbg" rowspan="4">Works</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="3">Habs</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="3">Est Cost</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="3">Expenditure</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="3">Population</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="5">Tenders Finalized</td>
	<td align="center" class="gridhdbg"  rowspan="1" colspan="8">Works Completed</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="3">Likely Expenditure during 2013-14</td>
        <td align="center" class="gridhdbg" rowspan="2" colspan="3">Likely Expenditure during 2014-15</td>
	
	</tr>
	<tr>
	<td align="center" class="gridhdbg" rowspan="3">No of Works</td>
	<td align="center" class="gridhdbg" colspan="4">Est Cost</td>
	<td align="center" class="gridhdbg" rowspan="3">No of Works</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="3">Habs Completed</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="4">Est Cost</td>
	</tr>
<tr>
	<td align="center" class="gridhdbg" rowspan="2">Program</td>
	<td align="center" class="gridhdbg" rowspan="2">Percentage</td>
	<td align="center" class="gridhdbg" rowspan="2">SC</td>
	<td align="center" class="gridhdbg" rowspan="2">ST</td>

	<td align="center" class="gridhdbg" rowspan="2">Plain</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="2">State Share</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="2">State Share</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="2">SC</td>
	<td align="center" class="gridhdbg" rowspan="2">ST</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="3">State Share</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="2">SC>40%</td>
	<td align="center" class="gridhdbg" rowspan="2">ST>40%</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="3">State Share</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="2">State Share</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="2">State Share</td>
	

	
	</tr>
	<tr>
	
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	<td align="center" class="gridhdbg" >Plain</td>
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	<td align="center" class="gridhdbg" >Plain</td>
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	

	
	</tr>
<tr>
	<%for(int i=1;i<37;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%
		
	} %>
	</tr>
	<%
		Statement stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null, stmt7 = null, stmt8 = null, stmt9 = null, stmt10 = null, stmt11 = null, stmt12 = null, stmt13 = null, stmt14 = null, stmt15 = null,stmt16=null,stmt17=null,stmt18=null,stmt19=null,stmt20=null,stmt21=null,stmt22=null,stmt23=null,stmt24=null,stmt25=null,stmt26=null,stmt27=null,stmt28=null,stmt29=null,stmt30=null,stmt31=null,stmt32=null;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null, rs9 = null, rs10 = null, rs11 = null, rs12 = null, rs13 = null, rs14 = null, rs15 = null,rs16=null,rs17=null,rs18=null,rs19=null,rs20=null,rs21=null,rs22=null, rs23= null, rs24 = null, rs25 = null,rs26 = null,rs27 = null, rs28 = null,rs29 = null,rs30 = null,rs31 = null,rs32 = null;
		int count = 1;
		String temp="";
		List SCSPWorks = new ArrayList();
		List SCSPWorks1 = new ArrayList();
		List PSPWorks = new ArrayList();
		List scstWorks = new ArrayList();
		try {

			stmt2 = conn.createStatement();
			stmt3 = conn.createStatement();
			stmt4 = conn.createStatement();
			stmt5 = conn.createStatement();
			stmt6 = conn.createStatement();
			stmt7 = conn.createStatement();
			stmt8 = conn.createStatement();
			stmt9 = conn.createStatement();
			stmt10 = conn.createStatement();
			stmt11 = conn.createStatement();
			stmt12 = conn.createStatement();
			stmt13 = conn.createStatement();
			stmt14 = conn.createStatement();
			stmt15 = conn.createStatement();
			stmt16=conn.createStatement();
			stmt17=conn.createStatement();
			stmt18=conn.createStatement();
			stmt19=conn.createStatement();
			stmt20=conn.createStatement();
			stmt21=conn.createStatement();
			stmt22=conn.createStatement();
			stmt23=conn.createStatement();
			stmt24=conn.createStatement();
			stmt25=conn.createStatement();
			stmt26=conn.createStatement();
			stmt27=conn.createStatement();
			stmt28=conn.createStatement();
			stmt29=conn.createStatement();
			stmt30=conn.createStatement();
			stmt31=conn.createStatement();
			stmt32=conn.createStatement();
			int workcountsc=0,habcountsc=0,scpopcountsc=0,scpopcountst=0,scpopcountp=0;
			int workcountst=0,habcountst=0,stpopcountsc=0,stpopcountst=0,stpopcountp=0;
			int workcountp=0,habcountp=0,ppopcountsc=0,ppopcountst=0,ppopcountp=0;
			
			int tworkcountsc=0,thabcountsc=0,tscpopcountsc=0,tscpopcountst=0,tscpopcountp=0;
			int tworkcountst=0,thabcountst=0,tstpopcountsc=0,tstpopcountst=0,tstpopcountp=0;
			int tworkcountp=0,thabcountp=0,tppopcountsc=0,tppopcountst=0,tppopcountp=0;
			
			int comptdworkcountsc=0,comptdhabcountsc=0,comptdscpopcountsc=0,comptdscpopcountst=0,comptdscpopcountp=0;
			int comptdworkcountst=0,comptdhabcountst=0,comptdstpopcountsc=0,comptdstpopcountst=0,comptdstpopcountp=0;
			int comptdworkcountp=0,comptdhabcountp=0,comptdppopcountsc=0,comptdppopcountst=0,comptdppopcountp=0;
			
			double ssscEstcost2=0.0,ssscExpenditureAmt=0.0,ssscL13ExpenditureAmt=0.0,ssscL14ExpenditureAmt=0.0;
			 double ssstEstcost2=0.0,ssstExpenditureAmt=0.0,ssstL13ExpenditureAmt=0.0,ssstL14ExpenditureAmt=0.0;
			 double sspEstcost2=0.0,sspExpenditureAmt=0.0,sspL13ExpenditureAmt=0.0,sspL14ExpenditureAmt=0.0;
			
			 int styleCount = 0;
			String style = "";
			int recCount = 0;
			int gncount = 0, gscount = 0, ghcount = 0, gschcount = 0, newtotpop = 0, spilltotpop = 0, scsptotpop = 0;
			double gspillsanAmt = 0.0, gnewsanAmt = 0.0, stgspillsanAmt = 0.0, stgnewsanAmt = 0.0, pgspillsanAmt = 0.0, pgnewsanAmt = 0.0, likexp = 0.0, glikexp = 0.0, sclikexp = 0.0, gsclikexp = 0.0, gdurexp = 0.0, durexp = 0.0;
			double plainPop = 0, scPop = 0, stPop = 0;
			double plainPop1 = 0, scPop1 = 0, stPop1 = 0;

			double scL13expscshare=0.0,scL13expstshare=0.0,stL13expscshare=0.0,stL13expstshare=0.0,scL14expscshare=0.0,scL14expstshare=0.0,stL14expscshare=0.0,stL14expstshare=0.0,scexpscshare=0.0,scexpstshare=0.0,stexpscshare=0.0,stexpstshare=0.0,scestcostscshare=0.0,scestcoststshare=0.0,stestcostscshare=0.0,stestcoststshare=0.0;
			double pL13expscshare=0.0,
			 pL13expstshare=0.0,
			 pL14expscshare=0.0,
			 pL14expstshare=0.0,
			
			 pexpscshare=0.0,
			 pexpstshare=0.0,
			 pestcostscshare=0.0,
			 pestcoststshare=0.0;
			double plainPer = 0, scPer = 0, stPer = 0;
			double plainPer1 = 0, scPer1 = 0, stPer1 = 0;

			double totPop = 0, totPop1 = 0;

			boolean flag = false;

			int nWorkCount = 0, sWorkCount = 0, nstWorkCount = 0, sstWorkCount = 0, pWorkCount = 0, pnWorkCount = 0, habcount = 0, schabcount = 0, gsctencount = 0, tencount = 0, gcompcount = 0, compcount = 0, gcomphabcount = 0, comphabcount = 0;

			double sctenderestsc=0.0,sctenderestst=0.0,sctenderestp=0.0,scspillSanctionedAmt = 0.0,tscSanctionedAmt=0.0,tstSanctionedAmt=0.0,tpSanctionedAmt=0.0, scSanctionedAmt = 0.0,scExpenditureAmt=0.0,scEstimationAmt=0.0,scEstcost2=0.0,scEstcost1=0.0,scExpenditureAmtb=0.0,scL13ExpenditureAmt=0.0,scL14ExpenditureAmt=0.0;
			double sttenderestsc=0.0,sttenderestst=0.0,sttenderestp=0.0,stspillSanctionedAmt = 0.0, stSanctionedAmt = 0.0,stExpenditureAmt=0.0,stEstimationAmt=0.0,stEstcost2=0.0,stEstcost1=0.0,stExpenditureAmtb=0.0,stL13ExpenditureAmt=0.0,stL14ExpenditureAmt=0.0;
			double ptenderestsc=0.0,ptenderestst=0.0,ptenderestp=0.0,pspillSanctionedAmt = 0.0, pSanctionedAmt = 0.0,pExpenditureAmt=0.0,pEstimationAmt=0.0,pEstcost2=0.0,pEstcost1=0.0,pExpenditureAmtb=0.0,pL13ExpenditureAmt=0.0,pL14ExpenditureAmt=0.0;
			
			double scworkestsc=0.0,scworkestst=0.0,scworkestp=0.0,comptdscSanctionedAmt=0.0; 
			double stworkestsc=0.0,stworkestst=0.0,stworkestp=0.0,comptdstSanctionedAmt=0.0;
			double pworkestsc=0.0,pworkestst=0.0,pworkestp=0.0,comptdpSanctionedAmt=0.0;
			//double pL13expscshare=0.0,pL14expstshare=0.0,pexpscshare=0.0,pexpstshare=0.0,pestcostscshare=0.0,pestcoststshare=0.0;
			String dname = "";
			String myWorkList = "", myWorkList1 = "", myWorkList2 = "";
			
			//<40% and only plain

			 stmt2=conn.createStatement();
		        String mainQuery="select distinct b.dcode,b.dname,a.work_id,substr(a.work_id,1,2),e.programme_name,sum(CENSUS_PLAIN_POPU),sum(CENSUS_SC_POPU),sum(CENSUS_ST_POPU) from rws_work_admn_tbl a,rws_district_tbl b,rws_admn_hab_lnk_tbl c,rws_habitation_directory_tbl d ,rws_programme_tbl e  where substr(a.work_id,5,2)=b.dcode and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null and a.work_id=c.work_id and c.hab_code=d.hab_code and substr(a.work_id,1,2)=e.programme_code  ";
		    
			   if(dcode!=null && !dcode.equals("00")){
				   mainQuery+=" and b.DCODE='"+dcode+"'";
				}

				if(scheme!=null && !scheme.equals(""))
				{
					mainQuery+=" and a.type_of_asset in("+scheme+")";
				}
				if(category!=null && !category.equals("")){
					mainQuery += " and a.special_cat='" + category + "'";
				}
				mainQuery+=" and substr(a.work_id,1,2)=e.programme_code  and e.programme_code in ("+programe+")  group by b.dcode,b.dname,a.work_id,substr(a.work_id,1,2),e.programme_name order by  dcode  ";
			
				
		    System.out.println("Main query............"+mainQuery);
		 	rs2=stmt2.executeQuery(mainQuery);
			
		    //start printing
			while(rs2.next())
			{
				
				
				String ddCode=rs2.getString(1);
				
			 	
			    String key=rs2.getString(3);
				
				System.out.println("my key..............."+key);
				
				plainPop=Double.parseDouble(rs2.getString(6));
		  		scPop=Double.parseDouble(rs2.getString(7));
		  		stPop=Double.parseDouble(rs2.getString(8));
		  		
		  		totPop=plainPop+scPop+stPop;
		  		
			 	plainPer = (plainPop * 100/ totPop);
		 		scPer = (scPop * 100/ totPop);
		 		stPer = (stPop * 100/ totPop);
		 		
		 		//System.out.println("my pop..............."+totPop+"....."+scPop);
		 		//System.out.println("my SCper..............."+scPer+rs2.getString(3));
				
				if(scPer==0 && stPer==0)
				{
						
					PSPWorks.add(rs2.getString(3));
					//System.out.println("my workids..............."+SCSPWorks.toString());
					myWorkList=PSPWorks.toString();
					myWorkList=myWorkList.replace("[", "(" );
					myWorkList=myWorkList.replace("]", ")" );
					//System.out.println("my workids21243435..............."+myWorkList);
					//session.setAttribute("myList",myWorkList);	
				}
				if(scPer<40 && stPer<40)
				{
					scstWorks.add(rs2.getString(3));
					//System.out.println("my workids..............."+SCSPWorks.toString());
					myWorkList1=scstWorks.toString();
					myWorkList1=myWorkList1.replace("[", "(" );
					myWorkList1=myWorkList1.replace("]", ")" );
				    
				    //session.setAttribute("myList1",myWorkList1);
				}
				
				 //System.out.println("my workids4354566..............."+myWorkList);
			}
			if(stmt2!=null){
				stmt2.close();
			}
			if(rs2!=null){
				rs2.close();
			}
		    //habs count for <40 and plain
		    String habs="select d.dname,p.programme_name,count(l.hab_code),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU),sum(prob_exp),sum(prob_exp_nxt_yr),sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d , rws_programme_tbl p ,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd where  w.work_id=l.work_id and l.hab_code=hd.hab_code and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,1,2)=p.programme_code ";

        habs+=" and   w.work_id in  "+myWorkList+"  group by  d.dname,p.programme_name";
        
        Hashtable plain_hash = new Hashtable();
		
			
       System.out.println("1111habs ............"+habs);
    rs23=stmt23.executeQuery(habs);
	while(rs23.next())
	{
		
		
		plain_hash.put(rs23.getString(1)+rs23.getString(2),rs23.getString(3)+"@"+rs23.getInt(4)+"@"+rs23.getInt(5)+"@"+rs23.getInt(6)+"@"+rs23.getString(7)+"@"+rs23.getString(8)+"@"+rs23.getString(9));
		System.out.println("hab count is"+rs23.getInt(3));
		
	}
	if(stmt23!=null){
		stmt23.close();
	}
	if(rs23!=null){
		rs23.close();
	}
	  String habs1="select d.dname,p.programme_name,count(l.hab_code),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU),sum(prob_exp),sum(prob_exp_nxt_yr),sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d , rws_programme_tbl p ,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd where  w.work_id=l.work_id and l.hab_code=hd.hab_code and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,1,2)=p.programme_code ";

      habs1+=" and   w.work_id in  "+myWorkList1+"  group by  d.dname,p.programme_name";
      
      Hashtable plain_scst_hash = new Hashtable();
		
			
     System.out.println("222habs ............"+habs1);
     
  rs24=stmt24.executeQuery(habs1);
	while(rs24.next())
	{
		
		
		plain_scst_hash.put(rs24.getString(1)+rs24.getString(2),rs24.getString(3)+"@"+rs24.getInt(4)+"@"+rs24.getInt(5)+"@"+rs24.getInt(6)+"@"+rs24.getString(7)+"@"+rs24.getString(8)+"@"+rs24.getString(8));
		
		
	}
	if(stmt24!=null){
		stmt23.close();
	}
	if(rs24!=null){
		rs23.close();
	}    
	///tenders finalized
	//////////////st Tenders Finalized query/////////
	  	
	  	String tenderqryscst="select d.dname,p.programme_name,count(*),sum(sanction_amount),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU) from rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_COMMENCEMENT_TBL c,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd where  a.work_id=l.work_id and l.hab_code=hd.hab_code and a.work_id in "+myWorkList1+"  and a.work_id=c.work_id and GROUNDING_DATE is not null and substr(a.work_id,5,2)=d.dcode and substr(a.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	
	  	 if (dcode != null && !dcode.equals("00")) {
	  		tenderqryscst+= " and d.DCODE='" + dcode + "'";
				}

				if (scheme != null && !scheme.equals("")) {
					tenderqryscst+= " and a.type_of_asset in(" + scheme + ")";
				}
				
				if(category!=null && !category.equals("")){
					tenderqryscst += " and a.special_cat='" + category + "'";
				}
				tenderqryscst+=" and  a.programme_code in ("+programe+") group by d.dname,p.programme_name ";

				System.out.println("1) tenderqryscst " + tenderqryscst);
				rs25=stmt25.executeQuery(tenderqryscst);
				Hashtable scst_habdet_hash = new Hashtable();
				while(rs25.next()){
					
					scst_habdet_hash.put(rs25.getString(1)+rs25.getString(2),rs25.getInt(3)+"@"+rs25.getString(4)+"@"+rs25.getInt(5)+"@"+rs25.getInt(6)+"@"+rs25.getInt(7));	
				}
				
				if(stmt25!=null){
					stmt25.close();
				}
				if(rs25!=null){
					rs25.close();
				}
			  	String tenderqryplain="select d.dname,p.programme_name,count(*),sum(sanction_amount),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU) from rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_COMMENCEMENT_TBL c,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd where  a.work_id=l.work_id and l.hab_code=hd.hab_code and a.work_id in "+myWorkList+"  and a.work_id=c.work_id and GROUNDING_DATE is not null and substr(a.work_id,5,2)=d.dcode and substr(a.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
			
			  	 if (dcode != null && !dcode.equals("00")) {
			  		tenderqryplain+= " and d.DCODE='" + dcode + "'";
						}

						if (scheme != null && !scheme.equals("")) {
							tenderqryplain+= " and a.type_of_asset in(" + scheme + ")";
						}
						
						if(category!=null && !category.equals("")){
							tenderqryplain += " and a.special_cat='" + category + "'";
						}
						tenderqryplain+=" and  a.programme_code in ("+programe+") group by d.dname,p.programme_name ";

						System.out.println("1) tenderqryplain " + tenderqryplain);
						rs26=stmt26.executeQuery(tenderqryplain);
						Hashtable plain_habdet_hash = new Hashtable();
						while(rs26.next()){
							
							plain_habdet_hash.put(rs26.getString(1)+rs26.getString(2),rs26.getInt(3)+"@"+rs26.getString(4)+"@"+rs26.getInt(5)+"@"+rs26.getInt(6)+"@"+rs26.getInt(7));	
						}
						
						if(stmt26!=null){
							stmt26.close();
						}
						if(rs26!=null){
							rs26.close();
						}
			///////////// works completed query/////////
			  		  	
			  		  	String workscomptplain="select d.dname,p.programme_name,count(*),sum(sanction_amount),sum(l.hab_code),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU) from rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_Completion_tbl c,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd where  a.work_id=c.work_id and a.work_id=l.work_id and l.hab_code=hd.hab_code and a.work_id in "+myWorkList+" and DATE_of_completion is not null and  (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"')  and substr(a.work_id,5,2)=d.dcode and substr(a.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
			  		  		 	   
			  		  	        if (dcode != null && !dcode.equals("00")) {
			  		  	        workscomptplain+= " and d.DCODE='" + dcode + "'";
			  		  				}

			  		  				if (scheme != null && !scheme.equals("")) {
			  		  				workscomptplain+= " and a.type_of_asset in(" + scheme + ")";
			  		  				}
			  		  			if(category!=null && !category.equals("")){
			  		  			workscomptplain += " and a.special_cat='" + category + "'";
				  	  					}
				  			  		
			  		  				
			  		  		workscomptplain+=" and  a.programme_code in ("+programe+") group by d.dname,p.programme_name ";

			  		  		  	System.out.println("18)Plain works completed query "+workscomptplain);
			  	    rs27=stmt27.executeQuery(workscomptplain);
			  	    Hashtable works_compt_plain_hash = new Hashtable();
			  		while(rs27.next()){
			  			works_compt_plain_hash.put(rs27.getString(1)+rs27.getString(2),rs27.getInt(3)+"@"+rs27.getString(4)+"@"+rs27.getInt(5)+"@"+rs27.getInt(6)+"@"+rs27.getInt(7)+"@"+rs27.getInt(8));
			  		}
		    ////scst
			  		if(stmt27!=null){
						stmt27.close();
					}
					if(rs27!=null){
						rs27.close();
					}
		    
			  		String workscomptscst="select d.dname,p.programme_name,count(*),sum(sanction_amount),sum(l.hab_code),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU) from rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_Completion_tbl c,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd where  a.work_id=c.work_id and a.work_id=l.work_id and l.hab_code=hd.hab_code and a.work_id in "+myWorkList1+" and DATE_of_completion is not null and  (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"')  and substr(a.work_id,5,2)=d.dcode and substr(a.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
		  		 	   
  		  	        if (dcode != null && !dcode.equals("00")) {
  		  	        workscomptscst+= " and d.DCODE='" + dcode + "'";
  		  				}

  		  				if (scheme != null && !scheme.equals("")) {
  		  				workscomptscst+= " and a.type_of_asset in(" + scheme + ")";
  		  				}
  		  			if(category!=null && !category.equals("")){
  		  			workscomptscst += " and a.special_cat='" + category + "'";
	  	  					}
	  			  		
  		  				
  		  		workscomptscst+=" and  a.programme_code in ("+programe+") group by d.dname,p.programme_name ";

  		  		  	System.out.println("18)Plain works completed query "+workscomptscst);
  	    rs28=stmt28.executeQuery(workscomptplain);
  	    Hashtable works_compt_scst_hash = new Hashtable();
  		while(rs28.next()){
  			works_compt_scst_hash.put(rs28.getString(1)+rs28.getString(2),rs28.getInt(3)+"@"+rs28.getString(4)+"@"+rs28.getInt(5)+"@"+rs28.getInt(6)+"@"+rs28.getInt(7)+"@"+rs28.getInt(8));
  		}
  		if(stmt28!=null){
			stmt28.close();
		}
		if(rs28!=null){
			rs28.close();
		}
  	//////expenditure during an before	
  		
  		String plainexpqry="select d.dcode,substr(a.work_id,1,2),sum(case when (to_date(voucher_dt)> '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a  where a.work_id in "+myWorkList+" and (to_date(admin_date) < '01-Apr-"+startyr+"') and  a.work_id=exp.work_id and substr(a.WORK_ID,5,2)=D.DCODE and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null  ";
		if (dcode != null && !dcode.equals("00")) {
			plainexpqry += "and d.DCODE='" + dcode + "'";
		}

		if (scheme != null && !scheme.equals("")) {
			plainexpqry += " and a.type_of_asset in(" + scheme + ")";
		}
		if(category!=null && !category.equals("")){
			plainexpqry += " and a.special_cat='" + category + "'";
					}
	  			
		
		plainexpqry += " and substr(a.work_id,1,2) in (" + programe
					+ ") group by d.dcode,substr(a.work_id,1,2)";
		
		System.out.println("15)plain expenditure during " + plainexpqry);
		rs29=stmt29.executeQuery(plainexpqry);
		Hashtable plain_exp_hash = new Hashtable();
      while(rs29.next()){
    	  plain_exp_hash.put(rs29.getString(1)+rs29.getString(2),rs29.getString(3));
       //System.out.println("plain expqry" + rs29.getInt(3));
       
        }
      if(stmt29!=null){
			stmt29.close();
		}
		if(rs29!=null){
			rs29.close();
		}
      ///scst
      String scstexpqry="select d.dcode,substr(a.work_id,1,2),sum(case when (to_date(voucher_dt)> '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a  where a.work_id in "+myWorkList1+" and (to_date(admin_date) < '01-Apr-"+startyr+"') and  a.work_id=exp.work_id and substr(a.WORK_ID,5,2)=D.DCODE and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null  ";
		if (dcode != null && !dcode.equals("00")) {
			scstexpqry += "and d.DCODE='" + dcode + "'";
		}

		if (scheme != null && !scheme.equals("")) {
			scstexpqry += " and a.type_of_asset in(" + scheme + ")";
		}
		if(category!=null && !category.equals("")){
			scstexpqry += " and a.special_cat='" + category + "'";
					}
	  			
		
		scstexpqry += " and substr(a.work_id,1,2) in (" + programe
					+ ") group by d.dcode,substr(a.work_id,1,2)";
		
		System.out.println("15)plain expenditure during " + scstexpqry);
		rs30=stmt30.executeQuery(scstexpqry);
		Hashtable scst_exp_hash = new Hashtable();
    while(rs30.next()){
    	scst_exp_hash.put(rs30.getString(1)+rs30.getString(2),rs30.getString(3));
     //System.out.println("scstexpqry" + rs30.getInt(3));
     
      }
    if(stmt30!=null){
		stmt23.close();
	}
	if(rs30!=null){
		rs23.close();
	}
  	////before
  
	String plainexpqrybefore="select d.dcode,substr(a.work_id,1,2),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a where a.work_id in "+myWorkList+" and (to_date(admin_date) < '01-Apr-"+startyr+"') and  a.work_id=exp.work_id and substr(a.WORK_ID,5,2)=D.DCODE and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	if (dcode != null && !dcode.equals("00")) {
		plainexpqrybefore += "and d.DCODE='" + dcode + "'";
	}

	if (scheme != null && !scheme.equals("")) {
		plainexpqrybefore += " and a.type_of_asset in(" + scheme + ")";
	}
	if(category!=null && !category.equals("")){
		plainexpqrybefore += " and a.special_cat='" + category + "'";
	}
	
	plainexpqrybefore += " and substr(a.work_id,1,2) in (" + programe
				+ ") group by d.dcode,substr(a.work_id,1,2)";
	
	System.out.println("plain expenditure before  " + plainexpqrybefore);
	rs31=stmt31.executeQuery(plainexpqrybefore);
	Hashtable plain_bef_exp_hash = new Hashtable();
  while(rs31.next()){
	  plain_bef_exp_hash.put(rs31.getString(1)+rs31.getString(2),rs31.getString(3));

   System.out.println("plain epen b " + rs31.getInt(3));
   }
  if(stmt31!=null){
		stmt23.close();
	}
	if(rs31!=null){
		rs23.close();
	}	
  String scstexpqrybefore="select d.dcode,substr(a.work_id,1,2),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a where a.work_id in "+myWorkList1+" and (to_date(admin_date) < '01-Apr-"+startyr+"') and  a.work_id=exp.work_id and substr(a.WORK_ID,5,2)=D.DCODE and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	if (dcode != null && !dcode.equals("00")) {
		scstexpqrybefore += "and d.DCODE='" + dcode + "'";
	}

	if (scheme != null && !scheme.equals("")) {
		scstexpqrybefore += " and a.type_of_asset in(" + scheme + ")";
	}
	if(category!=null && !category.equals("")){
		scstexpqrybefore += " and a.special_cat='" + category + "'";
	}
	
	scstexpqrybefore += " and substr(a.work_id,1,2) in (" + programe
				+ ") group by d.dcode,substr(a.work_id,1,2)";
	
	System.out.println("scst expenditure before " + scstexpqrybefore);
	rs32=stmt32.executeQuery(plainexpqrybefore);
	Hashtable scst_bef_exp_hash = new Hashtable();
while(rs32.next()){
	System.out.println("scst exp b " + rs32.getInt(3));
	  scst_bef_exp_hash.put(rs32.getString(1)+rs32.getString(2),rs32.getString(3));


 }
			
if(stmt32!=null){
	stmt32.close();
}
if(rs32!=null){
	rs32.close();
}	
  		
  		
  		
			////SC population,works,hab_count,est,exp cost

			String scquery = "select d.dname,p.programme_name,count(*),sum(sc.hab_count),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop),sum(a.sanction_amount),sum(prob_exp),sum(prob_exp_nxt_yr) from rws_sc_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a where sc.work_id=a.work_id and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
			
			if (dcode != null && !dcode.equals("00")) {
				scquery += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				scquery += "and a.type_of_asset in(" + scheme + ")";
			}
			if(category!=null && !category.equals("")){
				scquery += " and a.special_cat='" + category + "'";
			}
				scquery += " and p.programme_code in (" + programe
						+ ") group by d.dname,p.programme_name";
			
			System.out.println("1) scquery " + scquery);
			rs4 = stmt4.executeQuery(scquery);
			Hashtable scpop_works_hab_hash = new Hashtable();
			while (rs4.next()) {
				scpop_works_hab_hash.put(rs4.getString(1)
						+ rs4.getString(2), rs4.getInt(3) + "@"
						+ rs4.getInt(4) + "@" + rs4.getInt(5) + "@"
						+ rs4.getInt(6) + "@" + rs4.getInt(7)+"@"+rs4.getInt(8)+"@"+rs4.getInt(9)+"@"+rs4.getInt(10));

			}
			if(stmt4!=null){
				stmt4.close();
			}
			if(rs4!=null){
				rs4.close();
			}
			//sc expenditure before
			String scexpqrybefore="select d.dcode,substr(w.work_id,1,2),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_sc_works_view W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a where a.work_id=w.work_id and (to_date(admin_date) < '01-Apr-"+startyr+"') and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
			if (dcode != null && !dcode.equals("00")) {
				scexpqrybefore += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				scexpqrybefore += " and a.type_of_asset in(" + scheme + ")";
			}
			if(category!=null && !category.equals("")){
				scexpqrybefore += " and a.special_cat='" + category + "'";
			}
			
				scexpqrybefore += " and substr(w.work_id,1,2) in (" + programe
						+ ") group by d.dcode,substr(w.work_id,1,2)";
			
			System.out.println("2)sc expenditure before " + scexpqrybefore);
			rs14=stmt14.executeQuery(scexpqrybefore);
			Hashtable sc_bef_exp_hash = new Hashtable();
          while(rs14.next()){
        	  sc_bef_exp_hash.put(rs14.getString(1)+rs14.getString(2),rs14.getString(3));
  
	      // System.out.println("stexpqry" + rs8.getInt(3));
	       }
          if(stmt14!=null){
  			stmt14.close();
  		}
  		if(rs14!=null){
  			rs14.close();
  		}
			//sc expenditure during
			String scexpqry="select d.dcode,substr(w.work_id,1,2),sum(case when (to_date(voucher_dt)> '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_sc_works_view W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a  where a.work_id=w.work_id and (to_date(admin_date) < '01-Apr-"+startyr+"') and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
			if (dcode != null && !dcode.equals("00")) {
				scexpqry += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				scexpqry += " and a.type_of_asset in(" + scheme + ")";
			}
			if(category!=null && !category.equals("")){
				scexpqry += " and a.special_cat='" + category + "'";
			}
			
			scexpqry += " and substr(w.work_id,1,2) in (" + programe
						+ ") group by d.dcode,substr(w.work_id,1,2)";
			
			System.out.println("3)sc expenditure during " + scexpqry);
			rs8=stmt8.executeQuery(scexpqry);
			Hashtable sc_exp_hash = new Hashtable();
          while(rs8.next()){
	       sc_exp_hash.put(rs8.getString(1)+rs8.getString(2),rs8.getString(3));
  
	       System.out.println("stexpqry" + rs8.getInt(3));
	       }
          if(stmt8!=null){
  			stmt8.close();
  		}
  		if(rs8!=null){
  			rs8.close();
  		}
          
 ///sanction amount for spill over works sc
 
          String spillOverWorkssc="select d.dcode,substr(w.work_id,1,2),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_sc_works_view sc  where  sc.work_id=w.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
 	   
          if (dcode != null && !dcode.equals("00")) {
        	  spillOverWorkssc += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				spillOverWorkssc += " and w.type_of_asset in(" + scheme + ")";
			}
			if(category!=null && !category.equals("")){
				spillOverWorkssc += " and w.special_cat='" + category + "'";
			}
	  spillOverWorkssc+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(w.work_id,1,2) ";

	  	System.out.println("4) sanction amount for spill over works sc "+spillOverWorkssc);
	  	 rs11=stmt11.executeQuery(spillOverWorkssc);
	  
	  	Hashtable spillOverWorksHashsc=new Hashtable();
	  	while(rs11.next()){
	  		  	
	  		spillOverWorksHashsc.put(rs11.getString(1)+rs11.getString(2),rs11.getString(3));
	  	}
	  	if(stmt11!=null){
			stmt11.close();
		}
		if(rs11!=null){
			rs11.close();
		}
//////////////sc Tenders Finalized query/////////
	  	
String tenderqrysc="select d.dname,p.programme_name,count(*),sum(sanction_amount),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop) from rws_sc_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_COMMENCEMENT_TBL c where sc.work_id=a.work_id  and a.work_id=c.work_id and GROUNDING_DATE is not null and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	 	   
        if (dcode != null && !dcode.equals("00")) {
        	tenderqrysc+= " and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				tenderqrysc+= " and a.type_of_asset in(" + scheme + ")";
			}
			
			if(category!=null && !category.equals("")){
				tenderqrysc += " and a.special_cat='" + category + "'";
			}
			tenderqrysc+=" and  a.programme_code in ("+programe+") group by d.dname,p.programme_name ";

	  	System.out.println("5) sc Tenders Finalized query "+tenderqrysc);
	  	 rs17=stmt17.executeQuery(tenderqrysc);
	  
	  	Hashtable tenderHashsc=new Hashtable();
	  	while(rs17.next()){
	  		  	
	  		tenderHashsc.put(rs17.getString(1)+rs17.getString(2),rs17.getInt(3)+"@"+rs17.getString(4)+"@"+rs17.getInt(5)+"@"+rs17.getInt(6)+"@"+rs17.getInt(7));
	  	}
	  	if(stmt17!=null){
			stmt17.close();
		}
		if(rs17!=null){
			rs17.close();
		}
//////////////sc works completed query/////////
	  	
	  	String workscomptdsc="select d.dname,p.programme_name,count(*),sum(sanction_amount),sum(sc.hab_count),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop) from rws_sc_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_Completion_tbl c where sc.work_id=a.work_id  and a.work_id=c.work_id and DATE_of_completion is not null and  (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"')  and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	  		 	   
	  	        if (dcode != null && !dcode.equals("00")) {
	  	        	workscomptdsc+= " and d.DCODE='" + dcode + "'";
	  				}

	  				if (scheme != null && !scheme.equals("")) {
	  					workscomptdsc+= " and a.type_of_asset in(" + scheme + ")";
	  				}
	  				
	  				if(category!=null && !category.equals("")){
	  					workscomptdsc += " and a.special_cat='" + category + "'";
	  				}
	  				workscomptdsc+=" and  a.programme_code in ("+programe+") group by d.dname,p.programme_name ";

	  		  	System.out.println("6) sc works completed query "+workscomptdsc);
	  		  	 rs20=stmt20.executeQuery(workscomptdsc);
	  		  
	  		  	Hashtable workscomptdHashsc=new Hashtable();
	  		  	while(rs20.next()){
	  		  		  	
	  		  	workscomptdHashsc.put(rs20.getString(1)+rs20.getString(2),rs20.getInt(3)+"@"+rs20.getString(4)+"@"+rs20.getInt(5)+"@"+rs20.getInt(6)+"@"+rs20.getInt(7)+"@"+rs20.getInt(8));
	  		  	}

	  		  if(stmt20!=null){
	  			stmt20.close();
	  		}
	  		if(rs20!=null){
	  			rs20.close();
	  		}

	  	
	  	
	////ST population,works,hab_count

			String stquery = "select d.dname,p.programme_name,count(*),sum(st.hab_count),sum(st.plain_pop),sum(st.sc_pop),sum(st.st_pop),sum(a.sanction_amount),sum(prob_exp),sum(prob_exp_nxt_yr) from rws_st_works_view st,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a where st.work_id=a.work_id and substr(st.work_id,5,2)=d.dcode and substr(st.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null  ";

			if (dcode != null && !dcode.equals("00")) {
				stquery += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				stquery += "and a.type_of_asset in(" + scheme + ")";
			}
			if(category!=null && !category.equals("")){
				stquery += " and a.special_cat='" + category + "'";
				}
				stquery += " and p.programme_code in (" + programe
						+ ") group by d.dname,p.programme_name";
			
			System.out.println("7)ST population,works,hab_count " + stquery);
			rs5 = stmt5.executeQuery(stquery);
			Hashtable stpop_works_hab_hash = new Hashtable();
			while (rs5.next()) {
				stpop_works_hab_hash.put(rs5.getString(1)
						+ rs5.getString(2), rs5.getInt(3) + "@"
						+ rs5.getInt(4) + "@" + rs5.getInt(5) + "@"
						+ rs5.getInt(6) + "@" + rs5.getInt(7)+"@"+rs5.getInt(8)+"@"+rs5.getInt(9)+"@"+rs5.getInt(10));

			}
			if(stmt5!=null){
				stmt5.close();
			}
			if(rs5!=null){
				rs5.close();
			}
//st expenditure before
			String stexpqrybefore="select d.dcode,substr(w.work_id,1,2),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_st_works_view W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a where a.work_id=w.work_id and (to_date(admin_date) < '01-Apr-"+startyr+"') and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
			
				if (dcode != null && !dcode.equals("00")) 
				{
					stexpqrybefore += "and d.DCODE='" + dcode + "'";
				}

				if (scheme != null && !scheme.equals("")) {
					stexpqrybefore += " and a.type_of_asset in(" + scheme + ")";
				}
				
				if(category!=null && !category.equals("")){
					stexpqrybefore += " and a.special_cat='" + category + "'";
					}
				
					stexpqrybefore += " and substr(w.work_id,1,2) in (" + programe
							+ ") group by d.dcode,substr(w.work_id,1,2)";
				
			System.out.println("8) st expenditure before " + stexpqrybefore);
			rs15=stmt15.executeQuery(stexpqrybefore);
			Hashtable st_bef_exp_hash = new Hashtable();
          while(rs15.next()){
        	  st_bef_exp_hash.put(rs15.getString(1)+rs15.getString(2),rs15.getString(3));
  
	      // System.out.println("stexpqry" + rs8.getInt(3));
	       }
          if(stmt15!=null){
  			stmt15.close();
  		}
  		if(rs15!=null){
  			rs15.close();
  		}
			//st expenditure during
			String stexpqry="select d.dcode,substr(w.work_id,1,2),sum(case when (to_date(voucher_dt)> '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_st_works_view W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a  where a.work_id=w.work_id and (to_date(admin_date) < '01-Apr-"+startyr+"') and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
			if (dcode != null && !dcode.equals("00")) {
				stexpqry += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				stexpqry += " and a.type_of_asset in(" + scheme + ")";
			}
			if(category!=null && !category.equals("")){
				stexpqry += " and a.special_cat='" + category + "'";
				}
			
			
			stexpqry += " and substr(w.work_id,1,2) in (" + programe
						+ ") group by d.dcode,substr(w.work_id,1,2)";
			
			System.out.println("9) st expenditure during " + stexpqry);
			rs9=stmt9.executeQuery(stexpqry);
			Hashtable st_exp_hash = new Hashtable();
          while(rs9.next()){
	       st_exp_hash.put(rs9.getString(1)+rs9.getString(2),rs9.getString(3));
	       //System.out.println("stexpqry" + rs9.getInt(3)); 
          }
          if(stmt9!=null){
  			stmt9.close();
  		}
  		if(rs9!=null){
  			rs9.close();
  		}	
        ///sanction amount for spill over works st
          
          String spillOverWorksst="select d.dcode,substr(w.work_id,1,2),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_st_works_view sc  where  sc.work_id=w.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
          if (dcode != null && !dcode.equals("00")) {
        	  spillOverWorksst += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				spillOverWorksst += " and w.type_of_asset in(" + scheme + ")";
			}
			
			if(category!=null && !category.equals("")){
				spillOverWorksst += " and w.special_cat='" + category + "'";
				}
	  spillOverWorksst+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(w.work_id,1,2) ";

	  	System.out.println("10) sanction amount for spill over works st "+spillOverWorksst);
	  	 rs12=stmt12.executeQuery(spillOverWorksst);
	  
	  	Hashtable spillOverWorksHashst=new Hashtable();
	  	while(rs12.next()){
	  		  	
	  		spillOverWorksHashst.put(rs12.getString(1)+rs12.getString(2),rs12.getString(3));
	  	}

	  	if(stmt12!=null){
			stmt12.close();
		}
		if(rs12!=null){
			rs12.close();
		}
//////////////st Tenders Finalized query/////////
	  	
	  	String tenderqryst="select d.dname,p.programme_name,count(*),sum(sanction_amount),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop) from rws_st_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_COMMENCEMENT_TBL c where sc.work_id=a.work_id  and a.work_id=c.work_id and GROUNDING_DATE is not null and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	  		 	   
	  	        if (dcode != null && !dcode.equals("00"))
	  	        {
	  	        	tenderqryst+= "and d.DCODE='" + dcode + "'";
	  				}

	  				if (scheme != null && !scheme.equals("")) {
	  					tenderqryst+= " and a.type_of_asset in(" + scheme + ")";
	  				}
	  				
	  				if(category!=null && !category.equals("")){
	  					tenderqryst += " and a.special_cat='" + category + "'";
	  					}
	  				tenderqryst+=" and  a.programme_code in ("+programe+") group by d.dname,p.programme_name ";

	  		  	System.out.println("11)st Tenders Finalized query "+tenderqryst);
	  		  	 rs18=stmt18.executeQuery(tenderqryst);
	  		  
	  		  	Hashtable tenderHashst=new Hashtable();
	  		  	while(rs18.next()){
	  		  		  	
	  		  		tenderHashst.put(rs18.getString(1)+rs18.getString(2),rs18.getInt(3)+"@"+rs18.getString(4)+"@"+rs18.getInt(5)+"@"+rs18.getInt(6)+"@"+rs18.getInt(7));
	  		  	}
	  		  if(stmt18!=null){
	  			stmt18.close();
	  		}
	  		if(rs18!=null){
	  			rs18.close();
	  		}
	//////////////st works completed query/////////
	  		  	
	  		  	String workscomptdst="select d.dname,p.programme_name,count(*),sum(sanction_amount),sum(sc.hab_count),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop) from rws_st_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_Completion_tbl c where sc.work_id=a.work_id  and a.work_id=c.work_id and DATE_of_completion is not null and  (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"')  and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	  		  		 	   
	  		  	        if (dcode != null && !dcode.equals("00")) {
	  		  	        	workscomptdst+= " and d.DCODE='" + dcode + "'";
	  		  				}

	  		  				if (scheme != null && !scheme.equals("")) {
	  		  					workscomptdst+= " and a.type_of_asset in(" + scheme + ")";
	  		  				}
	  		  			if(category!=null && !category.equals("")){
	  		  			workscomptdst += " and a.special_cat='" + category + "'";
		  					}
	  		  				
	  		  				workscomptdst+=" and  a.programme_code in ("+programe+") group by d.dname,p.programme_name ";

	  		  		  	System.out.println("12)st works completed query "+workscomptdst);
	  		  		  	 rs21=stmt21.executeQuery(workscomptdst);
	  		  		  
	  		  		  	Hashtable workscomptdHashst=new Hashtable();
	  		  		  	while(rs21.next()){
	  		  		  		  	
	  		  		  	workscomptdHashst.put(rs21.getString(1)+rs21.getString(2),rs21.getInt(3)+"@"+rs21.getString(4)+"@"+rs21.getInt(5)+"@"+rs21.getInt(6)+"@"+rs21.getInt(7)+"@"+rs21.getInt(8));
	  		  		  	}
	  		  		if(stmt21!=null){
	  					stmt21.close();
	  				}
	  				if(rs21!=null){
	  					rs21.close();
	  				}
	  		  	
	  		  	
	  		  	
			////plain population,works,hab_count

			String pquery = "select d.dname,p.programme_name,count(*),sum(pl.hab_count),sum(pl.plain_pop),sum(pl.sc_pop),sum(pl.st_pop),sum(a.sanction_amount),sum(prob_exp),sum(prob_exp_nxt_yr) from rws_plain_works_view pl,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a where pl.work_id=a.work_id and substr(pl.work_id,5,2)=d.dcode and substr(pl.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null  ";

			if (dcode != null && !dcode.equals("00")) {
				pquery += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				pquery += "and a.type_of_asset in(" + scheme + ")";
			}
			if(category!=null && !category.equals("")){
				pquery += " and a.special_cat='" + category + "'";
  					}
		  				
				pquery += " and p.programme_code in (" + programe
						+ ") group by d.dname,p.programme_name";
			
			System.out.println("13)plain population,works,hab_count " + pquery);
			rs6 = stmt6.executeQuery(pquery);
			Hashtable ppop_works_hab_hash = new Hashtable();
			while (rs6.next()) {
				ppop_works_hab_hash
						.put(rs6.getString(1) + rs6.getString(2), rs6
								.getInt(3)
								+ "@"
								+ rs6.getInt(4)
								+ "@"
								+ rs6.getInt(5)
								+ "@" + rs6.getInt(6) + "@" + rs6.getInt(7)+"@"+rs6.getInt(8)+"@"+rs6.getInt(9)+"@"+rs6.getInt(10));

			}
			if(stmt6!=null){
				stmt6.close();
			}
			if(rs6!=null){
				rs6.close();
			}
			//plain expenditure before
			String pexpqrybefore="select d.dcode,substr(w.work_id,1,2),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_plain_works_view W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a where a.work_id=w.work_id and (to_date(admin_date) < '01-Apr-"+startyr+"') and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
			if (dcode != null && !dcode.equals("00")) {
				pexpqrybefore += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				pexpqrybefore += " and a.type_of_asset in(" + scheme + ")";
			}
			if(category!=null && !category.equals("")){
				pexpqrybefore += " and a.special_cat='" + category + "'";
  					}
		  			
			
			
				pexpqrybefore += " and substr(w.work_id,1,2) in (" + programe
						+ ") group by d.dcode,substr(w.work_id,1,2)";
			
			System.out.println("14)plain expenditure before " + pexpqrybefore);
			rs16=stmt16.executeQuery(pexpqrybefore);
			Hashtable p_bef_exp_hash = new Hashtable();
          while(rs16.next()){
        	  p_bef_exp_hash.put(rs16.getString(1)+rs16.getString(2),rs16.getString(3));
  
	      // System.out.println("stexpqry" + rs8.getInt(3));
	       }
          if(stmt16!=null){
  			stmt16.close();
  		}
  		if(rs16!=null){
  			rs16.close();
  		}
			//plain expenditure during
			String pexpqry="select d.dcode,substr(w.work_id,1,2),sum(case when (to_date(voucher_dt)> '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_plain_works_view W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a  where a.work_id=w.work_id and (to_date(admin_date) < '01-Apr-"+startyr+"') and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null  ";
			if (dcode != null && !dcode.equals("00")) {
				pexpqry += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				pexpqry += " and a.type_of_asset in(" + scheme + ")";
			}
			if(category!=null && !category.equals("")){
				pexpqry += " and a.special_cat='" + category + "'";
  					}
		  			
			
			pexpqry += " and substr(w.work_id,1,2) in (" + programe
						+ ") group by d.dcode,substr(w.work_id,1,2)";
			
			System.out.println("15)plain expenditure during " + pexpqry);
			rs10=stmt10.executeQuery(pexpqry);
			Hashtable p_exp_hash = new Hashtable();
          while(rs10.next()){
	       p_exp_hash.put(rs10.getString(1)+rs10.getString(2),rs10.getString(3));
	       //System.out.println("stexpqry" + rs10.getInt(3));
	       
            }
          
          if(stmt10!=null){
  			stmt10.close();
  		}
  		if(rs10!=null){
  			rs10.close();
  		}
        ///sanction amount for spill over works plain
          
          String spillOverWorksp="select d.dcode,substr(w.work_id,1,2),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_plain_works_view sc  where  sc.work_id=w.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
 	   
          if (dcode != null && !dcode.equals("00")) {
        	  spillOverWorksp += "and d.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				spillOverWorksp += " and w.type_of_asset in(" + scheme + ")";
			}
			
			if(category!=null && !category.equals("")){
				spillOverWorksp += " and w.special_cat='" + category + "'";
  					}
		  		
	  spillOverWorksp+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(w.work_id,1,2) ";

	  	System.out.println("16)sanction amount for spill over works plain "+spillOverWorksp);
	  	 rs13=stmt13.executeQuery(spillOverWorksp);
	  
	  	Hashtable spillOverWorksHashp=new Hashtable();
	  	while(rs13.next()){
	  		  	
	  		spillOverWorksHashp.put(rs13.getString(1)+rs13.getString(2),rs13.getString(3));
	  	}
	  	if(stmt13!=null){
			stmt13.close();
		}
		if(rs13!=null){
			rs13.close();
		}
	  	
////////////// Tenders Finalized query/////////
	  	
	  	String tenderqryp="select d.dname,p.programme_name,count(*),sum(sanction_amount),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop) from rws_plain_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_COMMENCEMENT_TBL c where sc.work_id=a.work_id  and a.work_id=c.work_id and GROUNDING_DATE is not null and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	  		 	   
	  	        if (dcode != null && !dcode.equals("00")) {
	  	        	tenderqryp+= "and d.DCODE='" + dcode + "'";
	  				}

	  				if (scheme != null && !scheme.equals("")) {
	  					tenderqryp+= " and a.type_of_asset in(" + scheme + ")";
	  				}
	  				
	  				if(category!=null && !category.equals("")){
	  					tenderqryp += " and a.special_cat='" + category + "'";
	  	  					}
	  			  		
	  				tenderqryp+=" and  a.programme_code in ("+programe+") group by d.dname,p.programme_name ";

	  		  	System.out.println("17)Tenders Finalized query "+tenderqryp);
	  		  	 rs19=stmt19.executeQuery(tenderqryp);
	  		  
	  		  	Hashtable tenderHashp=new Hashtable();
	  		  	while(rs19.next()){
	  		  		  	
	  		  		tenderHashp.put(rs19.getString(1)+rs19.getString(2),rs19.getInt(3)+"@"+rs19.getString(4)+"@"+rs19.getInt(5)+"@"+rs19.getInt(6)+"@"+rs19.getInt(7));
	  		  	}
	  		  if(stmt19!=null){
	  			stmt19.close();
	  		}
	  		if(rs19!=null){
	  			rs19.close();
	  		}
//////////////Plain works completed query/////////
	  		  	
	  		  	String workscomptdp="select d.dname,p.programme_name,count(*),sum(sanction_amount),sum(sc.hab_count),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop) from rws_plain_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_Completion_tbl c where sc.work_id=a.work_id  and a.work_id=c.work_id and DATE_of_completion is not null and  (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"')  and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	  		  		 	   
	  		  	        if (dcode != null && !dcode.equals("00")) {
	  		  	        	workscomptdp+= " and d.DCODE='" + dcode + "'";
	  		  				}

	  		  				if (scheme != null && !scheme.equals("")) {
	  		  					workscomptdp+= " and a.type_of_asset in(" + scheme + ")";
	  		  				}
	  		  			if(category!=null && !category.equals("")){
	  		  			workscomptdp += " and a.special_cat='" + category + "'";
		  	  					}
		  			  		
	  		  				
	  		  				workscomptdp+=" and  a.programme_code in ("+programe+") group by d.dname,p.programme_name ";

	  		  		  	System.out.println("18)Plain works completed query "+workscomptdp);
	  		  		  	 rs22=stmt22.executeQuery(workscomptdp);
	  		  		  
	  		  		  	Hashtable workscomptdHashp=new Hashtable();
	  		  		  	while(rs22.next()){
	  		  		  		  	
	  		  		  	workscomptdHashp.put(rs22.getString(1)+rs22.getString(2),rs22.getInt(3)+"@"+rs22.getString(4)+"@"+rs22.getInt(5)+"@"+rs22.getInt(6)+"@"+rs22.getInt(7)+"@"+rs22.getInt(8));
	  		  		  	}
	  		  		if(stmt22!=null){
	  					stmt22.close();
	  				}
	  				if(rs22!=null){
	  					rs22.close();
	  				}
	  		  	
	  		
	  		  	
			//////////////////////////Printing Loop Query/////////////////////////////////////////////
			String newWorksQuery = "select distinct d.dname,c.programme_name,d.dcode,c.programme_code from rws_work_admn_tbl a,rws_district_tbl d,rws_programme_tbl c where substr(a.work_id,5,2)=d.dcode and substr(a.work_id,1,2)=c.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.WORK_CANCEL_DT  is null ";

	         if(dcode!=null && !dcode.equals("00"))
		  	  {
	        	 newWorksQuery+=" and d.DCODE='"+dcode+"'";
		  	  }

			  if(scheme!=null && !scheme.equals(""))
			  {
				  newWorksQuery+=" and a.type_of_asset in("+scheme+")";
			  }
			  if(category!=null && !category.equals("")){
				  newWorksQuery += " and a.special_cat='"+category+ "'";
	  	  					}
	  			  		
			newWorksQuery += " and c.programme_code in (" + programe+ ") group by d.dname,c.programme_name,d.dcode,c.programme_code order by d.dcode";
			
            System.out.println("19) Main query....... "+newWorksQuery);
			rs7 = stmt7.executeQuery(newWorksQuery);
			while (rs7.next()) {
				
				String programeCode=rs7.getString(4);                                                    
					if(scpop_works_hab_hash.get(rs7.getString(1)+ rs7.getString(2))!=null){
		
			
				String scpop = (String) scpop_works_hab_hash.get(rs7.getString(1)+ rs7.getString(2));
				String scpopValues[] = scpop.split("@");
				 workcountsc = Integer.parseInt(scpopValues[0]);
				 habcountsc = Integer.parseInt(scpopValues[1]);
				 scpopcountsc = Integer.parseInt(scpopValues[3]);
				 scpopcountst = Integer.parseInt(scpopValues[4]);
				 scpopcountp = Integer.parseInt(scpopValues[2]);
				 scSanctionedAmt=Double.parseDouble(scpopValues[5]);
				 scL13ExpenditureAmt=Double.parseDouble(scpopValues[6]);
				 scL14ExpenditureAmt=Double.parseDouble(scpopValues[7]);
				 
					 
				 
				 }
					if(sc_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
						scExpenditureAmtb=Double.parseDouble((String)sc_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
					
					if(sc_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
						scExpenditureAmt=Double.parseDouble((String)sc_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
					if(spillOverWorksHashsc.get(rs7.getString(3)+ rs7.getString(4))!=null){
						scspillSanctionedAmt=Double.parseDouble((String)spillOverWorksHashsc.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
					//tender hash table
					if(tenderHashsc.get(rs7.getString(1)+ rs7.getString(2))!=null){
						
						
						String tscpop = (String) tenderHashsc.get(rs7.getString(1)+ rs7.getString(2));
						String tscpopValues[] = tscpop.split("@");
						 tworkcountsc = Integer.parseInt(tscpopValues[0]);
						 tscSanctionedAmt=Double.parseDouble(tscpopValues[1]);
						 
						 tscpopcountsc = Integer.parseInt(tscpopValues[3]);
						 tscpopcountst = Integer.parseInt(tscpopValues[4]);
						 tscpopcountp = Integer.parseInt(tscpopValues[2]);
						 double sstscSanctionedAmt=0.0;
						 int totalsc=tscpopcountsc+tscpopcountst+tscpopcountp;
						 if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){

						sstscSanctionedAmt=0.5*tscSanctionedAmt;}
						 if(totalsc==0){
								sctenderestsc=0;sctenderestst=0;sctenderestp=0;
							}else{
								sctenderestsc=(sstscSanctionedAmt/totalsc)*tscpopcountsc;
								sctenderestst=(sstscSanctionedAmt/totalsc)*tscpopcountst;
								sctenderestp=(sstscSanctionedAmt/totalsc)*tscpopcountp;
							}
						 }
					
					 if(workscomptdHashsc.get(rs7.getString(1)+ rs7.getString(2))!=null){
							
							
							String workssc = (String) workscomptdHashsc.get(rs7.getString(1)+ rs7.getString(2));
							String worksscValues[] = workssc.split("@");
							comptdworkcountsc = Integer.parseInt(worksscValues[0]);
							comptdscSanctionedAmt=Double.parseDouble(worksscValues[1]);
							comptdhabcountsc = Integer.parseInt(worksscValues[2]);
							comptdscpopcountsc = Integer.parseInt(worksscValues[4]);
							comptdscpopcountst = Integer.parseInt(worksscValues[5]);
							comptdscpopcountp = Integer.parseInt(worksscValues[3]);
							 int worktotalsc=comptdscpopcountsc+comptdscpopcountst+comptdscpopcountp;
							 double sscomptdscSanctionedAmt=0.0;
							 if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
								 sscomptdscSanctionedAmt=0.5*comptdscSanctionedAmt;
							 }
							  
							 if(worktotalsc==0){
									scworkestsc=0;scworkestst=0;scworkestp=0;
								}else{
									scworkestsc=(sscomptdscSanctionedAmt/worktotalsc)*comptdscpopcountsc;
									scworkestst=(sscomptdscSanctionedAmt/worktotalsc)*comptdscpopcountst;
									scworkestp=(sscomptdscSanctionedAmt/worktotalsc)*comptdscpopcountp;
								}
							 }	
					
		               scEstcost2= scspillSanctionedAmt-scExpenditureAmtb;
		               System.out.println("befor  1>"+scEstcost2+"   2>"+scExpenditureAmt+"  3>"+scL13ExpenditureAmt+"  4>"+scL14ExpenditureAmt);
		               System.out.println("------programeCode-------"+programeCode);
		               if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
							
						 ssscEstcost2=0.5*scEstcost2;
						 ssscExpenditureAmt=0.5*scExpenditureAmt;
						 ssscL13ExpenditureAmt=0.5*scL13ExpenditureAmt;
						 ssscL14ExpenditureAmt=0.5*scL14ExpenditureAmt;
						 System.out.println("after 1>"+scEstcost2+" 2> "+scExpenditureAmt+" 3>"+scL13ExpenditureAmt+" 4>"+scL14ExpenditureAmt);
						}
						

					 int totpopsc=scpopcountsc+scpopcountst+scpopcountp;
					 if(totpopsc==0){
						 scL13expscshare=0.0;
						 scL14expstshare=0.0;
						 scexpscshare=0.0;
						 scexpstshare=0.0;
						 scestcostscshare=0.0;
						 scestcoststshare=0.0;
						 scestcostscshare=0.0;
						 scestcoststshare=0.0;
					 }
					 else
					 {
						 scL13expscshare=(ssscL13ExpenditureAmt*scpopcountsc)/totpopsc;
						 scL13expstshare=(ssscL13ExpenditureAmt*scpopcountst)/totpopsc;
						 scL14expscshare=(ssscL14ExpenditureAmt*scpopcountsc)/totpopsc;
						 scL14expstshare=(ssscL14ExpenditureAmt*scpopcountst)/totpopsc;
						 scexpscshare=(ssscExpenditureAmt*scpopcountsc)/totpopsc;
						 scexpstshare=(ssscExpenditureAmt*scpopcountst)/totpopsc;
						 scestcostscshare=(ssscEstcost2*scpopcountsc)/totpopsc;
						 scestcoststshare=(ssscEstcost2*scpopcountst)/totpopsc;
					 }
					
					
					
//***sc complete*******

					if(stpop_works_hab_hash.get(rs7.getString(1)+ rs7.getString(2))!=null){
						
						
						String stpop = (String) stpop_works_hab_hash.get(rs7.getString(1)+ rs7.getString(2));
						String stpopValues[] = stpop.split("@");
						 workcountst = Integer.parseInt(stpopValues[0]);
						 habcountst= Integer.parseInt(stpopValues[1]);
						 stpopcountsc = Integer.parseInt(stpopValues[3]);
						 stpopcountst = Integer.parseInt(stpopValues[4]);
						 stpopcountp = Integer.parseInt(stpopValues[2]);
						 stSanctionedAmt=Double.parseDouble(stpopValues[5]);
						 stL13ExpenditureAmt=Double.parseDouble(stpopValues[6]);
						 stL14ExpenditureAmt=Double.parseDouble(stpopValues[7]);
						
					}
				
					if(st_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
						stExpenditureAmtb=Double.parseDouble((String)st_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
					
					if(st_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
						stExpenditureAmt=Double.parseDouble((String)st_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
					if(spillOverWorksHashst.get(rs7.getString(3)+ rs7.getString(4))!=null){
						stspillSanctionedAmt=Double.parseDouble((String)spillOverWorksHashst.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
if(tenderHashst.get(rs7.getString(1)+ rs7.getString(2))!=null){
						
						
						String tstpop = (String) tenderHashst.get(rs7.getString(1)+ rs7.getString(2));
						String tstpopValues[] = tstpop.split("@");
						 tworkcountst = Integer.parseInt(tstpopValues[0]);
						 tstSanctionedAmt=Double.parseDouble(tstpopValues[1]);
						 
						 tstpopcountsc = Integer.parseInt(tstpopValues[3]);
						 tstpopcountst = Integer.parseInt(tstpopValues[4]);
						 tstpopcountp = Integer.parseInt(tstpopValues[2]);
						 double sststSanctionedAmt=0.0;
						 if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
							 sststSanctionedAmt=0.5*tstSanctionedAmt;
						 }
						int totalst=tstpopcountsc+tstpopcountst+tstpopcountp;
						 if(totalst==0){
								sttenderestsc=0;sttenderestst=0;sttenderestp=0;
							}else{
								sttenderestsc=(sststSanctionedAmt/totalst)*tstpopcountsc;
								sttenderestst=(sststSanctionedAmt/totalst)*tstpopcountst;
								sttenderestp=(sststSanctionedAmt/totalst)*tstpopcountp;
							}
						 }

if(workscomptdHashst.get(rs7.getString(1)+ rs7.getString(2))!=null){
	
	
	String worksst = (String) workscomptdHashst.get(rs7.getString(1)+ rs7.getString(2));
	String worksstValues[] = worksst.split("@");
	comptdworkcountsc = Integer.parseInt(worksstValues[0]);
	comptdstSanctionedAmt=Double.parseDouble(worksstValues[1]);
	comptdhabcountst = Integer.parseInt(worksstValues[2]);
	comptdstpopcountsc = Integer.parseInt(worksstValues[4]);
	comptdstpopcountst = Integer.parseInt(worksstValues[5]);
	comptdstpopcountp = Integer.parseInt(worksstValues[3]);
	 int worktotalst=comptdstpopcountsc+comptdstpopcountst+comptdstpopcountp;
	 double sscomptdstSanctionedAmt=0.0;
	 if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
		 sscomptdstSanctionedAmt=0.5*comptdstSanctionedAmt;
	 }
	 if(worktotalst==0){
			stworkestsc=0;stworkestst=0;stworkestp=0;
		}else{
			stworkestsc=(sscomptdstSanctionedAmt/worktotalst)*comptdstpopcountsc;
			stworkestst=(sscomptdstSanctionedAmt/worktotalst)*comptdstpopcountst;
			stworkestp=(sscomptdstSanctionedAmt/worktotalst)*comptdstpopcountp;
		}
	 }
stEstcost2= stspillSanctionedAmt-stExpenditureAmtb;
if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
	
	 ssstEstcost2=0.5*stEstcost2;
	 ssstL13ExpenditureAmt=0.5*stL13ExpenditureAmt;
	 ssstL14ExpenditureAmt=0.5*stL14ExpenditureAmt;
	 ssstExpenditureAmt=0.5*stExpenditureAmt;
	}
	
int totpopst=stpopcountsc+stpopcountst+stpopcountp;
if(totpopst==0){
	 stL13expscshare=0.0;
	 stL14expstshare=0.0;
	 stexpscshare=0.0;
	 stexpstshare=0.0;
	 stestcostscshare=0.0;
	 stestcoststshare=0.0;
	 stestcostscshare=0.0;
	 stestcoststshare=0.0;

}
else
{
	 stL13expscshare=(ssstL13ExpenditureAmt*stpopcountsc)/totpopst;
	 stL13expstshare=(ssstL13ExpenditureAmt*stpopcountst)/totpopst;
	 stL14expscshare=(ssstL14ExpenditureAmt*stpopcountsc)/totpopst;
	 stL14expstshare=(ssstL14ExpenditureAmt*stpopcountst)/totpopst;
	 stexpscshare=(ssstExpenditureAmt*stpopcountsc)/totpopst;
	 stexpstshare=(ssstExpenditureAmt*stpopcountst)/totpopst;
	 stestcostscshare=(ssstEstcost2*stpopcountsc)/totpopst;
	 stestcoststshare=(ssstEstcost2*stpopcountst)/totpopst;
}


					//st complet
                if(ppop_works_hab_hash.get(rs7.getString(1)+ rs7.getString(2))!=null){
						
						
						String ppop = (String) ppop_works_hab_hash.get(rs7.getString(1)+ rs7.getString(2));
						String ppopValues[] = ppop.split("@");
						 workcountp = Integer.parseInt(ppopValues[0]);
						 habcountp= Integer.parseInt(ppopValues[1]);
						 ppopcountsc = Integer.parseInt(ppopValues[3]);
						 ppopcountst = Integer.parseInt(ppopValues[4]);
						 ppopcountp = Integer.parseInt(ppopValues[2]);
						 pSanctionedAmt=Double.parseDouble(ppopValues[5]);
						 pL13ExpenditureAmt=Double.parseDouble(ppopValues[6]);
						 pL14ExpenditureAmt=Double.parseDouble(ppopValues[7]);		 
                }
                if(p_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
					pExpenditureAmtb=Double.parseDouble((String)p_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
				
				}
				
                if(p_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
					pExpenditureAmt=Double.parseDouble((String)p_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
				
				}
                
                if(spillOverWorksHashp.get(rs7.getString(3)+ rs7.getString(4))!=null){
					pspillSanctionedAmt=Double.parseDouble((String)spillOverWorksHashp.get(rs7.getString(3)+ rs7.getString(4)));
				
				}
                if(tenderHashp.get(rs7.getString(1)+ rs7.getString(2))!=null){
					
					
					String tppop = (String) tenderHashp.get(rs7.getString(1)+ rs7.getString(2));
					String tppopValues[] = tppop.split("@");
					 tworkcountp = Integer.parseInt(tppopValues[0]);
					 tpSanctionedAmt=Double.parseDouble(tppopValues[1]);
					 
					 tppopcountsc = Integer.parseInt(tppopValues[3]);
					 tppopcountst = Integer.parseInt(tppopValues[4]);
					 tppopcountp = Integer.parseInt(tppopValues[2]);
					 int totalp=tppopcountsc+tppopcountst+tppopcountp;
					 double sstpSanctionedAmt=0.0;
					 if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
						 sstpSanctionedAmt=0.5*tpSanctionedAmt;	
					 }
					 if(totalp==0)
					 {
							ptenderestsc=0;ptenderestst=0;ptenderestp=0;
						}else{
							ptenderestsc=(sstpSanctionedAmt/totalp)*tppopcountsc;
							ptenderestst=(sstpSanctionedAmt/totalp)*tppopcountst;
							ptenderestp=(sstpSanctionedAmt/totalp)*tppopcountp;
						}
					 }
                if(workscomptdHashp.get(rs7.getString(1)+ rs7.getString(2))!=null){
					
					
					String worksp = (String) workscomptdHashp.get(rs7.getString(1)+ rs7.getString(2));
					String workspValues[] = worksp.split("@");
					comptdworkcountp = Integer.parseInt(workspValues[0]);
					comptdpSanctionedAmt=Double.parseDouble(workspValues[1]);
					comptdhabcountp = Integer.parseInt(workspValues[2]);
					comptdppopcountsc = Integer.parseInt(workspValues[4]);
					comptdppopcountst = Integer.parseInt(workspValues[5]);
					comptdppopcountp = Integer.parseInt(workspValues[3]);
					 int worktotalst=comptdppopcountsc+comptdppopcountst+comptdppopcountp;
					 double sscomptdpSanctionedAmt=0.0;
					 if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
						 sscomptdpSanctionedAmt=0.5*comptdpSanctionedAmt;
					 }
					 if(worktotalst==0){
							pworkestsc=0;pworkestst=0;pworkestp=0;
						}else{
							pworkestsc=(sscomptdpSanctionedAmt/worktotalst)*comptdppopcountsc;
							pworkestst=(sscomptdpSanctionedAmt/worktotalst)*comptdppopcountst;
							pworkestp=(sscomptdpSanctionedAmt/worktotalst)*comptdppopcountp;
						}
					 }
                pEstcost2=  pspillSanctionedAmt-pExpenditureAmtb;
                if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
					
					 sspEstcost2=0.5*pEstcost2;
					 sspL13ExpenditureAmt=0.5*pL13ExpenditureAmt;
					 sspL14ExpenditureAmt=0.5*pL14ExpenditureAmt;
					 sspExpenditureAmt=0.5*pExpenditureAmt;
					}
					
                int totpopp=ppopcountsc+ppopcountst+ppopcountp;
				 if(totpopp==0){
					 pL13expscshare=0.0;
					 pL13expstshare=0.0;
					 pL14expscshare=0.0;
					 pL14expstshare=0.0;
					
					 pexpscshare=0.0;
					 pexpstshare=0.0;
					 pestcostscshare=0.0;
					 pestcoststshare=0.0;
				 }
				 else
				 {
					 pL13expscshare=(sspL13ExpenditureAmt*ppopcountsc)/totpopp;
					 pL13expstshare=(sspL13ExpenditureAmt*ppopcountst)/totpopp;
					 pL14expscshare=(sspL14ExpenditureAmt*ppopcountsc)/totpopp;
					 pL14expstshare=(sspL14ExpenditureAmt*ppopcountst)/totpopp;
					 pexpscshare=(sspExpenditureAmt*ppopcountsc)/totpopp;
					 pexpstshare=(sspExpenditureAmt*ppopcountst)/totpopp;
					 pestcostscshare=(sspEstcost2*ppopcountsc)/totpopp;
					 pestcoststshare=(sspEstcost2*ppopcountst)/totpopp; 
				 }
				
				//plain complet
                System.out.println("scamt"+scspillSanctionedAmt);
                System.out.println("scexp"+scExpenditureAmtb);
                System.out.println("stamt"+stspillSanctionedAmt);
                System.out.println("stexp"+stExpenditureAmtb);
                System.out.println("pamt"+pspillSanctionedAmt);
             
                System.out.println("pexp"+pExpenditureAmtb);
              // scEstcost1=scSanctionedAmt-scspillSanctionedAmt;
               //stEstcost1=stSanctionedAmt-stspillSanctionedAmt;
               //pEstcost1=pSanctionedAmt-pspillSanctionedAmt;
          
               if(dname.equals(rs7.getString(1))||temp.equals(rs7.getString(1))){
            	   dname="-";
               }else{
            	   dname=rs7.getString(1);
               }
               
               /////
               double plainExpenditureAmt=0.0;
               double scstExpenditureAmt=0.0;
               double plainExpenditureAmtb=0.0;
               double scstExpenditureAmtb=0.0;
               if(plain_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
					plainExpenditureAmt=Double.parseDouble((String)plain_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
				
				}
               if(scst_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
					scstExpenditureAmt=Double.parseDouble((String)scst_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
				
				}
               if(plain_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
					plainExpenditureAmtb=Double.parseDouble((String)plain_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
				
				}
               if(scst_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){

					scstExpenditureAmtb=Double.parseDouble((String)scst_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
            	   
				}
               //////////////////////////
               int workscsthabcount=0;
               int workplainhabcount=0;
               int workscstpopsc=0;
               int workscstpopst=0;
               int workscstpopp=0;
               int workplainpopsc=0;
               int workplainpopst=0;
               int workplainpopp=0;
               int workplaintotal=0;
               int workscsttotal=0;
               double workscstl13exp=0.0;
               double workscstl14exp=0.0;
               double workplainl13exp=0.0;
               double workplainl14exp=0.0;
               int workplainhabpopp=0;
               int workplainhabpopsc=0;
               int workplainhabpopst=0;
               int workscsthabpopp=0;
               int workscsthabpopsc=0;
               int workscsthabpopst=0;
               int workscsttotworks=0;
               int workplaintotworks=0;
               double workscstsnamt=0.0;
               double workscstsnamtpshare=0.0;
               double workplainsnamt=0.0;
               double workplainsnamtpshare=0.0;
               if(works_compt_plain_hash.get(rs7.getString(1)+rs7.getString(2))!=null){
            	   
                 	  String workplainhabdet=(String)works_compt_plain_hash.get(rs7.getString(1)+rs7.getString(2));
                 	  String workplainhabdetvalues[]=workplainhabdet.split("@");
                	  workplaintotworks=Integer.parseInt(workplainhabdetvalues[0]);
                	  workplainhabcount=Integer.parseInt(workplainhabdetvalues[2]);
                	  workplainhabpopp=Integer.parseInt(workplainhabdetvalues[3]);
                	  workplainhabpopsc=Integer.parseInt(workplainhabdetvalues[4]);
                	  workplainhabpopst=Integer.parseInt(workplainhabdetvalues[5]);
                	  if(!workplainhabdetvalues[1].equals("null")){
                    	  workplainsnamt=Double.parseDouble(workplainhabdetvalues[1]);
                    	  int totalp=workplainhabpopp+workplainhabpopsc+workplainhabpopst;
                    	  workplainsnamtpshare=(workplainsnamt/totalp)*workplainhabpopp;
                          if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
                        	  workplainsnamtpshare=0.5*workplainsnamtpshare;
                          }}
               }
                	  if(works_compt_scst_hash.get(rs7.getString(1)+rs7.getString(2))!=null){
                   	   
                     	  String workscsthabdet=(String)works_compt_scst_hash.get(rs7.getString(1)+rs7.getString(2));
                     	  String workscsthabdetvalues[]=workscsthabdet.split("@");
                    	  workscsttotworks=Integer.parseInt(workscsthabdetvalues[0]);
                    	  workscsthabcount=Integer.parseInt(workscsthabdetvalues[2]);
                    	  workscsthabpopp=Integer.parseInt(workscsthabdetvalues[3]);
                    	  workscsthabpopsc=Integer.parseInt(workscsthabdetvalues[4]);
                    	  workscsthabpopst=Integer.parseInt(workscsthabdetvalues[5]);
                    	  if(!workscsthabdetvalues[1].equals("null")){
                        	  workscstsnamt=Double.parseDouble(workscsthabdetvalues[1]);
                        	  int totalp=workscsthabpopp+workscsthabpopsc+workscsthabpopst;
                        	  workscstsnamtpshare=(workscstsnamt/totalp)*workscsthabpopp;
                              if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
                            	  workscstsnamtpshare=0.5*workscstsnamtpshare;
                              }
                   }
               }
               /////////////////////////
               int scsthabcount=0;
               int plainhabcount=0;
               int scstpopsc=0;
               int scstpopst=0;
               int scstpopp=0;
               int plainpopsc=0;
               int plainpopst=0;
               int plainpopp=0;
               int plaintotal=0;
               int scsttotal=0;
               double scstl13exp=0.0;
               double scstl14exp=0.0;
               double plainl13exp=0.0;
               double plainl14exp=0.0;
               int plainhabpopp=0;
               int plainhabpopsc=0;
               int plainhabpopst=0;
               int scsthabpopp=0;
               int scsthabpopsc=0;
               int scsthabpopst=0;
               int scsttotworks=0;
               int plaintotworks=0;
               double scstsnamt=0.0;
               double scstsnamtpshare=0.0;
               double plainsnamt=0.0;
               double plainsnamtpshare=0.0;
               double plainexp=0.0;
               double scstexp=0.0;
               if(plain_habdet_hash.get(rs7.getString(1)+rs7.getString(2))!=null){
            	  String plainhabdet=(String)plain_habdet_hash.get(rs7.getString(1)+rs7.getString(2));
            	  String plainhabdetvalues[]=plainhabdet.split("@");
            	  plaintotworks=Integer.parseInt(plainhabdetvalues[0]);
            	  plainhabpopp=Integer.parseInt(plainhabdetvalues[2]);
            	  plainhabpopsc=Integer.parseInt(plainhabdetvalues[3]);
            	  plainhabpopst=Integer.parseInt(plainhabdetvalues[4]);
            	  if(!plainhabdetvalues[1].equals("null")){
            	  plainsnamt=Double.parseDouble(plainhabdetvalues[1]);
            	  int totalp=plainhabpopp+plainhabpopsc+plainhabpopst;
            	  plainsnamtpshare=(plainsnamt/totalp)*plainhabpopp;
                  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
                	  plainsnamtpshare=0.5*plainsnamtpshare;
                  }
            	  
            	  }
           }
            	  if(scst_habdet_hash.get(rs7.getString(1)+rs7.getString(2))!=null){
                	  String scsthabdet=(String)scst_habdet_hash.get(rs7.getString(1)+rs7.getString(2));
                	  String scsthabdetvalues[]=scsthabdet.split("@");
                	  scsttotworks=Integer.parseInt(scsthabdetvalues[0]);
                	  scsthabpopp=Integer.parseInt(scsthabdetvalues[2]);
                	  scsthabpopsc=Integer.parseInt(scsthabdetvalues[3]);
                	  scsthabpopst=Integer.parseInt(scsthabdetvalues[4]);
                	  if(!scsthabdetvalues[1].equals("null")){
                	  scstsnamt=Double.parseDouble(scsthabdetvalues[1]);
                	  int totalp=scsthabpopp+scsthabpopsc+scsthabpopst;
                	  scstsnamtpshare=(scstsnamt/totalp)*scsthabpopp;
                	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
                		  scstsnamtpshare=0.5*scstsnamtpshare;
                      }
                	  }
            	  
               }
               if(plain_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
            		   {
            	   System.out.println("hi this is plain");
            	   String plainpop = (String) plain_hash.get(rs7.getString(1)+rs7.getString(2));
					String plainpopValues[] = plainpop.split("@");
            	   plainhabcount=Integer.parseInt(plainpopValues[0]);
            	   System.out.println("plainhabcount is "+plainhabcount);
            	   plainpopp=Integer.parseInt(plainpopValues[1]);
            	   plainpopsc=Integer.parseInt(plainpopValues[2]);
            	   plainpopst=Integer.parseInt(plainpopValues[3]);
            	   if(!plainpopValues[4].equals("null")){
            	   plainl13exp=Double.parseDouble(plainpopValues[4]);}
            	   if(!plainpopValues[5].equals("null")){
            	   plainl14exp=Double.parseDouble(plainpopValues[5]);}
            	   if(!plainpopValues[6].equals("null")){
                	   plainexp=Double.parseDouble(plainpopValues[6]);}
            	   plaintotal=plainpopsc+plainpopst+plainpopp;
               }
               if(plain_scst_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
               {
            	   System.out.println("hi this is scst");
            	   String scstpop = (String) plain_scst_hash.get(rs7.getString(1)+rs7.getString(2));
					String scstpopValues[] = scstpop.split("@");
					scsthabcount=Integer.parseInt(scstpopValues[0]);
           	 System.out.println("scsthabcount is "+plainhabcount);
           	   scstpopp=Integer.parseInt(scstpopValues[1]); 
           	 
           	   scstpopsc=Integer.parseInt(scstpopValues[2]);
           	   scstpopst=Integer.parseInt(scstpopValues[3]);
              	

           	 scsttotal=scstpopsc+scstpopst+scstpopp;
           	 if(!scstpopValues[4].equals("null")){
           	scstl13exp=Double.parseDouble(scstpopValues[4]);}
           	System.out.println("scsthabcount is2 "+scstl13exp);
            if(!scstpopValues[5].equals("null")){
     	   scstl14exp=Double.parseDouble(scstpopValues[5]);}
     	  System.out.println("scsthabcount is3 "+scstl14exp);
     	 if(!scstpopValues[6].equals("null")){
      	   scstexp=Double.parseDouble(scstpopValues[6]);}
                            }
               double plainsanctionamount=plainexp-plainExpenditureAmtb;
               double scstsanctionamount=scstexp-scstExpenditureAmtb;
            		   
	%>
	<tr>
		<td rowspan="6" class=<%=style%>><%=++recCount%></td>

		<td rowspan="6" class="gridbg1" style="text-align: left;"><%=dname%></td>
		<td rowspan="6" class="gridbg1" style="text-align: left;"><%=rs7.getString(2)%></td>
		<td class="gridbg1" style="text-align: center;">SC>40%</td>

		<td class="gridbg1" style="text-align: right;"><%=workcountsc%></td>

		<td class="gridbg1" style="text-align: right;"><%=habcountsc %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scEstcost2) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scestcostscshare) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scexpscshare) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1"  style="text-align: right;"><%=scpopcountsc+scpopcountst+scpopcountp%></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountsc %></td>
		<td class="gridbg1"  style="text-align: right;"><%=scpopcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tworkcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tscSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sctenderestsc) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		
		<td class="gridbg1" style="text-align: right;"><%=comptdworkcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdscpopcountsc %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(comptdscSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scworkestsc) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=scL13ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13expscshare) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=scL14ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14expscshare) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
	</tr>
	
	<tr>
		<td class="gridbg1" style="text-align: center;">ST>40%</td>

		<td class="gridbg1" style="text-align: right;"><%=workcountst%></td>
        <td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=habcountst %></td>
		
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stEstcost2) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stestcoststshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stexpstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=stpopcountsc+stpopcountst+stpopcountp %></td>
		<td class="gridbg1" style="text-align: right;"><%=stpopcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=stpopcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tworkcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tstSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sttenderestst) %></td>
		
	
		<td class="gridbg1" style="text-align: right;"><%=comptdworkcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountst %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=comptdstpopcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(comptdstSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stworkestst) %></td>
		<td class="gridbg1" style="text-align: right;"><%=stL13ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL13expstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=stL14ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL14expstshare) %></td>
</tr>
	<tr>
		<td class="gridbg1" style="text-align: center;">Plain>40%</td>

		<td class="gridbg1" style="text-align: right;"><%=workcountp%></td>
       <td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		
		<td class="gridbg1" style="text-align: right;"><%=habcountp %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(pEstcost2) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(pExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	
		<td class="gridbg1" style="text-align: right;"><%=ppopcountsc+ppopcountst+ppopcountp %></td>
		<td class="gridbg1" style="text-align: right;"><%=ppopcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=ppopcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tworkcountp %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tpSanctionedAmt) %></td>
				<td class="gridbg1" style="text-align: right;"><%=ndf.format(ptenderestp) %></td>
		
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	
		<td class="gridbg1" style="text-align: right;"><%=comptdworkcountp %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountp %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(comptdpSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(pworkestp) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=pL13ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=pL14ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	</tr>
	
	<tr>
		<td class="gridbg1" style="text-align: center;"><40%</td>

		<td class="gridbg1" style="text-align: right;"><%=scstWorks.size() %></td>
       <td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		
		<td class="gridbg1" style="text-align: right;"><%=scsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstsanctionamount) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	
		<td class="gridbg1" style="text-align: right;"><%=scsttotal %></td>
		<td class="gridbg1" style="text-align: right;"><%=scstpopsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=scstpopst %></td>
		<td class="gridbg1" style="text-align: right;"><%=scsttotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstsnamt) %></td>
				<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstsnamtpshare) %></td>
		
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	
		<td class="gridbg1" style="text-align: right;"><%=workscsttotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=workscsthabcount %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workscstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workscstsnamtpshare) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=scstl13exp %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=scstl14exp %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	</tr>
	<tr>
		<td class="gridbg1" style="text-align: center;">Plain</td>

		<td class="gridbg1" style="text-align: right;"><%=PSPWorks.size() %></td>
       <td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		
		<td class="gridbg1" style="text-align: right;"><%=plainhabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainsanctionamount) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	
		<td class="gridbg1" style="text-align: right;"><%=plainpopp %></td>
		<td class="gridbg1" style="text-align: right;"><%=plainpopsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=plainpopst %></td>
		<td class="gridbg1" style="text-align: right;"><%=plaintotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainsnamt) %></td>
				<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainsnamtpshare) %></td>
		
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	
		<td class="gridbg1" style="text-align: right;"><%=workplaintotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=workplainhabcount %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workplainsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workplainsnamtpshare) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=plainl13exp %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=plainl14exp %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	</tr>
	<tr>
		<td class="gridbg1" style="text-align: center;">Sub Total</td>

		<td class="gridbg1" style="text-align: right;"><%=workcountsc+workcountst+workcountp+scstWorks.size()+PSPWorks.size()%></td>

		<td class="gridbg1" style="text-align: right;"><%=habcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=habcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=habcountp+plainhabcount+scsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scEstcost2+stEstcost2+pEstcost2+plainsanctionamount+scstsanctionamount) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scestcostscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stestcoststshare) %></td>
		
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scExpenditureAmt+stExpenditureAmt+pExpenditureAmt+plainExpenditureAmt+scstExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scexpscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stexpstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountsc+scpopcountst+scpopcountp+stpopcountsc+stpopcountst+stpopcountp+ppopcountsc+ppopcountst+ppopcountp %></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountsc+stpopcountsc+ppopcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountst+stpopcountst+ppopcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tworkcountsc+tworkcountst+tworkcountp+scsttotworks+plaintotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tscSanctionedAmt+tstSanctionedAmt+tpSanctionedAmt+plainsnamt+scstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(ptenderestp+plainsnamtpshare+scstsnamtpshare) %> </td>
        <td class="gridbg1" style="text-align: right;"><%=ndf.format(sctenderestsc) %> </td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sttenderestst) %> </td>
		<td class="gridbg1" style="text-align: right;"><%=comptdworkcountsc+comptdworkcountst+comptdworkcountp+workplaintotworks+workscsttotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountsc+comptdhabcountst+comptdhabcountp+workplainhabcount+workscsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdscpopcountsc%></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdstpopcountst%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(comptdscSanctionedAmt+comptdscSanctionedAmt+comptdpSanctionedAmt+workplainsnamt+workscstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(pworkestp+workplainsnamtpshare+workscstsnamtpshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scworkestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stworkestst) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13ExpenditureAmt+stL13ExpenditureAmt+pL13ExpenditureAmt+plainl13exp+scstl13exp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13expscshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL13expstshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14ExpenditureAmt+stL14ExpenditureAmt+pL14ExpenditureAmt+plainl14exp+scstl14exp)  %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14expscshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL14expstshare)%></td>
		</tr>



	<%
	
	temp=rs7.getString(1);
         
			}
			
	%>






	<%
	if(stmt7!=null){
		stmt7.close();
	}
	if(rs7!=null){
		rs7.close();
	}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</table>
</body>
</html>