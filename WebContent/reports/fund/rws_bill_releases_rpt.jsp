<%@ page
	import="java.text.DecimalFormat,java.math.BigDecimal,java.text.NumberFormat"%>
<%@ include file="/reports/conn.jsp"%>
<%@ include file="/commons/rws_header1.jsp"%>

<%@ include file="/commons/rws_session_validation.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
<%
	long billAmtTot = 0;
	int sno = 0;
	String pcode = request.getParameter("pcode");
	if (pcode != null) {
		session.setAttribute("pcode", pcode);
	}

	NumberFormat formatter = new DecimalFormat("#0.00");
	String per = request.getParameter("per");
	if (per != null) {
		session.setAttribute("per", per);
	}

	String division = request.getParameter("division");
	//System.out.println("division :"+division);
	if (division != null) {
		session.setAttribute("division", division);
	}
	if(request.getParameter("programme") != null && request.getParameter("programme").trim().length()>0){
		session.setAttribute("programme", request.getParameter("programme"));
	}
	if(request.getParameter("finyear") != null && request.getParameter("finyear").trim().length()>0){
		session.setAttribute("finyear", request.getParameter("finyear"));
		
	}
	if(request.getParameter("finmonth") != null && request.getParameter("finmonth").trim().length()>0){
		session.setAttribute("finmonth", request.getParameter("finmonth"));
		
	}
	
	if (per == null)
		per = "";
	if (division == null)
		division = "";
	
	String selectedYear = null,selectedMonth = null;
	 int cyear = Calendar.getInstance().get(Calendar.YEAR);
	 int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
	// String cDate = day + "-" + currentMonth + "-" + cyear;
	
	    int yearStart = 0;
	    int yearEnd = 0;
	    //String y=""; 
	    if(request.getParameter("finyear")!=null && request.getParameter("finyear").trim().length()>0){
	    	//System.out.println("fin year :"+request.getParameter("finyear"));
	    	//y=request.getParameter("finyear");
	    yearStart = Integer.parseInt(request.getParameter("finyear"));
	    yearEnd = yearStart + 1;
	    }
	   /*  else{
	    	if (month <= 3) {
	            yearStart = cyear - 1;
	            yearEnd = cyear;
	        } else {
	            yearStart = cyear;
	            yearEnd = cyear + 1;
	        }
	    } */
	    int	startFinYear = cyear;

	    String[] months  = {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
%>
<html>
<script type="text/javascript"
	src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css"
	type="text/css">

<style>
#input_box {
	background-color: #C9DFF4;
	font-weight: bold;
}
</style>
<style>
.diva {
	width: 14px;
	height: 14px;
	clip: rect(0, 14, 14, 0);
	overflow: hidden;
}

.spana {
	background-color: red;
	position: relative;
	top: -3px;
	left: -3px;
}

.checka {
	margin: 0;
	padding: 0;
	FILTER: progid:DXImageTransform.Microsoft.Alpha(style=0, opacity=50)
		-moz-opacity:0.1;
}
</style>

<script language="javascript">
	function getBills() {
		//	alert("aaaaa");
		var per = document.forms[0].per.value;
		if (per == "") {
			alert("Please Select Any District or ALL option");
			return false;
		} else {
			document.forms[0].action = "rws_bill_releases_rpt.jsp?per="
					+ document.forms[0].per.value;
			document.forms[0].submit();
		}
	}
</script>
<link rel="stylesheet" type="text/css"
	href="<rws:context page='/resources/style/table.css'/>">
<body bgcolor="#edf2f8">
	<!-- onload="init()" -->
	<script language="JavaScript"
		src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
	<form method="post">
		<BR>
		<BR>
		<table border=0 align="right">
			<caption>
				<table border=0 rules=none style="border-collapse: collapse">
					<tr>
					<!-- ../images/excel_icon.jpg -->
						<td align="right" class="bwborder"><a
							href="<rws:context page='/home.jsp'/>">Home</a>|<a
							href="rws_bill_releases_rpt_excel.jsp" target="_new">&nbsp;&nbsp;<img
							
								src="<rws:context page='/images/excel_icon.jpg'/>" width="30" height="30"></a></td>
					</tr>
				</table>
			</caption>
		</table>
		<table align="center" border=0 width=65%>
			<tr align="center">
				<td class="rptHeading" style="width: 50%" align="center">BANK -
					Payment Due and Releases Entry Form</td>
				<td class="rptHeading" style="width: 50%" align="center"><font
					face=verdana size=2 color=red>(Amount Displayed is in
						Rupees)</font><b style="font-family: Rupee Foradian;">`</b></td>
			</tr>
		</table>
		<%
			DecimalFormat ndf = new DecimalFormat("####.00");
			double grandtotPaidThisBill = 0.0, grandpaototPaidThisBill = 0.0;
			double totPaidThisBill = 0.0, paototPaidThisBill = 0.0;
			double total = 0.0, gtotal = 0.0;
			double actualtot = 0.0;
			Statement st1 = null;
			Statement st2 = null;
			Statement st3 = null;
			Statement st4 = null;
			Statement st5 = null;
			Statement st6 = null;
			Statement stt = null;
			Statement stmtN = null;

			ResultSet rss = null, rs1 = null, rs2 = null,  rs4 = null, rs5 = null, rs6 = null, rsN = null;
			try {
				st4 = conn.createStatement();
				rs4 = st4
						.executeQuery("select circle_office_code,circle_office_name from rws_circle_office_tbl order by circle_office_name");
		%>
	<table style="margin-left: auto; margin-right: auto; width: 65%" align="center">
	<tr align="center">
	<td style="margin-left: auto; margin-right: auto; ">
	
		
			<font face=verdana size=2><b>Select Circle : </b></font><select
				name="per" class="mycombo" onchange="getBills()">
					<option value="">-Select-</option>
					<%
						if (per != null && per.equals("ALL")) {
					%>
					<!-- <option value="ALL" selected>ALL</option> -->
					<%
						} else if (per != null && !per.equals("ALL")) {
					%>
					<!-- <option value="ALL">ALL</option> -->
					<%
						}
							while (rs4.next()) {
								if (per != null && per.equals(rs4.getString(1))) {
					%>
					<option value="<%=rs4.getString(1)%>" selected><%=rs4.getString(2)%></option>
					<%
						} else if (per != null && !per.equals(rs4.getString(1))) {
					%>
					<option value="<%=rs4.getString(1)%>"><%=rs4.getString(2)%></option>
					<%
						}
							}
					%>
			</select> <%
 	if (per != null && !per.equals("ALL")) {
 			Statement stNew = conn.createStatement();
 			ResultSet rsNew = stNew
 					.executeQuery("select division_office_code,division_office_name from  rws_division_office_tbl div  where div.circle_office_code ='"
 							+ per + "' order by 1");
 %> <font face=verdana size=2>&nbsp;<b>Select Division :</b> </font><select
					name="division" class="mycombo" >
						<option value="">-Select-</option>
						<%
							while (rsNew.next()) {
										if (division != null
												&& division.equals(rsNew.getString(1))) {
						%>
						<option value="<%=rsNew.getString(1)%>" selected><%=rsNew.getString(2)%></option>
						<%
							} else if (division != null
												&& !division.equals(rsNew.getString(1))) {
						%>
						<option value="<%=rsNew.getString(1)%>"><%=rsNew.getString(2)%></option>
						<%
							}
									}
								}
						%>
				</select>
				</td><td>
				<%
				String programmeQry = "select PROGRAMME_CODE,PROGRAMME_NAME from RWS_PROGRAMME_TBL order by PROGRAMME_NAME";
				Statement stNew = conn.createStatement();
				ResultSet rsNew = stNew.executeQuery(programmeQry);
				String selectedProgramme=request.getParameter("programme");
				//System.out.println("programme :"+selectedProgramme);
				%>
				<font face=verdana size=2>&nbsp;<b>Select Program :</b></font> <select
					name="programme" id="programme" class="mycombo" >
						<option value="">-Select-</option>
						<%
						while (rsNew.next()) {
					
							if (selectedProgramme != null
									&& selectedProgramme.equals(rsNew.getString(1))) {
						//System.out.println("in if start year :"+startFinYear+" finYear :"+temp);
						%>
						<option value=<%= rsNew.getString(1) %> selected ><%= rsNew.getString(2) %></option>
						<%
					}else
					{
					%>
					<option value=<%= rsNew.getString(1) %>><%= rsNew.getString(2) %></option>
					<%}
					
					
				}%>
				</select>
				</td>
				</tr>
				<tr>
				<td>
				<font face=verdana size=2>&nbsp;<b>Select Year :</b></font> <select
					name="finyear" id="finyear" class="mycombo" >
						<option value="">-Select-</option>
						<%
					int endFinYear = 2011;
				int temp=0;
				String finYear=request.getParameter("finyear");
				while(startFinYear>=endFinYear){
					
					//System.out.println("start year :"+startFinYear+" finYear :"+finYear);
					if(finYear != null && finYear.trim().length()>0 &&  !finYear.equals("0") ){
						temp = Integer.parseInt( finYear);
						
					}
					
					if(startFinYear == temp ){
						//System.out.println("in if start year :"+startFinYear+" finYear :"+temp);
						%>
						<option value=<%= String.valueOf(startFinYear) %> selected ><%= String.valueOf(startFinYear) %></option>
						<%
					}else
					{
					%>
					<option value=<%= String.valueOf(startFinYear) %>><%= String.valueOf(startFinYear) %></option>
					<%}
					
					startFinYear--;
				}%>
				</select>
				</td>
				<td>
				<font face=verdana size=2>&nbsp;<b>Select Month :</b></font> <select
					name="finmonth" id="finmonth" class="mycombo" >
						<option value="">-Select-</option>
						<%
				String finmonth=request.getParameter("finmonth");
				for(int k=0;k<months.length;k++){
					
					if(finmonth != null && months[k].equals(finmonth) ){
						//System.out.println("in if start year :"+startFinYear+" finYear :"+temp);
						%>
						<option value=<%= months[k] %> selected ><%= months[k] %></option>
						<%
					}else
					{
					%>
					<option value=<%= months[k] %>><%= months[k] %></option>
					<%}
					
					
				}%>
				</select>
	
		</td>
	</tr>
	<tr align="center" style="width: 100%">
	<td align="center" >
	 <input type="button" value="Get Bills" onClick="getBills()"
					class="btext" align="center">
					</td>
	</tr>
	</table>
		</br>
		</br>
		<%
			st1 = conn.createStatement();
				st2 = conn.createStatement();
				st6 = conn.createStatement();
				String dquery = "", dquery1 = "", dquery2 = "",progQry = "",yearQry="",monQry="";

				if (per != null && per.equals("ALL") && division != null
						&& division.equals("ALL")) {
					dquery = "";
					dquery1 = "";
					dquery2 = "";
				} else {
					dquery = " and substr(b.work_id,5,2)='" + per + "'";
					if (!division.equals("ALL"))
						dquery += " and substr(b.office_code,4,1)='" + division
								+ "' ";
					dquery1 = " where substr(work_id,5,2)='" + per + "'";
					dquery2 = " where substr(work_id,5,2) <> '" + per + "'";

					//dquery = " and substr(b.work_id,5,2)='"+per+"' and substr(b.office_code,2,2)='"+per+"' and substr(b.office_code,4,1)='"+division+"'";
					//dquery1 = " where  substr(work_id,5,2)='"+per+"' and substr(office_code,2,2)='"+per+"' and substr(office_code,4,1)='"+division+"'";
					//dquery2 = " where substr(work_id,5,2) <> '"+per+"'";
				}
				if(request.getParameter("programme") != null && request.getParameter("programme").trim().length()>0){
					progQry = " and b.PROGRAMME_CODE = p.PROGRAMME_CODE and p.PROGRAMME_CODE='"+request.getParameter("programme")+"' ";
				}
				if(request.getParameter("finyear") != null && request.getParameter("finyear").trim().length()>0){
					yearQry = " and to_char(a.BILL_DATE,'YYYY')='"+temp+"' ";
					
				}
				if(request.getParameter("finmonth") != null && request.getParameter("finmonth").trim().length()>0){
					monQry = " and to_char(a.BILL_DATE,'MON')='"+request.getParameter("finmonth")+"' ";
					
				}
				//if()

				/* stmtN = conn.createStatement();
				String totReleasedAmount="select work_id, sum(BILL_AMOUNT_CENTRAL) from RWS_bill_bank_bridge_det_TBL b where  b.TXID is not null "+dquery+"  group by b.work_id";
				rsN=stmtN.executeQuery(totReleasedAmount);
				//System.out.println("totReleasedAmount"+totReleasedAmount);
				Hashtable releasedHash=new Hashtable();
				while(rsN.next()){releasedHash.put(rsN.getString(1),rsN.getString(2));}
				if(stmtN!=null){
					stmtN.close();
				}
				if(rsN!=null){
					rsN.close();
				}
				//query for pao amount
				
				stmtN = conn.createStatement();
				String totPaoReleasedAmount="select work_id,BILL_SL_NO,sum(BILL_AMOUT_STATE) from RWS_bill_pao_bridge_det_TBL b where  b.STATE_TXID  is not null "+dquery+"  group by b.work_id,BILL_SL_NO";
				rsN=stmtN.executeQuery(totPaoReleasedAmount);
				//System.out.println("totPaoReleasedAmount"+totPaoReleasedAmount);
				Hashtable PaoreleasedHash=new Hashtable();
				while(rsN.next()){PaoreleasedHash.put(rsN.getString(1)+rsN.getString(2),rsN.getString(3));}
				if(stmtN!=null){
					stmtN.close();
				}
				if(rsN!=null){
					rsN.close();
				}
				
				Statement paoTemStmt=conn.createStatement();
				String paoTempQuery="select WORK_ID ,BILL_SL_NO,BILL_AMOUT_STATE from rws_bill_pao_bridge_temp_tbl where substr(office_code,2,2)='"+per+"' and substr(office_code,4,1)='"+division+"'";
				
				rsN=paoTemStmt.executeQuery(paoTempQuery);
				
				Hashtable paoTempHash=new Hashtable();
					
					while(rsN.next()){
						paoTempHash.put(rsN.getString(1)+rsN.getString(2),rsN.getString(3));	
						
					}
					if(paoTemStmt!=null){
						paoTemStmt.close();
					}
					if(rsN!=null){
						rsN.close();
					}
				
				

				/***********************************Contractor Selection Condition  *******************/

				/*	stmtN = conn.createStatement();
						
						String contractorSel="select a.work_id,a.contractor_code,nvl(CONTRACTOR_NAME_COMPANY,'') as c1,nvl(CONTRACTOR_COMPANY_NAME1,'') c2 from rws_contractor_selection_tbl a,rws_work_admn_tbl b,rws_contractor_tbl c  where a.work_id=b.work_id and a.contractor_code=c.contractor_code "+dquery;
						
						//System.out.println("contractorSel:"+contractorSel);
						rsN=stmtN.executeQuery(contractorSel);
						
					Hashtable contractHash=new Hashtable();
						
						while(rsN.next()){
							contractHash.put(rsN.getString(1),rsN.getString(2)+"@"+rsN.getString(3)+"@"+rsN.getString(4));	
							
						}
						if(stmtN!=null){
							stmtN.close();
						}
						if(rsN!=null){
							rsN.close();
						}

				
				
						
						
					String q1 = "select work_id,bill_sl_no,nvl(sum(bill_amout_state),0),nvl(sum(bill_amount_central),0) from rws_bill_bank_bridge_tbl "+dquery1+" group by work_id,bill_sl_no";
						
						//System.out.println("Q1:"+q1);
						rs1 = st1.executeQuery(q1);
						Hashtable ht1 = new Hashtable();
						while(rs1.next())
						{
							ht1.put(rs1.getString(1)+rs1.getString(2),rs1.getString(3)+"@"+rs1.getString(4)); 
						}
						
						String q2 = "select work_id,bill_sl_no,bill_amout_state,bill_amount_central from rws_bill_bank_bridge_temp_tbl "+dquery1+"";
						rs2 = st2.executeQuery(q2);
						Hashtable ht2 = new Hashtable();
						int billCount = 0;
						long billAmt = 0;
						while(rs2.next())
						{
							ht2.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
							billCount++;
							billAmt += Double.parseDouble(rs2.getString(3))+Double.parseDouble(rs2.getString(4));
						}
						
						String q33 = "select sum(bill_amout_state+bill_amount_central) from rws_bill_bank_bridge_temp_tbl "+dquery2+"";
						rs6 = st6.executeQuery(q33);

						if(rs6.next())
						{
							if(rs6.getString(1)!=null && !rs6.getString(1).equals(""))
								billAmtTot += Double.parseDouble(rs6.getString(1));
						} */
				String qry = "select d.circle_office_name,sd.division_office_name,b.work_id,work_name,admin_no,to_char (admin_date,'dd/mm/yyyy'),sanction_amount*100000 as samtt,programme_name,subprogramme_name,bill_no,to_char (bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,(nvl(STATE_SHARE,0)*bill_amt_admissible)/100, (nvl(CENTRAL_SHARE,0)*bill_amt_admissible)/100,p.programme_code,nvl(STATE_SHARE,0)STATE_SHARE,nvl(CENTRAL_SHARE,0)CENTRAL_SHARE,bill_sl_no,'1'||d.circle_office_code||sd.division_office_code||'00' office_code,to_char (a.update_date,'dd/mm/yyyy') as update_date, nvl(to_char(ee_fwd_date,'dd/mm/yyyy'),'') as ee_fwd_date,length(PASS_ORDER_SCAN_COPY) as pCopy,bill_type as billType  from rws_work_bill_tbl a,rws_work_admn_tbl b,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_circle_office_tbl d,rws_division_office_tbl sd where  nvl(to_char(ee_fwd_date,'dd/mm/yyyy'),'') is NOT NULL and substr(b.office_code,2,2) =d.circle_office_code and d.circle_office_code=sd.circle_office_code and substr(b.office_code,2,2) =sd.circle_office_code and substr (b.office_code,4,1)=sd.division_office_code and b.programme_code=p.programme_code and p.programme_code=sp.programme_code and b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code and a.work_id=b.work_id and bill_sl_no<>0 "
						+ dquery +progQry +yearQry+monQry
						+ "  and b.block_payment<>'Y' and a.bill_type='B'  order by nvl(to_date(ee_fwd_date,'dd/mm/yyyy'),'') desc";//and rownum<100 -- and a.work_id='49010501110018' and a.work_id='49010501110018' a.work_id='49010501110018' 
				
						//						+ "  and b.block_payment<>'Y' and a.bill_type='B' and length(a.pass_order_scan_copy)>0 order by nvl(to_date(ee_fwd_date,'dd/mm/yyyy'),'') desc";//and rownum<100 -- and a.work_id='49010501110018' and a.work_id='49010501110018' a.work_id='49010501110018' 

						//System.out.println("main aa:" + qry);
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
				rs = stmt.executeQuery(qry);
				int count = 1;
		%>
		<table align=left>
			<tr>
				<td class=rptValue></td>
			</tr>
		</table>
		</br>
		</br>
		<table border=1 align=center bordercolor=black
			style="border-collapse: collapse">
			<tr align="center">
				<td class=gridhdbg rowspan="2">Sl. No.</td>
				<!-- <td class=gridhdbg rowspan="2">Circle</td> -->
				<td class=gridhdbg rowspan="2">Division</td>
				<td class=gridhdbg rowspan="2">Work ID/<BR>Work Name / <BR>Agency
					Name
				</td>
				<!-- <td class=gridhdbg rowspan="2">Admin No</td> -->
				<td class=gridhdbg rowspan="2">Sanction Amount/<BR>Program/<BR>Sub
					Program
				</td>
				<td class=gridhdbg rowspan="2">Bill<BR>No/<BR>Bill
					Date/<BR>Bill Entered Date/<BR>EE FWD Date
				</td>
				<td class=gridhdbg rowspan="2">Bill Amt <BR>Contractor/<br>Bill
					Amt <BR>Admissible
				</td>
				<td class=gridhdbg colspan="3">Amount So Far Released.</td>
				<td class=gridhdbg rowspan="2">Actual(Now recommended)</td>
			</tr>
			<tr>
				<td class=gridhdbg>Bank</td>
				<td class=gridhdbg>PAO</td>
				<td class=gridhdbg>Total</td>
			</tr>
			<%
				String val = "";
					int styleCount = 0;
					String style = "";
					String contractorName = "",actualAmt="--";
					double stateAmount=0.0,centralAmt=0.0,totalAmount=0.0,totStateAmount=0.0,totCentralAmt=0.0,totTotalAmount=0.0,totActualAmt=0.0;

					while (rs.next()) {
						
						boolean Cflag = false;
						boolean paoFlag = false;
						if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
						boolean flag = true;
						stmtN = conn.createStatement();
						String contractorSel = "select a.contractor_code,nvl(CONTRACTOR_NAME_COMPANY,'') as c1,nvl(CONTRACTOR_COMPANY_NAME1,'') c2 from rws_contractor_selection_tbl a,rws_contractor_tbl c  where a.work_id='"+rs.getString("WORK_ID") +"' and a.contractor_code=c.contractor_code ";
						//System.out.println("contractorSel:"+contractorSel);
						rsN = stmtN.executeQuery(contractorSel);
						if (rsN.next()) {
							contractorName = rsN.getString("c1");
							if(contractorName.equals(""))
								contractorName = rsN.getString("c2");
						}
							stmtN.close();
							rsN.close();
							
							stmtN = conn.createStatement();
							String totReleasedAmount="select  sum(BILL_AMOUNT_CENTRAL),COUNT(b.work_id) from RWS_bill_bank_bridge_det_TBL b where  b.TXID is not null and b.bill_activation_flag='P' and b.bill_sl_no='"+rs.getString("BILL_SL_NO")+"' and b.work_id='"+rs.getString("WORK_ID") +"'";
							rsN=stmtN.executeQuery(totReleasedAmount);
							//System.out.println("totReleasedAmount"+totReleasedAmount);
							
							if(rsN.next()){
								centralAmt = rsN.getDouble(1);
								totCentralAmt = totCentralAmt+centralAmt;
								
								}
							if(stmtN!=null){
								stmtN.close();
							}
							if(rsN!=null){
								rsN.close();
							}
							//query for pao amount
							
							stmtN = conn.createStatement();
							String totPaoReleasedAmount="select sum(BILL_AMOUT_STATE),COUNT(b.work_id) from RWS_bill_pao_bridge_det_TBL b where  b.STATE_TXID  is not null and b.BILL_ACTIVATION_FLAG='P' and b.bill_sl_no='"+rs.getString("BILL_SL_NO")+"' and b.work_id='"+rs.getString("WORK_ID") +"'";
							rsN=stmtN.executeQuery(totPaoReleasedAmount);
							//System.out.println("totPaoReleasedAmount"+totPaoReleasedAmount);
							
							if(rsN.next()){stateAmount = rsN.getDouble(1);
							totStateAmount=stateAmount+totStateAmount;
							}
							if(stmtN!=null){
								stmtN.close();
							}
							if(rsN!=null){
								rsN.close();
							}
							
							totTotalAmount = totTotalAmount+centralAmt+stateAmount;
							stmtN = conn.createStatement();
							String actualAmount="select  nvl(sum(b.BILL_AMOUNT_CENTRAL)+sum(a.bill_amout_state),0) as actual from RWS_bill_bank_bridge_det_TBL b,RWS_bill_pao_bridge_det_TBL a where  b.TXID is not null and b.bill_activation_flag='I'  and a.work_id=b.work_id  and b.work_id='"+rs.getString("WORK_ID") +"'";
							rsN=stmtN.executeQuery(actualAmount);
							//System.out.println("actualAmount"+actualAmount);
							
							if(rsN.next()){actualAmt = rsN.getString(1);
							//System.out.println("actualAmount"+actualAmt);
							}
							 if(actualAmt.equals("0") && (centralAmt+stateAmount==0.0)){
								 actualAmt = rs.getString(13);
								 actualAmt = String.valueOf(formatter.format(Double.parseDouble(actualAmt)));
								/*  actualAmount="select sum(bill_amt_admissible) from rws_work_bill_tbl where bill_sl_no='"+rs.getString("BILL_SL_NO")+"' and work_id='"+rs.getString("WORK_ID") +"'";
								 rsN=stmtN.executeQuery(actualAmount);
									System.out.println("actualAmount"+actualAmount); ada
									
									if(rsN.next()){} */
							}else{
								actualAmt ="--";
							}
							 if(!actualAmt.equals("--")){
								 totActualAmt = totActualAmt+Double.parseDouble(actualAmt);
							 }
							if(stmtN!=null){
								stmtN.close();
							}
							if(rsN!=null){
								rsN.close();
							}
						/* StringBuffer conName=new StringBuffer();
						
						String billType=rs.getString("billType");
						 
						//System.out.println("BillTyep:"+billType);
						 String cRec=(String)contractHash.get(rs.getString("work_id"));
						 
						 if(cRec!=null && !cRec.equals("null")){
							 String vals[]=cRec.split("@");
							conName.append(vals[1]);
							if(vals[2]!=null && !vals[2].equals("null")){
								conName.append(vals[2]);
								}
							Cflag=true;
						 }
						 
						 if(billType!=null && billType.equals("B") && !Cflag){
							 
							 continue;
						 }
						 
						 
						 String officeCode=rs.getString("office_code");
						 if(officeCode!=null && !officeCode.substring(3,4).equals(division)){
							 continue;
						 }
						 
						 
						 
						String pCopy=rs.getString("pCopy");
						
						
						val = "";
						String duestate = "0",duestate1 = "0",duecentral = "0";
						
						val = ""+ht1.get(rs.getString("work_id")+rs.getString("bill_sl_no"));
						if(val!=null && !val.equals("null")){}else{val="0@0";}
						String[] vals = val.split("@");
						boolean flag = false;
						
						String relValue=(String)releasedHash.get(rs.getString("work_id"));
						
						if(relValue!=null && !relValue.equals("null")){
							totPaidThisBill=Double.parseDouble(relValue);
						}else{
							totPaidThisBill=0.0;
						}
						
						String PaorelValue=(String)PaoreleasedHash.get(rs.getString("work_id")+rs.getString("bill_sl_no"));
						//System.out.println("PaorelValue"+PaorelValue);
						if(PaorelValue!=null && !PaorelValue.equals("null")){
							paototPaidThisBill=Double.parseDouble(PaorelValue);
						}
						else
						{
							paototPaidThisBill=0.0;
						}
						//System.out.println("paototPaidThisBill"+paototPaidThisBill);
						
						
						if(paoTempHash.get(rs.getString("work_id")+rs.getString("bill_sl_no"))!=null){
						   System.out.println("Flag is TRUE");
						   paoFlag=true;
						}
						
						double b=Double.parseDouble(rs.getString(12));
						//totPaidThisBill+=b;
						
						//					//System.out.println("aaaaaaaaaaaaaa:"+rs.getString(17)+"bbbbb"+rs.getString(18));
						if(ht1.containsKey(rs.getString("work_id")+rs.getString("bill_sl_no")))
						{						
							if(Double.parseDouble(rs.getString(13))>(Double.parseDouble(vals[0])+Double.parseDouble(vals[1])))
							{
								if((Double.parseDouble(rs.getString(15))-Double.parseDouble(vals[1]))<0)
								{
									////System.out.println("aaaaaaaaaaaaaa:"+((Double.parseDouble(rs.getString(14))-Double.parseDouble(vals[0]))+(Double.parseDouble(rs.getString(15))-Double.parseDouble(vals[1]))));
									
									duestate1 = ""+((Double.parseDouble(rs.getString(14))-Double.parseDouble(vals[0]))+(Double.parseDouble(rs.getString(15))-Double.parseDouble(vals[1])));
								}
								else
								{
									////System.out.println("nbbbbbbbbbbbb"+(Double.parseDouble(rs.getString(14))-Double.parseDouble(vals[0])));
									duestate1 = ""+(Double.parseDouble(rs.getString(14))-Double.parseDouble(vals[0]));
								}
								duestate = ""+(Double.parseDouble(rs.getString(14))-Double.parseDouble(vals[0]));
								duecentral = ""+(Double.parseDouble(rs.getString(15))-Double.parseDouble(vals[1]));
								System.out.println("in  if nbbbbbbbbbaaaaa"+duecentral +" duestate:"+duestate+" val :"+(Double.parseDouble(duestate)+Double.parseDouble(duecentral)>0));
								if(Double.parseDouble(duestate)+Double.parseDouble(duecentral)>0)
								flag = true;	
							}
						}
						else
						{
							duestate = ""+Double.parseDouble(rs.getString(14));
							duestate1 = ""+rs.getString(14);
							duecentral = ""+rs.getString(15);
							if(Double.parseDouble(duestate)+Double.parseDouble(duecentral)>0)
							flag = true;
							System.out.println("in  else nbbbbbbbbbaaaaa"+duecentral +" duestate:"+duestate+" val :"+(Double.parseDouble(duestate)+Double.parseDouble(duecentral)>0));
						}
						long stateNcentral = (long)(Double.parseDouble(duestate)+Double.parseDouble(duecentral)); */
						//stateNcentral = Long.parseLong(formatter.format(stateNcentral));
						if (flag) {
							/* String state = ""+Double.parseDouble(vals[0]);
							String central = ""+Double.parseDouble(vals[1]);
							
							
							if(duecentral.equals("0.0"))duecentral="0"; */
			%>
			<tr>
				<td class=<%=style%> style="text-align: left;" nowrap><%=count++%></td>
				<td><input type="text" name="aa" class="mytext"
					style="width: 80px" readonly="true"
					onmouseover="Tip(this.value,TITLE,'Division')"
					value="<%=rs.getString(2)%>" onmouseout="UnTip()" /></td>
				<td class=<%=style%> style="text-align: left;" nowrap><%=rs.getString(3)%>/<BR>
				<input type="text" name="a" class="mytext" style="width: 120px"
					readonly="true" onmouseover="Tip(this.value,TITLE,'Work Name')"
					value="<%=rs.getString(4)%>" onmouseout="UnTip()" /> / <br>
				 <input type="text" name="ab" class="mytext" style="width:120px" readonly="true" onmouseover="Tip(this.value,TITLE,'Contractor Name')" value="<%=contractorName%>" onmouseout="UnTip()"/> 
					</br></td>
				<td class=<%=style%> style="text-align: left;" nowrap><b
					style="font-family: Rupee Foradian;"></b><%=rs.getString("samtt")%><BR><%=rs.getString(8)%>/<br><%=rs.getString(9)%></td>
				<td class=<%=style%> style="text-align: left;"><input
					type="text" name="b" class="mytext" style="width: 80px"
					readonly="true" onmouseover="Tip(this.value,TITLE,'Bill No')"
					value="<%=rs.getString(10)%>" onmouseout="UnTip()" /><BR><%=rs.getString(11)%>/<br><%=rs.getString("update_date")%>/<br><%=rs.getString("ee_fwd_date") == null ? "-"
								: rs.getString("ee_fwd_date")%>
				</td>
				<td class=<%=style%> style="text-align: right;" nowrap
					align="right"><%=rs.getString(12)%><br><%=rs.getString(13)%></td>
					<td class=<%=style %> style="text-align: right;"  align="right"><%=ndf.format(centralAmt) %></td>
					<td class=<%=style %> style="text-align: right;"  align="right"><%=ndf.format(stateAmount) %></td>
					<td class=<%=style %> style="text-align: right;"  align="right"><%=ndf.format(centralAmt+stateAmount) %></td>
					<td class=<%=style %> style="text-align: right;"><%= (actualAmt) %></td>
				<%-- 
						<!-- 
						<td class=<%=style %> style="text-align: left;"  nowrap><input type="text" name="tota<%=sno%>" value="<%=formatter.format((Double.parseDouble(duestate)+Double.parseDouble(duecentral)))%>" class="mytext" readonly="true" style="width:60px"></td>
						<td class=<%=style %> style="text-align: left;" nowrap><input type="text" name="statea<%=sno%>" value="<%=formatter.format(Double.parseDouble(duestate1))%>" class="mytext" readonly="true" style="width:60px"></td>
						<td class=<%=style %> style="text-align: left;" nowrap><input type="text" name="goia<%=sno%>" value="<%=formatter.format(Double.parseDouble(duecentral))%>" class="mytext" readonly="true" style="width:60px"></td>
						
						<td class=<%=style %> style="text-align: left;" nowrap><input type="text" name="totb<%=sno%>" value="<%=formatter.format(Double.parseDouble(state)+Double.parseDouble(central))%>" class="mytext" readonly="true" style="width:60px"></td>
						<td class=<%=style %> style="text-align: left;" nowrap><input type="text" name="stateb<%=sno%>" value="<%=formatter.format(Double.parseDouble(state))%>" class="mytext" readonly="true" style="width:60px"></td>
						<td class=<%=style %> style="text-align: left;" nowrap><input type="text" name="goib<%=sno%>" value="<%=formatter.format(Double.parseDouble(central))%>" class="mytext" readonly="true" style="width:60px"></td>
						<%String val1 = ""+ht2.get(rs.getString("work_id")+rs.getString("bill_sl_no"));%> --%>


				


				<td class=rptValue nowrap><input type="hidden"
					name="officeCode<%=sno%>" value="<%=rs.getString("office_code")%>">
					<input type="hidden" name="workId<%=sno%>"
					value="<%=rs.getString("work_id")%>"> <input type="hidden"
					name="billSno<%=sno%>" value="<%=rs.getString("bill_sl_no")%>">
					<input type="hidden" name="progCode<%=sno%>"
					value="<%=rs.getString("programme_code")%>">
			</tr>

<%}
						}%>
			<%-- <%
				if (flag)
								sno++;
							grandtotPaidThisBill += totPaidThisBill;
							//System.out.println("grandtotPaidThisBill:"+grandtotPaidThisBill);
							grandpaototPaidThisBill += paototPaidThisBill;
							gtotal += (totPaidThisBill + paototPaidThisBill);
							/* actualtot+=(Double.parseDouble(duestate)+Double.parseDouble(duecentral)); */
							//System.out.println("grandpaototPaidThisBill:"+grandpaototPaidThisBill);
						}
					} //end main loop

					String q3 = "SELECT decode(code,1,'NRDWP Related Grant:'),amount FROM RWS_BANK_GRANT_AMT_TBL order by code";
					////System.out.println("q3:"+q3);
					st3 = conn.createStatement();
					rs3 = st3.executeQuery(q3);
			%> --%>
			<tr>
				<td class=gridhdbg style="text-align: right;" colspan="6">Total:</td>
				 <td class=gridhdbg style="text-align: right;"><%=ndf.format(totCentralAmt)%></td>
					<td class=gridhdbg style="text-align: right;"><%=ndf.format(totStateAmount)%></td>
					<td class=gridhdbg style="text-align: right;"><%=ndf.format(totTotalAmount)%></td>
					<td class=gridhdbg style="text-align: right;"><%=ndf.format(totActualAmt)%></td> 
			</tr>
		</table>
		<BR>
	
		<%
		}
			 catch (Exception e) {
				//System.out.println("error in report:"+e.getMessage());
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (stmt != null)
						stmt.close();
					if (rs1 != null)
						rs1.close();
					if (st1 != null)
						st1.close();
					if (rs2 != null)
						rs2.close();
					if (st2 != null)
						st2.close();
					if (st3 != null)
						st3.close();
					if (rs4 != null)
						rs4.close();
					if (st4 != null)
						st4.close();
					if (rs5 != null)
						rs5.close();
					if (st5 != null)
						st5.close();
					if (rs6 != null)
						rs6.close();
					if (st6 != null)
						st6.close();
					if (conn != null)
						conn.close();
				} catch (Exception eee) {
					eee.getMessage();
				}
			}
		%>

	</form>
	<p align="left">
		<font face="verdana" size="2" color="red"> <bean:message
				key="app.nrdwprelatedfin" />


		</font>
	</p>
</body>
<p align=center class="pageFooter">
	<%@ include file="/commons/rws_footer.jsp"%>
</p>
</html>