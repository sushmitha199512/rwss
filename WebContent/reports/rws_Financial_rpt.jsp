<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<%@page import="nic.watersoft.commons.*" %>
<html>
<%
java.util.Date date =new  java.util.Date();
int year=date.getYear()+1900;
String currentYear= String.valueOf(year); 
int finYear_Start=2011;
DecimalFormat ndf = new DecimalFormat("####.00");
double obtot=0.0,ttot=0.0,ttot1=0.0,vtot=0.0,ttot2=0.0;
     nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute(Constants.RWS_USER);
	String loggedUser = user.getUserId();
	//System.out.println("user:::"+loggedUser);
	String dcode = request.getParameter("district");
	if(loggedUser.substring(0,3).equals("col")){
		dcode=(String)session.getAttribute("district");    
	   }

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
		document.forms[0].action= "rws_Financial_rpt.jsp";
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
					<a href="../home.jsp">Home</a>|
						<a href="./rws_Financial_rpt_xls.jsp" target="_new">Excel </a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>

			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">

			<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">Financial Achievement Report </font></td>		
		</tr>
		
		
		<%


  try{

		if(loggedUser!=null && (loggedUser.equals(Constants.ADMIN)||loggedUser.equals(Constants.LAKH_USER) ||loggedUser.equals(Constants.GUEST)||loggedUser.equals(Constants.SEC_USER) ||loggedUser.equals(Constants.MINISTER) ||loggedUser.equals("EE-Budget") || loggedUser.substring(0,3).equals("col")||loggedUser.toString().equals("ENC")||loggedUser.toString().equals("cerwss")||loggedUser.toString().equals("pdswsm")||loggedUser.toString().equals("pdccdu")||loggedUser.toString().equals("ce_nab")||loggedUser.toString().equals("ce_stp")||loggedUser.toString().equals("ce_vqc")))
		{
		%>
			<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" >
           <option value="">-Select-</option> 
		  <% 
		  if(!loggedUser.substring(0,3).equals("col")){
		  if(request.getParameter("district")!=null && request.getParameter("district").equals("All")){%>
			<option value="All" selected>All</option>
			<%}else{%>
			<option value="All">All</option><%}}
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 ";
			if(dcode!=null && !dcode.equals("")){
				query+=" and dcode='"+dcode+"'";
			}
			query+=" order by dname";
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
	%></tr>
	<%-- <tr><%@ include file="financialYear.jsp" %>
		</tr> --%>
		 <tr><td class=rptLabel>Financial Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="finyear" id="combo1" class="mycombo" style="width:150px">
		<option value="0">Select</option>

<%
int fy=0;
            while(year>=finYear_Start)
{
     fy=year+1;
%>
			<option value="<%=year+"-"+fy%>"><%=year+"-"+fy%></option> 
	<%
year--;
	
}	

		


%>
			
		</td>
	</tr>
			<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>

			<SELECT name="program" id="combo"  style="width:150px"   multiple size="10" class="hightlongcombo">
			<option value="">-select-</option>
			<%//System.out.println("program:sssssssss"+request.getParameter("program"));
			if(request.getParameter("program")!=null && request.getParameter("program").equals("01,02,18,23,32,48,49,50,51,58,59,60,72"))
			{%>
			<option value="01,02,18,23,32,48,49,50,51,58,59,60,72" selected >NRDWP Related</option>
			<%}else{%>
			<option value="01,02,18,23,32,48,49,50,51,58,59,60,72" >NRDWP Related</option>
			<%}%>
			<%

			rs.close();
			stmt.close();
			stmt = conn.createStatement();
			query="select * from  rws_programme_tbl  where programme_code not in(01,02,18,23,32,48,49,50,51,58,59,60,72) order by 1";
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
			<td class="rptHeading" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)
			</font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
		<tr><td><font color="red"><b><bean:message key="app.nrdwprelatedfin"/>


		</b></font></td></tr>
		</table><br>

		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	

		<tr align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>Division</td>
		<td class=btext  >OB Balance(1/4/<%=yr  %>)</td>
		<td class=btext  >Releases During <br> the Year</td>
		<td class=btext  >Fund Available<BR>(3+4)</td>
		<td class=btext  >Expenditure</td>
		<td class=btext  >% Of Achievement<BR>(6/5)</td>
		</tr>
		<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext>4</td><td align="center" class=btext>5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td></tr>
	<%

		String obqry="select sum(op_cl_bal),substr(office_code,2,3) from RWS_GRANT_OP_CL_BAL_TBL where fin_year='"+finyear+"'";
		if(dcode!=null && !dcode.equals("All")) obqry += " and substr(office_code,2,2)='"+dcode+"'";
		if(program!=null && !program.equals("All")) obqry += " and programme_code in("+programe+") ";
		obqry += " group by substr(office_code,2,3) ";
		Statement	stmt1=conn.createStatement();
		//System.out.println("obqry1:"+obqry);
		ResultSet rs1=stmt1.executeQuery(obqry);
		Hashtable h1=new Hashtable();
		while(rs1.next())
		{
		h1.put(rs1.getString(2),rs1.getString(1));
		}
		if(rs1!=null)rs1.close();
		if(stmt1!=null)stmt1.close();
		String billcqry="select sum(BILL_AMOUNT_CENTRAL ),substr(B.office_code,2,3) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-APR-"+yr+"' and to_date(bank_send_date)<='31-MAR-"+nextyr+"' and txid is not null";
		if(dcode!=null && !dcode.equals("All")) billcqry += " and substr(a.office_code,2,2)='"+dcode+"'";
		if(program!=null && !program.equals("All")) billcqry += " and substr(a.work_id,1,2) in( "+programe+") ";
		billcqry += " group by substr(B.office_code,2,3) ";
		Statement	stmt2=conn.createStatement();
		//System.out.println("billcqry1:"+billcqry);
		ResultSet rs2=stmt2.executeQuery(billcqry);
		Hashtable h2=new Hashtable();
		while(rs2.next())
		{
		h2.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
	//	String billsqry="select sum(BILL_AMOUT_STATE ),substr(B.office_code,2,3) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='17-APR-"+yr+"' and to_date(state_send_date)<='31-MAR-"+nextyr+"'";
        String billsqry="select sum(BILL_AMOUT_STATE ),substr(B.office_code,2,3) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='17-APR-"+yr+"' and to_date(state_send_date)<='31-MAR-"+nextyr+"' and state_txid is not null";
		if(dcode!=null && !dcode.equals("All")) billsqry += " and substr(a.office_code,2,2)='"+dcode+"'";
		if(program!=null && !program.equals("All")) billsqry += " and substr(a.work_id,1,2) in("+programe+")";
		billsqry += " group by substr(B.office_code,2,3) ";
		Statement	stmt3=conn.createStatement();
		System.out.println("billsqry1:"+billsqry);
		ResultSet rs3=stmt3.executeQuery(billsqry);
		Hashtable h3=new Hashtable();
		while(rs3.next())
		{
		h3.put(rs3.getString(2),rs3.getString(1));
		}
		if(rs3!=null)rs3.close();
		if(stmt3!=null)stmt3.close();

		String billvqry="select sum(voucher_AMT ),substr(w.office_code,2,3) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and to_date(voucher_dt)>='01-APR-"+yr+"' and to_date(voucher_dt)<='31-Mar-"+nextyr+"' ";
		if(dcode!=null && !dcode.equals("All")) billvqry += " and substr(w.office_code,2,2)='"+dcode+"'";
		if(program!=null && !program.equals("All")) billvqry += " and substr(w.work_id,1,2) in ("+programe+")";
		billvqry += " group by substr(w.office_code,2,3) ";
		Statement	stmt4=conn.createStatement();
		System.out.println("billvqry:"+billvqry);
		ResultSet rs4=stmt4.executeQuery(billvqry);
		Hashtable h4=new Hashtable();
		while(rs4.next())
		{
		h4.put(rs4.getString(2),rs4.getString(1));
		}
		if(rs4!=null)rs4.close();
		if(stmt4!=null)stmt4.close();

     String qry="select *	 from rws_division_office_tbl ";
	 if(dcode!=null && !dcode.equals("All")) qry += " where circle_office_code='"+dcode+"'";
	 qry += " order by 1";
	//System.out.println("qry111:"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	while(rs.next())
	{
		
         String obamt=""+h1.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(obamt!=null && !obamt.equals("") && !obamt.equals("null")){}else{obamt="0";}
		 String cenamt=""+h2.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(cenamt!=null && !cenamt.equals("") && !cenamt.equals("null")){}else{cenamt="0";}
		 String staamt=""+h3.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(staamt!=null && !staamt.equals("") && !staamt.equals("null")){}else{staamt="0";}
		 String vamt=""+h4.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(vamt!=null && !vamt.equals("") && !vamt.equals("null")){}else{vamt="0";}
		double tot=Double.parseDouble(cenamt)+Double.parseDouble(staamt);
		double tot1=Double.parseDouble(obamt)+(Double.parseDouble(cenamt)+Double.parseDouble(staamt));
		double tot2=0.0;
		if(tot1>0) tot2 = (Double.parseDouble(vamt)/tot1)*100;
%>
		<tr>	<td class=rptValue><%=sno++%></td>
		<td  class=rptValue nowrap><%=rs.getString("division_office_name")%></td>
		<td  class=rptValue align="right"><%=ndf.format(Double.parseDouble(obamt))%></td>
		<td  class=rptValue align="right"><%=ndf.format(tot)%></td>
		<td  class=rptValue align="right"><%=ndf.format(tot1)%></td>
		<td  class=rptValue align="right"><%=ndf.format(Double.parseDouble(vamt))%></td>
		<td  class=rptValue align="right"><%=ndf.format(tot2)%></td>
		</tr>
		<%
			obtot+=Double.parseDouble(obamt);
			ttot+=tot;
			ttot1+=tot1;
			vtot+=Double.parseDouble(vamt);
			ttot2+=tot2;
	}%>
<tr>
						<td class="btext" colspan="2" align="right" >Total : </td>
						<td class="btext"  align="right"><%=ndf.format(obtot)%></td>
						<td class="btext"  align="right"><%=ndf.format(ttot)%></td>
						<td class="btext" align="right"><%=ndf.format(ttot1)%></td>
						<td class="btext" align="right"><%=ndf.format(vtot)%></td>
						<td class="btext" align="right"><%=ndf.format((vtot/ttot1)*100)%></td>
						</tr>
	<%}

}catch(Exception e){
 e.printStackTrace();
}%>
	</table>
	<input type="hidden" name="mode">
		<input type="hidden" name="dname">
	</form>
	</body>
	<br>

	<%@ include file="/commons/rws_footer.jsp"%>
	</html>