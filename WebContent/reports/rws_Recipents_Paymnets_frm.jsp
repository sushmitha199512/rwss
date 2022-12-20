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
  System.out.print("sdfdsf");

%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		var user = '<%=loggedUser%>';
		if(user=="admin" || user=="100000" || user=="guest" || user=="EE-Budget")
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
			
			if(document.f1.finyear.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			
			else
			{
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				//document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
				document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
				document.f1.yname.value = document.f1.finyear.options[document.f1.finyear.selectedIndex].text;	
				//document.f1.wname.value = document.f1.work.options[document.f1.work.selectedIndex].text;	
				document.f1.action="./rws_Recipents_Paymnets_rpt.jsp";
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
			if(document.f1.finyear.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			else{
			//document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			//document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
			document.f1.yname.value = document.f1.finyear.options[document.f1.finyear.selectedIndex].text;
			//document.f1.wname.value = document.f1.work.options[document.f1.work.selectedIndex].text;	
			document.f1.action="./rws_Recipents_Paymnets_rpt.jsp";
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
		<td align="center" class="rptHeading" colspan=3>Recipents Vs Payments</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	String wrkcat = request.getParameter("program");
	String fyear = request.getParameter("year");
	%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals(Constants.ADMIN)||loggedUser.equals(Constants.LAKH_USER) ||loggedUser.equals(Constants.GUEST) ||loggedUser.equals("EE-Budget")))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		
		<%

		  stmt = conn.createStatement();
		
			query="SELECT distinct dcode,dname from rws_district_tbl   where dcode<>16   order by dname";
			//query="SELECT distinct dcode,dname  from rws_district_tbl d ,rws_work_bill_tbl b,rws_work_admn_tbl w  where d.dcode<>16  and substr(b.work_id,5,2)=d.dcode and b.work_id=w.work_id   and substr(w.office_code,2,2)=d.dcode order by d.dname";
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
			//System.out.println("in selected dist:");
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
			query="select  division_office_code,division_office_name from rws_division_office_tbl where circle_office_code='"+dcode+"'";
			//query="select  distinct division_office_code,division_office_name from rws_division_office_tbl a,rws_work_admn_tbl w,rws_work_bill_tbl b  where  w.work_id=b.work_id and a.circle_office_code=substr(office_code,2,2) and a.division_office_code =substr(office_code,4,1)    and circle_office_code='"+dcode+"'";
			//System.out.println("div qry:"+query);

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
		<tr><%@ include file="financialYear.jsp" %>
		</tr>

<%	
}catch(Exception e){
System.out.println("Exception in bill Report frm jsp:"+e);

}
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		
			
		</td>
	</tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="pname">
<INPUT type="hidden" name="divname">
<INPUT type="hidden" name="yname">
<INPUT type="hidden" name="wname">

</form>
</body>
</html>

