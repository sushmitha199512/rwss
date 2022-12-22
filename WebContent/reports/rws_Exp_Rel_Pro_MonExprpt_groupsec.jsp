<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<html>
<% 

DecimalFormat ndf = new DecimalFormat("####.00");
double obtot=0.0,ttot=0.0,ttot1=0.0,vtot=0.0,ttot2=0.0;
double stot=0.0,mtot=0.0,ctot=0.0,gmtot=0.0,texp=0.0;
     nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	//System.out.println("user:::"+loggedUser);
	String dcode = request.getParameter("district");
	if(dcode!=null)
	{
		session.setAttribute("dcode",dcode);
	}
	String dname = request.getParameter("dname");
	if(dname!=null)
	{
		session.setAttribute("dname",dname);
	}
		//String program = request.getParameter("program");
		String finyear = request.getParameter("finyear");
		if(finyear!=null)
	{
		session.setAttribute("finyear",finyear);
	}
		//System.out.println("dcode value::"+dcode);
		System.out.println("finyear value::"+finyear);
		String mode = request.getParameter("mode");	
		System.out.println("Mode:"+mode);
		String query = null;
		int sno=1;
		String programe="",nextyr="";
		
%>
<script>
function fnView()
{
	//alert(document.forms[0].finyear.value);
	//alert("in fun");
	      if(document.forms[0].district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			
			else if(document.forms[0].finyear.value=="0" )
			{
				alert("Please Select Financial Year");
				return false;
			}
			else
	{
		document.forms[0].dname.value = document.forms[0].district.options[document.forms[0].district.selectedIndex].text;
		//alert(document.forms[0].dname.value);
		document.forms[0].mode.value = "report";
		document.forms[0].action= "rws_Exp_Rel_Pro_rpt.jsp";
		document.forms[0].submit();
}
}
function fnView1()
{
	//alert(document.forms[0].finyear.value);
	//alert("in fun");
	      if(document.forms[0].district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			
			else if(document.forms[0].finyear.value=="0" )
			{
				alert("Please Select Financial Year");
				return false;
			}
			else
	{
		document.forms[0].dname.value = document.forms[0].district.options[document.forms[0].district.selectedIndex].text;
		//alert(document.forms[0].dname.value);
		document.forms[0].mode.value = "report";
		document.forms[0].action= "rws_Exp_Rel_Pro_Monrpt_groupsec.jsp";
		document.forms[0].submit();
}
}

function fnView2()
{
	//alert(document.forms[0].finyear.value);
	//alert("in fun");
	      if(document.forms[0].district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			
			else if(document.forms[0].finyear.value=="0" )
			{
				alert("Please Select Financial Year");
				return false;
			}
			else
	{
		document.forms[0].dname.value = document.forms[0].district.options[document.forms[0].district.selectedIndex].text;
		//alert(document.forms[0].dname.value);
		document.forms[0].mode.value = "report";
		document.forms[0].action= "rws_Exp_Rel_Pro_MonExprpt_groupsec.jsp";
		document.forms[0].submit();
}
}

</script>
<head>
<title></title>

 </head>
<body bgcolor="#edf2f8">
 <form> 
<BR>


<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="40%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">	



			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder">	<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
	
			
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">

			<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">Financial Achievement Report </font></td>		
		</tr>
		
		
		<%
		if(loggedUser!=null && (loggedUser.equals(Constants.ADMIN)||loggedUser.equals(Constants.LAKH_USER) ||loggedUser.equals(Constants.GUEST)||loggedUser.equals(Constants.SEC_USER)))
		{
		%>
			<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" >
           <option value="">-Select-</option> 
		  <% if(request.getParameter("district")!=null && request.getParameter("district").equals("All")){%>
			<option value="All" selected>All</option>
			<%}else{%>
			<option value="All">All</option><%}
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rs.getString(1).equals(dcode))
					{
					%>
					<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
					<%
					}
					else
					{
					%>
					<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
					<%
					}
				}
				rs.close();			
				stmt.close();
				%></select>
				 
			<%
		}
		else
		{
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
					query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>
			
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%>	<tr>
<%@ include file="financialYear.jsp" %>
		</tr>
	
		<tr>
									<td colspan=2 align=center><input type=button value="View Monthwise Releases" class = btext onclick="fnView1()">
		</td>
		</tr>
		<tr>
				<td colspan=2 align=center>
					<input type=button value="View Monthwise Expenditure" class = btext onclick="fnView2()">
		</td>
		</tr>
		
		</table>
		<br>
		<br>
		<%//System.out.println("docein conditionssssss"+request.getParameter("district"));
		//System.out.println("docein conditionssssss"+programe);
		String yr="";
		if(mode!=null && !mode.equals("report")){
		if(finyear!=null)
			yr=finyear.substring(0,4);
		nextyr=finyear.substring(5,9);
		
		//System.out.println("finyear:"+finyear);
		//System.out.println("yyyyyyyy:"+yr);
			//System.out.println("nextyr:"+nextyr);
		if(yr!=null)
			{
			session.setAttribute("yr",yr);
			}
			if(nextyr!=null)
			{
			session.setAttribute("nextyr",nextyr);
			}
			%>

			<table>
		<tr  >
			<td class="rptHeading" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
			<font face=verdana size=2 color=red>(Amount Displayed is in Lakhs)
			</font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
		<%if(finyear.equals("2011-2012")){%>
		<tr><td><font color="red">NOTE:</font> <font color="blue" size="4">State  Releases (01-APR-<%=finyear.substring(0,4)%> To 17-APR-<%=finyear.substring(0,4)%>) between these dates are related to<br> last Financial year Payments(As per dept officials)</font></td></tr>
		<%}%>
		</table><br>

		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	

		<tr align=center>
		<td class="gridhdbg" rowspan="2">Sl.No</td>
		<td class="gridhdbg" rowspan="2">Programme</td>
				
		
		<td class="gridhdbg" colspan="13" >Expenditure(01-APR-<%=finyear.substring(0,4)%> &nbsp;To 31-MAR-<%=finyear.substring(5,9)%>)</td>
		</tr>
		<tr>
			
		<!-- <td class=btext align="center">Offline Release(Upto 31-MAR-<%=finyear.substring(5,9)%>)</td>
		<td class=btext align="center" >Grand Total</td>
		 --><td class="gridhdbg" align="center" >APR</td>
		<td class="gridhdbg" align="center" >MAY</td>
		<td class="gridhdbg"  align="center" >JUN</td>
		<td class="gridhdbg"  align="center" >JUL</td>
		<td class="gridhdbg"  align="center" >AUG</td>
		<td class="gridhdbg"  align="center" >SEP</td>
		<td class="gridhdbg"  align="center" >OCT</td>
		<td class="gridhdbg"  align="center" >NOV</td>
		<td class="gridhdbg"  align="center" >DEC</td>
		<td class="gridhdbg"  align="center" >JAN</td>
		<td class="gridhdbg" align="center" >FEB</td>
		<td class="gridhdbg"  align="center" >MAR</td>
		<td class="gridhdbg" align="center" >Total EXP.</td>
		

		</tr>
		<tr><td align="center" class="gridhdbg">1</td>
		<td align="center" class="gridhdbg">2</td>
		<td align="center" class="gridhdbg">3</td>
		<td align="center" class="gridhdbg">4</td>
		<td align="center" class="gridhdbg">5</td>
		<td align="center" class="gridhdbg" >6</td>
		<td align="center" class="gridhdbg">7</td>
		<td align="center" class="gridhdbg">8</td>
		<td align="center" class="gridhdbg">9</td>
		<td align="center" class="gridhdbg">10</td>
		<td align="center" class="gridhdbg">11</td>
		<td align="center" class="gridhdbg">12</td>
		<td align="center" class="gridhdbg">13</td>
		<td align="center" class="gridhdbg">14</td>
		<td align="center" class="gridhdbg">15</td></tr>
		<%

			 Statement stmt2=null;
		ResultSet rs2=null;
	
		String obqry="select sum(BILL_AMT_ADMISSIBLE),substr(b.work_id,1,2) from RWS_work_bill_TBL  a,rws_work_admn_tbl b where a.work_id=b.work_id and to_date(bill_date)<='31-MAR-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) obqry += " and substr(office_code,2,2)='"+dcode+"'";
		obqry += " group by substr(b.work_id,1,2) ";
		Statement	stmt1=conn.createStatement();
		//System.out.println("wwwww:"+obqry);
		ResultSet rs1=stmt1.executeQuery(obqry);
		Hashtable h1=new Hashtable();
		while(rs1.next())
		{
		h1.put(rs1.getString(2),rs1.getString(1));
		}
		if(rs1!=null)rs1.close();
		if(stmt1!=null)stmt1.close();
		String billcqry="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-APR-"+yr+"' and to_date(bank_send_date)<='31-MAR-"+nextyr+"' and txid is not null ";
		if(dcode!=null && !dcode.equals("All")) billcqry += " and substr(a.office_code,2,2)='"+dcode+"'";
		billcqry += " group by substr(a.work_id,1,2) ";
			stmt2=conn.createStatement();
		//System.out.println("billcqry1expm:"+billcqry);
		 rs2=stmt2.executeQuery(billcqry);
		Hashtable h2=new Hashtable();
		while(rs2.next())
		{
		h2.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		String billsqry="select sum(BILL_AMOUT_STATE ),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>'17-APR-"+yr+"' and to_date(state_send_date)<='31-MAR-"+nextyr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) billsqry += " and substr(a.office_code,2,2)='"+dcode+"'";
		billsqry += " group by substr(a.work_id,1,2) ";
		Statement	stmt3=conn.createStatement();
		//System.out.println("billsqry1sree:"+billsqry);
		ResultSet rs3=stmt3.executeQuery(billsqry);
		Hashtable h3=new Hashtable();
		while(rs3.next())
		{
		h3.put(rs3.getString(2),rs3.getString(1));
		}
		if(rs3!=null)rs3.close();
		if(stmt3!=null)stmt3.close();

		String billvqry="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-APR-"+yr+"' and to_date(voucher_dt)<='31-Mar-"+nextyr+"' ";
		if(dcode!=null && !dcode.equals("All")) billvqry += " and substr(w.office_code,2,2)='"+dcode+"'";
		billvqry += " group by substr(a.work_id,1,2) ";
		Statement	stmt4=conn.createStatement();
		//System.out.println("billvqry:sree"+billvqry);
		ResultSet rs4=stmt4.executeQuery(billvqry);
		Hashtable h4=new Hashtable();
		while(rs4.next())
		{
		h4.put(rs4.getString(2),rs4.getString(1));
		}
		if(rs4!=null)rs4.close();
		if(stmt4!=null)stmt4.close();


String aprq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-APR-"+yr+"' and to_date(voucher_dt)<'01-MAY-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) aprq += " and substr(w.office_code,2,2)='"+dcode+"'";
		aprq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("aprq:"+aprq);
		rs2=stmt2.executeQuery(aprq);
		Hashtable aprh=new Hashtable();
		while(rs2.next())
		{
		aprh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		String mayq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-MAY-"+yr+"' and to_date(voucher_dt)<'01-JUN-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) mayq += " and substr(w.office_code,2,2)='"+dcode+"'";
		mayq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("mayq:"+mayq);
		rs2=stmt2.executeQuery(mayq);
		Hashtable mayh=new Hashtable();
		while(rs2.next())
		{
		mayh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
    String junq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-JUN-"+yr+"' and to_date(voucher_dt)<'01-JUL-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) junq += " and substr(w.office_code,2,2)='"+dcode+"'";
		junq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("junq:"+junq);
		rs2=stmt2.executeQuery(junq);
		Hashtable junh=new Hashtable();
		while(rs2.next())
		{
		junh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String julq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-JUL-"+yr+"' and to_date(voucher_dt)<'01-AUG-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) julq += " and substr(w.office_code,2,2)='"+dcode+"'";
		julq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("julq:"+julq);
		rs2=stmt2.executeQuery(julq);
		Hashtable julh=new Hashtable();
		while(rs2.next())
		{
		julh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String augq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-AUG-"+yr+"' and to_date(voucher_dt)<'01-SEP-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) augq += " and substr(w.office_code,2,2)='"+dcode+"'";
		augq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("augq:"+augq);
		rs2=stmt2.executeQuery(augq);
		Hashtable augh=new Hashtable();
		while(rs2.next())
		{
		augh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String sepq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-SEP-"+yr+"' and to_date(voucher_dt)<'01-OCT-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) sepq += " and substr(w.office_code,2,2)='"+dcode+"'";
		sepq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("sepq:"+sepq);
		rs2=stmt2.executeQuery(sepq);
		Hashtable seph=new Hashtable();
		while(rs2.next())
		{
		seph.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String octq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-OCT-"+yr+"' and to_date(voucher_dt)<'01-NOV-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) octq += " and substr(w.office_code,2,2)='"+dcode+"'";
		octq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("octq:"+octq);
		rs2=stmt2.executeQuery(octq);
		Hashtable octh=new Hashtable();
		while(rs2.next())
		{
		octh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String novq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-NOV-"+yr+"' and to_date(voucher_dt)<'01-DEC-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) novq += " and substr(w.office_code,2,2)='"+dcode+"'";
		novq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("novq:"+novq);
		rs2=stmt2.executeQuery(novq);
		Hashtable novh=new Hashtable();
		while(rs2.next())
		{
		novh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();

String decq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-DEC-"+yr+"' and to_date(voucher_dt)<'01-JAN-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) decq += " and substr(w.office_code,2,2)='"+dcode+"'";
		decq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("decq:"+decq);
		rs2=stmt2.executeQuery(decq);
		Hashtable dech=new Hashtable();
		while(rs2.next())
		{
		dech.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String janq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-JAN-"+nextyr+"' and to_date(voucher_dt)<'01-FEB-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) janq += " and substr(w.office_code,2,2)='"+dcode+"'";
		janq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
	//	System.out.println("janq:"+janq);
		rs2=stmt2.executeQuery(janq);
		Hashtable janh=new Hashtable();
		while(rs2.next())
		{
		janh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String febq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-FEB-"+nextyr+"' and to_date(voucher_dt)<'01-MAR-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) febq += " and substr(w.office_code,2,2)='"+dcode+"'";
		febq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("febq:"+febq);
		rs2=stmt2.executeQuery(febq);
		Hashtable febh=new Hashtable();
		while(rs2.next())
		{
		febh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		String marq="select sum(voucher_AMT),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-MAR-"+nextyr+"' and to_date(voucher_dt)<'01-APR-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) marq += " and substr(w.office_code,2,2)='"+dcode+"'";
		marq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("marq:"+marq);
		rs2=stmt2.executeQuery(marq);
		Hashtable marh=new Hashtable();
		while(rs2.next())
		{
		marh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();



		//mounika

		String billvqry1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-APR-"+yr+"' and to_date(voucher_dt)<='31-Mar-"+nextyr+"' ";
				if(dcode!=null && !dcode.equals("All")) billvqry1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				billvqry1 += " group by substr(a.work_id,1,2) ";
				Statement	stmt5=conn.createStatement();
				//System.out.println("billvqry:sree"+billvqry1);
				ResultSet rs5=stmt5.executeQuery(billvqry1);
				Hashtable h5=new Hashtable();
				while(rs5.next())
				{
				h5.put(rs5.getString(2),rs5.getString(1));
				}
				if(rs5!=null)rs5.close();
				if(stmt5!=null)stmt5.close();


		String aprq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-APR-"+yr+"' and to_date(voucher_dt)<'01-MAY-"+yr+"'";
				if(dcode!=null && !dcode.equals("All")) aprq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				aprq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
				//System.out.println("aprq1:"+aprq1);
				rs2=stmt2.executeQuery(aprq1);
				Hashtable aprh1=new Hashtable();
				while(rs2.next())
				{
				aprh1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		String mayq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-MAY-"+yr+"' and to_date(voucher_dt)<'01-JUN-"+yr+"'";
				if(dcode!=null && !dcode.equals("All")) mayq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				mayq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
				//System.out.println("mayq1:"+mayq1);
				rs2=stmt2.executeQuery(mayq1);
				Hashtable mayh1=new Hashtable();
				while(rs2.next())
				{
				mayh1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		    String junq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-JUN-"+yr+"' and to_date(voucher_dt)<'01-JUL-"+yr+"'";
				if(dcode!=null && !dcode.equals("All")) junq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				junq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
				//System.out.println("junq1:"+junq1);
				rs2=stmt2.executeQuery(junq1);
				Hashtable junh1=new Hashtable();
				while(rs2.next())
				{
				junh1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		String julq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-JUL-"+yr+"' and to_date(voucher_dt)<'01-AUG-"+yr+"'";
				if(dcode!=null && !dcode.equals("All")) julq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				julq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
				//System.out.println("julq1:"+julq1);
				rs2=stmt2.executeQuery(julq1);
				Hashtable julh1=new Hashtable();
				while(rs2.next())
				{
				julh1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		String augq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-AUG-"+yr+"' and to_date(voucher_dt)<'01-SEP-"+yr+"'";
				if(dcode!=null && !dcode.equals("All")) augq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				augq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
				//System.out.println("augq1:"+augq1);
				rs2=stmt2.executeQuery(augq1);
				Hashtable augh1=new Hashtable();
				while(rs2.next())
				{
				augh1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		String sepq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-SEP-"+yr+"' and to_date(voucher_dt)<'01-OCT-"+yr+"'";
				if(dcode!=null && !dcode.equals("All")) sepq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				sepq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
			   // System.out.println("sepq1:"+sepq1);
				rs2=stmt2.executeQuery(sepq1);
				Hashtable seph1=new Hashtable();
				while(rs2.next())
				{
				seph1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		String octq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-OCT-"+yr+"' and to_date(voucher_dt)<'01-NOV-"+yr+"'";
				if(dcode!=null && !dcode.equals("All")) octq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				octq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
				//System.out.println("octq1:"+octq1);
				rs2=stmt2.executeQuery(octq1);
				Hashtable octh1=new Hashtable();
				while(rs2.next())
				{
				octh1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		String novq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-NOV-"+yr+"' and to_date(voucher_dt)<'01-DEC-"+yr+"'";
				if(dcode!=null && !dcode.equals("All")) novq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				novq1+= " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
				//System.out.println("novq1:"+novq1);
				rs2=stmt2.executeQuery(novq1);
				Hashtable novh1=new Hashtable();
				while(rs2.next())
				{
				novh1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();

		String decq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-DEC-"+yr+"' and to_date(voucher_dt)<'01-JAN-"+nextyr+"'";
				if(dcode!=null && !dcode.equals("All")) decq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				decq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
				//System.out.println("decq1:"+decq1);
				rs2=stmt2.executeQuery(decq1);
				Hashtable dech1=new Hashtable();
				while(rs2.next())
				{
				dech1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		String janq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-JAN-"+nextyr+"' and to_date(voucher_dt)<'01-FEB-"+nextyr+"'";
				if(dcode!=null && !dcode.equals("All")) janq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				janq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
			 	//System.out.println("janq1:"+janq1);
				rs2=stmt2.executeQuery(janq1);
				Hashtable janh1=new Hashtable();
				while(rs2.next())
				{
				janh1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		String febq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-FEB-"+nextyr+"' and to_date(voucher_dt)<'01-MAR-"+nextyr+"'";
				if(dcode!=null && !dcode.equals("All")) febq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				febq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
				//System.out.println("febq1:"+febq1);
				rs2=stmt2.executeQuery(febq1);
				Hashtable febh1=new Hashtable();
				while(rs2.next())
				{
				febh1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
	String marq1="select sum(voucher_AMT),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-MAR-"+nextyr+"' and to_date(voucher_dt)<'01-APR-"+nextyr+"'";
				if(dcode!=null && !dcode.equals("All")) marq1 += " and substr(w.office_code,2,2)='"+dcode+"'";
				marq1 += " group by substr(a.work_id,1,2) ";
				stmt2=conn.createStatement();
				//System.out.println("marq1:"+marq1);
				rs2=stmt2.executeQuery(marq1);
				Hashtable marh1=new Hashtable();
				while(rs2.next())
				{
				marh1.put(rs2.getString(2),rs2.getString(1));
				}
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		     
		       //mounika



     String qry="select *	 from rws_programme_tbl where programme_code in('01','02','18','23','32','48','49','51','53','58','59','60','04','46','12','15','57') order by 1";
	//System.out.println("qry111sree:"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	double gcapr=0,gcmay=0,gcjun=0,gcjul=0,gcaug=0,gcsep=0,gcoct=0,gcnov=0,gcdec=0,gcjan=0,gcfeb=0,gcmar=0;
	double gcen=0;
	
	HashSet nrdwpProgList=new HashSet();
	nrdwpProgList.add("01");
	nrdwpProgList.add("02");
	nrdwpProgList.add("18");
	nrdwpProgList.add("23");
	nrdwpProgList.add("32");
	nrdwpProgList.add("48");
	nrdwpProgList.add("49");
	nrdwpProgList.add("51");
	nrdwpProgList.add("53");
	nrdwpProgList.add("58");
	nrdwpProgList.add("59");
	nrdwpProgList.add("60");
	
	boolean flag=false;
	double gcamt=0;
	double gcevAmt=0;
	double gsvAmt=0;
	 double camt=0;
	    double samt=0;
	    double gvAmt=0;

		int styleCount=0;
		String style="";
	
	
	while(rs.next())
	{
		
       /*String wbtot=""+h1.get(rs.getString(1));
	    if(wbtot!=null && !wbtot.equals("") && !wbtot.equals("null")){}else{wbtot="0";}*/
		String cenamt=""+h2.get(rs.getString(1));
	    if(cenamt!=null && !cenamt.equals("") && !cenamt.equals("null")){}else{cenamt="0";}
		 String staamt=""+h3.get(rs.getString(1));
	    if(staamt!=null && !staamt.equals("") && !staamt.equals("null")){}else{staamt="0";}
		 String vamt=""+h4.get(rs.getString(1));
	    if(vamt!=null && !vamt.equals("") && !vamt.equals("null")){}else{vamt="0";}
		double tot=Double.parseDouble(cenamt)+Double.parseDouble(staamt);
		String apra=""+aprh.get(rs.getString(1));
	    if(apra!=null && !apra.equals("") && !apra.equals("null")){}else{apra="0";}
		String maya=""+mayh.get(rs.getString(1));
	    if(maya!=null && !maya.equals("") && !maya.equals("null")){}else{maya="0";}
		String juna=""+junh.get(rs.getString(1));
	    if(juna!=null && !juna.equals("") && !juna.equals("null")){}else{juna="0";}
		String jula=""+julh.get(rs.getString(1));
	    if(jula!=null && !jula.equals("") && !jula.equals("null")){}else{jula="0";}
		String auga=""+augh.get(rs.getString(1));
	    if(auga!=null && !auga.equals("") && !auga.equals("null")){}else{auga="0";}
		String sepa=""+seph.get(rs.getString(1));
	    if(sepa!=null && !sepa.equals("") && !sepa.equals("null")){}else{sepa="0";}
		String octa=""+octh.get(rs.getString(1));
	    if(octa!=null && !octa.equals("") && !octa.equals("null")){}else{octa="0";}
		String nova=""+novh.get(rs.getString(1));
	    if(nova!=null && !nova.equals("") && !nova.equals("null")){}else{nova="0";}
		String deca=""+dech.get(rs.getString(1));
	    if(deca!=null && !deca.equals("") && !deca.equals("null")){}else{deca="0";}
		String jana=""+janh.get(rs.getString(1));
	    if(jana!=null && !jana.equals("") && !jana.equals("null")){}else{jana="0";}
		String feba=""+febh.get(rs.getString(1));
	    if(feba!=null && !feba.equals("") && !feba.equals("null")){}else{feba="0";}
		String mara=""+marh.get(rs.getString(1));
	    if(mara!=null && !mara.equals("") && !mara.equals("null")){}else{mara="0";}
	    
	    
	    String apra1=""+aprh1.get(rs.getString(1));
	    if(apra1!=null && !apra1.equals("") && !apra1.equals("null")){}else{apra1="0";}
		String maya1=""+mayh1.get(rs.getString(1));
	    if(maya1!=null && !maya1.equals("") && !maya1.equals("null")){}else{maya1="0";}
		String juna1=""+junh1.get(rs.getString(1));
	    if(juna1!=null && !juna1.equals("") && !juna1.equals("null")){}else{juna1="0";}
		String jula1=""+julh1.get(rs.getString(1));
	    if(jula1!=null && !jula1.equals("") && !jula1.equals("null")){}else{jula1="0";}
		String auga1=""+augh1.get(rs.getString(1));
	    if(auga1!=null && !auga1.equals("") && !auga1.equals("null")){}else{auga1="0";}
		String sepa1=""+seph1.get(rs.getString(1));
	    if(sepa1!=null && !sepa1.equals("") && !sepa1.equals("null")){}else{sepa1="0";}
		String octa1=""+octh1.get(rs.getString(1));
	    if(octa1!=null && !octa1.equals("") && !octa1.equals("null")){}else{octa1="0";}
		String nova1=""+novh1.get(rs.getString(1));
	    if(nova1!=null && !nova1.equals("") && !nova1.equals("null")){}else{nova1="0";}
		String deca1=""+dech1.get(rs.getString(1));
	    if(deca1!=null && !deca1.equals("") && !deca1.equals("null")){}else{deca1="0";}
		String jana1=""+janh1.get(rs.getString(1));
	    if(jana1!=null && !jana1.equals("") && !jana1.equals("null")){}else{jana1="0";}
		String feba1=""+febh1.get(rs.getString(1));
	    if(feba1!=null && !feba1.equals("") && !feba1.equals("null")){}else{feba1="0";}
		String mara1=""+marh1.get(rs.getString(1));
	    if(mara1!=null && !mara1.equals("") && !mara1.equals("null")){}else{mara1="0";}
	    
	    
	    
	    double gapr1=0,gmay1=0,gjun1=0,gjul1=0,gaug1=0,gsep1=0,goct1=0,gnov1=0,gdec1=0,gjan1=0,gfeb1=0,gmar1=0;
		gapr1+=(Double.parseDouble(apra1)/100000);
		gmay1+=(Double.parseDouble(maya1)/100000);
		gjun1+=(Double.parseDouble(juna1)/100000);
		gjul1+=(Double.parseDouble(jula1)/100000);
		gaug1+=(Double.parseDouble(auga1)/100000);
		gsep1+=(Double.parseDouble(sepa1)/100000);
		goct1+=(Double.parseDouble(octa1)/100000);
		gnov1+=(Double.parseDouble(nova1)/100000);
		gdec1+=(Double.parseDouble(deca1)/100000);
		gjan1+=(Double.parseDouble(jana1)/100000);
		gfeb1+=(Double.parseDouble(feba1)/100000);
		gmar1+=(Double.parseDouble(mara1)/100000);
	    
		double total=gapr1+gmay1+gjun1+gjul1+gaug1+gsep1+goct1+gnov1+gdec1+gjan1+gfeb1+gmar1;
		
		
		 /*   System.out.println("pppapr"+gapr1);
		    System.out.println("pppmay"+gmay1);
		    System.out.println("pppjun"+gjun1);
		    System.out.println("pppjul"+gjul1);
		    System.out.println("pppaug"+gaug1);
		    System.out.println("pppsep"+gsep1);
		    System.out.println("ppopoct"+goct1);
		    System.out.println("pppnov"+gnov1);
		    System.out.println("pppdec"+gdec1);
		    System.out.println("pppj"+gjan1);
		    System.out.println("pppf"+gfeb1);
		    System.out.println("pppm"+gmar1);
	    */
	    gvAmt=(Double.parseDouble(vamt)/100000);
		if(nrdwpProgList.contains(rs.getString(1))){
			
			gcapr+=(Double.parseDouble(apra)/100000);
			gcmay+=(Double.parseDouble(maya)/100000);
			gcjun+=(Double.parseDouble(juna)/100000);
			gcjul+=(Double.parseDouble(jula)/100000);
			gcaug+=(Double.parseDouble(auga)/100000);
			gcsep+=(Double.parseDouble(sepa)/100000);
			gcoct+=(Double.parseDouble(octa)/100000);
			gcnov+=(Double.parseDouble(nova)/100000);
			gcdec+=(Double.parseDouble(deca)/100000);
			gcjan+=(Double.parseDouble(jana)/100000);
			gcfeb+=(Double.parseDouble(feba)/100000);
			gcmar+=(Double.parseDouble(mara)/100000);
			gcamt+=gvAmt;
					
			/*
			 System.out.println("apr222"+gcapr);
			    System.out.println("may22"+gcmay);
			    System.out.println("jun22"+gcjun);
			    System.out.println("jul22"+gcjul);
			    System.out.println("aug22"+gcaug);
			    System.out.println("sep22"+gcsep);
			    System.out.println("oct22"+gcoct);
			    System.out.println("nov22"+gcnov);
			    System.out.println("dec22"+gcdec);
			    System.out.println("j22"+gcjan);
			    System.out.println("f22"+gcfeb);
			    System.out.println("m22"+gcmar);
			 */
			//System.out.println("Program:"+camt);
			//System.out.println("Tot Program:"+gcen);
			if(!rs.getString(1).equals("60")){
			continue;
			}else{
				flag=true;
			}
			
		}else {
			
			  samt=(Double.parseDouble(staamt)/100000);
				
		}
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		if(!flag){
		
%>              
		<tr>	<td class="<%=style %>" style="text-align: left;"><%=sno++%></td>
		<td   class="<%=style %>" style="text-align: left;" nowrap><%=rs.getString("programme_name")%></td>
		
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gapr1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gmay1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gjun1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gjul1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gaug1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%= ndf.format(gsep1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%= ndf.format(goct1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%= ndf.format(gnov1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%= ndf.format(gdec1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%= ndf.format(gjan1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%= ndf.format(gfeb1)%></td>
			<td class="<%=style %>" style="text-align: right;"><%= ndf.format(gmar1)%></td>
					

		<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(total)%></td>
		</tr>
		<%
		
		gcen=gvAmt;
		//System.out.println("gsvAmt:"+gsvAmt);
		}else {
	
				%>
				
				<tr>	<td class="<%=style %>" style="text-align: left;"><%=sno++%></td>
			<td  class="<%=style %>" style="text-align: left;" nowrap>NRDWP- Related</td>
		
		
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcapr)%></td>
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcmay)%></td>
		
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcjun)%></td>
			
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcjul)%></td>
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcaug)%></td>
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcsep)%></td>
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcoct)%></td>
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcnov)%></td>
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcdec)%></td>
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcjan)%></td>
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcfeb)%></td>
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcmar)%></td>
			
			<td  class="<%=style %>" style="text-align: right;"><%=ndf.format(gcamt) %></td>
			
			
		</tr>
		<%	total=gcamt; }
		 tot=gcen+samt;
		
		
		 stot+=samt;
			ctot+=camt;
		
		
			stot+=Double.parseDouble(staamt);
		    ctot+=Double.parseDouble(cenamt);
		//mtot+=Double.parseDouble(wbtot);
	//	gmtot+=texp;
			//obtot+=Double.parseDouble(obamt);
			ttot+=tot;
			//ttot1+=tot1;
	
			vtot+=(total);
			//ttot2+=tot2;
	}%>
<tr>
	<td class="gridhdbg" colspan="14" align="right" >Total : </td>
	 <td class="gridhdbg"align="right" ><%=ndf.format(vtot)%></td>
	</tr>
	<%}%>
	</table>
	<input type="hidden" name="mode">
		<input type="hidden" name="dname">
	</form>
	</body>
	<br>
	
	<font face=verdana size=2 color=red>
<b><bean:message key="app.nrdwprelatedfin"/>



	</font>

	<%@ include file="/commons/rws_footer.jsp"%>
	</html>