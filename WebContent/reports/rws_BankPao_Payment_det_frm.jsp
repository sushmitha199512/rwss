<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	WorksData1 wd = new WorksData1();
	int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
	String a="";
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		var user = '<%=loggedUser%>';
		if(user=="admin" || user=="100000")
		{
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			if(document.f1.division.value=='')
			{
				alert("Please Select Division");
				return false;
			}
			if(document.f1.program.value=='')
			{
				alert("Please Select Work Category");
				return false;
			}
			if(document.f1.year.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			
			else
			{
				//alert("in");
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
				document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
				//document.f1.yname.value = document.f1.year.options[document.f1.year.selectedIndex].text;	
				//document.f1.save.value="Forwarding Wait...";
				document.f1.action="./rws_BankPao_payment_det_rpt.jsp";
				document.f1.submit();
			}	
		}
		else
		{
				//alert("in else");
			if(document.f1.division.value=='')
			{
				alert("Please Select Division");
				return false;
			}
			if(document.f1.program.value=='')
			{
				alert("Please Select Work Category");
				return false;
			}
			if(document.f1.year.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			else{
			document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
		//	document.f1.yname.value = document.f1.year.options[document.f1.year.selectedIndex].text;
			document.f1.action="./rws_BankPao_payment_det_rpt.jsp";
			document.f1.submit();
			}
		}
	}
	function fnSubmit1()
	{
		var user = '<%=loggedUser%>';
		if(user=="admin" || user=="100000")
		{
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			if(document.f1.division.value=='')
			{
				alert("Please Select Division");
				return false;
			}
			if(document.f1.program.value=='')
			{
				alert("Please Select Work Category");
				return false;
			}
			if(document.f1.year.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			
			else
			{
				//alert("in");
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
				document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
				//document.f1.yname.value = document.f1.year.options[document.f1.year.selectedIndex].text;	
				document.f1.action="./rws_BankPao_payment_det_Brpt.jsp";
				document.f1.submit();
			}	
		}
		else
		{
				//alert("in else");
			if(document.f1.division.value=='')
			{
				alert("Please Select Division");
				return false;
			}
			if(document.f1.program.value=='')
			{
				alert("Please Select Work Category");
				return false;
			}
			if(document.f1.year.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			else{
			document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
		//	document.f1.yname.value = document.f1.year.options[document.f1.year.selectedIndex].text;
			document.f1.action="./rws_BankPao_payment_det_Brpt.jsp";
			document.f1.submit();
			}
		}
	}
	


</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="get">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				

			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Payment Details Report</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	String wrkcat = request.getParameter("program");
		String fyear="";
 fyear = request.getParameter("year");
		//System.out.println("fyear111111:"+fyear+":aa");
	%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals(Constants.ADMIN)||loggedUser.equals(Constants.LAKH_USER) ||loggedUser.equals(Constants.GUEST) ||loggedUser.equals(Constants.MINISTER) ||loggedUser.equals("EE-Budget") ||loggedUser.equals(Constants.SEC_USER) ||loggedUser.substring(0,3).equals("col") || loggedUser.equals("minrwss") ||loggedUser.toString().equals("ENC")||loggedUser.toString().equals("cerwss")||loggedUser.toString().equals("pdswsm")||loggedUser.toString().equals("pdccdu")||loggedUser.toString().equals("ce_nab")||loggedUser.toString().equals("ce_stp")||loggedUser.toString().equals("ce_vqc")))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		
		<%

		  stmt = conn.createStatement();
		
			//query="SELECT distinct d.dcode,d.dname from rws_district_tbl d ,rws_work_bill_tbl w where d.dcode<>16  and substr(work_id,5,2)=d.dcode order by d.dname";
			query="SELECT distinct dcode,dname  from rws_district_tbl d ,rws_work_bill_tbl b,rws_work_admn_tbl w  where d.dcode<>16  and substr(b.work_id,5,2)=d.dcode and b.work_id=w.work_id   and substr(w.office_code,2,2)=d.dcode order by d.dname";
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
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>

	<tr><td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="division" id="combo" class="mycombo" style="width:150px"  onchange="this.form.submit()">
				<option value="">-Select-</option>
<%if(dcode!=null && !dcode.equals("")) {
			Statement stmt2 = conn.createStatement();
			//query="select  division_office_code,division_office_name from rws_division_office_tbl where circle_office_code='"+dcode+"'";
			query="select  distinct division_office_code,division_office_name from rws_division_office_tbl a,rws_work_admn_tbl w,rws_work_bill_tbl b  where  w.work_id=b.work_id and a.circle_office_code=substr(office_code,2,2) and a.division_office_code =substr(office_code,4,1)    and circle_office_code='"+dcode+"'";
			// System.out.println("qqq:"+query);

			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				 if(rs2.getString(1).equals(divcode)){
	%>
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
	<%} else{%>
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(2)%></option> 
	<%}
			}

						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	} %>
</td></tr>
		

		<tr><td class=rptLabel nowrap>Work Category&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="program" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
		<option value="">-Select-</option>
<% if(divcode!=null && !divcode.equals("")){
			Statement stmt1 = conn.createStatement();
			query="select distinct a.category_code,a.category_name from rws_work_category_tbl a,rws_work_admn_tbl b,rws_work_bill_tbl c where c.work_id=b.work_id and  a.category_code =b.category_code and substr(office_code,2,2)='"+dcode+"'   and substr(office_code,4,1)='"+divcode+"'  order by category_code";
			// System.out.println("qqq cat:"+query);
			ResultSet rs1 = stmt1.executeQuery(query);
			while(rs1.next())
			{
				if(wrkcat.equals(rs1.getString(1))){
	%>
					 <option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(2)%></option> 
	<%}else{%>
				<option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option> 
	<%}
			}
						if(rs1!=null)rs1.close();
						if(stmt1!=null)stmt1.close();
		}%>
</td></tr>
<tr><td class=rptLabel>Financial Year&nbsp;&nbsp;<font color="red">*</font></td>&nbsp;&nbsp;&nbsp;&nbsp;
		<td class=btext>
		<SELECT name="year" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
		<option value="">-Select-</option>
	<% if(wrkcat!=null && !wrkcat.equals("")){
			Statement stmt11 = conn.createStatement();
			query="select distinct substr(to_char(BILL_DATE,'dd/mm/yyyy'),7,4)  from rws_work_category_tbl a,rws_work_admn_tbl b,rws_work_bill_tbl c where c.work_id=b.work_id and  a.category_code =b.category_code and substr(office_code,2,2)='"+dcode+"'   and substr(office_code,4,1)='"+divcode+"' and a.CATEGORY_CODE ='"+wrkcat+"' order by substr(to_char(BILL_DATE,'dd/mm/yyyy'),7,4) desc ";
		 //System.out.println("qqq aaaaaddddddtteeeee:"+query);
			ResultSet rs11 = stmt11.executeQuery(query);
			while(rs11.next())
			{
				String fy=rs11.getString(1);
		int fy1=Integer.parseInt(fy)+1;
		//System.out.println("fyear:"+fyear);
		//System.out.println("fy:"+fy);
	
		if(!fyear.equals(""))
				{
			a=fyear.substring(0,4);
				}
		//System.out.println("a:"+a);
				if(a.equals(rs11.getString(1))){
	%>
					 <option value="<%=fy+"-"+fy1%>" selected><%=fy+"-"+fy1%></option> 
	<%}else{%>
			<option value="<%=fy+"-"+fy1%>"><%=fy+"-"+fy1%></option> 
	<%}
			}
						if(rs11!=null)rs11.close();
						if(stmt11!=null)stmt11.close();
		}%>
</td></tr>

<%	
}catch(Exception e){
// System.out.println("Exception in work detail frm jsp:"+e);

}
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button name="a"  onclick="fnSubmit()" class=btext value="View Consolidated Report">
			<input type=button name="b" onclick="fnSubmit1()" class=btext value="View BillWise Report">
			
		</td>
	</tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="pname">
<INPUT type="hidden" name="divname">
<!-- <INPUT type="hidden" name="yname"> -->

</form>
</body>
</html>