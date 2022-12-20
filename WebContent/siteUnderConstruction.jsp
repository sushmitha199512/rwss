<%@ include file="/commons/rws_header1.jsp" %>

 <%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
<% //session.invalidate(); %>
<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server


 %>
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
<table width=100% height=90% border="0">

	<tr align=center valign=middle>
		<td>



<table width=100% height=90% border=1 bordercolor="#595CB2">
<tr align=center valign=middle>
<td>

<table border=0 width="100%">
<tr>
<td align="center" colspan="2"><img src="images/underConstruction/uc_anim26.gif" ></td>
</tr>
<tr>
<td align="center" colspan="2"><img src="images/underConstruction/uc_anim03.gif" ></td>
</tr>
<!-- 
<tr>
<td align="center"><img src="images/underConstruction/uc2_anim04.gif" ></td>
<td align="center"><img src="images/underConstruction/uc2_anim04.gif" ></td>
</tr>
 -->
 
<tr>
<td colspan="2" align="center">Go  <a href="#1" onclick="javascript:history.go(-1)">Back</a> | <a href="/pred/home.jsp">Home</a></td>
</tr>
</table>

</td></tr></table>
</td></tr>

<tr>
<td valign="bottom" class="pageFooter" align="center">
	Designed & Developed by National Informatics Centre, AP State Centre
	</td>
</tr>
</table>

</body>
</html> 
