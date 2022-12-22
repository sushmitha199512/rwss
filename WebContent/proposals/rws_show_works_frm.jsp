<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="RepresentativeProposalForm" />
<script language="JavaScript">
<!-- ajax code -->
function resetAssetType()
{
	document.forms[0].scheme.value='';
}
function getDivisions()
{
//	document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=getDivisions1";
	//document.forms[0].submit();
	document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=getWorks&someCond1=div";
	document.forms[0].submit();

}
function getSubDivisions()
{
	document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=getWorks&someCond1=subdiv";
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
	document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=getWorks&someCond=yes&someCond1=yes";
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
			frm.action = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=populateWorkId&augsch="+testval;
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
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
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
					
					<html:select property="ccode" styleClass="combo" onchange="resetAssetType();getDivisions();">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
						<html:options collection="circles" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			
				</td>
				</tr>
					</fieldset>

			  <tr>
				<td class="bwborder"><FONT class=myfontclr>Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					
					<html:select property="divCode" styleClass="combo"   onchange="resetAssetType();getSubDivisions();">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="divisions2">
						<html:options collection="divisions2" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			
				</td>
				<td class="bwborder"><FONT class=myfontclr>Sub Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					
					<html:select property="subDivCode" styleClass="combo"   onchange="resetAssetType();getSubDivisions();">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="subdivisions2">
						<html:options collection="subdivisions2" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			
				</td>
				</tr> 
				<tr>
				</fieldset>
				<td class="bwborder"><FONT class=myfontclr>Financial Year&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					<html:select property="expyear" styleClass="combo" onchange="resetAssetType()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
										</fieldset>
					<html:option value="ALL">ALL</html:option>
										</fieldset>
					<logic:notEmpty name="expyears">
										</fieldset>
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
	<tr>
    <td  bgcolor="#8A9FCD" colspan=11 align=center>
	  <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Works/Assets </font>	

	</td>
	</tr>
	
		<tr >
			<td class="clrborder" align=center>Select</td>
			<td class="clrborder" align=center>Work/Asset</td>
			<!-- <td class="clrborder" align=center>Division</td>
			<td class="clrborder" align=center>Sub Division</td> -->
			<td class="clrborder" align=center>Mandal<br>(Lead Hab)</td>
			<td class="clrborder" align=center>Panchayat<br>(Lead Hab)</td>
			<td class="clrborder" align=center>Lead Hab Code</td>
			<td class="clrborder" align=center>Lead Hab Name</td>
			<td class="clrborder" align=center>Work ID/<BR>Asset Code</td>
			<td class="clrborder" align=center>Work/Asset Name</td>
			<td class="clrborder" align=center>Asset Location</td>
			<!-- <td class="clrborder" align=center>Admin Sanc. No</td> -->
			<td class="clrborder" align=center>Admin Sanc.<BR> Date/<BR>Asset Creation<BR> Date</td>
			<td class="clrborder" align=center>Admin Sanc<BR>.Amount/<BR>Asset Cost<BR>(in Lakhs)</td>
		</tr>
		<% int resultCount = 0;%>
		<logic:notEmpty name="works">
		<nested:iterate id="LABTEST_LIST" property="works" indexId="ndx">
		<tr align="left" >
			<td  class=bwborder align=center>
				<nested:hidden name="LABTEST_LIST" property="workid" indexed="true"/>
				<nested:radio name="LABTEST_LIST" property="workid" value="<%= String.valueOf(resultCount)%>" indexed="false" onclick="getParameters(this)"/>
				<% resultCount++; %>
			<td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="typeOfAsset" 
							styleClass="mytbltextshort" indexed="true" readonly="true"/>
			</td>
			<!-- <td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="divisionOfficeName" 
							styleClass="mytbltext" indexed="true" readonly="true" title="<nested:text name=LABTEST_LIST property=workname/ >"/>
			</td>
			<td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="subdivisionOfficeName" 
							styleClass="mytbltext" indexed="true" readonly="true" title="<nested:text name=LABTEST_LIST property=workname/ >"/>
			</td> -->
			<td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="mandal" 
							styleClass="mytbltext" indexed="true" readonly="true"/>
			</td>
			<td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="repName" 
							styleClass="mytbltext" indexed="true" readonly="true"/>
			</td>
			<td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="habCode" 
							styleClass="mytbltext" indexed="true" readonly="true"/>
			</td>
			<td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="repAddress" 
							styleClass="mytbltext" indexed="true" readonly="true"/>
			</td>
			<%-- <td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="workid" 
							styleClass="mytbltext" indexed="true" readonly="true"/>
			</td> --%>
			<td  class="bwborder">
<bean:write name="LABTEST_LIST" property="workid" /></td>
			<td  class="bwborder">
				<nested:text name="LABTEST_LIST" property="workname" 
							styleClass="mytbltextlong" indexed="true" readonly="true" onmouseover="Tip(this.value,TITLE,'')" onmouseout="UnTip()"/>
			</td>
			<td  class="bwborder" >
				<nested:text name="LABTEST_LIST" property="location" 
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
		</logic:notEmpty>
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