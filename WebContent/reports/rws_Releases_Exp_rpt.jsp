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
	String dcode1 = request.getParameter("district");
	if(dcode1!=null)
	{
		session.setAttribute("dcode1",dcode1);
	}
	String dname1 = request.getParameter("dname");
	if(dname1!=null)
	{
		session.setAttribute("dname1",dname1);
	}
		//String program = request.getParameter("program");
		String finyear1 = request.getParameter("finyear");
		if(finyear1!=null)
	{
		session.setAttribute("finyear1",finyear1);
	}
		
		//System.out.println("dcode value::"+dcode);
		//System.out.println("finyear value::"+finyear);
		String mode = request.getParameter("mode");	
		String query = null;
		int sno=1;
		String programe="",nextyr="";
		String[] program=request.getParameterValues("program");
		ArrayList aa = new ArrayList();
		//System.out.println("ppppppppppp"+request.getParameterValues("program"));
if(request.getParameterValues("program")!=null)
{
  for(int i=0;i<program.length;i++)
{
programe += program[i]+",";
aa.add(program[i]);
}
//System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
//System.out.println("programe::"+programe);
if(programe!=null)
{
session.setAttribute("programe",programe);
}
}
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
			else if(document.forms[0].program.value=='')
			{
				alert("Please Select programs");
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
		document.forms[0].action= "rws_Releases_Exp_rpt.jsp";
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
					if(rs.getString(1).equals(dcode1))
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
				dcode1=rs.getString(1);
	%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>
			
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
			<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>

			<SELECT name="program" id="combo"  style="width:150px"   multiple size="10" class="hightlongcombo">
			<option value="">-select-</option>
			  <% if(request.getParameter("program")!=null && request.getParameter("program").equals("All")){%>
			<option value="All" selected>All</option>
			<%}else{%>
			<option value="All">All</option><%}%>
			<%String progCode="";
				String nrdwpQuery="select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
				Statement statement=conn.createStatement();
				ResultSet  resultSet=statement.executeQuery(nrdwpQuery);
				while(resultSet.next()){
					if(!progCode.equals("")){
					progCode=progCode+","+resultSet.getString(1);
					}
					else{
						progCode=resultSet.getString(1);
					}
				}
				
					%>
			<%//System.out.println("program:sssssssss"+request.getParameter("program"));
			if(request.getParameter("program")!=null && request.getParameter("program").equals(progCode))
			{%>
			<option value=<%=progCode %> selected>NRDWP Related</option>
			<%}else{%>
			<option value=<%=progCode %>>NRDWP Related</option>
			<%}%>
			<%

			rs.close();
			stmt.close();
			stmt = conn.createStatement();
			query="select * from  rws_programme_tbl  where NRDWP_RELATED='N' order by 1";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
			    if(aa.contains(rs.getString(1)))
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
			</td></tr>
			<tr><%@ include file="financialYear.jsp" %>		</tr>
	
		<tr align="center">
			<td colspan=2 align=center>
				<input type=button value="View Report" class = btext onclick="fnView()">
		</td>
		</tr>
		
		</table>
		<br>
		<br>
		<%//System.out.println("docein conditionssssss"+request.getParameter("district"));
		//System.out.println("docein conditionssssss"+programe);
		String yr="";
		if(mode!=null && mode.equals("report")){
		if(finyear1!=null)
			yr=finyear1.substring(0,4);
		nextyr=finyear1.substring(5,9);
		
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
			<td class="rptHeading" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)
			</font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
		<tr><td><font color="red"><bean:message key="app.nrdwprelatedfin"/>


		 </font></td></tr>
		<%if(finyear1.equals("2011-2012")){%>
		<tr><td><font color="red">NOTE:</font> <font color="blue" size="4">(01-APR-<%=finyear1.substring(0,4)%> To 17-APR-<%=finyear1.substring(0,4)%>) Releases are related to last Financial year Payments</font></td></tr>
		<%}%>
		</table><br>

		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	

		<tr align=center>
		<td class=btext rowspan="2">Sl.No</td>
		<td class=btext rowspan="2">Division</td>
		<td class=btext rowspan="2">Opening Balance</td>
			<%if(finyear1.equals("2011-2012")){%>
		<td class=btext  colspan="3" nowrap>Central Releases During the Year(01-APR-<%=finyear1.substring(0,4)%> To 31-MAR-<%=finyear1.substring(5,9)%>)<br>State Releases During the Year(17-APR-<%=finyear1.substring(0,4)%> To 31-MAR-<%=finyear1.substring(5,9)%>)</td>
		<%}else{%>
		<td class=btext  colspan="3" nowrap>Central Releases During the Year(01-APR-<%=finyear1.substring(0,4)%> To 31-MAR-<%=finyear1.substring(5,9)%>)<br>State Releases During the Year(01-APR-<%=finyear1.substring(0,4)%> To 31-MAR-<%=finyear1.substring(5,9)%>)</td>
		<%}%>
		
		<td class=btext rowspan="2" >Expenditure(01-APR-<%=finyear1.substring(0,4)%><br>To 31-MAR-<%=finyear1.substring(5,9)%>)</td>
		</tr>
		<tr>
		<td class=btext align="center" nowrap>Central<br>(With TXID)</td>
		<td class=btext align="center" nowrap>State<br>(With TXID)</td>
		<td class=btext align="center">Total</td>
		<!-- <td class=btext align="center">Offline Release(Upto 31-MAR-<%=finyear1.substring(5,9)%>)</td>
		<td class=btext align="center">Grand Total</td>
		 --></tr>
		<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext>4</td><td align="center" class=btext>5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td></tr>
	
		<%

		String obqry="select sum(BILL_AMT_ADMISSIBLE),substr(office_code,2,3) from RWS_work_bill_TBL  a,rws_work_admn_tbl b where a.work_id=b.work_id and to_date(bill_date)<='31-MAR-"+nextyr+"' ";
		if(dcode1!=null && !dcode1.equals("All")) obqry += " and substr(office_code,2,2)='"+dcode1+"'";
		if(program!=null && !program.equals("All") && !programe.equals("All")) obqry += " and programme_code in("+programe+") ";
		obqry += " group by substr(office_code,2,3) ";
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
		String billcqry="select nvl(sum(BILL_AMOUNT_CENTRAL),0),substr(a.office_code,2,3) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-APR-"+yr+"' and to_date(bank_send_date)<='31-MAR-"+nextyr+"' and txid is not null";
		if(dcode1!=null && !dcode1.equals("All")) billcqry += " and substr(a.office_code,2,2)='"+dcode1+"'";
		if(program!=null && !program.equals("All") && !programe.equals("All")) billcqry += " and programme_code in( "+programe+") ";
		billcqry += " group by substr(a.office_code,2,3) ";
		Statement	stmt2=conn.createStatement();
		//System.out.println("billcqry1sree:"+billcqry);
		ResultSet rs2=stmt2.executeQuery(billcqry);
		Hashtable h2=new Hashtable();
		while(rs2.next())
		{
		h2.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		String billsqry="select sum(BILL_AMOUT_STATE ),substr(a.office_code,2,3) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>'17-APR-"+yr+"' and to_date(state_send_date)<='31-MAR-"+nextyr+"' and state_txid is not null";
		if(dcode1!=null && !dcode1.equals("All")) billsqry += " and substr(a.office_code,2,2)='"+dcode1+"'";
		//System.out.println("ppppppppp<><<><><><><<:"+programe);
		if(program!=null && !program.equals("All") && !programe.equals("All") && programe!=null) billsqry += " and programme_code in("+programe+")";
		billsqry += " group by substr(a.office_code,2,3) ";
		Statement	stmt3=conn.createStatement();
		System.out.println("billsqry1sr222:"+billsqry);
		ResultSet rs3=stmt3.executeQuery(billsqry);
		Hashtable h3=new Hashtable();
		while(rs3.next())
		{
		h3.put(rs3.getString(2),rs3.getString(1));
		}
		if(rs3!=null)rs3.close();
		if(stmt3!=null)stmt3.close();

		String billvqry="select sum(voucher_AMT ),substr(w.office_code,2,3) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-APR-"+yr+"' and to_date(voucher_dt)<='31-Mar-"+nextyr+"' ";
		if(dcode1!=null && !dcode1.equals("All")) billvqry += " and substr(w.office_code,2,2)='"+dcode1+"'";
		if(program!=null && !program.equals("All") && !programe.equals("All")) billvqry += " and w.programme_code in ("+programe+")";
		billvqry += " group by substr(w.office_code,2,3) ";
		Statement	stmt4=conn.createStatement();
		System.out.println("expenditure:sree"+billvqry);
		ResultSet rs4=stmt4.executeQuery(billvqry);
		Hashtable h4=new Hashtable();
		while(rs4.next())
		{
		h4.put(rs4.getString(2),rs4.getString(1));
		}
		if(rs4!=null)rs4.close();
		if(stmt4!=null)stmt4.close();

		String obqry11="select sum(op_cl_bal),substr(office_code,2,3) from RWS_GRANT_OP_CL_BAL_TBL where fin_year='"+yr+"-"+nextyr+"' ";
		if(dcode1!=null && !dcode1.equals("All")) obqry11 += " and substr(office_code,2,2)='"+dcode1+"'";
		if(program!=null && !program.equals("All") && !programe.equals("All")) obqry11 += " and programme_code in("+programe+") ";
		obqry11 += " group by substr(office_code,2,3) ";
		Statement	stmt11=conn.createStatement();
		//System.out.println("obqry1:"+obqry11);
		ResultSet rs11=stmt11.executeQuery(obqry11);
		Hashtable h11=new Hashtable();
		while(rs11.next())
		{
		h11.put(rs11.getString(2),rs11.getString(1));
		}
		if(rs11!=null)rs11.close();
		if(stmt11!=null)stmt11.close();

     String qry="select *	 from rws_division_office_tbl ";
	 if(dcode1!=null && !dcode1.equals("All")) qry += " where circle_office_code='"+dcode1+"'";
	 qry += " order by 1";
	//System.out.println("qry111sree:"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	while(rs.next())
	{
		 String staamt="";
        // String wbtot=""+h1.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	   // if(wbtot!=null && !wbtot.equals("") && !wbtot.equals("null")){}else{wbtot="0";}
		 String cenamt=""+h2.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(cenamt!=null && !cenamt.equals("") && !cenamt.equals("null")){}else{cenamt="0";}
		  staamt=""+h3.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(staamt!=null && !staamt.equals("") && !staamt.equals("null")){}else{staamt="0";}
		 String vamt=""+h4.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(vamt!=null && !vamt.equals("") && !vamt.equals("null")){}else{vamt="0";}
		String opbal=""+h11.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(opbal!=null && !opbal.equals("") && !opbal.equals("null")){}else{opbal="0";}
		 
		Double tot=Double.parseDouble(cenamt)+Double.parseDouble(staamt);
		/////modified on 11/03/2015 releases have been reflected as per the request from the department//////
%>
		<tr>	<td class=rptValue><%=sno++%></td>
		<td  class=rptValue nowrap><%=rs.getString("division_office_name")%></td>
		<td  class=rptValue align="right"><%=opbal%></td>
		<td  class=rptValue align="right"><%=cenamt%></td>
		<td  class=rptValue align="right"><%=staamt%></td>
		<td  class=rptValue align="right"><%=ndf.format(tot)%></td>
		<%-- <td  class=rptValue align="right"><%=ndf.format(Double.parseDouble(vamt))%></td>
 --%>	
        <td  class=rptValue align="right"><%=ndf.format(tot)%></td>
 
 	</tr>
		<%
	//System.out.println("state:"+staamt);
//	System.out.println("cen:"+cenamt);
			stot+=Double.parseDouble(staamt);
		ctot+=Double.parseDouble(cenamt);
		
	//System.out.println("state2:"+stot);
	//System.out.println("cen2:"+ctot);
			 //texp=tot+Double.parseDouble(wbtot);
		mtot+=Double.parseDouble(opbal);
		//gmtot+=texp;
			//obtot+=Double.parseDouble(obamt);
			ttot+=tot;
			//ttot1+=tot1;
			vtot+=Double.parseDouble(vamt);
			//ttot2+=tot2;
	}%>
<tr>
	<td class="btext" colspan="2" align="right" >Total : </td>
		<td class="btext"  align="right"><%=ndf.format(mtot)%></td>
	<td class="btext"  align="right"><%=ndf.format(ctot)%></td>
	<td class="btext"  align="right"><%=ndf.format(stot)%></td>
	<td class="btext"  align="right"><%=ndf.format(ttot)%></td>
	<!-- <td class="btext"  align="right"><%=ndf.format(mtot)%></td>
	<td class="btext"  align="right"><%=ndf.format(gmtot)%></td>
	 --><%-- <td class="btext" align="right"><%=ndf.format(vtot)%></td> --%>
	 
	 <td class="btext"  align="right"><%=ndf.format(ttot)%></td>
	</tr>
	<%}%>
	</table>
	<input type="hidden" name="mode">
		<input type="hidden" name="dname">
	</form>
	</body>
	<br>

	<%@ include file="/commons/rws_footer.jsp"%>
	</html>