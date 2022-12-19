<%@ page buffer="16kb" autoFlush="true"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%String coc = request.getParameter("coc"); 
String path = request.getContextPath();
String subdivisionOfficeCode = request.getParameter("subdivisionOfficeCode");
String prooved = request.getParameter("prooved");
String assetcode = request.getParameter("assetcode");
String workid=(String)session.getAttribute("proposalId");
String habindex=(String)session.getAttribute("habindex");
String editvar=(String)session.getAttribute("editvar");
%>

<script language="JavaScript">

function carryHabs()
{   
    var workid='<%=workid%>';
    var index='<%=habindex%>';
    var editvar='<%=editvar%>';
	var subdivisionOfficeCode = '<%=subdivisionOfficeCode%>';
	var prooved = '<%=prooved%>';
	var assetcode = '<%=assetcode%>';
	var txt = document.getElementById("habs");
	var selectHabs = "false";
	for(i=0;i<txt.length;i++)
	{
		if(txt.options[i].selected==true)
		{
			selectHabs="true";	
		}
	}
	if(selectHabs)
	{  // alert("selected"+txt.length);
		var s ="";
		var count = 0;
		for(i=0;i<txt.length;i++)
		{
			if(txt.options[i].selected==true)
			{
				s+=txt.options[i].text+"@@";
				count++;	
			}
		}
			var openerDoc = opener.document;
			if(confirm("Are you sure to Add Selected Habitations("+count+") .\nPress OK to continue..."))
			{
                    document.forms[0].selHabs.value=s;
					var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do&mode=carryHabs&add=Y&noOfHabs="+count+"&workid="+workid+"&habindex="+index+"&editvar="+editvar+"&selHabs="+s;
				    document.forms[0].action=url;
					document.forms[0].submit();
					window.opener.location.href="switch.do?prefix=/drought&page=/AdminstrativeSanction.do&mode=carryHabs&noOfHabs="+count+"&subdivisionOfficeCode="+subdivisionOfficeCode+"&prooved="+prooved+"&typeOfAsset="+assetcode+"&workid="+workid+"&habindex="+index+"&editvar="+editvar+"&selHabs="+s;
					window.close();
				
             
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
		     mcodes=mcodes+"@"+document.getElementById('mandalCode['+i+']').value;
		  }
	  }
	 
	document.getElementById('selectedMcodes').value=mcodes;
  document.forms[0].action="switch.do?prefix=/drought&page=/PickAdminHabitation.do";
  document.forms[0].submit();
}

function AjaxFun(destinationname)
{
	var txt = document.getElementById("mandalss");
	var selectMandal = "false";
	for(i=0;i<txt.length;i++)
		{
			if(txt.options[i].selected==true)
			{
				selectMandal="true"
			}
			
		}
	if(selectMandal=="true")
	{
		var coc = <%=coc%>;
		var form = document.forms[0];
		var txt = document.getElementById("mandalss");
		var s ="substr(panch_code,1,2)="+coc+" and (";
		for(i=0;i<txt.length;i++)
		{
			if(txt.options[i].selected==true)
			{
				s+="substr(panch_code,6,2)="+txt.options[i].value+" or ";
			}
			
		}
		var postData = generatePreviewData(form);
		var openRequest = getAjaxRequest();
		var urll = "/pred/drought/HabsGet.jsp?mandals="+s;
		openRequest.open("POST",urll,false);
		postData=s;
		openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		openRequest.send(postData);
	//	var response = openRequest.responseText.split(",");
		//document.getElementById(destinationname).options.length = 0; 
//alert(openRequest.responseText);
		document.getElementById("habs1").innerHTML="<select name=habs  size=10 class=hightlongcombo>"
+openRequest.responseText+"</select>";


		//document.getElementById(destinationname).innerHTML="hai";
//openRequest.responseText;
	}
	else
	{
		alert("Select Mandal to Get Habitations");
	}
}

function generatePreviewData(form) 
	{
var postData ="mandals="+form.mandalss.value;
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

<html:form action="SaveAdminHabitation" onsubmit="return fnAdd(this)">
<input type="hidden" name="selectedMcodes" value="">
<input type="hidden" name="All" value="">
<input type="hidden" name="proposalId" value="<%=request.getParameter("proposalId")%>"/>
<input type="hidden" name="coc" value="<%=(String)request.getParameter("coc")%>"/>
<input type="hidden" name="index" value="<%=request.getParameter("index") %>"  />
<input type="hidden" name="mode" value=""/>

<logic:notEmpty name="mandals">

<table width="90%" cellspacing="0" cellpadding="2" border="0" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block" align="center">
<tr><td align="center"><font size="3" face="verdana"><b>Select Mandals & Habitations</b></font></td></tr>
<tr>
<td>
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000">
<tr><td width="25%" align=center><FONT size="2" face="verdana"><b>Mandals</b></FONT></td><td width="5%">&nbsp;</td><td width="70%"  align=center><FONT size="2" face="verdana"><b>Habitations : Hab Code-HabName(Panchayat-Village)</b></FONT></td></tr>


<%int i=0;
%>
<tr>
<td>
<select name="mandalss"  size="10" class="hightcombo">
<c:forEach items="${mandals}" var="item" varStatus="status">
	<option value="<c:out value='${item.mandalCode}'/>""><c:out value="${item.mandalName}" /></option>
</c:forEach>
</select>
</td>
<td>
<input type="button" value="Get Habs>>>" onClick="AjaxFun('habs')">
</td>
<td id="habs1">
<select name="habs" multiple size="10" class="hightlongcombo">
</select>
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
<input type="hidden" name="selHabs">
<input type="hidden" name="proposalId" value="<%=request.getParameter("proposalId")%>">
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

 









































