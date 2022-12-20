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
		System.out.println("finyear value::"+finyear);
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
		document.forms[0].action= "rws_Exp_Rel_Pro_groupsec_rpt.jsp";
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
		document.forms[0].action= "rws_Exp_Rel_Pro_MonExprpt_groupsec.jsp?mode=report";
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

			<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">Financial Achievement Month Wise Report </font></td>		
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
		
		<input type=button value="View Monthwise Releases" class = btext onclick="fnView1()">
		</td>
		</tr>
		<tr>
				<td colspan=2 align=center>
					<input type=button value="View Monthwise Expenditure" class = btext onclick="fnView2()">
		</td>
		</tr>
		<tr>
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
		
			<font face=verdana size=2 color=red>(Amount Displayed is in Lakhs)
			</font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
		<%if(finyear.equals("2011-2012")){%>
		<tr><td><font color="red">NOTE:</font> <font color="blue" size="4">State  Releases (01-APR-<%=finyear.substring(0,4)%> To 17-APR-<%=finyear.substring(0,4)%>) between these dates are related to<br> last Financial year Payments(As per dept officials)</font></td></tr>
		<%}%>
		</table><br>

		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	

		<tr align=center>
		<td class="gridhdbg" rowspan="3">Sl.No</td>
		<td class="gridhdbg" rowspan="3">Programme</td>
			<%if(finyear.equals("2011-2012")){%>
		<td class="gridhdbg"   colspan="27" nowrap>Central Releases During the Year(01-APR-<%=finyear.substring(0,4)%> To 31-MAR-<%=finyear.substring(5,9)%>)<br>State Releases During the Year(17-APR-<%=finyear.substring(0,4)%> To 31-MAR-<%=finyear.substring(5,9)%>)</td>
		<%}else{%>
		<td class="gridhdbg"  colspan="27" nowrap>Central Releases During the Year(01-APR-<%=finyear.substring(0,4)%> To 31-MAR-<%=finyear.substring(5,9)%>)<br>State Releases During the Year(01-APR-<%=finyear.substring(0,4)%> To 31-MAR-<%=finyear.substring(5,9)%>)</td>
		<%}%>
		
		
		</tr>
		<tr>
				<td class="gridhdbg"  align="center" nowrap colspan=2>APR</td>
				<td class="gridhdbg"  align="center" nowrap colspan=2>MAY</td>
				<td class="gridhdbg" align="center" nowrap colspan=2>JUN</td>
				<td class="gridhdbg"  align="center" nowrap colspan=2>JULY</td>
				<td class="gridhdbg"  align="center" nowrap colspan=2>AUG</td>
				<td class="gridhdbg"  align="center" nowrap colspan=2>SEP</td>
				<td class="gridhdbg"  align="center" nowrap colspan=2>OCT</td>
				<td class="gridhdbg" align="center" nowrap colspan=2>NOV</td>
				<td class="gridhdbg" align="center" nowrap colspan=2>DEC</td>
				<td class="gridhdbg" align="center" nowrap colspan=2>JAN</td>
				<td class="gridhdbg"  align="center" nowrap colspan=2>FEB</td>
				<td class="gridhdbg"  align="center" nowrap colspan=2>MAR</td>
				<td class="gridhdbg"  align="center" colspan=2>Total</td>
				<td class="gridhdbg"  rowspan="2" >Expenditure(01-APR-<%=finyear.substring(0,4)%><br>To 31-MAR-<%=finyear.substring(5,9)%>)</td>

				</tr>
				<tr>
<td class="gridhdbg"  align=center nowrap >Central</td>
<td class="gridhdbg"  align=center nowrap>State</td>
<td class="gridhdbg"  align=center nowrap>Central</td>
<td class="gridhdbg"  align=center nowrap>State</td>

<td class="gridhdbg"  align=center nowrap>Central</td>
<td class="gridhdbg"  align=center nowrap>State</td>

<td class="gridhdbg"  align=center nowrap>Central</td>
<td class="gridhdbg"  align=center nowrap>State</td>

<td class="gridhdbg" align=center nowrap >Central</td>
<td class="gridhdbg" align=center nowrap>State</td>

<td class="gridhdbg" align=center nowrap>Central</td>
<td class="gridhdbg"  align=center nowrap>State</td>

<td class="gridhdbg"  align=center nowrap>Central</td>
<td class="gridhdbg" align=center nowrap>State</td>

<td class="gridhdbg" align=center nowrap>Central</td>
<td class="gridhdbg"  align=center nowrap>State</td>

<td class="gridhdbg"  align=center nowrap>Central</td>
<td class="gridhdbg"  align=center nowrap>State</td>

<td class="gridhdbg" align=center nowrap>Central</td>
<td class="gridhdbg"  align=center nowrap>State</td>

<td class="gridhdbg" align=center nowrap>Central</td>
<td class="gridhdbg" align=center nowrap>State</td>

<td class="gridhdbg"  align=center nowrap>Central</td>
<td class="gridhdbg"  align=center nowrap>State</td>

<td class="gridhdbg"  align=center nowrap>Central</td>
<td class="gridhdbg" align=center nowrap>State</td>

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
		System.out.println("marq:"+marq);
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

//mounika
//mounika
		
		
		String sqry="select sum(BILL_AMT_ADMISSIBLE),substr(b.work_id,1,2) from rws_work_direct_bill_tbl  a,rws_work_admn_tbl b where a.work_id=b.work_id and bill_date <= '31-MAR-"+yr+"'";
        //String obqry="select sum(BILL_AMT_ADMISSIBLE),substr(b.work_id,1,2) from RWS_work_bill_TBL  a,rws_work_admn_tbl b where a.work_id=b.work_id and bill_date<'31-MAR-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) sqry += " and substr(a.work_id,5,2)='"+dcode+"'";
		sqry += " group by substr(b.work_id,1,2)";
		stmt2=conn.createStatement();
		//System.out.println("1.wwwww:"+sqry);
		 rs2=stmt2.executeQuery(sqry);
		Hashtable h5=new Hashtable();
		while(rs2.next())
		{
		h5.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
	
		
		String billvqry1="select sum(voucher_AMT ),substr(a.work_id,1,2) from rws_work_direct_voucher_tbl a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt) >='01-APR-"+yr+"' and to_date(voucher_dt)<='31-Mar-"+nextyr+"' ";
		if(dcode!=null && !dcode.equals("All")) billvqry1 += " and substr(w.office_code,2,2)='"+dcode+"'";
		billvqry1 += " group by substr(a.work_id,1,2) ";
		Statement	stmt5=conn.createStatement();
		//System.out.println("sTATEtOTALpppp"+billvqry1);
		ResultSet rs5=stmt5.executeQuery(billvqry1);
		Hashtable h6=new Hashtable();
		while(rs5.next())
		{
		h6.put(rs5.getString(2),rs5.getString(1));
		}
		if(rs5!=null)rs5.close();
		if(stmt5!=null)stmt5.close();
		
		
		String saprq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-APR-"+yr+"' and to_date(BILL_DATE)<'01-MAY-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) saprq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		saprq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("saprq:"+saprq);
		rs2=stmt2.executeQuery(saprq1);
		Hashtable saprh1=new Hashtable();
		while(rs2.next())
		{
		saprh1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		String smayq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-MAY-"+yr+"' and to_date(BILL_DATE)<'01-JUN-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) smayq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		smayq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("smayq1:"+smayq1);
		rs2=stmt2.executeQuery(smayq1);
		Hashtable smayh1=new Hashtable();
		while(rs2.next())
		{
		smayh1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
    String sjunq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-JUN-"+yr+"' and to_date(BILL_DATE)<'01-JUL-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) sjunq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		sjunq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("sjunq1:"+sjunq1);
		rs2=stmt2.executeQuery(sjunq1);
		Hashtable sjunh1=new Hashtable();
		while(rs2.next())
		{
		sjunh1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
String sjulq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-JUL-"+yr+"' and to_date(BILL_DATE)<'01-AUG-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) sjulq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		sjulq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("sjulq1:"+sjulq1);
		rs2=stmt2.executeQuery(sjulq1);
		Hashtable sjulh1=new Hashtable();
		while(rs2.next())
		{
		sjulh1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
String saugq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-AUG-"+yr+"' and to_date(BILL_DATE)<'01-SEP-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) saugq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		saugq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("saugq1:"+saugq1);
		rs2=stmt2.executeQuery(saugq1);
		Hashtable saugh1=new Hashtable();
		while(rs2.next())
		{
		saugh1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
String ssepq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-SEP-"+yr+"' and to_date(BILL_DATE)<'01-OCT-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) ssepq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		ssepq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("ssepq1:"+ssepq1);
		rs2=stmt2.executeQuery(ssepq1);
		Hashtable sseph1=new Hashtable();
		while(rs2.next())
		{
		sseph1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
String soctq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-OCT-"+yr+"' and to_date(BILL_DATE)<'01-NOV-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) soctq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		soctq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("soctq1:"+soctq1);
		rs2=stmt2.executeQuery(soctq1);
		Hashtable socth1=new Hashtable();
		while(rs2.next())
		{
		socth1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
String snovq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-NOV-"+yr+"' and to_date(BILL_DATE)<'01-DEC-"+yr+"'";
		if(dcode!=null && !dcode.equals("All")) snovq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		snovq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("snovq1:"+snovq1);
		rs2=stmt2.executeQuery(snovq1);
		Hashtable snovh1=new Hashtable();
		while(rs2.next())
		{
		snovh1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();

String sdecq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-DEC-"+yr+"' and to_date(BILL_DATE)<'01-JAN-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) sdecq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		sdecq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("sdecq1:"+sdecq1);
		rs2=stmt2.executeQuery(sdecq1);
		Hashtable sdech1=new Hashtable();
		while(rs2.next())
		{
		sdech1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
String sjanq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-JAN-"+nextyr+"' and to_date(BILL_DATE)<'01-FEB-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) sjanq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		sjanq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("sjanq1:"+sjanq1);
		rs2=stmt2.executeQuery(sjanq1);
		Hashtable sjanh1=new Hashtable();
		while(rs2.next())
		{
		sjanh1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
String sfebq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-FEB-"+nextyr+"' and to_date(BILL_DATE)<'01-MAR-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) sfebq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		sfebq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("sfebq1:"+sfebq1);
		rs2=stmt2.executeQuery(sfebq1);
		Hashtable sfebh1=new Hashtable();
		while(rs2.next())
		{
		sfebh1.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
		String smarq1="select sum(BILL_AMT_ADMISSIBLE),substr(a.work_id,1,2) from rws_work_direct_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(BILL_DATE)>='01-MAR-"+nextyr+"' and to_date(BILL_DATE)<'01-APR-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) smarq1 += " and substr(a.work_id,5,2)='"+dcode+"'";
		smarq1 += " group by substr(a.work_id,1,2) ";
		stmt2=conn.createStatement();
		//System.out.println("smarq1:"+smarq1);
		rs2=stmt2.executeQuery(smarq1);
		Hashtable smarh1=new Hashtable();
		while(rs2.next())
		{
		smarh1.put(rs2.getString(2),rs2.getString(1));
		}
		
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
		
		
		
		//mounika
		

//mounika

     String qry="select * from rws_programme_tbl where programme_code in ('01','02','18','23','32','48','49','51','53','58','59','60','04','46','12','15','57') order by 1";
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
	nrdwpProgList.add("72");
	boolean flag=false;
	double gcamt=0;
	double gcevAmt=0;
	double gsvAmt=0;
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
		
		//mounika
	    String vamt1=""+h6.get(rs.getString(1));
	    if(vamt1!=null && !vamt1.equals("") && !vamt1.equals("null")){}else{vamt1="0";}
	    String sapra1=""+saprh1.get(rs.getString(1));
	    if(sapra1!=null && !sapra1.equals("") && !sapra1.equals("null")){}else{sapra1="0";}
		String smaya1=""+smayh1.get(rs.getString(1));
	    if(smaya1!=null && !smaya1.equals("") && !smaya1.equals("null")){}else{smaya1="0";}
		String sjuna1=""+sjunh1.get(rs.getString(1));
	    if(sjuna1!=null && !sjuna1.equals("") && !sjuna1.equals("null")){}else{sjuna1="0";}
		String sjula1=""+sjulh1.get(rs.getString(1));
	    if(sjula1!=null && !sjula1.equals("") && !sjula1.equals("null")){}else{sjula1="0";}
		String sauga1=""+saugh1.get(rs.getString(1));
	    if(sauga1!=null && !sauga1.equals("") && !sauga1.equals("null")){}else{sauga1="0";}
		String ssepa1=""+sseph1.get(rs.getString(1));
	    if(ssepa1!=null && !ssepa1.equals("") && !ssepa1.equals("null")){}else{ssepa1="0";}
		String socta1=""+socth1.get(rs.getString(1));
	    if(socta1!=null && !socta1.equals("") && !socta1.equals("null")){}else{socta1="0";}
		String snova1=""+snovh1.get(rs.getString(1));
	    if(snova1!=null && !snova1.equals("") && !snova1.equals("null")){}else{snova1="0";}
		String sdeca1=""+sdech1.get(rs.getString(1));
	    if(sdeca1!=null && !sdeca1.equals("") && !sdeca1.equals("null")){}else{sdeca1="0";}
		String sjana1=""+sjanh1.get(rs.getString(1));
	    if(sjana1!=null && !sjana1.equals("") && !sjana1.equals("null")){}else{sjana1="0";}
		String sfeba1=""+sfebh1.get(rs.getString(1));
	    if(sfeba1!=null && !sfeba1.equals("") && !sfeba1.equals("null")){}else{sfeba1="0";}
		String smara1=""+smarh1.get(rs.getString(1));
	    if(smara1!=null && !smara1.equals("") && !smara1.equals("null")){}else{smara1="0";}
		
		
		//mounika
	    double camt=0;
	    double samt=0;
	    double gvAmt=0;
	    double gvAmt1=0;
	    int styleCount=0;
	    double gsamount=0;
		String style="";
		//
		double gsapr1=0,gsmay1=0,gsjun1=0,gsjul1=0,gsaug1=0,gssep1=0,gsoct1=0,gsnov1=0,gsdec1=0,gsjan1=0,gsfeb1=0,gsmar1=0;
		gsapr1+=(Double.parseDouble(sapra1)/100000);
		gsmay1+=(Double.parseDouble(smaya1)/100000);
		gsjun1+=(Double.parseDouble(sjuna1)/100000);
		gsjul1+=(Double.parseDouble(sjula1)/100000);
		gsaug1+=(Double.parseDouble(sauga1)/100000);
		gssep1+=(Double.parseDouble(ssepa1)/100000);
		gsoct1+=(Double.parseDouble(socta1)/100000);
		gsnov1+=(Double.parseDouble(snova1)/100000);
		gsdec1+=(Double.parseDouble(sdeca1)/100000);
		gsjan1+=(Double.parseDouble(sjana1)/100000);
		gsfeb1+=(Double.parseDouble(sfeba1)/100000);
		gsmar1+=(Double.parseDouble(smara1)/100000);
		
	   /* System.out.println("apr"+gsapr1);
	    System.out.println("may"+gsmay1);
	    System.out.println("jun"+gsjun1);
	    System.out.println("jul"+gsjul1);
	    System.out.println("aug"+gsaug1);
	    System.out.println("sep"+gssep1);
	    System.out.println("oct"+gsoct1);
	    System.out.println("nov"+gsnov1);
	    System.out.println("dec"+gsdec1);
	    System.out.println("j"+gsjan1);
	    System.out.println("f"+gsfeb1);
	    System.out.println("m"+gsmar1);
	   */ 
	     double total=gsapr1+gsmay1+gsjun1+gsjul1+gsaug1+gssep1+gsoct1+gsnov1+gsdec1+gsjan1+gsfeb1+gsmar1;
	    String state=(String)h5.get(rs.getString(1));
		if(state !=null && !state.equals("") && !state.equals("null"))
		{
			
		}
		else
		{
			state="0";
		}
		//System.out.println("state***********"+state);
		
		gsamount+=Double.parseDouble(state);
		//System.out.println("gsamountstate***********"+gsamount);
		//
	    gvAmt=(Double.parseDouble(vamt)/100000);
	    gvAmt1=(Double.parseDouble(vamt1)/100000);
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
			camt=(Double.parseDouble(cenamt)/100000);
			gcamt+=(Double.parseDouble(cenamt)/100000);
			
			gcevAmt+=gvAmt;
			gcen+=camt;
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
		<tr>	<td class="<%=style %>" style="text-align: left;" ><%=sno++%></td>
			<td   class="<%=style %>" style="text-align: left;" nowrap><%=rs.getString("programme_name")%></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(apra)/100000))%></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(sapra1)/100000))%></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(maya)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(smaya1)/100000)) %></td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(juna)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(sjuna1)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(jula)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(sjula1)/100000)) %></td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(auga)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(sauga1)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(sepa)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(ssepa1)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(octa)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(socta1)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(nova)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(snova1)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(deca)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(sdeca1)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(jana)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(sjana1)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(feba)/100000))%></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(sfeba1)/100000))%></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(mara)/100000)) %></td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format((Double.parseDouble(smara1)/100000)) %></td>
			



		<td class="<%=style %>" style="text-align: right;">-</td>
		<td class="<%=style %>"  style="text-align: right;"><%=ndf.format(total)%></td>
		
		<td class="<%=style %>"  style="text-align: right;"><%=ndf.format(gvAmt1)%></td>
		</tr>
		<tr>
		
			
		
		<%
		//System.out.println("gvAmt:"+gvAmt);
		gsvAmt+=gvAmt1;
		//System.out.println("gsvAmt:"+gsvAmt);
		}else {
	
				%>
				
				<tr>	<td class="<%=style %>" style="text-align: left;" ><%=sno++%></td>
			<td class="<%=style %>" style="text-align: left;" nowrap>NRDWP- Related</td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcapr)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcmay)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcjun)%></td>
			
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcjul)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcaug)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcsep)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcoct)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcnov)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcdec)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcjan)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcfeb)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcmar)%></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>	
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcamt) %></td>
			<td class="<%=style %>" style="text-align: right;">0.0</td>
			<td class="<%=style %>" style="text-align: right;"><%=ndf.format(gcevAmt)%></td>
		</tr>
			<% }
		double tot=gcen+samt;
		
			stot+=total;
			ctot+=camt;
			mtot+=Double.parseDouble(wbtot);
			gmtot+=texp;
				//obtot+=Double.parseDouble(obamt);
				ttot+=tot;
				//ttot1+=tot1;
				//System.out.println("gsvAmtL:"+gsvAmt);
				//System.out.println("gcevAmt:"+gcevAmt);
				vtot=0;
				vtot=(gcevAmt+gsvAmt);
			//ttot2+=tot2;
	}%>
<tr>
	<td class="gridhdbg"colspan="26" align="right" >Total : </td>
	
	<td class="gridhdbg" style="text-align: right;"><%=ndf.format(gcen)%></td>
	<td class="gridhdbg" style="text-align: right;"><%=ndf.format(stot)%></td>
	<td class="gridhdbg"style="text-align: right;"><%=ndf.format(vtot)%></td>
	</tr>
	<%//}%>
	</table>
	<input type="hidden" name="mode">
		<input type="hidden" name="dname">
	</form>
	</body>
	<br>
	
	<font face=verdana size=2 color=red>
<b><bean:message key="app.nrdwprelatedfin"/></b></font>

	<%@ include file="/commons/rws_footer.jsp"%>
	</html>