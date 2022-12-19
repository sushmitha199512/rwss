<%@ page import="java.text.DecimalFormat,java.math.BigDecimal,java.text.NumberFormat"%>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_ee_header1.jsp"%>

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


<style>
#input_box {
	background-color:#C9DFF4;
	font-weight:bold;
}
</style>
<style>
.diva
{
	width:14px;
	height:14px;
	clip:rect(0,14,14,0);
	overflow:hidden;
}
.spana
{
background-color:red;
position:relative;
top:-3px;
left:-3px;
}
.checka
{
margin:0;
padding:0;
FILTER:progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=50)-moz-opacity:0.1;
}
</style>

<script language="javascript">
function fnClose()
{
	document.forms[0].action="rws_ee_homepage_frm.jsp";
	document.forms[0].submit();	
}

function getBills()
{
//	alert("aaaaa");
var per = document.forms[0].per.value;
	if(per=="")
	{
		alert("Please Select Any District or ALL option");
		return false;
	}
	else
	{
		document.forms[0].action="rws_bill_release_to_bank.jsp?per="+document.forms[0].per.value;
		document.forms[0].submit();
	}
}

function fnAllBills()
{
	 var url="rws_bill_selected_to_enc_rpt.jsp";
     var properties="width=648,height=562,toolbar=no,status=yes,menubar=no,location=no,directories=no scrollbars=yes,copyhistory=no,resizable=yes";
     newWindow1 = window.open(url, "_New", properties);
}
function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}
function fnAllBals(){
	var url="rws_bill_tobe_release_nrdwp_rpt.jsp";
	var properties="width=648,height=562,toolbar=no,status=no,menubar=no,location=no,directories=noscrollbars=yes,copyhistory=no,resizable=yes";
	newWindow1 = window.open(url, "_New", properties);
}
function init()
{
	var per ='<%=per%>';
	if(per=="")
	{
		alert("Before Processing the Bills You may view the All the Balances Report");
		if(confirm("Do You want View the Report"))
			{
				var url="rws_bill_tobe_release_nrdwp_rpt.jsp";
				var properties="width=648,height=562,toolbar=no,status=no,menubar=no,location=no,directories=noscrollbars=yes,copyhistory=no,resizable=yes";
				newWindow = window.open(url, "_New", properties);
			}
	}
}
function fnCheckBank(totAmt)
{
	var value2='0';
	for(var i=0;i<document.forms[0].sendBank.length;i++)
	{
		if(document.forms[0].sendBank[i].checked==true)
		{
			value2 = parseFloat(value2)+parseFloat(document.getElementById('goic'+document.forms[0].sendBank[i].value).value);
		}
	}
	//alert(parseFloat(value2)+parseFloat(totAmt));
	//alert(document.getElementById('bankGrants1').value);
	if((parseFloat(value2)+parseFloat(totAmt))>parseFloat(document.getElementById('bankGrants1').value))
	{
		alert("Total NRDWP Related Bills to be Released Amount (Rs. "+parseFloat(value2)+"/-)\n should be less than or equal to NRDWP Bank Fund (Rs. "+document.getElementById('bankGrants1').value+"/-)");
		return false;
	}
	else
	{
		return true;
	}
}
function fnSaveContinue()
{
	var flag = false;
	for(var i=0;i<document.forms[0].sendBank.length;i++)
	{
		if(document.forms[0].sendBank[i].checked==true)
		{
			flag = true;
		}
	}
	if(flag==true)
	{
		if(fnCheckBank())
		{
			if(confirm("Are You Sure"))
			{
				document.forms[0].action="rws_bill_release_to_bank_save_continue.jsp";
				document.forms[0].submit();
			}
		}
	}
	else
	{
		alert("Please Select Atleast One Check Box to Continue");
	}
}
</script>
<body > <!-- onload="init()" -->
<form method="post">
		<table>
		<tr  align="center">
			<td class="rptHeading" style="width:50%" align="center">BANK - Payment Due and Releases Entry Form</td>
			<td class="rptHeading"  style="width:50%" align="center">
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)</font><b style="font-family: Rupee Foradian;">`</b></td>
<td class="rptHeading"  style="width:50%" align="right"><a href="#" onclick="window.print()"><img src="../images/print_icon.jpg"></a></td>	
		</tr>
		</table>
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
		
			<table border = 1 align=center bordercolor=black style="border-collapse:collapse">
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
						<td  ><font size="2" ><%=rs.getString(3)%><br><%=rs.getString(4)%></font></td>
						<td  ><b style="font-family: Rupee Foradian;">`</b><%=rs.getString("samtt")%><BR><%=rs.getString(8)%>/<br><%=rs.getString(9)%></td>
												<td class="rptValue"> <input type="text" name="b" class="mytext" style="width:80px" readonly="true" onmouseover="Tip(this.value,TITLE,'Bill No')" value="<%=rs.getString(10)%>" onmouseout="UnTip()"/><BR><%=rs.getString(11)%>/<br><%=rs.getString("update_date")%>/<br><%=rs.getString("ee_fwd_date")==null?"-":rs.getString("ee_fwd_date") %> </td>
						<td   align="right"><%=rs.getString(12)%><br><%=rs.getString(13)%></td>
						<td   ><input type="text" name="tota<%=sno%>" value="<%=formatter.format((Double.parseDouble(duestate)+Double.parseDouble(duecentral)))%>"  readonly="true" style="width:60px"></td>
						<td  ><input type="text" name="statea<%=sno%>" value="<%=formatter.format(Double.parseDouble(duestate1))%>"  readonly="true" style="width:60px"></td>
						<td  ><input type="text" name="goia<%=sno%>" value="<%=formatter.format(Double.parseDouble(duecentral))%>"  readonly="true" style="width:60px"></td>
						
						<td  ><input type="text" name="totb<%=sno%>" value="<%=formatter.format(Double.parseDouble(state)+Double.parseDouble(central))%>"  readonly="true" style="width:60px"></td>
						<td  ><input type="text" name="stateb<%=sno%>" value="<%=formatter.format(Double.parseDouble(state))%>"  readonly="true" style="width:60px"></td>
						<td  ><input type="text" name="goib<%=sno%>" value="<%=formatter.format(Double.parseDouble(central))%>"  readonly="true" style="width:60px"></td>
						<%String val1 = ""+ht2.get(rs.getString("work_id")+rs.getString("bill_sl_no"));%>
						<td class=rptValue><input type="text" id="input_box" name="totc<%=sno%>" value="<%=formatter.format((Double.parseDouble(duestate)+Double.parseDouble(duecentral)))%>"  onkeypress="return numeralsOnly()" onkeyup="fnCheckMax('<%=sno%>')" style="width:70px"></td>
						<td class=rptValue >
							<input type="text" style="width:25px" name="stateca<%=sno%>"   onkeypress="return numeralsOnly()" onkeyup="fnCalState('<%=sno%>')" onchange="fnCalState('<%=sno%>')" value="0" readonly="true">
							<input type="text" name="statec<%=sno%>" value="0"  style="width:25px" readonly="true">
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
						<input type="text" id="input_box" style="width:25px" name="goica<%=sno%>"   onkeypress="return numeralsOnly()" onkeyup="fnCalCentral('<%=sno%>')" onchange="fnCalCentral('<%=sno%>')" value="<%=percentage%>">
						<input type="text" id="input_box" name="goic<%=sno%>" value="<%=formatter.format(workData.round(Double.parseDouble(val1s[1]),2))%>"  style="width:80px" onkeypress="return numeralsOnly()" onkeyup="fnCalCentralPer('<%=sno%>')" >
						<%}else{%>
						<input type="text" id="input_box" style="width:25px" name="goica<%=sno%>"   onkeypress="return numeralsOnly()" onkeyup="fnCalCentral('<%=sno%>')" onchange="fnCalCentral('<%=sno%>')" value="<%=rs.getString("CENTRAL_SHARE")%>">
						<input type="text" id="input_box" name="goic<%=sno%>" value="<%=workData.round(Double.parseDouble(duecentral),2)%>"  style="width:80px" onkeypress="return numeralsOnly()" onkeyup="fnCalCentralPer('<%=sno%>')" >
						<%}%></td>
						<input type="hidden" name="officeCode<%=sno%>" value="<%=rs.getString("office_code")%>">
						<input type="hidden" name="workId<%=sno%>" value="<%=rs.getString("work_id")%>">
						<input type="hidden" name="billSno<%=sno%>" value="<%=rs.getString("bill_sl_no")%>">
						<input type="hidden" name="progCode<%=sno%>" value="<%=rs.getString("programme_code")%>">
						
                        <%
						if(rs.getString(17).equals("0") && rs.getString(18).equals("0"))
						{%>
							<td class=rptValue align="center" onmouseover="Tip('State/Central Share Not Given',TITLE,'Error')" ><div class="diva"><span class="spana"><input type="checkbox"  disabled name="sendBank" value="<%=sno%>" class="checka"></span></div></td>
							<%
						}
						else
						{
							if(rs.getString("ee_fwd_date")==null || (rs.getString("ee_fwd_date")!=null && rs.getString("ee_fwd_date").equals("-")))
							{%>
							<td  align="center"  ><div class="diva"><span class="spana"><input disabled type="checkbox" name="sendBank" value="<%=sno%>" class="checka" title="EE Not yet forwarded"></span></div></td>
							<%}
							else
							{
							//String val1 = ""+ht2.get(rs.getString("work_id")+rs.getString("bill_sl_no"));
								if(duecentral.substring(0,1).equals("-") || duecentral.equals("0.0"))
								{
									%>
									<td  align="center"><input type="checkbox" name="sendBank" value="<%=sno%>" disabled="true"></td>
									<%
								}
								else
								{
									if(val1!=null && !val1.equals("null"))
									{
										%>
										<td  align="center"><input type="checkbox" name="sendBank" value="<%=sno%>" checked="true"></td>
										<%
									}
									else
									{
									%>
									<td  align="center"><input type="checkbox" name="sendBank" value="<%=sno%>"></td>
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
			st3 = conn.createStatement();
			rs3 = st3.executeQuery(q3);
			%>
			</table>
				<BR>
			<table align=center>
			<tr  align="center">
			<%
				int iter = 1;
				if(rs3.next())
				{
				%>
					<td class="btext"><%=rs3.getString(1)%></td>
					<td><input type="text" name="bankGrants<%=iter++%>" value="<%=rs3.getString(2)%>" readonly="true" style="width:100px;text-align:right" class="noborder-text-box"><b style="font-family: Rupee Foradian;">`</b></td>
				<%
				}%>
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
	<script>
	function fnCalState(val)
	{
		if(parseInt(document.getElementById('stateca'+val).value)>100)
		{
			document.getElementById('stateca'+val).value = '0';
			document.getElementById('statec'+val).value = '0';
			alert("State Percentage Should be in Between 1-100");
		}
		if((parseInt(document.getElementById('stateca'+val).value)+parseInt(document.getElementById('goica'+val).value))>100)
		{
			document.getElementById('stateca'+val).value = '0';
			document.getElementById('statec'+val).value = '0';
			alert("State+GOI Percentage Should be in Between 1-100");
		}
		else
		{
			var value = parseFloat(document.getElementById('totc'+val).value)*((parseFloat(document.getElementById('stateca'+val).value))/100);
			if(isNaN(value))
			{
				document.getElementById('statec'+val).value = '0';
			}
			else
			{
				document.getElementById('statec'+val).value = Math.round((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
			}
		}
		fnDisable(val);
	}	
	function fnCalCentral(val)
	{
		if(parseInt(document.getElementById('goica'+val).value)>100)
		{
			document.getElementById('goica'+val).value = '0';
			document.getElementById('goic'+val).value = '0';
			alert("GOI Percentage Should be in Between 1-100");
		}
		if((parseInt(document.getElementById('stateca'+val).value)+parseInt(document.getElementById('goica'+val).value))>100)
		{
			document.getElementById('goica'+val).value = '0';
			document.getElementById('goic'+val).value = '0';
			alert("State+GOI Percentage Should be in Between 1-100");
		}
		else
		{
			var value = parseFloat(document.getElementById('totc'+val).value)*((parseFloat(document.getElementById('goica'+val).value))/100);
			if(value=="" || value == null || isNaN(value))
			{
				document.getElementById('goic'+val).value = '0';
			}
			else
			{
				document.getElementById('goic'+val).value = Math.round((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
			}
		}
		//alert(document.getElementById('goic'+val).value);
		fnDisable(val);
		
	}
	function fnDisable(val)
	{
		for(var i=0;i<document.forms[0].sendBank.length;i++)
		{
			if(val==i)
			{
				if(parseFloat(document.getElementById('goic'+val).value)>0 || document.getElementById('goic'+val).value=="0.0")
				{
					document.forms[0].sendBank[i].disabled=false;			
				}
				else
				{
					document.forms[0].sendBank[i].disabled=true;
				}
			}
		}
	}
	function fnCheckMax(val)
	{
		fnCalState(val);
		fnCalCentral(val);
		if((parseFloat(document.getElementById('totc'+val).value))>(parseFloat(document.getElementById('tota'+val).value)))
		{
			document.getElementById('totc'+val).value = '0';
			document.getElementById('statec'+val).value = '0';
			document.getElementById('goic'+val).value = '0';
			alert("Now Recommended Amount Should be Less than or Equal to Bill Amount Due");
		}
		fnDisable(val);
	}
	function fnCalCentralPer(val)
	{
		if(parseFloat(document.getElementById('goic'+val).value)>parseFloat(document.getElementById('totc'+val).value))
		{
			document.getElementById('goic'+val).value = '0';
			document.getElementById('goica'+val).value = '0';
			alert("GOI Amount of Now Recommended Should be in Less than or equal to Actual Amount of Now Recommended");
		}
		else
		{
			var value = ((parseFloat(document.getElementById('goic'+val).value))/(parseFloat(document.getElementById('tota'+val).value)))*100;
			if(value=="" || value == null || isNaN(value))
			{
				document.getElementById('goica'+val).value = '0';
			}
			else
			{
				document.getElementById('goica'+val).value = value;//Math.round((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
			}
		}
		fnDisable(val);
	}
	function fnSave()
	{
		var flag = false;
		for(var i=0;i<document.forms[0].sendBank.length;i++)
		{
			
			if(document.forms[0].sendBank[i].checked==true)
			{
				flag=true;
				if(parseFloat(document.getElementById('goic'+i).value)<0)
				{
					alert("This bill cannot be Forwarded to ENC Because of Invalid Amount("+document.getElementById('goic'+i).value+") for the Sl. No:"+(i+1));
					document.forms[0].sendBank[i].checked=false;
					document.forms[0].sendBank[i].disabled=true;
					return false;
				}
			}

		}
		var totAmt = '<%=billAmtTot%>';
		//alert(totAmt);
		
		
		if(flag==true)
		{
			if(fnCheckBank(totAmt))
			{
				if(confirm("Are You Sure"))
				{
					document.getElementById('fnSavve').disabled=true;
					document.getElementById('fnSavve').value="Wait...";
					document.forms[0].action="rws_bill_release_to_bank_save.jsp";
					document.forms[0].submit();
				}
			}
		}
		else
		{
			document.getElementById('fnSavve').value="Save";
			document.getElementById('fnSavve').disabled=false;
			alert("Please Select Atleast One Check Box to Continue");
		}
	}
	</script>
</form>
<p align="left">
<font face="verdana" size="2" color="red">
Note********: Works Displayed above under the following programmes which are related to <b>NRDWP</b><BR>
 <bean:message key="app.nrdwprelatedfin"/></body>
<p align=center class="pageFooter" >
<%@ include file="/commons/rws_footer.jsp"%>
</p>
</html>