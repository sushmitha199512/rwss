<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal,java.text.NumberFormat"%>
<%@ include file="/reports/conn.jsp" %>
<%@page import="nic.watersoft.commons.RwsUtils"%>

<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />   
<%
long billAmtTot = 0;
int sno = 0;
String pcode = request.getParameter("pcode");
if (pcode != null) {
	session.setAttribute("pcode", pcode);
}

NumberFormat formatter = new DecimalFormat("#0.00");
/* String per = request.getParameter("per");
if (per != null) {
	session.setAttribute("per", per);
}

String division = request.getParameter("division");
if (division != null) {
	session.setAttribute("division", division);
} */
String per = (String)session.getAttribute("per");
String division=(String)session.getAttribute("division");
//System.out.println("per :"+per+" division :"+session.getAttribute("division").toString());

if (per == null)
	per = "";
if (division == null)
	division = "";
%>
<html>
<form method="post">

         
			
		
	
		<%
		//	//System.out.println("1");
		//String pQry = "and p.programme_code in (01,02,18,23,32,48,49,50,51,58,59,60,72)";
		/* nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		String userid = users.getUserId(); */
		////System.out.println("user di:"+userid);
		DecimalFormat ndf = new DecimalFormat("####.00");
		//double col4=0.0,col5=0.0,col6=0.0,col7=0.0,col8=0.0,col9=0.0,col10=0.0,col11=0.0,col12=0;
		//double grandtotPaidThisBill=0.0,grandpaototPaidThisBill=0.0;
		//double totPaidThisBill=0.0,paototPaidThisBill=0.0;
		//double total=0.0,gtotal=0.0;
		//double actualtot=0.0;
		Statement st1 = null;
		Statement st2 = null;
		Statement st3 = null;
		Statement st4 = null;
		Statement st5 = null;
		Statement st6 = null;
		Statement stt = null;
		Statement stmtN=null;
		
		ResultSet rss = null,rs1 = null,rs2 = null,rs3 = null,rs4 = null,rs5 = null,rs6 = null,rsN=null;
	try
	{
		st4 = conn.createStatement();
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		st6 = conn.createStatement();
		String dquery = "",dquery1 = "",dquery2 = "",progQry = "",yearQry="",monQry="";
		
		if(per!=null && per.equals("") && division!=null && division.equals(""))
		{

		}
		else
		{
			/* stmtN = conn.createStatement();
			String queryEmp="select EMPLOYEE_CODE,EMPLOYEE_NAME,EMPLOYEE_SURNAME from rws_employee_tbl";
			rsN=stmtN.executeQuery(queryEmp);
			Hashtable hashEmp=new Hashtable();
			while(rsN.next()){
			hashEmp.put(rsN.getString(1),rsN.getString(2)+"  "+rsN.getString(3));	
			}
			if(stmtN!=null){
				stmtN.close();
			}
			if(rsN!=null){
				rsN.close();
			} */
			if(per!=null && per.equals("ALL")&& division!=null && division.equals("ALL"))
			{	dquery = "";dquery1 = "";dquery2 = "";}
			else
			{
				dquery = " and substr(b.work_id,5,2)='" + per + "'";
				if (!division.equals("ALL"))
					dquery += " and substr(b.office_code,4,1)='" + division
							+ "' ";
				dquery1 = " where substr(work_id,5,2)='" + per + "'";
				dquery2 = " where substr(work_id,5,2) <> '" + per + "'";
			}
			if(session.getAttribute("programme") != null && session.getAttribute("programme").toString().trim().length()>0){
				progQry = " and b.PROGRAMME_CODE = p.PROGRAMME_CODE and p.PROGRAMME_CODE='"+session.getAttribute("programme").toString()+"' ";
			}
			if(session.getAttribute("finyear") != null && session.getAttribute("finyear").toString().trim().length()>0){
				String finYear = (String)session.getAttribute("finyear");
				int temp = 0;
				if(finYear != null && finYear.trim().length()>0 &&  !finYear.equals("0") ){
					temp = Integer.parseInt( finYear);
				}
				yearQry = " and to_char(a.BILL_DATE,'YYYY')='"+temp+"' ";
				
			}
			if(session.getAttribute("finmonth") != null && session.getAttribute("finmonth").toString().trim().length()>0){
				monQry = " and to_char(a.BILL_DATE,'MON')='"+session.getAttribute("finmonth").toString()+"' ";
				
			}
			//System.out.println("programme  :"+progQry+" yearQry :"+yearQry);
				String qry = "select d.circle_office_name,sd.division_office_name,b.work_id,work_name,admin_no,to_char (admin_date,'dd/mm/yyyy'),sanction_amount*100000 as samtt,programme_name,subprogramme_name,bill_no,to_char (bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,(nvl(STATE_SHARE,0)*bill_amt_admissible)/100, (nvl(CENTRAL_SHARE,0)*bill_amt_admissible)/100,p.programme_code,nvl(STATE_SHARE,0)STATE_SHARE,nvl(CENTRAL_SHARE,0)CENTRAL_SHARE,bill_sl_no,'1'||d.circle_office_code||sd.division_office_code||'00' office_code,to_char (a.update_date,'dd/mm/yyyy') as update_date, nvl(to_char(ee_fwd_date,'dd/mm/yyyy'),'') as ee_fwd_date,length(PASS_ORDER_SCAN_COPY) as pCopy,bill_type as billType  from rws_work_bill_tbl a,rws_work_admn_tbl b,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_circle_office_tbl d,rws_division_office_tbl sd where  nvl(to_char(ee_fwd_date,'dd/mm/yyyy'),'') is NOT NULL and substr(b.office_code,2,2) =d.circle_office_code and d.circle_office_code=sd.circle_office_code and substr(b.office_code,2,2) =sd.circle_office_code and substr (b.office_code,4,1)=sd.division_office_code and b.programme_code=p.programme_code and p.programme_code=sp.programme_code and b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code and a.work_id=b.work_id and bill_sl_no<>0 "
						+ dquery+progQry +yearQry+monQry
						+ "  and b.block_payment<>'Y' and a.bill_type='B'  order by nvl(to_date(ee_fwd_date,'dd/mm/yyyy'),'') desc";//and rownum<100 -- and a.work_id='49010501110018' and a.work_id='49010501110018' a.work_id='49010501110018' 
				//						+ "  and b.block_payment<>'Y' and a.bill_type='B' and length(a.pass_order_scan_copy)>0 order by nvl(to_date(ee_fwd_date,'dd/mm/yyyy'),'') desc";//and rownum<100 -- and a.work_id='49010501110018' and a.work_id='49010501110018' a.work_id='49010501110018' 

					//	System.out.println("main aa:" + qry);
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
				rs = stmt.executeQuery(qry);
				int count = 1;
		
			  %>
			  <table align=left>
			  <tr><td class=rptValue>
			  </td></tr>
			</table>
			</br></br>
			<table border = 1 align=center bordercolor=black style="border-collapse:collapse">
				 <tr align="center">
					<td class=gridhdbg rowspan="2">Sl. No.</td>
					<!-- <td class=gridhdbg rowspan="2">Circle</td> -->
					<td class=gridhdbg rowspan="2">Division</td>
					<td class=gridhdbg rowspan="2">Work ID/<BR>Work Name / <BR>Agency Name</td>
					<!-- <td class=gridhdbg rowspan="2">Admin No</td> -->
					<td class=gridhdbg rowspan="2">Sanction Amount/<BR>Program/<BR>Sub Program</td>
					<td class=gridhdbg rowspan="2">Bill<BR>No/<BR>Bill Date/<BR>Bill Entered Date/<BR>EE FWD Date</td>
					<td class=gridhdbg rowspan="2">Bill Amt <BR>Contractor/<br>Bill Amt <BR>Admissible</td>
					<td class=gridhdbg colspan="3">Amount So Far Released.<br></br> Including Current Bill</td>
					<td class=gridhdbg rowspan="2">Actual(Now recommended)</td>
					
				</tr>
				<tr>
				    <td class=gridhdbg >Bank</td>
					<td class=gridhdbg >PAO</td>
					<td class=gridhdbg >Total</td>
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
					//stateNcentral = Long.parseLong(formatter.format(stateNcentral));
					if(flag)
					{
				  %>
					<tr >
						<td><%=count++%></td>
						<td> <font size="2" ><%=rs.getString(2)%></font></td>
						<td  ><font size="2" >&nbsp;<%=rs.getString(3)%><br><%=rs.getString(4)%><br><%=contractorName%></font></td>
						<td  ><b style="font-family: Rupee Foradian;">`</b><%=rs.getString("samtt")%><BR><%=rs.getString(8)%>/<br><%=rs.getString(9)%></td>
						<td class="rptValue"> <%=rs.getString(10)%><BR><%=rs.getString(11)%>/<br><%=rs.getString("update_date")%>/<br><%=rs.getString("ee_fwd_date")==null?"-":rs.getString("ee_fwd_date") %> </td>
						<td   align="right"><%=rs.getString(12)%><br><%=rs.getString(13)%></td>
						<td  align="right"><%=ndf.format(centralAmt) %></td>
					
						<td  align="right"><%=ndf.format(stateAmount) %></td>
						<td  align="right"><%=ndf.format(centralAmt+stateAmount) %></td>
						
						
						<td align="right"><%= (actualAmt) %></td>
						
						
					
						
					
						
					</tr>
					
				<%
					
					
						/* grandtotPaidThisBill+=totPaidThisBill;
						//System.out.println("grandtotPaidThisBill:"+grandtotPaidThisBill);
						grandpaototPaidThisBill+=paototPaidThisBill;
						gtotal+=(totPaidThisBill+paototPaidThisBill);
						actualtot+=(Double.parseDouble(duestate)+Double.parseDouble(duecentral));
						*/
					//System.out.println("grandpaototPaidThisBill:"+grandpaototPaidThisBill);
					}	
				}  //end main loop
				
				
			String q3 = "SELECT decode(code,1,'NRDWP Related Grant:'),amount FROM RWS_BANK_GRANT_AMT_TBL order by code";
			////System.out.println("q3:"+q3);
			st3 = conn.createStatement();
			rs3 = st3.executeQuery(q3);
			%>
			<tr>
					<td align="right" colspan="6">Total:</td>
					<td align="right"><%=ndf.format(totCentralAmt)%></td>
					<td align="right"><%=ndf.format(totStateAmount)%></td>
					<td align="right"><%=ndf.format(totTotalAmount)%></td>
					<td align="right"><%=ndf.format(totActualAmt)%></td>
			</tr>
			</table>
				<BR>
			<table align=center>
			<tr  align="center">
			<%
				int iter = 1;
				if(rs3.next())
				{
				%>
					
					
				<%
				}%>
			</tr></table>
			<table align=center>
			
			</table>
	<%}
	}
		catch(Exception e){
		//System.out.println("error in report:"+e.getMessage());
		e.printStackTrace();}
		finally{
		try{
			if(rs!=null)rs.close();if(stmt!=null)stmt.close();
			if(rs1!=null)rs1.close();if(st1!=null)st1.close();
			if(rs2!=null)rs2.close();if(st2!=null)st2.close();
			if(rs3!=null)rs3.close();if(st3!=null)st3.close();
			if(rs4!=null)rs4.close();if(st4!=null)st4.close();
			if(rs5!=null)rs5.close();if(st5!=null)st5.close();
			if(rs6!=null)rs6.close();if(st6!=null)st6.close();
			if(conn!=null)conn.close();
		}catch(Exception eee){eee.getMessage();}
		}
	
	%>
	
</form>
</body>
<p align=center class="pageFooter" >
<%@ include file="/commons/rws_footer.jsp"%>
</p>
</html>