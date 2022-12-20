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
<script language="JavaScript">
	function fnSave() {
		document.forms[0].action = "switch.do?prefix=/masters&page=/AssetChange.do&mode=saveassethabs";

		document.forms[0].submit();

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

		<jsp:include page="/commons/TableHeader1.jsp">
			<jsp:param name="TableName" value="Asset Details" />
			<jsp:param name="TWidth" value="670" />
		</jsp:include>
		<table align=center bgcolor="#DEE3E0" bordercolor="#8A9FCD" border="1"
			style="border-collapse: collapse;" width="700">
			<logic:iterate id="assetChangeDetails1" name="assetChangeDetails1"
				indexId="index">
				<tr>
					<td class="mycborder">
						<fieldset>
							<legend>Asset Present Details</legend>
							<label>

								<table border=0 width="700">

									<tr align="center">
										<td class="textborder" align="left">Asset Code<span
											class="mandatory"></span></td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="assetCode"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
										<td class="textborder" align="left">Asset Name<span
											class="mandatory"></span></td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="assetName"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
									</tr>
									<tr align="center">
										<td class="textborder" align="left">Habitation Code<span
											class="mandatory"></span></td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="habCode"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
										<td class="textborder" align="left">Habitation Name<span
											class="mandatory"></span></td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="habName"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
									</tr>
									<tr align="center">
										<td class="textborder" align="left">Location<span
											class="mandatory"></span></td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="location"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
										<td class="textborder" align="left">Asset Cost(Rs. in
											Lakhs)<span class="mandatory"></span>
										</td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="assetCost"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
									</tr>
									<tr align="center">
										<td class="textborder" align="left">Type Of Asset<span
											class="mandatory"></span></td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="typeOfAsset"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
										<%-- <td class="textborder" align="left">Asset Cost(Rs. in Lakhs)<span class="mandatory"></span></td>
		 <td class="textborder" ><html:text name="assetChangeDetails1" property="assetCost" readonly="true" styleClass="mytext" style="width:140px"/></td> --%>
									</tr>
									<tr align="center">
										<td class="textborder" align="left">Present Division<span
											class="mandatory"></span></td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="prasentDivision"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
										<td class="textborder" align="left">Present Sub Division<span
											class="mandatory"></span></td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="prasentSubDivision"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
									</tr>


									<html:hidden name="assetChangeDetails1" property="habCode"
										styleId="source" />
									<html:hidden name="assetChangeDetails1" property="division"
										styleId="source" />

									<html:hidden name="assetChangeDetails1" property="subDivision"
										styleId="source" />
									<html:hidden name="assetChangeDetails1" property="circle"
										styleId="source" />
									<html:hidden name="assetChangeDetails1" property="workasset"
										styleId="source" />
									<html:hidden name="assetChangeDetails1"
										property="changeToDivisionCode" styleId="source" />
									<html:hidden name="assetChangeDetails1"
										property="changeToSubDivisionCode" styleId="source" />

								</table>
							</label>
						</fieldset>
					</td>
				</tr>

				<tr>
					<td class="mycborder">
						<fieldset>
							<legend>Asset Change To Details</legend>
							<label>

								<table border=0 width="700">


									<tr align="center">
										<td class="textborder" align="left">Change To Division<span
											class="mandatory"></span></td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="changeToDivision"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
										<td class="textborder" align="left">Change To Sub
											Division<span class="mandatory"></span>
										</td>
										<td class="textborder"><html:text
												name="assetChangeDetails1" property="changeToSubDivision"
												readonly="true" styleClass="mytext" style="width:140px" /></td>
									</tr>


								</table>
							</label>
						</fieldset>
					</td>
				</tr>

				<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
				<html:hidden property="token" styleClass="mytext"
					value="${sessionScope.csrfToken}" />
				<tr align="center">
					<td align="center"><input type=button value=Save id="sBtn"
						class="btext" onclick="fnSave()" /></td>
				</tr>
			</logic:iterate>
		</table>
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="670" />
		</jsp:include>

	</html:form>
	<%@ include file="/commons/rws_footer.jsp"%>
	<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

