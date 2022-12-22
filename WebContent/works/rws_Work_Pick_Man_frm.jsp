<%@ page buffer="16kb" autoFlush="true"%>
<%@ include file="/commons/rws_header1.jsp" %>
 <%
 String workId = request.getParameter("workId");
 String coc = request.getParameter("coc"); 
 String type = request.getParameter("type"); 
String path = request.getContextPath();
String table="";
if (type != null && type.equals("admin")) {
	if (workId != null
			&& workId.substring(6, 8).equals("11")) {
		table = "rws_work_school_lnk_tbl ";
	} else if (workId != null
			&& workId.substring(6, 8).equals("12")) {
		table = "rws_work_lab_lnk_tbl";
	} else {
		table = "RWS_ADMN_HAB_LNK_TBL";
	}
} else if (type != null && type.equals("tech")) {
	table = "RWS_EST_NEW_HAB_LNK_TBL";
} else if (type != null && type.equals("comp")) {
	table = "RWS_WORK_COMP_HAB_LNK_TBL";
}
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
		var type = '<%=type%>';
		var workId = '<%=workId%>';
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
				var url = "./switch.do?prefix=/works&page=/HabLink.do&mode=carryHabs&workId="+workId+"&type="+type;
				//alert(url);
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
		var aCode = '<%=workId%>';
		var table = '<%=table%>';
		var s ="and (";
		for(i=0;i<document.forms[0].mandalss.length;i++)
		{
			if(document.forms[0].mandalss[i].checked==true)
			{
				s+="substr(panch_code,1,2)="+(document.forms[0].mandalss[i].value).substring(0,2)+" and substr(panch_code,6,2)="+(document.forms[0].mandalss[i].value).substring(3,5)+" or ";
			}
			
		}
		var openRequest = getAjaxRequest();
		openRequest.open("POST","/pred/works/Work_HabsGet.jsp?workId="+aCode+"&table="+table+"&mandals="+s,false);
		postData=s;
		openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		openRequest.send(postData);
		document.getElementById("habs1").innerHTML=openRequest.responseText;


	}
	else
	{
		alert("Select Mandal to Get Habitations");
	}
}

function AjaxFun1(destinationname)
{
	var aCode = '<%=workId%>';
	var table = '<%=table%>';
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
		var openRequest = getAjaxRequest();
		openRequest.open("POST","/pred/works/Work_MandalsGet.jsp?workId="+aCode+"&table="+table+"&dists="+s,false);
		postData=s;
		openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		openRequest.send(postData);
		document.getElementById("mandals1").innerHTML=openRequest.responseText;

	}
	else
	{
		alert("Select District to Get Mandals");
	}
}

function generatePreviewData(form) 
	{
var postData ="mandals="+form.mands.value;
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

<html:form action="HabLink" onsubmit="return fnAdd(this)">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<input type="hidden" name="selectedDcodes" value="">
<input type="hidden" name="All" value="">
<input type="hidden" name="proposalId" value="<%=request.getParameter("proposalId")%>"/>
<input type="hidden" name="coc" value="<%=(String)request.getParameter("coc")%>"/>
<input type="hidden" name="index" value="<%=request.getParameter("index") %>"  />
<input type="hidden" name="mode" value=""/>


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

<input type="hidden" name="index" value="<c:out value='${param.index}'/>">

</html:form>
</body>
</html>
<%try{
 String[] mcodes=(String[])session.getAttribute("H_"+request.getParameter("proposalId"));
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

 