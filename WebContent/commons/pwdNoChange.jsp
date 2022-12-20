<%@ include file="/commons/rws_header1.jsp" %>

 <%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
	nic.watersoft.commons.RwsUser user = (nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//System.out.println(user);
%>
<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
</head>
<body style="background-color:#fff;">
<table border=0  width="100%" cellpadding=0 cellspacing=0>
<tr>
<td align=left  width="5%">
<!--  <IMG SRC="/pred/images/PredSymbol.gif" WIDTH="40" HEIGHT="40">  -->
</td>
<td align=center class="pageHeading">
	WaterSoft 
	<span style="font-family:verdana; font-size: 8pt; "> </span>		
</td>
</tr>

<tr >
	<td class="pageHeading1" align="center" colspan="2">
		Panchayat Raj Engineering Department, Rural Water Supply Sector
	</td>
</tr>
<tr >
	<td class="pageHeading2" align="center" colspan="2">
		Government  of Andhra Pradesh
	</td>
</tr> 
<tr>
<td align="right" colspan="10" class="pageFooter"><b>
				<%=sdf.format(new java.util.Date())%>&nbsp;&nbsp;&nbsp;&nbsp;
       </b></td>
</tr>


</table>
<table width=100% height=90% border=1 bordercolor="#595CB2">

	<tr align=center valign=middle>
		<td>
		<font face=verdana size=4 color=red><B><%=request.getAttribute("message")%></B></font><BR><BR><BR><BR>
			<a  href="switch.do?prefix=/admin&page=/ChangePasswordAction.do&mode=init">
				<font face=verdana size=3 color=BLUE><B>Update Password</B></font>
			</a>
		</td>
		</tr>
		<tr height="2%">
	<td valign="bottom" class="pageFooter" align="center">
	Designed & Developed by National Informatics Centre, AP State Centre
	</td>
</tr>
</table>

</body>
</html> 
<rws:alert />