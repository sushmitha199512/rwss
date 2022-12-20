<%@ page buffer="16kb" autoFlush="true"%>
<%@ include file="/commons/rws_header1.jsp" %>
 <%
 String assetCode = request.getParameter("assetCode");
 //System.out.println("assetCode:"+assetCode);
 String coc = request.getParameter("coc"); 
String path = request.getContextPath();
//System.out.println("path:"+path);
%>
<script language="JavaScript">
function carryHabs()
{
	var txt = document.getElementById("habs");
	var selectHabs = "false";
	for(i=0;i<document.forms[0].habs.length;i++)
		{
			if(document.forms[0].habs[i].checked==true)
			{
			selectHabs="true";	
		}
	}
	if(selectHabs=="true")
	{
		var s ="";
		var count = 0;
		for(i=0;i<document.forms[0].habs.length;i++)
		{
			if(document.forms[0].habs[i].checked==true)
			{
				//s+=document.forms[0].habs[i].value+",";
				count++;	
			}
		}
			var openerDoc = opener.document;
			if(confirm(count+" Habitation(s) Selected\n Press OK to SAVE Press CANCEL to add Habitations..."))
			{
				var url = "switch.do?prefix=/masters&page=/Asset.do&mode=carryHabs";
				document.forms[0].action = url;
				document.forms[0].submit();
			}
	}
	else
	{
	alert("Select Habitions to Add Habitaions");
	}
}
function calMe()
{
document.getElementById('unChkALL').style.display='none';
}
function checkAll()
{
 

 for(i=0; i<document.forms[0].elements.length; i++)
	{ 
		 if (document.forms[0].elements[i].type == "checkbox")
		 {
		  document.forms[0].elements[i].checked = true;
		 }
	 }
	  document.getElementById('chkALL').style.display='none';
	  document.getElementById('unChkALL').style.display='inline';
	   document.getElementById('All').value='yes';
}

function clearAll()
{
  for(i=0; i<document.forms[0].elements.length; i++)
	{ 
		 if (document.forms[0].elements[i].type == "checkbox")
		 {
		  document.forms[0].elements[i].checked = false;
		 }
	 }
	  document.getElementById('chkALL').style.display='inline';
	  document.getElementById('unChkALL').style.display='none';
	  document.getElementById('All').value='';
}
function getHabs()
{ 
var len=document.getElementById('count').value;
 
  var mcodes="00";
  
    for(var i=0; i<len; i++)
	{   
	 
	 	  if(document.getElementById('mandalCode['+i+']').checked ==true)
		  { 
		     mcodes=mcodes+"<>"+document.getElementById('mandalCode['+i+']').value;
		  }
	  }
	 
	document.getElementById('selectedMcodes').value=mcodes;
  document.forms[0].action="switch.do?prefix=/proposals&page=/PickAdminHabitation.do";
  document.forms[0].submit();
}

function AjaxFun(destinationname)
{
	var txt = document.getElementById("mandalss");
//	alert(document.forms[0].mands.value);
	var selectMandal = "false";
	for(i=0;i<document.forms[0].mandalss.length;i++)
		{
			if(document.forms[0].mandalss[i].checked==true)
			{
				selectMandal="true"
			}
			
		}
	if(selectMandal=="true")
	{
		var form = document.forms[0];
		var txt = document.getElementById("mandalss");
		var aCode = '<%=assetCode%>';
		var s ="and (";
		for(i=0;i<document.forms[0].mandalss.length;i++)
		{
			if(document.forms[0].mandalss[i].checked==true)
			{
				s+="substr(panch_code,1,2)="+(document.forms[0].mandalss[i].value).substring(0,2)+" and substr(panch_code,6,2)="+(document.forms[0].mandalss[i].value).substring(3,5)+" or ";
			}
			
		}
		//var postData = generatePreviewData(form);
		var openRequest = getAjaxRequest();
		openRequest.open("POST","/pred/masters/HabsGet.jsp?assetCode="+aCode+"&mandals="+s,false);
		postData=s;
		openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		openRequest.send(postData);
	//	var response = openRequest.responseText.split(",");
		//document.getElementById(destinationname).options.length = 0; 
		document.getElementById("habs1").innerHTML=openRequest.responseText;


		//document.getElementById(destinationname).innerHTML="hai";
//openRequest.responseText;
	}
	else
	{
		alert("Select Mandal to Get Habitations");
	}
}

function AjaxFun1(destinationname)
{
	var aCode = '<%=assetCode%>';
	var selectMandal = "false";
	for(i=0;i<document.forms[0].dists.length;i++)
		{
			if(document.forms[0].dists[i].checked==true)
			{
				selectMandal="true"
			}
			
		}
	if(selectMandal=="true")
	{
		var form = document.forms[0];
		var txt = document.getElementById("dists");
		var s ="";
		for(i=0;i<document.forms[0].dists.length;i++)
		{
			if(document.forms[0].dists[i].checked==true)
			{
				s+="dcode="+document.forms[0].dists[i].value+" or ";
			}
			
		}
		//var postData = generatePreviewData(form);
		//alert("PD:"+postData);
		var openRequest = getAjaxRequest();
		openRequest.open("POST","/pred/masters/MandalsGet.jsp?assetCode="+aCode+"&dists="+s,false);
		postData=s;
		openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		openRequest.send(postData);
	//	var response = openRequest.responseText.split(",");
		//document.getElementById(destinationname).options.length = 0; 
		document.getElementById("mandals1").innerHTML=openRequest.responseText;


		//document.getElementById(destinationname).innerHTML="hai";
//openRequest.responseText;
	}
	else
	{
		alert("Select District to Get Mandals");
	}
}

function generatePreviewData(form) 
	{
var postData ="mandals="+form.mands.value;
//alert(postData);
return(postData); 
} 

function getAjaxRequest()
	{
var openRequest;
try {
openRequest = new XMLHttpRequest();
return openRequest;
}
catch (error) {
try {
openRequest = new ActiveXObject("Microsoft.XMLHTTP");
return openRequest;
}
catch (error)
	{
if(isDebugOn)
displayDebugError("Error crea");
	}
	
}
	}
</script>
</head>

<body method="post"leftmargin="0" topmargin="0" bgcolor="#edf2f8">

<html:form action="Asset" onsubmit="return fnAdd(this)">
<input type="hidden" name="selectedMcodes" value="">
<input type="hidden" name="All" value="">
<input type="hidden" name="proposalId" value="<%=request.getParameter("proposalId")%>"/>
<input type="hidden" name="coc" value="<%=(String)request.getParameter("coc")%>"/>
<input type="hidden" name="index" value="<%=request.getParameter("index") %>"  />
<input type="hidden" name="mode" value=""/>

<logic:notEmpty name="mandals">

<table width="100%" cellspacing="0" cellpadding="2" border="0" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block" align="center">
<tr><td align="center"><font size="2" face="verdana"><b>Select Districts, Mandals & Habitations</b></font></td></tr>
<tr>
<td>
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000">
<tr><td width="18%" align=center><FONT size="2" face="verdana"><b>Districts</b></FONT></td>
<td width="3%">&nbsp;</td>
<td width="23%" align=center><FONT size="2" face="verdana"><b>Mandals</b></FONT></td>
<td width="4%">&nbsp;</td>
<td width="53%" align=center><FONT size="2" face="verdana"><b>Habitations</b></FONT></td></tr>


<%int i=0;
String s = "";
%>
<tr>
<td valign="top">
<c:forEach items="${dists}" var="item" varStatus="status">
<c:set var="ab" value="${item.districtCode}" scope="request"/>
<%
java.util.ArrayList al = (java.util.ArrayList)request.getAttribute("assetdists");

//System.out.println("al size:"+al.size());

s = (String)request.getAttribute("ab");
if(al.contains(s))
	{
%>
	<input type=checkbox name=dists value="<c:out value='${item.districtCode}'/>" checked>
	<font face=verdana size=2> <c:out value="${item.districtName}" /></font><br>


	<%}
	else{
		%>
		<input type=checkbox name=dists value="<c:out value='${item.districtCode}'/>">
	<font face=verdana size=2> <c:out value="${item.districtName}" /></font><br>
		<%}%>
</c:forEach>
</select>
</td>
<td valign="top">
<input type="button" value=">>>" onClick="AjaxFun1('mandals')">
</td>
<td id="mandals1"  valign="top">

</td>
<td valign="top">
<input type="button" value=">>>" onClick="AjaxFun('habs')">
</td>
<td id="habs1"  valign="top">
</td>
</td>
</tr>
</td>
</tr>
</table>
</td>
</tr>
<input type="hidden" name="count" value="<%=i++%>" />
</table>
<input type="hidden" name="proposalId" value="<c:out value='${habitations[0].proposalId}'/>">
<br>
<center>
	<html:button property="mode" value="Add Habitations" styleClass="btext" onclick="carryHabs()"/>
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:notEmpty>

<logic:empty name="mandals">
<center><b class="gridLabel">
There are no Mandals in the selected office.
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
</body>
</html>
<%try{
 String[] mcodes=(String[])session.getAttribute("H_"+request.getParameter("proposalId"));
//System.out.println("Lenght"+mcodes.length);
for(int i=0;i<mcodes.length;i++)
{
 %>
 <script>
	var len=document.getElementById('count').value;
	for(var i=0;i<len;i++)
	{
	var mcode=document.getElementById('mandalCode['+i+']').value;
	if(mcode==<%=mcodes[i]%>)
	  {
	   document.getElementById('mandalCode['+i+']').checked=true;
	  }
	}
 </script>
<%}
}
catch(Exception e){} %>

 