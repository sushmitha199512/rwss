<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		var user = '<%=loggedUser%>';
		if(user=="admin" || user=="100000")
		{
			/*if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}*/
			if(document.f1.division.value=='')
			{
				alert("Please Select Division");
				return false;
			}
			/*if(document.f1.program.value=='')
			{
				alert("Please Select Work Category");
				return false;
			}*/
			if(document.f1.year.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			
			else
			{
			//	document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				//document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
				document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
				document.f1.yname.value = document.f1.year.options[document.f1.year.selectedIndex].text;	
				document.f1.action="./rws_work_refund_bank_rpt.jsp";
				document.f1.submit();
			}	
		}
		else
		{
			if(document.f1.division.value=='')
			{
				alert("Please Select Division");
				return false;
			}
		/*	if(document.f1.program.value=='')
			{
				alert("Please Select Work Category");
				return false;
			}*/
			if(document.f1.year.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			else{
			//document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			//document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
			document.f1.yname.value = document.f1.year.options[document.f1.year.selectedIndex].text;
			document.f1.action="./rws_work_refund_bank_rpt.jsp";
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
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3> Bank Refund Report</td>	
	</tr>
	
<%
try
{
	//String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	String bankrefund = request.getParameter("refund");
	String fyear = request.getParameter("year");
	%>
		
	
	
	  
	
	<tr><td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="division" id="combo" class="mycombo" style="width:150px"  onchange="this.form.submit()">
				<option value="">-Select-</option>
<%//if(dcode!=null && !dcode.equals("")) {
			
			//query="select  division_office_code,division_office_name from rws_division_office_tbl where circle_office_code='"+dcode+"'";
			//query="select  distinct division_office_code,division_office_name from rws_division_office_tbl a,rws_work_admn_tbl w,rws_work_bill_tbl b  where  w.work_id=b.work_id and a.circle_office_code=substr(office_code,2,2) and a.division_office_code =substr(office_code,4,1)    and circle_office_code='"+dcode+"'";

			query="select division_office_name from rws_division_office_tbl";
			System.out.println("qqq:"+query);
			Statement stmt2 = conn.createStatement();
			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				 if(rs2.getString(1).equals(divcode)){
	%>
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(1)%></option> 
	<%} else{%>
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(1)%></option> 
	<%}
			}

						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	 %>
</td></tr>
		

		<tr><td class=rptLabel>Financial Year&nbsp;&nbsp;<font color="red">*</font></td>&nbsp;&nbsp;&nbsp;&nbsp;
		<td class=btext>
		<SELECT name="year" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
				<option value="">-Select-</option>
				<option value=""selected>-ALL-</option>
<%//if(wrkcat!=null && !wrkcat.equals("")){
	Statement	 stmt1 = conn.createStatement();
	
	query="select distinct to_char(admin_date,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_work_bill_tbl b  where a.work_id=b.work_id and  admin_date is not null  order by 1 desc";
	// System.out.println("qqqsrinivas date:"+query);
	    ResultSet rs1 = stmt1.executeQuery(query);
		ArrayList aa = new ArrayList();	
		String finalSancYear="";
	while(rs1.next())
		{
			//// System.out.println("rs1:"+rs1.getString(1));
			//// System.out.println("before :"+rs1.getString(1));
			String dates = rs1.getString(1);
   			int da = Integer.parseInt(dates.substring(3,5));
			int ye = Integer.parseInt(dates.substring(6,10));
			if(da<=03)finalSancYear = ye-1+"-"+ye;
			else finalSancYear = ye+"-"+(ye+1);
			//System.out.println("final year:"+finalSancYear);
			//HashSet h = new HashSet();
			aa.add(finalSancYear);
		}
			HashSet h = new HashSet(aa);
        	ArrayList bb =new ArrayList(h);
			Collections.sort(bb,Collections.reverseOrder()); 
            for(int i = 0;i<bb.size();i++)
			{
		finalSancYear = (String)bb.get(i);
	  if(fyear!=null &&  !fyear.equals("") && finalSancYear.equals(fyear))
		{
	 %>
		 <option value="<%=finalSancYear%>" selected><%=finalSancYear%></option> 
	 <%}else {%>
	  <option value="<%=finalSancYear%>" ><%=finalSancYear%></option> 
	 
	 <%}
			}
						if(rs1!=null)rs1.close();
						if(stmt1!=null)stmt1.close();
		//}%>
</td></tr>






	<tr><td class=rptLabel>Refund<font color="red">*</font></td>&nbsp;&nbsp;&nbsp;&nbsp;
		<td class=btext>
		<SELECT name="refund" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
				<option value="">-Select-</option>
				<option value=""selected>BANK</option>
				<option value=""selected>PAO</option>
				<option value=""selected>BOTH</option>

<%	
}


catch(Exception e){
// System.out.println("Exception in work detail frm jsp:"+e);

}
%>




	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		
			
		</td>
	</tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>

<INPUT type="hidden" name="refund">
<INPUT type="hidden" name="divname">
<INPUT type="hidden" name="yname">

</form>
</body>
</html>