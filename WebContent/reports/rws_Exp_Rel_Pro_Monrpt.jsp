<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<html>
<% DecimalFormat ndf = new DecimalFormat("####.00");
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
		//System.out.println("finyear value::"+finyear);
		String mode = request.getParameter("mode");	
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
		document.forms[0].action= "rws_Exp_Rel_Pro_Monrpt.jsp";
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
		document.forms[0].action= "rws_Exp_Rel_Pro_MonExprpt.jsp";
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
			<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back</a>|
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
		if(loggedUser!=null && (loggedUser.equals(Constants.ADMIN)||loggedUser.equals(Constants.LAKH_USER) ||loggedUser.equals(Constants.GUEST) ||loggedUser.equals(Constants.MINISTER) ||loggedUser.equals("EE-Budget") ||loggedUser.equals(Constants.SEC_USER) ||loggedUser.substring(0,3).equals("col") || loggedUser.equals("minrwss") ||loggedUser.toString().equals("ENC")||loggedUser.toString().equals("cerwss")||loggedUser.toString().equals("pdswsm")||loggedUser.toString().equals("pdccdu")||loggedUser.toString().equals("ce_nab")||loggedUser.toString().equals("ce_stp")||loggedUser.toString().equals("ce_vqc")))
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
	
		<tr align="center">
		<td colspan=2 align=center>
		<input type=button value="View Report" class = btext onclick="fnView()"></td><tr><td colspan=2 align=center>
		<input type=button value="View Monthwise Releases" class = btext onclick="fnView1()">
		</td>
		</tr>
		<tr>
		<td colspan=2 align=center>
		<input type=button value="View Monthwise Expenditure" class = btext onclick="fnView2()">
		</td>
		</tr>
		<input type="hidden" name="mode">
		<input type="hidden" name="dname">
		</table>
		<br>
		<br>
		<%//System.out.println("docein conditionssssss"+request.getParameter("district"));
		//System.out.println("docein conditionssssss"+programe);
		String yr="";
		//if(mode!=null && mode.equals("report")){
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
		
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)
			</font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
		<%if(finyear.equals("2011-2012")){%>
		<tr><td><font color="red">NOTE:</font> <font color="blue" size="4">State  Releases (01-APR-<%=finyear.substring(0,4)%> To 17-APR-<%=finyear.substring(0,4)%>) between these dates are related to<br> last Financial year Payments(As per dept officials)</font></td></tr>
		<%}%>
		</table><br>

		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	

		<tr align=center>
		<td class=btext rowspan="3">Sl.No</td>
		<td class=btext rowspan="3">Programme</td>
			<%if(finyear.equals("2011-2012")){%>
		<td class=btext  colspan="3" nowrap>Central Releases During the Year(01-APR-<%=finyear.substring(0,4)%> To 31-MAR-<%=finyear.substring(5,9)%>)<br>State Releases During the Year(17-APR-<%=finyear.substring(0,4)%> To 31-MAR-<%=finyear.substring(5,9)%>)</td>
		<%}else{%>
		<td class=btext  colspan="3" nowrap>Central Releases During the Year(01-APR-<%=finyear.substring(0,4)%> To 31-MAR-<%=finyear.substring(5,9)%>)<br>State Releases During the Year(01-APR-<%=finyear.substring(0,4)%> To 31-MAR-<%=finyear.substring(5,9)%>)</td>
		<%}%>
		
		
		</tr>
		<tr>
				<td class=btext align="center" nowrap colspan=2>APR</td>
				<td class=btext align="center" nowrap colspan=2>MAY</td>
				<td class=btext align="center" nowrap colspan=2>JUN</td>
				<td class=btext align="center" nowrap colspan=2>JULY</td>
				<td class=btext align="center" nowrap colspan=2>AUG</td>
				<td class=btext align="center" nowrap colspan=2>SEP</td>
				<td class=btext align="center" nowrap colspan=2>OCT</td>
				<td class=btext align="center" nowrap colspan=2>NOV</td>
				<td class=btext align="center" nowrap colspan=2>DEC</td>
				<td class=btext align="center" nowrap colspan=2>JAN</td>
				<td class=btext align="center" nowrap colspan=2>FEB</td>
				<td class=btext align="center" nowrap colspan=2>MAR</td>
				<td class=btext align="center" colspan=2>Total</td>
				<td class=btext rowspan="2" >Expenditure(01-APR-<%=finyear.substring(0,4)%><br>To 31-MAR-<%=finyear.substring(5,9)%>)</td>

				</tr>
				<tr>
<td class=btext align=center nowrap >Central</td>
<td class=btext align=center nowrap>State</td>
<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap >Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

<td class=btext align=center nowrap>Central</td>
<td class=btext align=center nowrap>State</td>

		</tr>
<% Statement stmt2=null;
		ResultSet rs2=null;
		String obqry="select sum(BILL_AMT_ADMISSIBLE),substr(b.work_id,1,2) from RWS_work_bill_TBL  a,rws_work_admn_tbl b where a.work_id=b.work_id and bill_date<='31-MAR-"+nextyr+"'";
        //String obqry="select sum(BILL_AMT_ADMISSIBLE),substr(b.work_id,1,2) from RWS_work_bill_TBL  a,rws_work_admn_tbl b where a.work_id=b.work_id and bill_date<'31-MAR-"+nextyr+"'";
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
		//System.out.println("billcqry1sree:"+billcqry);
		 rs2=stmt2.executeQuery(billcqry);
		Hashtable h2=new Hashtable();
		while(rs2.next())
		{
		h2.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		String billsqry="select sum(BILL_AMOUT_STATE ),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>'17-APR-"+yr+"' and to_date(state_send_date)<='31-MAR-"+nextyr+"' and state_txid is not null ";
		if(dcode!=null && !dcode.equals("All")) billsqry += " and substr(a.office_code,2,2)='"+dcode+"'";
		billsqry += " group by substr(a.work_id,1,2) ";
		Statement	stmt3=conn.createStatement();
		//System.out.println("State total:"+billsqry);
		ResultSet rs3=stmt3.executeQuery(billsqry);
		Hashtable h3=new Hashtable();
		while(rs3.next())
		{
		h3.put(rs3.getString(2),rs3.getString(1));
		}
		if(rs3!=null)rs3.close();
		if(stmt3!=null)stmt3.close();

		String billvqry="select sum(voucher_AMT ),substr(a.work_id,1,2) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt) >='01-APR-"+yr+"' and to_date(voucher_dt)<='31-Mar-"+nextyr+"' ";
		if(dcode!=null && !dcode.equals("All")) billvqry += " and substr(w.office_code,2,2)='"+dcode+"'";
		billvqry += " group by substr(a.work_id,1,2) ";
		Statement	stmt4=conn.createStatement();
		//System.out.println("sTATEtOTAL"+billvqry);
		ResultSet rs4=stmt4.executeQuery(billvqry);
		Hashtable h4=new Hashtable();
		while(rs4.next())
		{
		h4.put(rs4.getString(2),rs4.getString(1));
		}
		if(rs4!=null)rs4.close();
		if(stmt4!=null)stmt4.close();
		String aprq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-APR-"+yr+"' and to_date(bank_send_date)<'01-MAY-"+yr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) aprq += " and substr(a.office_code,2,2)='"+dcode+"'";
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
		String mayq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-MAY-"+yr+"' and to_date(bank_send_date)<'01-JUN-"+yr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) mayq += " and substr(a.office_code,2,2)='"+dcode+"'";
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
    String junq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-JUN-"+yr+"' and to_date(bank_send_date)<'01-JUL-"+yr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) junq += " and substr(a.office_code,2,2)='"+dcode+"'";
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
String julq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-JUL-"+yr+"' and to_date(bank_send_date)<'01-AUG-"+yr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) julq += " and substr(a.office_code,2,2)='"+dcode+"'";
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
String augq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-AUG-"+yr+"' and to_date(bank_send_date)<'01-SEP-"+yr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) augq += " and substr(a.office_code,2,2)='"+dcode+"'";
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
String sepq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-SEP-"+yr+"' and to_date(bank_send_date)<'01-OCT-"+yr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) sepq += " and substr(a.office_code,2,2)='"+dcode+"'";
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
String octq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-OCT-"+yr+"' and to_date(bank_send_date)<'01-NOV-"+yr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) octq += " and substr(a.office_code,2,2)='"+dcode+"'";
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
String novq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-NOV-"+yr+"' and to_date(bank_send_date)<'01-DEC-"+yr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) novq += " and substr(a.office_code,2,2)='"+dcode+"'";
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

String decq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-DEC-"+yr+"' and to_date(bank_send_date)<'01-JAN-"+nextyr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) decq += " and substr(a.office_code,2,2)='"+dcode+"'";
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
String janq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-JAN-"+nextyr+"' and to_date(bank_send_date)<'01-FEB-"+nextyr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) janq += " and substr(a.office_code,2,2)='"+dcode+"'";
		janq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("janq:"+janq);
		rs2=stmt2.executeQuery(janq);
		Hashtable janh=new Hashtable();
		while(rs2.next())
		{
		janh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String febq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-FEB-"+nextyr+"' and to_date(bank_send_date)<'01-MAR-"+nextyr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) febq += " and substr(a.office_code,2,2)='"+dcode+"'";
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
		String marq="select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,1,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-MAR-"+nextyr+"' and to_date(bank_send_date)<'01-APR-"+nextyr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) marq += " and substr(a.office_code,2,2)='"+dcode+"'";
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



String saprq="select sum(BILL_AMOUT_state ),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>'17-APR-"+yr+"' and to_date(state_send_date)<'01-MAY-"+yr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) saprq += " and substr(a.office_code,2,2)='"+dcode+"'";
		saprq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("saprq:"+saprq);
		rs2=stmt2.executeQuery(saprq);
		Hashtable saprh=new Hashtable();
		while(rs2.next())
		{
		saprh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		String smayq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-MAY-"+yr+"' and to_date(state_send_date)<'01-JUN-"+yr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) smayq += " and substr(a.office_code,2,2)='"+dcode+"'";
		smayq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("smayq:"+smayq);
		rs2=stmt2.executeQuery(smayq);
		Hashtable smayh=new Hashtable();
		while(rs2.next())
		{
		smayh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
    String sjunq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-JUN-"+yr+"' and to_date(state_send_date)<'01-JUL-"+yr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) sjunq += " and substr(a.office_code,2,2)='"+dcode+"'";
		sjunq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("sjunq:"+sjunq);
		rs2=stmt2.executeQuery(sjunq);
		Hashtable sjunh=new Hashtable();
		while(rs2.next())
		{
		sjunh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String sjulq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-JUL-"+yr+"' and to_date(state_send_date)<'01-AUG-"+yr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) sjulq += " and substr(a.office_code,2,2)='"+dcode+"'";
		sjulq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("sjulq:"+sjulq);
		rs2=stmt2.executeQuery(sjulq);
		Hashtable sjulh=new Hashtable();
		while(rs2.next())
		{
		sjulh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String saugq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-AUG-"+yr+"' and to_date(state_send_date)<'01-SEP-"+yr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) saugq += " and substr(a.office_code,2,2)='"+dcode+"'";
		saugq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("saugq:"+saugq);
		rs2=stmt2.executeQuery(saugq);
		Hashtable saugh=new Hashtable();
		while(rs2.next())
		{
		saugh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String ssepq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-SEP-"+yr+"' and to_date(state_send_date)<'01-OCT-"+yr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) ssepq += " and substr(a.office_code,2,2)='"+dcode+"'";
		ssepq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("ssepq:"+ssepq);
		rs2=stmt2.executeQuery(ssepq);
		Hashtable sseph=new Hashtable();
		while(rs2.next())
		{
		sseph.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String soctq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-OCT-"+yr+"' and to_date(state_send_date)<'01-NOV-"+yr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) soctq += " and substr(a.office_code,2,2)='"+dcode+"'";
		soctq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("soctq:"+soctq);
		rs2=stmt2.executeQuery(soctq);
		Hashtable socth=new Hashtable();
		while(rs2.next())
		{
		socth.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String snovq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-NOV-"+yr+"' and to_date(state_send_date)<'01-DEC-"+yr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) snovq += " and substr(a.office_code,2,2)='"+dcode+"'";
		snovq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("snovq:"+snovq);
		rs2=stmt2.executeQuery(snovq);
		Hashtable snovh=new Hashtable();
		while(rs2.next())
		{
		snovh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();

String sdecq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-DEC-"+yr+"' and to_date(state_send_date)<'01-JAN-"+nextyr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) sdecq += " and substr(a.office_code,2,2)='"+dcode+"'";
		sdecq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("sdecq:"+sdecq);
		rs2=stmt2.executeQuery(sdecq);
		Hashtable sdech=new Hashtable();
		while(rs2.next())
		{
		sdech.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String sjanq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-JAN-"+nextyr+"' and to_date(state_send_date)<'01-FEB-"+nextyr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) sjanq += " and substr(a.office_code,2,2)='"+dcode+"'";
		sjanq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("sjanq:"+sjanq);
		rs2=stmt2.executeQuery(sjanq);
		Hashtable sjanh=new Hashtable();
		while(rs2.next())
		{
		sjanh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String sfebq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-FEB-"+nextyr+"' and to_date(state_send_date)<'01-MAR-"+nextyr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) sfebq += " and substr(a.office_code,2,2)='"+dcode+"'";
		sfebq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		///System.out.println("sfebq:"+sfebq);
		rs2=stmt2.executeQuery(sfebq);
		Hashtable sfebh=new Hashtable();
		while(rs2.next())
		{
		sfebh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		String smarq="select sum(BILL_AMOUT_STATE),substr(a.work_id,1,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-MAR-"+nextyr+"' and to_date(state_send_date)<'01-APR-"+nextyr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) smarq += " and substr(a.office_code,2,2)='"+dcode+"'";
		smarq += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("smarq:"+smarq);
		rs2=stmt2.executeQuery(smarq);
		Hashtable smarh=new Hashtable();
		while(rs2.next())
		{
		smarh.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();



     String qry="select *	 from rws_programme_tbl where   programme_code not in ('00') order by 1";
	//System.out.println("qry111sree:"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	while(rs.next())
	{
		
         String wbtot=""+h1.get(rs.getString(1));
	    if(wbtot!=null && !wbtot.equals("") && !wbtot.equals("null")){}else{wbtot="0";}
		 String cenamt=""+h2.get(rs.getString(1));
	    if(cenamt!=null && !cenamt.equals("") && !cenamt.equals("null")){}else{cenamt="0";}
		 String staamt=""+h3.get(rs.getString(1));
	    if(staamt!=null && !staamt.equals("") && !staamt.equals("null")){}else{staamt="0";}
		 String vamt=""+h4.get(rs.getString(1));
	    if(vamt!=null && !vamt.equals("") && !vamt.equals("null")){}else{vamt="0";}
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
		


		String sapra=""+saprh.get(rs.getString(1));
	    if(sapra!=null && !sapra.equals("") && !sapra.equals("null")){}else{sapra="0";}
		String smaya=""+smayh.get(rs.getString(1));
	    if(smaya!=null && !smaya.equals("") && !smaya.equals("null")){}else{smaya="0";}
		String sjuna=""+sjunh.get(rs.getString(1));
	    if(sjuna!=null && !sjuna.equals("") && !sjuna.equals("null")){}else{sjuna="0";}
		String sjula=""+sjulh.get(rs.getString(1));
	    if(sjula!=null && !sjula.equals("") && !sjula.equals("null")){}else{sjula="0";}
		String sauga=""+saugh.get(rs.getString(1));
	    if(sauga!=null && !sauga.equals("") && !sauga.equals("null")){}else{sauga="0";}
		String ssepa=""+sseph.get(rs.getString(1));
	    if(ssepa!=null && !ssepa.equals("") && !ssepa.equals("null")){}else{ssepa="0";}
		String socta=""+socth.get(rs.getString(1));
	    if(socta!=null && !socta.equals("") && !socta.equals("null")){}else{socta="0";}
		String snova=""+snovh.get(rs.getString(1));
	    if(snova!=null && !snova.equals("") && !snova.equals("null")){}else{snova="0";}
		String sdeca=""+sdech.get(rs.getString(1));
	    if(sdeca!=null && !sdeca.equals("") && !sdeca.equals("null")){}else{sdeca="0";}
		String sjana=""+sjanh.get(rs.getString(1));
	    if(sjana!=null && !sjana.equals("") && !sjana.equals("null")){}else{sjana="0";}
		String sfeba=""+sfebh.get(rs.getString(1));
	    if(sfeba!=null && !sfeba.equals("") && !sfeba.equals("null")){}else{sfeba="0";}
		String smara=""+smarh.get(rs.getString(1));
	    if(smara!=null && !smara.equals("") && !smara.equals("null")){}else{smara="0";}
		
		
		double tot=Double.parseDouble(cenamt)+Double.parseDouble(staamt);
		
%>
		<tr>	<td class=rptValue><%=sno++%></td>
			<td  class=rptValue nowrap><%=rs.getString("programme_name")%></td>
			<td class=rptValue align="right"><%=apra%></td>
			<td class=rptValue align="right"><%=sapra%></td>
			<td class=rptValue align="right"><%=maya%></td>
			<td class=rptValue align="right"><%=smaya%></td>	
			<td class=rptValue align="right"><%=juna%></td>
			<td class=rptValue align="right"><%=sjuna%></td>
			<td class=rptValue align="right"><%=jula%></td>
			<td class=rptValue align="right"><%=sjula%></td>	
			<td class=rptValue align="right"><%=auga%></td>
			<td class=rptValue align="right"><%=sauga%></td>
			<td class=rptValue align="right"><%=sepa%></td>
			<td class=rptValue align="right"><%=ssepa%></td>
			<td class=rptValue align="right"><%=octa%></td>
			<td class=rptValue align="right"><%=socta%></td>
			<td class=rptValue align="right"><%=nova%></td>
			<td class=rptValue align="right"><%=snova%></td>
			<td class=rptValue align="right"><%=deca%></td>
			<td class=rptValue align="right"><%=sdeca%></td>
			<td class=rptValue align="right"><%=jana%></td>
			<td class=rptValue align="right"><%=sjana%></td>
			<td class=rptValue align="right"><%=feba%></td>
			<td class=rptValue align="right"><%=sfeba%></td>
			<td class=rptValue align="right"><%=mara%></td>
			<td class=rptValue align="right"><%=smara%></td>

		<td  class=rptValue align="right"><%=cenamt%></td>
		<td  class=rptValue align="right"><%=staamt%></td>
		<td  class=rptValue align="right"><%=ndf.format(Double.parseDouble(vamt))%></td>
		</tr>
		<%
			stot+=Double.parseDouble(staamt);
		ctot+=Double.parseDouble(cenamt);
		mtot+=Double.parseDouble(wbtot);
		gmtot+=texp;
			//obtot+=Double.parseDouble(obamt);
			ttot+=tot;
			//ttot1+=tot1;
			vtot+=Double.parseDouble(vamt);
			//ttot2+=tot2;
	}%>
<tr>
	<td class="btext" colspan="26" align="right" >Total : </td>
	
	<td class="btext"  align="right"><%=ndf.format(ctot)%></td>
	<td class="btext"  align="right"><%=ndf.format(stot)%></td>
	<td class="btext" align="right"><%=ndf.format(vtot)%></td>
	</tr>
	<%//}%>
	</table>
	<input type="hidden" name="mode">
		<input type="hidden" name="dname">
	</form>
	</body>
	<br>

	<%@ include file="/commons/rws_footer.jsp"%>
	</html>