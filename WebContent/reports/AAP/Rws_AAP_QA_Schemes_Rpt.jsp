<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
<%@ page import="java.util.*"%>


<%
String  ctype="";
if (request.getParameter("contType") != null) 
{
	 ctype = request.getParameter("contType");
     session.setAttribute("ctype", ctype);
}
else
{
	ctype="all";//(String)session.getAttribute("ctype");
}
String cType=(String)session.getAttribute("ctype");
if(cType==null){
	cType=ctype;
}
////System.out.println("ctype"+ctype);

	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	DecimalFormat ndf = new DecimalFormat("####.##");
	DecimalFormat ndf1 = new DecimalFormat("##.##");
	String financialstartyr = "";

	double aas = 0;
	String pname = "", distname = "";
	if (request.getParameter("pname") != null) 
	{
		pname = request.getParameter("pname");
		session.setAttribute("pname", pname);
	}
	else
	{
		pname=(String)session.getAttribute("pname");
	}
	
////System.out.println("pname"+pname);
	
	
	if (request.getParameter("distname") != null) 
	{
		distname = request.getParameter("distname");
		session.setAttribute("distname", distname);
	}
	else
	{
		distname=(String)session.getAttribute("distname");
	}
	
	
	
////System.out.println("distname"+distname);
	
	if (request.getParameter("finyear") != null) 
	{
		financialstartyr = request.getParameter("finyear");
		session.setAttribute("financialyr", financialstartyr);
	}
	else
	{
		financialstartyr=(String)session.getAttribute("financialyr");
	}
	//schemes
	String scheme = "";
	if (request.getParameterValues("scheme") != null) 
	{
		String[] schemes = request.getParameterValues("scheme");

		for (int i = 0; i < schemes.length; i++)
		{
			scheme += schemes[i] + ",";
		}
		////////System.out.println("programe::"+programe);
		scheme = scheme.substring(0, scheme.length() - 1);
		session.setAttribute("scheme", scheme);
	
	}
	
	else
	{
		scheme=(String)session.getAttribute("scheme");
	}
	
	
	

	String startyr = financialstartyr.substring(0, 4);
	String endyr = financialstartyr.substring(5, 9);
	String endyr1 = financialstartyr.substring(5, 9);

	int nextyr = Integer.parseInt(endyr1) + 1;

	String nxtfinancialstartyr = endyr1 + "-" + nextyr;

//System.out.println("nxt finyear::" + nxtfinancialstartyr);

	String[] programes = request.getParameterValues("program");

	String programe = "";
	if (request.getParameterValues("program") != null) 
	{
		for (int i = 0; i < programes.length; i++)
		{
			programe += programes[i] + ",";
		}
	   //System.out.println("programe::"+programe);
		programe = programe.substring(0, programe.length() - 1);
		session.setAttribute("programe", programe);
		
		
	}
	else
	{
		programe=(String)session.getAttribute("programe");
		//System.out.println("programe111::"+programe);
	}

	String sysdate = workData.getDate();
	String sysmon = sysdate.substring(3, 5);
	int mon = Integer.parseInt(sysmon);
	//////System.out.println("sysdate::"+sysdate);
	String sysyear = sysdate.substring(6, 10);
	int yy = Integer.parseInt(sysyear);
	//////System.out.println("startyr"+startyr);
	//////System.out.println("sysyear::"+sysyear);
	int prevyear = 0, prevmon = 0;
	String fyear, fyear1;

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

	} else 
	{
		endyr1 = endyr;
	}

	String dcode = request.getParameter("district");
	String divCode = request.getParameter("divCode");

	if (dcode != null && !dcode.equals(""))
	{
		session.setAttribute("dcode", dcode);
		session.setAttribute("divCode", divCode);
	}
	else
	{
		dcode=(String)session.getAttribute("dcode");
		divCode=(String)session.getAttribute("divCode");
	}
	
	String nextfinancialstartyr = "";

	int nextFinYear = yy + 1;
	int nn = nextFinYear + 1;

	nextfinancialstartyr = "" + yy + "-" + nextFinYear;
//System.out.println("startyr"+startyr);
//System.out.println("nextyr::"+nextyr);
	
	
	String myreptype=request.getParameter("type");
//System.out.println("type"+myreptype);
	if (request.getParameter("type") != null && !request.getParameter("type").equals(""))
	{
	 session.setAttribute("myreptype", myreptype);
	
	}
	else
	{
		myreptype=(String)session.getAttribute("myreptype");
		
	}
	session.setAttribute("nextyr", nextyr);
	/////////////////////////////////////////////
	

	
	
%>

<head>
<script language="JavaScript"
	src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>


<script language="JavaScript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,right=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}



function getReport()
{
	//alert("hello getting report");	
	//var aa=document.getElementById("contType").Value;
	//alert(aa);	
	
	document.f1.action="./Rws_AAP_QA_Schemes_Rpt.jsp";    
	document.f1.submit(); 
	
	
}

function fnValidate(){
	//alert("Fsdfd");

	document.getElementById('contType').value='<%=cType %>';
	
}

</script>

</head>
<html>
<body onload="fnValidate();">
<form name="f1">

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
					<td class="bwborder"><a href="./Rws_AAP_QA_Schemes_Frm.jsp">Back|</a><a
						href="./Rws_AAP_QA_Schemes_Excel.jsp" target=_new>Excel</a></td>
				</tr>
				<%
					} else {
				%>
				<tr>
					<td align="right" class="bwborder"><a href="#"
						onclick="window.close()">Close</td>
				</tr>
				<%
					}
				%>
			</table>
		</caption>
		<caption align="right" class="staticLabel">
			<b>Amount in Rs. lakhs</b>
		</caption>
		<tr>
			<td class="bwborder" align="center"><font color="red"><b></b></font></td>
		</tr>
	</table>
	<table  border=0 rules=none style="border-collapse:collapse" width="300" align="center" bgcolor="#ffffff"">
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg" colspan=3>Select Contamination</td>	
	</tr>		
			<tr>
			    <td class="gridbg1">Contamination Type&nbsp;&nbsp;<font color="red">*</font></td>
				<td class="gridbg1">
					<SELECT name="contType" id="contType" class="mycombo"  style="width:100px">
					        <option value="all" selected>ALL</option> 
							<option value="01">Flouride</option>
							<option value="02">Brakish</option>
							<option value="03">Iron</option>	
							<option value="05">Nitrate</option>	
			        </SELECT>
		       </td>
		    </tr>
		    
		    <tr class="gridhdbg" align="center">
		    <td colspan=3  align="center" class="gridhdbg">
			<input type=button id="vbutton" onclick="getReport()" class=btext value="View Report">
		   </td>
	       </tr>
		</table>
<br><br>
		<%
		Statement stmt1 = null, stmt2 = null, stmt3 = null;
		ResultSet rs1 = null, rs2 = null, rs3 = null;
		String spillValues = "", newValues = "", augValues = "", spillexpValues = "", mainValues = "", spill_compValues = "", spill_compexpValues = "", new_compValues = "", aug_compValues = "", main_compValues = "", spill_tarValues = "", new_tarValues = "", aug_tarValues = "", main_tarValues = "";
		String spill_habs = "", new_habs = "", aug_habs = "", main_habs = "", spill_comphabs = "", new_comphabs = "", aug_comphabs = "", main_comphabs = "", spill_tarhabs = "", new_tarhabs = "", aug_tarhabs = "", main_tarhabs = "";
		int newcnt = 0, spillcnt = 0, augcnt = 0, maincnt = 0, gtot1 = 0, gtot3 = 0, gtot4 = 0, spillcompcnt = 0, newcompcnt = 0, augcompcnt = 0, maincompcnt = 0, spilltarcnt = 0, newtarcnt = 0, augtarcnt = 0, maintarcnt = 0, spillanicnt = 0, newanticnt = 0, auganticnt = 0, mainanticnt = 0, bfivecnt = 0, bfivecompcnt = 0, bfiveanticnt = 0, bfivetarcnt = 0, lbfivecnt = 0, lbfivecompcnt = 0, lbfiveanticnt = 0, lbfivetarcnt = 0;
		double new_amt = 0, spill_amt = 0, aug_amt = 0, spill_exp = 0,spill_antiexp = 0,spill_targetexp = 0, spillsan_amt = 0, main_amt = 0, spill_compamt = 0, spill_compexp = 0, spill_compcost = 0, new_compamt = 0, aug_compamt = 0, main_compamt = 0, spill_taramt = 0, new_taramt = 0, aug_taramt = 0, main_taramt = 0, spill_aniamt = 0, new_antiamt = 0, aug_antiamt = 0, main_antiamt = 0, bfive_amt = 0, bfive_compamt = 0, bfive_antiamt = 0, bfive_taramt = 0, lbfive_amt = 0, lbfive_compamt = 0, lbfive_antiamt = 0, lbfive_taramt = 0;
		double gtot2 = 0, ggtot = 0;
		int spill_habcnt = 0, new_habcnt = 0, aug_habcnt = 0, main_habcnt = 0, spill_comphabcnt = 0, new_comphabcnt = 0, aug_comphabcnt = 0, main_comphabcnt = 0, spill_tarhabcnt = 0, new_tarhabcnt = 0, aug_tarhabcnt = 0, main_tarhabcnt = 0, spill_anihabcnt = 0, new_antihabcnt = 0, aug_antihabcnt = 0, main_antihabcnt = 0, bfive_habcnt = 0, bfive_comphabcnt = 0, bfive_antihabcnt = 0, bfive_tarhabcnt = 0, lbfive_habcnt = 0, lbfive_comphabcnt = 0, lbfive_antihabcnt = 0, lbfive_tarhabcnt = 0;
        int augnewcnt = 0, augspillcnt = 0,augspillAnticnt = 0,augspill_habcnt = 0, augnew_habcnt = 0,augspill_antihabcnt = 0, augnew_antihabcnt = 0,augnewAnticnt = 0,augspill_targethabcnt = 0, augnew_targethabcnt = 0,augspillTargetcnt = 0,augnewTargetcnt = 0;
        int  mainnewcnt = 0, mainspillcnt = 0,mainspillAnticnt = 0,mainspill_habcnt = 0, mainnew_habcnt = 0,mainspill_antihabcnt = 0, mainnew_antihabcnt = 0,mainnewAnticnt = 0,mainspill_targethabcnt = 0, mainnew_targethabcnt = 0,mainspillTargetcnt = 0,mainnewTargetcnt = 0;
        double augnew_amt = 0, augspill_amt = 0,augnew_antiamt = 0, augspill_antiamt = 0,augnew_targetamt = 0, augspill_targetamt = 0,augspill_exp = 0,augspill_antiexp = 0,augspill_targetexp = 0,augspill_compexp = 0;
        double mainnew_amt = 0, mainspill_amt = 0,mainspill_exp = 0,mainnew_antiamt = 0, mainspill_antiamt = 0,mainspill_antiexp = 0,mainnew_targetamt = 0,mainspill_targetexp = 0, mainspill_targetamt = 0;
        //int mainnewcnt = 0,mainspillcnt = 0,mainspill_habcnt = 0,mainnew_habcnt = 0;
       // double mainnew_amt = 0,mainspill_amt = 0;
        int gnewcnt = 0,gspillcnt = 0,gspill_habcnt = 0,gnew_habcnt = 0;
        double gnew_amt = 0,gspill_amt = 0;
        int lnewcnt = 0,lspillcnt = 0,lspill_habcnt = 0,lnew_habcnt = 0;
        double lnew_amt = 0,lspill_amt = 0,gspill_exp = 0;
       
        int augspillcompcnt = 0, augnewcompcnt = 0,augspill_comphabcnt = 0, augnew_comphabcnt = 0;
        double augspill_compamt = 0,augnew_compamt=0;
        int mainspillcompcnt = 0, mainnewcompcnt = 0,mainspill_comphabcnt = 0, mainnew_comphabcnt = 0;
        double mainspill_compamt = 0,mainspill_compexp = 0,mainnew_compamt=0;
        int gnew_tarhabcnt=0,gspill_tarhabcnt=0,gnew_antihabcnt=0,gspill_antihabcnt=0,gnew_comphabcnt=0,gspill_comphabcnt=0,gspillhabcnt=0,gnewhabcnt=0,gspillcompcnt=0,gnewcompcnt=0,gspillcomphabcnt=0,gnewcomphabcnt=0,gspillanticnt=0,gnewanticnt=0,gspillantihabcnt=0,gnewantihabcnt=0,gspilltarcnt=0,gnewtarcnt=0,gspilltarhabcnt=0,gnewtarhabcnt=0;
		double gnew_taramt=0,gspill_comexp =0, gspill_compamt=0,gspill_compexp=0,gspill_antiamt=0,gspill_antiexp=0,gspill_taramt=0,gspill_tarexp=0;
        double gnew_compamt=0,gnew_antiamt=0,lspill_exp=0,lspill_compamt=0,lspill_compexp =0,lnew_compamt=0,lspill_antiamt=0,lspill_antiexp=0,lnew_antiamt =0,lspill_taramt=0,lspill_tarexp=0,lnew_taramt =0,lspill_comexp =0;
        int lspillcompcnt=0,lspill_comphabcnt=0,lnewcompcnt=0,lnew_comphabcnt=0,lspillanticnt =0,lspill_antihabcnt=0,lnewanticnt=0,lnew_antihabcnt=0,lspilltarcnt=0,lspill_tarhabcnt=0,lnewtarcnt=0,lnew_tarhabcnt=0,lspillcomphabcnt =0,lnewcomphabcnt =0,lspillantihabcnt=0,lnewantihabcnt=0,lspilltarhabcnt=0,lnewtarhabcnt =0;
		//////////////pop varibales//////////////////////////////////
		String work_id="";
		int ppop=0,scpop=0,stpop=0,totpop=0;
		double plainper=0,scper=0,stper=0;
		////////////////////////////////////////////////
          String myids="",myids1="",myids2="",plainworks="",scworks="",stworks="",worksType="";
		double spill_direxp=0,spill_compdirexp=0,spill_antidirexp=0,spill_targetdirexp=0,augspill_direxp=0,augspill_compdirexp=0,augspill_antidirexp=0,augspill_targetdirexp=0;
		double mainspill_direxp=0,mainspill_compdirexp=0,mainspill_antidirexp=0,mainspill_targetdirexp=0;
		double gspill_direxp=0, gspill_compdirexp=0,gspill_antidirexp=0,gspill_targetdirexp=0;
		double lspill_direxp=0, lspill_compdirexp=0,lspill_antidirexp=0,lspill_tardirexp=0;
		String spillwrks="",spillcompwrks="",spillantiwrks="",spilltarwrks="";
		String newwrks="",newcompwrks="",newantiwrks="",newtarwrks="";
		
		String augwrks="",augcompwrks="",augantiwrks="",augtarwrks="";
		String augnewwrks="",augnewcompwrks="",augnewantiwrks="",augnewtarwrks="";
		
		String mainwrks="",maincompwrks="",mainantiwrks="",maintarwrks="";
		String mainnewwrks="",mainnewcompwrks="",mainnewantiwrks="",mainnewtarwrks="";
		
		String gwrks="",gcompwrks="",gantiwrks="",gtarwrks="";
		String gnewwrks="",gnewcompwrks="",gnewantiwrks="",gnewtarwrks="";
		
		String lwrks="",lcompwrks="",lantiwrks="",ltarwrks="";
		String lnewwrks="",lnewcompwrks="",lnewantiwrks="",lnewtarwrks="";
	
            try {

				stmt1 = conn.createStatement();

				int styleCount = 0, recCount = 0;
				String style = "", dname = "", prg_code = "";

			
		////////////////////////////////////////////Spill Works Population//////////////////////////////////////////////////////////////////////////////////////////		
				
			//System.out.println("my cont type ............" + ctype);
				
			    stmt2 = conn.createStatement();
				String PopQuery = "select distinct a.work_id,sum(census_plain_popu),sum(census_sc_popu),sum(census_st_popu),sum(census_plain_popu+census_sc_popu+census_st_popu) FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d   where a.work_id=b.work_id  and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null  "
						+ " and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl)";
				if (dcode != null && !dcode.equals("00")) {
					PopQuery += "and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					PopQuery += "and type_of_asset in(" + scheme + ")";
				}
				if (ctype != null && !ctype.equals("")) 
				{
					PopQuery += " and CONT_TYPE ='" + ctype + "' ";
				}
			
				PopQuery += " and  programme_code in (" + programe + ") group by a.work_id";
				
			//System.out.println("PopQuery ............" + PopQuery);
				rs2 = stmt2.executeQuery(PopQuery);
				
				while (rs2.next())
				{
					work_id=rs2.getString(1);
					ppop= rs2.getInt(2);
					scpop= rs2.getInt(3);
					stpop= rs2.getInt(4);
					totpop= rs2.getInt(5);
							
						
					if(ppop>0)
					{
						
						plainper=((double)ppop*100/totpop);
					}
					
					if(scpop>0)
					{
						
						scper=((double)scpop*100/totpop);
					}
					
					if(stpop>0)
					{
						
						stper=((double)stpop*100/totpop);
					}
					
					
					if(plainper>=40)
					{
						
						myids+=work_id+",";
						plainworks=myids.substring(0, myids.length() - 1);
					}
					 
					
				   if(scper>=40)
					{
						
						myids1+=work_id+",";
						scworks=myids1.substring(0, myids1.length() - 1);
					}
				
					
					 if(stper>=40)
					{
						
						myids2+=work_id+",";
						stworks=myids2.substring(0, myids2.length() - 1);
					}
					 
					else
					{
						continue;
					}
					
					
					 
				}

				//System.out.println("my ids"+plainworks);
				//System.out.println("my ids1"+scworks);
			   //System.out.println("my ids2"+stworks);
			//System.out.println("my ids1"+myids1);
			//System.out.println("my ids2"+myids2);
			
			
			
			if(myreptype != null && myreptype.equals("Plain") && !plainworks.equals(""))
			{
				worksType="PLAIN Works";
			}
			
			else if(myreptype != null && myreptype.equals("SC") && !scworks.equals(""))
			{
				worksType="SC Works";
			}
			
			
			else if(myreptype != null && myreptype.equals("ST") && !stworks.equals(""))
			{
				worksType="ST Works";
			}
			else if(myreptype != null && myreptype.equals("All"))
			{
				worksType="ALL Works";
			}
			
			else
          
			{
				worksType="No "+myreptype+" Works Instead Showing ALL Works";
			}
          
			
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();	
		String contname="";
		if(ctype.equals("all"))	{contname=" All "; }  else if(ctype.equals("01"))	{contname="Flouride"; } else if(ctype.equals("02"))	{contname="Brakish"; } else if(ctype.equals("03"))	{contname="Iron"; } else if(ctype.equals("04"))	{contname="Aresenic"; } else if(ctype.equals("05"))	{contname="Nitrate"; } 
				
			%>
		
		<table border=1 cellspacing=0 cellpadding=0 width="76%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" align="center">
		<tr>
			<td align="center" class="gridhdbg" colspan=18>AAP Report (QA Habs Related
				Schemes) for (<%=pname%>) <%=financialstartyr%> : [<%=distname%>] : [<%=worksType %>]  : [<%=contname%>] Contamination. 
			</td>
		</tr>
		<tr>
			<td class="gridhdbg" rowspan=2>Scheme/work Type</td>
			<td class="gridhdbg" colspan=3>Total Ongoing Works as on <br>
				1.4.<%=startyr%></td>
			<td class="gridhdbg" colspan=3>Completed during <br><%=financialstartyr%>
				so far
			</td>
			<td class="gridhdbg" colspan=3>Anticipated Completion during <br><%=financialstartyr%>
			</td>
			<td class="gridhdbg" colspan=3>Target (To be completed during <br><%=nxtfinancialstartyr%>)
			</td>
		</tr>
		<tr>
			<td class="gridhdbg">No.</td>
			<td class="gridhdbg">Est. Cost</td>
			<td class="gridhdbg">Habitations</td>
			<td class="gridhdbg">No.</td>
			<td class="gridhdbg">Est. Cost</td>
			<td class="gridhdbg">Habitations</td>
			<td class="gridhdbg">No.</td>
			<td class="gridhdbg">Est. Cost</td>
			<td class="gridhdbg">Habitations</td>
			<td class="gridhdbg">No.</td>
			<td class="gridhdbg">Est. Cost</td>
			<td class="gridhdbg">Habitations</td>

		</tr>
			
			
				
	<%/////////////////////////////////////////////////////ALL Works////////////////////////////////////////////////////////////////////////////////////////////////////////////////			
				
				//////////////////////// Spill ////////////////////////////////////////////////////
				stmt2 = conn.createStatement();
				String spillWorks = "select distinct a.work_id,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_Code=d.hab_code and  CONT_TYPE is not null and  to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "'  and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ startyr + "'))";
				if (dcode != null && !dcode.equals("00")) {
					spillWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					spillWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					spillWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					spillWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					spillWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					spillWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				spillWorks += " and  programme_code in (" + programe + ") group by a.work_id";
				
				//System.out.println("spillWorks ............" + spillWorks);

				rs2 = stmt2.executeQuery(spillWorks);
				
				while (rs2.next()) 
				{
					spillcnt += rs2.getInt(2);
					spillwrks+=rs2.getString(1)+",";
					//spill_amt += rs2.getDouble(2);

				}
				//System.out.println("my spill wrks"+spillwrks);
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
			
				if(spillwrks!=null && !spillwrks.equals(""))
				{
				stmt2 = conn.createStatement();
				String spillWorksSanAmt = "select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL where work_id in ("+spillwrks.substring(0, spillwrks.length() - 1)+")";	
				rs2 = stmt2.executeQuery(spillWorksSanAmt);
				//System.out.println("spillWorksSanAmt ............" + spillWorksSanAmt);

				while (rs2.next()) 
				{
					spill_amt += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();		
		
				

				stmt2 = conn.createStatement();
				String spillWorksExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where a.work_id=b.work_id and a.work_id in ("+spillwrks.substring(0, spillwrks.length() - 1)+")";
		
				rs2 = stmt2.executeQuery(spillWorksExp);
				//System.out.println("spillWorksExp ............" + spillWorksExp);
		
				while (rs2.next()) {
					spill_exp += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				stmt2 = conn.createStatement();
				String spillWorksDirExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b where a.work_id=b.work_id and a.work_id in ("+spillwrks.substring(0, spillwrks.length() - 1)+")";
		
				rs2 = stmt2.executeQuery(spillWorksDirExp);
				//System.out.println("spillWorksDirExp ............" + spillWorksDirExp);
		
				while (rs2.next()) {
					spill_direxp += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
		

	        	stmt2 = conn.createStatement();
				String spillHabs = "select count(distinct  b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and b.hab_code=c.panch_code  and b.hab_code=d.hab_Code and CONT_TYPE is not null and a.work_id in ("+spillwrks.substring(0, spillwrks.length() - 1)+") ";
				//System.out.println("spillHabs ............" + spillHabs);
				rs2 = stmt2.executeQuery(spillHabs);
				

				while (rs2.next())
				{
					spill_habcnt += rs2.getInt(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
				/////////////////////////////////////////////Spill Completed/////////////////////////////////////////////////
				stmt2 = conn.createStatement();
				String spillCompWorks = "select distinct a.work_id ,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,RWS_WORK_COMP_HAB_LNK_TBL c,rws_complete_hab_view d ,RWS_HAB_CONTAMINATION_TBL e  where a.work_id=b.work_id and a.work_id=c.work_id and c.hab_code=d.panch_code and c.hab_code=e.hab_code and CONT_TYPE is not null and to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and  a.work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
						+ startyr
						+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ endyr + "' ";
				if (dcode != null && !dcode.equals("00")) {
					spillCompWorks += " and substr(a.work_id,5,2)='" + dcode
							+ "'";
				}
				if (scheme != null && !scheme.equals("")) {
					spillCompWorks += " and type_of_asset in(" + scheme + ")";
				}
				
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					spillCompWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					spillCompWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					spillCompWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					spillCompWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				spillCompWorks += " and  programme_code in (" + programe + ") group by a.work_id";

				rs2 = stmt2.executeQuery(spillCompWorks);
				//System.out.println("spillCompWorks ............"+ spillCompWorks);
				while (rs2.next()) 
				{
					spillcompcnt += rs2.getInt(2);
					spillcompwrks+= rs2.getString(1)+",";
					//spill_compamt += rs2.getDouble(2);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				if(spillcompwrks!=null && !spillcompwrks.equals(""))
				{
				stmt2 = conn.createStatement();
				String spillCompWorksSanAmt = "select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a  where a.work_id in ("+spillcompwrks.substring(0, spillcompwrks.length() - 1)+")";
				rs2 = stmt2.executeQuery(spillCompWorksSanAmt);
				//System.out.println("spillCompWorksSanAmt ............" + spillCompWorksSanAmt);

				while (rs2.next()) {
					spill_compamt += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				stmt2 = conn.createStatement();
				String spillCompWorksExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id and   a.work_id in ("+spillcompwrks.substring(0, spillcompwrks.length() - 1)+")";
				rs2 = stmt2.executeQuery(spillCompWorksExp);
				//System.out.println("spillCompWorksExp ............" + spillCompWorksExp);

				while (rs2.next())
				{
					spill_compexp += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				stmt2 = conn.createStatement();
				String spillCompWorksDirExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b where a.work_id=b.work_id and   a.work_id in ("+spillcompwrks.substring(0, spillcompwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(spillCompWorksDirExp);
				//System.out.println("spillCompWorksDirExp ............" + spillCompWorksDirExp);

				while (rs2.next())
				{
					spill_compdirexp += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();

				stmt2 = conn.createStatement();
				String spillCompHabs = "select count(b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d   where a.work_id=b.work_id and  b.hab_code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null and  a.work_id in ("+spillcompwrks.substring(0, spillcompwrks.length() - 1)+") "; 
				rs2 = stmt2.executeQuery(spillCompHabs);
				//System.out.println("spillCompHabs ............" + spillCompHabs);

				while (rs2.next()) {
					spill_comphabcnt += rs2.getInt(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
				/////////////////////////////////////////Spill Anticipated///////////////////////////////////////////////////////
				stmt2 = conn.createStatement();
				String spillAntiWorks = "select distinct a.work_id,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a , rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null and to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' ";
				if (dcode != null && !dcode.equals("00")) {
					spillAntiWorks += "and substr(a.work_id,5,2)='" + dcode
							+ "'";
				}
				if (scheme != null && !scheme.equals("")) {
					spillAntiWorks += "and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					spillAntiWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					spillAntiWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					spillAntiWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					spillAntiWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				spillAntiWorks += " and  programme_code in (" + programe + ") group by a.work_id";

				rs2 = stmt2.executeQuery(spillAntiWorks);
				//System.out.println("spillAntiWorks ............"+ spillAntiWorks);

				while (rs2.next()) {
					spillanicnt += rs2.getInt(2);
					spillantiwrks+=rs2.getString(1)+",";
					//spill_aniamt += rs2.getDouble(2);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				if(spillantiwrks!=null && !spillantiwrks.equals(""))
				{
				stmt2 = conn.createStatement();
				String spillAntiWorksSanAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a   where  a.work_id in ("+spillantiwrks.substring(0, spillantiwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(spillAntiWorksSanAmt);
				//System.out.println("spillAntiWorksSanAmt ............" + spillAntiWorksSanAmt);

				while (rs2.next())
				{
					spill_aniamt += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				stmt2 = conn.createStatement();
				String spillAntiWorksExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and a.work_id in ("+spillantiwrks.substring(0, spillantiwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(spillAntiWorksExp);
				//System.out.println("spillAntiWorksExp ............" + spillAntiWorksExp);

				while (rs2.next())
				{
					spill_antiexp += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				stmt2 = conn.createStatement();
				String spillAntiWorksDirExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id and a.work_id in ("+spillantiwrks.substring(0, spillantiwrks.length() - 1)+") ";

				rs2 = stmt2.executeQuery(spillAntiWorksDirExp);
				//System.out.println("spillAntiWorksDirExp ............" + spillAntiWorksDirExp);

				while (rs2.next())
				{
					spill_antidirexp += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				

				stmt2 = conn.createStatement();
				String spillAntiHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL "
                        + " d  where a.work_id=b.work_id and  b.hab_code=c.panch_code and b.hab_Code=d.hab_code and CONT_TYPE is not null"
						+ " and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ startyr+ "-"	+ endyr+ "' and a.work_id in ("+spillantiwrks.substring(0, spillantiwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(spillAntiHabs);
				//System.out.println("spillAntiHabs ............" + spillAntiHabs);

				while (rs2.next())
				{
					spill_anihabcnt += rs2.getInt(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
				
//////////////////////////////////////////////Spill Targeted////////////////////////////////////////////////////////////////////////////
				stmt2 = conn.createStatement();
				String spillTargetWorks = "select distinct a.work_id ,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d  where "
						+ "a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_Code=d.hab_code  "
						+ " and CONT_TYPE is not null and to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ startyr + "')) and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' ";
				if (dcode != null && !dcode.equals("00")) {
					spillTargetWorks += "and substr(a.work_id,5,2)='" + dcode
							+ "'";
				}
				if (scheme != null && !scheme.equals("")) {
					spillTargetWorks += "and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					spillTargetWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					spillTargetWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					spillTargetWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					spillTargetWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				spillTargetWorks += " and  programme_code in (" + programe+ ") group by a.work_id";

				rs2 = stmt2.executeQuery(spillTargetWorks);
				//System.out.println("spillTargetWorks ............"	+ spillTargetWorks);

				while (rs2.next()) {
					spilltarcnt += rs2.getInt(2);
					spilltarwrks+=rs2.getString(1)+",";
					//spill_taramt += rs2.getDouble(2);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();

				if(spilltarwrks!=null && !spilltarwrks.equals(""))
				{
					stmt2 = conn.createStatement();
					String spillTarWorksSanAmt = "select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id and a.work_id in ("+spilltarwrks.substring(0, spilltarwrks.length() - 1)+") ";
					rs2 = stmt2.executeQuery(spillTarWorksSanAmt);
					//System.out.println("spillTarWorksSanAmt ............" + spillTarWorksSanAmt);
	
					while (rs2.next()) {
						spill_taramt += rs2.getDouble(1);
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
					
					
					
					stmt2 = conn.createStatement();
					String spillTarWorksExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id and a.work_id in ("+spilltarwrks.substring(0, spilltarwrks.length() - 1)+") ";
					rs2 = stmt2.executeQuery(spillTarWorksExp);
					//System.out.println("spillTarWorksExp ............" + spillTarWorksExp);
	
					while (rs2.next()) {
						spill_targetexp += rs2.getDouble(1);
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
					
					
					stmt2 = conn.createStatement();
					String spillTarWorksDirExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b  where a.work_id=b.work_id and a.work_id in ("+spilltarwrks.substring(0, spilltarwrks.length() - 1)+") ";
	     			rs2 = stmt2.executeQuery(spillTarWorksDirExp);
					//System.out.println("spillTarWorksDirExp ............" + spillTarWorksDirExp);
	
					while (rs2.next()) {
						spill_targetdirexp += rs2.getDouble(1);
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
					
						
					
					stmt2 = conn.createStatement();
					String spillTargetHabs = "select count(distinct b.hab_Code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_code=c.panch_code  and b.hab_code=d.hab_Code and CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and  AAP_TARGET_YEAR ='"+endyr+"-"+nextyr+"' and a.work_id in ("+spilltarwrks.substring(0, spilltarwrks.length() - 1)+") ";
					rs2 = stmt2.executeQuery(spillTargetHabs);
					//System.out.println("spillTargetHabs ............"						+ spillTargetHabs);
	
					while (rs2.next()) {
						spill_tarhabcnt += rs2.getInt(1);
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
				}
			

					%>
		<tr>
			<td class="gridbg1" style="text-align: left;">Spill</td>
			<td class="gridbg1" style="text-align: right;"><%=spillcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format(spill_amt-(spill_exp+spill_direxp))%></td>
			<td class="gridbg1" style="text-align: right;"><%=spill_habcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=spillcompcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format(spill_compamt-(spill_compexp+spill_compdirexp))%></td>
			<td class="gridbg1" style="text-align: right;"><%=spill_comphabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=spillanicnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format(spill_aniamt-(spill_antiexp+spill_antidirexp))%></td>
			<td class="gridbg1" style="text-align: right;"><%=spill_anihabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=spilltarcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format(spill_taramt-(spill_targetexp+spill_targetdirexp))%></td>
			<td class="gridbg1" style="text-align: right;"><%=spill_tarhabcnt%></td>

		</tr>
		
<%


  /////////////////////////////////////////////////////New Works/////////////////////////////////////////////////////////////////////////////////////////

                stmt2 = conn.createStatement();
				String newWorks = "select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,RWS_HAB_CONTAMINATION_TBL c ,rws_complete_hab_view d where a.work_id=b.work_id and b.hab_Code=d.panch_Code and b.hab_code=c.hab_code and CONT_TYPE is not null and to_date(ADMIN_DATE) >='01-Apr-"
						+ startyr
						+ "' and to_date(ADMIN_DATE) <'01-Apr-"
						+ endyr + "' and work_cancel_dt is null";
				if (dcode != null && !dcode.equals("00")) {
					newWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					newWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					newWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					newWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					newWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					newWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				newWorks += " and  programme_code in (" + programe + ")  group by a.work_id";

				rs2 = stmt2.executeQuery(newWorks);
				//System.out.println("newWorks ............" + newWorks);

				while (rs2.next()) {
					newcnt += rs2.getInt(2);
					newwrks+=rs2.getString(1)+",";
					//new_amt += rs2.getDouble(2);
				}

				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();

				if(newwrks!=null && !newwrks.equals(""))
				{
				stmt2 = conn.createStatement();
				String newWorksAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+newwrks.substring(0, newwrks.length() - 1)+")";
				//System.out.println("newWorksAmt ............" + newWorksAmt);
				rs2 = stmt2.executeQuery(newWorksAmt);
				

				while (rs2.next())
				{
					new_amt += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				stmt2 = conn.createStatement();
				String newHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id  and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null and a.work_id in ("+newwrks.substring(0, newwrks.length() - 1)+")";
				//System.out.println("newHabs ............" + newHabs);
				rs2 = stmt2.executeQuery(newHabs);
				

				while (rs2.next())
				{
					new_habcnt += rs2.getInt(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
//////////////////////////////////////////////New Completed///////////////////////////////////////////////////////////
				stmt2 = conn.createStatement();
				String newCompWorks = "select distinct a.work_id,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b , RWS_WORK_COMP_HAB_LNK_TBL c ,rws_complete_hab_view d ,RWS_HAB_CONTAMINATION_TBL e  where a.work_id=b.work_id  and a.work_id=c.work_id and c.hab_code=d.panch_code and c.hab_code=e.hab_code and CONT_TYPE is not null and to_date(a.ADMIN_DATE) >='01-Apr-"
						+ startyr
						+ "' and to_date(a.ADMIN_DATE) <'01-Apr-"
						+ endyr
						+ "' and work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
						+ startyr
						+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ endyr + "'";
				if (dcode != null && !dcode.equals("00")) {
					newCompWorks += " and substr(a.work_id,5,2)='" + dcode
							+ "'";
				}
				if (scheme != null && !scheme.equals("")) {
					newCompWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					newCompWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					newCompWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					newCompWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					newCompWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				newCompWorks += " and  programme_code in (" + programe + ") group by a.work_id ";

				rs2 = stmt2.executeQuery(newCompWorks);
				//System.out.println("newCompWorks ............" + newCompWorks);

				while (rs2.next()) {
					newcompcnt += rs2.getInt(2);
					newcompwrks+=rs2.getString(1)+",";
					//new_compamt += rs2.getDouble(2);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				if(newcompwrks!=null && !newcompwrks.equals(""))
				{
				stmt2 = conn.createStatement();
				String newCompWrksAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL  where  work_id in ("+newcompwrks.substring(0, newcompwrks.length() - 1)+")";
				//System.out.println("newCompWrksAmt ............" + newCompWrksAmt);
				rs2 = stmt2.executeQuery(newCompWrksAmt);
				

				while (rs2.next()) {
					new_compamt += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();

				stmt2 = conn.createStatement();
				String newCompHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c,rws_complete_hab_view d,RWS_HAB_CONTAMINATION_TBL e  where a.work_id=b.work_id and a.work_id=c.work_id and b.hab_code=d.panch_code and b.hab_Code=e.hab_code and CONT_TYPE is not null  and a.work_id in ("+newcompwrks.substring(0, newcompwrks.length() - 1)+")";
				//System.out.println("newCompHabs ............" + newCompHabs);
				rs2 = stmt2.executeQuery(newCompHabs);
				

				while (rs2.next()) {
					new_comphabcnt += rs2.getInt(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
				////////////////////////////////////New Anticipated Works////////////////////////////////////////////////////
				
				stmt2 = conn.createStatement();
				String newAntiWorks = "select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where   a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null and to_date(ADMIN_DATE) >='01-Apr-"
						+ startyr
						+ "' and to_date(ADMIN_DATE) <'01-Apr-"
						+ endyr + "' and work_cancel_dt is null  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' ";
				if (dcode != null && !dcode.equals("00")) {
					newAntiWorks += " and substr(a.work_id,5,2)='" + dcode
							+ "'";
				}
				if (scheme != null && !scheme.equals("")) {
					newAntiWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					newAntiWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					newAntiWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					newAntiWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					newAntiWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				newAntiWorks += " and  programme_code in (" + programe + ") group by a.work_id ";
				//System.out.println("newAntiWorks ............" + newAntiWorks);
				rs2 = stmt2.executeQuery(newAntiWorks);
				

				while (rs2.next()) {
					newanticnt += rs2.getInt(2);
					newantiwrks+=rs2.getString(1)+",";
					//new_antiamt += rs2.getDouble(2);
				}

				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				if(newantiwrks!=null && !newantiwrks.equals(""))
				{
				stmt2 = conn.createStatement();
				String newAntiWorksAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+newantiwrks.substring(0, newantiwrks.length() - 1)+")";
				//System.out.println("newAntiWorksAmt ............" + newAntiWorksAmt);
				rs2 = stmt2.executeQuery(newAntiWorksAmt);
				

				while (rs2.next()) {
					new_antiamt += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				stmt2 = conn.createStatement();
				String newAntiHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where  a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null  and a.work_id in ("+newantiwrks.substring(0, newantiwrks.length() - 1)+")" 
						+ " and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ startyr+ "-"+ endyr + "' ";
						//System.out.println("newAntiHabs ............" + newAntiHabs);
				rs2 = stmt2.executeQuery(newAntiHabs);
				

				while (rs2.next()) {
					new_antihabcnt += rs2.getInt(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
				/////////////////////////////////////////////////New Targeted Works//////////////////////////////////////////////////////////////////////////////
				
				stmt2 = conn.createStatement();
				String newTargetWorks = "select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_Complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d where  "
						+ " a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null and to_date(ADMIN_DATE) >='01-Apr-"
						+ startyr
						+ "' and to_date(ADMIN_DATE) <'01-Apr-"
						+ endyr
						+ "' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' ";
				if (dcode != null && !dcode.equals("00")) {
					newTargetWorks += " and substr(a.work_id,5,2)='" + dcode+ "'";
				}
				if (scheme != null && !scheme.equals("")) {
					newTargetWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					newTargetWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					newTargetWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					newTargetWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					newTargetWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				newTargetWorks += " and  programme_code in (" + programe + ") group by a.work_id";
				//System.out.println("newTargetWorks ............"						+ newTargetWorks);
				rs2 = stmt2.executeQuery(newTargetWorks);
				

				while (rs2.next()) {
					newtarcnt += rs2.getInt(2);
					newtarwrks+=rs2.getString(1)+",";
					//new_taramt += rs2.getDouble(2);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				if(newtarwrks!=null && !newtarwrks.equals(""))
				{
				stmt2 = conn.createStatement();
				String newTargetWorksSanAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+newtarwrks.substring(0, newtarwrks.length() - 1)+")";
				//System.out.println("newTargetWorksSanAmt ............"						+ newTargetWorksSanAmt);
				rs2 = stmt2.executeQuery(newTargetWorksSanAmt);
				

				while (rs2.next()) {
					new_taramt += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				

				stmt2 = conn.createStatement();
				String newTargetHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_Code=d.hab_Code and CONT_TYPE is not null and   AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"
						+ endyr
						+ "-"
						+ nextyr + "' and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' and    a.work_id in ("+newtarwrks.substring(0, newtarwrks.length() - 1)+")";
						//System.out						.println("newTargetHabs ............" + newTargetHabs);

				rs2 = stmt2.executeQuery(newTargetHabs);
				
				while (rs2.next()) {
					new_tarhabcnt += rs2.getInt(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();

				}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

%>

      <tr>
			<td class="gridbg1" style="text-align: left;">New</td>
			<td class="gridbg1" style="text-align: right;"><%=newcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format(new_amt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=new_habcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=newcompcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format(new_compamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=new_comphabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=newanticnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format(new_antiamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=new_antihabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=newtarcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format(new_taramt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=new_tarhabcnt%></td>


		</tr>
		<tr>
			<td class="gridhdbg" style="text-align: right;">Total</td>
			<td class="gridhdbg" style="text-align: right;"><%=spillcnt + newcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((spill_amt-(spill_exp+spill_direxp)) + new_amt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=spill_habcnt + new_habcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=spillcompcnt + newcompcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((spill_compamt-(spill_compexp+spill_compdirexp)) + new_compamt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=spill_comphabcnt + new_comphabcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=spillanicnt + newanticnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((spill_aniamt-(spill_antiexp+spill_antidirexp)) + new_antiamt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=spill_anihabcnt + new_antihabcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=spilltarcnt + newtarcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((spill_taramt-(spill_targetexp+spill_targetdirexp)) + new_taramt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=spill_tarhabcnt + new_tarhabcnt%></td>


		</tr>
		

<%

////////////////////////////////////////////////Augmentation Works////////////////////////////////////////////////////////////////////////////////


				
				stmt2 = conn.createStatement();
				String augspillWorks = "select distinct a.work_id ,count(distinct a.work_id),aug_new_code  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null  and to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ startyr + "'))";
				if (dcode != null && !dcode.equals("00")) {
					augspillWorks += "and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					augspillWorks += "and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					augspillWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					augspillWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					augspillWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					augspillWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				augspillWorks += " and  programme_code in (" + programe + ") group by a.work_id,aug_new_code";

				rs2 = stmt2.executeQuery(augspillWorks);
				//System.out.println("augspillWorks ............" + augspillWorks);
				while (rs2.next())
				{   if(rs2.getInt(3)==2)
					{
						augspillcnt += rs2.getInt(2);
						//augspill_amt += rs2.getDouble(2);
						augwrks+=rs2.getString(1)+",";
					}
					else
					{
						mainspillcnt += rs2.getInt(2);
						//mainspill_amt += rs2.getDouble(2);
						mainwrks+=rs2.getString(1)+",";
					}

				}
				//System.out.println("augwrks ............" + augwrks);
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				if(augwrks!=null && !augwrks.equals("") )
				{
					stmt2 = conn.createStatement();
					String augspillWorksAmt = "select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+augwrks.substring(0, augwrks.length() - 1)+")";
					//System.out.println("augspillWorksAmt ............" + augspillWorksAmt);
	     			rs2 = stmt2.executeQuery(augspillWorksAmt);
	     			while (rs2.next())
					{ 
						augspill_amt += rs2.getDouble(1);
					  
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
					
					stmt2 = conn.createStatement();
					String augspillWorksExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id and  a.work_id in ("+augwrks.substring(0, augwrks.length() - 1)+")";
					//System.out.println("augspillWorksExp ............" + augspillWorksExp);
					rs2 = stmt2.executeQuery(augspillWorksExp);
				    
	
					while (rs2.next())
					{ 
						augspill_exp += rs2.getDouble(1);
					  
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
					
					
	
					stmt2 = conn.createStatement();
					String augspillWorksDirExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b  where a.work_id=b.work_id and  a.work_id in ("+augwrks.substring(0, augwrks.length() - 1)+")";
					//System.out.println("augspillWorksDirExp ............" + augspillWorksDirExp);
					rs2 = stmt2.executeQuery(augspillWorksDirExp);
				
	
					while (rs2.next())
					{ 
						augspill_direxp += rs2.getDouble(1);
					  
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
					
					stmt2 = conn.createStatement();
					String augspillHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d   where a.work_id=b.work_id and  b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null and a.work_id in ("+augwrks.substring(0, augwrks.length() - 1)+") ";
					rs2 = stmt2.executeQuery(augspillHabs);
				    //System.out.println("augspillHabs ............" + augspillHabs);
	
					while (rs2.next()) {
						
						augspill_habcnt += rs2.getInt(1);
						
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
					
				
				}
				
				if(mainwrks!=null && !mainwrks.equals("") )
				{
				stmt2 = conn.createStatement();
				String mainspillWorksAmt = "select sum(sanction_amount)   FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+mainwrks.substring(0, mainwrks.length() - 1)+")";
     			rs2 = stmt2.executeQuery(mainspillWorksAmt);
			    //System.out.println("mainspillWorksAmt ............" + mainspillWorksAmt);

				while (rs2.next())
				{ 
					mainspill_amt += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
					
				
				
				
				
				stmt2 = conn.createStatement();
				String mainspillWorksExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id and  a.work_id in ("+mainwrks.substring(0, mainwrks.length() - 1)+")";
     			rs2 = stmt2.executeQuery(mainspillWorksExp);
			   //System.out.println("mainspillWorksExp ............" + mainspillWorksExp);

				while (rs2.next())
				{ 
						mainspill_exp += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				
				stmt2 = conn.createStatement();
				String mainspillWorksDirExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b  where a.work_id=b.work_id and  a.work_id in ("+mainwrks.substring(0, mainwrks.length() - 1)+")";
     			rs2 = stmt2.executeQuery(mainspillWorksDirExp);
			   //System.out.println("mainspillWorksDirExp ............" + mainspillWorksDirExp);

				while (rs2.next())
				{ 
						mainspill_direxp += rs2.getDouble(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				
				stmt2 = conn.createStatement();
				String mainspillHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d   where a.work_id=b.work_id and  b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null and a.work_id in ("+mainwrks.substring(0, mainwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(mainspillHabs);
			   //System.out.println("mainspillHabs ............" + mainspillHabs);

				while (rs2.next()) {
					
						mainspill_habcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				
				
				}
				
			/////////////////////////////
				
				stmt2 = conn.createStatement();
				String augnewWorks = "select distinct a.work_id,count(distinct a.work_id),aug_new_code  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_code=d.hab_code and  CONT_TYPE is not null and to_date(ADMIN_DATE) >='01-Apr-"
						+ startyr
						+ "' and to_date(ADMIN_DATE) <'01-Apr-"
						+ endyr + "' and work_cancel_dt is null";
				if (dcode != null && !dcode.equals("00")) {
					augnewWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					augnewWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					augnewWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					augnewWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					augnewWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					augnewWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				augnewWorks += " and  programme_code in (" + programe + ") group by a.work_id,aug_new_code  ";

				rs2 = stmt2.executeQuery(augnewWorks);
			   //System.out.println("augnewWorks ............" + augnewWorks);

				while (rs2.next())
				{   if(rs2.getInt(3)==2)
					{
						augnewcnt += rs2.getInt(2);
						augnewwrks+=rs2.getString(1)+",";
						//augnew_amt += rs2.getDouble(2);
					}
				else
				{
					
						mainnewcnt += rs2.getInt(2);
						mainnewwrks+=rs2.getString(1)+",";
						//mainnew_amt += rs2.getDouble(2);
					
				}
				}

				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				if(augnewwrks!=null && !augnewwrks.equals("") )
				{
				
					
					stmt2 = conn.createStatement();
					String augnewWorksAmt = "select sum(sanction_amount)   FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+augnewwrks.substring(0, augnewwrks.length() - 1)+")";
	     			rs2 = stmt2.executeQuery(augnewWorksAmt);
				   //System.out.println("augnewWorksAmt ............" + augnewWorksAmt);

					while (rs2.next())
					{ 
						augnew_amt += rs2.getDouble(1);
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
						
					
				stmt2 = conn.createStatement();
				String augnewHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_Code=d.hab_Code and CONT_TYPE is not null  and a.work_id in ("+augnewwrks.substring(0, augnewwrks.length() - 1)+") ";

				rs2 = stmt2.executeQuery(augnewHabs);
			  //System.out.println("augnewHabs ............" + augnewHabs);

				while (rs2.next()) {
					
					augnew_habcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
				
				
				if(mainnewwrks!=null && !mainnewwrks.equals("") )
				{
					
					
					stmt2 = conn.createStatement();
					String mainnewWorksAmt = "select sum(sanction_amount)   FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+mainnewwrks.substring(0, mainnewwrks.length() - 1)+")";
	     			rs2 = stmt2.executeQuery(mainnewWorksAmt);
				   //System.out.println("mainnewWorksAmt ............" + mainnewWorksAmt);

					while (rs2.next())
					{ 
						mainnew_amt += rs2.getDouble(1);
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();	
					
					
					
				
				stmt2 = conn.createStatement();
				String mainnewHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_Code=d.hab_Code and CONT_TYPE is not null  and a.work_id in ("+mainnewwrks.substring(0, mainnewwrks.length() - 1)+") ";

				rs2 = stmt2.executeQuery(mainnewHabs);
			   //System.out.println("mainnewHabs ............" + mainnewHabs);

				while (rs2.next()) {
					
						mainnew_habcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				}
				/////////////////Agumentaion completion Works////////////////////////////
				
				
				
				stmt2 = conn.createStatement();
				String augspillCompWorks = "select distinct a.work_id,count(distinct a.work_id),aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c, rws_complete_hab_view  d , RWS_HAB_CONTAMINATION_TBL e  where a.work_id=b.work_id  and a.work_id=c.work_id and c.hab_Code=d.panch_code and c.hab_code=e.hab_code and CONT_TYPE is not null and to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and  a.work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
						+ startyr
						+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ endyr + "' ";
				if (dcode != null && !dcode.equals("00")) {
					augspillCompWorks += " and substr(a.work_id,5,2)='" + dcode
							+ "'";
				}
				if (scheme != null && !scheme.equals("")) {
					augspillCompWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					augspillCompWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					augspillCompWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					augspillCompWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					augspillCompWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				augspillCompWorks += " and  programme_code in (" + programe + ") group by a.work_id, aug_new_code ";

				rs2 = stmt2.executeQuery(augspillCompWorks);
			   //System.out.println("augspillCompWorks ............"						+ augspillCompWorks);
				while (rs2.next()) {
					if(rs2.getInt(3)==2)
					{
					augspillcompcnt += rs2.getInt(2);
					augcompwrks+=rs2.getString(1)+",";
				//	augspill_compamt += rs2.getDouble(2);
					}
					else
					{
						mainspillcompcnt += rs2.getInt(2);
						maincompwrks+=rs2.getString(1)+",";
					//	mainspill_compamt += rs2.getDouble(2);
					}
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();

				if(augcompwrks!=null && !augcompwrks.equals("") )
				{
				stmt2 = conn.createStatement();
				String augspillCompWorksAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+augcompwrks.substring(0, augcompwrks.length() - 1)+")";
				rs2 = stmt2.executeQuery(augspillCompWorksAmt);
			    //System.out.println("augspillCompWorksAmt ............" + augspillCompWorksAmt);

				while (rs2.next()) 
				{
					augspill_compamt += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				stmt2 = conn.createStatement();
				String augspillCompWorksExp = "select sum(voucher_Amt)/100000 FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id  and  a.work_id in ("+augcompwrks.substring(0, augcompwrks.length() - 1)+")";
				rs2 = stmt2.executeQuery(augspillCompWorksExp);
			   //System.out.println("augspillCompWorksExp ............" + augspillCompWorksExp);

				while (rs2.next()) 
				{
					augspill_compexp += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				
				stmt2 = conn.createStatement();
				String augspillCompWorksDirExp = "select sum(voucher_Amt)/100000 FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b  where a.work_id=b.work_id  and  a.work_id in ("+augcompwrks.substring(0, augcompwrks.length() - 1)+")";
				rs2 = stmt2.executeQuery(augspillCompWorksDirExp);
			   //System.out						.println("augspillCompWorksDirExp ............" + augspillCompWorksDirExp);

				while (rs2.next()) 
				{
					augspill_compdirexp += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				stmt2 = conn.createStatement();
				String augspillCompHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c,rws_complete_hab_View d ,RWS_HAB_CONTAMINATION_TBL e  where a.work_id=b.work_id  and a.work_id=c.work_id and b.hab_code=d.panch_code and b.hab_code=e.hab_code and CONT_TYPE is not null and  a.work_id in ("+augcompwrks.substring(0, augcompwrks.length() - 1)+")";
				rs2 = stmt2.executeQuery(augspillCompHabs);
			   //System.out.println("augspillCompHabs ............" +augspillCompHabs);

				while (rs2.next()) {
					
					augspill_comphabcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				}
				if(maincompwrks!=null && !maincompwrks.equals("") )
				{
				stmt2 = conn.createStatement();
				String mainspillCompWorksAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+maincompwrks.substring(0, maincompwrks.length() - 1)+")";
				rs2 = stmt2.executeQuery(mainspillCompWorksAmt);
			//System.out						.println("mainspillCompWorksAmt ............" + mainspillCompWorksAmt);

				while (rs2.next())
				{
					mainspill_compamt += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				/////////////
				
				
				
				stmt2 = conn.createStatement();
				String mainspillCompWorksExp = "select sum(voucher_Amt)/100000 FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id  and a.work_id in ("+maincompwrks.substring(0, maincompwrks.length() - 1)+")";
				rs2 = stmt2.executeQuery(mainspillCompWorksExp);
			//System.out						.println("mainspillCompWorksExp ............" + mainspillCompWorksExp);

				while (rs2.next())
				{
					mainspill_compexp += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
	/////////////
				
					
					
					stmt2 = conn.createStatement();
					String mainspillCompWorksDirExp = "select sum(voucher_Amt)/100000 FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b  where a.work_id=b.work_id  and a.work_id in ("+maincompwrks.substring(0, maincompwrks.length() - 1)+")";
					rs2 = stmt2.executeQuery(mainspillCompWorksDirExp);
				   //System.out						.println("mainspillCompWorksDirExp ............" + mainspillCompWorksDirExp);

					while (rs2.next())
					{
						mainspill_compdirexp += rs2.getDouble(1);
						
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
					
				
				
				
				stmt2 = conn.createStatement();
				String mainspillCompHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c,rws_complete_hab_View d ,RWS_HAB_CONTAMINATION_TBL e  where a.work_id=b.work_id  and a.work_id=c.work_id and b.hab_code=d.panch_code and b.hab_code=e.hab_code and CONT_TYPE is not null and  a.work_id in ("+maincompwrks.substring(0, maincompwrks.length() - 1)+")";
				rs2 = stmt2.executeQuery(mainspillCompHabs);
			   //System.out.println("mainspillCompHabs ............" +mainspillCompHabs);

				while (rs2.next()) {
					
						mainspill_comphabcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
				
				stmt2 = conn.createStatement();
				String augnewCompWorks = "select distinct a.work_id,count(distinct a.work_id) ,aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b , RWS_WORK_COMP_HAB_LNK_TBL  c ,rws_complete_hab_View d ,RWS_HAB_CONTAMINATION_TBL  e where a.work_id=b.work_id and a.work_id=c.work_id and c.hab_Code=d.panch_code and c.hab_code=e.hab_Code and CONT_TYPE is not null and to_date(a.ADMIN_DATE) >= '01-Apr-"
						+ startyr
						+ "' and  a.work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
						+ startyr
						+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ endyr + "' ";
				if (dcode != null && !dcode.equals("00")) {
					augnewCompWorks += " and substr(a.work_id,5,2)='" + dcode
							+ "'";
				}
				if (scheme != null && !scheme.equals("")) {
					augnewCompWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					augnewCompWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					augnewCompWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					augnewCompWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					augnewCompWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				augnewCompWorks += " and  programme_code in (" + programe + ") group by a.work_id,aug_new_code";

				rs2 = stmt2.executeQuery(augnewCompWorks);
			//System.out.println("augnewCompWorks ............"						+ augnewCompWorks);
				while (rs2.next()) {
					if(rs2.getInt(3)==2)
					{
					augnewcompcnt += rs2.getInt(2);
					augnewwrks+=rs2.getString(1)+",";
					//augnew_compamt += rs2.getDouble(2);
					}
					else
					{
						mainnewcompcnt += rs2.getInt(2);
						mainnewwrks+=rs2.getString(1)+",";
					    //mainnew_compamt += rs2.getDouble(2);
						
					}
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
					
				
				if(augnewwrks!=null && !augnewwrks.equals("") )
				{
				
				stmt2 = conn.createStatement();
				String augnewCompAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL where work_id in ("+augnewwrks.substring(0, augnewwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(augnewCompAmt);
			//System.out						.println("augnewCompAmt ............" +augnewCompAmt);

				while (rs2.next()) {
					
					augnew_compamt += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				stmt2 = conn.createStatement();
				String augnewCompHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c , rws_complete_hab_View d , RWS_HAB_CONTAMINATION_TBL e  where a.work_id=b.work_id  and a.work_id=c.work_id and b.hab_Code=d.panch_Code and b.hab_code=e.hab_code and CONT_TYPE is not null and  a.work_id in ("+augnewwrks.substring(0, augnewwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(augnewCompHabs);
			//System.out						.println("augnewCompHabs ............" +augnewCompHabs);

				while (rs2.next()) {
					
						augnew_comphabcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
				if(mainnewwrks!=null && !mainnewwrks.equals("") )
				{
				stmt2 = conn.createStatement();
				String mainnewCompAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL where  work_id in ("+mainnewwrks.substring(0, mainnewwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(mainnewCompAmt);
			   //System.out.println("mainnewCompAmt ............" +mainnewCompAmt);

				while (rs2.next()) {
					
					mainnew_compamt += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();

				
				
				
				stmt2 = conn.createStatement();
				String mainnewCompHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c , rws_complete_hab_View d , RWS_HAB_CONTAMINATION_TBL e  where a.work_id=b.work_id  and a.work_id=c.work_id and b.hab_Code=d.panch_Code and b.hab_code=e.hab_code and CONT_TYPE is not null and  a.work_id in ("+mainnewwrks.substring(0, mainnewwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(mainnewCompHabs);
			//System.out						.println("mainnewCompHabs ............" +mainnewCompHabs);

				while (rs2.next()) {
					
						mainnew_comphabcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();

				}
//////////////////////////////////////////////////Augumentation Anticipated Works///////////////////////////////////////////////////////////////////////////////////////




                stmt2 = conn.createStatement(); 
				String augspillAntiWorks = "select distinct a.work_id,count(distinct a.work_id),aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_Complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where  a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_Code=d.hab_Code and CONT_TYPE is not null   and to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ startyr + "')) and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' ";
				if (dcode != null && !dcode.equals("00")) {
					augspillAntiWorks += "and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					augspillAntiWorks += "and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					augspillAntiWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					augspillAntiWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					augspillAntiWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					augspillAntiWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				augspillAntiWorks += " and  programme_code in (" + programe + ") group by a.work_id,aug_new_code";

				rs2 = stmt2.executeQuery(augspillAntiWorks);
			   //System.out.println("augspillAntiWorks ............" + augspillAntiWorks);
				while (rs2.next()) {
					if(rs2.getInt(3)==2)
					{
					augspillAnticnt += rs2.getInt(2);
					augantiwrks+=rs2.getString(1)+",";
					//augspill_antiamt += rs2.getDouble(2);
					}
					else
					{
						mainspillAnticnt += rs2.getInt(2);
						mainantiwrks+=rs2.getString(1)+",";
						//mainspill_antiamt += rs2.getDouble(2);
					}

				}

				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				//////////////////
				if(augantiwrks!=null && !augantiwrks.equals("") )
				{
				stmt2 = conn.createStatement();
				String augspillAntiWorksAmt= "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a  where  a.work_id in ("+augantiwrks.substring(0, augantiwrks.length() - 1)+") ";

				rs2 = stmt2.executeQuery(augspillAntiWorksAmt);
			   //System.out.println("augspillAntiWorksAmt ............" + augspillAntiWorksAmt);

				while (rs2.next()) {
					
					augspill_antiamt += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				stmt2 = conn.createStatement();
				String augspillAntiWorksExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where a.work_id=b.work_id and a.work_id in ("+augantiwrks.substring(0, augantiwrks.length() - 1)+") ";

				rs2 = stmt2.executeQuery(augspillAntiWorksExp);
			  //System.out.println("augspillAntiWorksExp ............" + augspillAntiWorksExp);

				while (rs2.next()) {
					
					augspill_antiexp += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				stmt2 = conn.createStatement();
				String augspillAntiWorksDirExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b where a.work_id=b.work_id and a.work_id in ("+augantiwrks.substring(0, augantiwrks.length() - 1)+") ";

				rs2 = stmt2.executeQuery(augspillAntiWorksDirExp);
			   //System.out.println("augspillAntiWorksDirExp ............" + augspillAntiWorksDirExp);

				while (rs2.next()) {
					
					augspill_antidirexp += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				
				stmt2 = conn.createStatement();
				String augspillAntiHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and  b.hab_code=c.panch_code and b.hab_code=d.hab_code and  CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ startyr+ "-"	+ endyr+ "' and  a.work_id in ("+augantiwrks.substring(0, augantiwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(augspillAntiHabs);
			   //System.out.println("augspillAntiHabs ............" + augspillAntiHabs);

				while (rs2.next()) {
					
					augspill_antihabcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				}
				
				if(mainantiwrks!=null && !mainantiwrks.equals("") )
				{
				stmt2 = conn.createStatement();
				String mainspillAntiWorksAmt= "select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+mainantiwrks.substring(0, mainantiwrks.length() - 1)+") ";

				rs2 = stmt2.executeQuery(mainspillAntiWorksAmt);
			  //System.out.println("mainspillAntiWorksAmt ............" + mainspillAntiWorksAmt);

				while (rs2.next()) {
					
					mainspill_antiamt += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
							
				
				
				
				
				stmt2 = conn.createStatement();
				String mainspillAntiWorksExp = "select sum(voucher_Amt)/100000 FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where a.work_id=b.work_id and a.work_id in ("+mainantiwrks.substring(0, mainantiwrks.length() - 1)+") ";

				rs2 = stmt2.executeQuery(mainspillAntiWorksExp);
			  //System.out.println("mainspillAntiWorksExp ............" + mainspillAntiWorksExp);

				while (rs2.next()) {
					
						mainspill_antiexp += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				
				
				stmt2 = conn.createStatement();
				String mainspillAntiWorksDirExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b where a.work_id=b.work_id and a.work_id in ("+mainantiwrks.substring(0, mainantiwrks.length() - 1)+") ";

				rs2 = stmt2.executeQuery(mainspillAntiWorksDirExp);
			   //System.out.println("mainspillAntiWorksDirExp ............" + mainspillAntiWorksDirExp);

				while (rs2.next()) {
					
						mainspill_antidirexp += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				stmt2 = conn.createStatement();
				String mainspillAntiHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and  b.hab_code=c.panch_code and b.hab_code=d.hab_code and  CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ startyr+ "-"	+ endyr+ "' and  a.work_id in ("+mainantiwrks.substring(0, mainantiwrks.length() - 1)+") ";
				rs2 = stmt2.executeQuery(mainspillAntiHabs);
			   //System.out.println("mainspillAntiHabs ............" + mainspillAntiHabs);

				while (rs2.next()) {
					
						mainspill_antihabcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				
				
				}
				
			//////////////////////////////////
				stmt2 = conn.createStatement();
				String augnewAntiWorks = "select distinct a.work_id,count(distinct a.work_id),aug_new_code  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_Code=d.hab_Code and  CONT_TYPE is not null and to_date(ADMIN_DATE) >='01-Apr-"
						+ startyr
						+ "' and to_date(ADMIN_DATE) <'01-Apr-"
						+ endyr + "' and work_cancel_dt is null  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' ";
				if (dcode != null && !dcode.equals("00")) {
					augnewAntiWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					augnewAntiWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					augnewAntiWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					augnewAntiWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					augnewAntiWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					augnewAntiWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				augnewAntiWorks += " and  programme_code in (" + programe + ") group by a.work_id,aug_new_code ";

				rs2 = stmt2.executeQuery(augnewAntiWorks);
			   //System.out.println("augnewAntiWorks ............" +augnewAntiWorks);

				while (rs2.next()) {
					if(rs2.getInt(3)==2)
					{
					  augnewAnticnt += rs2.getInt(2);
					  augnewantiwrks+=rs2.getString(1)+",";
					  //augnew_antiamt += rs2.getDouble(2);
					}
					else
					{
						mainnewAnticnt += rs2.getInt(2);
						mainnewantiwrks+=rs2.getString(1)+",";
						//mainnew_antiamt += rs2.getDouble(2);
					}
				}

				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				/////////////
				if(augnewantiwrks!=null && !augnewantiwrks.equals("") )
				{
				stmt2 = conn.createStatement();
				String augnewAntiWorksAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+augnewantiwrks.substring(0, augnewantiwrks.length() - 1)+") ";
				//System.out.println("augnewAntiWorksAmt ............" + augnewAntiWorksAmt);
				rs2 = stmt2.executeQuery(augnewAntiWorksAmt);
			  

				while (rs2.next()) {
					
					augnew_antiamt += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				
				stmt2 = conn.createStatement();
				String augnewAntiHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ startyr+ "-"	+ endyr+ "' and  a.work_id in ("+augnewantiwrks.substring(0, augnewantiwrks.length() - 1)+")";
				//System.out.println("augnewAntiHabs ............" + augnewAntiHabs);
				rs2 = stmt2.executeQuery(augnewAntiHabs);
			   

				while (rs2.next()) {
					
					augnew_antihabcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				}
				if(mainnewantiwrks!=null && !mainnewantiwrks.equals("") )
				{
				stmt2 = conn.createStatement();
				String mainnewAntiWorksAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+mainnewantiwrks.substring(0, mainnewantiwrks.length() - 1)+") ";
				//System.out.println("mainnewAntiWorksAmt ............" + mainnewAntiWorksAmt);
				rs2 = stmt2.executeQuery(mainnewAntiWorksAmt);
			   

				while (rs2.next()) {
					
					mainnew_antiamt += rs2.getDouble(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				stmt2 = conn.createStatement();
				String mainnewAntiHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ startyr+ "-"	+ endyr+ "' and  a.work_id in ("+mainnewantiwrks.substring(0, mainnewantiwrks.length() - 1)+")";
				//System.out.println("mainnewAntiHabs ............" + mainnewAntiHabs);
				rs2 = stmt2.executeQuery(mainnewAntiHabs);
			    

				while (rs2.next()) {
					
						mainnew_antihabcnt += rs2.getInt(1);
					
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
//////////////////////////////////////////////////Augumentation Targeted Works///////////////////////////////////////////////////////////////////////////////////////




stmt2 = conn.createStatement();
String augspillTargetWorks = "select distinct a.work_id,count(distinct a.work_id),aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null and   to_date(a.ADMIN_DATE) < '01-Apr-"
+ startyr
+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
+ startyr + "')) and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' ";
if (dcode != null && !dcode.equals("00")) {
augspillTargetWorks += "and substr(a.work_id,5,2)='" + dcode + "'";
}
if (scheme != null && !scheme.equals("")) {
augspillTargetWorks += "and type_of_asset in(" + scheme + ")";
}
if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
{
	augspillTargetWorks += " and a.work_id in(" + plainworks + ")";
	
}
if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
{    
	augspillTargetWorks += " and a.work_id in(" + scworks + ")";
}
if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
{    
	augspillTargetWorks += " and a.work_id in(" + stworks + ")";
}
if (ctype != null && !ctype.equals("all")) 
{
	augspillTargetWorks += "and CONT_TYPE ='" + ctype + "' ";
}
augspillTargetWorks += " and  programme_code in (" + programe + ") group by a.work_id, aug_new_code";
//System.out.println("augspillTargetWorks ............" + augspillTargetWorks);
rs2 = stmt2.executeQuery(augspillTargetWorks);

while (rs2.next()) {
	if(rs2.getInt(3)==2)
	{
		augspillTargetcnt += rs2.getInt(2);
		augtarwrks+=rs2.getString(1)+",";
//augspill_targetamt += rs2.getDouble(2);
	}
	else
	{
		mainspillTargetcnt += rs2.getInt(2);
		maintarwrks+=rs2.getString(1)+",";
		//mainspill_targetamt += rs2.getDouble(2);
	}

}

if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();

if(augtarwrks!=null && !augtarwrks.equals("") )
{

stmt2 = conn.createStatement();
String augspillTarWorksAmt = "select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+augtarwrks.substring(0, augtarwrks.length() - 1)+")";
//System.out.println("augspillTarWorksAmt ............" + augspillTarWorksAmt);
rs2 = stmt2.executeQuery(augspillTarWorksAmt);


while (rs2.next()) {
	
	augspill_targetamt += rs2.getDouble(1);
	
}
if (rs2 != null)
	rs2.close();
if (stmt2 != null)
	stmt2.close();


stmt2 = conn.createStatement();
String augspillTarWorksExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where a.work_id=b.work_id and  a.work_id in ("+augtarwrks.substring(0, augtarwrks.length() - 1)+")";
//System.out.println("augspillTarWorksExp ............" + augspillTarWorksExp);
rs2 = stmt2.executeQuery(augspillTarWorksExp);


while (rs2.next()) {
	
	augspill_targetexp += rs2.getDouble(1);
	
}
if (rs2 != null)
	rs2.close();
if (stmt2 != null)
	stmt2.close();

stmt2 = conn.createStatement();
String augspillTarWorksDirExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b where a.work_id=b.work_id and   a.work_id in ("+augtarwrks.substring(0, augtarwrks.length() - 1)+")";
//System.out.println("augspillTarWorksDirExp ............" + augspillTarWorksDirExp);
rs2 = stmt2.executeQuery(augspillTarWorksDirExp);


while (rs2.next()) {
	
	augspill_targetdirexp += rs2.getDouble(1);
	
}
if (rs2 != null)
	rs2.close();
if (stmt2 != null)
	stmt2.close();

stmt2 = conn.createStatement();
String augspillTargetHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d   where a.work_id=b.work_id and  b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ endyr+ "-"	+ nextyr+ "' and  a.work_id in ("+augtarwrks.substring(0, augtarwrks.length() - 1)+")";
//System.out.println("augspillTargetHabs ............" + augspillTargetHabs);

rs2 = stmt2.executeQuery(augspillTargetHabs);


while (rs2.next()) {
	
		augspill_targethabcnt += rs2.getInt(1);
	

}
if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();





}

if(maintarwrks!=null && !maintarwrks.equals("") )
{

stmt2 = conn.createStatement();
String mainspillTarWorksAmt = "select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+maintarwrks.substring(0, maintarwrks.length() - 1)+")";
//System.out.println("mainspillTarWorksAmt ............" + mainspillTarWorksAmt);
rs2 = stmt2.executeQuery(mainspillTarWorksAmt);


while (rs2.next()) {
	
	mainspill_targetamt += rs2.getDouble(1);
	
}
if (rs2 != null)
	rs2.close();
if (stmt2 != null)
	stmt2.close();





stmt2 = conn.createStatement();
String mainspillTarWorksExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where a.work_id=b.work_id and  a.work_id in ("+maintarwrks.substring(0, maintarwrks.length() - 1)+")";
//System.out.println("mainspillTarWorksExp ............" + mainspillTarWorksExp);
rs2 = stmt2.executeQuery(mainspillTarWorksExp);


while (rs2.next()) {
	
		mainspill_targetexp += rs2.getDouble(1);
	
}
if (rs2 != null)
	rs2.close();
if (stmt2 != null)
	stmt2.close();




stmt2 = conn.createStatement();
String mainspillTarWorksDirExp = "select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b where a.work_id=b.work_id and  a.work_id in ("+maintarwrks.substring(0, maintarwrks.length() - 1)+")";
//System.out.println("mainspillTarWorksDirExp ............" + mainspillTarWorksDirExp);
rs2 = stmt2.executeQuery(mainspillTarWorksDirExp);


while (rs2.next()) {
	
		mainspill_targetdirexp += rs2.getDouble(1);
	
}
if (rs2 != null)
	rs2.close();
if (stmt2 != null)
	stmt2.close();

stmt2 = conn.createStatement();
String mainspillTargetHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d   where a.work_id=b.work_id and  b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ endyr+ "-"	+ nextyr+ "' and  a.work_id in ("+maintarwrks.substring(0, maintarwrks.length() - 1)+")";
//System.out.println("mainspillTargetHabs ............" + mainspillTargetHabs);

rs2 = stmt2.executeQuery(mainspillTargetHabs);


while (rs2.next()) {
	
		mainspill_targethabcnt += rs2.getInt(1);
	

}
if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();

}


stmt2 = conn.createStatement();
String augnewTargetWorks = "select distinct a.work_id,count(distinct a.work_id),aug_new_code  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and  CONT_TYPE is not null   and to_date(ADMIN_DATE) >='01-Apr-"
+ startyr
+ "' and to_date(ADMIN_DATE) <'01-Apr-"
+ endyr + "' and work_cancel_dt is null  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' ";
if (dcode != null && !dcode.equals("00")) {
augnewTargetWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
}
if (scheme != null && !scheme.equals("")) {
augnewTargetWorks += " and type_of_asset in(" + scheme + ")";
}
if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
{
	augnewTargetWorks += " and a.work_id in(" + plainworks + ")";
	
}
if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
{    
	augnewTargetWorks += " and a.work_id in(" + scworks + ")";
}
if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
{    
	augnewTargetWorks += " and a.work_id in(" + stworks + ")";
}
if (ctype != null && !ctype.equals("all")) 
{
	augnewTargetWorks += "and CONT_TYPE ='" + ctype + "' ";
}
augnewTargetWorks += " and  programme_code in (" + programe + ") group by a.work_id,aug_new_code  ";
//System.out.println("augnewTargetWorks ............" +augnewTargetWorks);
rs2 = stmt2.executeQuery(augnewTargetWorks);


while (rs2.next()) {
	if(rs2.getInt(3)==2)
	{
augnewTargetcnt += rs2.getInt(2);
augnewtarwrks+=rs2.getString(1)+",";
//augnew_targetamt += rs2.getDouble(2);
	}
	else
	{
		mainnewTargetcnt += rs2.getInt(2);
		mainnewtarwrks+=rs2.getString(1)+",";
	//mainnew_targetamt += rs2.getDouble(2);
		
	}
}

if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();


if(augnewtarwrks!=null && !augnewtarwrks.equals("") )
{
stmt2 = conn.createStatement();
String augnewTargetAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+augnewtarwrks.substring(0, augnewtarwrks.length() - 1)+")";

//System.out.println("augnewTargetAmt ............" + augnewTargetAmt);
rs2 = stmt2.executeQuery(augnewTargetAmt);


while (rs2.next()) {
	
	augnew_targetamt += rs2.getDouble(1);
	

}
if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();




stmt2 = conn.createStatement();
String augnewTargetHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_code=d.hab_code and  CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' and AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ endyr+ "-"	+ nextyr+ "' and  a.work_id in ("+augnewtarwrks.substring(0, augnewtarwrks.length() - 1)+")";
//System.out.println("augnewTargetHabs ............" + augnewTargetHabs);
rs2 = stmt2.executeQuery(augnewTargetHabs);


while (rs2.next()) {
	
		augnew_targethabcnt += rs2.getInt(1);
	
}
if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();
}

if(mainnewtarwrks!=null && !mainnewtarwrks.equals("") )
{
stmt2 = conn.createStatement();
String mainnewTargetAmt = "select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+mainnewtarwrks.substring(0, mainnewtarwrks.length() - 1)+")";
//System.out.println("mainnewTargetAmt ............" + mainnewTargetAmt);

rs2 = stmt2.executeQuery(mainnewTargetAmt);


while (rs2.next()) {
	
	mainnew_targetamt += rs2.getDouble(1);
	

}
if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();






stmt2 = conn.createStatement();
String mainnewTargetHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_code=d.hab_code and  CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ endyr+ "-"	+ nextyr+ "' and  a.work_id in ("+mainnewtarwrks.substring(0, mainnewtarwrks.length() - 1)+")";
//System.out.println("mainnewTargetHabs ............" + mainnewTargetHabs);
rs2 = stmt2.executeQuery(mainnewTargetHabs);


while (rs2.next()) {
	
			mainnew_targethabcnt += rs2.getInt(1);
	
}
if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



%>

  <tr>
			<td class="gridbg1" style="text-align: left;">Augmentation</td>
			<td class="gridbg1" style="text-align: right;"><%=augspillcnt+augnewcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((augspill_amt-(augspill_exp+augspill_direxp))+augnew_amt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=augspill_habcnt+augnew_habcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=augspillcompcnt+augnewcompcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((augspill_compamt-(augspill_compexp+augspill_compdirexp))+augnew_compamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=augspill_comphabcnt+augnew_comphabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=augspillAnticnt+augnewAnticnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((augspill_antiamt-(augspill_antiexp+augspill_antidirexp))+augnew_antiamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=augspill_antihabcnt+augnew_antihabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=augspillTargetcnt+augnewTargetcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((augspill_targetamt-(augspill_targetexp+augspill_targetdirexp))+augnew_targetamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=augspill_targethabcnt+augnew_targethabcnt%></td>
			

		</tr>


   <tr>
			<td class="gridbg1" style="text-align: left;">Main</td>
			<td class="gridbg1" style="text-align: right;"><%=mainspillcnt+mainnewcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((mainspill_amt-(mainspill_exp+mainspill_direxp))+mainnew_amt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=mainspill_habcnt+mainnew_habcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=mainspillcompcnt+mainnewcompcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((mainspill_compamt-(mainspill_compexp+mainspill_compdirexp))+mainnew_compamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=mainspill_comphabcnt+mainnew_comphabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=mainspillAnticnt+mainnewAnticnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((mainspill_antiamt-(mainspill_antiexp+mainspill_antidirexp))+mainnew_antiamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=mainspill_antihabcnt+mainnew_antihabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=mainspillTargetcnt+mainnewTargetcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((mainspill_targetamt-(mainspill_targetexp+mainspill_targetdirexp))+mainnew_targetamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=mainspill_targethabcnt+mainnew_targethabcnt%></td>
			

		</tr>


<tr>
			<td class="gridhdbg" style="text-align: right;">Total</td>
			<td class="gridhdbg" style="text-align: right;"><%=augspillcnt+augnewcnt+mainspillcnt+mainnewcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((augspill_amt-(augspill_exp+augspill_direxp)) +augnew_amt+(mainspill_amt-(mainspill_exp+mainspill_direxp))+mainnew_amt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=augspill_habcnt+augnew_habcnt+mainspill_habcnt+mainnew_habcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=augspillcompcnt+augnewcompcnt +mainspillcompcnt+mainnewcompcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((augspill_compamt-(augspill_compexp+augspill_compdirexp))+augnew_compamt+(mainspill_compamt-(mainspill_compexp+mainspill_compdirexp))+mainnew_compamt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=augspill_comphabcnt+augnew_comphabcnt+mainspill_comphabcnt+mainnew_comphabcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=augspillAnticnt+augnewAnticnt+mainspillAnticnt+mainnewAnticnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((augspill_antiamt-(augspill_antiexp+augspill_antidirexp))+augnew_antiamt+(mainspill_antiamt-(mainspill_antiexp+mainspill_antidirexp))+mainnew_antiamt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=augspill_antihabcnt+augnew_antihabcnt+mainspill_antihabcnt+mainnew_antihabcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=augspillTargetcnt+augnewTargetcnt+mainspillTargetcnt+mainnewTargetcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((augspill_targetamt-(augspill_targetexp+augspill_targetdirexp))+augnew_targetamt+(mainspill_targetamt-(mainspill_targetexp+mainspill_targetdirexp))+mainnew_targetamt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=augspill_targethabcnt+augnew_targethabcnt+mainspill_targethabcnt+mainnew_targethabcnt%></td>

		</tr>

<%
////////////////////////////////////////////to be cointneued

//////////////////////////////////////////////////////////////Sanction greater than 5 yrs///////////////////////////////////////////////////////////////////////////////////////////////////

				stmt2 = conn.createStatement();
				String gspillWorks = "select distinct a.work_id,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null and   to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ startyr + "'))   and (sysdate -  a.admin_date>5*365 ) ";
				if (dcode != null && !dcode.equals("00")) {
					gspillWorks += "and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					gspillWorks += "and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					gspillWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					gspillWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					gspillWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					gspillWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				gspillWorks += " and  programme_code in (" + programe + ") group by a.work_id";

				rs2 = stmt2.executeQuery(gspillWorks);
			   //System.out.println("gspillWorks ............" + gspillWorks);
				while (rs2.next())
				{
					gspillcnt += rs2.getInt(2);
					gwrks+=rs2.getString(1)+",";
					//gspill_amt += rs2.getDouble(2);

				}

				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				if(gwrks!=null && !gwrks.equals(""))
				{
					  stmt2=conn.createStatement();
					  String gspillWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL  where work_id in  ("+gwrks.substring(0, gwrks.length() - 1)+")";
					 //System.out.println("gspillWorksAmt ............"+gspillWorksAmt);
					  rs2=stmt2.executeQuery(gspillWorksAmt);
					 
					  	
					  	while(rs2.next())
					  	{
					  		gspill_amt += rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
					
					  stmt2=conn.createStatement();
					  String gspillWorksExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id  and a.work_id in  ("+gwrks.substring(0, gwrks.length() - 1)+")";
					 //System.out.println("gspillWorksExp ............"+gspillWorksExp);
					  rs2=stmt2.executeQuery(gspillWorksExp);
					 
					  	
					  	while(rs2.next())
					  	{
					  		gspill_exp+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
					  	
					  	
					  	  stmt2=conn.createStatement();
						  String gspillWorksDirExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b  where a.work_id=b.work_id  and a.work_id in  ("+gwrks.substring(0, gwrks.length() - 1)+")";
						 //System.out.println("gspillWorksDirExp ............"+gspillWorksDirExp);
						  rs2=stmt2.executeQuery(gspillWorksDirExp);
						 
						  	
						  	while(rs2.next())
						  	{
						  		gspill_direxp+=rs2.getDouble(1);
						  	}
						  	if(rs2!=null)rs2.close();
						  	if(stmt2!=null)stmt2.close();
				
				  	
					  	stmt2 = conn.createStatement();
						String gspillHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c , RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and  b.hab_code=c.panch_code and b.hab_Code=d.hab_code and  CONT_TYPE is not null and a.work_id in  ("+gwrks.substring(0, gwrks.length() - 1)+")";
						//System.out.println("gspillHabs ............" +gspillHabs);
						rs2 = stmt2.executeQuery(gspillHabs);
					   

						while (rs2.next()) {
							gspill_habcnt += rs2.getInt(1);
						}
						if (rs2 != null)
							rs2.close();
						if (stmt2 != null)
							stmt2.close();	  	
					  	
				} 	
					  	
					  	
					  	
				
				stmt2 = conn.createStatement();
				String gnewWorks = "select distinct a.work_id,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a , rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_Code=d.hab_Code and CONT_TYPE is not null and to_date(ADMIN_DATE) >='01-Apr-"
						+ startyr
						+ "' and to_date(ADMIN_DATE) <'01-Apr-"
						+ endyr + "' and work_cancel_dt is null  and (sysdate -  a.admin_date>5*365 )";
				if (dcode != null && !dcode.equals("00")) {
					gnewWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					gnewWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					gnewWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					gnewWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					gnewWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					gnewWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				gnewWorks += " and  programme_code in (" + programe + ") group by a.work_id";
				//System.out.println("gnewWorks ............" + gnewWorks);
				rs2 = stmt2.executeQuery(gnewWorks);
			

				while (rs2.next()) {
					gnewcnt += rs2.getInt(2);
					gnewwrks+=rs2.getString(1)+",";
					//gnew_amt += rs2.getDouble(2);
				}

				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				
				if(gnewwrks!=null && !gnewwrks.equals(""))
				{
					
					
					stmt2 = conn.createStatement();
					String gnewWorksAmt = "selectsum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where  a.work_id in  ("+gnewwrks.substring(0, gnewwrks.length() - 1)+")";
					//System.out.println("gnewWorksAmt ............" + gnewWorksAmt);
					rs2 = stmt2.executeQuery(gnewWorksAmt);
				    

					while (rs2.next()) {
						gnew_amt += rs2.getDouble(1);
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
					
					stmt2 = conn.createStatement();
					String gnewHabs = "select count(distinct b.hab_code)  FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where  a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null  and a.work_id in  ("+gnewwrks.substring(0, gnewwrks.length() - 1)+")";
					//System.out.println("gnewHabs ............" + gnewHabs);
					rs2 = stmt2.executeQuery(gnewHabs);
				   
	
					while (rs2.next()) {
						gnew_habcnt += rs2.getInt(1);
					}
					if (rs2 != null)
						rs2.close();
					if (stmt2 != null)
						stmt2.close();
				
				}
	
//////////////////////////////////////////////////////////>5yrs completed works//////////////////////////////////////////////////////////////////////////////////////////////////////

                stmt2=conn.createStatement();
				String gspillcompWorks="select distinct a.work_id,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a  ,rws_work_completion_tbl b ,RWS_WORK_COMP_HAB_LNK_TBL  c ,rws_complete_hab_View d ,RWS_HAB_CONTAMINATION_TBL  e where  a.work_id=b.work_id and a.work_id=c.work_id and c.hab_Code=d.panch_code and c.hab_code=e.hab_Code and CONT_TYPE is not null and to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and work_cancel_dt is null  and (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' )and (sysdate -  admin_date>5*365 ) ";
				if(dcode!=null && !dcode.equals("00"))
				{
					gspillcompWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					gspillcompWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					gspillcompWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					gspillcompWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					gspillcompWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					gspillcompWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				gspillcompWorks+=" and  programme_code in ("+programe+") group by a.work_id"; 
				//System.out.println("gspillcompWorks ............"+gspillcompWorks);
				rs2=stmt2.executeQuery(gspillcompWorks);
			   
				
				while(rs2.next())
				{
					gspillcompcnt+=rs2.getInt(2);
					gcompwrks+=rs2.getString(1)+",";
					//gspill_compamt+=rs2.getDouble(2);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				if(gcompwrks!=null && !gcompwrks.equals(""))
				{
				
					
					stmt2=conn.createStatement();
					  String gspillCompAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a  where  a.work_id in  ("+gcompwrks.substring(0, gcompwrks.length() - 1)+")";
					 //System.out.println("gspillCompAmt ............"+gspillCompAmt); 
					  rs2=stmt2.executeQuery(gspillCompAmt);
					  
					  	
					  	while(rs2.next())
					  	{
					  		gspill_compamt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close();
				
				  stmt2=conn.createStatement();
				  String gspillCompExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id  and a.work_id in  ("+gcompwrks.substring(0, gcompwrks.length() - 1)+")";
				 //System.out.println("gspillCompExp ............"+gspillCompExp);
				  rs2=stmt2.executeQuery(gspillCompExp);
				   
				  	
				  	while(rs2.next())
				  	{
				  		gspill_compexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();
				
				  	stmt2=conn.createStatement();
					  String gspillCompDirExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b  where a.work_id=b.work_id  and a.work_id in  ("+gcompwrks.substring(0, gcompwrks.length() - 1)+")";
					 //System.out.println("gspillCompDirExp ............"+gspillCompDirExp);
					  rs2=stmt2.executeQuery(gspillCompDirExp);
					   
					  	
					  	while(rs2.next())
					  	{
					  		gspill_compdirexp+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close();
				  	
				  	
				  	
				stmt2=conn.createStatement();
				String gspillcomphabs="select count(distinct c.hab_code)  FROM RWS_WORK_ADMN_TBL a  ,rws_work_completion_tbl b ,RWS_WORK_COMP_HAB_LNK_TBL c ,rws_complete_hab_view d ,RWS_HAB_CONTAMINATION_TBL f where  a.work_id=b.work_id and a.work_id=c.work_id and c.hab_Code=d.panch_code and c.hab_code=f.hab_Code and  CONT_TYPE is not null  and a.work_id in  ("+gcompwrks.substring(0, gcompwrks.length() - 1)+") "; 
				//System.out.println("gspillcomphabs ............"+gspillcomphabs);
				rs2=stmt2.executeQuery(gspillcomphabs);
			    
				
				while(rs2.next())
				{
					gspill_comphabcnt+=rs2.getInt(1);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				}
				
				stmt2=conn.createStatement();
			
			    String gnewcompWorks="select distinct a.work_id , count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c ,rws_complete_hab_view d ,RWS_HAB_CONTAMINATION_TBL f  where a.work_id=b.work_id and a.work_id=c.work_id and c.hab_code=d.panch_code and c.hab_Code=f.hab_Code and  CONT_TYPE is not null and to_date(a.ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(a.ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' and (sysdate -  admin_date>5*365 )";
					
				if(dcode!=null && !dcode.equals("00"))
				{
					gnewcompWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					gnewcompWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					gnewcompWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					gnewcompWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					gnewcompWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					gnewcompWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				gnewcompWorks+=" and  programme_code in ("+programe+") group by a.work_id"; 
				
				//System.out.println("gnewcompWorks ............"+gnewcompWorks);
				rs2=stmt2.executeQuery(gnewcompWorks);
			   
				
				while(rs2.next())
				{
					gnewcompcnt+=rs2.getInt(2);
					gnewcompwrks+=rs2.getString(1)+",";
					//gnew_compamt+=rs2.getDouble(2);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				
				
				if(gnewcompwrks!=null && !gnewcompwrks.equals(""))
				{
					
					
					stmt2=conn.createStatement();
					String gnewCompWorksAmt="select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where a.work_id in  ("+gnewcompwrks.substring(0, gnewcompwrks.length() - 1)+") "; 
					//System.out.println("gnewCompWorksAmt ............"+gnewCompWorksAmt);
					  	rs2=stmt2.executeQuery(gnewCompWorksAmt);
					   
					  	
					  	while(rs2.next())
					  	{
					  		gnew_compamt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close();  
			  	
				
				stmt2=conn.createStatement();
				String gnewCompHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c,rws_complete_hab_view d ,RWS_HAB_CONTAMINATION_TBL f  where a.work_id=b.work_id and a.work_id=c.work_id and b.hab_code=d.panch_code and b.hab_Code=f.hab_code and CONT_TYPE is not null  and a.work_id in  ("+gnewcompwrks.substring(0, gnewcompwrks.length() - 1)+") "; 
				//System.out.println("gnewCompHabs ............"+gnewCompHabs);
				  	rs2=stmt2.executeQuery(gnewCompHabs);
				    
				  	
				  	while(rs2.next())
				  	{
				  		gnew_comphabcnt+=rs2.getInt(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();  
				}
		  		
		////////////////////////////////////////////>5yrs Anticipated Works////////////////////////////////////////////////////////////		
				
			    stmt2=conn.createStatement();
				String gspillantiWorks="select distinct a.work_id,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d  where  a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null and  work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"'  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date>5*365 )  ";
				if(dcode!=null && !dcode.equals("00"))
				{
					gspillantiWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					gspillantiWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					gspillantiWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					gspillantiWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					gspillantiWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					gspillantiWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				gspillantiWorks+=" and  programme_code in ("+programe+") group by a.work_id"; 
				//System.out.println("gspillantiWorks ............"+gspillantiWorks);
				rs2=stmt2.executeQuery(gspillantiWorks);
			
				
				while(rs2.next())
				{
					gspillanticnt+=rs2.getInt(2);
					gantiwrks+=rs2.getString(1)+",";
					//gspill_antiamt+=rs2.getDouble(2);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				if(gantiwrks!=null && !gantiwrks.equals(""))
				{
					stmt2=conn.createStatement();
					  String gspillAntiWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where a.work_id in  ("+gantiwrks.substring(0, gantiwrks.length() - 1)+") ";
					 //System.out.println("gspillAntiWorksAmt ............"+gspillAntiWorksAmt);
					  	rs2=stmt2.executeQuery(gspillAntiWorksAmt);
					   
					  	
					  	while(rs2.next())
					  	{
					  		gspill_antiamt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close();
					
			
				  stmt2=conn.createStatement();
				  String gspillAntiExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id  and a.work_id in  ("+gantiwrks.substring(0, gantiwrks.length() - 1)+") ";
				 //System.out.println("gspillAntiExp ............"+gspillAntiExp);
				  	rs2=stmt2.executeQuery(gspillAntiExp);
				    
				  	
				  	while(rs2.next())
				  	{
				  		gspill_antiexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close(); 

				  	
				  	
				  	stmt2=conn.createStatement();
					  String gspillAntiDirExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b where a.work_id=b.work_id  and a.work_id in  ("+gantiwrks.substring(0, gantiwrks.length() - 1)+") ";
					 //System.out.println("gspillAntiDirExp ............"+gspillAntiDirExp);
					  	rs2=stmt2.executeQuery(gspillAntiDirExp);
					    
					  	
					  	while(rs2.next())
					  	{
					  		gspill_antidirexp+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 

				
				
				stmt2=conn.createStatement(); 
				String gspillantihabs="select count(distinct b.hab_code)  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where  a.work_id=b.work_id and b.hab_code=c.panch_Code and b.hab_Code=d.hab_code and  CONT_TYPE is not null  and   to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+startyr+"-"+endyr+"' and a.work_id in  ("+gantiwrks.substring(0, gantiwrks.length() - 1)+") ";
				//System.out.println("gspillantihabs ............"+gspillantihabs);
				rs2=stmt2.executeQuery(gspillantihabs);
			    
				
				while(rs2.next())
				{
					gspill_antihabcnt+=rs2.getInt(1);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 	
				}
				
		
				stmt2=conn.createStatement();
				String gnewAntiWorks="select distinct a.work_id,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c , RWS_HAB_CONTAMINATION_TBL d   where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_Code=d.hab_Code and CONT_TYPE is not null and to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date>5*365 )   ";
				if(dcode!=null && !dcode.equals("00"))
				{
					gnewAntiWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					gnewAntiWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					gnewAntiWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					gnewAntiWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					gnewAntiWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					gnewAntiWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				gnewAntiWorks+=" and  programme_code in ("+programe+") group by a.work_id "; 
				//System.out.println("gnewAntiWorks ............"+gnewAntiWorks);
				rs2=stmt2.executeQuery(gnewAntiWorks);
			   
				
				while(rs2.next())
				{
					gnewanticnt+=rs2.getInt(2);
					gnewantiwrks+=rs2.getString(1)+",";
					//gnew_antiamt+=rs2.getDouble(2);
				}
				
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				if(gnewantiwrks!=null && !gnewantiwrks.equals(""))
				{
					
					stmt2=conn.createStatement();
					  String gnewantiWorksAmt="select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where  a.work_id in  ("+gnewantiwrks.substring(0, gnewantiwrks.length() - 1)+") ";
					 //System.out.println("gnewantiWorksAmt ............"+gnewantiWorksAmt);
					  	rs2=stmt2.executeQuery(gnewantiWorksAmt);
					    
					  	
					  	while(rs2.next())
					  	{
					  		gnew_antiamt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
					  	
				  stmt2=conn.createStatement();
				  String gnewantiHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "'  and AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+startyr+"-"+endyr+"'  and a.work_id in  ("+gnewantiwrks.substring(0, gnewantiwrks.length() - 1)+") ";
				 //System.out.println("gnewantiHabs ............"+gnewantiHabs);
				  	rs2=stmt2.executeQuery(gnewantiHabs);
				   
				  	
				  	while(rs2.next())
				  	{
				  		gnew_antihabcnt+=rs2.getInt(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();   
				  				
				}
				
		//////////////////////////////////////////////////////>5yrs Targeted Works///////////////////////////////////////////////////////////////////////////////////////////////////////		
				
		        stmt2=conn.createStatement();
				String gspillTargetWorks="select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a  ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d where  a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null and  work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"'  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date>5*365 ) ";
				if(dcode!=null && !dcode.equals("00"))
				{
					gspillTargetWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					gspillTargetWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					gspillTargetWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					gspillTargetWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					gspillTargetWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					gspillTargetWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				gspillTargetWorks+=" and  programme_code in ("+programe+") group by a.work_id"; 
				//System.out.println("gspillTargetWorks ............"+gspillTargetWorks);
				rs2=stmt2.executeQuery(gspillTargetWorks);
			
				
				while(rs2.next())
				{
					gspilltarcnt+=rs2.getInt(2);
					gtarwrks+=rs2.getString(1)+",";
					//gspill_taramt+=rs2.getDouble(2);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				
				if(gtarwrks!=null && !gtarwrks.equals(""))
				{
										
					stmt2=conn.createStatement();
					  String gspillTargetWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where  a.work_id in  ("+gtarwrks.substring(0, gtarwrks.length() - 1)+")"; 
					 //System.out.println("gspillTargetWorksAmt ............"+gspillTargetWorksAmt);
					  	rs2=stmt2.executeQuery(gspillTargetWorksAmt);
					    
					  	
					  	while(rs2.next())
					  	{
					  		gspill_taramt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
					  	
					  	
					  	
				  stmt2=conn.createStatement();
				  String gspillTargetExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id and a.work_id in  ("+gtarwrks.substring(0, gtarwrks.length() - 1)+")"; 
				 //System.out.println("gspillTargetExp ............"+gspillTargetExp);
				  	rs2=stmt2.executeQuery(gspillTargetExp);
				    
				  	
				  	while(rs2.next())
				  	{
				  		gspill_tarexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close(); 
				
				  	stmt2=conn.createStatement();
					  String gspillTargetDirExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b where a.work_id=b.work_id  and a.work_id in  ("+gtarwrks.substring(0, gtarwrks.length() - 1)+")"; 
					 //System.out.println("gspillTargetDirExp ............"+gspillTargetDirExp);
					  	rs2=stmt2.executeQuery(gspillTargetDirExp);
					   
					  	
					  	while(rs2.next())
					  	{
					  		gspill_targetdirexp+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
				  	
				  	
				  	
				  	
				stmt2=conn.createStatement();
				String gspillTargethabs="select count(distinct b.hab_Code) FROM RWS_WORK_ADMN_TBL a  ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d where  a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_Code=d.hab_Code and CONT_TYPE is not null  and AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+endyr+"-"+nextyr+"'  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and a.work_id in  ("+gtarwrks.substring(0, gtarwrks.length() - 1)+")" ;
				//System.out.println("gspillTargethabs ............"+gspillTargethabs);
				rs2=stmt2.executeQuery(gspillTargethabs);
			   
				
				while(rs2.next())
				{
					gspill_tarhabcnt+=rs2.getInt(1);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
				}
						
				
				stmt2=conn.createStatement();
				String gnewTargetWorks="select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c , RWS_HAB_CONTAMINATION_TBL d   where a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_code=d.hab_code and  CONT_TYPE is not null  and to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date>5*365 )";
				if(dcode!=null && !dcode.equals("00"))
				{
					gnewTargetWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					gnewTargetWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					gnewTargetWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					gnewTargetWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					gnewTargetWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					gnewTargetWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				gnewTargetWorks+=" and  programme_code in ("+programe+") group by a.work_id"; 
				//System.out.println("gnewTargetWorks ............"+gnewTargetWorks);
				rs2=stmt2.executeQuery(gnewTargetWorks);
			
				
				while(rs2.next())
				{
					gnewtarcnt+=rs2.getInt(2);
					gnewtarwrks+=rs2.getString(1)+",";
					//gnew_taramt+=rs2.getDouble(2);
				}
				
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				
				if(gnewtarwrks!=null && !gnewtarwrks.equals(""))
				{
					
					
					stmt2=conn.createStatement();
					  String gnewTargetWorksAmt="select sum(sanction_amount) FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+gnewtarwrks.substring(0, gnewtarwrks.length() - 1)+") ";
					 //System.out.println("gnewTargetWorksAmt ............"+gnewTargetWorksAmt);
					  rs2=stmt2.executeQuery(gnewTargetWorksAmt);
					   
					  	
					  	while(rs2.next())
					  	{
					  		gnew_taramt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
					  	
				  stmt2=conn.createStatement();
				  String gnewTargetHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_Code and  CONT_TYPE is not null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and  AAP_TARGET_YEAR ='"+endyr+"-"+nextyr+"' and a.work_id in ("+gnewtarwrks.substring(0, gnewtarwrks.length() - 1)+") ";
				 //System.out.println("gnewTargetHabs ............"+gnewTargetHabs);	
				  rs2=stmt2.executeQuery(gnewTargetHabs);
				   
				  	
				  	while(rs2.next())
				  	{
				  		gnew_tarhabcnt+=rs2.getInt(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();   			
				}
				
					
%>

      <tr>
			<td class="gridbg1" style="text-align: left;">Greater than 5 years</td>
			<td class="gridbg1" style="text-align: right;"><%=gspillcnt+gnewcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((gspill_amt-(gspill_exp+gspill_direxp))+gnew_amt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=gspill_habcnt+gnew_habcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=gspillcompcnt+gnewcompcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((gspill_compamt-(gspill_compexp+gspill_compdirexp))+gnew_compamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=gspill_comphabcnt+gspill_comphabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=gspillanticnt+gnewanticnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((gspill_antiamt-(gspill_antiexp+gspill_antidirexp))+gnew_antiamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=gspill_antihabcnt+gnew_antihabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=gspilltarcnt+gnewtarcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((gspill_taramt-(gspill_tarexp+gspill_targetdirexp))+gnew_taramt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=gspill_tarhabcnt+gnew_tarhabcnt%></td>


		</tr>


<%
///////////////////////////////////////////////////////////////<5yrs////////////////////////////////////////////////////////////////////////////////////////////



stmt2 = conn.createStatement();
				String lspillWorks = "select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where  a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null and to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
						+ startyr + "'))   and (sysdate -  a.admin_date<5*365 ) ";
				if (dcode != null && !dcode.equals("00")) {
					lspillWorks += "and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					lspillWorks += "and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					lspillWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					lspillWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					lspillWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					lspillWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				lspillWorks += " and  programme_code in (" + programe + ") group by a.work_id";

				rs2 = stmt2.executeQuery(lspillWorks);
			//System.out.println("lspillWorks ............" + lspillWorks);
				while (rs2.next())
				{
					lspillcnt += rs2.getInt(2);
					lwrks+=rs2.getString(1)+",";
					//lspill_amt += rs2.getDouble(2);

				}

				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				if(lwrks!=null && !lwrks.equals(""))
				{
					
					stmt2=conn.createStatement();
					  String lspillWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+lwrks.substring(0, lwrks.length() - 1)+")";
					  
					  	rs2=stmt2.executeQuery(lspillWorksAmt);
					   //System.out.println("lspillWorksAmt ............"+lspillWorksAmt);
					  	
					  	while(rs2.next())
					  	{
					  		lspill_amt += rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
					  	
				  stmt2=conn.createStatement();
				  String lspillWorksExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where a.work_id=b.work_id and a.work_id in ("+lwrks.substring(0, lwrks.length() - 1)+")";
				  
				  	rs2=stmt2.executeQuery(lspillWorksExp);
				   //System.out.println("lspillWorksExp ............"+lspillWorksExp);
				  	
				  	while(rs2.next())
				  	{
				  		lspill_exp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close(); 
				
				  	stmt2=conn.createStatement();
					  String lspillWorksDirExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b where a.work_id=b.work_id and a.work_id in ("+lwrks.substring(0, lwrks.length() - 1)+")"; 
					  
					  	rs2=stmt2.executeQuery(lspillWorksDirExp);
					   //System.out.println("lspillWorksDirExp ............"+lspillWorksDirExp);
					  	
					  	while(rs2.next())
					  	{
					  		lspill_direxp+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close();
				  	
				  	
					  	stmt2 = conn.createStatement();
						String lspillHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c , RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and  b.hab_code=c.panch_code and b.hab_Code=d.hab_Code and CONT_TYPE is not null and a.work_id in ("+lwrks.substring(0, lwrks.length() - 1)+")"; 

						rs2 = stmt2.executeQuery(lspillHabs);
					//System.out.println("lspillHabs ............" +lspillHabs);

						while (rs2.next()) {
							lspill_habcnt += rs2.getInt(1);
						}
						if (rs2 != null)
							rs2.close();
						if (stmt2 != null)
							stmt2.close();
				}
				
				stmt2 = conn.createStatement();
				String lnewWorks = "select distinct a.work_id ,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b  ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d   where a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null and  to_date(ADMIN_DATE) >='01-Apr-"
						+ startyr
						+ "' and to_date(ADMIN_DATE) <'01-Apr-"
						+ endyr + "' and work_cancel_dt is null  and (sysdate -  a.admin_date<5*365 )";
				if (dcode != null && !dcode.equals("00")) {
					lnewWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
				}
				if (scheme != null && !scheme.equals("")) {
					lnewWorks += " and type_of_asset in(" + scheme + ")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					lnewWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					lnewWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					lnewWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					lnewWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				lnewWorks += " and  programme_code in (" + programe + ")  group by a.work_id";

				rs2 = stmt2.executeQuery(lnewWorks);
			//System.out.println("lnewWorks ............" + lnewWorks);

				while (rs2.next()) {
					lnewcnt += rs2.getInt(2);
					lnewwrks+=rs2.getString(1)+",";
					//lnew_amt += rs2.getDouble(2);
				}

				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				
				
				if(lnewwrks!=null && !lnewwrks.equals(""))
				{
				
					stmt2=conn.createStatement();
					  String lnewWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+lnewwrks.substring(0, lnewwrks.length() - 1)+")";
					 //System.out.println("lnewWorksAmt ............"+lnewWorksAmt);
					  	rs2=stmt2.executeQuery(lnewWorksAmt);
					   
					  	
					  	while(rs2.next())
					  	{
					  		lnew_amt += rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close();
					
				stmt2 = conn.createStatement();
				String lnewHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c,RWS_HAB_CONTAMINATION_TBL d  where  a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_Code and CONT_TYPE is not null  and a.work_id in ("+lnewwrks.substring(0, lnewwrks.length() - 1)+")"; 
				//System.out.println("lnewHabs ............" + lnewHabs);
				rs2 = stmt2.executeQuery(lnewHabs);
			   

				while (rs2.next()) {
					lnew_habcnt += rs2.getInt(1);
				}
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				}
//////////////////////////////////////////////////////////<5yrs completed works//////////////////////////////////////////////////////////////////////////////////////////////////////

                stmt2=conn.createStatement();
				String lspillcompWorks="select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a  ,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c,rws_Complete_hab_view d,RWS_HAB_CONTAMINATION_TBL f where  a.work_id=b.work_id and a.work_id=c.work_id and c.hab_Code=d.panch_code and c.hab_code=f.hab_Code and CONT_TYPE is not null  and  work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' ) and (sysdate -  admin_date<5*365 ) ";
				if(dcode!=null && !dcode.equals("00"))
				{
					lspillcompWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					lspillcompWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					lspillcompWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					lspillcompWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					lspillcompWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					lspillcompWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				lspillcompWorks+=" and  programme_code in ("+programe+") group by a.work_id"; 
				
				rs2=stmt2.executeQuery(lspillcompWorks);
			   //System.out.println("lspillcompWorks ............"+lspillcompWorks);
				
				while(rs2.next())
				{
					lspillcompcnt+=rs2.getInt(2);
					lcompwrks+=rs2.getString(1)+",";
					//lspill_compamt+=rs2.getDouble(2);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				if(lcompwrks!=null && !lcompwrks.equals(""))
				{
				  
					stmt2=conn.createStatement();
					  String lspillCompWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+lcompwrks.substring(0, lcompwrks.length() - 1)+")"; 
					  
					  	rs2=stmt2.executeQuery(lspillCompWorksAmt);
					   //System.out.println("lspillCompWorksAmt ............"+lspillCompWorksAmt);
					  	
					  	while(rs2.next())
					  	{
					  		lspill_compamt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close();
					
					
					
					
					stmt2=conn.createStatement();
				  String lspillCompExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b  where a.work_id=b.work_id  and a.work_id in ("+lcompwrks.substring(0, lcompwrks.length() - 1)+")"; 
				  
				  	rs2=stmt2.executeQuery(lspillCompExp);
				   //System.out.println("lspillCompExp ............"+lspillCompExp);
				  	
				  	while(rs2.next())
				  	{
				  		lspill_compexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();
				  	
				  	
				  	stmt2=conn.createStatement();
					  String lspillCompDirExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id  and a.work_id in ("+lcompwrks.substring(0, lcompwrks.length() - 1)+")";
					  
					  	rs2=stmt2.executeQuery(lspillCompDirExp);
					   //System.out.println("lspillCompDirExp ............"+lspillCompDirExp);
					  	
					  	while(rs2.next())
					  	{
					  		lspill_compdirexp+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close();
				  	
				  	
				  	
				  	
				
				stmt2=conn.createStatement();
				String lspillcomphabs="select count(distinct c.hab_code)  FROM RWS_WORK_ADMN_TBL a  ,rws_work_completion_tbl b ,RWS_WORK_COMP_HAB_LNK_TBL c ,rws_complete_hab_view d, RWS_HAB_CONTAMINATION_TBL e where  a.work_id=b.work_id and a.work_id=c.work_id and c.hab_Code=d.panch_code and  c.hab_code=e.hab_Code and CONT_TYPE is not null  and a.work_id in ("+lcompwrks.substring(0, lcompwrks.length() - 1)+")"; 
				
				rs2=stmt2.executeQuery(lspillcomphabs);
			   //System.out.println("lspillcomphabs ............"+lspillcomphabs);
				
				while(rs2.next())
				{
					lspill_comphabcnt+=rs2.getInt(1);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				}
				
				
				
				stmt2=conn.createStatement();
			
			    String lnewcompWorks="select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c ,rws_complete_hab_view d, RWS_HAB_CONTAMINATION_TBL e   where a.work_id=b.work_id and a.work_id=c.work_id and c.hab_Code=d.panch_code and c.hab_Code=e.hab_code and CONT_TYPE is not null and to_date(a.ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(a.ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' and (sysdate -  admin_date<5*365 )";
					
				if(dcode!=null && !dcode.equals("00"))
				{
					lnewcompWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					lnewcompWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					lnewcompWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					lnewcompWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					lnewcompWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					lnewcompWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				lnewcompWorks+=" and  programme_code in ("+programe+") group by a.work_id"; 
				
				rs2=stmt2.executeQuery(lnewcompWorks);
			  //System.out.println("lnewcompWorks ............"+lnewcompWorks);
				
				while(rs2.next())
				{
					lnewcompcnt+=rs2.getInt(2);
					lnewcompwrks+=rs2.getString(1)+",";
					//lnew_compamt+=rs2.getDouble(2);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				
				if(lnewcompwrks!=null && !lnewcompwrks.equals(""))
				{
				
					stmt2=conn.createStatement();
					  String lnewCompWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where a.work_id in ("+lnewcompwrks.substring(0, lnewcompwrks.length() - 1)+")"; 
					  
					  	rs2=stmt2.executeQuery(lnewCompWorksAmt);
					   //System.out.println("lnewCompWorksAmt ............"+lnewCompWorksAmt);
					  	
					  	while(rs2.next())
					  	{
					  		lnew_compamt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close();
					  	
					  	
				stmt2=conn.createStatement();
				String lnewCompHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c,rws_complete_hab_view d ,RWS_HAB_CONTAMINATION_TBL e where a.work_id=b.work_id and a.work_id=c.work_id and b.hab_code=d.panch_code and b.hab_Code=e.hab_Code and CONT_TYPE is not null  and a.work_id in ("+lnewcompwrks.substring(0, lnewcompwrks.length() - 1)+")"; 
			      
				  	rs2=stmt2.executeQuery(lnewCompHabs);
				   //System.out.println("lnewCompHabs ............"+lnewCompHabs);
				  	
				  	while(rs2.next())
				  	{
				  		lnew_comphabcnt+=rs2.getInt(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();  
		  	
				}
		////////////////////////////////////////////<5yrs Anticipated Works////////////////////////////////////////////////////////////		
				
			    stmt2=conn.createStatement();
				String lspillantiWorks="select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_Complete_hab_view c , RWS_HAB_CONTAMINATION_TBL d   where  a.work_id=b.work_id and b.hab_Code=c.panch_code and b.hab_Code=d.hab_Code and CONT_TYPE is not null and  work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"'  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date<5*365 )  ";
				if(dcode!=null && !dcode.equals("00"))
				{
					lspillantiWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					lspillantiWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					lspillantiWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					lspillantiWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					lspillantiWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					lspillantiWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				lspillantiWorks+=" and  programme_code in ("+programe+") group by a.work_id"; 
				
				rs2=stmt2.executeQuery(lspillantiWorks);
			//System.out.println("lspillantiWorks ............"+lspillantiWorks);
				
				while(rs2.next())
				{
					lspillanticnt+=rs2.getInt(2);
					lantiwrks+=rs2.getString(1)+",";
					//lspill_antiamt+=rs2.getDouble(2);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				if(lantiwrks!=null && !lantiwrks.equals(""))
				{
				
					stmt2=conn.createStatement();
					  String lspillAntiWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+lantiwrks.substring(0, lantiwrks.length() - 1)+")"; 
					  
					  	rs2=stmt2.executeQuery(lspillAntiWorksAmt);
					   //System.out.println("lspillAntiWorksAmt ............"+lspillAntiWorksAmt);
					  	
					  	while(rs2.next())
					  	{
					  		lspill_antiamt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 

					
					
					
				 stmt2=conn.createStatement();
				  String lspillAntiExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and  a.work_id in ("+lantiwrks.substring(0, lantiwrks.length() - 1)+")"; 
				  
				  	rs2=stmt2.executeQuery(lspillAntiExp);
				   //System.out.println("lspillAntiExp ............"+lspillAntiExp);
				  	
				  	while(rs2.next())
				  	{
				  		lspill_antiexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close(); 

				  	stmt2=conn.createStatement();
					  String lspillAntiDirExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b    where a.work_id=b.work_id and  a.work_id in ("+lantiwrks.substring(0, lantiwrks.length() - 1)+")";   
					  
					  	rs2=stmt2.executeQuery(lspillAntiDirExp);
					   //System.out.println("lspillAntiDirExp ............"+lspillAntiDirExp);
					  	
					  	while(rs2.next())
					  	{
					  		lspill_antidirexp+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
				
				stmt2=conn.createStatement(); 
				String lspillantihabs="select count(distinct b.hab_code)  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where  a.work_id=b.work_id and b.hab_code=c.panch_Code and b.hab_Code=d.hab_code and work_cancel_dt is null and CONT_TYPE is not null  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and AAP_TARGET_YEAR ='"+startyr+"-"+endyr+"'  and    a.work_id in ("+lantiwrks.substring(0, lantiwrks.length() - 1)+")";
							
				rs2=stmt2.executeQuery(lspillantihabs);
			   //System.out.println("lspillantihabs ............"+lspillantihabs);
				
				while(rs2.next())
				{
					lspill_antihabcnt+=rs2.getInt(1);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 	
				}
				
		
				stmt2=conn.createStatement();
				String lnewAntiWorks="select distinct a.work_id,count(distinct a.work_id)  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d   where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null and to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date<5*365 )   ";
				if(dcode!=null && !dcode.equals("00"))
				{
					lnewAntiWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					lnewAntiWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					lnewAntiWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					lnewAntiWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					lnewAntiWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					lnewAntiWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				lnewAntiWorks+=" and  programme_code in ("+programe+") group by a.work_id "; 
				
				rs2=stmt2.executeQuery(lnewAntiWorks);
			//System.out.println("lnewAntiWorks ............"+lnewAntiWorks);
				
				while(rs2.next())
				{
					lnewanticnt+=rs2.getInt(2);
					lnewantiwrks+=rs2.getString(1)+",";
					//lnew_antiamt+=rs2.getDouble(2);
				}
				
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				if(lnewantiwrks!=null && !lnewantiwrks.equals(""))
				{
					
					
					stmt2=conn.createStatement();
					  String lnewAntiWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+lnewantiwrks.substring(0, lnewantiwrks.length() - 1)+")"; 
					  
					  	rs2=stmt2.executeQuery(lnewAntiWorksAmt);
					   //System.out.println("lnewAntiWorksAmt ............"+lnewAntiWorksAmt);
					  	
					  	while(rs2.next())
					  	{
					  		lnew_antiamt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 

					
					
					
					
					
					
				  stmt2=conn.createStatement();
				  String lnewantiHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"' and AAP_TARGET_YEAR ='"+startyr+"-"+endyr+"' and   a.work_id in ("+lnewantiwrks.substring(0, lnewantiwrks.length() - 1)+")";
				 			  
				  	rs2=stmt2.executeQuery(lnewantiHabs);
				   //System.out.println("lnewantiHabs ............"+lnewantiHabs);
				  	
				  	while(rs2.next())
				  	{
				  		lnew_antihabcnt+=rs2.getInt(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();   
				  				
				}
				
		//////////////////////////////////////////////////////<5yrs Targeted Works///////////////////////////////////////////////////////////////////////////////////////////////////////		
				
		        stmt2=conn.createStatement();
				String lspillTargetWorks="select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a , rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where  a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null  and  work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"'  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date<5*365 ) ";
				if(dcode!=null && !dcode.equals("00"))
				{
					lspillTargetWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					lspillTargetWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					lspillTargetWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					lspillTargetWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					lspillTargetWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					lspillTargetWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				lspillTargetWorks+=" and  programme_code in ("+programe+") group by a.work_id"; 
				
				rs2=stmt2.executeQuery(lspillTargetWorks);
			//System.out.println("lspillTargetWorks ............"+lspillTargetWorks);
				
				while(rs2.next())
				{
					lspilltarcnt+=rs2.getInt(2);
					ltarwrks+=rs2.getString(1)+",";
					//lspill_taramt+=rs2.getDouble(2);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				if(ltarwrks!=null && !ltarwrks.equals(""))
				{
				
					  stmt2=conn.createStatement();
					  String lspillTargetWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+ltarwrks.substring(0, ltarwrks.length() - 1)+")"; 
					  
					  	rs2=stmt2.executeQuery(lspillTargetWorksAmt);
					   //System.out.println("lspillTargetWorksAmt ............"+lspillTargetWorksAmt);
					  	
					  	while(rs2.next())
					  	{
					  		lspill_taramt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
					
					
					
				  stmt2=conn.createStatement();
				  String lspillTargetExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where a.work_id=b.work_id and  a.work_id in ("+ltarwrks.substring(0, ltarwrks.length() - 1)+")"; 
				  
				  	rs2=stmt2.executeQuery(lspillTargetExp);
				   //System.out.println("lspillTargetExp ............"+lspillTargetExp);
				  	
				  	while(rs2.next())
				  	{
				  		lspill_tarexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close(); 
				
				  	
				  	
				  	stmt2=conn.createStatement();
					  String lspillTargetDirExp="select sum(voucher_Amt)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b  where a.work_id=b.work_id and  a.work_id in ("+ltarwrks.substring(0, ltarwrks.length() - 1)+")"; 
					  
					  	rs2=stmt2.executeQuery(lspillTargetDirExp);
					   //System.out.println("lspillTargetDirExp ............"+lspillTargetDirExp);
					  	
					  	while(rs2.next())
					  	{
					  		lspill_tardirexp+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
					
				
				stmt2=conn.createStatement();
				String lspillTargethabs="select count(distinct b.hab_Code) FROM RWS_WORK_ADMN_TBL a  ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where  a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null  and AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+endyr+"-"+nextyr+"' and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"' and  a.work_id in ("+ltarwrks.substring(0, ltarwrks.length() - 1)+")";  
				
				rs2=stmt2.executeQuery(lspillTargethabs);
			   //System.out.println("lspillTargethabs ............"+lspillTargethabs);
				
				while(rs2.next())
				{
					lspill_tarhabcnt+=rs2.getInt(1);
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
				
				}
						
				
				stmt2=conn.createStatement();
				String lnewTargetWorks="select distinct a.work_id,count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d  where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null  and to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date<5*365 )";
				if(dcode!=null && !dcode.equals("00"))
				{
					lnewTargetWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					lnewTargetWorks+=" and type_of_asset in("+scheme+")";
				}
				if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				{
					lnewTargetWorks += " and a.work_id in(" + plainworks + ")";
					
				}
				if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				{    
					lnewTargetWorks += " and a.work_id in(" + scworks + ")";
				}
				if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				{    
					lnewTargetWorks += " and a.work_id in(" + stworks + ")";
				}
				if (ctype != null && !ctype.equals("all")) 
				{
					lnewTargetWorks += "and CONT_TYPE ='" + ctype + "' ";
				}
				lnewTargetWorks+=" and  programme_code in ("+programe+") group by a.work_id "; 
				
				rs2=stmt2.executeQuery(lnewTargetWorks);
			//System.out.println("lnewTargetWorks ............"+lnewTargetWorks);
				
				while(rs2.next())
				{
					lnewtarcnt+=rs2.getInt(2);
					lnewtarwrks+=rs2.getString(1)+",";
					//lnew_taramt+=rs2.getDouble(2);
				}
				
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close(); 
				
				if(lnewtarwrks!=null && !lnewtarwrks.equals(""))
				{
					
					 stmt2=conn.createStatement();
					  String lnewTargetWorksAmt="select sum(sanction_amount)  FROM RWS_WORK_ADMN_TBL a where  a.work_id in ("+lnewtarwrks.substring(0, lnewtarwrks.length() - 1)+")"; 
					  
					  	rs2=stmt2.executeQuery(lnewTargetWorksAmt);
					   //System.out.println("lnewTargetWorksAmt ............"+lnewTargetWorksAmt);
					  	
					  	while(rs2.next())
					  	{
					  		lnew_taramt+=rs2.getDouble(1);
					  	}
					  	if(rs2!=null)rs2.close();
					  	if(stmt2!=null)stmt2.close(); 
					
					
				
				  stmt2=conn.createStatement();
				  String lnewTargetHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c ,RWS_HAB_CONTAMINATION_TBL d where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=d.hab_code and CONT_TYPE is not null and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and  AAP_TARGET_YEAR ='"+endyr+"-"+nextyr+"' and   a.work_id in ("+lnewtarwrks.substring(0, lnewtarwrks.length() - 1)+")";
				  rs2=stmt2.executeQuery(lnewTargetHabs);
				 //System.out.println("lnewTargetHabs ............"+lnewTargetHabs);
				  	
				  	while(rs2.next())
				  	{
				  		lnew_tarhabcnt+=rs2.getInt(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();   			
				}
				  	////System.out.println(lspill_compamt+"...."+lspill_comexp);
					
%>
  <tr>
			<td class="gridbg1" style="text-align: left;">Less than 5 years</td>
			<td class="gridbg1" style="text-align: right;"><%=lspillcnt+lnewcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((lspill_amt-(lspill_exp+lspill_direxp)) + lnew_amt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=lspill_habcnt+lnew_habcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=lspillcompcnt+lnewcompcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((lspill_compamt-(lspill_compexp+lspill_compdirexp))+lnew_compamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=lspill_comphabcnt+lnew_comphabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=lspillanticnt+lnewanticnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((lspill_antiamt-(lspill_antiexp+lspill_antidirexp))+lnew_antiamt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=lspill_antihabcnt+lnew_antihabcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=lspilltarcnt+lnewtarcnt%></td>
			<td class="gridbg1" style="text-align: right;"><%=ndf.format((lspill_taramt-(lspill_tarexp+lspill_tardirexp))+lnew_taramt)%></td>
			<td class="gridbg1" style="text-align: right;"><%=lspill_tarhabcnt+lnew_tarhabcnt%></td>


		</tr>

<tr>

			<td class="gridhdbg" style="text-align: right;">Total</td>
			<td class="gridhdbg" style="text-align: right;"><%=gspillcnt+gnewcnt+lspillcnt+lnewcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((gspill_amt-(gspill_exp+gspill_direxp))+gnew_amt+(lspill_amt-(lspill_exp+lspill_direxp))+ lnew_amt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=gspill_habcnt+gnew_habcnt+lspill_habcnt+lnew_habcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=gspillcompcnt+gnewcompcnt+lspillcompcnt+lnewcompcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((gspill_compamt-(gspill_compexp+gspill_compdirexp))+gnew_compamt+(lspill_compamt-(lspill_compexp+lspill_compdirexp))+lnew_compamt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=gspill_comphabcnt+gnew_comphabcnt+lspill_comphabcnt+lnew_comphabcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=gspillanticnt+gnewanticnt+lspillanticnt+lnewanticnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((gspill_antiamt-(gspill_antiexp+gspill_antidirexp))+gnew_antiamt+(lspill_antiamt-(lspill_antiexp+lspill_antidirexp))+lnew_antiamt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=gspill_antihabcnt+gnew_antihabcnt+lspill_antihabcnt+lnew_antihabcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=gspilltarcnt+gnewtarcnt+lspilltarcnt+lnewtarcnt%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format((gspill_taramt-(gspill_tarexp+gspill_targetdirexp))+gnew_taramt+(lspill_taramt-(lspill_tarexp+lspill_tardirexp))+lnew_taramt)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=gspill_tarhabcnt+gnew_tarhabcnt+lspill_tarhabcnt+lnew_tarhabcnt%></td>

		</tr>



		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>

	</table>
</body>
</form>
</html>