<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
//String loggedUser = user.getUserId();
StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());
%>
<html>
<head>

<script language="JavaScript">
function fnSubmit1()
	{
		var loggedUser = '<%=loggedUser%>';
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			else if(document.f1.fDate.value=='')
			{
				alert("Please Select From Date");
				return false;
			}
			else if(document.f1.toDate.value=='')
			{
				alert("Please Select To Date");
				return false;
			}
			
					
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000" ||loggedUser=="guest" ||loggedUser=="1000DR")
				{
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			
				}
				else
				{
					document.f1.dname.value = document.f1.district.value;
				
				}
				//alert(document.f1.dname.value);
				//document.f1.action="./rws_drought_drinking_water_frm.jsp";
				document.f1.action="./rws_tanker_movement_rpt_district_wise_statistics_rpt.jsp?mode=date";
				
				
				document.f1.submit();
			}	
		}

function show()
	{
	document.getElementById('ecode').style.display='block';
	document.getElementById('circlewise').style.display='none';
    }
    function check()
	{
		
	 
	 if(document.forms[0].habtype[0].checked)
	 {
	   document.getElementById('circlewise').style.display='none';
	 }
	 else if(document.forms[0].habtype[1].checked)
	 {
		 
	  document.getElementById('ecode').style.display='none';
	 }
	
	}

	function show1()
	{
document.getElementById('circlewise').style.display='block';		
document.getElementById('ecode').style.display='none';
		
	}

	function fnSubmit()
	{
		var loggedUser = '<%=loggedUser%>';
			
			if(document.f1.fromDate.value=='')
			{
				alert("Please Select From Date");
				return false;
			}
			else if(document.f1.toDate1.value=='')
			{
				alert("Please Select To Date");
				return false;
			}
			
			
					
				document.f1.action="./rws_tanker_movement_rpt_all_districts_statistics_rpt.jsp?mode=date";
				//document.f1.action="./rws_drought_drinking_water_frm.jsp";
				
				
				document.f1.submit();
			
		}
function setDate(){
var today = new Date();
var dtstr=today.toUTCString();
var mnth=dtstr.substring(8,11);
var day=dtstr.substring(5,7);
var year=dtstr.substring(12,16);
var n=parseInt(today.getMonth());
n+=1;
 if(n<10){
n="0"+n;
}
var s=day+"/"+n+"/"+year;
document.getElementById("fromDate").value=s;

}
		</script>

</head>
<body bgcolor="#edf2f8">
<body onload="check()">
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
		<td align="center" class="rptHeading" colspan=3>Abstract of Daily Report on Tanker Movement - Report</td>	
	</tr>
<tr>
<td>
	<tr><td class="textborder" colspan="2" align="center">
<input type="radio" value="0" name="habtype" checked onclick="show()">All Districts &nbsp;&nbsp;
<input type="radio" value="1" name="habtype" onclick="show1()">District Wise &nbsp;&nbsp;

</td>
</tr>

<tr>
<td>
<div id="ecode" style="display:block">
<table border=0 width="423" align=center style="margin-bottom:5;margin-top:5">
 <tr>
 <tr align=center>
<td align="center" class=rptvalue>From Date:&nbsp;<font color="red">*</font><input type="text" name="fromDate"  maxlength=15 readonly  style="width:80px">
<a href="javascript: showCalendarFuture(document.forms[0].fromDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
<tr align=center>
<td align="center" class=rptvalue>To Date:&nbsp;<font color="red">*</font><input type="text" name=toDate1 maxlength=10 readonly  style="width:80px">
<a href="javascript: showCalendarFuture(document.forms[0].toDate1);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
<tr>
</tr>
<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Details">
	</td>
	</tr>

 </table>
</div>
</td>
</tr>

<tr>
<td>
<div id="circlewise" style="display:block">
<table border=0 width="423" align=center style="margin-bottom:5;margin-top:5">
 <tr>
<%
StringBuffer dcode=new StringBuffer();
StringBuffer query=new StringBuffer();
try
{
	//String dcode = request.getParameter("district");
	dcode.delete(0,dcode.length());
	dcode.append(request.getParameter("district"));
	
		
%>
	<tr align=center><td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District&nbsp;&nbsp;<font color="red">*</font>
		
		<%
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" >
            <option value="">-Select-</option> 
		<%
			stmt = conn.createStatement();
		query.delete(0,query.length());
			query.append("SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname");
			rs = stmt.executeQuery(query.toString());
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode.toString()))
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
}catch(Exception e)
{
e.printStackTrace();
}
			finally{

 dcode=null;
query=null;
}
				
		
	%>
</td>
</tr>
			

 <tr align=center>
<td align="center" class=rptvalue>From Date:&nbsp;<font color="red">*</font><input type="text" name=fDate maxlength=10 readonly  style="width:80px">
<a href="javascript: showCalendarFuture(document.forms[0].fDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
<tr>
<tr align=center>
<td align="center" class=rptvalue>To Date:&nbsp;<font color="red">*</font><input type="text" name=toDate maxlength=10 readonly  style="width:80px">
<a href="javascript: showCalendarFuture(document.forms[0].toDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
<tr>
</tr>
<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton1" onclick="fnSubmit1()" class=btext value="Get Details">
	</td>
	</tr>

 </table>
</div>
</td>
</tr>


 
</table>
<p align=center>
Note:-
1. For All Districts Selection->From Date Selection and To Date Selection are mandatory<br>
2.For District Wise Selection - District -> From Date and To Date Selection are mandatory<br>

<font color=red> Completed and Approved Trips only counted</font>
</p>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
</form>
</body>
 
</html>