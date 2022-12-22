<%@		taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@		taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@		taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@		taglib uri="/WEB-INF/jstl-core" prefix="c" %>


<html>			
	<head>
<html:javascript formName="/PhysicalProgress" />
<script language="JavaScript">

	function getSubDivisions()
	{
		document.physicalForm.action="/pred/worksMonitoring/GenPhysicalProgressAction.do";
		document.physicalForm.submit();
	}
	function getDivisions()
	{
		document.physicalForm.action="/pred/worksMonitoring/GenPhysicalProgressAction.do";
		document.physicalForm.submit();

	}
	function winClose()
{
	location.href="/Pred/home.do";
}
function main()
{
	window.location="/Pred/home.do";
}
	</script>
	<title>WATERSOFT</title>


	<link rel="stylesheet" type="text/css" href="resources/style/style.css">
		<link rel="stylesheet" type="text/css" href="resources/style/menu.css">
	</head>
	
	<body>
		 
<html:form action="PhysicalProgress" onsubmit="return validatePhysicalForm(this)">

<center>
 <span class = "mainHeading">WATERSOFT</span><br>
<span class = "mainHeading">Panchayat Raj & Engineering Department, Rural Water Supply Sector</span> <br>
<span class = "mainHeading">Government of Andhra Pradesh</span>
<br><br><br>
 
<!--  <tr height="1%">
	<td class="pageHeading" align="center">
		WaterSoft
		 <span style="font-family:verdana; font-size: 8pt; "></span>		
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading1" align="center">
		Panchayat Raj Engineering Department, Rural Water Supply Sector
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		Government  of Andhra Pradesh
	</td>
</tr> -->


	


	<!-- <table cellpadding="0" cellspacing="0" align="center">
		<tr height="70%">
			<td>
	<table cellpadding="0" cellspacing="0" width="450" align="center">
		<tr>
			<td>
	
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="resources/images/top_left_b.gif"></td>
			<td background="resources/images/top_center_b.gif" width="100%" class="heading" valign="middle" align="center" class id ="mainheading">Physical Progress Entry Form</td>
			<td><img src="resources/images/top_right_b.gif"></td>
		</tr>
	</table> -->
	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_t_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=400>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#000000" face=verdana size=2><B><center>Physical Progress Entry Form</center></B><font></td>
	    <td align=right><IMG SRC="/pred/resources/images/icon_help.gif" WIDTH="13" HEIGHT="13" style="cursor:hand">&nbsp;
		<IMG SRC="/pred/resources/images/cloapp.gif" WIDTH="13" HEIGHT="13" onclick="winClose()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_t_right1.gif" ALT=""></TD>
</TABLE>
	
	<table width="440" bgcolor=#edf2f8 cellpadding="2" cellspacing="2" border="1" bordercolor="#364d67" rules="none" style="border-collapse:collapse">
	<tr>
		<td class=label><bean:message key="app.common.circle" />
		<td class=label>:</td>
		<logic:present name="circles">
		<td><html:select property="cmbCircle" styleClass="comboFont" style="width:127px" onchange="getDivisions()">
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
		<td><html:select property="cmbDivision" styleClass="comboFont" style="width:127px" onchange="getSubDivisions()">
			<html:option value="">Please Select...</html:option>
			<html:options collection="divisions" name="division" property="code" labelProperty="name" />
			</html:select>
		</td>
		</logic:present>

		<logic:notPresent name="divisions">
		<td class=label><bean:message key="app.common.division" />
		<td class=label>:</td>
		<td><html:select property="cmbDivision" styleClass="comboFont" style="width:127px">
			<html:option value="">Please Select...</html:option>

			</html:select>
		</td>
		</logic:notPresent>
	
	</tr>
	<tr>
		<logic:present name="subdivisions">
		<td class=label><bean:message key="app.common.subdivision" />
		<td class=label>:</td>
		<td><html:select property="cmbSubDivision" styleClass="comboFont" style="width:127px">
			<html:option value="">Please Select...</html:option>
			<html:options collection="subdivisions" name="subdivision" property="code" labelProperty="name" />
			</html:select>
		</td>
		</logic:present>

		<logic:notPresent name="subdivisions">
		<td class=label><bean:message key="app.common.subdivision" />
		<td class=label>:</td>
		<td><html:select property="cmbSubDivision" styleClass="comboFont" style="width:127px">
			<html:option value="">Please Select...</html:option>
			</html:select>
		</td>
		</logic:notPresent>
	</tr>
	<tr>
		<td class=label><bean:message key="app.common.assettype" />
		<td class=label>:</td>
		<td><html:select property="cmbAssetType" styleClass="comboFont" style="width:127px">
			<html:option value="">Please Select...</html:option>
			<html:option value="01">PWS</html:option>
			<html:option value="02">MPWS</html:option>
			<html:option value="03">CPWS</html:option>
			<html:option value="04">HandPumps</html:option>
			<html:option value="05">Shallow Hand Pumps</html:option>
			</html:select>
		</td>
	
	</tr>
	<tr>
		<logic:present name="months">
		<td class=label><bean:message key="app.common.month"/>
		<td class=label>:</td>
		<td><html:select property="cmbMonth" styleClass="comboFont" style="width:127px">
		    <html:option value="">Please Select...</html:option>
			<html:options collection="months" name="month" property="code" labelProperty="name" />
			</html:select>

		</td>
		</logic:present>
		<logic:notPresent name="months">
		<td class=label><bean:message key="app.common.month"/>
		<td class=label>:</td>
		<td><html:select property="cmbMonth" styleClass="comboFont" style="width:127px">
		    <html:option value="">Please Select...</html:option>

			</html:select>
		</td>
		</logic:notPresent>
	</tr>
	<tr>
		<logic:present name="financialyears">
		<td class=label><bean:message key="app.common.year" />
		<td class=label>:</td>
		<td><html:select property="cmbYear" styleClass="comboFont" style="width:127px">
			<html:option value="">Please Select...</html:option>
			<html:options name="financialyears" labelName="financialyears" />
			</html:select>
		</td>
		</logic:present>
		<logic:notPresent name="financialyears">
		<td class=label><bean:message key="app.common.year" />
		<td class=label>:</td>
		<td><html:select property="cmbYear" styleClass="comboFont" style="width:127px">
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
		<INPUT class id ="buttonfont" id=button1 type=button value=Exit name=button1 onClick="main()">
		</TD>

		</TR>
		</table>
		<tr><td>
		<!-- <table cellpadding="0" cellspacing="0" width="100%">
		<tr>	

			<td><img src="resources/images/bottom_left.gif"></td>
			<td background="resources/images/bottom_center.gif" width="100%" class="heading" valign="middle"	align="center"></td>
			<td><img src="resources/images/bottom_right.gif"></td>
		</tr> -->
		<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_b_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=400>
	  <!-- <FONT  style="font-size:9pt" color="#000000"><font color="#FF6666" >*</font>&nbsp;Data mandatory</FONT></td> -->
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_b_right1.gif" ALT=""></TD>
</TABLE>
	</table>
	</td>
	</tr>
	</table>
	</td></tr></table>
	<html:hidden property="circleName" />
	<html:hidden property="divisionName" />
	</center>
	</html:form>

