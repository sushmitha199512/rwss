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
<table style="width: 100%;height: 100%;border-color:#595CB2;border: 1 ">

	<tr align=center valign=middle>
		<td>
		<div style="top-margin:22px;font-family:arial;font-size:18px;font-weight:bold;color:#595CB2" >
		Sorry, your session has expired.
		</div><p></p>
		<!-- <a  href="/pred/rws_login_frm.jsp"> --><a  href="/pred/">
		<img src="/pred/images/login.jpg" boreder="0"/>
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
<%
try
{
     session.getAttributeNames();
     session.invalidate();
}
catch (java.lang.Exception isse)
{
    System.out.println("session already invalidated");
}
 %>