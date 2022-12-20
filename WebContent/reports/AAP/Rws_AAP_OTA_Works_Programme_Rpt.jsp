<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 



<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>


<script language="JavaScript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
</script>

	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialstartyr="";
	
    double aas=0;
    double OtherFundasSC=0,OtherFundaslikelySC=0,gtotlikely=0,gexpendituretot=0,gglikelytot=0,ggexpenditure=0,scPOP=0,ggggtotEST=0,	ggggstatescEST=0,ggggtotalotherscsp=0;
        
    double ggunderscexp=0,ggunderotherexp=0;
    //System.out.println("1"); 
    String pname="";
	if(request.getParameter("pname")!=null){
	pname=request.getParameter("pname");
	session.setAttribute("pname",pname);
	}

	if(request.getParameter("finyear")!=null){
	financialstartyr=request.getParameter("finyear");
	}
   String probstrng="";
   if(financialstartyr.equals("2013-2014")){
	   probstrng="PROB_EXP";  
   }
	if(financialstartyr.equals("2014-2015")){
		probstrng="PROB_EXP_NXT_YR1";   
	   }
	if(financialstartyr.equals("2015-2016")){
		probstrng="PROB_EXP_NXT_YR";   
	}
	if(financialstartyr.equals("2016-2017")){
		probstrng="PROB_EXP_NXT_YR2";   
	}
	session.setAttribute("financialyr",financialstartyr);
//////System.out.println("Changing");
    //schemes
	String scheme="";
	String[] schemes=null;
    if(request.getParameterValues("scheme")!=null){
    schemes=request.getParameterValues("scheme");
	
    
	for(int i=0;i<schemes.length;i++)
	{
	scheme += schemes[i]+",";
	}
	//////System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);
	session.setAttribute("schemes",schemes);
	}
  
	String startyr =financialstartyr.substring(0,4);
	String endyr =financialstartyr.substring(5,9);
    String endyr1 =financialstartyr.substring(5,9);
   
    String[] programes=request.getParameterValues("program");
   // System.out.println("2"); 	
    session.setAttribute("programes",programes);
    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	programe = programe.substring(0,programe.length()-1);

	

   String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   //////System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(startyr);
   
   String nextfinancialstartyr="";
   
   int nextFinYear=yy+1;
   int nn=nextFinYear+1;
   
   nextfinancialstartyr=""+nextFinYear+"-"+nn;
   int prevyear=0,prevmon=0;String fyear,fyear1;

	String prevmonth=RwsUtils.getPreviousMonth().toUpperCase();
	String cmonth=RwsUtils.getCurrentMont().toUpperCase();
	String nextmonth=RwsUtils.getNextMonth().toUpperCase();
	
	if(startyr.equals(sysyear) && cmonth.equals("APR")){
	   prevmonth=cmonth;
	}
	String startyr2="";
	  java.util.Date d=new java.util.Date();
	if(d.getMonth()>=3 && d.getMonth()  <=11){
	endyr1=startyr;
	
	}else {
	endyr1=endyr;
	}



	String dcode=request.getParameter("district");
	
	  if(dcode!=null && !dcode.equals("")){
	  session.setAttribute("dcode",dcode);
	}
	
	String mode=request.getParameter("mode");
	
	String targetyr=(Integer.parseInt(startyr))+"-"+(Integer.parseInt(endyr));

	int cyear = Calendar.getInstance().get(Calendar.YEAR);
	int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
	int yearStart = 0;
	int yearEnd = 0;
	if (month <= 3) {
		yearStart = cyear - 1;
		yearEnd = cyear;
	} else {
		yearStart = cyear;
		yearEnd = cyear + 1;
	}
	String dname=request.getParameter("dname");
	%>
	
	<body>
	 
<table border = 0 cellspacing = 0 cellpadding = 0 width="60%" style="border-collapse:collapse" >
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
//1 PROJECTS (mvs)

//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a><!-- <a href="./rws_wrk_hab_target_abstract_excel.jsp">Excel</a></td> --></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b></b></font></td></tr>
	</table>
	
	
<table border=1 cellspacing=0 cellpadding=0 width="60%"
	bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff"
	align="center"><tr >
	<%if(mode.equals("programme")){ %>
			<td align="center" class="gridhdbg" colspan=27>AAP Abstract during <%=financialstartyr %> District:<%=dname %></td>	
	<%}if(mode.equals("subProgramme")){ %>
	<td align="center" class="gridhdbg" colspan=27>AAP Abstract during <%=financialstartyr %> District:<%=dname %> and Programme: <%=request.getParameter("progName") %></td>
	<%} %>
	</tr>
		<tr>
		<td  class="gridhdbg" rowspan="2">Sl.No</td>
		<%if(mode.equals("programme")){ %>
		<td   class="gridhdbg" rowspan="2">Programme</td>
		<%}if(mode.equals("subProgramme")){ %>
		<td  class="gridhdbg" rowspan="2"> Sub Programme</td>
		<%} %>
		<td   class="gridhdbg"  colspan="3">Ongoing Works</td>
		<td   class="gridhdbg" colspan="3">Target (<%=financialstartyr %>)</td>
		<td   class="gridhdbg"  colspan="4">Achievement During (<%=financialstartyr %>)</td>
		<%-- <td   class="gridhdbg"  colspan="3">To Be Completed During(<%=financialstartyr %>)</td> --%>
		<td   class="gridhdbg"  colspan="3">Balance Program (<%=financialstartyr %>)</td>
	</tr>
	<tr>
	<td  class="gridhdbg">Works</td>
	<td  class="gridhdbg">Habs</td>
	<td  class="gridhdbg">Bal Est. Cost</td>
	<td  class="gridhdbg">Works</td>
	<td  class="gridhdbg">Habs</td>
	<td  class="gridhdbg">Bal Est. Cost</td>
	<td  class="gridhdbg">Works</td>
	<td  class="gridhdbg">Habs</td>
	<td  class="gridhdbg">Expenditure</td>
	<td  class="gridhdbg">Tot Exp.</td>
	<!-- <td  class="gridhdbg">Works</td>
	<td  class="gridhdbg">Habs</td>
	<td  class="gridhdbg">Bal Est. Cost</td> -->
	<td  class="gridhdbg">Works</td>
	<td  class="gridhdbg">Habs</td>
	<!-- <td  class="gridhdbg">Expenditure</td> -->
	<td  class="gridhdbg">Bal Est. Cost</td>
	</tr>

	<tr>
	<%
	Statement stmt1=null,stmt2=null,stmt3=null;
	ResultSet rs1=null,rs2=null,rs3=null;
	int styleCount = 0;
	String style = ""; 
	int slno=0;
	try{
		int ongoingHabs=0,ongoingWorks=0;
		double bankLastYear=0,paoLastYear=0,sacAmount=0;
		int targetHabs=0,targetWorks=0;
		double targetbankLastYear=0,targetpaoLastYear=0,targetsacAmount=0;
		int tobecompHabs=0,tobecompWorks=0;
		double tobecompbankLastYear=0,tobecomppaoLastYear=0,tobecompsacAmount=0;
		int worksComp=0,habsCov=0;
		double compbankLastYear=0,comppaoLastYear=0,compsacAmount=0;
		double totExpBank=0,totExpPao=0,totExpBankPlusPao=0;
		int finalongoingHabs=0,finalongoingWorks=0;
		double finalongoingbankLastYear=0,finalongoingpaoLastYear=0,finalongoingsacAmount=0;
		int totongoingHabs=0,totongoingWorks=0,tottargetHabs=0,tottargetWorks=0,totworksComp=0,tothabsCov=0,tottobecompHabs=0,tottobecompWorks=0,totfinalongoingHabs=0,totfinalongoingWorks=0; 
		double totOngoingBalEstCost=0,totTargetBalEstCost=0,totCompExp=0,totCompBalEstCost=0,tottobecompBalEstCost=0,totfinalOngoingBalEstCost=0,totfinalOngoingExp=0;
		
		
		String progQuery="";
		if(mode.equals("programme")){ 
			progQuery="select programme_code,programme_name from rws_programme_tbl where programme_code in ("+ programe+") order by programme_code";
		}
		else if(mode.equals("subProgramme")){ 
		progQuery="select p.programme_code,p.programme_name,subprogramme_code,subprogramme_name from rws_programme_tbl p,rws_subprogramme_tbl sp where sp.programme_code in ("+ programe+") and  p.programme_code=sp.programme_code order by subprogramme_code";
		}
		//System.out.println(progQuery);
		stmt2=conn.createStatement();
		rs2=stmt2.executeQuery(progQuery);
		while(rs2.next()){
			//System.out.println("innnn"+progQuery);
			//dcode=rs2.getString(1);
			programe=rs2.getString(1);
			String subprogramme="";
			if(mode.equals("subProgramme")){
				subprogramme=rs2.getString(3);
			}
			if (styleCount % 2 == 0) {
				style = "gridbg1";
			} else {
				style = "gridbg2";
			}
			styleCount++;
			
			/***Ongoing Related***/ 
		String ongoingWorksQuery="select sum(a.SANCTION_AMOUNT),count(a.work_id) from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+ dcode+ "'   and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+")  and a.programme_code in ("+ programe+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		if(mode.equals("subProgramme")){
			ongoingWorksQuery+=" and a.subprogramme_code in ('"+subprogramme+"')";
		}
		//System.out.println("ongoingWorksQuery"+ongoingWorksQuery);
		stmt=conn.createStatement();
		rs=stmt.executeQuery(ongoingWorksQuery);
		//System.out.println("ongoingWorksQuery"+ongoingWorksQuery);
		if(rs.next()){
			
			ongoingWorks=rs.getInt(2);
			sacAmount=rs.getDouble(1);
		}
		stmt.close();
		rs.close();
			if(ongoingWorks!=0){
			String ongoingHabsQuery="select count(h.hab_code) from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL h where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+dcode+ "'   and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+") and a.programme_code in ("+ programe+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and  h.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(mode.equals("subProgramme")){
				ongoingHabsQuery+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1=conn.createStatement();
			rs1=stmt1.executeQuery(ongoingHabsQuery);
			if(rs1.next()){
				ongoingHabs=rs1.getInt(1);
			}
			stmt1.close();
			rs1.close();
			String bankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
					+ dcode
					+ "' and a.type_of_asset in ("+scheme+") and a.programme_code in ("
					+ programe
					+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-"
					+ (yearEnd - 1) + "'";
			bankLFY += "   and c.GROUNDING_DATE is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(mode.equals("subProgramme")){
				bankLFY+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(bankLFY);
			if (rs1.next()) {
				bankLastYear = rs1.getDouble(1);
			}
			stmt1.close();
			rs1.close();

			String paoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
					+ dcode
					+ "' and a.type_of_asset in ("+scheme+") and a.programme_code in ("
					+ programe
					+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"')  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-"
					+ (yearEnd - 1) + "'";
			
			paoFLY += "   and c.GROUNDING_DATE is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(mode.equals("subProgramme")){
				paoFLY+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(paoFLY);
			if (rs1.next()) {
				paoLastYear = rs1.getDouble(1);
			}
			stmt1.close();
			rs1.close();
			double bankPao=(bankLastYear + paoLastYear) / 100000;
			double balAmount=sacAmount-bankPao;
			String finalamount =ndf.format(balAmount);
			if (styleCount % 2 == 0) {
				style = "gridbg1";
			} else {
				style = "gridbg2";
			}
			styleCount++;
			%>
			<tr>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
			<%if(mode.equals("programme")){ %>
			<td class="<%=style%>" style="text-align: left;" align="left"><a href="./Rws_AAP_OTA_Works_Programme_Rpt.jsp?mode=subProgramme&district=<%=dcode%>&program=<%=programe%>&dname=<%=dname%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=ongoingWorks&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=dname%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>')"><%=ongoingWorks%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=ongoingHabs&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=dname%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>')"><%=ongoingHabs%></a></td>
			<%} if(mode.equals("subProgramme")){%>
			<td class="<%=style%>" style="text-align: left;" align="left"><%=rs2.getString(4)%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=ongoingWorks&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=dname%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>&subprogName=<%=rs2.getString(4)%>&subprogCode=<%=rs2.getString(3)%>')"><%=ongoingWorks%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=ongoingHabs&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=dname%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>&subprogName=<%=rs2.getString(4)%>&subprogCode=<%=rs2.getString(3)%>')"><%=ongoingHabs%></a></td>
			<%} %>
			
			
			<td class="<%=style%>" style="text-align: right;" align="right"><%=finalamount%></td>
			
			<%
			/*** End of Ongoing Related***/ 
		
			/***Target Related***/ 
			String targetWorksQuery="select sum(a.SANCTION_AMOUNT),count(a.work_id) from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+ dcode+ "'   and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+") and a.programme_code in ("+ programe+ ") "
					+"  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
					+" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(mode.equals("subProgramme")){
				targetWorksQuery+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
		stmt=conn.createStatement();
		rs=stmt.executeQuery(targetWorksQuery);
		//System.out.println("targetWorksQuery"+targetWorksQuery);
		if(rs.next()){
			
			targetWorks=rs.getInt(2);
			targetsacAmount=rs.getDouble(1);
		}
		stmt.close();
		rs.close();
			
			String targetHabsQuery="select count(h.hab_code) from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL h where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+dcode+ "'   and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+") and a.programme_code in ("+ programe+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and  h.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
					+" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(mode.equals("subProgramme")){
				targetHabsQuery+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1=conn.createStatement();
			rs1=stmt1.executeQuery(targetHabsQuery);
			if(rs1.next()){
				targetHabs=rs1.getInt(1);
			}
			stmt1.close();
			rs1.close();
			String targetbankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
					+ dcode
					+ "' and a.type_of_asset in ("+scheme+") and a.programme_code in ("
					+ programe
					+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-"
					+ (yearEnd - 1) + "'"
					+" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"' ";
			targetbankLFY += "   and c.GROUNDING_DATE is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(mode.equals("subProgramme")){
				targetbankLFY+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(targetbankLFY);
			if (rs1.next()) {
				targetbankLastYear = rs1.getDouble(1);
			}
			stmt1.close();
			rs1.close();

			String targetpaoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
					+ dcode
					+ "' and a.type_of_asset in ("+scheme+") and a.programme_code in ("
					+ programe
					+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"')  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-"
					+ (yearEnd - 1) + "'"
					+" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
				targetpaoFLY += "   and c.GROUNDING_DATE is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
				if(mode.equals("subProgramme")){
					targetpaoFLY+=" and a.subprogramme_code in ('"+subprogramme+"')";
				}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(targetpaoFLY);
			if (rs1.next()) {
				targetpaoLastYear = rs1.getDouble(1);
			}
			stmt1.close();
			rs1.close();
			double targetbankPao=(targetbankLastYear + targetpaoLastYear) / 100000;
			double targetbalAmount=targetsacAmount-targetbankPao;
			String targetfinalamount =ndf.format(targetbalAmount);
			%>
			<%if(mode.equals("programme")){ %>
			<%if(targetWorks!=0){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=targetWorks&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=dname%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>')"><%=targetWorks%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=targetHabs&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=dname%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>')"><%=targetHabs%></a></td>
			<%} else{%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=targetWorks%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=targetHabs%></td>
			<%} %>
			<%} if(mode.equals("subProgramme")){%>
			<%if(targetWorks!=0){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=targetWorks&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=dname%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>&subprogName=<%=rs2.getString(4)%>&subprogCode=<%=rs2.getString(3)%>')"><%=targetWorks%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=targetHabs&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=dname%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>&subprogName=<%=rs2.getString(4)%>&subprogCode=<%=rs2.getString(3)%>')"><%=targetHabs%></a></td>
			<%} else{%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=targetWorks%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=targetHabs%></td>
			<%} %>
			<%} %>
			
			
			
			
			<td class="<%=style%>" style="text-align: right;" align="right"><%=targetfinalamount%></td>
			
			<%
			/*** End of Target Related***/ 
			 
			/*** Completed Related***/ 
			
			String compWorks = "select count(a.work_id),sum(a.SANCTION_AMOUNT) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
					+ dcode
					+ "'  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and a.type_of_asset in ("+scheme+")  and a.programme_code in ("
					+ programe
					+ ") and b.DATE_OF_COMPLETION between '01-APR-"
					+ yearStart
					+ "' and '31-MAR-"
					+ yearEnd
					+ "'  and b.DATE_OF_COMPLETION is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(mode.equals("subProgramme")){
				compWorks+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(compWorks);
			//System.out.println("compWorks"+compWorks);
			if (rs1.next()) {
				worksComp = rs1.getInt(1);
				compsacAmount=rs1.getDouble(2);
			}
			stmt1.close();
			rs1.close();
			
			String covHabs = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
					+ dcode
					+ "'   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and a.type_of_asset in ("+scheme+")  and a.programme_code in ("
					+ programe
					+ ") and b.DATE_OF_COMPLETION between '01-APR-"
					+ yearStart
					+ "' and '31-MAR-"
					+ yearEnd
					+ "'  and b.DATE_OF_COMPLETION is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(mode.equals("subProgramme")){
				covHabs+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(covHabs);
			
			if (rs1.next()) {
				habsCov = rs1.getInt(1);
			}
			stmt1.close();
			rs1.close();
			
			String compbankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_work_completion_tbl com,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
					+ dcode
					+ "' and a.type_of_asset in ("+scheme+") and a.programme_code in ("
					+ programe
					+ ")  and  b.work_id=a.work_id and  com.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
					+" and com.DATE_OF_COMPLETION between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
			compbankLFY += "   and c.GROUNDING_DATE is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(mode.equals("subProgramme")){
				compbankLFY+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(compbankLFY);
			if (rs1.next()) {
				compbankLastYear = rs1.getDouble(1);
			}
			stmt1.close();
			rs1.close();

			String comppaoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_work_completion_tbl com,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
					+ dcode
					+ "' and a.type_of_asset in ("+scheme+") and a.programme_code in ("
					+ programe
					+ ") and  com.work_id=a.work_id  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
					+" and com.DATE_OF_COMPLETION between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
			
			comppaoFLY += "   and c.GROUNDING_DATE is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(mode.equals("subProgramme")){
				comppaoFLY+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(comppaoFLY);
			if (rs1.next()) {
				comppaoLastYear = rs1.getDouble(1);
			}
			stmt1.close();
			rs1.close();
			
			double compbankPao=(compbankLastYear + comppaoLastYear) / 100000;
			double compbalAmount=compsacAmount-compbankPao;
			String compBalEstamount =ndf.format(compbalAmount);
			String compfinalamount =ndf.format(compbankPao);
			
			String totExpBankQuery="select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b WHERE a.work_id=b.work_id and BANK_SEND_DATE BETWEEN '01-APR-"+yearStart+"' AND '31-MAR-"+yearEnd+"' and substr(a.WORK_ID,5,2)='"+dcode+"' and b.type_of_asset in ("+scheme+") and b.programme_code in ("+ programe+ ")";
			if(mode.equals("subProgramme")){
				totExpBankQuery+=" and b.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(totExpBankQuery);
			if (rs1.next()) {
				totExpBank = rs1.getDouble(1);
			}
			stmt1.close();
			rs1.close();
			
			String totExpPaoQuery="select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b WHERE a.work_id=b.work_id and STATE_SEND_DATE BETWEEN '01-APR-"+yearStart+"' AND '31-MAR-"+yearEnd+"' and substr(a.WORK_ID,5,2)='"+dcode+"' and b.type_of_asset in ("+scheme+") and b.programme_code in ("+ programe+ ")";
			if(mode.equals("subProgramme")){
				totExpPaoQuery+=" and b.subprogramme_code in ('"+subprogramme+"')";
			}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(totExpPaoQuery);
			if (rs1.next()) {
				totExpPao = rs1.getDouble(1);
			}
			stmt1.close();
			rs1.close();
			String totexp=ndf.format((totExpBank+totExpPao)/100000);
		
		%>
			<%if(mode.equals("programme")){ %>
			
			<%if(worksComp!=0){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=compWorks&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>')"><%=worksComp%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=compHabs&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>')"><%=habsCov%></a></td>
			<%} else{%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=worksComp%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCov%></td>
			<%} %>
			
			<%} if(mode.equals("subProgramme")){%>
			
			<%if(worksComp!=0){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=compWorks&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>&subprogName=<%=rs2.getString(4)%>&subprogCode=<%=rs2.getString(3)%>')"><%=worksComp%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=compHabs&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>&subprogName=<%=rs2.getString(4)%>&subprogCode=<%=rs2.getString(3)%>')"><%=habsCov%></a></td>
			<%} else{%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=worksComp%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCov%></td>
			<%} %>
			
			<%} %>
		
		
		<%-- 
		<td class="<%=style%>" style="text-align: right;" align="right"><%=compfinalamount%></td>
		<td class="<%=style%>" style="text-align: right;" align="right"><%=totexp%></td> --%>
		
		
		<%
		/*** End of Completed Related***/ 
		/***tobecomp Related***/ 
		/* String tobecompWorksQuery="select sum(a.SANCTION_AMOUNT),count(a.work_id) from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+ dcode+ "'   and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+") and a.programme_code in ("+ programe+ ") "
				+"  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
				+" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
		if(mode.equals("subProgramme")){
			tobecompWorksQuery+=" and a.subprogramme_code in ('"+subprogramme+"')";
		}
	stmt=conn.createStatement();
	rs=stmt.executeQuery(tobecompWorksQuery);
	if(rs.next()){
		
		tobecompWorks=rs.getInt(2);
		tobecompsacAmount=rs.getDouble(1);
	}
	stmt.close();
	rs.close();
		
		String tobecompHabsQuery="select count(h.hab_code) from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL h where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+dcode+ "'   and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+") and a.programme_code in ("+ programe+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and  h.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
				+" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
		if(mode.equals("subProgramme")){
			tobecompHabsQuery+=" and a.subprogramme_code in ('"+subprogramme+"')";
		}
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery(tobecompHabsQuery);
		if(rs1.next()){
			tobecompHabs=rs1.getInt(1);
		}
		stmt1.close();
		rs1.close();
		String tobecompbankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
				+ dcode
				+ "' and a.type_of_asset in ("+scheme+") and a.programme_code in ("
				+ programe
				+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
				+" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
		tobecompbankLFY += "   and c.GROUNDING_DATE is not null";
		if(mode.equals("subProgramme")){
			tobecompbankLFY+=" and a.subprogramme_code in ('"+subprogramme+"')";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tobecompbankLFY);
		if (rs1.next()) {
			tobecompbankLastYear = rs1.getDouble(1);
		}
		stmt1.close();
		rs1.close();

		String tobecomppaoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
				+ dcode
				+ "' and a.type_of_asset in ("+scheme+") and a.programme_code in ("
				+ programe
				+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null )  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
				+" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
			tobecomppaoFLY += "   and c.GROUNDING_DATE is not null";
			if(mode.equals("subProgramme")){
				tobecomppaoFLY+=" and a.subprogramme_code in ('"+subprogramme+"')";
			}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tobecomppaoFLY);
		if (rs1.next()) {
			tobecomppaoLastYear = rs1.getDouble(1);
		}
		stmt1.close();
		rs1.close();
		double tobecompbankPao=(tobecompbankLastYear + tobecomppaoLastYear) / 100000;
		double tobecompbalAmount=tobecompsacAmount-tobecompbankPao;
		String tobecompfinalamount =ndf.format(tobecompbalAmount); */
		%>
		
		
			<%-- <%if(mode.equals("programme")){ %>
			
			<%if(tobecompWorks!=0){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=tobecompWorks&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>')"><%=tobecompWorks%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=tobecompHabs&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>')"><%=tobecompHabs%></a></td>
			<%} else{%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=tobecompWorks%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=tobecompHabs%></td>
			<%} %>
			
			<%} if(mode.equals("subProgramme")){%>
			
			<%if(tobecompWorks!=0){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=tobecompWorks&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>&subprogName=<%=rs2.getString(4)%>&subprogCode=<%=rs2.getString(3)%>')"><%=tobecompWorks%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=tobecompHabs&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>&subprogName=<%=rs2.getString(4)%>&subprogCode=<%=rs2.getString(3)%>')"><%=tobecompHabs%></a></td>
			<%} else{%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=tobecompWorks%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=tobecompHabs%></td>
			<%} %>
			
			<%} %>
		
		<td class="<%=style%>" style="text-align: right;" align="right"><%=tobecompfinalamount%></td>
		 --%>
		<%
		/*** End of tobecomp Related***/ 
		/**** Total Ongoning****/
		String finalongoingWorksQuery="select sum(a.SANCTION_AMOUNT),count(a.work_id) from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+ dcode+ "'    and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+")  and a.programme_code in ("+ programe+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		if(mode.equals("subProgramme")){
			finalongoingWorksQuery+=" and a.subprogramme_code in ('"+subprogramme+"')";
		}
		stmt=conn.createStatement();
		rs=stmt.executeQuery(finalongoingWorksQuery);
		//System.out.println("ongoingWorksQuery"+finalongoingWorksQuery);
		if(rs.next()){
			
			finalongoingWorks=rs.getInt(2);
			finalongoingsacAmount=rs.getDouble(1);
		}
		stmt.close();
		rs.close();
		
		String finalongoingHabsQuery="select count(h.hab_code) from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL h where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+dcode+ "'   and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+") and a.programme_code in ("+ programe+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and  h.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		if(mode.equals("subProgramme")){
			finalongoingHabsQuery+=" and a.subprogramme_code in ('"+subprogramme+"')";
		}
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery(finalongoingHabsQuery);
		if(rs1.next()){
			finalongoingHabs=rs1.getInt(1);
		}
		stmt1.close();
		rs1.close();
		String finalongoingbankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
				+ dcode
				+ "' and a.type_of_asset in ("+scheme+") and a.programme_code in ("
				+ programe
				+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id ";
		finalongoingbankLFY += "   and c.GROUNDING_DATE is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		if(mode.equals("subProgramme")){
			finalongoingbankLFY+=" and a.subprogramme_code in ('"+subprogramme+"')";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(finalongoingbankLFY);
		if (rs1.next()) {
			finalongoingbankLastYear = rs1.getDouble(1);
		}
		stmt1.close();
		rs1.close();

		String finalongoingpaoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
				+ dcode
				+ "' and a.type_of_asset in ("+scheme+") and a.programme_code in ("
				+ programe
				+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null )  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id ";
		
		finalongoingpaoFLY += "   and c.GROUNDING_DATE is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		if(mode.equals("subProgramme")){
			finalongoingpaoFLY+=" and a.subprogramme_code in ('"+subprogramme+"')";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(finalongoingpaoFLY);
		if (rs1.next()) {
			finalongoingpaoLastYear = rs1.getDouble(1);
		}
		stmt1.close();
		rs1.close();
		double finalongoingbankPao=(finalongoingbankLastYear + finalongoingpaoLastYear + compbalAmount) / 100000;
		finalongoingsacAmount=finalongoingsacAmount+compbalAmount;
		double finalongoingbalAmount=finalongoingsacAmount-finalongoingbankPao;
		String finalongoingfinalamount =ndf.format(finalongoingbalAmount);
		double expong=(finalongoingbankPao-bankPao)+compbankPao;
		%>
		<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(expong)%></td>
		<td class="<%=style%>" style="text-align: right;" align="right"><%=totexp%></td>
		
		<%if(mode.equals("programme")){ %>
		
			<%if(finalongoingWorks!=0){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=totOngoingWorks&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>')"><%=finalongoingWorks%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=totOngoingHabs&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>')"><%=finalongoingHabs%></a></td>
			<%} else{%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=finalongoingWorks%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=finalongoingHabs%></td>
			<%} %>
						
			<%} if(mode.equals("subProgramme")){%>
			
			<%if(finalongoingWorks!=0){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=totOngoingWorks&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>&subprogName=<%=rs2.getString(4)%>&subprogCode=<%=rs2.getString(3)%>')"><%=finalongoingWorks%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=totOngoingHabs&dcode=<%=dcode%>&programmeCode=<%=programe%>&dname=<%=rs2.getString(2)%>&finyear=<%=financialstartyr%>&scheme=<%=scheme%>&progName=<%=rs2.getString(2)%>&subprogName=<%=rs2.getString(4)%>&subprogCode=<%=rs2.getString(3)%>')"><%=finalongoingHabs%></a></td>
			<%} else{%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=finalongoingWorks%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=finalongoingHabs%></td>
			<%} %>
						
			<%} %>
		
		
		<%-- <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(finalongoingbankPao)%></td> --%>
		<td class="<%=style%>" style="text-align: right;" align="right"><%=finalongoingfinalamount%></td>
		
		<%
		/*** End of Ongoing Related***/ 
		
		totongoingHabs=totongoingHabs+ongoingHabs;
		totongoingWorks=totongoingWorks+ongoingWorks;
		tottargetHabs=tottargetHabs+targetHabs;
		tottargetWorks=tottargetWorks+targetWorks;
		totworksComp=totworksComp+worksComp;
		tothabsCov=tothabsCov+habsCov; 
		totOngoingBalEstCost=totOngoingBalEstCost+balAmount;
		totTargetBalEstCost=totTargetBalEstCost+targetbalAmount;
		totCompExp=totCompExp+expong;
		totCompBalEstCost=totCompBalEstCost+compbalAmount;
		totExpBankPlusPao=totExpBankPlusPao+totExpBank+totExpPao;
		/* tottobecompHabs=tottobecompHabs+tobecompHabs;
		tottobecompWorks=tottobecompWorks+tobecompWorks;
		tottobecompBalEstCost=tottobecompBalEstCost+tobecompbalAmount; */
		totfinalongoingHabs=totfinalongoingHabs+finalongoingHabs;
		totfinalongoingWorks=totfinalongoingWorks+finalongoingWorks;
		totfinalOngoingBalEstCost=totfinalOngoingBalEstCost+finalongoingbalAmount;
		totfinalOngoingExp=totfinalOngoingExp+finalongoingbankPao;
			}
		}
		stmt2.close();
		rs2.close();
		 if(slno==0){ %>
		<tr><td class="gridhdbg" colspan=14 align="center"><font color="red" size="4">No Records Found</font></td></tr>
		<%} %>
		<tr>
			<td class="gridhdbg" style="text-align: right;" colspan=2>Total:</td>
			<td class="gridhdbg" style="text-align: right;"><%=totongoingWorks%></td>
			<td class="gridhdbg" style="text-align: right;"><%=totongoingHabs%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totOngoingBalEstCost)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=tottargetWorks%></td>
			<td class="gridhdbg" style="text-align: right;"><%=tottargetHabs%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totTargetBalEstCost)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=totworksComp%></td>
			<td class="gridhdbg" style="text-align: right;"><%=tothabsCov%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totCompExp)%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpBankPlusPao/100000)%></td>
			<%-- <td class="gridhdbg" style="text-align: right;"><%=tottobecompWorks%></td>
			<td class="gridhdbg" style="text-align: right;"><%=tottobecompHabs%></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(tottobecompBalEstCost)%></td> --%>
			<td class="gridhdbg" style="text-align: right;"><%=totfinalongoingWorks%></td>
			<td class="gridhdbg" style="text-align: right;"><%=totfinalongoingHabs%></td>
			<%-- <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totfinalOngoingExp)%></td> --%>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totfinalOngoingBalEstCost)%></td>
			
		</tr>
		<%
	}
	catch(Exception e){
		e.printStackTrace();
	}
	%>		


</table>	
<table  cellspacing=0 cellpadding=0 width="60%"
	bordercolor=#000000  bgcolor="#ffffff"
	align="center">
<tr align="left">
		<td ><font color="red">Note:</font></td>
		</tr>
		<tr>
		<td ><font color="green" size="1">1. Ongoing Works count includes only the works with probable date of completion in current Financial Year</font></td>
		</tr>
		<tr>
		<td ><font color="green" size="1">2. Only the works which are grounded and having mile stones taken into count</font></td>
		</tr>
</table>
</body>
</html>