<%@ include file="/commons/rws_header1.jsp" %>

<%@ include file="/commons/rws_header2.jsp" %>

<script language="JavaScript">
<!--
var newWindow;
function getData()
{   
   	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSampleFtkTest.do&mode=data";
	document.forms[0].submit();
}
function labforward()
{
	var val = document.forms[0].selectedMonth.value;
	if(document.forms[0].circleOfficeCode1.value!="")
	{
		if(document.forms[0].mandalCode1.value!="")
		{
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSampleFtkTest.do&mode=data&selectedMonth="+val+"&circleOfficeCode1="+document.forms[0].circleOfficeCode1.value+"&mandalCode1="+document.forms[0].mandalCode1.value;
		document.forms[0].submit();
		}
		else
		{
			alert("Mandal Required");
		}
	}
	else
	{
		alert("Circle Required");
	}
}

function showFtkTestResult(ndx){
//alert("in the function");
var ftktestid = document.getElementById("WATERSAMPLE_LIST["+ndx+"].ftktestid").value;
 var srcCode=document.getElementById("WATERSAMPLE_LIST["+ndx+"].sourceCode").value;
//alert(srcCode);
//alert(ftktestid);
 var url = "switch.do?prefix=/wquality&page=/WaterSampleFtkTest.do&mode=testResult&ftktestid="+ftktestid+"&sourceCode="+srcCode;
	
	 var width = 900;
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
function showFtkTestResults(ndx){
//alert("in the function");
var ftktestid = document.getElementById("TESTRESULT_LIST["+ndx+"].ftktestid").value;
var srcCode=document.getElementById("TESTRESULT_LIST["+ndx+"].sourceCode").value;
//alert(srcCode);
//alert(ftktestid);
 var url = "switch.do?prefix=/wquality&page=/WaterSampleFtkTest.do&mode=testResult&ftktestid="+ftktestid+"&sourceCode="+srcCode;
	
	 var width = 900;
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
<html:form action="WaterSampleFtkTest.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value=" Ftk Tested Samples" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

  	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
			
				
			<%
			String seleMonth = (String)request.getAttribute("selectedMonth");
			String seleYear= (String)request.getAttribute("selectedYear");
			
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
				<td class="bwborder"><FONT class=myfontclr>Mandal&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					<html:select property="mandalCode1" styleClass="combo">
						<html:option value=" "><bean:message key="app.pleaseSelect" /></html:option>
						<logic:notEmpty name="mandals1">
						<html:options collection="mandals1" name="labelValueBean" 
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
				
					
		<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
			
			<tr >
				<tr >
				<td class=clrborder align=center>Mandal</td>
				<td class=clrborder align=center>Habitation</td>
				<td class=clrborder align=center>Source Type</td>
				<td class=clrborder align=center>Source</td>
				<td class=clrborder align=center>Ftk Test Id</td> 
				<td class=clrborder align=center>Ftk Test Date</td>	
				<td class=clrborder align=center>Forward Date</td>	
				<td class=clrborder align=center>FTK Test Result</td>			
			</tr>
				
				
			</tr>
			<% int resultCount = 0;%>
			<nested:iterate id="TESTRESULT_LIST" property="resultsSubmittedToSubdivision" indexId="ndx">
			<% resultCount++; %>
			<tr align="left" >
				
				<td  class=bwborder nowrap>
					<nested:text name="TESTRESULT_LIST" property="mandalName" 
								 indexed="true" readonly="true" 
								 style="width:125px" styleClass="mytbltext"  />
				</td>
				
				<td  class=bwborder nowrap>
					<nested:text name="TESTRESULT_LIST" property="habCode" 
								 indexed="true" readonly="true" 
								 style="width:120px" styleClass="mytbltext"/>
				</td>				
				<td  class=bwborder nowrap>
					<nested:text name="TESTRESULT_LIST" property="sourceType" 
								 indexed="true" readonly="true" 
								 style="width:150px" styleClass="mytbltext"/>
				</td>
				<td  class=bwborder nowrap>
					<nested:text name="TESTRESULT_LIST" property="sourceCode" 
								 indexed="true" readonly="true" 
								 style="width:200px" styleClass="mytbltext"/>
				</td>
				<td  class=bwborder nowrap>
					<nested:text name="TESTRESULT_LIST" property="ftktestid" 
								 indexed="true" readonly="true" 
								 style="width:140px" styleClass="mytbltext"/>
				</td> 
				<td  class=bwborder nowrap>
					<nested:text name="TESTRESULT_LIST" property="ftkTestDate" 
								 indexed="true" readonly="true" 
								 style="width:80px" styleClass="mytbltext"/>
				</td>
				<td  class=bwborder nowrap>
					<nested:text name="TESTRESULT_LIST" property="forwardDate" 
								 indexed="true" readonly="true" 
								 style="width:80px" styleClass="mytbltext"/>
				</td>
				
				<td  class=bwborder >
				<nested:match name="TESTRESULT_LIST" property="natureOfTest" value="Y">
					<input type=button name="mode" value="...Contaminated" style="width:120" style Class="btext" onclick='<%= "javascript: showFtkTestResults(" + ndx + ")"%>' title="Click Here"/>
				</nested:match>
				<nested:match name="TESTRESULT_LIST" property="natureOfTest" value="N">
					&nbsp;
				</nested:match>
				</td>			
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
			
		</table> 				
	
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>