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
 
function fndiv()
{
document.f1.submit();
}
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
			if(document.f1.frmDate.value=='')
			{
				alert("Please Select From Date");
				return false;
			}
			if(document.f1.toDate.value=='')
			{
				alert("Please Select To Date");
				return false;
			}
			else
			{
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			    document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
				document.f1.action="./rws_bank_details_rpt.jsp";
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
			if(document.f1.frmDate.value=='')
			{
				alert("Please Select From Date");
				return false;
			}
			if(document.f1.toDate.value=='')
			{
				alert("Please Select To Date");
				return false;
			}
			else{
				document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
				document.f1.action="./rws_bank_details_rpt.jsp";
				document.f1.submit();
			}
		}
	}
	

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Bills Vs Releases  Vs Vouchers</td>	
	</tr>
	
	
<%
try
{
	String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	String frmDate = request.getParameter("frmDate");
    String toDate = request.getParameter("toDate");
	%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		
		<%

		  stmt = conn.createStatement();
		
			//query="SELECT circle_office_code,circle_office_name from  rws_circle_office_tbl  order by 2";
			query="select  distinct circle_office_code,circle_office_name from  rws_circle_office_tbl c,rws_work_admn_tbl a,rws_work_bill_tbl b where a.work_id=b.work_id and substr(a.office_code,2,2)=c.circle_office_code order by 2";
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
			
			query="SELECT circle_office_code,circle_office_name from rws_circle_office_tbl where circle_office_code='"+loggedUser.substring(1,3)+"'";
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
		<SELECT name="division" id="combo" class="mycombo" style="width:150px"  onchange="fndiv()">
				<option value="">-Select-</option>
<%if(dcode!=null && !dcode.equals("")) {
			Statement stmt2 = conn.createStatement();
			//query="select  division_office_code,division_office_name from rws_division_office_tbl where circle_office_code='"+dcode+"'";
            query="select  distinct c.division_office_code,division_office_name from rws_division_office_tbl c, rws_work_admn_tbl a,rws_work_bill_tbl b where a.work_id=b.work_id and bill_sl_no<>0 and  substr(a.office_code,2,2)=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code and c.circle_office_code='"+dcode+"' order by 2 ";

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
<tr>
 <td class=rptLabel>From Date:&nbsp;&nbsp;<font color="red">*</font></td>
 <td><SELECT name="frmDate" id="combo" class="mycombo" style="width:150px"  onchange="this.form.submit()">
 <option value="">-Select-</option>
<%
	Statement stmt3 = conn.createStatement();
	if(dcode!=null && !dcode.equals("") && divcode!=null && !divcode.equals("")) {
query="select distinct to_char(UPDATE_DATE ,'dd/mm/yy') from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and update_date >= '15/MAR/2011' and  update_date is not null  and bill_sl_no <> 0 and   substr(office_code,2,2)='"+dcode+"' and substr(office_code,4,1)='"+divcode+"'  order by to_char(UPDATE_DATE ,'dd/mm/yy')  ";
// System.out.println("query3:"+query);
ResultSet rs3 = stmt3.executeQuery(query);
  while(rs3.next())
    { 
     if(rs3.getString(1).equals(frmDate)){
	%>
					 <option value="<%=rs3.getString(1)%>" selected><%=rs3.getString(1)%></option> 
	<%} else{%>
					 <option value="<%=rs3.getString(1)%>" ><%=rs3.getString(1)%></option> 
	<%}
  
    }

	} %>
 </td>
</tr>
<tr>
 <td class=rptLabel>To Date:&nbsp;&nbsp;<font color="red">*</font></td>
 <td><SELECT name="toDate" id="combo" class="mycombo" style="width:150px"  onchange="this.form.submit()">
 <option value="">-Select-</option>
<%Statement stmt4 = conn.createStatement();

if(frmDate!=null && !frmDate.equals("")) {
query="select distinct to_char(update_date,'dd/mm/yy'),to_char(update_date,'yy'),to_char(update_date,'mm'),to_char(update_date,'dd')  from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and substr(office_code,2,2)='"+dcode+"' and substr(office_code,4,1)='"+divcode+"' and to_date(update_date,'dd/mm/yy')>= to_date('"+frmDate+"', 'dd/MM/yy')  order by to_char(update_date,'yy'),to_char(update_date,'mm'),to_char(update_date,'dd')   ASC ";	

//System.out.println("query1111:"+query);
ResultSet rs4 = stmt4.executeQuery(query);
  while(rs4.next())  
    { 
     if(rs4.getString(1).equals(toDate)){
	%>
					 <option value="<%=rs4.getString(1)%>" selected><%=rs4.getString(1)%></option> 
	<%} else{%>
					 <option value="<%=rs4.getString(1)%>" ><%=rs4.getString(1)%></option> 
	<%}
  
    }

} %>
 </td>
</tr>

<%	
}catch(Exception e){
System.out.println("Exception in Bank Process Report frm jsp:"+e);

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
<INPUT type="hidden" name="divname">
</form>
</body>
</html>

