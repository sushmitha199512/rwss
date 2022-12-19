<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%
DecimalFormat ndf = new DecimalFormat("####.00");
WorksData1 data1 = new WorksData1();
int cyear = Calendar.getInstance().get(Calendar.YEAR);
int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
int lMonth = Calendar.getInstance().get(Calendar.MONTH);
int day = Calendar.getInstance().get(Calendar.DATE);
String currentMonth = data1.getCurrentMonth(month);
String lastMonth = "";
if (currentMonth.equals("JAN")) {
	lastMonth = "DEC-" + (cyear - 1);
} else {
	lastMonth = data1.getCurrentMonth(lMonth) + "-" + cyear;
}
String cDate = day + "-" + currentMonth + "-" + cyear;
int yearStart = 0;
int yearEnd = 0;
if (month <= 3) {
	yearStart = cyear - 1;
	yearEnd = cyear;
} else {
	yearStart = cyear;
	yearEnd = cyear + 1;
}
HashMap programmeList = new HashMap();

String progCode = "";
String nrdwpQuery = "select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
Statement statement = conn.createStatement();
ResultSet resultSet = statement.executeQuery(nrdwpQuery);
while (resultSet.next()) {
	if (!progCode.equals("")) {
		progCode = progCode + "," + resultSet.getString(1);
	} else {
		progCode = resultSet.getString(1);
	}
}
programmeList.put(1, "65");
programmeList.put(2, "57");
programmeList.put(3, "04");
programmeList.put(4, progCode);
resultSet.close();
statement.close();

%>
<script language="JavaScript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
</script>
<body>
<form name=f1 method="post">
	<table border=1 cellspacing=0 cellpadding=0 height=5% width="70%" bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff" align="center">
		<caption>
		<table border=0 rules=none style="border-collapse: collapse" align="right">
			<tr align="right">
				<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|&nbsp;</a></td>
				<td class="bwborder"><a	href="javascript:onclick=history.go(-1)">Back</a>&nbsp;&nbsp;</td>
			</tr>
		</table>
		</caption>
		<tr align=center align=center>
			<td class="gridhdbg" colspan="17"><b>Work Load for <%=yearStart%>-<%=yearEnd%></b></td>
		</tr>
		<tr align=center align=center>
			<td class=gridhdbg rowspan=2>Sl.No</td>
			<td class=gridhdbg rowspan=2>Programme</td>
			<td colspan=4 class=gridhdbg align="center">Spill Over works as on <br> 01.04.<%=yearStart%></td>
			<td colspan=4 class=gridhdbg align="center">New works sanctioned in<br><%=yearStart%>-<%=yearEnd%></td>
			<td colspan=4 class=gridhdbg align="center">Total Ongoing works in<br><%=yearStart%>-<%=yearEnd%></td>
			<td colspan=2 class=gridhdbg align="center">Financial Pending</td>
			<td class=gridhdbg rowspan=2>Total Commitment</td>
		</tr>
		<tr>
			<td colspan=1 class=gridhdbg align="center">No of Works</td>
			<td colspan=1 class=gridhdbg align="center">Habs Sanctioned</td>
			<td colspan=1 class=gridhdbg align="center">Population</td>
			<td colspan=1 class=gridhdbg align="center">Bal.Est.Cost</td>
			<td colspan=1 class=gridhdbg align="center">No of Works</td>
			<td colspan=1 class=gridhdbg align="center">Habs Sanctioned</td>
			<td colspan=1 class=gridhdbg align="center">Population</td>
			<td colspan=1 class=gridhdbg align="center">Cost</td>
			<td colspan=1 class=gridhdbg align="center">No of Works</td>
			<td colspan=1 class=gridhdbg align="center">Habs Sanctioned</td>
			<td colspan=1 class=gridhdbg align="center">Population</td>
			<td colspan=1 class=gridhdbg align="center">Cost</td>
			<td colspan=1 class=gridhdbg align="center">Works</td>
			<td colspan=1 class=gridhdbg align="center">Amount</td>
		</tr>
		<%
		int styleCount = 0;
		String style = "";
		int slno=0;	
		String query="",hab_query="",banksendQuery="",bankpaos="",query_new="",new_hab_query="",Financial_qry="",fin_banksendQuery="",fin_bankpaos="";
		Statement stmt1=null,stmt2=null;
		ResultSet rs1=null,rs2=null;
		Double sanction_amount=0.0,finalBal=0.0,new_work_amt=0.0;
		int no_works=0,new_works=0,habs=0,new_habs=0,pop=0,new_pop=0,fin_works=0;
		Double banksendAmount=0.0,bankpaoAmt=0.0,fin_amount=0.0,fin_banksendAmount=0.0,fin_bankpaoAmt=0.0,not_finalBal=0.0;	
		int tot_no_works=0,tot_new_works=0,tot_habs=0,tot_new_habs=0,tot_pop=0,tot_new_pop=0,tot_fin_works=0;
		Double tot_new_work_amount=0.0,tot_fin_amount=0.0,tot_not_finalBal=0.0;	
		try{			
		String programme = "";
		for (int i = 1; i <= programmeList.size(); i++){
			programme = (String) programmeList.get(i);
		    String programmeName = "";
		    if (programme.length() > 2) {
		        programmeName = "NRDWP";
           	} else {
             	String programmeQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where PROGRAMME_CODE='"+ programme + "'";
             	Statement statement1 = conn.createStatement();
             	ResultSet resultSet1 = statement1.executeQuery(programmeQuery);
             	if (resultSet1.next()) {
             		programmeName = resultSet1.getString("PROGRAMME_NAME");
             	}
             	resultSet.close();
             	statement.close();
             	}
                if (styleCount % 2 == 0) {
			        style = "gridbg1";
				} else {
					style = "gridbg2";
				}
				styleCount++;
		%>
		<tr>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
			<td class="<%=style%>" style="text-align: left;" align="left"><a href="./rws_work_load_div_sub_div_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=programmeName%>"><%=programmeName%></td>
		<%
		query = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2)  in ('01','02','03') "
				+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme
				+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id ";
		//System.out.println("query"+query);	
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(query);
		if(rs1.next())
		{
		  sanction_amount=rs1.getDouble("SANCTION_AMOUNT");
		  no_works=rs1.getInt("works");
	    %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=no_works%></a></td>
		<%
		}
		tot_no_works+=no_works;
		rs1.close();
		stmt1.close();
	    hab_query = "select count(hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2) in ('01','02','03') "
				+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme
				+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and hab.work_id=a.work_id and  hab.hab_code=h.hab_code";
	    System.out.println("hab_query"+hab_query)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(hab_query);
		if(rs2.next()){
			habs=rs2.getInt("habs");
			pop=rs2.getInt("pop");
		%>
		  <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=habs%></a></td>
		  <td class="<%=style%>" style="text-align: right;" align="right"><%=pop%></td>
		<%
		}
		tot_habs+=habs;
		tot_pop+=pop;
		rs2.close();
		stmt2.close();
		banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2) in ('01','02','03') and BANK_SEND_DATE<='"+cDate+"'"
				+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme
				+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and b.work_id=a.work_id ";
		//System.out.println("banksendQuery"+banksendQuery)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(banksendQuery);
		while(rs2.next()){
			banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
		}
		rs2.close();
		stmt2.close();
		bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2)  in ('01','02','03') and STATE_SEND_DATE<='"+cDate+"'"
				+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme 
				+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and b.work_id=a.work_id ";		
		// System.out.println("bankpaos"+bankpaos)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(bankpaos);
		if(rs2.next()){
			bankpaoAmt=rs2.getDouble("BILL_AMOUT_STATE");
		}
		rs2.close();
		stmt2.close();
		finalBal=(sanction_amount*100000)-(banksendAmount + bankpaoAmt);
		tot_fin_amount+=finalBal;
		%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(finalBal/100000)%></td>
		<%
		query_new = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2)  in ('01','02','03') "
				+ " and a.ADMIN_DATE >=to_date('01/04/"+yearStart+"','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+  programme
				+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id ";
		//System.out.println("query_new"+query_new)	;	
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(query_new);
		if(rs1.next())
		{
		  new_work_amt=rs1.getDouble("SANCTION_AMOUNT");
		  new_works=rs1.getInt("works");
		  %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=new_works%></a></td>
		  <%
		}
		tot_new_works+=new_works;
		rs1.close();
		stmt1.close();
	    new_hab_query = "select count(hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2) in ('01','02','03') "
				+ " and a.ADMIN_DATE >=to_date('01/04/"+yearStart+"','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme
				+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and hab.work_id=a.work_id and  hab.hab_code=h.hab_code";
	   // System.out.println("new_hab_query"+new_hab_query)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(new_hab_query);
		if(rs2.next()){
			new_habs=rs2.getInt("habs");
			new_pop=rs2.getInt("pop");
		%>		
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=new_habs%></a></td>
		<td class="<%=style%>" style="text-align: right;" align="right"><%=new_pop%></td>
		<%
		}
		tot_new_habs+=new_habs;
		tot_new_pop+=new_pop;
		rs2.close();
		stmt2.close();
		tot_new_work_amount+=new_work_amt;
		%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(new_work_amt/100000)%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=no_works+new_works%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=habs+new_habs%></a></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=pop+new_pop%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((new_work_amt+finalBal)/100000)%></td>
		<%
		Financial_qry="select count(a.work_id) as works,sum(a.sanction_amount) as sanction_amount from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2) in ('01','02','03') "
						+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id ";
		System.out.println("Financial_qry"+Financial_qry);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(Financial_qry);
		if(rs2.next()){
			fin_works=rs2.getInt("works");
			fin_amount=rs2.getDouble("sanction_amount");
			%>		
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=fin_works%></a></td>
			<%
			}
			tot_fin_works+=fin_works;
			rs2.close();
			stmt2.close();
			fin_banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) in ('01','02','03') and BANK_SEND_DATE<='"+cDate+"'"
					+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme
					+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and b.work_id=a.work_id ";
			//System.out.println("fin_banksendQuery"+fin_banksendQuery);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(banksendQuery);
			while(rs2.next()){
				fin_banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
			}
			rs2.close();
			stmt2.close();
			fin_bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2)  in ('01','02','03') and STATE_SEND_DATE<='"+cDate+"'"
					+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme 
					+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and b.work_id=a.work_id ";		
			 //System.out.println("fin_bankpaos"+fin_bankpaos);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(bankpaos);
			if(rs2.next()){
				fin_bankpaoAmt=rs2.getDouble("BILL_AMOUT_STATE");
			}
			rs2.close();
			stmt2.close();
			not_finalBal=(fin_amount*100000)-(fin_banksendAmount + fin_bankpaoAmt);
			tot_not_finalBal+=not_finalBal;
			%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(not_finalBal/100000) %> </td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((new_work_amt+finalBal+not_finalBal)/100000) %></td>
		</tr>
		
		<%	
		}%>
		<tr >
		<td class=btext style="text-align: right;" colspan="2">Total </td>
		<td class="btext" style="text-align: right;" ><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=spill&programme=All')"><%=tot_no_works %></a></td>
		<td class="btext" style="text-align: right;" ><%=tot_habs %> </td>
		<td class="btext" style="text-align: right;" ><%=tot_pop %> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format(tot_fin_amount/100000)%> </td>
		<td class="btext" style="text-align: right;" ><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=new&programme=All')"><%=tot_new_works %></a> </td>
		<td class="btext" style="text-align: right;" ><%=tot_new_habs %> </td>
		<td class="btext" style="text-align: right;" ><%=tot_new_pop %> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format(tot_new_work_amount/100000)%> </td>
		<td class="btext" style="text-align: right;" ><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=All')"><%=tot_no_works+tot_new_works %> </td>
		<td class="btext" style="text-align: right;" ><%=tot_habs+ tot_new_habs%> </td>
		<td class="btext" style="text-align: right;" ><%=tot_pop+tot_new_pop %> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format((tot_fin_amount+tot_new_work_amount)/100000)%> </td>
		<td class="btext" style="text-align: right;" ><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=All')"><%=tot_fin_works%></a> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format(tot_not_finalBal/100000) %> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format((tot_fin_amount+tot_new_work_amount+tot_not_finalBal)/100000)%> </td>
		
		</tr>
		<%
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			%>
		</table>
		</form>			
</body>