<%@page import="nic.watersoft.works.rws_works_WorkStatus_bean"%>
<%@	page import="java.util.ArrayList" %>
<%@	page import="nic.watersoft.masters.PanchRaj" %>
<%@ include file="/commons/rws_SpecialHeader.jsp" %>
<%
String assetCode = request.getParameter("workId");
int count = 0;
 %>
<html>
<head>
 <html:javascript formName="WorkForm"/>
<script language="JavaScript">
function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}
function checkRadio (rbGroupName) { 
 var radios = document.forms[0].elements[rbGroupName]; 
 for (var i=0; i <radios.length; i++) { 
  if (radios[i].checked) { 
   return true; 
  } 
 } 
 return false; 
}
function fnSave(){
	var workId='<%=request.getParameter("workId")%>';
	var schools="";
	var checkbox_choices=0;
	if(document.forms[0].resultCount.value==0)
	{
		document.forms[0].school.checked=true;
		schools=schools+document.forms[0].school.value+",";	
	//	alert(schools);
		document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=saveSchool&school="+schools;
		document.forms[0].submit();	
	}
	else
	{
			for(var counter=0;counter<document.forms[0].school.length;counter++)
			{
				if(document.forms[0].school[counter].checked)
				{
					schools=schools+document.forms[0].school[counter].value+",";
					checkbox_choices++;
				}
			}
			if(checkbox_choices==0)
			{
				alert("Please Select any of Check Boxes");
			}
			else
			{
				//alert(schools);
				document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=saveSchool&school="+schools;
				document.forms[0].submit();	
			}
	}

}
function fnAdd() { 
	if(document.forms[0].schoolCount.value!=1)
	{
		var value = "";
		var flag = false;
		var radios = document.forms[0].elements['school']; 
		for (var i=0; i <radios.length; i++) { 
		if (radios[i].checked) { 
			value += ","+radios[i].value;
			flag=true;
		}
		}
		 if (!flag) 
		  alert("Please Select One School"); 
		 else 
		 if(confirm("Are You Sure to add the Selected School for this work"))
		 {
			 //alert(value);
			document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=saveSchool&school="+value;
			document.forms[0].submit();	
		 }
	}
	else
	{
		if(confirm("Are You Sure to add the Selected School for this work"))
		{
			var value = "";
			document.forms[0].school.checked=true;
			value = document.forms[0].school.value;
			document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=saveSchool&school="+value;
			document.forms[0].submit();	
		}
	}
}
function getPanchayats()
{
	var workId='<%=request.getParameter("workId")%>';	document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=addSchool&mode1=panchayats&workId="+workId;
	document.forms[0].submit();	
}
function getVillages()
{
	var workId='<%=request.getParameter("workId")%>';	document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=addSchool&mode1=villages&workId="+workId;
	document.forms[0].submit();	
}
function getHabs()
{
	var workId='<%=request.getParameter("workId")%>';	document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=addSchool&mode1=habs&workId="+workId;
	document.forms[0].submit();	
}
function carryHabs()
{
	var workId='<%=request.getParameter("workId")%>';
	var txt = document.getElementById("habs1");
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
				s+=document.forms[0].habs[i].value+",";
				count++;	
			}
		}
		//alert(s);
			var openerDoc = opener.document;
			if(confirm(count+" Habitation(s) Selected.....\n Press OK to get School Information..."))
			{
                  alert("Ur workid"+workId);
				var openRequest = getAjaxObj();
				var url = "/pred/works/rws_SchoolsGet.jsp?workId="+workId+"&habs="+s;
				openRequest.open("GET",url,true);
	openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
postData=s;
				openRequest.send(null);
openRequest.onreadystatechange = function(){
  //alert("State:"+openRequest.readyState);
 //alert("Sttaus:"+openRequest.status);
     if(openRequest.readyState == 4 && openRequest.status == 200){

  //alert(openRequest.responseText);
        if(openRequest.responseText != null)
            document.getElementById("schools").innerHTML=openRequest.responseText;
        else{
             alert("failed");
             return false;
        }
     }
}
			
					document.forms[0].addSchool.disabled=false;
			}
	}
	else
	{
		alert("Select Habitions to Get Schools");
	}
}
function getSchools()
{
	var workId='<%=request.getParameter("workId")%>';
	if(document.forms[0].mandalss.value!="")
	{
		if(document.forms[0].panchayatCode.value!="")
		{
			document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=addSchool&mode1=yes&workId="+workId;
			document.forms[0].submit();	
		}
		else
		{
			alert("Please Select Panchayat");
		}
	}
	else
	{
		alert("Please Select Mandal");
	}
}
function AjaxFun(destinationname)
{
	var txt = document.getElementById("mandalss");
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
		//alert(aCode);
		//alert(aCode.substring(4,6));
		var s ="and (substr(panch_code,1,2)="+aCode.substring(4,6)+" and ( ";

		for(i=0;i<document.forms[0].mandalss.length;i++)
		{
			if(document.forms[0].mandalss[i].checked==true)
			{
				s+=" substr(panch_code,6,2)="+(document.forms[0].mandalss[i].value)+" or ";
			}
			
		}
	//	s += " ) "
		//var postData = generatePreviewData(form);
		//alert(s);
		var openRequest = getAjaxRequest();
		openRequest.open("POST","/pred/works/HabsGet.jsp?assetCode="+aCode+"&mandals="+s,false);
		postData=s;
		openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		openRequest.send(postData);
		document.getElementById("habs1").innerHTML=openRequest.responseText;
		document.forms[0].getSchools.disabled=false;
	}
	else
	{
		alert("Select Mandal to Get Habitations");
	}
}
function generatePreviewData(form) 
	{
var postData ="mandals="+form.mands.value;
//alert(postData);
return(postData); 
} 


function getAjaxObj(){


var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
return xmlHttp;

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
<style>
DIV{
	SCROLLBAR-FACE-COLOR: #c6c6aa; SCROLLBAR-HIGHLIGHT-COLOR: #c6c6aa; SCROLLBAR-SHADOW-COLOR: #ffffff; SCROLLBAR-3DLIGHT-COLOR: #ffffff; SCROLLBAR-ARROW-COLOR: #7c7764; SCROLLBAR-TRACK-COLOR: #c6c6aa
}
</style>
<body leftmargin="0" topmargin="0" bgcolor="#edf2f8">
<%java.util.Date date=new java.util.Date();
 	             long now=date.getTime();
  	             response.setHeader("Expires",(now-(1000*60*60))+""); %>
<html:form action="WorkStatus.do"  method="POST">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<html:hidden property="workId" value="<%=request.getParameter(\"workId\")%>"/>
<BR><BR><BR><center><font face=verdana size=2><b><u>Select School to Link the Work</u></b></font><BR><BR>
<table width="60%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block" align=center>
<thead class="gridLabel">
<tr align="center">
<td colspan=2 nowrap><font size=2><b>Work Name:</b></font>
&nbsp;&nbsp;<html:text property="workName" style="width:750px" styleClass="noborder-text-box" readonly="true"/>
</td></tr>
</thead>
<tbody class="gridText">
<tr>
<td align="center" colspan=2 class="btext">
District : <%=request.getAttribute("dname")%>
</td>
</tr>
</table>
<table width="90%" cellspacing="0" cellpadding="1" border="0" bordercolor="#000000" style="border-collapse:collapse;display:block" align="center">
<tr><td align="center"><font size="2" face="verdana"><b>Note:********* &nbsp;Please Select All the Habitations at Once and Click 'Get Schools' button.</b></font></td></tr>
<tr>
<td align=center>
<table width="90%" cellspacing="0" cellpadding="1" border="1" bordercolor="#000000">
<tr><td width="30%" align=center><FONT size="2" face="verdana"><b>Mandals</b></FONT></td>
<td width="12%">&nbsp;</td>
<td width="48%" align=center><FONT size="2" face="verdana"><b>Habitations</b></FONT></td></tr>
<%
String s = "";
java.util.ArrayList al = (java.util.ArrayList)request.getAttribute("schoolMandals");
%>
<tr>
<td valign="top">
<c:forEach items="${mandals}" var="item" varStatus="status">
<c:set var="ab" value="${item.mandalCode}" scope="request"/>
<%
s = (String)request.getAttribute("ab");
if(al.contains(s))
	{
%>
	<input type=checkbox name=mandalss value="<c:out value='${item.mandalCode}'/>" checked>
	<font face=verdana size=2> <c:out value="${item.mandalName}" /></font><br>


	<%}
	else{
		%>
		<input type=checkbox name=mandalss value="<c:out value='${item.mandalCode}'/>">
	<font face=verdana size=2> <c:out value="${item.mandalName}" /></font><br>
		<%}%>
</c:forEach>
</td>
<td valign="top" align="center">
<input type="button" value="Get Habitations>>>" onClick="AjaxFun('habs')">
<font face=verdana size=2 color=red>Alredy Linked Schools Related 'Mandals & Habitations' Selected By Default.</font>
</td>
<td id="habs1"  valign="top">
</td>
</tr>
</table>
</td>
</tr>
</table>
<table align=center>
<tr>
<td colspan=2 class=textborder>
&nbsp;</td>
</tr>
<tr>
<td colspan=2 align="center">
<input type="button" value="Get Schools" name="getSchools" class="btext" disabled="true" onclick="carryHabs();">
</td>
</tr>
<tr>
<td colspan=2>
&nbsp;
</td>
</tr>
<!-- <tr>
<td colspan=2 class="btext">
Mandal : <%=request.getAttribute("mname")%>
</td>
</tr> -->

<tr>
<td id="schools" valign="top">
</td>
</tr>
<tr>
<td>&nbsp;
</td>
</tr>
<tr>
<td align="center">
	<input type=button name="addSchool" value="Add the Selected School to this Work" styleClass="btext" disabled=false onclick="fnSave()"/>
	<input type=button value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</td>
</tr>
</table>
</html:form>
</body>
</html>
