<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


<style>
.mystyle {
	border-width: 1;
	color: brown;
	font-weight: bold;
	font-family: verdana;
	font-size: 8pt;
}

.mystyle1 {
	border-width: 1;
	color: black;
	font-family: verdana;
	font-size: 8pt;
}
</style>
</head>
<script language="JavaScript"
	src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}

	function wopen(url, name, w, h) {
		// Fudge factors for window decoration space.
		// In my tests these work well on all platforms & browsers.
		w += 32;
		h += 96;
		var win = window.open(url, name, 'width=' + w + ', height=' + h + ', '
				+ 'location=yes, menubar=no, '
				+ 'status=yes, toolbar=no, scrollbars=yes, resizable=yes');

		win.focus();
	}
</script>





<%
	Date systemdate = new java.util.Date(System.currentTimeMillis());
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String transdate = null;
	transdate = dateFormat.format(systemdate);

	String circleName = session.getAttribute("circleName").toString();
	String circleCode = session.getAttribute("circleCode").toString();
%>

<body>


	<html:form action="AssetChange.do">
		<font color="red" size="2">Circle Name:<%=circleName%>
		</font>
		<jsp:include page="/commons/TableHeader1.jsp">
			<jsp:param name="TableName" value="Asset Details" />
			<jsp:param name="TWidth" value="1000" />
		</jsp:include>


		<table width="800" border=1 style="border-collapse: collapse;">

			<tr>
				<td class="btext" align="center">S.No</td>

				<td class="btext" align="center">Asset Code</td>
				<td class="btext" align="center">Asset Name</td>
				<td class="btext" align="center">Habitation Code</td>
				<td class="btext" align="center">Habitation Name</td>
				<td class="btext" align="center">Location</td>
				<td class="btext" align="center">Asset&nbsp;Cost (Rs. in Lakhs)</td>
				<td class="btext" align="center">Present&nbsp;Division</td>
				<td class="btext" align="center">Present SubDivision</td>

				<td class="btext" align="center">Edit</td>
			</tr>
			<%
				int count = 1;
			%>

			<logic:iterate id="assetChangeDetails" name="assetChangeDetails"
				indexId="index">
				<tr id='tr<%=count%>' onclick="changeColor(this)";>
					<td class="rptValue" align="center"><%=count++%></td>
					<td class="rptValue" align="right"><bean:write
							name="assetChangeDetails" property="assetCode" /></td>
					<html:hidden name="assetChangeDetails" property="assetCode"
						indexed="true" styleId="source" />
					<td class="rptValue" align="center"><bean:write
							name="assetChangeDetails" property="assetName" /></td>
					<td class="rptValue" align="right"><bean:write
							name="assetChangeDetails" property="habCode" /></td>
					<html:hidden name="assetChangeDetails" property="habCode"
						indexed="true" />
					<td class="rptValue" align="left"><bean:write
							name="assetChangeDetails" property="habName" /></td>

					<td class="rptValue" align="left"><bean:write
							name="assetChangeDetails" property="location" /></td>
					<td class="rptValue" align="right"><bean:write
							name="assetChangeDetails" property="assetCost" /></td>
					<td class="rptValue" align="left"><bean:write
							name="assetChangeDetails" property="prasentDivision" /></td>
					<html:hidden name="assetChangeDetails" property="division"
						indexed="true" styleId="source" />
					<td class="rptValue" align="left"><bean:write
							name="assetChangeDetails" property="prasentSubDivision" /></td>
					<html:hidden name="assetChangeDetails" property="subDivision"
						indexed="true" styleId="source" />
					<td class="rptValue" align="center"><a
						href="switch.do?prefix=/masters&page=/AssetChange.do&mode=edit&assetcode=<bean:write name="assetChangeDetails" property="assetCode"/>&habCode=<bean:write name="assetChangeDetails" property="habCode"/>&prasentDivision=<bean:write name="assetChangeDetails" property="division"/>&prasentSubDivision=<bean:write name="assetChangeDetails" property="subDivision"/>&circleCode=<%=circleCode%>">Edit</a></td>
				</tr>
			</logic:iterate>
			<%
				if (count == 1) {
			%><tr align="center">
				<td colspan="9" align="center" class="btext">No Records</td>
			</tr>

			<%
				}
			%>




		</table>

		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="1000" />
		</jsp:include>

	</html:form>


	<%@ include file="/commons/rws_footer.jsp"%>
	<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

