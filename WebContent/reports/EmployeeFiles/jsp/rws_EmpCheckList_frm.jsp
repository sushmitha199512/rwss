<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html:javascript formName="empForm" />
<script language="JavaScript">
window.history.forward(1);
<!-- 
/*function viewCheckList()
{
if(document.empForm.selection[0].checked)
{
document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=viewCheckList";
document.forms[0].submit();
return false;
}
}
function viewCheckList1()
{
if(document.empForm.selection[1].checked)
{
document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=viewCheckList";
document.forms[0].submit();
return false;
}
}
//else
//{
//document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=dates";
//document.forms[0].submit();
//return false;
//}

//}

function wise()
{
	if(document.empForm.selection[0].checked)
	{
	showdiv('a1');
	hidediv('a2');
	}
	else 
	{
	
	hidediv('a1');
	showdiv('a2');
	}
}*/

function hidediv(id)
 {
	//safe function to hide an element with a specified id
	document.getElementById(id).style.display = 'none';
 }
function showdiv(id)
 {
	//safe function to hide an element with a specified id
	document.getElementById(id).style.display = 'block';
 }


function fnGetOffices(elem)
{
	var elemName = elem.name;
	var url;
	if(elemName == 'headOfficeCode')
		url ="switch.do?prefix=/admin&page=/UserManagementData.do&mode=headOffice";
	else
	if(elemName == 'circleOfficeCode')
		url ="switch.do?prefix=/admin&page=/UserManagementData.do&mode=circle";
	else
	if(elemName == 'divisionOfficeCode')
		url ="switch.do?prefix=/admin&page=/UserManagementData.do&mode=division";
	else
	if(elemName == 'subdivisionOfficeCode')
		url ="switch.do?prefix=/admin&page=/UserManagementData.do&mode=subdivision";
	
	var frm = elem.form;
	frm.action = url;
	frm.submit();
	
}

function getData()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=checklist";
document.forms[0].submit();
}

function getFromDates()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=dates";
document.forms[0].submit();
}


function unview()
{
    var a=document.getElementById('date').value;
	if(a!="-1")
	{
       document.getElementById('dist').disabled=true;
	}
}

function fnSubmit()
{
		if(document.f1.type.selectedIndex == "-1")
		{
			alert("SELECT Module...");
			return false;
		}
        document.f1.action="./rws_update_date_count.jsp";
		document.f1.submit();		
}
/*function init()
{
if(document.empForm.fromDate.value=='' && document.empForm.hoc.value=="0")
{
 	hidediv('a1');
	hidediv('a2');
}
else
{
wise();
}
}*/

function viewCheckList()
{
var a=document.getElementById("hoc").value;
if(a!="0")
{
document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=viewCheckList";
document.forms[0].submit();
return false;
}
else
{   
   alert(" select Head Office ");
}
}


//-->
</script>

<!-- ?mode=CheckList-->
<!-- <body onload="init()">-->
<html:form action="Employee.do?mode=checklist" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Employees CheckList" />
	<jsp:param name="TWidth" value="400"/>
</jsp:include>

<table  bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="440" align="center">
<tr>
<td>
	<!-- <table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	    <tr>
		<td class="textborder">Select</td>
		<td class="textborder">
		<html:radio property="selection" value="OfficeWise" onclick="javascript:wise();">Office Wise</html:radio>
		<html:radio property="selection" value="DateWise" onclick="javascript:wise();">Date Wise</html:radio>
		</td>
		</tr>
	</table>
	<div id='a1'>-->	    
	<table border=0 width="300" align=center style="margin-bottom:5;margin-top:5">
	  
	    <tr>
	    <td  class="textborder" >Head Office<font color="#FF6666">*</font></td>
		<td  class="textborder" >
			<html:select property="hoc" styleClass="mycombo" style="width:130px" onchange="javascript:getData()">
			<html:option value="0">SELECT...</html:option>
			<html:options collection="heads" name="labelValueBean" property="value" labelProperty="label" />
			</html:select>
		</td>
		</tr>
	    
	    <tr>
	    <td  class="textborder" >Circle Office</td>
		<td  class="textborder" >
			<html:select property="coc" style="width:130px" styleClass="mycombo" onchange="javascript:getData()"><!--  onblur="javascript:getRwsCode()" -->
			<html:option value="00"><font class="myfontclr1">SELECT...</font></html:option>
			 <html:options collection="circlecodes" name="labelValueBean" property="value" labelProperty="label" />
			</html:select>
		</td>
		</tr>
	    
	    <tr>
	    <td  class="textborder" >Division Office</td>
		<td  class="textborder" >
			<html:select property="doc" style="width:130px" styleClass="mycombo" onchange="javascript:getData()" >
			<html:option value="0"><font class="myfontclr1">SELECT...</font></html:option>
			<html:options collection="divcodes" name="labelValueBean" property="value" labelProperty="label" />
			</html:select>
		</td>
		</tr>
	
		<tr>
		<td  class="textborder" >SubDivision Office</td>
		<td  class="textborder" >
			<html:select property="sdoc" styleClass="mycombo" style="width:130px" onchange="javascript:getData()">
			<html:option value="00"><font class="myfontclr1">SELECT...</font></html:option>
			<html:options collection="subdivcodes" name="labelValueBean" property="value" labelProperty="label" />
			</html:select>
		</td>
		</tr>
	
		<tr>
		<td  class="textborder">From Date</td>
		<td  class="textborder">
		<html:select property="fromDate" styleClass="mycombo" style="width:100" onchange="getFromDates()"><!-- onchange="javascript:getToDate()" -->
		<html:option value=""><font class="myfontclr1">Select...</font></html:option>
		<logic:present name="fromdates">
		<html:options collection="fromdates" property="fromDate" labelProperty="fromDate" />
		</logic:present>
		</html:select>
		</td>
		</tr>
	
		<tr>
		<td  class="textborder">To Date</td>
		<td  class="textborder">
		<html:select property="toDate" styleClass="mycombo" style="width:100">
		<html:option value=""><font class="myfontclr1">Select...</font></html:option>
		<logic:present name="todates">
		<html:options collection="todates" property="toDate" labelProperty="toDate"/>
		</logic:present>
		</html:select>
		</td>
		</tr>
			
	</table>
</td>
</tr>
	
	<tr>
	</tr>

	<tr>
    <td colspan="2" align="center">
    <html:button property="mode" value="View Report" styleClass="btext" onclick="viewCheckList()"/>
    </td>
	</tr>
	
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="400"/>
</jsp:include>
</table>	
</html:form>
<!-- </body>-->
<%@ include file="/commons/rws_footer.jsp"%>

	

