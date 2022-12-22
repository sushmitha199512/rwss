<%@ page buffer="16kb" autoFlush="true"%>
<%@ include file="/commons/rws_header1.jsp" %>
 <%
 	String coc = request.getParameter("coc"); 
	String path = request.getContextPath();
	String subdivisionOfficeCode = request.getParameter("subdivisionOfficeCode");
	String prooved = request.getParameter("prooved");
	String assetcode = request.getParameter("assetcode");
	String proposalId=request.getParameter("proposalId");
%>
<script language="JavaScript">
function carryLabs(){
	var subdivisionOfficeCode = '<%=subdivisionOfficeCode%>';
	var prooved = '<%=prooved%>';
	var assetcode = '<%=assetcode%>';
	var txt = document.getElementById("labs");
	var selectLabs = "false";
	for(i=0;i<txt.length;i++){
		if(txt.options[i].selected==true){
			selectLabs="true";	
		}
	}
	if(selectLabs=="true"){
		var s ="";
		var count = 0;
		for(i=0;i<txt.length;i++){
			if(txt.options[i].selected==true){
				s+=txt.options[i].text+"@@";
				count++;	
			}
		}
			var openerDoc = opener.document;
			if(confirm("Are you sure to Add Selected Labs("+count+") .\nPress OK to continue...")){
				document.forms[0].selHabs.value=s;
				saveHabsToTemp("/pred/proposals/rws_temp_habs_save.jsp?selHabs="+s+"&proposalId="+<%=proposalId %>);
     		return; 
				var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=carryHabs&add=Y&noOfHabs="+count+"&typeOfAsset="+assetcode;
				document.forms[0].action=url;
				document.forms[0].submit();			

      		window.close();
      		window.opener.location.href = window.opener.location.href; 
			if (window.opener && !window.opener.closed) {
				window.opener.location.reload();
			} 	
		}
	}
	else{
		alert("Select Labs to Add Labs");
	}
}

function saveHabsToTemp(URL){ 
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
	if (xmlHttp==null){
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function(){
	  if(xmlHttp.readyState==4){
			var resp = xmlHttp.responseText;
		   
          	if(resp.length==26){
 				alert(resp);
		       	window.close();
				window.opener.location.href = window.opener.location.href; 
				if (window.opener && !window.opener.closed) {
					window.opener.location.reload();
				} 			
       		}else{
			    alert(resp);
				alert("Labs not added");
	    	}		
	  	}
	}
	xmlHttp.open("POST",URL,true);
	xmlHttp.send(null);  
}


function calMe(){
	document.getElementById('unChkALL').style.display='none';
}
function checkAll(){
 	for(i=0; i<document.forms[0].elements.length; i++){ 
		 if (document.forms[0].elements[i].type == "checkbox"){
		  	document.forms[0].elements[i].checked = true;
		 }
	 }
	 document.getElementById('chkALL').style.display='none';
	 document.getElementById('unChkALL').style.display='inline';
	 document.getElementById('All').value='yes';
}

function clearAll(){
  for(i=0; i<document.forms[0].elements.length; i++){ 
		 if (document.forms[0].elements[i].type == "checkbox"){
		  	document.forms[0].elements[i].checked = false;
		 }
	 }
	  document.getElementById('chkALL').style.display='inline';
	  document.getElementById('unChkALL').style.display='none';
	  document.getElementById('All').value='';
}

function getHabs(){ 
	var len=document.getElementById('count').value; 
  	var mcodes="00";  
    for(var i=0; i<len; i++){   	 
	 	  if(document.getElementById('divisionCode['+i+']').checked ==true){ 
		     mcodes=mcodes+"<>"+document.getElementById('divisionCode['+i+']').value;
		  }
	  }	 
	document.getElementById('selectedMcodes').value=mcodes;
    document.forms[0].action="switch.do?prefix=/proposals&page=/PickAdminHabitation.do";
    document.forms[0].submit();
}

function AjaxFun(destinationname){
	var txt = document.getElementById("divisionss");
	var selectDivision = "false";
	for(i=0;i<txt.length;i++){
		if(txt.options[i].selected==true){
			selectDivision="true"
		}		
	}
	if(selectDivision=="true"){
		var coc = <%=coc%>;
		var form = document.forms[0];
		var txt = document.getElementById("divisionss");
		var s ="substr(office_code,2,2)="+coc+" and (";
		for(i=0;i<txt.length;i++){
			if(txt.options[i].selected==true){
				s+="substr(office_code,4,1)="+txt.options[i].value+" or ";
			}			
		}
		var postData = generatePreviewData(form);
		var openRequest = getAjaxRequest();
		var urll = "/pred/proposals/getLabs.jsp?divisions="+s;
		openRequest.open("POST",urll,false);
		postData=s;
		openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		openRequest.send(postData);
		document.getElementById("labs1").innerHTML="<select name=labs multiple size=10 class=hightlongcombo>"+openRequest.responseText+"</select>";
	}
	else{
		alert("Select Division to Get Labs");
	}
}

function generatePreviewData(form) {
	var postData ="divisions="+form.divisionss.value;
	return(postData); 
} 

function getAjaxRequest(){
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
		catch (error){
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

<logic:notEmpty name="divisions">

<table width="90%" cellspacing="0" cellpadding="2" border="0" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block" align="center">
<tr><td align="center"><font size="3" face="verdana"><b>Select Divisions & Labs</b></font></td></tr>
<tr>
<td>
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000">
<tr><td width="25%" align=center><FONT size="2" face="verdana"><b>Divisions</b></FONT></td><td width="5%">&nbsp;</td><td width="70%"  align=center><FONT size="2" face="verdana"><b>Lab : Lab Code-LabName-Location</b></FONT></td></tr>


<%int i=0;
%>
<tr>
<td>
<select name="divisionss" multiple size="10" class="hightcombo">
<c:forEach items="${divisions}" var="item" varStatus="status">
	<option value="<c:out value='${item.divisionCode}'/>""><c:out value="${item.divisionName}" /></option>
</c:forEach>
</select>
</td>
<td>
<input type="button" value="Get Labs>>>" onClick="AjaxFun('habs')">
</td>
<td id="labs1">
<select name="labs" multiple size="10" class="hightlongcombo">
</select>
</td>
</td>
</tr>
</td>
</tr>
</table>
<font color="red">*</font><font face="verdana" size="2">To Select Multiple Divisions and Labs use CTRL Button</font>
</td>
</tr>
<input type="hidden" name="count" value="<%=i++%>" />
</table>
<input type="hidden" name="proposalId" value="<c:out value='${habitations[0].proposalId}'/>">
<br>
<center>
	<html:button property="mode" value="Add Labs" styleClass="btext" onclick="carryLabs()"/>
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:notEmpty>

<logic:empty name="divisions">
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
var habs = frm.elements("selectedLabCode");
if(habs)
{
	if(typeof habs.length != 'number')
		habs = [habs];
	
	for(var i=0; i<habs.length; i++)
	{
		<c:forEach items="${tempSelectedLabs}" var="item">
			if(habs[i].value == '<c:out value="${item.labCode}" />')
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
 String[] mcodes=(String[])session.getAttribute("L_"+request.getParameter("proposalId"));
//System.out.println("Lenght"+mcodes.length);
for(int i=0;i<mcodes.length;i++)
{
 %>
 <script>
	var len=document.getElementById('count').value;
	for(var i=0;i<len;i++)
	{
	var mcode=document.getElementById('divisionCode['+i+']').value;
	if(mcode==<%=mcodes[i]%>)
	  {
	   document.getElementById('divisionCode['+i+']').checked=true;
	  }
	}
 </script>
<%}
}
catch(Exception e){} %>

 