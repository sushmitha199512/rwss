<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="RepresentativeProposalForm" />
<%System.out.println("1"); %>
<script language="JavaScript">
<!-- ajax code -->
function getDivisions()
{
//	document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=getDivisions1";
	//document.forms[0].submit();
	document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=getWorks&someCond1=1";
	document.forms[0].submit();

}
function getSubDivisions()
{
	document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=getSubDivisions1";
	document.forms[0].submit();
}
function getData()
{
	if(document.forms[0].ccode.value == null || document.forms[0].ccode.value == "")
	{
		alert("Please select circle");
	}
	else if(document.forms[0].expyear.value == null || document.forms[0].expyear.value == "")
	{
		alert("Please select financial year");
	}
	else
	{
	document.forms[0].action="switch.do?prefix=/proposals&page=/EditAdminSanction.do?mode=getWorks1&someCond=yes&dcode="+document.forms[0].ccode.value+"&expyear="+document.forms[0].expyear.value+"&scode="+document.forms[0].scheme.value;
	document.forms[0].submit();
	}
}
function initFunc()
{
if(document.getElementById("resultCount").value == 0)
{
	document.getElementById('mode').disabled = true;
}
else
{
	document.getElementById('mode').disabled = false;
}
}
<!-- end of ajax code -->

	function getParameters(that)
	{
		var index = that.value;
		var testval=document.getElementById("LABTEST_LIST["+index+"].workid").value;
		if(that.checked)
		{
			//document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=data-success&augsch="+testval;
			//document.forms[0].submit();
			var openerDoc = opener.document;
			var frm = openerDoc.forms[0];
			frm.action = "switch.do?prefix=/proposals&page=/EditAdminSanction.do?mode=populateWorkId&augsch="+testval;
			frm.submit();
			window.close();
		}
	}
	function checkTestResult()
    {
    var testresult = document.getElementById("resultCount").value;
	var k=0;
//	alert(document.forms[0].habCode.checked);
    for(var i=0; i<testresult; i++)
	{
	 k++;
	}
	if(k==testresult)
	{
		 if(testresult==0)
	    	alert("There Is No Test Results");
	  	 else  
 	    	alert("Please Select One Of The Test Result");
	     return false;
	}
	else 
  	 	 return true;
}
function fnSave()
{   
	var testresult = document.getElementById("resultCount").value;
	var flag = false;
	var i = 0;
	if(testresult == 0)
	{
		alert("No Test Resutls");
		return false;
	}

	else if(testresult>1)
	{
		for(i=0;i<testresult;i++)
		{
			if(document.forms[0].habCode[i].checked == true)
			{
				document.forms[0].selectedRadio.value = i;
				var testval=document.getElementById("LABTEST_LIST["+i+"].sourceCode").value;
				alert("You are selected the Source Code:"+testval);
				var x = window.confirm("Do you want Submit the Data");
				if(x)
					flag = true;
				else
					flag = false;
			}
		}
	}
	else if(testresult == 1)
	{
			document.forms[0].selectedRadio.value = '0';
			var testval=document.getElementById("LABTEST_LIST[0].sourceCode").value;
			alert("You are selected the Source Code:"+testval);
			var x = window.confirm("Do you want Submit the Data");
			if(x)
				flag = true;
			else
				flag = false;
	}
	if(flag == true)
	{
		return true;
	}
	else
	{
		alert("Please Select One Of The Test Result");
		return false;
	}
}

</script>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<%@ include file="/commons/rws_header2.jsp" %>
<body>
<html:form action="AdminstrativeSanction.do" >
<div id="load">
</div>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Works List" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
<tr>
<td class="bwborder" >
<fieldset>
<legend><B>Details</B></font></legend>
<label>
<table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
<tr>
	<logic:present name="RWS_USER" property="headOfficeName">
	<td class="bwborder">Head&nbsp;:</td>
	<td class="bwborder">
	<html:text property="headOfficeName" name="RWS_USER" readonly="true" styleClass="mytext1" style="width:100px"/>
	</td>
	</logic:present>
				<td class="bwborder"><FONT class=myfontclr>Circle&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					
					<html:select property="ccode" styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
						<html:options collection="circles" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			
				</td>
				</tr>
					</fieldset>

			<!-- <tr>
				<td class="bwborder"><FONT class=myfontclr>Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					
					<html:select property="divCode" styleClass="combo"   onchange="getSubDivisions()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="divisions2">
						<html:options collection="divisions2" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			
				</td>
				<td class="bwborder"><FONT class=myfontclr>Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					
					<html:select property="subDivCode" styleClass="combo"   onchange="getSubDivisions()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="subdivisions2">
						<html:options collection="subdivisions2" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			
				</td>
				</tr> -->
				<tr>
									</fieldset>
				<td class="bwborder"><FONT class=myfontclr>Financial Year&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					<html:select property="expyear" styleClass="combo">
										</fieldset><%System.out.println("2.12"); %>
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
										</fieldset><%System.out.println("2.13"); %>
					<logic:notEmpty name="expyears">
										</fieldset><%System.out.println("2.14"); %>
					<html:options collection="expyears" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
				</td>
					</fieldset>

				<td class="bwborder"><FONT class=myfontclr>Scheme&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					<html:select property="scheme" styleClass="combo" onchange="getData()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="schemes">
					<html:options collection="schemes" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
				</td>
					</fieldset>

	</tr>
	</table>
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
		<tr >
			<td class="clrborder" align=center>Select</td>
			<td class="clrborder" align=center>Division</td>
			<td class="clrborder" align=center>Sub Division</td>
			<td class="clrborder" align=center>Work Name</td>
			<td class="clrborder" align=center>Admin Sanc. No</td>
			<td class="clrborder" align=center>Admin Sanc. Date</td>
			<td class="clrborder" align=center>Admin Sanc. Amount</td>
		</tr>
		<% int resultCount = 0;%>
		
		<nested:iterate id="LABTEST_LIST" property="works" indexId="ndx">
		<% resultCount++; %>
		<tr align="left" >
			<td  class=bwborder align=center>
				<nested:hidden name="LABTEST_LIST" property="workid" indexed="true"/>
				<nested:radio name="LABTEST_LIST" property="workid" value="<%= String.valueOf(ndx)%>" indexed="false" onclick="getParameters(this)"/>
			<td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="divisionOfficeName" 
							styleClass="mytbltext" indexed="true" readonly="true" title="<nested:text name=LABTEST_LIST property=workname/ >"/>
			</td>
			<td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="subdivisionOfficeName" 
							styleClass="mytbltext" indexed="true" readonly="true" title="<nested:text name=LABTEST_LIST property=workname/ >"/>
			</td>
			<td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="workname" 
							styleClass="mytbltextlong" indexed="true" readonly="true" title="<nested:text name=LABTEST_LIST property=workname/ >"/>
			</td>
			<td  class="bwborder" >
				<nested:text name="LABTEST_LIST" property="admin_no" 
							styleClass="mytbltext" indexed="true" readonly="true"/>
			</td>
			<td  class="bwborder" >
				<nested:text name="LABTEST_LIST" property="admin_date" 
							styleClass="mytbltextshort" indexed="true" readonly="true" />
			</td>
			<td  class="bwborder" >
				<nested:text name="LABTEST_LIST" property="admin_amount" 
							styleClass="mytbltextshort" indexed="true" readonly="true" />
			</td>
		</tr>
		</nested:iterate>
		<%if(resultCount == 0 ){%>
		<tr><td class="clrborder" align="center" colspan="8">no results</td></tr>
		<%} %>
		
	</table>
	</label>
	</fieldset>
	
	
</table>
 <input type="hidden" name="selectedRadio"> 
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>