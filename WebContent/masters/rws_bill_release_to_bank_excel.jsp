<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal,java.text.NumberFormat"%>
<%@ include file="/reports/conn.jsp" %>

<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />   
<%
System.out.println("dddd");
	long billAmtTot = 0;
	String pcode = (String)session.getAttribute("pcode");
	NumberFormat formatter = new DecimalFormat("#0.00");
	String per = (String)session.getAttribute("per");
	if(per==null)per="";
%>
<html>

<body > <!-- onload="init()" -->
<form method="post">
			<%
		//	//System.out.println("1");
		String pQry = "and p.programme_code in (01,02,18,23,32,48,49,50,51,58,59,60,72)";
		nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		String userid = users.getUserId();
		System.out.println("user di:"+userid);
		DecimalFormat ndf = new DecimalFormat("####.00");
		double col4=0.0,col5=0.0,col6=0.0,col7=0.0,col8=0.0,col9=0.0,col10=0.0,col11=0.0,col12=0;
		Statement st1 = null;
		Statement st2 = null;
		Statement st3 = null;
		Statement st4 = null;
		Statement st5 = null;
		Statement st6 = null;
		Statement stt = null;
		ResultSet rss = null,rs1 = null,rs2 = null,rs3 = null,rs4 = null,rs5 = null,rs6 = null;
	try
	{
		st4 = conn.createStatement();
	
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		st6 = conn.createStatement();
		String dquery = "",dquery1 = "",dquery2 = "";
		if(per!=null && per.equals(""))
		{

		}
		else
		{
			if(per!=null && per.equals("ALL"))
			{	dquery = "";dquery1 = "";dquery2 = "";}
			else
			{
				dquery = " and substr(a.work_id,5,2)='"+per+"'";
				dquery1 = " where substr(work_id,5,2)='"+per+"'";
				dquery2 = " where substr(work_id,5,2) <> '"+per+"'";
			}
			String q1 = "select work_id,bill_sl_no,nvl(sum(bill_amout_state),0),nvl(sum(bill_amount_central),0) from rws_bill_bank_bridge_tbl "+dquery1+" group by work_id,bill_sl_no";
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
			}
String qry = "select circle_office_name,division_office_name,b.work_id,work_name,admin_no,to_char (admin_date,'dd/mm/yyyy'),sanction_amount*100000 as samtt,programme_name,subprogramme_name,bill_no,to_char (bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,(nvl(STATE_SHARE,0)*bill_amt_admissible)/100, (nvl(CENTRAL_SHARE,0)*bill_amt_admissible)/100,p.programme_code,nvl(STATE_SHARE,0)STATE_SHARE,nvl(CENTRAL_SHARE,0)CENTRAL_SHARE,bill_sl_no,'1'||d.circle_office_code||sd.division_office_code||'00' office_code,to_char (update_date,'dd/mm/yyyy') as update_date, nvl(to_char(ee_fwd_date,'dd/mm/yyyy'),'') as ee_fwd_date from rws_work_bill_tbl a,rws_work_admn_tbl b,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_circle_office_tbl d,rws_division_office_tbl sd where substr(b.office_code,2,2) =d.circle_office_code and d.circle_office_code=sd.circle_office_code and substr(b.office_code,2,2) =sd.circle_office_code and substr (b.office_code,4,1)=sd.division_office_code and b.programme_code=p.programme_code and p.programme_code=sp.programme_code and b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code and a.work_id=b.work_id and bill_sl_no<>0 and p.programme_code in ('02','01','48','32','23','49','51','18','37','60','50','58','59') "+dquery+" order by nvl(to_date(ee_fwd_date,'dd/mm/yyyy'),'') desc";//and rownum<100 -- and a.work_id='49010501110018' and a.work_id='49010501110018' a.work_id='49010501110018' 
	System.out.println("aa:"+qry);
			  stmt = conn.createStatement();
			  rs = stmt.executeQuery(qry);
			  int count = 1,sno=0;
			  %>
		
			<table border = 1 align=center bordercolor=black style="border-collapse:collapse" >
				 <tr align="center">
					<td  rowspan="2">Sl. No.</td>
					<!-- <td  rowspan="2">Circle</td> -->
					<td  rowspan="2">Division</td>
					<td  rowspan="2">Work ID/<BR>Work Name</td>
					<!-- <td  rowspan="2">Admin No</td> -->
					<td  rowspan="2">Sanction Amount/<BR>Program/<BR>Sub Program</td>
					<td  rowspan="2">Bill<BR>No/<BR>Bill Date/<BR>Bill Entered Date/<BR> EE Forward Date</td>
					<td  rowspan="2">Bill Amt <BR>Contractor/<br>Bill Amt <BR>Admissible</td>
					<td  colspan="3">Bill Amount Due</td>
					<td  colspan="3">Already Paid Bill</td>
					<td  colspan="3">Now recommended </td>
					<td  rowspan="2">Select</td>
				</tr>
				<tr align="center">
					<td >Actual</td>
					<td >State</td>
					<td >GOI</td>
					<td >Actual</td>
					<td >State</td>
					<td >GOI</td>
					<td >Actual</td>
					<td >State</td>
					<td >GOI</td>
				</tr>
			<%
				String val = "";
				while(rs.next())
				{
					val = "";
					String duestate = "0",duestate1 = "0",duecentral = "0";
					val = ""+ht1.get(rs.getString("work_id")+rs.getString("bill_sl_no"));
					if(val!=null && !val.equals("null")){}else{val="0@0";}
					String[] vals = val.split("@");
					boolean flag = false;
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
							////System.out.println("nbbbbbbbbbaaaaa"+duecentral);
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
					}
					long stateNcentral = (long)(Double.parseDouble(duestate)+Double.parseDouble(duecentral));
					//stateNcentral = Long.parseLong(formatter.format(stateNcentral));
					if(flag)
					{
						String state = ""+Double.parseDouble(vals[0]);
						String central = ""+Double.parseDouble(vals[1]);
						if(duecentral.equals("0.0"))duecentral="0";
				  %>
					<tr>
						<td><%=count++%></td>
						<td> <font size="2" ><%=rs.getString(2)%></font></td>
						<td  ><font size="2" >&nbsp;<%=rs.getString(3)%><br><%=rs.getString(4)%></font></td>
						<td  ><b style="font-family: Rupee Foradian;">`</b><%=rs.getString("samtt")%><BR><%=rs.getString(8)%>/<br><%=rs.getString(9)%></td>
												<td class="rptValue"> <%=rs.getString(10)%><BR><%=rs.getString(11)%>/<br><%=rs.getString("update_date")%>/<br><%=rs.getString("ee_fwd_date")==null?"-":rs.getString("ee_fwd_date") %> </td>
						<td   align="right"><%=rs.getString(12)%><br><%=rs.getString(13)%></td>
						<td   ><%=formatter.format((Double.parseDouble(duestate)+Double.parseDouble(duecentral)))%></td>
						<td  ><%=formatter.format(Double.parseDouble(duestate1))%></td>
						<td  ><%=formatter.format(Double.parseDouble(duecentral))%></td>
						
						<td  ><%=formatter.format(Double.parseDouble(state)+Double.parseDouble(central))%></td>
						<td  ><%=formatter.format(Double.parseDouble(state))%></td>
						<td  ><%=formatter.format(Double.parseDouble(central))%></td>
						<%String val1 = ""+ht2.get(rs.getString("work_id")+rs.getString("bill_sl_no"));%>
						<td class=rptValue><%=formatter.format((Double.parseDouble(duestate)+Double.parseDouble(duecentral)))%></td>
						<td class=rptValue >
							
							
						</td>
						<%if(Double.parseDouble(duestate1)<0)duecentral=""+(Double.parseDouble(duecentral)+Double.parseDouble(duestate1));%>
						<td class=rptValue >
						<%if(val1!=null && !val1.equals("null"))
						{
							////System.out.println(val1);
							String val1s[] = val1.split("@");
							double percentage = ((Double.parseDouble(val1s[1])/(Double.parseDouble(duestate)+Double.parseDouble(duecentral)))*100);
							////System.out.println("aaa:"+Math.round(((Double.parseDouble(val1s[1])/(Double.parseDouble(duestate)+Double.parseDouble(duecentral)))*100)));
							%>
						<%=percentage%>
						<%=formatter.format(workData.round(Double.parseDouble(val1s[1]),2))%>
						<%}else{%>
						<%=rs.getString("CENTRAL_SHARE") %>--
						<%=workData.round(Double.parseDouble(duecentral),2)%>
						<%}%></td>
						
                        <%
						if(rs.getString(17).equals("0") && rs.getString(18).equals("0"))
						{%>
							<td class=rptValue align="center" onmouseover="Tip('State/Central Share Not Given',TITLE,'Error')" ><div class="diva"><span class="spana"></span></div></td>
							<%
						}
						else
						{
							if(rs.getString("ee_fwd_date")==null || (rs.getString("ee_fwd_date")!=null && rs.getString("ee_fwd_date").equals("-")))
							{%>
							<td  align="center"  ><div class="diva"></div></td>
							<%}
							else
							{
							//String val1 = ""+ht2.get(rs.getString("work_id")+rs.getString("bill_sl_no"));
								if(duecentral.substring(0,1).equals("-") || duecentral.equals("0.0"))
								{
									%>
									<td  align="center"></td>
									<%
								}
								else
								{
									if(val1!=null && !val1.equals("null"))
									{
										%>
										<td  align="center"></td>
										<%
									}
									else
									{
									%>
									<td  align="center"></td>
									<%}
								}
						}
						}%>
					</tr>
				<%
					}
						if(flag)sno++;
				}
			String q3 = "SELECT decode(code,1,'NRDWP Related Grant:'),amount FROM RWS_BANK_GRANT_AMT_TBL order by code";
			////System.out.println("q3:"+q3);
			//st3 = conn.createStatement();
			//rs3 = st3.executeQuery(q3);
			%>
			</table>
				<BR>
			<table align=center>
			<tr  align="center">
			
			</tr></table>
			
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

</html>