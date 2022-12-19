<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="waterSampleResForm" />
<%// System.out.println("sdfgfdgfgdf"); %>
<script language="JavaScript">
<!-- ajax code -->
<%String mode = request.getParameter("mode");%>
function getData()
{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=data";
	document.forms[0].submit();
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
//var intervalID = window.setInterval("sendAjaxRequest()", 30*1000);
var sessionTimeOutValue=<%=session.getMaxInactiveInterval()%>
sessionTimeOutValue=sessionTimeOutValue/60;
var interval=0;
if(sessionTimeOutValue>5)
{                       
 interval=(sessionTimeOutValue*60*1000)-(5*60*1000);
}
else if(sessionTimeOutValue>1)
{
//set the interval as sessionTimeOutValue in Min. - 1Min.
interval=(sessionTimeOutValue*60*1000)-(1*60*1000);
}
else if(sessionTimeOutValue==1)
{
//set the interval as sessionTimeOutValue in Min. - 30Sec.
interval=(sessionTimeOutValue*60*1000)-(30*1000);
}

var intervalID = window.setInterval("sendAjaxRequest()",interval );


}

function sendAjaxRequest()
{
//document.getElementById("whatsNewLink").style.left=document.body.clientWidth-document.getElementById("whatsNewImg").width;
var clientScreenWidth=document.body.clientWidth;
var leftPos=clientScreenWidth-130;
		if(confirm("Your session is about to expire.\nDo you want to extend the Session"))
		{
			var  httpRequest2;
			var url="/pred/switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=doNothing";
			if (window.ActiveXObject) 
		        { //IE
		            httpRequest2 = new ActiveXObject("Microsoft.XMLHTTP"); 
		        } 
		        else if (window.XMLHttpRequest) 
		        { //other browsers
		            httpRequest2 = new XMLHttpRequest(); 
		        } 
		         
		        httpRequest2.open("GET", url, true); 
		        httpRequest2.onreadystatechange = function() {processNewRequest(); } ; 
		        httpRequest2.send(null); 
		        function processNewRequest() 
		       { 
		       		//alert(httpRequest2.readyState);
		          if(httpRequest2.readyState== 1)
		          {
		           var img="images\ajax-loader.gif"
		           //document.getElementById('load').innerHTML="<img src='images/ajax-loader3.gif'style='position:absolute; left:410px; top:100px' ALT='Please wait..'></img>";
		           document.getElementById('load').innerHTML="<div id='innerLoad' style='position:absolute; left:"+leftPos+"px; top:15px; background-color:CC0033' ALT='Please wait..'>Extending Session...</div>";
		          
		          }
		        if (httpRequest2.readyState == 4) 
		        {  
		            if(httpRequest2.status == 200) 
		            { 
		              var data=httpRequest2.responseText;
		              //alert(httpRequest2.responseText);
		               var arr1=data.split('</>');
		              if(arr1[1]=="ok")
		              document.getElementById('load').innerHTML='';
		              else
		              {
		              alert("Oops there was a problem while connecting. \n The Session might have expired.");
		              document.getElementById('load').innerHTML='';
		              }
		              
		             
		            }
		            //document.getElementById('load').innerHTML='';
		        }
		         else 
		            { 
		            //alert("error");
		                //alert("Error loading page\n"+ httpRequest2.status +":"+ httpRequest2.statusText); 
						//document.getElementById('load').innerHTML='';
		            }   
		       }              
	}
}
<!-- end of ajax code -->

function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background='';
		else if(that.style.background=='white')
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}
	
	function getParameters(that)
	{
		// alert("that:" +that.value);
		var mode = '<%=mode%>';
		var index=that.value;
		var testval=document.getElementById("LABTEST_LIST["+index+"].testCode").value;
		var sourceCode=document.getElementById("LABTEST_LIST["+index+"].sourceCode").value;
		
        var testresult = document.getElementById("resultCount").value;
        // alert("resultcount:"+testresult);
        
        var testId=document.getElementById("LABTEST_LIST["+index+"].testId").value;
		if(that.checked)
		{
			if(mode!="data")
			{
			   url = "/pred/switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=test&testCode="+testval+"&testId="+testId+"&sourceCode="+sourceCode;
			}
			else
			{
			   url = "/pred/switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=testNewParams&testCode="+testval+"&testId="+testId+"&sourceCode="+sourceCode;
			}

			//url = "/WaterSampleRes.do&mode=test&testCode="+testval+"&testId="+testId+"&sourceCode="+sourceCode;
			 // alert(url);
			window.open(url,"", "width=850,height=500,left=100,top=150,scrollbars=1,resizable=1, status=yes");
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
				// alert("You are selected the Source Code:"+testval);
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
			//alert("You are selected the Source Code:"+testval);
			var x = window.confirm("Do you want Submit the Data");
			if(x)
				flag = true;
			else
				flag = false;
	}
	if(flag == true)
	{
	  	   document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=Submit";
		   document.forms[0].submit();
	}
	else
	{
		alert("Please Select One Of The Test Result");
		return false;
	}
}
function fnView()
{
 if(document.forms[0].circleOfficeCode.value=="")
 {
     alert("Circle is Required");
	   return false;
 }
 else if(document.forms[0].divisionOfficeCode.value=="")
 {
     alert("Division is Required");
	   return false;
 }
 else if(document.forms[0].mandalCode.value=="")
 {
     alert("Mandal  is Required");
	   return false;
 }
  else{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=View";
	document.forms[0].submit();
	}
}
		   
</script>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<%@ include file="/commons/rws_header2.jsp" %>
<body onload="initFunc()">
<html:form action="WaterSampleRes.do" >
<div id="load">
</div>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Sample Test Result" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
<tr>
<td class="bwborder" >
<fieldset>
<legend><B>Office Details </B></font></legend>
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
		<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
		<html:select property="circleOfficeCode" onchange="getData()" styleClass="combo">
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="circles">
			<html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>			  
		</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
		<html:text property="circleOfficeName" name="RWS_USER" readonly="true" styleClass="text"/>
		<html:hidden property="circleOfficeCode" name="RWS_USER" />
		</logic:notEqual>
	 </td>
				
				
				<td class="bwborder"><FONT class=myfontclr>Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				
				<td class="bwborder">
		 <logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
		 <html:select property="divisionOfficeCode" onchange="getData()" styleClass="combo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
				<html:text property="divisionOfficeName" name="RWS_USER" readonly="true"/>
				<html:hidden property="divisionOfficeCode" name="RWS_USER" />
			</logic:notEqual>
			</td>
				</tr>
				<tr>
				<td></td><td></td>
				<td class="bwborder"><FONT class=myfontclr>SubDivision&nbsp;:</FONT></td>
				<td class="bwborder">
	 <logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subdivisionOfficeCode" onchange="getData()" styleClass="combo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions">
			<html:options collection="subdivisions" name="labelValueBean" property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName" name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
				
				<td class="bwborder"><FONT class=myfontclr>Mandal<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					<html:select property="mandalCode" styleClass="combo" onchange="getData()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="mandals">
					<html:options collection="mandals" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
				</td>
	</tr>
	</table>
	</label>
	</fieldset>
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
		<tr >
			<td class="clrborder" align=center>Select</td>
			<td class="clrborder" align=center>Test</td>
			<td class="clrborder" align=center>Habitation</td>
<!-- 			<td class="clrborder" align=center>Sample Collected By</td> -->
			<td class="clrborder" align=center>Sample<BR>Collected Date</td>
			<td class="clrborder" align=center>Forwarded<BR>On</td>
			<td class="clrborder" align=center>Source</td>
			<td class="clrborder" align=center>Lab</td>

		</tr>
		<% int resultCount = 0;%>
		
		<nested:iterate id="LABTEST_LIST" property="wqLabTests" indexId="ndx">
		<% resultCount++; %>
		<nested:define id="testCode" name="LABTEST_LIST" property="testCode"  />
		<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=bwborder align=center>
				<nested:hidden name="LABTEST_LIST" property="testId" indexed="true"/>
				<nested:radio name="LABTEST_LIST" property="habCode" value="<%= String.valueOf(ndx)%>" indexed="false" onclick="getParameters(this)"  />
			</td>
			<td  class="bwborder" >
				<nested:hidden name="LABTEST_LIST" property="testCode" indexed="true" />
				<nested:write  name="LABTEST_LIST" property="testName" />
			</td>
			<td  class="bwborder" >
				<nested:write name="LABTEST_LIST" property="habName" />
			</td>
			<!-- <td  class="bwborder" >
				<nested:text name="LABTEST_LIST" property="sampCollectCode" 
			 				 styleClass="mytbltext" indexed="true" readonly="true" 
			 				 style="width:80px" />
			</td> -->
			<td  class="bwborder" >
				<nested:write name="LABTEST_LIST" property="sampCollectDate"/>
			</td>
			<td  class="bwborder" >
				<nested:write name="LABTEST_LIST" property="assignedOn" />
			</td>
			<td  class="bwborder" nowrap>
				<nested:hidden name="LABTEST_LIST" property="sourceCode" indexed="true" />
				<nested:write name="LABTEST_LIST" property="sourceName" />
			</td>
			<td  class="bwborder" align=center>
				<nested:hidden name="LABTEST_LIST" property="labCode" indexed="true" />
				<nested:write name="LABTEST_LIST" property="labName" />
			</td>
		</tr>
		</nested:iterate>
		<%if(resultCount == 0 ){%>
		<tr><td class="clrborder" align="center" colspan="8">no results</td></tr>
		<%} %>
		<input type="hidden" name="resultCount" value="<%=resultCount%>">
	</table>
	<table cellspacing=2 cellpadding=2 border=1 bordercolor= "#8A9FCD" style="border-collapse:collapse;" rules=none width="100%">
		<tr>
			<td class="bwborder">Update Source Data:</td>
			<td>
			<html:select property="updateSource" styleClass="mycombo">
			<html:option value="Y">YES</html:option>
			<html:option value="N">NO</html:option>
			</html:select>
			<!-- <td><font face="verdana" style="font-size:9pt;">Potable&nbsp;&nbsp;:</td>
			<td>
			<html:select property="condemnSource" styleClass="mycombo" >
			<html:option value="Y">YES</html:option>
			<html:option value="N">NO</html:option>
			</html:select>
			</td>  -->  
			<td class="bwborder">Forwarded On&nbsp;:</td>
			<td class="bwborder" nowrap><html:text property="forwadedOn" value="<%=sdf.format(new java.util.Date())%>" size="12" style="width:80px" styleClass="mytext"/>
			<a href="javascript: showCalendar(document.waterSampleResForm.forwadedOn);">
			<img src="<rws:context page='/images/calendar.gif'/>" width="22" height="17" border="0" alt="" align="absmiddle"/></a></td>		
		
			<td><font face="verdana" style="font-size:9pt;">Recommendations/Remarks:</td>
			<td colspan=3><html:textarea property="recommendations" style="width:150px" onkeypress="upperOnly()"/></td>
		</tr>
		
	</table>
	<tr>
		<td align=center>
		<html:button property="mode" title="Save the Fields"  styleClass="btext" value="Submit" onclick="fnSave()"/>
	    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
		<html:button property="mode" title="View the Results" styleClass="btext" value="View" onclick="fnView()"/>
		<bean:define id="userId" name="RWS_USER" property="userId" />
		<html:hidden property="preparedBy" value="<%=(String)userId%>"/>
		<html:hidden property="preparedOn" value="<%=sdf.format(new java.util.Date())%>"/>
	</tr>
</table>
 <input type="hidden" name="selectedRadio"> 
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%> 