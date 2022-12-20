<%@		taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@		taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@		taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@		taglib uri="/WEB-INF/jstl-core" prefix="c" %>
<html>	
<head>
<title>WATERSOFT</title>

	<link rel="stylesheet" type="text/css" href="resources/style/style.css">
		<link rel="stylesheet" type="text/css" href="resources/style/menu.css">
		
<Script language="javaScript">
function getDivisions()
{
 document.physicalForm.action="GenPhysicalProgressReport.do";
 document.physicalForm.submit();
}
function getSubDivisions()
	{
		document.physicalForm.action="GenPhysicalProgressReport.do";
		document.physicalForm.submit();
	}
	function getMonths()
	{
		document.physicalForm.action="GenPhysicalProgressReport.do";
		document.physicalForm.submit();
		
	}
</Script>
	</head>
	<html:messages id="error">
<%=error%><br>
</html:messages>
<body>
<html:form action="PhysicalReport" onsubmit="return validatePhysicalForm(this)">
<center>
<span class = "mainHeading">WATERSOFT</span><br>
<span class = "mainHeading">Panchayat Raj & Engineering Department, Rural Water Supply Sector</span> <br>
<span class = "mainHeading">Government of Andhra Pradesh</span>




	<table cellpadding="0" cellspacing="0" align="center">
		<tr height="70%">
			<td>
	<table cellpadding="0" cellspacing="0" width="450" align="center">
		<tr>
			<td>
	
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="resources/images/top_left_b.gif"></td>
			<td background="resources/images/top_center_b.gif" width="67%" class="heading" valign="middle" align="center" class id ="mainheading">Physical Progress Report</td>
			<td><img src="resources/images/top_right_b.gif"></td>
		</tr>
	</table>
	
	<table width="58%" bgcolor=#edf2f8 cellpadding="2" cellspacing="2" border="1" bordercolor="#364d67" rules="none" style="border-collapse:collapse">
	<tr>
		<logic:present name="circles">
		<td class=label><bean:message key="app.common.circle" />
		<td class=label>:</td>
		<td><html:select property="cmbCircle" styleClass="comboFont" onchange="getDivisions()">
			<html:option value="">Please Select...</html:option>
			<html:options collection="circles"  property="code" labelProperty="name" />
			</html:select>
		</td>
		</logic:present>
	</tr>
	<tr>
	
		<logic:present name="divisions">
		<td class=label><bean:message key="app.common.division" />
		<td class=label>:</td>
		<td><html:select property="cmbDivision" styleClass="comboFont" onchange="getSubDivisions()">
			<html:option value="">Please Select...</html:option>
			<html:options collection="divisions" name="division" property="code" labelProperty="name" />
			</html:select>
		</td>
		</logic:present>

		<logic:notPresent name="divisions">
		<td class=label><bean:message key="app.common.division" />
		<td class=label>:</td>
		<td><html:select property="cmbDivision" styleClass="comboFont" >
			<html:option value="">Please Select...</html:option>

			</html:select>
		</td>
		</logic:notPresent>
	
	</tr>
	<tr>
		<logic:present name="subdivisions">
		<td class=label><bean:message key="app.common.subdivision" />
		<td class=label>:</td>
		<td><html:select property="cmbSubDivision" styleClass="comboFont" >
			<html:option value="">Please Select...</html:option>
			<html:options collection="subdivisions" name="subdivision" property="code" labelProperty="name" />
			</html:select>
		</td>
		</logic:present>

		<logic:notPresent name="subdivisions">
		<td class=label><bean:message key="app.common.subdivision" />
		<td class=label>:</td>
		<td><html:select property="cmbSubDivision" styleClass="comboFont" >
			<html:option value="">Please Select...</html:option>
			</html:select>
		</td>
		</logic:notPresent>
	</tr>
	<tr>
		
		<td class=label><bean:message key="app.common.year" />
		<td class=label>:</td>
		<td><html:select property="cmbYear" styleClass="comboFont" onchange="getMonths()">
			<html:option value="">Please Select...</html:option>
			<html:option value="01">All</html:option>
			<html:option value="02">2003</html:option>
			<html:option value="03">2004</html:option>
			<html:option value="04">2005</html:option>
			<html:option value="05">2006</html:option>
			<html:option value="06">2007</html:option>
			</html:select>
		</td>
		</tr>
		
		
		
			<tr>
		<logic:present name="months">
		<td class=label><bean:message key="app.common.month"/>
		<td class=label>:</td>
		<td><html:select property="cmbMonth" styleClass="comboFont" >
		    <html:option value="">Please Select...</html:option>
			<html:options collection="months" name="month" property="code" labelProperty="name" />
			</html:select>

		</td>
		</logic:present>
		<logic:notPresent name="months">
		<td class=label><bean:message key="app.common.month"/>
		<td class=label>:</td>
		<td><html:select property="cmbMonth" styleClass="comboFont" >
		    <html:option value="">Please Select...</html:option>

			</html:select>
		</td>
		</logic:notPresent>
	</tr>
		
	<tr>
		  <td colspan="6"><hr size="1" color="#525e6e"></td>
		</tr> 
	
		<TR>
		<TD align=center  colspan=6><html:submit />
		</TD>
		</TR>
	</table>
	<table cellpadding="0" cellspacing="0" >
		<tr>	

			<td><img src="resources/images/bottom_left.gif"></td>
			<td background="resources/images/bottom_center.gif" width="222" class="heading" valign="middle"	align="center"></td>
			<td><img src="resources/images/bottom_right.gif" ></td>
		</tr>
		</table>
		</center>
		</html:form>
		</body>
		</html>
