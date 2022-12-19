<%@ include file="/commons/rws_SpecialHeader.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%int count = 1;%>
<head>
<script>	
function getDivisions()
{
	document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=contractorUpdate&mode1=Divisions";
	WorkForm.submit();
}
function getWorks()
{
  if(document.forms[0].circleOfficeCode.value==''){
  alert("Please Select Circle");
	return false;
  }
  else if(document.forms[0].divisionOfficeCode.value==''){
  alert("Please Select Division");
	return false;
  }
 else {
	document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=contractorUpdate&mode1=getWorks";
	document.forms[0].submit();		
	}
}
function getWorks1()
{
	document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=contractorUpdate&mode1=getWorks1";
	document.forms[0].submit();
}

function fnSave(){
		var len=document.WorkForm.elements.length;
		var yes=0;
		for( var i=1;i<len;i++)
		{       
			if(document.WorkForm.elements[i].name.substring(0,5)=="check")
				if(document.WorkForm.elements[i].checked == false)
				{ 
					yes=1; 
				}
				else if(document.WorkForm.elements[i].checked==true)
				{ 
					yes=0;
					break; 
				}
		}
		if(yes==1)
		{
			alert("Please Select Atleast One Check Box to Update the Contractor Details");
		}
		else if(yes==0){
			var status = checkValues();
			if(status==true)
			{
				if(confirm("Are You Sure To Update The Checked Contractor(s)")){
				document.forms[0].save.value='Wait Updating';
				document.forms[0].save.disabled='true';				document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=contractorUpdate&mode1=fnSave";
					document.forms[0].submit();
				}
			}
		}	
}
function fnShowHabs(contractorCode)
{
	var contractorCodes=contractorCode.name;
	var url = "switch.do?prefix=/works&page=/WorkStatus.do&mode=contractorUpdate&mode1=showWorks&contractorCode="+contractorCodes;
	var properties = "width=748,height=332,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
function fnShowPanVoterid(rowid){
	//alert(rowid.value);
}



</script>
</head>
<html:form action="WorkStatus.do">
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<body>
<table width="60%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Contractor Updation" />
	<jsp:param name="TWidth" value="620px" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="660px" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Office Details</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2" border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tbody class="formTBody">
	  
		<tr class="textborder">
			<td class="textborder" >Circle<span class="mandatory">*</span></td>
			<td class="textborder">
				<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
					<html:select property="circleOfficeCode"   style="width:140px" onchange="javascript: getDivisions()" styleClass="combo">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:notEmpty name="circles">
						<html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
						</logic:notEmpty>			  
					</html:select>
				</logic:equal>
				<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
					<html:text property="circleOfficeName" styleClass="mytext" style="width:140px" name="RWS_USER" readonly="true" />
					<html:hidden property="circleOfficeCode" name="RWS_USER" />
				</logic:notEqual>
			</td>
			<td ><bean:message key="app.division" /><span class="mandatory">*</span></td>
		   <td ><logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:select property="divisionOfficeCode"  styleClass="combo">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:text property="divisionOfficeName" styleClass="mytext" style="width:140px" name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
		</tr>
		<tr>
		<td colspan="4"><font face=verdana size=2 color=red>Click to Get Contractors--></font>
		<input type=button name=GetData value="Linked With Works" onClick="getWorks();" class=btext>
		<input type=button name=GetData value="Not Linked With Works" onClick="getWorks1();" class=btext></td> 

	 </tr>
		</table>
		</label>
		</fieldset>
</td></tr>
</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="620px"/>
</jsp:include>
<BR>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="660px" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="7"><B><font color="#FFFFFF">Contractor List</B></td>
</tr>
<tr >
	<td class="clrborder" align="center">S.No.</td>
	<td class="clrborder" align="center">Contractor Code</td>	  
	<td class="clrborder" align="center">Contractor Name</td>
	<td class="clrborder" align="center">No of Works</td>
	<td class="clrborder" align="center">Check<BR>/Select</td>
	<td class="clrborder" align="center">Pan No</td>
	<td class="clrborder" align="center">Voter ID</td>
	<!-- <td class="clrborder" align="center">View</td> -->
	</tr>
	
<logic:present name="contractorList">
<nested:iterate id="WORKS_DELETES" property="contractorList" indexId="ndx">
<tr align="left" >
<td class="bwborder"><%=count%></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="workid" /></td>
<td class="bwborder"><bean:write name="WORKS_DELETES" property="workname" /></td>
<td  class="bwborder" align="right" nowrap><bean:write name="WORKS_DELETES" property="noofhabs" />
<nested:equal name="WORKS_DELETES" property="noofhabs" value="0">
		&nbsp;<input type="button" value="..." title="Show Selected Habs"  class="btext" disabled="true">
</nested:equal>
<nested:notEqual name="WORKS_DELETES" property="noofhabs" value="0">
		&nbsp;<input type="button" value="..." title="Show Selected Habs"  class="btext" 
			name="<bean:write name="WORKS_DELETES" property="workid" />" onclick="javascript:fnShowHabs(this)">
</nested:notEqual>
</td>
<td class="bwborder" align=center><input type=checkbox name=check<%=count++%> value='<bean:write name="WORKS_DELETES" property="workid" />' ></td>
<%-- <td class="bwborder"><nested:text name="WORKS_DELETES" property="progName" style="width:130px" size="12" maxlength="10" indexed="true" onkeypress="return checkSpaceAndSpecial(event)"/></td>
<td  class="bwborder" ><nested:text name="WORKS_DELETES" property="subprogName" style="width:130px" size="12" maxlength="10" indexed="true" onkeypress="return checkSpaceAndSpecial(event)"/></td>
 --%>
<td class="bwborder"><nested:password name="WORKS_DELETES" property="progName"  style="width:130px" size="12" maxlength="10" onfocus="fnShowPanVoterid(this);" indexed="true" onkeypress="this.type = 'text';return checkSpaceAndSpecial(event)"/></td>
<td  class="bwborder" ><nested:password name="WORKS_DELETES" property="subprogName" style="width:130px" size="12" maxlength="10" indexed="true" onkeypress="return checkSpaceAndSpecial(event)"/></td>
<%-- <td class="bwborder" align=center><input type=checkbox name=checkbox<%=count-1%> id=checkbox<%=count-1%>></td> --%>
</tr>
</nested:iterate>
</logic:present>
<%if(count==1){ %>
	<tr><td colspan="7" align="center" class="btext">No Records</td></tr>
<%}else{%>
	<tr><td colspan="7" align="center" ><input type=button name=save value=Update onClick="fnSave();"></td></tr>
<%}%>
<input type="hidden" name="resultCount" value="<%=count%>">
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
</table>
<script>
	function checkValues()
	{
		var len=document.WorkForm.elements.length;
		var yes = false;
		var j = 0;
		for( var i=1;i<len;i++)
		{
			if(document.WorkForm.elements[i].name.substring(0,5)=="check")
			{
				if(document.WorkForm.elements[i].checked==true)
				{ 
					if(document.getElementById("WORKS_DELETES["+j+"].progName").value=="" && document.getElementById("WORKS_DELETES["+j+"].subprogName").value=="")
					{
						alert("Please Enter Pan No (or) Voter Id to Update the Contractor Details for the S.No:"+(j+1));
						document.getElementById("WORKS_DELETES["+j+"].progName").focus();
						yes = false;
						break;
					}
					else
					{
						if(document.getElementById("WORKS_DELETES["+j+"].progName").value!="")
						{
							if(document.getElementById("WORKS_DELETES["+j+"].progName").value!="" && document.getElementById("WORKS_DELETES["+j+"].progName").value.length!=10)
							{
								alert("Please Provide Valid Pan No for the S.No."+(j+1));
								document.getElementById("WORKS_DELETES["+j+"].progName").focus();
								return false;
							}
							else
							{
								if(validateName(document.getElementById("WORKS_DELETES["+j+"].progName").value,'Pan No',(j+1)))
									return true;
								else
								{
									document.getElementById("WORKS_DELETES["+j+"].progName").focus();
									return false;
								}
							}
						}
						if(document.getElementById("WORKS_DELETES["+j+"].subprogName").value!="")
						{
							if(document.getElementById("WORKS_DELETES["+j+"].subprogName").value!="" && document.getElementById("WORKS_DELETES["+j+"].subprogName").value.length!=10)
							{
								alert("Please Provide Valid Voter ID for the S.No."+(j+1));
								document.getElementById("WORKS_DELETES["+j+"].subprogName").focus();
								return false;
							}
						}
					}
					yes = true;
				}
				j++;
			}
		}
		return yes;
	}
function validateName(name,col,j){
if (name!="" || name!=null) {
var string = name;
var chars = '0';var nums = '0';
for (var i=0;i<string.length;i++){
var asciiNum = string.charCodeAt(i);
if ((asciiNum == 20) || (asciiNum>64 && asciiNum<91) || (asciiNum>96 && asciiNum<123)){
chars ++;
} 
else {nums ++;};
}
}
if(chars>=5 && nums >= 3)
	{return true;}
else
	{alert("INVALID PAN NO - Please Enter Valid "+col+" for the S.No."+j);return false;}
}
</script>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>