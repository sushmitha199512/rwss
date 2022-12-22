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
	String qry3="";
	
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		//alert(1);
		var loggedUser = '<%=loggedUser%>';
			if(document.f1.fromDate.value=='')
			{
				alert("Please Select From Date");
				return false;
			}
			
			if(document.f1.toDate.value=='')
				{
				alert("Please select To Date");
				return false;
				}
			
			
			 else
			{
				
					
			
				document.f1.action="./rws_Typeof_Adverse_News_Item_rpt.jsp";
				document.f1.submit();
			}	
		}
		</script>
<script language="javascript" type="text/javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>

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
		<td align="center" class="rptHeading" colspan=3>Type of Adverse News Item Report</td>	
	</tr>
	
	<tr>
	<td class=rptLabel>&nbsp;&nbsp;From Date<font color="red">*</font></td>
	<td>
		<input type="text" name="fromDate" id="fromDate" style="width:90" />
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr><tr>
	<td class=rptLabel>&nbsp;&nbsp;To Date<font color="red">*</font></td>
	<td>
		<input type="text" name="toDate" id="toDate" style="width:90"  />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	
	
	
		
					
	
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Details">
	</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="mname">
<INPUT type="hidden" name="sname">



</form>
</body>
</html>