<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileOutputStream" %>
<%@ include file = "/reports/conn.jsp" %>

<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String qry3="";
	
%>
<html>
<head>
<script>
	function fnSubmit()
	{
		
	 document.forms[0].action="switch.do?prefix=/drought&page=/newsItem.do&mode=downloadImages"; 
	//document.forms[0].action="/pred/drought/newsItem.do&mode=downloadImages";
	document.forms[0].submit(); 
//alert("All Images Downloaded Successfully.");
		}
</script>

</head>
<body bgcolor="#edf2f8">
<html:form action="/newsItem.do">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>News Paper Clippings Download</td>	
	</tr>		
	
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit();" class=btext value="Download Images">
	</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>

<%@ include file="/commons/rws_alert.jsp"%>


</html:form>
</body>
</html>