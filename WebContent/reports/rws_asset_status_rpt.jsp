<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-html-el.tld" prefix="htmlel" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>

<html:html>
<HEAD>
<TITLE>Asset_Status</TITLE>
<script language="javascript">
<!--
function state()
{
if(document.forms[0].level[1].checked==true)
{
	showdiv('D1');
	showdiv('D2');
}
else
{
	hidediv('D1');
	hidediv('D2');
}
}
function showdiv(id)
{
document.getElementById(id).style.display='block';
}

function hidediv(id)
{
document.getElementById(id).style.display='none';
}


function getData2()
{
document.forms[0].mandal.value="ALL";
document.forms[0].action="switch.do?prefix=/reports&page=/assetStatus.do?mode=Assets";
document.forms[0].submit();
}


//-->
</script>
<%@ include file="/commons/rws_header2.jsp" %>
</HEAD>

<BODY onload="javascript:state();">
<html:form action="assetStatus.do">

<table width="780" align="center">
<tr><td align="right"><a href="../rws_login_frm.jsp">Home</a></td></tr>
</table>

<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="760" align="center">
<tr>
<td>
	<FIELDSET>
	<LEGEND> Asset Status Report</LEGEND>
	<LABEL>
	<table border="0" width="770" align="center">
	<tr>
	<td class="textborder">Level
	
	<html:radio property="level" value="S" onclick="javascript:state();">State</html:radio>
	<html:radio property="level" value="D" onclick="javascript:state();">District</html:radio>
	</td>
	
	<td id="D1" class="textborder" style="display:none">District
	<html:select property="district" style="width:150px" styleClass="mycombo" onchange="javascript:getData2();">
	<html:option value="ALL"><font style="myfontclr1">ALL</font></html:option>
	<logic:present name="assetDistricts">
	<html:options collection="assetDistricts" name="labelValueBean" property="value" labelProperty="label"/>
	</logic:present>
	</html:select>
	</td>
	<td id="D2" class="textborder" style="display:none">Mandal
	<html:select property="mandal" style="width:150px" styleClass="mycombo" >
	<html:option value="ALL"><font style="myfontclr1">ALL</font></html:option>
	<html:options collection="assetMandals" name="labelValueBean" property="value" labelProperty="label"/>
	</html:select>
	</td>
	</tr>
	
</table>
</LABEL>
</FIELDSET>

<tr>
<td colspan="2" align="center">
<html:submit property="mode" title="submit" value="Assets" styleClass="btext"></html:submit>
</td>
</tr>
</table>

<%
try
{

if(request.getParameter("level").equals("S"))
{
%>
<%@ include file="rws_asset_status_state_rpt.jsp" %>
<%
}
if(request.getParameter("level").equals("D") && request.getParameter("district").equals("ALL") && request.getParameter("mandal").equals("ALL"))
{
//System.out.println("In District");
%>
<%@ include file="rws_asset_status_district_rpt.jsp" %>
<%
}
if(request.getParameter("level").equals("D") && !request.getParameter("district").equals("ALL") && request.getParameter("mandal").equals("ALL"))
{%>
<%@ include file="rws_asset_status_mandal_rpt.jsp" %>
<%
}
if(request.getParameter("level").equals("D") && !request.getParameter("district").equals("ALL") && !request.getParameter("mandal").equals("ALL"))
{
%>
<%@ include file="rws_asset_status_mandal1_rpt.jsp" %>
<%
}
}catch(Exception e)
{
}
 %>


</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp" %>
</BODY>
</html:html>
