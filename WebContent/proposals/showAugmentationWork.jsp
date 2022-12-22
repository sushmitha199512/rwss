<%@include file="/commons/rws_header1.jsp"%>

<script type="text/javascript">
<!--
function fnGetEndYears(that)
{
	var frm = that.form;
	var assetType = document.getElementById("assetType").value;
	var url = "switch.do?prefix=/proposals&page=/PickAugmentationWork.do&mode=endYears"
			+ "&assetType="+assetType;
	frm.action = url;
	frm.submit();		
}

function fnGetAssetIds(that)
{
	var frm = that.form;
	var endYear = document.getElementById("year").value;
	var assetType = document.getElementById("assetType").value;
	var url = "switch.do?prefix=/proposals&page=/PickAugmentationWork.do&mode=assetIds"
			+ "&endYear="+endYear+"&assetType="+assetType;
	frm.action = url;
	frm.submit();		
}
function fnSave()
{
	var openerDoc = opener.document;
	var workId = document.getElementById("workId").value;
	openerDoc.getElementById("WORK[0].workId").value = workId;
	window.close();
	return false;
}
//-->
</script>
</HEAD>

<BODY bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<html:form action="PickAugmentationWork">
<TABLE width="100%" border="0" cellpadding="2" cellspacing="0">
	<TBODY>
		<TR>
			<TD class="staticLabelBold"><bean:message key="app.scheme" /></TD>
			<TD>:</TD>
			<TD>
				<html:select property="assetType" styleClass="combo"
							 onchange="javascript: fnGetEndYears(this)">
				<html:option value="">
					<bean:message key="app.pleaseSelect" />
				</html:option>
				<html:options collection="assetTypes" name="labelValueBean"
					property="value" labelProperty="label" />
				</html:select>
			</TD>
		</TR>
		<TR>
			<TD class="staticLabelBold"><bean:message key="app.year" /></TD>
			<TD>:</TD>
			<TD>
				<html:select property="year" styleClass="combo"
							 onchange="javascript: fnGetAssetIds(this)">
				<html:option value="">
					<bean:message key="app.pleaseSelect" />
				</html:option>
				<logic:present name="endYears">
					<html:options collection="endYears" name="labelValueBean"
								  property="value" labelProperty="value" />
				</logic:present>
				</html:select>
			</TD>
		</TR>
		<TR>
			<TD class="staticLabelBold"><bean:message key="app.work" /></TD>
			<TD>:</TD>
			<TD>
				<html:select property="workId" styleClass="combo" style="width: 300px">
				<html:option value="">
					<bean:message key="app.pleaseSelect" />
				</html:option>
				<logic:present name="assetIds">
					<html:options collection="assetIds" name="labelValueBean"
								  property="value" labelProperty="label" />
				</logic:present>	
				</html:select>
			</TD>
		</TR>
		<TR>
			<TD colspan="3" align="center">
			<html:submit styleClass="btext" onclick="return fnSave()">
				<bean:message key="button.save" />
			</html:submit>
			<html:button property="btnClose" styleClass="btext" 
						 onclick="javascript:fnClose()">	
				<bean:message key="button.close" />				
			</html:button>	
			</TD>
		</TR>
	</TBODY>
</TABLE>
</html:form>
</BODY>
</html>
