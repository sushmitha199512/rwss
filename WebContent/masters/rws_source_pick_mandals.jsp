<%@ page buffer="16kb" autoFlush="true"%>
<%@ include file="/commons/rws_header1.jsp" %>
 <%
 String sourcecode=(String)session.getAttribute("sourcecode");
 
 System.out.println("sourceCode in pick mandals"+sourcecode);
 

 
 %>
<script language="JavaScript">
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
{ //alert("1");
	
	var len=document.getElementById('count').value;
	 //alert("len"+len);
	  var mcodes="00";
	  
	    for(var i=0; i<len; i++)
		{   
		
		 	  if(document.getElementById('mandal['+i+']').checked ==true)
			  { 
			     mcodes=mcodes+"@@"+document.getElementById('mandal['+i+']').value;
			  }
		  }
	 
		document.getElementById('selectedMcodes').value=mcodes;
		var sourceCode=document.getElementById('sourceCode').value
		
        // alert("sourceCode"+sourceCode);
		 
	    document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do?mode=pickhabs";
	 //   alert("document.forms[0].action"+document.forms[0].action);
	    document.forms[0].submit();
		
}
</script>
</head>

<body method="post"leftmargin="0" topmargin="0" bgcolor="#edf2f8" onload="calMe()">
<form name="PickHabitation" method="post">
<input type="hidden" name="selectedMcodes" value="">
<input type="hidden" name="All" value="">
<input type="hidden" name="type" value="<%=request.getParameter("type")%>"/>
<input type="hidden" name="sourceCode" value="<%=request.getParameter("sourceCode")%>"/>
<input type="hidden" name="index" value="<%=request.getParameter("index") %>"  />
<input type="hidden" name="mode" value=""/>
<input type="hidden" name="officeCode" value="<%=request.getParameter("officeCode") %>"  />

<logic:notEmpty name="mandals1">

<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
<th colspan=2>Select Mandals To Add/Remove Habitations</th>
</tr>
<tr bgcolor="#8A9FCD">
	<th align="center" id="chkALL"> <input type="checkbox" name="selectAll" onclick="checkAll()" title="Check to select All Mandals"></th>
	<th align="center" id="unChkALL"> <input type="checkbox" name="selectAll" onclick="clearAll()" title="Check to Clear All Mandals"></th>
	
	<th>Mandals</th>
	 
</tr>
</thead>
<tbody class="gridText">
<%int i=0; %>
<c:forEach items="${mandals1}" var="item" varStatus="status">
<tr>
	<td align="center">
		<input type="checkbox" name="mandal[<%=i++%>]" 
			   value="<c:out value='${item.value}'  />"/>
	</td>
	 
	<td align="left">
		<b><c:out value="${item.label}" /></b>
	</td>
	 
</tr>
</c:forEach>
<input type="hidden" name="count" value="<%=i++%>" />
</tbody>
</table>
<input type="hidden" name="proposalId" value="<c:out value='${habitations[0].proposalId}'/>">
<br>
<center>
	<html:button property="mode" value="Next" styleClass="btext" onclick="getHabs()"/>
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:notEmpty>

<logic:empty name="mandals1">
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
</form>
</body>
</html>
<%try{
 java.util.ArrayList mcodes=(java.util.ArrayList)request.getAttribute("SanctionedHabs");
 
for(int i=0;i<mcodes.size();i++)
{
String mcode=((String)mcodes.get(i)).substring(5,7);
 %>
 <script>
	var len=document.getElementById('count').value;
	
	for(var i=0;i<len;i++)
	{
	var mcode=document.getElementById('mandalCode['+i+']').value;
	   
	if(mcode==<%=mcode%>)
	  { 
	   document.getElementById('mandalCode['+i+']').checked=true;
	  }
	}
 </script>
<%}
}
catch(Exception e){
	//System.out.println("Exception:"+e);
} %>

 