 
<%@ include file="/commons/rws_header1.jsp" %>
 <%!int i=0,ix=0; %>
<script language="JavaScript">
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
			var url="./switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=doNothing";
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
 

function fnAdd()
{
var noOfSelectedHabs = 0;
var leng = document.forms[0].hidd1.value;
if(confirm("Do you want add the selected habitations?"))
{
for(var sss=1;sss<=leng;sss++)
{
if(document.getElementById('selectedHabCode['+sss+']').checked)
{	
	noOfSelectedHabs++;
	selHabss[selHabsIndex++]=document.getElementById('selectedHabCode['+sss+']').value;
}
}

	document.forms[0].hidd.value = selHabss;
	var openerDoc = opener.document;
	openerDoc.getElementById("techHabsBen").value = noOfSelectedHabs;
	document.forms[0].action="/pred/works/SaveCompHabs.jsp";
	alert("You have added "+ noOfSelectedHabs+" hab(s)");
	document.forms[0].submit();
}
}

 
 
</script>
</head>

<body leftmargin="0" topmargin="0" bgcolor="#edf2f8" onload="initFunc()">
<%java.util.Date date=new java.util.Date();
 	             long now=date.getTime();
  	             response.setHeader("Expires",(now-(1000*60*60))+""); %>
  	             
<html:form action="PickHabs"  method="POST"  >
<html:hidden property="workId" value="<%=request.getParameter(\"workId\")%>"/>
<logic:notEmpty name="habitations">

<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th>Assembly</th>
	<th>Mandal</th>
	<th><bean:message key="app.habitationCode" /></th>
	<th colspan="2"><bean:message key="app.habitationName" /></th>
	
	<th><bean:message key="app.population" /></th>
	<th><bean:message key="app.status" /></th>
</tr>
</thead>
<tbody class="gridText">

<%i=0; %>
<c:forEach items="${habitations}" var="item" varStatus="status">
<tr id="hab<%=i++%>">
	
	<td align="center">
		<b><c:out value="${item.constituencyName}" /></b>
	</td>
	<td align="center">
		<b><c:out value="${item.mandalName}" /></b>
	</td>
	<td align="center">
		<b><c:out value="${item.habCode}" /></b>
	</td>
	<td align="left">
		<b><c:out value="${item.habName}" /></b>
	</td>
	<td align="center">
		<input type="checkbox" name="selectedHabCode[<%=i%>]" 
			   value="<c:out value='${item.habCode}' />" <c:out value='${item.habMatch}' /> onclick="hilight(document.getElementById('hab<%=i-1%>'))"/>
	</td>
	<td align="right">
		<c:out value="${item.population}" />
	</td>
	<td align="center">
		<c:out value="${item.status}" />
	</td>
</tr>
</c:forEach>
<%ix = i;%>
</tbody>
</table>
 
<br>
<center>
	<html:button property="mode" value="Add" styleClass="btext" onclick="fnAdd()"/>
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
 <input type="hidden" name="hidd1">
 <input type="hidden" name="hidd">


</html:form>
</body>
<div id="load"></div>
</html>
<script language="javascript">
	var selHabss = new Array();
	var selHabsIndex = 0;
function funcInit()
{
	for(var i=0;i<<%=i%>;i++)
	{
		if(document.forms[0].selectedHabCode(i).checked==true)
			document.getElementById("hab"+i).style.background='<bean:message key="tableRowHighlightColor" />';
		
	}

}
</script>

 <%try{
int counts = 0;
 String[] mcodes=(String[])session.getAttribute("selHabCodes");
if(mcodes != null){
for(int x = 0;x<mcodes.length;x++)
{
	if(mcodes[x]!=null)
{
counts++;
}
}
}
 if(mcodes != null){
for(int i=0;i<counts;i++)
{
String mcode=mcodes[i];
%>
 <script>

	var len=<%=ix%>;
document.forms[0].hidd1.value = len;
	for(var i=1;i<=len;i++)
	{
		var mcode = document.getElementById('selectedHabCode['+i+']').value;
		var mcode1 = '<%=mcode%>';
	    if(mcode==mcode1)
	  	{ 
	   		document.getElementById('selectedHabCode['+i+']').checked=true;
	  	 }
	}
 </script>
<%}
}
}
catch(Exception e){System.out.println("Exception in jsp:"+e);} %>