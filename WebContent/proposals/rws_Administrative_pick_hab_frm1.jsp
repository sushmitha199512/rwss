<%@ page buffer="16kb" autoFlush="true"%>
<%@ include file="/commons/rws_header1.jsp" %>
 
<script language="JavaScript">
<!--

//ajax code begins here
function initFunc()
{

	//var intervalID = window.setInterval("sendAjaxRequest()", 30*1000);
	var sessionTimeOutValue=<%=session.getMaxInactiveInterval()%>
	//coverting sessionTimeOutValue to Min.
	sessionTimeOutValue=sessionTimeOutValue/60;
	var interval=0;
	if(sessionTimeOutValue>5)
	{
		//set the interval as sessionTimeOutValue in Min. - 5Min.
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
var clientScreenWidth=document.body.clientWidth;
var leftPos=clientScreenWidth-130;
var topPos=document.body.scrollTop+15;
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
			        document.getElementById('load').innerHTML="<div id='innerLoad' style='position:absolute; left:"+leftPos+"px; top:"+topPos+"px; background-color:CC0033' ALT='Please wait..'>Extending Session...</div>";
			          
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
			              alert("Oops there was a problem while connecting. \n Your Session might have already expired.");
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
//other things to include
//include initFunc() in body onload event
//include <div id="load"></div> in body of the html document
//end
// ***********ajax code ends here***********



function hilight(that)
{
 
 var rowCol='<bean:message key="tableRowHighlightColor" />';
 if(that)
 {
  if(that.style.background==rowCol)
  {
   that.style.background="white";
   
  }
  else if(that.style.background=="white")
  {
     that.style.background=rowCol;
     
  }
  else 
  {
    that.style.background=rowCol;
  }
  
 }
 
}
function searchHab()
{

}

function fnAdd(frm)
{
	var selectedHabs = 	frm.elements("selectedHabCode");
	var len;
	var isAllowed = false;
	if(selectedHabs)
	{
		if(typeof selectedHabs.length != 'number')
			selectedHabs = [selectedHabs];
		
		len = selectedHabs.length;
		for(var i=0; i<len; i++)
		{
			if(selectedHabs[i].checked)
				isAllowed = true;
		}
		if(isAllowed)
		{
			if(confirm("Do you want add the selected habitations?"))
			{
				var index = document.getElementById("index").value;
				var totalHabitations = document.forms[0].elements("selectedHabCode");
				var noOfSelectedHabs = "";
				if(totalHabitations)
				{
					if(typeof totalHabitations.length != "number")
					{
						totalHabitations = [totalHabitations];
					}
					var len = totalHabitations.length;
					
					for(var i=0; i<len; i++){
						if(totalHabitations[i].checked)
							noOfSelectedHabs++;  
					}
				}
				var openerDoc = opener.document;
				if(confirm("you have added "+noOfSelectedHabs+" habitation(s) \n if you want to add more click 'cancel' \n other wise click 'ok' to continiue"))
				{
				openerDoc.getElementById("WORK["+index+"].noOfHabs").value = noOfSelectedHabs;
				return true;
				}
				else
				{
				return false;
				}
			}
		}
		else
			alert("Please select atleast one habitation.");
	}
	return false;
}

function fnOpenerSubmit()
{
	
}
//-->
</script>
</head>

<body leftmargin="0" topmargin="0" bgcolor="#edf2f8" onload="initFunc()">

<html:form action="SaveAdminHabitation" onsubmit="return fnAdd(this)">

<logic:notEmpty name="habitations">

<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	 <th>Assembly</th>
	<th>Mandal</th>
	<th>Panchayat</th>
	<th>Village</th>
	<th><bean:message key="app.habitationCode" /></th>
	<th colspan=2><bean:message key="app.habitationName" /></th>
	<th><bean:message key="app.population" /></th>
	<th><bean:message key="app.status" /></th>
</tr>
</thead><%int i=0; %>
<tbody class="gridText">
<c:forEach items="${habitations}" var="item" varStatus="status">
<tr id="hab<%=i++%>">
	
	<td align="center">
		<b><c:out value="${item.assemblyName}" /></b>
	</td>
	<td align="center">
		<b><c:out value="${item.mandalName}" /></b>
	</td>
	<td align="center">
		<b><c:out value="${item.panchayatName}" /></b>
	</td>
	<td align="center">
		<b><c:out value="${item.villageName}" /></b>
	</td>
	<td align="center">
		<b><c:out value="${item.habCode}" /></b>
	</td>
	<td align="left">
		<b><c:out value="${item.habName}" /></b>
	</td>
	<td align="center" >
		<input type="checkbox" name="selectedHabCode" onclick="hilight(document.getElementById('hab<%=i-1%>'))"
			   value="<c:out value='${item.habCode}' />"/>
	</td>
	<td align="right">
		<c:out value="${item.population}" />
	</td>
	<td align="center">
		<c:out value="${item.status}" />
	</td>
</tr>
</c:forEach>
</tbody>
</table>
<input type="hidden" name="proposalId" value="<c:out value='${habitations[0].proposalId}'/>">
<br>
<center>
	<html:submit property="mode" value="Add" styleClass="btext"/>
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:notEmpty>

<logic:empty name="habitations">
<center><b class="gridLabel">
There are no habitations in the selected office.
<br>Please select different office</b><br> 
<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:empty>
<input type="hidden" name="index" value="<c:out value='${param.index}'/>">

<script>
<!-- 

var frm = document.forms[0];
var habs = frm.elements("selectedHabCode");
if(habs)
{
	if(typeof habs.length != 'number')
		habs = [habs];
	
	for(var i=0; i<habs.length; i++)
	{
		<c:forEach items="${tempSelectedHabs}" var="item">
			if(habs[i].value == '<c:out value="${item.habCode}" />')
				habs[i].checked = true;
		</c:forEach>	
	}
}
//-->
</script>
</html:form>
<div id="load"></div>
</body>
</html>

<%
	String message = (String)request.getAttribute("insert-success");
	if(message != null && message.equals("inserted"))
	{
%>
	<script>
	<!--
		var index = document.getElementById("index").value;
		var openerDoc = opener.document;
		alert("Habitations added successfully.\nPress OK to continue...");
		var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=showHabs";
		openerDoc.forms[0].action = url;
		openerDoc.forms[0].submit();
		window.close();
	//-->
	</script>
<%
	}
	
	if(message != null && message.equals("not-inserted"))
	{
%>
	<script>
	<!--
		alert("Cannot add habitations.\n Please try again.");
		openerDoc.getElementById("WORK["+index+"].noOfHabs").value = "";
	//-->
	</script>
<% 
	}
%> 