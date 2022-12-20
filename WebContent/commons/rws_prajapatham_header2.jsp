
<!-- prajapatham header begins here -->


<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
 
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
		Prajapatham
		 <span style="font-family:verdana; font-size: 8pt; "></span>		
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading1" align="center">
		
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		<bean:message key="app.heading2" />
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
		Welcome, <bean:write name="RWS_USER" property="userId" />
		<font face = "italic" size=1 color =#0000FF>
		<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00"> -- <bean:write name="RWS_USER" property="circleOfficeName"/>
		</logic:notEqual>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="00"> -- <bean:write name="RWS_USER" property="divisionOfficeName"/>
		</logic:notEqual>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00"> -- <bean:write name="RWS_USER" property="subdivisionOfficeName"/>
		</logic:notEqual>
		</font>
		[ <c:out value="${sessionScope.RWS_USER.officeName} User" /> ]</b>
		 <A href="/pred/Logout.do">[Logout]</A>
		</td>
		
			<td align="right"><b>
				<%=sdf.format(new java.util.Date())%>&nbsp;&nbsp;&nbsp;&nbsp;
       </b></td>
      
		</tr>
		</table>
	</td>
	
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;
	</td>
</tr>

<!-- Page content starts here -->
<tr height="93%">
	<td align="center">

<!-- end of prajapatham header -->
