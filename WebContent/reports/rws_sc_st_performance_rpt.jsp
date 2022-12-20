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
	//System.out.println("Changing");
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
    session.setAttribute("category",category);
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
			<td class="bwborder"><a href="./rws_sc_st_performance_frm.jsp">Back|</a><a href="./rws_sc_st_performance_excel.jsp">Excel</a>
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
		<td align="center" class="gridhdbg" colspan="36">SC/ST Performance Report for(<%=financialstartyr%>)</td>
	</tr>
	<tr>
	<td align="center" class="gridhdbg" rowspan="4">Sl.No</td>
	<td align="center" class="gridhdbg" rowspan="4">District</td>
<td align="center" class="gridhdbg" rowspan="4">Program</td>
	<td align="center" class="gridhdbg" rowspan="4">Percentage</td>
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
	<td align="center" class="gridhdbg" rowspan="2">SC</td>
	<td align="center" class="gridhdbg" rowspan="2">ST</td>

	<td align="center" class="gridhdbg" rowspan="2">Other Habs</td>
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
		Statement stmt2 = null, stmt3 = null,stmt4=null,stmt5=null,stmt7 = null,stmt8=null,stmt9=null;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null, rs9 = null, rs10 = null, rs11 = null, rs12 = null, rs13 = null, rs14 = null, rs15 = null,rs16=null,rs17=null,rs18=null,rs19=null,rs20=null,rs21=null,rs22=null, rs23= null, rs24 = null, rs25 = null,rs26 = null,rs27 = null, rs28 = null,rs29 = null,rs30 = null,rs31 = null,rs32 = null,rs33 = null,rs34 = null,rs35 = null,rs36 = null,rs37=null,rs38=null,rs39=null,rs40=null;
		int count = 1;
		String temp="";
		List gWorks = new ArrayList();
		List SCSPWorks1 = new ArrayList();
		List PSPWorks = new ArrayList();
		List scstWorks = new ArrayList();
		try {

			stmt2 = conn.createStatement();
			int gncount = 0, gscount = 0, ghcount = 0, gschcount = 0, newtotpop = 0, spilltotpop = 0, scsptotpop = 0;
			double plainPop = 0, scPop = 0, stPop = 0;
			double plainPop1 = 0, scPop1 = 0, stPop1 = 0;

			double plainPer = 0, scPer = 0, stPer = 0;
			double plainPer1 = 0, scPer1 = 0, stPer1 = 0;

			double totPop = 0, totPop1 = 0;
            
			
			 int styleCount = 0;
			String style = "";
			

			boolean flag = false;

			int nWorkCount = 0, sWorkCount = 0, nstWorkCount = 0, sstWorkCount = 0, pWorkCount = 0, pnWorkCount = 0, habcount = 0, gsctencount = 0, tencount = 0, gcompcount = 0, compcount = 0, gcomphabcount = 0, comphabcount = 0;

			
			//double pL13expscshare=0.0,pL14expstshare=0.0,pexpscshare=0.0,pexpstshare=0.0,pestcostscshare=0.0,pestcoststshare=0.0;
			String dname = "";
			String myWorkList = "", myWorkList1 = "", myWorkList2 = "";
			
			//<40% and only plain
Hashtable plain_works_count = new Hashtable();
Hashtable scst_works_count = new Hashtable();
Hashtable works_scpop_hash = new Hashtable();
Hashtable works_stpop_hash = new Hashtable();
Hashtable works_ppop_hash = new Hashtable();
String createqry="create table rws_sc_st_performance_temp_tbl(work_id varchar2(14),type varchar2(1))";
stmt8=conn.createStatement();
rs40=stmt8.executeQuery("select tname from tab where tname like '%PERFORMANCE_TEMP_TBL'");
if(rs40.next()){
	stmt9=conn.createStatement();
	stmt9.executeUpdate("drop table rws_sc_st_performance_temp_tbl");
	if(stmt9!=null)
	{
		stmt9.close();
	}
	
}
if(stmt8!=null)
{
	stmt8.close();
}
if(rs40!=null)
{
	rs40.close();
}
stmt4=conn.createStatement();
stmt4.executeUpdate(createqry);
if(stmt4!=null)
{
	stmt4.close();
}
//System.out.println("create qry"+createqry);
stmt2=conn.createStatement();
String mainQuery="select distinct b.dcode,b.dname,a.work_id,substr(a.work_id,1,2),e.programme_name,sum(CENSUS_PLAIN_POPU),sum(CENSUS_SC_POPU),sum(CENSUS_ST_POPU) from rws_work_admn_tbl a,rws_district_tbl b,rws_admn_hab_lnk_tbl c,rws_habitation_directory_tbl d ,rws_programme_tbl e  where substr(a.work_id,5,2)=b.dcode and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null and a.work_id=c.work_id and c.hab_code=d.hab_code and substr(a.work_id,1,2)=e.programme_code and d.coverage_status<>'UI'  ";



 
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
mainQuery+=" and substr(a.work_id,1,2)=e.programme_code  and e.programme_code in ("+programe+") group by b.dcode,b.dname,a.work_id,substr(a.work_id,1,2),e.programme_name order by  dcode  ";


//System.out.println("Main query............"+mainQuery);
rs2=stmt2.executeQuery(mainQuery);
String[] s;
String[] p;
int size1=0;
int size2=0;
int size3=0;
int scpopul=0;
int stpopl=0;
//start printing
while(rs2.next())
{
String ddCode=rs2.getString(1);

	
String key=rs2.getString(3);

//System.out.println("my key..............."+key);

plainPop=Double.parseDouble(rs2.getString(6));
	scPop=Double.parseDouble(rs2.getString(7));
	stPop=Double.parseDouble(rs2.getString(8));
	scpopul=rs2.getInt(7);
	stpopl=rs2.getInt(8);
	
	totPop=plainPop+scPop+stPop;
	
	plainPer = (plainPop * 100/ totPop);
	scPer = (scPop * 100/ totPop);
	stPer = (stPop * 100/ totPop);
	
	//System.out.println("my pop..............."+totPop+"....."+scPop);
	//System.out.println("my SCper..............."+scPer+rs2.getString(3));

if(scPer==0 && stPer==0)
{
	works_scpop_hash.put(rs2.getString(2)+rs2.getString(5)+rs2.getString(3),rs2.getInt(7));
	works_ppop_hash.put(rs2.getString(2)+rs2.getString(5)+rs2.getString(3),rs2.getInt(6));
	works_stpop_hash.put(rs2.getString(2)+rs2.getString(5)+rs2.getString(3),rs2.getInt(8));
		
	PSPWorks.add(rs2.getString(3));
	//System.out.println("my workids..............."+SCSPWorks.toString());
	myWorkList=PSPWorks.toString();
	myWorkList=myWorkList.replace("[", "(" );
	myWorkList=myWorkList.replace("]", ")" );
	//System.out.println("my workids21243435..............."+myWorkList);
	//session.setAttribute("myList",myWorkList);	
    
	String insertQuery1="insert into  rws_sc_st_performance_temp_tbl values ('"+rs2.getString(3)+"','P')";
	stmt3=conn.createStatement();
	stmt3.executeUpdate(insertQuery1);
	if(stmt3!=null)
	{
		stmt3.close();
	}
	//System.out.println("sss"+insertQuery1);
}

if(scPer!=0.0 || stPer!=0.0)
{
	if(scPer<40 && stPer<40){
	//works_scpop_hash.put(rs2.getString(2)+rs2.getString(5)+rs2.getString(3),rs2.getInt(7));
	//works_ppop_hash.put(rs2.getString(2)+rs2.getString(5)+rs2.getString(3),rs2.getInt(6));
	//works_stpop_hash.put(rs2.getString(2)+rs2.getString(5)+rs2.getString(3),rs2.getInt(8));
		//System.out.println("sc percentage..............."+scPer+"----sc population "+rs2.getInt(7));
		//System.out.println("work_id is "+rs2.getString(3));

	scstWorks.add(rs2.getString(3));
	myWorkList1=scstWorks.toString();
	myWorkList1=myWorkList1.replace("[", "(" );
	myWorkList1=myWorkList1.replace("]", ")" );
	String insertQuery1="insert into  rws_sc_st_performance_temp_tbl values ('"+rs2.getString(3)+"','S')";
	stmt3=conn.createStatement();
	stmt3.executeUpdate(insertQuery1);
	if(stmt3!=null)
	{
		stmt3.close();
	}}
    //session.setAttribute("myList1",myWorkList1);
}
if(scPer>40 && stPer>40 )
{
	//works_scpop_hash.put(rs2.getString(2)+rs2.getString(5)+rs2.getString(3),rs2.getInt(7));
	//works_ppop_hash.put(rs2.getString(2)+rs2.getString(5)+rs2.getString(3),rs2.getInt(6));
	//works_stpop_hash.put(rs2.getString(2)+rs2.getString(5)+rs2.getString(3),rs2.getInt(8));
	
	gWorks.add(rs2.getString(3));
	//System.out.println("my workids..............."+SCSPWorks.toString());
	myWorkList2=gWorks.toString();
	myWorkList2=myWorkList2.replace("[", "(" );
	myWorkList2=myWorkList2.replace("]", ")" );
   
    //session.setAttribute("myList1",myWorkList1);
}
//System.out.println();

}

//System.out.println("PSPWorks size is.............."+size1);
//System.out.println("scstWorks size is.............."+size2);
if(stmt2!=null){
stmt2.close();
}
if(rs2!=null){
rs2.close();
}


////
stmt3 = conn.createStatement();

String habs="select  d.dname,p.programme_name,count(l.hab_code),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join rws_admn_hab_lnk_tbl l on (w.work_id=l.work_id) left join rws_habitation_directory_tbl hd on(l.hab_code=hd.hab_code) left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id) where  ";

	       
	        if (dcode != null && !dcode.equals("00")) {
	        	habs+= " substr(w.work_id,5,2)='" + dcode + "' and";
					}

					if (scheme != null && !scheme.equals("")) {
						habs+= "  w.type_of_asset in(" + scheme + ") ";
					}
					
					if(category!=null && !category.equals("")){
						habs += " and w.special_cat='" + category + "'";
					}
					 habs+="and  substr(w.work_id,1,2) in ("+programe+") and temp.type='P'  and hd.coverage_status<>'UI' group by d.dname,p.programme_name";
				// System.out.println("plainhabs ............"+habs); 
	        Hashtable plain_hash = new Hashtable();
	        if(PSPWorks.size()!=0){
	            rs23=stmt3.executeQuery(habs);
	        	while(rs23.next())
	        	{
	        		
	        	
	        		plain_hash.put(rs23.getString(1)+rs23.getString(2),rs23.getInt(3)+"@"+rs23.getInt(4)+"@"+rs23.getInt(5)+"@"+rs23.getInt(6));
	        		//System.out.println("hab count is"+rs23.getInt(3));
	        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

	        	}}
	        	if(stmt3!=null){
	        		stmt3.close();
	        	}
	        	if(rs23!=null){
	        		rs23.close();
	        	}
				
	     //System.out.println("plain habsllll ............"+habs);

///////works and sanction amount
stmt3 = conn.createStatement();
	        	String works="select  d.dname,p.programme_name,count(distinct w.work_id),sum(prob_exp),sum(prob_exp_nxt_yr),sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id) where  ";
	        	
	 	       
		        if (dcode != null && !dcode.equals("00")) {
		        	works+= " substr(w.work_id,5,2)='" + dcode + "' and";
						}

						if (scheme != null && !scheme.equals("")) {
							works+= "  w.type_of_asset in(" + scheme + ") ";
						}
						
						if(category!=null && !category.equals("")){
							works += " and w.special_cat='" + category + "'";
						}
						works+="and  substr(w.work_id,1,2) in ("+programe+") and temp.type='P' group by d.dname,p.programme_name";
					 //System.out.println("plain works ............"+works); 
		        Hashtable works_plain_hash = new Hashtable();
		        if(PSPWorks.size()!=0){
		            rs24=stmt3.executeQuery(works);
		        	while(rs24.next())
		        	{
		        		
		        	
		        		works_plain_hash.put(rs24.getString(1)+rs24.getString(2),rs24.getInt(3)+"@"+rs24.getString(4)+"@"+rs24.getString(5)+"@"+rs24.getString(6));
		        		//System.out.println("hab count is"+rs23.getInt(3));
		        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

		        	}}
		        	if(stmt3!=null){
		        		stmt3.close();
		        	}
		        	if(rs24!=null){
		        		rs24.close();
		        	}
		     // System.out.println("plain works ............"+works);
		        	
		// plain expenditure during
		stmt3 = conn.createStatement();        	
					String plainexpqry="select d.dcode,substr(a.work_id,1,2),sum(case when (to_date(voucher_dt)> '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a,rws_sc_st_performance_temp_tbl temp  where  a.work_id=exp.work_id  and a.work_id=temp.work_id and temp.type='P' ";
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
					
					//System.out.println("plain expenditure during " + plainexpqry);
					Hashtable plain_exp_hash = new Hashtable();
					if(PSPWorks.size()!=0){
					rs27=stmt3.executeQuery(plainexpqry);
					
		          while(rs27.next()){
			       plain_exp_hash.put(rs27.getString(1)+rs27.getString(2),rs27.getString(3));
		  
			       //System.out.println("stexpqry" + rs8.getInt(3));
			       }}
		          if(stmt3!=null){
		  			stmt3.close();
		  		}
		  		if(rs27!=null){
		  			rs27.close();
		  		}
		  		///tender
		  		
		  		
		  	////
		  	stmt3 = conn.createStatement();
		  		String tenderhabs="select  d.dname,p.programme_name,count(distinct w.work_id),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join rws_admn_hab_lnk_tbl l on (w.work_id=l.work_id) left join rws_habitation_directory_tbl hd on(l.hab_code=hd.hab_code) left join RWS_WORK_COMMENCEMENT_TBL c on(w.work_id=c.work_id) left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id) where  c.GROUNDING_DATE is not null and hd.coverage_status<>'UI' and ";

		  			       
		  			        if (dcode != null && !dcode.equals("00")) {
		  			        	tenderhabs+= " substr(w.work_id,5,2)='" + dcode + "' and";
		  							}

		  							if (scheme != null && !scheme.equals("")) {
		  								tenderhabs+= "  w.type_of_asset in(" + scheme + ") ";
		  							}
		  							
		  							if(category!=null && !category.equals("")){
		  								tenderhabs += " and w.special_cat='" + category + "'";
		  							}
		  							tenderhabs+="and  substr(w.work_id,1,2) in ("+programe+") and temp.type='P'  group by d.dname,p.programme_name";
		  					//		 System.out.println("tenderhabs ............"+tenderhabs); 
		  			        Hashtable plain_tender_hash = new Hashtable();
		  			        if(PSPWorks.size()!=0){
		  			            rs29=stmt3.executeQuery(tenderhabs);
		  			        	while(rs29.next())
		  			        	{
		  			        		
		  			        	
		  			        		plain_tender_hash.put(rs29.getString(1)+rs29.getString(2),rs29.getInt(3)+"@"+rs29.getInt(4)+"@"+rs29.getInt(5)+"@"+rs29.getInt(6));
		  			        		//System.out.println("hab count is"+rs23.getInt(3));
		  			        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

		  			        	}}
		  			        	if(stmt3!=null){
		  			        		stmt3.close();
		  			        	}
		  			        	if(rs29!=null){
		  			        		rs29.close();
		  			        	}
		  						
		  			      // System.out.println("1111habs ............"+tenderhabs);
		  			        ////
		  			        stmt3 = conn.createStatement();
		  				  		String tenderwrks="select  d.dname,p.programme_name,sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join RWS_WORK_COMMENCEMENT_TBL c on(w.work_id=c.work_id) left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id) where   c.GROUNDING_DATE is not null and";

		  				  			       
		  				  			        if (dcode != null && !dcode.equals("00")) {
		  				  			        tenderwrks+= " substr(w.work_id,5,2)='" + dcode + "' and";
		  				  							}

		  				  							if (scheme != null && !scheme.equals("")) {
		  				  							tenderwrks+= "  w.type_of_asset in(" + scheme + ") ";
		  				  							}
		  				  							
		  				  							if(category!=null && !category.equals("")){
		  				  							tenderwrks += " and w.special_cat='" + category + "'";
		  				  							}
		  				  						tenderwrks+="and  substr(w.work_id,1,2) in ("+programe+") and   temp.type='P' group by d.dname,p.programme_name";
		  				  			//System.out.println("tenderwrks ............"+tenderwrks); 
		  				  			        Hashtable plain_tender_wrk_hash = new Hashtable();
		  				  			        if(PSPWorks.size()!=0){
		  				  			            rs31=stmt3.executeQuery(tenderwrks);
		  				  			        	while(rs31.next())
		  				  			        	{
		  				  			        		
		  				  			        	
		  				  			        		plain_tender_wrk_hash.put(rs31.getString(1)+rs31.getString(2),rs31.getString(3));
		  				  			        		//System.out.println("hab count is"+rs23.getInt(3));
		  				  			        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

		  				  			        	}}
		  				  			        	if(stmt3!=null){
		  				  			        		stmt3.close();
		  				  			        	}
		  				  			        	if(rs29!=null){
		  				  			        		rs29.close();
		  				  			        	}
		
		 ////works completed**********
		  				  			      ///tender
		  				  			  		
		  				  			  		
		  				  				  	////
		  				  				  	
		  				  		stmt3 = conn.createStatement();
		  				  				  		String wchabs="select  d.dname,p.programme_name,count(distinct l.hab_code),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join rws_admn_hab_lnk_tbl l on (w.work_id=l.work_id) left join rws_habitation_directory_tbl hd on(l.hab_code=hd.hab_code) left join rws_work_completion_tbl c on(w.work_id=c.work_id) left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id) where  c.DATE_OF_COMPLETION is not null and hd.coverage_status<>'UI' and ";

		  				  				  			       
		  				  				  			        if (dcode != null && !dcode.equals("00")) {
		  				  				  			      wchabs+= " substr(w.work_id,5,2)='" + dcode + "' and";
		  				  				  							}

		  				  				  							if (scheme != null && !scheme.equals("")) {
		  				  				  							wchabs+= "  w.type_of_asset in(" + scheme + ") ";
		  				  				  							}
		  				  				  							
		  				  				  							if(category!=null && !category.equals("")){
		  				  				  							wchabs += " and w.special_cat='" + category + "'";
		  				  				  							}
		  				  				  						wchabs+="and  substr(w.work_id,1,2) in ("+programe+") and   temp.type='P' group by d.dname,p.programme_name";
		  				  				  				 
		  				  				  			        Hashtable wcplain_tender_hash = new Hashtable();
		  				  				  			        if(PSPWorks.size()!=0){
		  				  				  			            rs33=stmt3.executeQuery(wchabs);
		  				  				  			        	while(rs33.next())
		  				  				  			        	{
		  				  				  			        		
		  				  				  			        	
		  				  				  			        		wcplain_tender_hash.put(rs33.getString(1)+rs33.getString(2),rs33.getInt(3)+"@"+rs33.getInt(4)+"@"+rs33.getInt(5)+"@"+rs33.getInt(6));
		  				  				  			        		//System.out.println("hab count is"+rs23.getInt(3));
		  				  				  			        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

		  				  				  			        	}}
		  				  				  			        	if(stmt3!=null){
		  				  				  			        		stmt3.close();
		  				  				  			        	}
		  				  				  			        	if(rs33!=null){
		  				  				  			        		rs33.close();
		  				  				  			        	}
		  				  				  			      //System.out.println("wchabs ............"+wchabs);
		  				  				  			        	
		  				  //scst workscomptd habs
		  				  stmt3 = conn.createStatement();
		  				  				  			      String wchabsscst="select  d.dname,p.programme_name,count(distinct l.hab_code),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join rws_admn_hab_lnk_tbl l on (w.work_id=l.work_id) left join rws_habitation_directory_tbl hd on(l.hab_code=hd.hab_code) left join rws_work_completion_tbl c on(w.work_id=c.work_id) left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id) where c.DATE_OF_COMPLETION is not null and hd.coverage_status<>'UI' and ";

		  				  				  			       
		  				  				  			        if (dcode != null && !dcode.equals("00")) {
		  				  				  			      wchabsscst+= " substr(w.work_id,5,2)='" + dcode + "' and";
		  				  				  							}

		  				  				  							if (scheme != null && !scheme.equals("")) {
		  				  				  							wchabsscst+= "  w.type_of_asset in(" + scheme + ") ";
		  				  				  							}
		  				  				  							
		  				  				  							if(category!=null && !category.equals("")){
		  				  				  							wchabsscst += " and w.special_cat='" + category + "'";
		  				  				  							}
		  				  				  						wchabsscst+="and  substr(w.work_id,1,2) in ("+programe+") and  temp.type='S' group by d.dname,p.programme_name";
		  				  				  						//System.out.println("wchabsscst ............"+wchabsscst); 
		  				  				  			        Hashtable wcscst_tender_hash = new Hashtable();
		  				  				  			        if(scstWorks.size()!=0){
		  				  				  			            rs34=stmt3.executeQuery(wchabsscst);
		  				  				  			        	while(rs34.next())
		  				  				  			        	{
		  				  				  			        		
		  				  				  			        	
		  				  				  			        		wcscst_tender_hash.put(rs34.getString(1)+rs34.getString(2),rs34.getInt(3)+"@"+rs34.getInt(4)+"@"+rs34.getInt(5)+"@"+rs34.getInt(6));
		  				  				  			        		//System.out.println("hab count is"+rs23.getInt(3));
		  				  				  			        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

		  				  				  			        	}}
		  				  				  			        	if(stmt3!=null){
		  				  				  			        		stmt3.close();
		  				  				  			        	}
		  				  				  			        	if(rs34!=null){
		  				  				  			        		rs34.close();
		  				  				  			        	}
		  				  				  						
		  				  				  			   
		  		  ////System.out.println("1111habs ............"+s);
		  			  ////
		  			  stmt3 = conn.createStatement();
		  				  				  				  		String wctenderwrks="select  d.dname,p.programme_name,count(w.work_id),sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join rws_work_completion_tbl c on(w.work_id=c.work_id) left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id)  where c.DATE_OF_COMPLETION is not null and ";

		  				  				  				  			       
		  				  				  				  			        if (dcode != null && !dcode.equals("00")) {
		  				  				  				  			    wctenderwrks+= " substr(w.work_id,5,2)='" + dcode + "' and";
		  				  				  				  							}

		  				  				  				  							if (scheme != null && !scheme.equals("")) {
		  				  				  				  						wctenderwrks+= "  w.type_of_asset in(" + scheme + ") ";
		  				  				  				  							}
		  				  				  				  							
		  				  				  				  							if(category!=null && !category.equals("")){
		  				  				  				  						wctenderwrks += " and w.special_cat='" + category + "'";
		  				  				  				  							}
		  				  				  				  					wctenderwrks+="and  substr(w.work_id,1,2) in ("+programe+") and  temp.type='P'  group by d.dname,p.programme_name";
		  				  				  				 							// System.out.println("wctenderwrks ............"+wctenderwrks); 
		  				  				  				  			        Hashtable wcplain_tender_wrk_hash = new Hashtable();
		  				  				  				  			        if(PSPWorks.size()!=0){
		  				  				  				  			            rs35=stmt3.executeQuery(wctenderwrks);
		  				  				  				  			        	while(rs35.next())
		  				  				  				  			        	{
		  				  				  				  			        		
		  				  				  				  			        	
		  				  				  				  			        		wcplain_tender_wrk_hash.put(rs35.getString(1)+rs35.getString(2),rs35.getInt(3)+"@"+rs35.getString(4));
		  				  				  				  			        		//System.out.println("hab count is"+rs23.getInt(3));
		  				  				  				  			        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

		  				  				  				  			        	}}
		  				  				  				  			        	if(stmt3!=null){
		  				  				  				  			        		stmt3.close();
		  				  				  				  			        	}
		  				  				  				  			        	if(rs35!=null){
		  				  				  				  			        		rs35.close();
		  				  				  				  			        	}
		  				  		
		  				  				//scst works
		  				  				stmt3 = conn.createStatement();
		  				  				  				  			    String wctenderwrksscst="select  d.dname,p.programme_name,count(w.work_id),sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join rws_work_completion_tbl c on(w.work_id=c.work_id)  left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id)  where  c.DATE_OF_COMPLETION is not null and";

		  				  				  				  			       
	  				  				  				  			        if (dcode != null && !dcode.equals("00")) {
	  				  				  				  			    wctenderwrksscst+= " substr(w.work_id,5,2)='" + dcode + "' and";
	  				  				  				  							}

	  				  				  				  							if (scheme != null && !scheme.equals("")) {
	  				  				  				  						wctenderwrksscst+= "  w.type_of_asset in(" + scheme + ") ";
	  				  				  				  							}
	  				  				  				  							
	  				  				  				  							if(category!=null && !category.equals("")){
	  				  				  				  						wctenderwrksscst += " and w.special_cat='" + category + "'";
	  				  				  				  							}
	  				  				  				  					wctenderwrksscst+="and  substr(w.work_id,1,2) in ("+programe+") and  temp.type='S'  group by d.dname,p.programme_name";
	  				  				  				  							 //System.out.println("wctenderwrksscst ............"+wctenderwrksscst); 
	  				  				  				  			        Hashtable wcscst_tender_wrk_hash = new Hashtable();
	  				  				  				  			        if(scstWorks.size()!=0){
	  				  				  				  			            rs36=stmt3.executeQuery(wctenderwrksscst);
	  				  				  				  			        	while(rs36.next())
	  				  				  				  			        	{
	  				  				  				  			        		
	  				  				  				  			        	
	  				  				  				  			        		wcscst_tender_wrk_hash.put(rs36.getString(1)+rs36.getString(2),rs36.getInt(3)+"@"+rs36.getString(4));
	  				  				  				  			        		//System.out.println("hab count is"+rs23.getInt(3));
	  				  				  				  			        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

	  				  				  				  			        	}}
	  				  				  				  			        	if(stmt3!=null){
	  				  				  				  			        		stmt3.close();
	  				  				  				  			        	}
	  				  				  				  			        	if(rs36!=null){
	  				  				  				  			        		rs36.close();
	  				  				  				  			        	}
	  				  				  			 



///scst
stmt3 = conn.createStatement();
		        	String habsscst="select  d.dname,p.programme_name,count(l.hab_code),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join rws_admn_hab_lnk_tbl l on (w.work_id=l.work_id) left join rws_habitation_directory_tbl hd on(l.hab_code=hd.hab_code)  left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id) where   ";

		 	       
			        if (dcode != null && !dcode.equals("00")) {
			        	habsscst+= " substr(w.work_id,5,2)='" + dcode + "' and";
							}

							if (scheme != null && !scheme.equals("")) {
								habsscst+= "  w.type_of_asset in(" + scheme + ") ";
							}
							
							if(category!=null && !category.equals("")){
								habsscst += " and w.special_cat='" + category + "'";
							}
							habsscst+="and  substr(w.work_id,1,2) in ("+programe+") and   temp.type='S' and hd.coverage_status<>'UI' group by d.dname,p.programme_name";
							 
			        Hashtable scst_hash = new Hashtable();
			        if(scstWorks.size()!=0){
			            rs25=stmt3.executeQuery(habsscst);
			        	while(rs25.next())
			        	{
			        		
			        	
			        		scst_hash.put(rs25.getString(1)+rs25.getString(2),rs25.getInt(3)+"@"+rs25.getInt(4)+"@"+rs25.getInt(5)+"@"+rs25.getInt(6));
			        		//System.out.println("hab code is"+rs23.getInt(3));
			        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

			        	}}
			        	if(stmt3!=null){
			        		stmt3.close();
			        	}
			        	if(rs25!=null){
			        		rs25.close();
			        	}
						
			    //System.out.println("habsscstmm ............"+habsscst);
stmt3 = conn.createStatement();
String habcountqrysc="select  substr(l.work_id,5,2),substr(l.work_id,1,2),count(l.hab_code) from rws_work_admn_tbl w,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd ,rws_complete_hab_view ch,rws_sc_st_performance_temp_tbl temp  where temp.work_id=w.work_id and ch.panch_code=hd.hab_code and w.work_id=l.work_id and l.hab_code=hd.hab_code and hd.coverage_status<>'UI'  "; 
if (dcode != null && !dcode.equals("00")) {
	habcountqrysc+= " and substr(w.work_id,5,2)='" + dcode + "' ";
						}

						if (scheme != null && !scheme.equals("")) {
							habcountqrysc+= "and  w.type_of_asset in(" + scheme + ") ";
						}
						
						if(category!=null && !category.equals("")){
							habcountqrysc += " and w.special_cat='" + category + "'";
						}
	
habcountqrysc+=" and  temp.type='S' and hd.CENSUS_SC_POPU>(hd.CENSUS_PLAIN_POPU+hd.CENSUS_ST_POPU) group by substr(l.work_id,5,2),substr(l.work_id,1,2)";

		 Hashtable habscount_scst_sc_hash = new Hashtable();
	        if(scstWorks.size()!=0){

	            rs37=stmt3.executeQuery(habcountqrysc);
	        	while(rs37.next())
	        	{
	        		habscount_scst_sc_hash.put(rs37.getString(1)+rs37.getString(2),rs37.getInt(3));
	        		
	        			        }
	       	//System.out.println("habcountqrysc "+habcountqrysc);
	
	        }
	        	if(stmt3!=null){
	        		stmt3.close();
	        	}
	        	if(rs37!=null){
	        		rs37.close();
	        	}
	        	
	        	stmt3 = conn.createStatement();	
	        	String habcountqryst="select  substr(l.work_id,5,2),substr(l.work_id,1,2),count(l.hab_code) from rws_work_admn_tbl w,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd ,rws_complete_hab_view ch,rws_sc_st_performance_temp_tbl temp  where temp.work_id=w.work_id and ch.panch_code=hd.hab_code and w.work_id=l.work_id and l.hab_code=hd.hab_code and hd.coverage_status<>'UI' "; 
	        	if (dcode != null && !dcode.equals("00")) {
	        		habcountqryst+= " and substr(w.work_id,5,2)='" + dcode + "' ";
	        							}

	        							if (scheme != null && !scheme.equals("")) {
	        								habcountqryst+= "and  w.type_of_asset in(" + scheme + ") ";
	        							}
	        							
	        							if(category!=null && !category.equals("")){
	        								habcountqryst += " and w.special_cat='" + category + "'";
	        							}

	        	habcountqryst+=" and temp.type='S' and hd.CENSUS_ST_POPU>(hd.CENSUS_PLAIN_POPU+hd.CENSUS_SC_POPU) group by substr(l.work_id,5,2),substr(l.work_id,1,2)";
	        	
	        		 Hashtable habscount_scst_st_hash = new Hashtable();
	        	        if(scstWorks.size()!=0){
	        	            rs38=stmt3.executeQuery(habcountqryst);
	        	        	while(rs38.next())
	        	        	{
	        	        		habscount_scst_st_hash.put(rs38.getString(1)+rs38.getString(2),rs38.getInt(3));
	        	        		
	        	        			        }
	        	        	
	        		      //System.out.println("habcountqryst "+habcountqryst);

	        	        }
	        	        	if(stmt3!=null){
	        	        		stmt3.close();
	        	        	}
	        	        	if(rs38!=null){
	        	        		rs38.close();
	        	        	}
	        	        	stmt3 = conn.createStatement();
	        	        	String habcountqrypl="select  substr(l.work_id,5,2),substr(l.work_id,1,2),count(l.hab_code) from rws_work_admn_tbl w,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd ,rws_complete_hab_view ch,rws_sc_st_performance_temp_tbl temp   where temp.work_id=w.work_id and ch.panch_code=hd.hab_code and w.work_id=l.work_id and l.hab_code=hd.hab_code and hd.coverage_status<>'UI' "; 
	        	        	if (dcode != null && !dcode.equals("00")) {
	        	        		habcountqrypl+= " and substr(w.work_id,5,2)='" + dcode + "' ";
	        	        							}

	        	        							if (scheme != null && !scheme.equals("")) {
	        	        								habcountqrypl+= "and  w.type_of_asset in(" + scheme + ") ";
	        	        							}
	        	        							
	        	        							if(category!=null && !category.equals("")){
	        	        								habcountqrypl += " and w.special_cat='" + category + "'";
	        	        							}

	        	        	habcountqrypl+=" and temp.type='S' and hd.CENSUS_PLAIN_POPU>(hd.CENSUS_SC_POPU+hd.CENSUS_ST_POPU) group by substr(l.work_id,5,2),substr(l.work_id,1,2)";
	        	        	
	        	        		 Hashtable habscount_scst_p_hash = new Hashtable();
	        	        	        if(scstWorks.size()!=0){
	        	        	            rs39=stmt3.executeQuery(habcountqrypl);
	        	        	        	while(rs39.next())
	        	        	        	{
	        	        	        		habscount_scst_p_hash.put(rs39.getString(1)+rs39.getString(2),rs39.getInt(3));
	        	        	        		
	        	        	        			        }
	        	        	        	
	        	 	        	    //System.out.println("habcountqrypl "+habcountqrypl);

	        	        	        }
	        	        	        	if(stmt3!=null){
	        	        	        		stmt3.close();
	        	        	        	}
	        	        	        	if(rs39!=null){
	        	        	        		rs39.close();
	        	        	        	}

		
		///////works and sanction amount
stmt3 = conn.createStatement();
			        	String worksscst="select  d.dname,p.programme_name,count(distinct w.work_id),sum(prob_exp),sum(prob_exp_nxt_yr),sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code)  left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id) where  ";

			 	       
				        if (dcode != null && !dcode.equals("00")) {
				        	worksscst+= " substr(w.work_id,5,2)='" + dcode + "' and";
								}

								if (scheme != null && !scheme.equals("")) {
									worksscst+= "  w.type_of_asset in(" + scheme + ") ";
								}
								
								if(category!=null && !category.equals("")){
									worksscst += " and w.special_cat='" + category + "'";
								}
								worksscst+="and  substr(w.work_id,1,2) in ("+programe+") and   temp.type='S' group by d.dname,p.programme_name";
								 
				        Hashtable works_scst_hash = new Hashtable();
				        if(scstWorks.size()!=0){
				            rs26=stmt3.executeQuery(worksscst);
				        	while(rs26.next())
				        	{
				        		
				        	
				        		works_scst_hash.put(rs26.getString(1)+rs26.getString(2),rs26.getInt(3)+"@"+rs26.getString(4)+"@"+rs26.getString(5)+"@"+rs26.getString(6));
				        		//System.out.println("hab count is"+rs23.getInt(3));
				        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

				        	}}
				        	if(stmt3!=null){
				        		stmt3.close();
				        	}
				        	if(rs26!=null){
				        		rs26.close();
				        	}
				        	//System.out.println("worksscst............"+worksscst);
				        	
				        	
			       //scst expenditure during
			       stmt3 = conn.createStatement();
							String scstexpqry="select d.dcode,substr(a.work_id,1,2),sum(case when (to_date(voucher_dt)> '01-APR-2013') then voucher_Amt else 0 end)/100000  FROM  rws_work_admn_tbl a left join  rws_work_exp_voucher_tbl v on (a.work_id=v.work_id) left join  rws_district_tbl d on(substr(a.work_id,5,2)=d.dcode) left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=a.work_id)   where temp.type='S' ";
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
							
						//System.out.println("3333333)scst expenditure during " + scstexpqry);
							Hashtable scst_exp_hash = new Hashtable();
							if(scstWorks.size()!=0){
							rs28=stmt3.executeQuery(scstexpqry);
							
				          while(rs28.next()){
					       scst_exp_hash.put(rs28.getString(1)+rs28.getString(2),rs28.getString(3));
				  
					       //System.out.println("stexpqry" + rs8.getInt(3));
					       }}
				          if(stmt3!=null){
				  			stmt3.close();
				  		}
				  		if(rs28!=null){
				  			rs28.close();
				  		}
				        	
				  		
				  	///tender
				  		
				  		
					  	////
					  	stmt3 = conn.createStatement();
					  		String tenderhabsscst="select  d.dname,p.programme_name,count(distinct w.work_id),sum(hd.CENSUS_PLAIN_POPU),sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join rws_admn_hab_lnk_tbl l on (w.work_id=l.work_id) left join rws_habitation_directory_tbl hd on(l.hab_code=hd.hab_code) left join RWS_WORK_COMMENCEMENT_TBL c on(w.work_id=c.work_id) left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id)  where  c.GROUNDING_DATE is not null and hd.coverage_status<>'UI' and ";

					  			       
					  			        if (dcode != null && !dcode.equals("00")) {
					  			        	tenderhabsscst+= " substr(w.work_id,5,2)='" + dcode + "' and";
					  							}

					  							if (scheme != null && !scheme.equals("")) {
					  								tenderhabsscst+= "  w.type_of_asset in(" + scheme + ") ";
					  							}
					  							
					  							if(category!=null && !category.equals("")){
					  								tenderhabsscst += " and w.special_cat='" + category + "'";
					  							}
					  							tenderhabsscst+="and  substr(w.work_id,1,2) in ("+programe+") and   temp.type='S' group by d.dname,p.programme_name";
					  					 //System.out.println("tenderhabsscst ............"+tenderhabsscst); 
					  			        Hashtable scst_tender_hash = new Hashtable();
					  			        if(scstWorks.size()!=0){
					  			            rs30=stmt3.executeQuery(tenderhabsscst);
					  			        	while(rs30.next())
					  			        	{
					  			        		
					  			        	
					  			        		scst_tender_hash.put(rs30.getString(1)+rs30.getString(2),rs30.getInt(3)+"@"+rs30.getInt(4)+"@"+rs30.getInt(5)+"@"+rs30.getInt(6));
					  			        		//System.out.println("hab count is"+rs23.getInt(3));
					  			        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

					  			        	}}
					  			        	if(stmt3!=null){
					  			        		stmt3.close();
					  			        	}
					  			        	if(rs30!=null){
					  			        		rs30.close();
					  			        	}
					  						
					  			     //  System.out.println("tenderhabsscst ............"+tenderhabsscst);
					 stmt3 = conn.createStatement();
					  			     String tenderwrksscst="select  d.dname,p.programme_name,sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL W left join rws_district_tbl d on (substr(w.work_id,5,2)=d.dcode) left join rws_programme_tbl p on (substr(w.work_id,1,2)=p.programme_code) left join RWS_WORK_COMMENCEMENT_TBL c on(w.work_id=c.work_id) left join rws_sc_st_performance_temp_tbl temp on(temp.work_id=w.work_id)  where  c.GROUNDING_DATE is not null and";

	  				  			       
	  				  			        if (dcode != null && !dcode.equals("00")) {
	  				  			        tenderwrksscst+= " substr(w.work_id,5,2)='" + dcode + "' and ";
	  				  							}

	  				  							if (scheme != null && !scheme.equals("")) {
	  				  							tenderwrksscst+= "  w.type_of_asset in(" + scheme + ") ";
	  				  							}
	  				  							
	  				  							if(category!=null && !category.equals("")){
	  				  							tenderwrksscst += " and w.special_cat='" + category + "'";
	  				  							}
	  				  						tenderwrksscst+="and  substr(w.work_id,1,2) in ("+programe+") and  temp.type='S'  group by d.dname,p.programme_name";
	  				  							 
	  				  			        Hashtable scst_tender_wrk_hash = new Hashtable();
	  				  			        if(scstWorks.size()!=0){
	  				  			            rs32=stmt3.executeQuery(tenderwrksscst);
	  				  			        	while(rs32.next())
	  				  			        	{
	  				  			        		
	  				  			        	
	  				  			        		scst_tender_wrk_hash.put(rs32.getString(1)+rs32.getString(2),rs32.getString(3));
	  				  			        		//System.out.println("hab count is"+rs23.getInt(3));
	  				  			        		//plain_works_count.put(rs23.getString(1)+rs23.getString(2),Integer.toString(rs23.getInt(10)));

	  				  			        	}}
	  				  			        	if(stmt3!=null){
	  				  			        		stmt3.close();
	  				  			        	}
	  				  			        	if(rs32!=null){
	  				  			        		rs32.close();
	  				  			        	}
	  			 
	        	
	  				  			        //System.out.println("tenderwrksscst456783 ............"+tenderwrksscst); 
					  		
						////SC population,works,hab_count,est,exp cost
     stmt3 = conn.createStatement();
			String scquery = "select distinct d.dname,p.programme_name,count(*),sum(sc.hab_count),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop),sum(a.sanction_amount),sum(prob_exp),sum(prob_exp_nxt_yr) from rws_sc_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a where sc.work_id=a.work_id and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
			
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
			
			//System.out.println("1) scquery " + scquery);
			rs4 = stmt3.executeQuery(scquery);
			Hashtable scpop_works_hab_hash = new Hashtable();
			while (rs4.next()) {
				scpop_works_hab_hash.put(rs4.getString(1)
						+ rs4.getString(2), rs4.getInt(3) + "@"
						+ rs4.getInt(4) + "@" + rs4.getInt(5) + "@"
						+ rs4.getInt(6) + "@" + rs4.getInt(7)+"@"+rs4.getInt(8)+"@"+rs4.getInt(9)+"@"+rs4.getInt(10));

			}
			if(stmt3!=null){
				stmt3.close();
			}
			if(rs4!=null){
				rs4.close();
			}
			//sc expenditure before
			stmt3 = conn.createStatement();
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
			
			//System.out.println("2)sc expenditure before " + scexpqrybefore);
			rs14=stmt3.executeQuery(scexpqrybefore);
			Hashtable sc_bef_exp_hash = new Hashtable();
          while(rs14.next()){
        	  sc_bef_exp_hash.put(rs14.getString(1)+rs14.getString(2),rs14.getString(3));
  
	      // System.out.println("stexpqry" + rs8.getInt(3));
	       }
          if(stmt3!=null){
  			stmt3.close();
  		}
  		if(rs14!=null){
  			rs14.close();
  		}
			//sc expenditure during
			stmt3 = conn.createStatement();
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
			
			//System.out.println("3)sc expenditure during " + scexpqry);
			rs8=stmt3.executeQuery(scexpqry);
			Hashtable sc_exp_hash = new Hashtable();
          while(rs8.next()){
	       sc_exp_hash.put(rs8.getString(1)+rs8.getString(2),rs8.getString(3));
  
	       //System.out.println("stexpqry" + rs8.getInt(3));
	       }
          if(stmt3!=null){
  			stmt3.close();
  		}
  		if(rs8!=null){
  			rs8.close();
  		}
          
 ///sanction amount for spill over works sc
 stmt3 = conn.createStatement();
 
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

	  	//System.out.println("4) sanction amount for spill over works sc "+spillOverWorkssc);
	  	 rs11=stmt3.executeQuery(spillOverWorkssc);
	  
	  	Hashtable spillOverWorksHashsc=new Hashtable();
	  	while(rs11.next()){
	  		  	
	  		spillOverWorksHashsc.put(rs11.getString(1)+rs11.getString(2),rs11.getString(3));
	  	}
	  	if(stmt3!=null){
			stmt3.close();
		}
		if(rs11!=null){
			rs11.close();
		}
//////////////sc Tenders Finalized query/////////
	stmt3 = conn.createStatement();  	
String tenderqrysc="select d.dname,p.programme_name,count(distinct sc.work_id),sum(sanction_amount),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop) from rws_sc_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_COMMENCEMENT_TBL c where sc.work_id=a.work_id  and a.work_id=c.work_id and GROUNDING_DATE is not null and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	 	   
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

	  	//System.out.println("5) sc Tenders Finalized query "+tenderqrysc);
	  	 rs17=stmt3.executeQuery(tenderqrysc);
	  
	  	Hashtable tenderHashsc=new Hashtable();
	  	while(rs17.next()){
	  		  	
	  		tenderHashsc.put(rs17.getString(1)+rs17.getString(2),rs17.getInt(3)+"@"+rs17.getString(4)+"@"+rs17.getInt(5)+"@"+rs17.getInt(6)+"@"+rs17.getInt(7));
	  	}
	  	if(stmt3!=null){
			stmt3.close();
		}
		if(rs17!=null){
			rs17.close();
		}
//////////////sc works completed query/////////
stmt3 = conn.createStatement();
	  	
	  	String workscomptdsc="select d.dname,p.programme_name,count(distinct sc.work_id),sum(sanction_amount),sum(sc.hab_count),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop) from rws_sc_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_Completion_tbl c where sc.work_id=a.work_id  and a.work_id=c.work_id and DATE_of_completion is not null and  (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"')  and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	  		 	   
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

	  		//System.out.println("6) sc works completed query "+workscomptdsc);
	  		  	 rs20=stmt3.executeQuery(workscomptdsc);
	  		  
	  		  	Hashtable workscomptdHashsc=new Hashtable();
	  		  	while(rs20.next()){
	  		  		  	
	  		  	workscomptdHashsc.put(rs20.getString(1)+rs20.getString(2),rs20.getInt(3)+"@"+rs20.getString(4)+"@"+rs20.getInt(5)+"@"+rs20.getInt(6)+"@"+rs20.getInt(7)+"@"+rs20.getInt(8));
	  		  	}

	  		  if(stmt3!=null){
	  			stmt3.close();
	  		}
	  		if(rs20!=null){
	  			rs20.close();
	  		}
///////habcounts in sc 
	  		stmt3 = conn.createStatement();
		  	
		  	String schabcountinsc="select substr(sc.work_id,5,2),substr(sc.work_id,1,2),count(l.hab_code) from rws_sc_works_view sc left join rws_work_admn_tbl a on (sc.work_id=a.work_id) left join  rws_admn_hab_lnk_tbl l on (sc.work_id=l.work_id) left join rws_habitation_directory_tbl hd on (l.hab_code=hd.hab_code) where a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and hd.CENSUS_SC_POPU>(hd.CENSUS_ST_POPU+hd.CENSUS_PLAIN_POPU) and WORK_CANCEL_DT  is null ";
		  		 	   
		  	        if (dcode != null && !dcode.equals("00")) {
		  	        	schabcountinsc+= " and substr(l.work_id,5,2)='" + dcode + "'";
		  				}

		  				if (scheme != null && !scheme.equals("")) {
		  					schabcountinsc+= " and a.type_of_asset in(" + scheme + ")";
		  				}
		  				
		  				if(category!=null && !category.equals("")){
		  					schabcountinsc += " and a.special_cat='" + category + "'";
		  				}
		  				schabcountinsc+=" and  substr(sc.work_id,1,2) in ("+programe+") group by substr(sc.work_id,5,2),substr(sc.work_id,1,2) ";

		  		//System.out.println("6) schabcountinsc query "+schabcountinsc);
		  		  	 rs6=stmt3.executeQuery(schabcountinsc);
		  		  
		  		  	Hashtable sc_habcount_sc=new Hashtable();
		  		  	while(rs6.next()){
		  		  		  	
		  		  	sc_habcount_sc.put(rs6.getString(1)+rs6.getString(2),rs6.getInt(3));
		  		  	}

		  		  if(stmt3!=null){
		  			stmt3.close();
		  		}
		  		if(rs6!=null){
		  			rs6.close();
		  		}
		  		//
		  		stmt3 = conn.createStatement();
			  	
			  	String sthabcountinsc="select substr(sc.work_id,5,2),substr(sc.work_id,1,2),count(l.hab_code) from rws_sc_works_view sc left join rws_work_admn_tbl a on (sc.work_id=a.work_id) left join  rws_admn_hab_lnk_tbl l on (sc.work_id=l.work_id) left join rws_habitation_directory_tbl hd on (l.hab_code=hd.hab_code) where a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and hd.CENSUS_ST_POPU>(hd.CENSUS_SC_POPU+hd.CENSUS_PLAIN_POPU) and WORK_CANCEL_DT  is null ";
			  		 	   
			  	        if (dcode != null && !dcode.equals("00")) {
			  	        	sthabcountinsc+= " and substr(l.work_id,5,2)='" + dcode + "'";
			  				}

			  				if (scheme != null && !scheme.equals("")) {
			  					sthabcountinsc+= " and a.type_of_asset in(" + scheme + ")";
			  				}
			  				
			  				if(category!=null && !category.equals("")){
			  					sthabcountinsc += " and a.special_cat='" + category + "'";
			  				}
			  				sthabcountinsc+=" and  substr(sc.work_id,1,2) in ("+programe+") group by substr(sc.work_id,5,2),substr(sc.work_id,1,2) ";

			  		// System.out.println("6) sthabcountinsc query "+sthabcountinsc);
			  		  	 rs1=stmt3.executeQuery(sthabcountinsc);
			  		  
			  		  	Hashtable st_habcount_sc=new Hashtable();
			  		  	while(rs1.next()){
			  		  		  	
			  		  	st_habcount_sc.put(rs1.getString(1)+rs1.getString(2),rs1.getInt(3));
			  		  	}

			  		  if(stmt3!=null){
			  			stmt3.close();
			  		}
			  		if(rs1!=null){
			  			rs1.close();
			  		}
		  	
///
			  		stmt3 = conn.createStatement();
				  	
				  	String plainhabcountinsc="select substr(sc.work_id,5,2),substr(sc.work_id,1,2),count(l.hab_code) from rws_sc_works_view sc left join rws_work_admn_tbl a on (sc.work_id=a.work_id) left join  rws_admn_hab_lnk_tbl l on (sc.work_id=l.work_id) left join rws_habitation_directory_tbl hd on (l.hab_code=hd.hab_code) where a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and hd.CENSUS_PLAIN_POPU>(hd.CENSUS_SC_POPU+hd.CENSUS_ST_POPU) and WORK_CANCEL_DT  is null ";
				  		 	   
				  	        if (dcode != null && !dcode.equals("00")) {
				  	        	plainhabcountinsc+= " and substr(l.work_id,5,2)='" + dcode + "'";
				  				}

				  				if (scheme != null && !scheme.equals("")) {
				  					plainhabcountinsc+= " and a.type_of_asset in(" + scheme + ")";
				  				}
				  				
				  				if(category!=null && !category.equals("")){
				  					plainhabcountinsc += " and a.special_cat='" + category + "'";
				  				}
				  				plainhabcountinsc+=" and  substr(sc.work_id,1,2) in ("+programe+") group by substr(sc.work_id,5,2),substr(sc.work_id,1,2) ";

				  		// System.out.println("6) plainhabcountinsc query "+plainhabcountinsc);
				  		  	 rs3=stmt3.executeQuery(plainhabcountinsc);
				  		  
				  		  	Hashtable p_habcount_sc=new Hashtable();
				  		  	while(rs3.next()){
				  		  		  	
				  		  	p_habcount_sc.put(rs3.getString(1)+rs3.getString(2),rs3.getInt(3));
				  		  	}

				  		  if(stmt3!=null){
				  			stmt3.close();
				  		}
				  		if(rs3!=null){
				  			rs3.close();
				  		}
			  	

		  		
	////ST population,works,hab_count

	stmt3 = conn.createStatement();
			String stquery = "select d.dname,p.programme_name,count(*),sum(st.hab_count),sum(st.plain_pop),sum(st.sc_pop),sum(st.st_pop),sum(a.sanction_amount),sum(prob_exp),sum(prob_exp_nxt_yr) from rws_st_works_view st,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a where st.work_id=a.work_id and substr(st.work_id,5,2)=d.dcode and substr(st.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null   ";
           if(myWorkList2.length()!=0)
           {
        	   stquery +=" and a.work_id not in "+myWorkList2+" ";   
           }
			
			
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
			
			//System.out.println("7)ST population,works,hab_count " + stquery);
			rs5 = stmt3.executeQuery(stquery);
			Hashtable stpop_works_hab_hash = new Hashtable();
			while (rs5.next()) {
				stpop_works_hab_hash.put(rs5.getString(1)
						+ rs5.getString(2), rs5.getInt(3) + "@"
						+ rs5.getInt(4) + "@" + rs5.getInt(5) + "@"
						+ rs5.getInt(6) + "@" + rs5.getInt(7)+"@"+rs5.getInt(8)+"@"+rs5.getInt(9)+"@"+rs5.getInt(10));

			}
			if(stmt3!=null){
				stmt3.close();
			}
			if(rs5!=null){
				rs5.close();
			}
//st expenditure before
stmt3 = conn.createStatement();
			String stexpqrybefore="select d.dcode,substr(w.work_id,1,2),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_st_works_view W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a where a.work_id=w.work_id and (to_date(admin_date) < '01-Apr-"+startyr+"') and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null  ";
			
			 if(myWorkList2.length()!=0)
	           {
				 stexpqrybefore +=" and a.work_id not in "+myWorkList2+" ";   
	           }
				
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
				
			//System.out.println("8) st expenditure before " + stexpqrybefore);
			rs15=stmt3.executeQuery(stexpqrybefore);
			Hashtable st_bef_exp_hash = new Hashtable();
          while(rs15.next()){
        	  st_bef_exp_hash.put(rs15.getString(1)+rs15.getString(2),rs15.getString(3));
  
	      // System.out.println("stexpqry" + rs8.getInt(3));
	       }
          if(stmt3!=null){
  			stmt3.close();
  		}
  		if(rs15!=null){
  			rs15.close();
  		}
			//st expenditure during
			stmt3 = conn.createStatement();
			String stexpqry="select d.dcode,substr(w.work_id,1,2),sum(case when (to_date(voucher_dt)> '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000  FROM rws_st_works_view W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,rws_work_admn_tbl a  where a.work_id=w.work_id and (to_date(admin_date) < '01-Apr-"+startyr+"') and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null  ";
			if(myWorkList2.length()!=0)
	           {
				stexpqry +=" and a.work_id not in "+myWorkList2+" ";   
	           }
				
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
			
			//System.out.println("9) st expenditure during " + stexpqry);
			rs9=stmt3.executeQuery(stexpqry);
			Hashtable st_exp_hash = new Hashtable();
          while(rs9.next()){
	       st_exp_hash.put(rs9.getString(1)+rs9.getString(2),rs9.getString(3));
	       //System.out.println("stexpqry" + rs9.getInt(3)); 
          }
          if(stmt3!=null){
  			stmt3.close();
  		}
  		if(rs9!=null){
  			rs9.close();
  		}	
        ///sanction amount for spill over works st
          stmt3 = conn.createStatement();
          String spillOverWorksst="select d.dcode,substr(w.work_id,1,2),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_st_works_view sc  where  sc.work_id=w.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null  ";
         
          if(myWorkList2.length()!=0)
          {
        	  spillOverWorksst +=" and w.work_id not in "+myWorkList2+" ";   
          }
			
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

	//  System.out.println("10) sanction amount for spill over works st "+spillOverWorksst);
	  	 rs12=stmt3.executeQuery(spillOverWorksst);
	  
	  	Hashtable spillOverWorksHashst=new Hashtable();
	  	while(rs12.next()){
	  		  	
	  		spillOverWorksHashst.put(rs12.getString(1)+rs12.getString(2),rs12.getString(3));
	  	}

	  	if(stmt3!=null){
			stmt3.close();
		}
		if(rs12!=null){
			rs12.close();
		}
//////////////st Tenders Finalized query/////////
stmt3 = conn.createStatement();
	  	
	  	String tenderqryst="select d.dname,p.programme_name,count(distinct sc.work_id),sum(sanction_amount),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop) from rws_st_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_COMMENCEMENT_TBL c where sc.work_id=a.work_id  and a.work_id=c.work_id and GROUNDING_DATE is not null and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null  ";
	  	 
        if(myWorkList2.length()!=0)
        {
        	tenderqryst +=" and a.work_id not in "+myWorkList2+" ";   
        }  
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

	  		//System.out.println("11)st Tenders Finalized query "+tenderqryst);
	  		  	 rs18=stmt3.executeQuery(tenderqryst);
	  		  
	  		  	Hashtable tenderHashst=new Hashtable();
	  		  	while(rs18.next()){
	  		  		  	
	  		  		tenderHashst.put(rs18.getString(1)+rs18.getString(2),rs18.getInt(3)+"@"+rs18.getString(4)+"@"+rs18.getInt(5)+"@"+rs18.getInt(6)+"@"+rs18.getInt(7));
	  		  	}
	  		  if(stmt3!=null){
	  			stmt3.close();
	  		}
	  		if(rs18!=null){
	  			rs18.close();
	  		}
	//////////////st works completed query/////////
	stmt3 = conn.createStatement();
	  		  	
	  		  	String workscomptdst="select d.dname,p.programme_name,count(distinct sc.work_id),sum(sanction_amount),sum(sc.hab_count),sum(sc.plain_pop),sum(sc.sc_pop),sum(sc.st_pop) from rws_st_works_view sc,rws_district_tbl d,rws_programme_tbl p,rws_work_admn_tbl a ,RWS_WORK_Completion_tbl c where sc.work_id=a.work_id  and a.work_id=c.work_id and DATE_of_completion is not null and  (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"')  and substr(sc.work_id,5,2)=d.dcode and substr(sc.work_id,1,2)=p.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null  ";
	  		  		 	  
	  		   if(myWorkList2.length()!=0)
	  	        {
	  			 workscomptdst +=" and a.work_id not in "+myWorkList2+" ";   
	  	        }  
	  		  	
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

	  		  		//System.out.println("12)st works completed query "+workscomptdst);
	  		  		  	 rs21=stmt3.executeQuery(workscomptdst);
	  		  		  
	  		  		  	Hashtable workscomptdHashst=new Hashtable();
	  		  		  	while(rs21.next()){
	  		  		  		  	
	  		  		  	workscomptdHashst.put(rs21.getString(1)+rs21.getString(2),rs21.getInt(3)+"@"+rs21.getString(4)+"@"+rs21.getInt(5)+"@"+rs21.getInt(6)+"@"+rs21.getInt(7)+"@"+rs21.getInt(8));
	  		  		  	}
	  		  		if(stmt3!=null){
	  					stmt3.close();
	  				}
	  				if(rs21!=null){
	  					rs21.close();
	  				}
	  		  	
	  		///////habcounts in st 
	  		  		stmt3 = conn.createStatement();
	  			  	
	  			  	String schabcountinst="select substr(sc.work_id,5,2),substr(sc.work_id,1,2),count(l.hab_code) from rws_st_works_view sc left join rws_work_admn_tbl a on (sc.work_id=a.work_id) left join  rws_admn_hab_lnk_tbl l on (sc.work_id=l.work_id) left join rws_habitation_directory_tbl hd on (l.hab_code=hd.hab_code) where a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and hd.CENSUS_SC_POPU>(hd.CENSUS_ST_POPU+hd.CENSUS_PLAIN_POPU) and WORK_CANCEL_DT  is null ";
	  			  		 	 
	  			  if(myWorkList2.length()!=0)
		  	        {
	  				schabcountinst +=" and sc.work_id not in "+myWorkList2+" ";   
		  	        }  
	  			  	        if (dcode != null && !dcode.equals("00")) {
	  			  	        schabcountinst+= " and substr(l.work_id,5,2)='" + dcode + "'";
	  			  				}

	  			  				if (scheme != null && !scheme.equals("")) {
	  			  				schabcountinst+= " and a.type_of_asset in(" + scheme + ")";
	  			  				}
	  			  				
	  			  				if(category!=null && !category.equals("")){
	  			  				schabcountinst += " and a.special_cat='" + category + "'";
	  			  				}
	  			  			schabcountinst+=" and  substr(sc.work_id,1,2) in ("+programe+") group by substr(sc.work_id,5,2),substr(sc.work_id,1,2) ";

	  			  		//System.out.println("schabcountinst query "+schabcountinst);
	  			  		  	 rs10=stmt3.executeQuery(schabcountinst);
	  			  		  
	  			  		  	Hashtable sc_habcount_st=new Hashtable();
	  			  		  	while(rs10.next()){
	  			  		  		  	
	  			  		  	sc_habcount_st.put(rs10.getString(1)+rs10.getString(2),rs10.getInt(3));
	  			  		  	}

	  			  		  if(stmt3!=null){
	  			  			stmt3.close();
	  			  		}
	  			  		if(rs10!=null){
	  			  			rs10.close();
	  			  		}
	  			  		
	  			  		
	  			  		
	  			  		///
	  			  	stmt3 = conn.createStatement();
					  	
					  	String plainhabcountinst="select substr(sc.work_id,5,2),substr(sc.work_id,1,2),count(l.hab_code) from rws_st_works_view sc left join rws_work_admn_tbl a on (sc.work_id=a.work_id) left join  rws_admn_hab_lnk_tbl l on (sc.work_id=l.work_id) left join rws_habitation_directory_tbl hd on (l.hab_code=hd.hab_code) where a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and hd.CENSUS_PLAIN_POPU>(hd.CENSUS_SC_POPU+hd.CENSUS_ST_POPU) and WORK_CANCEL_DT  is null ";
			 		 	 
			  			  if(myWorkList2.length()!=0)
				  	        {
			  				plainhabcountinst +=" and sc.work_id not in "+myWorkList2+" ";   
				  	        }   
					  	        if (dcode != null && !dcode.equals("00")) {
					  	        plainhabcountinst+= " and substr(l.work_id,5,2)='" + dcode + "'";
					  				}

					  				if (scheme != null && !scheme.equals("")) {
					  				plainhabcountinst+= " and a.type_of_asset in(" + scheme + ")";
					  				}
					  				
					  				if(category!=null && !category.equals("")){
					  				plainhabcountinst += " and a.special_cat='" + category + "'";
					  				}
					  			plainhabcountinst+=" and  substr(sc.work_id,1,2) in ("+programe+") group by substr(sc.work_id,5,2),substr(sc.work_id,1,2) ";

					  	//System.out.println(" plainhabcountinst query "+plainhabcountinst);
					  		  	 rs16=stmt3.executeQuery(plainhabcountinst);
					  		  
					  		  	Hashtable p_habcount_st=new Hashtable();
					  		  	while(rs16.next()){
					  		  		  	
					  		  	p_habcount_st.put(rs16.getString(1)+rs16.getString(2),rs16.getInt(3));
					  		  	}

					  		  if(stmt3!=null){
					  			stmt3.close();
					  		}
					  		if(rs16!=null){
					  			rs16.close();
					  		}
				  	

		  	
	  			  		
	  			  		//
	  			  		stmt3 = conn.createStatement();
	  				  	
	  				  	String sthabcountinst="select substr(sc.work_id,5,2),substr(sc.work_id,1,2),count(l.hab_code) from rws_st_works_view sc left join rws_work_admn_tbl a on (sc.work_id=a.work_id) left join  rws_admn_hab_lnk_tbl l on (sc.work_id=l.work_id) left join rws_habitation_directory_tbl hd on (l.hab_code=hd.hab_code) where a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and hd.CENSUS_ST_POPU>(hd.CENSUS_SC_POPU+hd.CENSUS_PLAIN_POPU) and WORK_CANCEL_DT  is null ";
	  				 
	  				  	 if(myWorkList2.length()!=0)
			  	        {
	  				  		sthabcountinst +=" and sc.work_id not in "+myWorkList2+" ";   
			  	        }     
	  				  	        if (dcode != null && !dcode.equals("00")) {
	  				  	        sthabcountinst+= " and substr(l.work_id,5,2)='" + dcode + "'";
	  				  				}

	  				  				if (scheme != null && !scheme.equals("")) {
	  				  				sthabcountinst+= " and a.type_of_asset in(" + scheme + ")";
	  				  				}
	  				  				
	  				  				if(category!=null && !category.equals("")){
	  				  				sthabcountinst += " and a.special_cat='" + category + "'";
	  				  				}
	  				  			sthabcountinst+=" and  substr(sc.work_id,1,2) in ("+programe+")  group by substr(sc.work_id,5,2),substr(sc.work_id,1,2) ";

	  				  	//System.out.println(" sthabcountinst query "+sthabcountinst);
	  				  		  	 rs13=stmt3.executeQuery(sthabcountinst);
	  				  		  
	  				  		  	Hashtable st_habcount_st=new Hashtable();
	  				  		  	while(rs13.next()){
	  				  		  		  	
	  				  		  	st_habcount_st.put(rs13.getString(1)+rs13.getString(2),rs13.getInt(3));
	  				  		  	}

	  				  		  if(stmt3!=null){
	  				  			stmt3.close();
	  				  		}
	  				  		if(rs13!=null){
	  				  			rs13.close();
	  				  		}
	  			  	
	  	
	  	//String delqry="drop table rws_sc_st_performance_temp_tbl"; 
	  	session.setAttribute("plain_hash",plain_hash);
		session.setAttribute("works_plain_hash",works_plain_hash);
		session.setAttribute("plain_exp_hash",plain_exp_hash);
		session.setAttribute("plain_tender_hash",plain_tender_hash);
		session.setAttribute("plain_tender_wrk_hash",plain_tender_wrk_hash);
		session.setAttribute("wcplain_tender_hash",wcplain_tender_hash);
		session.setAttribute("wcscst_tender_hash",wcscst_tender_hash);
		session.setAttribute("wcplain_tender_wrk_hash",wcplain_tender_wrk_hash);
		session.setAttribute("wcscst_tender_wrk_hash",wcscst_tender_wrk_hash);
		session.setAttribute("scst_hash",scst_hash);
		session.setAttribute("habscount_scst_sc_hash",habscount_scst_sc_hash);
		session.setAttribute("habscount_scst_st_hash",habscount_scst_st_hash);
		session.setAttribute("habscount_scst_p_hash",habscount_scst_p_hash);
		session.setAttribute("works_scst_hash",works_scst_hash);
		session.setAttribute("scst_exp_hash",scst_exp_hash);
		session.setAttribute("scst_tender_hash",scst_tender_hash);
		session.setAttribute("scst_tender_wrk_hash",scst_tender_wrk_hash);
		session.setAttribute("scpop_works_hab_hash",scpop_works_hab_hash);
		session.setAttribute("sc_bef_exp_hash",sc_bef_exp_hash);
		session.setAttribute("sc_exp_hash",sc_exp_hash);
		session.setAttribute("spillOverWorksHashsc",spillOverWorksHashsc);
		session.setAttribute("tenderHashsc",tenderHashsc);
		session.setAttribute("workscomptdHashsc",workscomptdHashsc);
		session.setAttribute("sc_habcount_sc",sc_habcount_sc);
		session.setAttribute("st_habcount_sc",st_habcount_sc);
		session.setAttribute("p_habcount_sc",p_habcount_sc);
		session.setAttribute("stpop_works_hab_hash",stpop_works_hab_hash);
		session.setAttribute("st_bef_exp_hash",st_bef_exp_hash);
		session.setAttribute("st_exp_hash",st_exp_hash);
		session.setAttribute("spillOverWorksHashst",spillOverWorksHashst);
		session.setAttribute("tenderHashst",tenderHashst);
		session.setAttribute("workscomptdHashst",workscomptdHashst);
		session.setAttribute("sc_habcount_st",sc_habcount_st);
		session.setAttribute("p_habcount_st",p_habcount_st);
		session.setAttribute("st_habcount_st",st_habcount_st);

	  	
//System.out.println("hello");
		  		
	double g9=0.0,g10=0.0,g11=0.0,g12=0.0,g13=0.0,g14=0.0,g19=0.0,g20=0.0,g21=0.0,g22=0.0,g25=0.0,g26=0.0,g28=0.0,g29=0.0,g30=0.0,g31=0.0,g32=0.0,g33=0.0,g34=0.0,g35=0.0,g36=0.0;
	int g5=0,g6=0,g7=0,g8=0,g15=0,g16=0,g17=0,g18=0,g23=0,g24=0,g27=0,recCount = 0;
	
	  		
	  		  	
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
			stmt7 = conn.createStatement();

        //System.out.println("19) Main query....... "+newWorksQuery);
			rs7 = stmt7.executeQuery(newWorksQuery);
			while (rs7.next()) {
				int workcountsc=0,habcountsc=0,scpopcountsc=0,scpopcountst=0,scpopcountp=0,workcountst=0,habcountst=0,stpopcountsc=0,stpopcountst=0,stpopcountp=0,workcountp=0,habcountp=0,ppopcountsc=0,ppopcountst=0,ppopcountp=0;
				double scworkestsc=0.0,scworkestst=0.0,scworkestp=0.0,comptdscSanctionedAmt=0.0,stworkestsc=0.0,stworkestst=0.0,stworkestp=0.0,comptdstSanctionedAmt=0.0,pworkestsc=0.0,pworkestst=0.0,pworkestp=0.0,comptdpSanctionedAmt=0.0;
				double sctenderestsc=0.0,sctenderestst=0.0,sctenderestp=0.0,scspillSanctionedAmt = 0.0,tscSanctionedAmt=0.0,tstSanctionedAmt=0.0,tpSanctionedAmt=0.0, scSanctionedAmt = 0.0,scExpenditureAmt=0.0,scEstimationAmt=0.0,scEstcost2=0.0,scEstcost1=0.0,scExpenditureAmtb=0.0,scL13ExpenditureAmt=0.0,scL14ExpenditureAmt=0.0;
				double sttenderestsc=0.0,sttenderestst=0.0,sttenderestp=0.0,stspillSanctionedAmt = 0.0, stSanctionedAmt = 0.0,stExpenditureAmt=0.0,stEstimationAmt=0.0,stEstcost2=0.0,stEstcost1=0.0,stExpenditureAmtb=0.0,stL13ExpenditureAmt=0.0,stL14ExpenditureAmt=0.0;
				double ptenderestsc=0.0,ptenderestst=0.0,ptenderestp=0.0,pspillSanctionedAmt = 0.0, pSanctionedAmt = 0.0,pExpenditureAmt=0.0,pEstimationAmt=0.0,pEstcost2=0.0,pEstcost1=0.0,pExpenditureAmtb=0.0,pL13ExpenditureAmt=0.0,pL14ExpenditureAmt=0.0;
				int tworkcountsc=0,thabcountsc=0,tscpopcountsc=0,tscpopcountst=0,tscpopcountp=0,tworkcountst=0,thabcountst=0,tstpopcountsc=0,tstpopcountst=0,tstpopcountp=0,tworkcountp=0,thabcountp=0,tppopcountsc=0,tppopcountst=0,tppopcountp=0;
				int comptdworkcountsc=0,comptdhabcountsc=0,comptdscpopcountsc=0,comptdscpopcountst=0,comptdscpopcountp=0,comptdworkcountst=0,comptdhabcountst=0,comptdstpopcountsc=0,comptdstpopcountst=0,comptdstpopcountp=0,comptdworkcountp=0,comptdhabcountp=0,comptdppopcountsc=0,comptdppopcountst=0,comptdppopcountp=0;
				int schabsc=0,schabst=0,schabp=0,sthabsc=0,sthabst=0,sthabp=0;
				double ssscEstcost2=0.0,ssscExpenditureAmt=0.0,ssscL13ExpenditureAmt=0.0,ssscL14ExpenditureAmt=0.0,ssstEstcost2=0.0,ssstExpenditureAmt=0.0,ssstL13ExpenditureAmt=0.0,ssstL14ExpenditureAmt=0.0;
			    double sspEstcost2=0.0,sspExpenditureAmt=0.0,sspL13ExpenditureAmt=0.0,sspL14ExpenditureAmt=0.0,scL13expscshare=0.0,scL13expstshare=0.0,stL13expscshare=0.0,stL13expstshare=0.0,scL14expscshare=0.0,scL14expstshare=0.0,stL14expscshare=0.0,stL14expstshare=0.0,scexpscshare=0.0,scexpstshare=0.0,stexpscshare=0.0,stexpstshare=0.0,scestcostscshare=0.0,scestcoststshare=0.0,stestcostscshare=0.0,stestcoststshare=0.0,plainExpenditureAmt=0.0,scstExpenditureAmt=0.0;
				int scsthabcount=0,pplainhabcount=0,scstpopsc=0,scstpopst=0,scstpopp=0,plainpopsc=0,plainpopst=0,plainpopp=0,plaintotal=0,scsttotal=0;
		        double scstl13exp=0.0,scstl13expscshare=0.0,scstl13expstshare=0.0,scstl14exp=0.0,scstl14expscshare=0.0,scstl14expstshare=0.0,plainl13exp=0.0,plainl14exp=0.0;
		        int plainhabpopp=0,plainhabpopsc=0,plainhabpopst=0,scsthabpopp=0,scsthabpopsc=0,scsthabpopst=0,scsttotworks=0,plaintotworks=0;
		        double scstsnamt=0.0,scstsnamtpshare=0.0,scstsnamtscshare=0.0,scstsnamtstshare=0.0, plainsnamt=0.0, plainsnamtpshare=0.0;
		        double plainexp=0.0,tenderplainsnamt=0.0,tenderscstsnamt=0.0,tenderplainsnamtpshare=0.0,tenderscstsnamtpshare=0.0,tenderscstsnamtscshare=0.0,tenderscstsnamtstshare=0.0,scstexp=0.0;
		        int tenderplainpopp=0,schab=0,sthab=0,plainhab=0,tenderplainpopsc=0,tenderplainpopst=0,tenderplaintotal=0, wctenderplainpopp=0, wctenderplainpopsc=0,wctenderplainpopst=0, wctenderplaintotal=0;
		        int tenderscstpopp=0,tenderscstpopsc=0,tenderscstpopst=0,tenderscsttotal=0,wctenderscstpopp=0,wctenderscstpopsc=0,wctenderscstpopst=0,wctenderscsttotal=0,workscsthabcount=0;
		        int workplainhabcount=0,workscstpopsc=0, workscstpopst=0, workscstpopp=0, workplainpopsc=0,workplainpopst=0,workplainpopp=0,workplaintotal=0,workscsttotal=0;
		        double workscstl13exp=0.0,workscstl14exp=0.0,workplainl13exp=0.0,workplainl14exp=0.0;
		        int workplainhabpopp=0,workplainhabpopsc=0,workplainhabpopst=0,workscsthabpopp=0,workscsthabpopsc=0,workscsthabpopst=0,workscsttotworks=0,workplaintotworks=0;
		        double workscstsnamt=0.0, workscstsnamtpshare=0.0, workplainsnamt=0.0,workplainsnamtpshare=0.0,workplainsnamtscshare=0.0,workplainsnamtstshare=0.0;
		        int tenderplainhabcount=0,tenderscsthabcount=0,sc40count=0,st40count=0;   
		        double scstExpenditureAmtb=0.0,scstExpenditureAmtscshare=0.0,scstExpenditureAmtstshare=0.0,plainExpenditureAmtb=0.0;   
		        double pL13expscshare=0.0, pL13expstshare=0.0, pL14expscshare=0.0,pL14expstshare=0.0, pexpscshare=0.0, pexpstshare=0.0,pestcostscshare=0.0,pestcoststshare=0.0;
		              
		              
			  
					
				String programeCode=rs7.getString(4); 
				
				 int schabcount=0,sthabcount=0,phabcount=0;
					if(habscount_scst_sc_hash.get(rs7.getString(3)+rs7.getString(4))!=null){
						 schabcount=(Integer)habscount_scst_sc_hash.get(rs7.getString(3)+rs7.getString(4));   
			      	  // System.out.println("sc "+schabcount);
			      
					 }
				           if(habscount_scst_st_hash.get(rs7.getString(3)+rs7.getString(4))!=null){
				        	   sthabcount=(Integer)habscount_scst_st_hash.get(rs7.getString(3)+rs7.getString(4)); 
				        	  // System.out.println("st "+sthabcount);
				            }
				           if(habscount_scst_p_hash.get(rs7.getString(3)+rs7.getString(4))!=null){
				        	   phabcount=(Integer)habscount_scst_p_hash.get(rs7.getString(3)+rs7.getString(4));  
				        	   //System.out.println("plain "+phabcount);
			     
				           }
				if(sc_habcount_sc.get(rs7.getString(3)+rs7.getString(4))!=null){
					schabsc=(Integer)sc_habcount_sc.get(rs7.getString(3)+rs7.getString(4));
				}
				if(st_habcount_sc.get(rs7.getString(3)+rs7.getString(4))!=null){
					schabst=(Integer)st_habcount_sc.get(rs7.getString(3)+rs7.getString(4));
				}
				if(p_habcount_sc.get(rs7.getString(3)+rs7.getString(4))!=null){
					schabp=(Integer)p_habcount_sc.get(rs7.getString(3)+rs7.getString(4));
				}
				if(sc_habcount_st.get(rs7.getString(3)+rs7.getString(4))!=null){
					sthabsc=(Integer)sc_habcount_st.get(rs7.getString(3)+rs7.getString(4));
				}
				if(st_habcount_st.get(rs7.getString(3)+rs7.getString(4))!=null){
					sthabst=(Integer)st_habcount_st.get(rs7.getString(3)+rs7.getString(4));
				}
				if(p_habcount_st.get(rs7.getString(3)+rs7.getString(4))!=null){
					sthabp=(Integer)p_habcount_st.get(rs7.getString(3)+rs7.getString(4));
				}
				
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
		              // System.out.println("befor  1>"+scEstcost2+"   2>"+scExpenditureAmt+"  3>"+scL13ExpenditureAmt+"  4>"+scL14ExpenditureAmt);
		              // System.out.println("------programeCode-------"+programeCode);
		               if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
							
						 ssscEstcost2=0.5*scEstcost2;
						 ssscExpenditureAmt=0.5*scExpenditureAmt;
						 ssscL13ExpenditureAmt=0.5*scL13ExpenditureAmt;
						 ssscL14ExpenditureAmt=0.5*scL14ExpenditureAmt;
						 //System.out.println("after 1>"+scEstcost2+" 2> "+scExpenditureAmt+" 3>"+scL13ExpenditureAmt+" 4>"+scL14ExpenditureAmt);
						}
						

					 int totpopsc=scpopcountsc+scpopcountst+scpopcountp;
					 if(totpopsc==0){
						 scL13expscshare=0.0;
						 scL14expstshare=0.0;
						 scexpscshare=0.0;
						 scexpstshare=0.0;
						 scestcostscshare=0.0;
						 scL13expstshare=0.0;
						 scestcostscshare=0.0;
						 scL14expscshare=0.0;
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
					if(schabst==0){
						 scexpstshare=0.0;
						 scL14expstshare=0.0;
						 scL13expstshare=0.0;
						 scestcoststshare=0.0;
						 scworkestst=0.0;
						 sctenderestst=0.0;
					}
					if(schabst==0){
						 scworkestp=0.0;
						 sctenderestp=0.0;	
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
	comptdworkcountst = Integer.parseInt(worksstValues[0]);
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
	 stL13expstshare=0.0;
	 stestcostscshare=0.0;
	 stL14expscshare=0.0;

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
if(sthabsc==0){
	 stexpscshare=0.0;
	 stL14expscshare=0.0;
	 stL13expscshare=0.0;
	 stestcostscshare=0.0;
	 sttenderestsc=0.0;
	 stworkestsc=0.0;
}
if(sthabp==0){
	sttenderestp=0.0;
	 stworkestp=0.0;
}

					//st complet
               
               
                
                
               
              
             
				
				 if(plain_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
            		   {
            	   //System.out.println("hi this is plain");
            	   String plainpop = (String) plain_hash.get(rs7.getString(1)+rs7.getString(2));
					String plainpopValues[] = plainpop.split("@");
					pplainhabcount=Integer.parseInt(plainpopValues[0]);
            	   //System.out.println("plainhabcount is "+plainhabcount);
            	   plainpopp=Integer.parseInt(plainpopValues[1]);
            	   plainpopsc=Integer.parseInt(plainpopValues[2]);
            	   plainpopst=Integer.parseInt(plainpopValues[3]);
            	  
            	   plaintotal=plainpopsc+plainpopst+plainpopp;
               }
				 if(plain_tender_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
      		   {
      	   //System.out.println("hi this is plain");
      	   String tenderplainpop = (String) plain_tender_hash.get(rs7.getString(1)+rs7.getString(2));
				String tenderplainpopValues[] = tenderplainpop.split("@");
				tenderplainhabcount=Integer.parseInt(tenderplainpopValues[0]);
      	   //System.out.println("plainhabcount is "+plainhabcount);
      	   tenderplainpopp=Integer.parseInt(tenderplainpopValues[1]);
      	   tenderplainpopsc=Integer.parseInt(tenderplainpopValues[2]);
      	   tenderplainpopst=Integer.parseInt(tenderplainpopValues[3]);
      	
      	   tenderplaintotal=tenderplainpopsc+tenderplainpopst+tenderplainpopp;
      	  // System.out.println("ptendertotpop"+tenderplaintotal);
         }
				
				 if(scst_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
      		   {
      	   //System.out.println("hi this is plain");
      	   String scstpop = (String) scst_hash.get(rs7.getString(1)+rs7.getString(2));
				String scstpopValues[] = scstpop.split("@");
      	   scsthabcount=Integer.parseInt(scstpopValues[0]);
      	   //System.out.println("plainhabcount is "+plainhabcount);
      	   scstpopp=Integer.parseInt(scstpopValues[1]);
      	 scstpopsc=Integer.parseInt(scstpopValues[2]);
      	scstpopst=Integer.parseInt(scstpopValues[3]);
      	//System.out.println("scstpopp-"+scstpopp+" scstpops-"+scstpopsc+" scstpopst-"+scstpopst);
      	   scsttotal=scstpopsc+scstpopst+scstpopp;
      	  double scpoppercentage=(scstpopp/scsttotal)*100;
      	 double stpoppercentage=(scstpopp/scsttotal)*100;
      	 double ppoppercentage=(scstpopp/scsttotal)*100;
      	 //if(scpoppercentage>40){
      		// schab=schab+1;
      		 
      	// }
      	// if(stpoppercentage>40)
      	// {
      	//	sthab=sthab+1; 
      	// }
      	//if(ppoppercentage>40)
     	// {
     	//	plainhab=plainhab+1; 
     	// }
         }
				
				 if(scst_tender_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
	      		   {
	      	   //System.out.println("hi this is plain");
	      	   String tenderscstpop = (String) scst_tender_hash.get(rs7.getString(1)+rs7.getString(2));
					String scstplainpopValues[] = tenderscstpop.split("@");
					tenderscsthabcount=Integer.parseInt(scstplainpopValues[0]);
	      	   //System.out.println("plainhabcount is "+plainhabcount);
	      	   tenderscstpopp=Integer.parseInt(scstplainpopValues[1]);
	      	   tenderscstpopsc=Integer.parseInt(scstplainpopValues[2]);
	      	   tenderscstpopst=Integer.parseInt(scstplainpopValues[3]);
	      	  
	      	   tenderscsttotal=tenderscstpopsc+tenderscstpopst+tenderscstpopp;
	      	 //System.out.println("scsttenderscsttotal"+tenderscsttotal);
	         }
				 if(plain_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
				 {
					 if(!plain_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2)).equals("null")){
	                	  tenderplainsnamt=Double.parseDouble((String)plain_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2)));
	                	 
	                	  tenderplainsnamtpshare=(tenderplainsnamt/tenderplaintotal)*tenderplainpopp;
	                	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
	("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
	                		  tenderplainsnamtpshare=0.5*tenderplainsnamtpshare;
	                      } 
	                	  
					 }
				 }
				 if(scst_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
				 {
					 if(!scst_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2)).equals("null")){
	                	  tenderscstsnamt=Double.parseDouble((String)scst_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2)));
	                	 
	                	  tenderscstsnamtpshare=(tenderscstsnamt/tenderscsttotal)*tenderscstpopp;
	                	  tenderscstsnamtscshare=(tenderscstsnamt/tenderscsttotal)*tenderscstpopsc;
	                	  tenderscstsnamtstshare=(tenderscstsnamt/tenderscsttotal)*tenderscstpopst;
	                	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
	("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
	                		  tenderscstsnamtpshare=0.5*tenderscstsnamtpshare;
	                		  tenderscstsnamtscshare=0.5*tenderscstsnamtscshare;
	                		  tenderscstsnamtstshare=0.5*tenderscstsnamtstshare;
	                      } 
	                	  
					 }
				 }
				 
								 if(works_plain_hash.get(rs7.getString(1)+rs7.getString(2))!=null){
									 String plainworkdet=(String)works_plain_hash.get(rs7.getString(1)+rs7.getString(2));
				                	  String plainworkdetvalues[]=plainworkdet.split("@");
				                	  plaintotworks=Integer.parseInt(plainworkdetvalues[0]);
				                	 
				                	  if(!plainworkdetvalues[3].equals("null")){
				                	  plainsnamt=Double.parseDouble(plainworkdetvalues[3]);
				                	 
				                	  plainsnamtpshare=(plainsnamt/plaintotal)*plainhabpopp;
				                	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
				("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
				                		  plainsnamtpshare=0.5*plainsnamtpshare;
				                      }
				                	  }
				                	  if(!plainworkdetvalues[1].equals("null")){
				                   	   plainl13exp=Double.parseDouble(plainworkdetvalues[1]);}
				                   	   if(!plainworkdetvalues[2].equals("null")){
				                   	   plainl14exp=Double.parseDouble(plainworkdetvalues[2]);}
				                   	   
									 
								 }
								 if(works_scst_hash.get(rs7.getString(1)+rs7.getString(2))!=null){
									 String scstworkdet=(String)works_scst_hash.get(rs7.getString(1)+rs7.getString(2));
				                	  String scstworkdetvalues[]=scstworkdet.split("@");
				                	  scsttotworks=Integer.parseInt(scstworkdetvalues[0]);
				                	 //System.out.println("aaaa"+scsttotworks);
				                	  if(!scstworkdetvalues[1].equals("null")){
				                		  scstl13exp=Double.parseDouble(scstworkdetvalues[1]);
				                		  scstl13expscshare=(scstl13exp/scsttotal)*scstpopsc;
				                		  scstl13expstshare=(scstl13exp/scsttotal)*scstpopst;
				                	  }
				                   	   if(!scstworkdetvalues[2].equals("null")){
				                   		scstl14exp=Double.parseDouble(scstworkdetvalues[2]);
				                   		scstl14expscshare=(scstl14exp/scsttotal)*scstpopsc;
				                		  scstl14expstshare=(scstl14exp/scsttotal)*scstpopst;
				                   	   
				                   	   }
				                   	   
				                	  if(!scstworkdetvalues[3].equals("null")){
				                		  scstsnamt=Double.parseDouble(scstworkdetvalues[3]);
				                	 
				                		  scstsnamtpshare=(scstsnamt/scsttotal)*scstpopp;
				                		  scstsnamtscshare=(scstsnamt/scsttotal)*scstpopsc;
				                		  scstsnamtstshare=(scstsnamt/scsttotal)*scstpopst;
				                	  
				                	  }
				                	  
				                	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
				              				("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
				              				                		  scstsnamtpshare=0.5*scstsnamtpshare;
				              				                		  scstsnamtscshare=0.5*scstsnamtscshare;
				              				                		  scstsnamtstshare=0.5*scstsnamtstshare;
				              				                		scstl13expscshare=0.5*scstl13expscshare;
				              				                		scstl13expstshare=0.5*scstl13expstshare;
				              				                		scstl14expscshare=0.5*scstl14expscshare;
				              				                		scstl14expstshare=0.5*scstl14expstshare;
				              				                      }
								 }
								 
								 
								 if(plain_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
										plainExpenditureAmt=Double.parseDouble((String)plain_exp_hash.get(rs7.getString(3)+ 
					rs7.getString(4)));
									if(plainpopp==0)
									{
										plainExpenditureAmt=0.0;	
									}
									
									}
					               if(scst_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
										scstExpenditureAmt=Double.parseDouble((String)scst_exp_hash.get(rs7.getString(3)+ 
					rs7.getString(4)));
										scstExpenditureAmtscshare=(scstExpenditureAmt/scsttotal)*scstpopsc;
										scstExpenditureAmtstshare=(scstExpenditureAmt/scsttotal)*scstpopst;
										if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
												("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
											scstExpenditureAmtscshare=0.5*scstExpenditureAmtscshare;
											scstExpenditureAmtstshare=0.5*scstExpenditureAmtstshare;       		  
												             }
										if(scsttotal==0)
										{
											scstExpenditureAmtscshare=0.0;	
											scstExpenditureAmtstshare=0.0;	
										}
									}
		////works comptd
		
		if(wcplain_tender_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
      		   {
      	   //System.out.println("hi this is plain");
      	   String wctenderplainpop = (String) wcplain_tender_hash.get(rs7.getString(1)+rs7.getString(2));
				String wctenderplainpopValues[] = wctenderplainpop.split("@");
				workplainhabcount=Integer.parseInt(wctenderplainpopValues[0]);
      	   //System.out.println("plainhabcount is "+plainhabcount);
      	   wctenderplainpopp=Integer.parseInt(wctenderplainpopValues[1]);
      	   wctenderplainpopsc=Integer.parseInt(wctenderplainpopValues[2]);
      	   wctenderplainpopst=Integer.parseInt(wctenderplainpopValues[3]);
      	
      	   wctenderplaintotal=wctenderplainpopsc+wctenderplainpopst+wctenderplainpopp;
      	   //System.out.println("ptendertotpop"+tenderplaintotal);
         }
		if(wcscst_tender_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
		   {
	   //System.out.println("hi this is plain");
	   String wctenderscstpop = (String) wcscst_tender_hash.get(rs7.getString(1)+rs7.getString(2));
			String wctenderscstpopValues[] = wctenderscstpop.split("@");
			workscsthabcount=Integer.parseInt(wctenderscstpopValues[0]);
	   //System.out.println("plainhabcount is "+plainhabcount);
	   wctenderscstpopp=Integer.parseInt(wctenderscstpopValues[1]);
	   wctenderscstpopsc=Integer.parseInt(wctenderscstpopValues[2]);
	   wctenderscstpopst=Integer.parseInt(wctenderscstpopValues[3]);
	   
	   wctenderscsttotal=wctenderscstpopsc+wctenderscstpopst+wctenderscstpopp;
	   double scpercentage=(wctenderscstpopsc/wctenderscsttotal)*100;
	   double stpercentage=(wctenderscstpopst/wctenderscsttotal)*100;
	   if( scpercentage>40)
	   {
		 sc40count=sc40count+1;
		 
	   }
	   if( stpercentage>40)
	   {
		 st40count=st40count+1;
		 
	   }
	   //System.out.println("ptendertotpop"+tenderplaintotal);
  }		
		 if(wcplain_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
		 {
			 String wcplainworkdet=(String)wcplain_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2));
       	  String wcplainworkdetvalues[]=wcplainworkdet.split("@");
       	workplaintotworks=Integer.parseInt(wcplainworkdetvalues[0]);
       	 //System.out.println("aaaa"+scsttotworks);
       	  if(!wcplainworkdetvalues[1].equals("null")){
       		workplainsnamt=Double.parseDouble(wcplainworkdetvalues[1]);
       	 
       		workplainsnamtpshare=(workplainsnamt/wctenderplaintotal)*wctenderplainpopp;
       		if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
       		workplainsnamtpshare=0.5*workplainsnamtpshare;
       		
             }
       	  } 
		 }
			               
		 if(wcscst_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
		 {
			 String wcscstworkdet=(String)wcscst_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2));
	       	  String wcscstworkdetvalues[]=wcscstworkdet.split("@");
	       	workscsttotworks=Integer.parseInt(wcscstworkdetvalues[0]);
	       	 //System.out.println("aaaa"+scsttotworks);
	       	  if(!wcscstworkdetvalues[1].equals("null")){
	       		workscstsnamt=Double.parseDouble(wcscstworkdetvalues[1]);
	       	 
	       		workscstsnamtpshare=(workscstsnamt/wctenderscsttotal)*wctenderscstpopp;
	       		workplainsnamtscshare=(workscstsnamt/wctenderscsttotal)*wctenderscstpopsc;
	       		workplainsnamtstshare=(workscstsnamt/wctenderscsttotal)*wctenderscstpopst;
	       	  
	       	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
	("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
	       		workscstsnamtpshare=0.5*workscstsnamtpshare;
	       		workplainsnamtscshare=0.5*workplainsnamtscshare;
	       		workplainsnamtstshare=0.5*workplainsnamtstshare;  
	             }
	       	  } 
		 }		
	

               if(dname.equals(rs7.getString(1))||temp.equals(rs7.getString(1))){
            	   dname="-";
               }else{
            	   dname=rs7.getString(1);
               }
               
               /////
             
               
               
               ////addhere 1)
                          		   
	%>
	<tr>
		<td rowspan="5" class=<%=style%>><%=++recCount%></td>

		<td rowspan="5" class="gridbg1" style="text-align: left;"><%=dname%></td>
		<td rowspan="5" class="gridbg1" style="text-align: left;"><%=rs7.getString(2)%></td>
		<td class="gridbg1" style="text-align: center;">SC>40%</td>

		<td class="gridbg1" style="text-align: right;"><%=workcountsc%></td>

		<td class="gridbg1" style="text-align: right;"><%=schabsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=schabst %></td>
		<td class="gridbg1" style="text-align: right;"><%=schabp %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scEstcost2) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scestcostscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scestcoststshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scexpscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scexpstshare) %></td>
		<td class="gridbg1"  style="text-align: right;"><%=scpopcountsc+scpopcountst+scpopcountp%></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountsc %></td>
		<td class="gridbg1"  style="text-align: right;"><%=scpopcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tworkcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tscSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sctenderestp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sctenderestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sctenderestst) %></td>
		
		<td class="gridbg1" style="text-align: right;"><%=comptdworkcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountsc %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(comptdscSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scworkestp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scworkestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scworkestst) %></td>
		<td class="gridbg1" style="text-align: right;"><%=scL13ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13expstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=scL14ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14expstshare) %></td>
	</tr>
	
	<tr>
		<td class="gridbg1" style="text-align: center;">ST>40%</td>

		<td class="gridbg1" style="text-align: right;"><%=workcountst%></td>
       <td class="gridbg1" style="text-align: right;"><%=sthabsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=sthabst %></td>
		<td class="gridbg1" style="text-align: right;"><%=sthabp %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stEstcost2) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stestcostscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stestcoststshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stexpscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stexpstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=stpopcountsc+stpopcountst+stpopcountp %></td>
		<td class="gridbg1" style="text-align: right;"><%=stpopcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=stpopcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tworkcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tstSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sttenderestp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sttenderestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sttenderestst) %></td>
		
	
		<td class="gridbg1" style="text-align: right;"><%=comptdworkcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountst %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(comptdstSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stworkestp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stworkestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stworkestst) %></td>
		<td class="gridbg1" style="text-align: right;"><%=stL13ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL13expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL13expstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=stL14ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL14expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL14expstshare) %></td>
</tr>

	<tr>
		<td class="gridbg1" style="text-align: center;"><40%</td>

		<td class="gridbg1" style="text-align: right;"><%=scsttotworks %></td>
       <td class="gridbg1" style="text-align: right;"><%=schabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=sthabcount %></td>
		
		<td class="gridbg1" style="text-align: right;"><%=phabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstsnamtscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstsnamtstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstExpenditureAmtscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstExpenditureAmtstshare) %></td>
	
		<td class="gridbg1" style="text-align: right;"><%=scsttotal %></td>
		<td class="gridbg1" style="text-align: right;"><%=scstpopsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=scstpopst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tenderscsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderscstsnamt) %></td>
				<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderscstsnamtpshare) %></td>
		
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderscstsnamtscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderscstsnamtstshare) %></td>
	
		<td class="gridbg1" style="text-align: right;"><%=workscsttotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=workscsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=sc40count %></td>
		<td class="gridbg1" style="text-align: right;"><%=st40count %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workscstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workscstsnamtpshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workplainsnamtscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workplainsnamtstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl13exp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl13expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl13expstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl14exp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl14expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl14expstshare) %></td>
	</tr>
	<tr>
		<td class="gridbg1" style="text-align: center;">Plain</td>

		<td class="gridbg1" style="text-align: right;"><%=plaintotworks %></td>
       <td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		
		<td class="gridbg1" style="text-align: right;"><%=pplainhabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainsnamt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	
		<td class="gridbg1" style="text-align: right;"><%=plainpopp %></td>
		<td class="gridbg1" style="text-align: right;"><%=plainpopsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=plainpopst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tenderplainhabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderplainsnamt) %></td>
				<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderplainsnamtpshare) %></td>
		
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
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainl13exp) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainl14exp) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	</tr>
	<tr>
		<td class="gridbg1" style="text-align: center;">Sub Total</td>

		<td class="gridbg1" style="text-align: right;"><%=workcountsc+workcountst+plaintotworks+scsttotworks%></td>

		<td class="gridbg1" style="text-align: right;"><%=schabsc+sthabsc+schabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=schabst+sthabst+sthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=schabp+sthabp+pplainhabcount+phabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scEstcost2+stEstcost2+plainsnamt+scstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scestcostscshare+scstsnamtscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stestcoststshare+scstsnamtstshare) %></td>
		
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scExpenditureAmt+stExpenditureAmt+plainExpenditureAmt+scstExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scexpscshare+scstExpenditureAmtscshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stexpstshare+scstExpenditureAmtstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountsc+scpopcountst+scpopcountp+stpopcountsc+stpopcountst+stpopcountp+plainpopp+scsttotal %></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountsc+stpopcountsc+scstpopsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountst+stpopcountst+scstpopst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tworkcountsc+tworkcountst+tenderplainhabcount+tenderscsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tscSanctionedAmt+tstSanctionedAmt+tenderplainsnamt+tenderscstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderplainsnamtpshare+tenderscstsnamtpshare+sctenderestp+sttenderestp) %> </td>
        <td class="gridbg1" style="text-align: right;"><%=ndf.format(sctenderestsc+tenderscstsnamtscshare+sttenderestsc) %> </td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sttenderestst+tenderscstsnamtstshare+sctenderestst) %> </td>
		<td class="gridbg1" style="text-align: right;"><%=comptdworkcountsc+comptdworkcountst+workplaintotworks+workscsttotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountsc+comptdhabcountst+workplainhabcount+workscsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountsc+sc40count%></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountst+st40count%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(comptdscSanctionedAmt+comptdscSanctionedAmt+workplainsnamt+workscstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workplainsnamtpshare+workscstsnamtpshare+stworkestp+scworkestp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scworkestsc+workplainsnamtscshare+stworkestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stworkestst+workplainsnamtstshare+scworkestst) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13ExpenditureAmt+stL13ExpenditureAmt+plainl13exp+scstl13exp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13expscshare+scstl13expscshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL13expstshare+scstl13expstshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14ExpenditureAmt+stL14ExpenditureAmt+plainl14exp+scstl14exp)  %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14expscshare+scstl14expscshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL14expstshare+scstl14expstshare)%></td>
		</tr>
	
		

	<%
	g5+=workcountsc+workcountst+plaintotworks+scsttotworks;
	g6+=schabsc+sthabsc+schabcount;
	g7+=schabst+sthabst+sthabcount;
	g8+=schabp+sthabp+pplainhabcount+phabcount; 
	g9+=scEstcost2+stEstcost2+plainsnamt+scstsnamt;
	g10+=scestcostscshare+scstsnamtscshare;
	g11+=stestcoststshare+scstsnamtstshare;
	g12+=scExpenditureAmt+stExpenditureAmt+plainExpenditureAmt+scstExpenditureAmt;
	g13+=scexpscshare+scstExpenditureAmtscshare;
    g14+=stexpstshare+scstExpenditureAmtstshare;
    g15+=scpopcountsc+scpopcountst+scpopcountp+stpopcountsc+stpopcountst+stpopcountp+plainpopp+scsttotal;
    g16+=scpopcountsc+stpopcountsc+scstpopsc;
    g17+=scpopcountst+stpopcountst+scstpopst;
    g18+=tworkcountsc+tworkcountst+tenderplainhabcount+tenderscsthabcount;
    g19+=tscSanctionedAmt+tstSanctionedAmt+tenderplainsnamt+tenderscstsnamt;
    g20+=tenderplainsnamtpshare+tenderscstsnamtpshare+sctenderestp+sttenderestp;
    g21+=sctenderestsc+tenderscstsnamtscshare+sttenderestsc;
    g22+=sttenderestst+tenderscstsnamtstshare+sctenderestst;
    g23+=comptdworkcountsc+comptdworkcountst+workplaintotworks+workscsttotworks;
    g24+=comptdhabcountsc+comptdhabcountst+workplainhabcount+workscsthabcount; 
   	g25+=comptdhabcountsc+sc40count;
    g26+=comptdhabcountst+st40count;
    g27+=comptdscSanctionedAmt+comptdscSanctionedAmt+workplainsnamt+workscstsnamt;
    g28+=workplainsnamtpshare+workscstsnamtpshare+stworkestp+scworkestp;
    g29+=scworkestsc+workplainsnamtscshare+stworkestsc;
    g30+=stworkestst+workplainsnamtstshare+scworkestst;
    g31+=scL13ExpenditureAmt+stL13ExpenditureAmt+plainl13exp+scstl13exp;
    g32+=scL13expscshare+scstl13expscshare;
    g33+=stL13expstshare+scstl13expstshare;
    g34+=scL14ExpenditureAmt+stL14ExpenditureAmt+plainl14exp+scstl14exp;    
    g35+=scL14expscshare+scstl14expscshare;
    g36+=stL14expstshare+scstl14expstshare;
    	temp=rs7.getString(1);
         
			}
			
	%>
	<tr>
	<td align="center" class="gridhdbg" colspan="4">Grand Total</td>
	<td align="center" class="gridhdbg" ><%=g5 %></td>
	<td align="center" class="gridhdbg" ><%=g6 %></td>
	<td align="center" class="gridhdbg" ><%=g7 %></td>
	<td align="center" class="gridhdbg" ><%=g8 %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g9) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g10) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g11) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g12) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g13) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g14) %></td>
	<td align="center" class="gridhdbg" ><%=g15 %></td>
	<td align="center" class="gridhdbg" ><%=g16 %></td>
	<td align="center" class="gridhdbg" ><%=g17 %></td>
	<td align="center" class="gridhdbg" ><%=g18 %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g19) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g20) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g21) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g22) %></td>
	<td align="center" class="gridhdbg" ><%=g23 %></td>
	<td align="center" class="gridhdbg" ><%=g24 %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g25) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g26) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g27) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g28) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g29) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g30) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g31) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g32) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g33) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g34) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g35) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g36) %></td>
	
	
	 </tr>






	<%
	stmt5=conn.createStatement();
	stmt5.executeUpdate("drop table rws_sc_st_performance_temp_tbl");
	if(stmt5!=null)
	{
		stmt5.close();
	}
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