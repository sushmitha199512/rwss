<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
<%@ include file="/commons/Cache_Control.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function winClose()
{
	location.href="<rws:context page='/home.do'/>";
}
function winClosePraja()
{
	location.href="<rws:context page='/home.do?loginMode=prajapatham'/>";
}
//-->
</SCRIPT>
</head>
<jsp:useBean id="RWS_USER" scope="session" class="nic.watersoft.commons.RwsUser" />

<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">

<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0" >
<!-- Page header starts here-->
<tr height="1%">
	<td class="pageHeading" align="center">
		<bean:message key="app.title1" />
		 <span style="font-family:verdana; font-size: 8pt; "></span>		
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading1" align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="app.heading1" />
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="app.heading2" />
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;
	</td>
</tr>
<tr height="1%">
	<td colspan=1>
	<table width="100%" class="userDetails" cellpadding="0" cellspacing="0">
	<tr>
	<td nowrap><b>
		<font size=1>Welcome, Guest</font>
		 </b>
		 <A href="/pred/rws_login_frm.jsp">[<font size=2><b>Go Home</b></font>]</A>
		</td>
		
			<td align="right"><b>
				<%=sdf.format(new java.util.Date())%>&nbsp;&nbsp;&nbsp;&nbsp;
       </b></td>
      
		</tr>
		</table>
	</td>
	
</tr><tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;
	</td>
</tr>

<!-- Page content starts here -->
<tr height="93%">
	<td align="center">
