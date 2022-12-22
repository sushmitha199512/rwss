<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String qry3 = "";
%>
<html>
<head>
<script language="JavaScript">
	function fnCheck() {
		document.f1.ast_type.disabled = true;
		if (document.f1.Type.value == 'A') {
			document.f1.ast_type.disabled = true;
		} else if (document.f1.Type.value == 'C') {
			document.f1.ast_type.disabled = false;
		}
	}
	function fnSubmit() {
		if (document.f1.Type.value == '') {
			alert("Please select type");
		} else if (document.f1.Type.value == 'A') {
			document.f1.action = "./rws_asset_images_rpt.jsp";
			document.f1.submit();
		} else if (document.f1.Type.value == 'C') {
			document.f1.action = "./rws_asset_comp_images_rpt.jsp";
			document.f1.submit();
		}
	}
</script>
</head>
<body bgcolor="#edf2f8" onload="fnCheck()">
	<form name=f1 method="post">
		<table border=1 align=center cellspacing=0 cellpadding=0 rules="rows"
			bordercolor=navy style="border-collapse: collapse" bgcolor="#ffffff"
			width=350>
			<caption>
				<table border=0 rules=none style="border-collapse: collapse"
					width=100% align="right" bgcolor="#edf2f8">
					<tr>
						<td align="right" class="bwborder"><a
							href="/pred/home.jsp?loginMode=watersoft">Home</td>
					</tr>
				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class="rptHeading" colspan=3>Assets and
					Components - Image Status</td>
			</tr>
			<tr>
				<td class=rptLabel>Type&nbsp;&nbsp;<font color="red">*</font></td>
				<td class=btext><SELECT name="Type" id="combo" class="mycombo"
					style="width: 150px" onchange="fnCheck()">
						<option value="">-Select-</option>
						<option value="A">Assets</option>
						<option value="C">Components</option>
				</SELECT></td>
			</tr>
			<tr>
				<td class=rptLabel>Asset Type&nbsp;&nbsp;<font color="red">*</font></td>
				<td class=btext><SELECT name="ast_type" id="combo"
					class="mycombo" style="width: 150px">
						<option value="">-Select-</option>
						<option value="01">PWS</option>
						<option value="02">MPWS</option>
						<option value="03">CPWS</option>
						<option value="09">Direct Pumping</option>
				</SELECT></td>
			</tr>
			<tr bgcolor="#8A9FCD" align="center">
				<td colspan=3 align="center"><input type=button id="vbutton"
					onclick="fnSubmit()" class=btext value="View Details"></td>
			</tr>
		</table>
		
		<%@ include file="/commons/rws_footer.jsp"%>
		<%-- <%@ include file="/reports/connClose.jsp" %>  --%>



	</form>
</body>
</html>