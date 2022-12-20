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
	Statement stmt1=conn.createStatement();
	ResultSet rs1=null;
%>
<html>
<head>

<script language="JavaScript">
 
	function fnSubmit()
	{
 
		var user = '<%=loggedUser%>';
	 	if(user=="admin" || user=="100000" || user=="guest" || user=="psrwss")
		 {
			if(document.f1.district.value=='')
			{
	 			alert("Please Select District");
				return false;
			 }
			   
		 }
			 if(document.f1.mandal.value=='')
			{
				alert("Please Select  Mandal");
				return false;
			 }
			 if(!document.f1.printType[0].checked && !document.f1.printType[1].checked)
			{
			   alert("Please Select Report Type....");
				return false;
			}
		
		  if(document.forms[0].printType[0].checked)
		      {
			  if(user=="admin" || user=="100000" || user=="guest" || user=="psrwss")
				 {
			   document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				 }
				document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
			    document.f1.action="./rws_water_parameters_rpt.jsp";
				document.f1.submit();
		      }
		  else if(document.forms[0].printType[1].checked)
		      {
				 var width = 650;
				 var height = 450;
				 var left = parseInt((screen.availWidth/2)-(width/2));
				 var top = parseInt((screen.availHeight/2)-(height/2));
				 if(user=="admin" || user=="100000" || user=="guest" || user=="psrwss")
				 {
				 document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				 }
				 else
					 {
					 
					 document.f1.dname.value = document.f1.dname1.value;
					 }
			
				 document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				 
			    var url="./rws_water_parameters_xls.jsp?district="+document.f1.district.value+"&mandal="+document.f1.mandal.value+"&dname="+document.f1.dname.value+"&mname="+document.f1.mname.value;
				var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
				newWindow = window.open(url, "_New", properties);
			  }	
		 //}
		
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
		<td align="center" class="rptHeading" colspan=3>Water Quality Data Format</td>	
	</tr>
<%
try
 {
	String dcode = request.getParameter("district");
	String mcode = request.getParameter("mandal");
	%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin") ||loggedUser.equals("100000") ||loggedUser.equals("guest") ||loggedUser.equals("psrwss")))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		
		<%

		  stmt = conn.createStatement();
		  query="select  distinct dcode,dname from  rws_district_tbl d,rws_wq_test_results_tbl a where substr(source_code,1,2)=d.dcode  and d.dcode<>'16' order by 2";
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
			stmt = conn.createStatement();
			query="SELECT dcode,dname from rws_district_tbl  where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
			 dcode=rs.getString(1);%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">  
					<input type="hidden" name="dname1" value="<%=rs.getString(2)%>"> 
	        <%
			 }
		 }
	%>
</tr>
<tr>
<td class=rptLabel>Mandal &nbsp;&nbsp;<font color="red">*</font></td>
<td><SELECT name="mandal" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
<option value="">-Select-</option>
<%
String qry1="select distinct mcode,mname from rws_mandal_tbl  a, rws_wq_test_results_tbl b where substr(source_code,1,2)=a.dcode and substr(source_code,6,2)=a.mcode and  dcode='"+dcode+"' order by 2  "; 
rs1=stmt1.executeQuery(qry1);
while(rs1.next())
 {
	if(rs1.getString(1).equals(mcode))
				{
				%>
					 <option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(2)%></option> 
			<%
				}
				else
				{
			%>
					 <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option> 
			<%
				}
 }
%>
</td>	
</tr>
<tr><td class = btext nowrap colspan="2" align="center"><input type="radio" name="printType" ><font color="green">Normal Report&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="printType">Excel Report</tr>

<tr>
<td  colspan=2  align="center">
<input type=button name="View Report"  value="Get Report" class = btext  onclick="fnSubmit()"></td>
</tr>
<%}catch(Exception e){
System.out.println("Exception in Water Quality DataFormat Report:"+e);
}%>
<input type="hidden" name="dname">
<input type="hidden" name="mname">
</form>
