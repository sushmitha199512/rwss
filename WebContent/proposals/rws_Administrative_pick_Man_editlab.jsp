<%@ page buffer="16kb" autoFlush="true"%>
<%@ include file="/commons/rws_header1.jsp" %>
 
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
{ 
var len=document.getElementById('count').value;
 
  var mcodes="00";
  
    for(var i=0; i<len; i++)
	{   
	 
	 	  if(document.getElementById('districtCode['+i+']').checked ==true)
		  { 
		     mcodes=mcodes+"@"+document.getElementById('districtCode['+i+']').value;
		  }
	  }
 
	document.getElementById('selectedMcodes').value=mcodes;
  document.forms[0].action="switch.do?prefix=/proposals&page=/AddRemoveAdminHabs.do&mode=addRemoveHabs";
  document.forms[0].submit();
}
</script>
</head>

<body method="post"leftmargin="0" topmargin="0" bgcolor="#edf2f8" onload="calMe()">

<html:form action="SaveAdminHabitation" onsubmit="return fnAdd(this)">
<input type="hidden" name="selectedMcodes" value="">
<input type="hidden" name="All" value="">
<input type="hidden" name="proposalId" value="<%=request.getParameter("proposalId")%>"/>
<input type="hidden" name="coc" value="<%=(String)request.getParameter("coc")%>"/>
<input type="hidden" name="index" value="<%=request.getParameter("index") %>"  />
<input type="hidden" name="mode" value=""/>
<input type="hidden" name="officeCode" value="<%=request.getParameter("officeCode") %>"  />

<logic:notEmpty name="districts">

<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
<th colspan=2>Select Districts To Add Labs</th>
</tr>
<tr bgcolor="#8A9FCD">
	<th align="center" id="chkALL"> <input type="checkbox" name="selectAll" onclick="checkAll()" title="Check to select All Districts"></th>
	<th align="center" id="unChkALL"> <input type="checkbox" name="selectAll" onclick="clearAll()" title="Check to Clear All Districts"></th>
	
	<th>Districts</th>
	 
</tr>
</thead>
<tbody class="gridText">
<%int i=0; %>
<c:forEach items="${districts}" var="item" varStatus="status">
<tr>
	<td align="center">
		<input type="checkbox" name="districtCode[<%=i++%>]" 
			   value="<c:out value='${item.districtCode}' />"/>
	</td>
	 
	<td align="left">
		<b><c:out value="${item.districtName}" /></b>
	</td>
	 
</tr>
</c:forEach>
<input type="hidden" name="count" value="<%=i++%>" />
</tbody>
</table>
<input type="hidden" name="proposalId" value="<%=request.getParameter("proposalId")%>">
<br>
<center>
	<html:button property="mode" value="Next" styleClass="btext" onclick="getHabs()"/>
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:notEmpty>

<logic:empty name="districts">
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
//alert(habs);
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
//System.out.println("LenghtTTTTTTTTTT"+mcodes.length);
for(int i=0;i<mcodes.length;i++)
{
	//System.out.println(mcodes[i]);
 %>
 <script>
	var len=document.getElementById('count').value;                  
	for(var i=0;i<len;i++)
	{
	var mcode=document.getElementById('districtCode['+i+']').value;
	if(mcode==<%=mcodes[i]%>)
	  {
	   document.getElementById('districtCode['+i+']').checked=true;
	  }
	}
 </script>
<%}
}
catch(Exception e){} %>