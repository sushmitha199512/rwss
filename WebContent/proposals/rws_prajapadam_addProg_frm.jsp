  <%@ include file="/commons/rws_header1.jsp" %>
 
  <SCRIPT LANGUAGE="JavaScript">
 function addProgram()
 {
  
  var prog=document.getElementById('programme').value;
  if(prog!='')
  {
   document.forms[0].action="switch.do?prefix=/proposals&page=/prajapadam.do?mode=addProg";
   document.forms[0].submit();
  }
  else
  {
  alert("Programme Name Should Not Be Empty");
  }
 
 }
  
 function calme()
 {
    
   opener.document.forms[0].action="switch.do?prefix=/proposals&page=/prajapadam.do?mode=refresProg";
   opener.document.forms[0].submit();
   window.close();
 }
  
</SCRIPT>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
 
 
<body  onUnload="calme()">
<html:form  action="prajapadam.do?mode=data" enctype="multipart/form-data" >
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" align="center"
	   width="100%" border=1 style="border-collapse:collapse;" >
	<tr class="mystyle" >
	<td>Programme  Name : </td><td><html:text property="programme" maxlength="30" size="30"/></td>
	</tr>
	<tr>
	<td align="center" colspan=2><html:button property="mode" onclick="addProgram()" value="Add" styleClass="btext"/></td>
	</tr>
</table>

</html:form> 
</body>
<%@ include file="/commons/rws_alert.jsp"%> 

