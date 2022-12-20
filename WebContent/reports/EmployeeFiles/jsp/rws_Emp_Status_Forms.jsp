<%@ include file="/commons/rws_header1.jsp"%>
<script language="JavaScript">
<!--
window.history.forward(1);
function unview()
{
    var a=document.getElementById('combo').value;
	//alert(a);
	if(a=="-1")
	{
       document.getElementById('butview').disabled=true;
	}
}

function checkAll(field)
{
//alert(document.forms[0].selectedItems.length);
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}

function clearAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}

/*
var checkflag = "false";
function checkAll(field) {
if (checkflag == "false") {
for (i = 0; i < field.length; i++) {
field[i].checked = true;
}
checkflag = "true";
return "Uncheck All"; 
}
else 
{
for (i = 0; i < field.length; i++) {
field[i].checked = false; }
checkflag = "false";
return "Check All"; }
}*/

function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=StatusForms";
	document.forms[0].submit();
}


function getCircles()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=getCircles";
	document.forms[0].submit();
}


function getSubDivisions()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=getSubDivisions";
	document.forms[0].submit();
}

function getDivisions()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=getDivisions";
	document.forms[0].submit();
}


function showtable(index)
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do&mode=StatusForms&detailedWise="+index;
    document.forms[0].submit();
}

function fnSubmit()
{
var a=document.getElementById("hoc").value;
if(a!="0")
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do&mode=ViewReport";
    document.forms[0].submit();
    return false;
}
else
{
	alert("Select Hoc Value");
}
   
}


//-->
</script>

<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="Employee.do?mode=StatusForms">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="20%" height="80%" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width="20%" height="80%" align = "right" bgcolor="#edf2f8">
	<tr><td align="right" class="bwborder"><a href="<rws:context page='/home.jsp'/>">Home</a></td></tr>
	</table>
	</caption>
	
	<tr bgcolor="#8A9FCD" align="center"><td align="center" class="textborder" colspan="2">
	<font color="#FFFFFF">Employee Status Report</font></td>	
	</tr>

	<TR> 
	<TD  valign=top  align="center" height="80%" width="20%">
	<table  bordercolor= navy width="20%" height="80%" border=1 rules="rows" style="border-collapse:collapse" align = center>
	
	<tr>
	<td class=rptLabel>Head Office&nbsp;&nbsp;<font color="#FF6666">*</font></td>
		<td class=btext>
		<html:select property="hoc" styleClass="mycombo" style="width:130px"  onchange="getCircles();getData()" >
		<html:option value="0">SELECT...</html:option>
		<html:options collection="heads" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	</tr>
		
	<tr>
	<td class=rptLabel>Circle Office&nbsp;&nbsp;</td>
	<td class=btext>
		<html:select property="coc" style="width:130px" styleClass="mycombo" onchange="getDivisions();getData()">
		<html:option value="00"><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="circlecodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	</tr>
		
	<tr>
	<td class=rptLabel>Division Office&nbsp;&nbsp;</td>
	<td class=btext>			
		<html:select property="doc" style="width:130px" styleClass="mycombo" onchange="getSubDivisions();getData()" >
		<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="divcodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	</tr>

	<tr>
	<td class=rptLabel>SubDivision Office&nbsp;&nbsp;</td>
	<td class=btext>
		<html:select property="sdoc" styleClass="mycombo" style="width:130px" onchange="javascript:getData()">
		<html:option value="00"><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="subdivcodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	</tr>
		

	<tr>					
	<td class="clrborder">
	<html:radio property="detailedWise" value="01" onclick="javascript:showtable('01');"><font size=2 color="purple">DesignationWise&nbsp;</font></html:radio>
	<html:radio property="detailedWise" value="02" onclick="javascript:showtable('02')"><font size=2 color="purple">ZoneWise</font></html:radio>
	&nbsp;<font size="5">.</font>
	<font size=2 color="purple">Sector</font>
	<html:select property="sector" styleClass="mycombo" style="width:80" onchange="getData()" >
	<html:option value="0"><font class="myfontclr1">SELECT..</font></html:option>
	<html:options collection="sectorcode" name="labelValueBean" property="value" labelProperty="label"/>
	</html:select>
	</td>
	</tr>
	
</table>
<td valign=top height=40% align="center" width="70%">
<div  style="position:relative;overflow-y:auto;left:0;height:300;width:100%;top:0;"> 
<logic:present name="designations">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=100%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
<td class=btext>
<logic:iterate id="list" name="designations" scope="session">
<html:multibox property="selectedItems">
<bean:write name="list" property="value"/>
</html:multibox>
<bean:write name="list" property="label"/><br/>
</logic:iterate>

</td>
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
	<tr>
	<td width="100%" colspan="2" align="center" class = btext nowrap>
	<html:button property="selectedItems" value="CheckAll" onclick="javascript:checkAll(document.forms[0].selectedItems);"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<html:button property="selectedItems" value="ClearAll" onclick="javascript:clearAll(document.forms[0].selectedItems);"/>
	</td></tr>	
	</table>
	</table>
</logic:present>	
</div>
</td>
</TR>

	<tr>
	<td colspan=2 align=center class=btext>
	<html:submit property="submitReport" onclick="fnSubmit()" value="View Report"  />
	</td>
	</tr>

</table>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>



	