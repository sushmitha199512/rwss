<%@ include file="/commons/rws_header1.jsp" %>

<%@ include file="/commons/rws_header2.jsp" %>

<script language="JavaScript">
<!--
var newWindow;
function getData()
{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSampleGeoTest.do&mode=data";
	document.forms[0].submit();
}
function labforward()
{
   //alert("get data functinality started");
	var val = document.forms[0].selectedMonth.value;
	if(document.forms[0].circleOfficeCode1.value!="")
	{
		if(document.forms[0].divisionOfficeCode1.value!="")
		{
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSampleGeoTest.do&mode=data&selectedMonth="+val+"&circleOfficeCode1="+document.forms[0].circleOfficeCode1.value+"&divisionOfficeCode1="+document.forms[0].divisionOfficeCode1.value;
		document.forms[0].submit();
		}
		else
		{
			alert("Division Required");
		}
	}
	else
	{
		alert("Circle Required");
	}
	 // alert(" get data functinality endeded");
}
function showTestResult(ndx)
{
var testId = document.getElementById("TESTRESULT_LIST["+ndx+"].testId").value;
 var url = "switch.do?prefix=/wquality&page=/WaterSampleGeoTest.do&mode=testResult&testId="+testId;
	
	 var width = 638;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 		
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }
	 else
	 {
		newWindow.focus();
	 }
}
function showTestResults(ndx)
{
var testId = document.getElementById("TESTRESULT_LIST["+ndx+"].testId").value;
var sourceCode = document.getElementById("TESTRESULT_LIST["+ndx+"].sourceCode").value;
var url = "switch.do?prefix=/wquality&page=/WaterSampleGeoTest.do&mode=testResults&testId="+testId+"&sourceCode="+sourceCode;
	
	 var width = 638;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 		
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }
	 else
	 {
		newWindow.focus();
	 }
}
function checkSampleResult()
{
    var sampleresult = document.getElementById("sampleCount").value;
	var labasstname;
	var message ="";
	var k=0;
    for(var i=0; i<sampleresult; i++)
	{   if(document.getElementById("WATERSAMPLE_LIST["+i+"].checkedTest").checked==true){
		  labasstname = document.getElementById("WATERSAMPLE_LIST["+i+"].forwadedTo").value;
		  if(labasstname.length == 0 || labasstname == '')
			message+="Lab Assistant Name " + (i+1) + " is required\n"; 
	      if(message.length >0)
  		  {
			alert(message);
			return false;
		  }
	    }	  
	    else
		 k=k+1;
	}
	if(k==sampleresult){
	  if(sampleresult==0)
	    alert("There Is No Sample Collections To Forward");
	  else  
	    alert("Please Select One Of The Sample Collection");
	  return false;
	}
	else 
  	 return true;
}
function checkTestResult()
{
    var testresult = document.getElementById("resultCount").value;
	var subName;
	var message ="";
	var k=0;
    for(var i=0; i<testresult; i++)
	{   if(document.getElementById("TESTRESULT_LIST["+i+"].checkedTest").checked==true){
		  subName = document.getElementById("TESTRESULT_LIST["+i+"].subdivision").value;
		  if(subName.length == 0 || subName == '')
			message+="Sub Division Name " + (i+1) + " is required\n"; 
	      if(message.length >0)
  		  {
			alert(message);
			return false;
		  }
	    }	  
	    else
		 k=k+1;
	}
	if(k==testresult){
	 if(testresult==0)
	    alert("There Is No Test Results");
	  else  
 	    alert("Please Select One Of The Test Result");
	 return false;
	}
	else 
  	 return true;
}
 function fnSave(index)
{   if(index==2){
      
		if(checkTestResult())
		{
			return true;
		}
	}	
	 else{
		if(checkSampleResult())
		{
			return true;
		}
	  }
	  return false;
	 
}
//-->
</script>
<html:form action="WaterSampleGeoTest.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Sample Test Result" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Office Details</B></legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr>
			<logic:present name="RWS_USER" property="headOfficeName">
				<td class="bwborder">Head&nbsp;:</td>
				<td class="bwborder">
					<html:text property="headOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:120px"/>
					<html:hidden property="headOfficeCode" name="RWS_USER"/>
				</td>
			</logic:present>
			
				<td class="bwborder"><FONT class=myfontclr>Circle&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					
					<html:select property="circleOfficeCode" styleClass="combo" onchange="getData()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
						<html:options collection="circles" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			
				</td>
				<td class="bwborder"><FONT class=myfontclr>Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					<html:select property="divisionOfficeCode" styleClass="combo" onchange="getData()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="divisions">
					<html:options collection="divisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
				</td>
	
			</tr>
		</table>
		</label>
		</fieldset>
	 	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
			<tr bgcolor="#8A9FCD">
				<td colspan="9" class="bwborder">
					<font color='000000'>Water Samples Yet to be Tested</font>
				</td>
			</tr>
			<tr >
				<td class=clrborder align=center>Division</td>
				<td class=clrborder align=center>Lab</td>
				<td class=clrborder align=center>Date of Sample<BR> Collection</td>
				<td class=clrborder align=center>Habitation</td>
				<td class=clrborder align=center>Source Type</td>
				<td class=clrborder align=center>Source</td>
				<td class=clrborder align=center>Test</td> 
				<td class=clrborder align=center>Sample Collected By</td>
				
				
			</tr>
			<% int SampleCount = 0;%>
			<nested:iterate id="WATERSAMPLE_LIST" property="samplesForwardToLabs">
			<% SampleCount++; %>
			<tr align="left" >
				<nested:hidden name="WATERSAMPLE_LIST" property="testId" indexed="true"/>
				<td  class=bwborder nowrap>
					<nested:text name="WATERSAMPLE_LIST" property="divisionOfficeName" 
								 indexed="true" readonly="true" 
								 style="width:125px" styleClass="mytbltext"/>
				</td>
				<td  class=bwborder nowrap>
					<nested:text name="WATERSAMPLE_LIST" property="labName" 
								 indexed="true" readonly="true" 
								 style="width:125px" styleClass="mytbltext"/>
				</td>
				
				<td  class=bwborder align=center nowrap>
					<nested:text name="WATERSAMPLE_LIST" property="sampCollectDate" 
								 indexed="true" readonly="true" 
								 style="width:100px" styleClass="mytbltext"/>
				</td>
				<td  class=bwborder nowrap>
					<nested:text name="WATERSAMPLE_LIST" property="habCode" 
								 indexed="true" readonly="true" 
								 style="width:100px" styleClass="mytbltext"/>
				</td>				
				<td  class=bwborder nowrap>
					<nested:text name="WATERSAMPLE_LIST" property="sourceType" 
								 indexed="true" readonly="true" 
								 style="width:150px" styleClass="mytbltext"/>
				</td>
				<td  class=bwborder nowrap>
					<nested:text name="WATERSAMPLE_LIST" property="sourceCode" 
								 indexed="true" readonly="true" 
								 style="width:200px" styleClass="mytbltext"/>
				</td>
				<td  class=bwborder nowrap>
					<nested:text name="WATERSAMPLE_LIST" property="testCode" 
								 indexed="true" readonly="true" 
								 style="width:140px" styleClass="mytbltext"/>
				</td> 
				<td  class=bwborder nowrap>
					<nested:text name="WATERSAMPLE_LIST" property="sampCollectCode" 
								 indexed="true" readonly="true" 
								 style="width:80px" styleClass="mytbltext"/>
				</td>
				
			</tr>
			</nested:iterate>
			
			
			<%if(SampleCount==0)
			{ %>
			<tr><td colspan="20" align="center" class="btext">No Forwarded Records</td></tr>
			<%} else{%>
			<tr><td colspan="20" align="center" class="btext">&nbsp;</td></tr>
			<%} %>
				<input type="hidden" name="sampleCount" value="<%= SampleCount %>">
				<tr bgcolor="#8A9FCD">
				<td colspan="11" class="bwborder">
					<font color='000000'>Water Samples Test Results Forwarded From Laboratory</font>
				</td>
			</tr>
			<%
			String seleMonth = (String)request.getAttribute("selectedMonth");
			String seleYear= (String)request.getAttribute("selectedYear");
			
			//System.out.println("month:"+seleMonth+"year:"+seleYear);
			//if(seleMonth == null || seleYear == null)
			//{
			//System.out.println("not selected for 1st time");
			
			
			 %>
			<tr bgcolor="#edf2f8">
				<td align=center colspan="11">
				<%
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
    String currentYear= dateFormat.format(currentDate).substring(0,4);
    int currentYears = Integer.parseInt(currentYear);
    //System.out.println("Current Year:"+currentYears);
    int i = 0;
     %>
     <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=0 style="border-collapse:collapse" >
     <tr>
			    <td class="bwborder">Selection Criteria&nbsp;:</td>
				<td class="bwborder"><FONT class=myfontclr>Circle&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					<html:select property="circleOfficeCode1" styleClass="combo" onchange="getData()">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:notEmpty name="circles1">
							<html:options collection="circles1" name="labelValueBean" 
										  property="value" labelProperty="label" />
						</logic:notEmpty>			  
					</html:select>
				</td>
				<td class="bwborder"><FONT class=myfontclr>Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					<html:select property="divisionOfficeCode1" styleClass="combo">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:notEmpty name="divisions1">
						<html:options collection="divisions1" name="labelValueBean" 
									  property="value" labelProperty="label" />
						</logic:notEmpty>			  
					</html:select>
				</td>
				<td class="bwborder"><FONT class=myfontclr>Year&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					<html:select property="selectedYear" styleClass="combo1">
						<%for(i=currentYears;i>=2002;i--){ 
						String ii = ""+i;
						%>
						<html:option value="<%=ii%>"><%=i%></html:option>
						<%} %>
					</html:select>
				</td>
				<td class="bwborder"><FONT class=myfontclr>Month&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					<html:select property="selectedMonth" styleClass="combo1">
						<html:option value="ALL">ALL</html:option>
						<html:option value="01" >JAN</html:option>
						<html:option value="02" >FEB</html:option>
						<html:option value="03" >MAR</html:option>					
						<html:option value="04" >APR</html:option>
						<html:option value="05" >MAY</html:option>
						<html:option value="06" >JUN</html:option>
						<html:option value="07" >JUL</html:option>
						<html:option value="08" >AUG</html:option>
						<html:option value="09" >SEP</html:option>
						<html:option value="10" >OCT</html:option>
						<html:option value="11" >NOV</html:option>
						<html:option value="12" >DEC</html:option>
					</html:select>
				</td>
				<td><INPUT type="button" value="Get Data" onClick="labforward()"></td>
		</tr></table>
				
			<%//} 
		//	else
			//{
			//System.out.println("selected for 1st time");
			%>
			
		<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
			
			<tr >
				<!-- <td class=clrborder align=center>Select</td> -->
				<td class=clrborder align=center nowrap> Date Forwarded <BR>From Divison</td>
				<td class=clrborder align=center>Habitation</td>
				<!-- <td class=clrborder align=center>Source Type</td>-->
				<td class=clrborder align=center>Source</td>
				<td class=clrborder align=center>Test</td>
				<!-- <td class=clrborder align=center>Date Forwarded On</td> -->
				<td class=clrborder align=center>Lab Assistant</td>
				<td class=clrborder align=center>Result Obtained On</td>
				<td class=clrborder align=center>Update Source Data</td>
				<td class=clrborder align=center>Remarks / Recommendations</td>
				<td class=clrborder align=center>Test Result</td>
				<td class=clrborder align=center>Results History</td>
				<!-- <td class=clrborder align=center>Subdivison</td> -->
				<!-- 
				<td class=clrborder align=center>Date Forwarded To Divsion</td>
				 -->
			</tr>
			<% int resultCount = 0;%>
			<nested:iterate id="TESTRESULT_LIST" property="resultsSubmittedToSubdivision" indexId="ndx">
			<% resultCount++; %>
			<tr align="left" >
				<!-- <td  class=bwborder align=center>
					<nested:checkbox name="TESTRESULT_LIST" property="checkedTest" 
									 indexed="true" />
					
				</td> -->
				<nested:hidden name="TESTRESULT_LIST" property="testId" 
								   indexed="true"/>
				<td  class=bwborder >
					<nested:text name="TESTRESULT_LIST" property="dateAssignedFromDiv" 
								 indexed="true" readonly="true" 
								 style="width:80px" styleClass="mytbltext" />
				</td>
				<td  class=bwborder nowrap>
					<nested:write name="TESTRESULT_LIST" property="habCode" />
				</td>
				<!-- <td  class=bwborder >
					<nested:text name="TESTRESULT_LIST" property="sourceType" 
								 indexed="true" readonly="true" 
								 style="width:200px" styleClass="mytbltext"/>
				</td> -->
				<td  class=bwborder >
					<nested:text name="TESTRESULT_LIST" property="sourceCode" 
								 indexed="true" readonly="true" 
								 style="width:200px" styleClass="mytbltext"/>
				</td>
				<td  class=bwborder nowrap>
					<nested:write name="TESTRESULT_LIST" property="testCode" />
				</td>
				<!--<td  class=bwborder >
					<nested:text name="TESTRESULT_LIST" property="forwadedOn" 
								 indexed="true"  readonly="true" 
								 style="width:80px" styleClass="mytbltext"  />
				</td>-->
				<td  class=bwborder nowrap>
					<nested:write name="TESTRESULT_LIST" property="forwadedTo" />
				</td>
				<td  class=bwborder >
					<nested:text name="TESTRESULT_LIST" property="resultObtainOn" 
			 					 indexed="true"  readonly="true" 
								 style="width:80px" styleClass="mytbltext"  />
				</td>
				<td  class=bwborder >
					<nested:text name="TESTRESULT_LIST" property="updateSource" 
								 indexed="true" readonly="true" 
								 style="width:80px" styleClass="mytbltext"/>
				</td>
				<td  class=bwborder >
					<nested:write name="TESTRESULT_LIST" property="recommendations" />
				</td>
				<td  class=bwborder >
					<html:button property="mode" value="..." style="width:80px" styleClass="btext" title="Click Here"
								 onclick='<%= "javascript: showTestResult(" + ndx + ")"%>' />
				</td>
				<td  class=bwborder >
					<html:button property="mode" value="..." style="width:80px" styleClass="btext" title="Click Here"
								 onclick='<%="javascript: showTestResults(" + ndx + ")"%>' />
				</td>
				<!-- 
				<td  class=bwborder >
					<nested:select name="TESTRESULT_LIST" property="subdivision" 
								   indexed="true"  style="width:80px" 
								   styleClass="mytbltext">
					<html:option value="">SELECT...</html:option>
					<nested:options collection="subdivisions" name="rwsOffices"  
									property="value" labelProperty="label" />
					</nested:select>
				</td> -->
				<!-- 
				<td  class=bwborder >
					<nested:text name="TESTRESULT_LIST" property="resultForwardOn" 
								 indexed="true"  style="width:80px" 
								 styleClass="mytbltext" maxlength="10"/>
				</td>
				 -->
			</tr>
			</nested:iterate>
			<%if(resultCount==0)
			{ %>
			<tr><td colspan="20" align="center" class="btext">No Forwarded Records</td></tr>
			<%}else{%> 
			<tr><td colspan="20" align="center" class="btext">&nbsp;</td></tr>
			<%} %>
			<input type="hidden" name="resultCount" value="<%= resultCount %>">
		</table>
			<%
			//}%>
		</table> 
				
	<tr>
		<td align=center>
		<!-- 
		
			<html:submit property="mode" title="Save the Fields"  
						 styleClass="btext" value="Submit" onclick='return fnSave(2)'/>
   		 -->
   		 
   		</td>
	</tr>
</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>