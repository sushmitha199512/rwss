<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<script language="JavaScript">
function autocompletion()
{
      // alert("auto comp");
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
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

 function show()
	{
	 document.empSearchForm.empcode.value='';
	document.forms[0].elements["ecode"].style.display='none';
	document.forms[0].elements["circlewise"].style.display='block';
    }
	function show1()
	{
		document.forms[0].elements["ecode"].style.display='block';
		document.forms[0].elements["circlewise"].style.display='none';
	}

function check()
	{
	 
	 if(document.forms[0].habtype[0].checked)
	 {
	   document.forms[0].elements["ecode"].style.display='none';
	 }
	 if(document.forms[0].habtype[1].checked)
	 {
		 
	  document.forms[0].elements["circlewise"].style.display='none';
	 }
	
	}
	

function fnView()
{
   
   if(document.forms[0].habtype[0].checked)
	{
	   if(document.empSearchForm.hoc.value=="" || document.empSearchForm.hoc.value=="0")
		{
		   alert("Please Select Head Office");
		   return false;
		}
		else if(document.empSearchForm.circleOfficeCode.value=="" || document.empSearchForm.circleOfficeCode.value=="00")
		{
		   alert("Please Select circleOfficeCode");
			return false;
		}
		else{
		document.forms[0].empcode.value='';
		document.forms[0].action="switch.do?prefix=/masters&page=/EmpSearch.do?mode=view";
		document.forms[0].submit();
		}
	}
	else  if(document.forms[0].habtype[1].checked)
	{
		
		var ecode=document.forms[0].empcode.value;

        if(ecode.length>6)
		{
          document.forms[0].action="switch.do?prefix=/masters&page=/EmpSearch.do?mode=view&empcode"+ecode;
		  document.forms[0].submit();
		}
		 else
		{
           alert("Employee Code Must Be 7 Digits");
		 }

	}
}
function getData()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=EmployeeList";
document.forms[0].submit();
}

function disable()
{
	
 if(document.empSearchForm.desig[0].checked || document.empSearchForm.desig[1].checked ||   document.empSearchForm.desig[2].checked )
	{
	    document.forms[0].action="switch.do?prefix=/masters&page=/EmpSearch.do?mode=EmployeeList";
	    document.forms[0].submit();
	}
}


function unview()
{
    var a=document.forms[0].elements["date"].value;
	if(a!="-1")
	{
       document.forms[0].elements["dist"].disabled=true;
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

</script>

<html:form action="/EmpSearch.do" >
<body onload="check();autocompletion();">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Employee Search Form " />
	<jsp:param name="TWidth" value="460"/>
	<jsp:param name="contextHelpUrl" value="./help/Help For PRED.doc" />
</jsp:include>

<table  bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="500" align="center">
<tr>
<td>
	<tr><td class="textborder" colspan="2" align="center">
<input type="radio" value="1" name="habtype" checked onclick="show()">Circle Wise &nbsp;&nbsp;
<input type="radio" value="2" name="habtype" onclick="show1()">Employee Code &nbsp;&nbsp;

</td>
</tr>
<tr>
<td>
	<div id="circlewise" style="display:block">
	<table border=0 width="423" align=center style="margin-bottom:5;margin-top:5">
	
	    <tr>
	    <td width="417"  class="textborder" >Head Office<font color="#FF6666">*</font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<html:select property="hoc" styleClass="mycombo" style="width:130px" >
			<html:option value="0"> SELECT...</html:option>
			<logic:present name="heads">
			<html:options collection="heads" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
		</td>
		</tr>
	    <td class="textborder" >Circle<span class="mandatory">*</span>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode"   style="width:130px"  
							 styleClass="mycombo">
					<html:option value="00"><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="mytext" style="width:100px"
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
			</td>
	    <tr>
	    <td  class="textborder">Appointed Zone&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:select property="zone" style="width:130px" styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="zonecodes">
		<html:options collection="zonecodes" name="rwsMaster" property="zoneCode" labelProperty="zoneName" />
		</logic:present>
		</html:select>
		</td>
		</tr>
	    	  
	    <tr>
	    <tr>
		<td class="textborder" nowrap>Nature Of Employment
		&nbsp;<html:radio property="desig" value="P" onclick="javascript:disable();">Permanent</html:radio>
		<html:radio property="desig" value="T" onclick="javascript:disable();">Temporary</html:radio>
		<html:radio property="desig" value="W" onclick="javascript:disable();">WorkCharged</html:radio>
		</tr>
		
		<tr>
		<td class="textborder" nowrap>Designation Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;	<html:select property="desgnCode" style="width:150px" styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="desgns">
		<html:options collection="desgns" name="rwsMaster" property="desgnCode" labelProperty="desgnName" />
		</logic:present>
		</html:select>
		</td>
	    </tr>	    		
	    	    		
	</table>
	</div>

<div id="ecode" style="display:block">
<table border=0 width="423" align=center style="margin-bottom:5;margin-top:5">
 <tr>
<td class="textborder" align="center">Enter Employee Code:<font color="red"><b>*</b></font>
<input type=text name="empcode" size="10" maxlength="7" onkeypress="return numeralsOnly(event)" >
</td>
</tr>
 </table>


</td>
</tr>
	
	<tr>
	</tr>

	<tr>
    <td colspan="2" align="center">
    <input type=button  name="view" value="View" class="btext"  onclick="fnView()"/>
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
    </td>
	</tr>
	
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="460"/>
</jsp:include>
</table>	
</html:form>

<%@ include file="/commons/rws_footer.jsp"%>

	

