<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<script language="javascript">


function getMileStoneStageCode(){

document.forms[0].action="switch.do?prefix=/masters&page=/ddwslnk.do?mode=data&mode1=stageCode";
	document.forms[0].submit();
}
function getSubSourceTypes(){

	document.forms[0].action="switch.do?prefix=/masters&page=/ddwslnk.do?mode=data&mode1=subSource";
		document.forms[0].submit();
	}
function validate()
{
	
	if(document.forms[0].ddwsCompCode.value=='0')
	{

		alert("please Select DDWS Component Code ");
				return false;
	}
	if(document.forms[0].mileStoneCode.value=='0')
	{

		alert("please Select MileStone ");
				return false;
	}
	 
	if(document.forms[0].mileStoneStageCode.value=='0')
	{

		alert("please Select MileStone Stage Code");
				return false;
	}

	if(document.forms[0].sourceType.value=='0')
	{

		alert("please Select Source Type");
				return false;
	}
	if(document.forms[0].subSourceType.value=='0')
	{

		alert("please Select Sub Source Type");
				return false;
	}
	if(document.forms[0].displayStatus.value=='0')
	{

		alert("please Select Display Status");
				return false;
	}
	else
		{
		
	document.forms[0].action="switch.do?prefix=/masters&page=/ddwslnk.do?mode=save";
	document.forms[0].submit();
}
}
</script>
<html:form action="ddwslnk.do">
	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "RIGHT">			
			<tr align="right">
<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>
			
			</tr>  
		</table>
	</caption>

</table>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="DDWS Link Entry"  />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	


<tr>
	<td class="mycborder">
	<FONT class=myfontclr>Component Code<font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="ddwsCompCode" styleClass="mycombo" style="width:123px" >
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="ddwsCompList">
	<html:options collection="ddwsCompList" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</tr>
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr>MileStone Code<font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="mileStoneCode" styleClass="mycombo" style="width:123px" onchange="javascript:getMileStoneStageCode()">
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="mileStonesList">
	<html:options collection="mileStonesList" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</tr>
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr>MileStone Stage Code<font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="mileStoneStageCode" styleClass="mycombo" style="width:123px">
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="mileStoneStageList">
	<html:options collection="mileStoneStageList" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</tr>
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr>Source Type<font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="sourceType" styleClass="mycombo" style="width:123px" onchange="javascript:getSubSourceTypes()">
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="sourceTypes">
	<html:options collection="sourceTypes" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</tr>
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr>Sub Source Type<font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="subSourceType" styleClass="mycombo" style="width:123px">
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="subSourceTypes">
	<html:options collection="subSourceTypes" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</tr>
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr>Display Status<font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="displayStatus" styleClass="mycombo" style="width:123px">
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<html:option value="Y">YES</html:option>
	<html:option value="N">NO</html:option>
	</html:select></td>
	</tr>
</table>

<tr>
	<td colspan="2" align="center">
	<html:button property="mode" title="Save the Fields" styleClass="btext" value="save" onclick="return validate()"/> 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

