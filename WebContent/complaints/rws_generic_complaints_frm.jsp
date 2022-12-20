<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script>
  function fngo()
  {
	  
	  
	  if if(document.forms[0].work[0].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/Complaintsout.do&mode=data&special=reset";
	  }
	  else if(document.forms[0].work[1].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do&mode=get2&special=reset";
	  }
	  


  }
</script>
<html>
<form method="get">
<body>
<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" >
	<tr><td class="mycborder">
<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Greivance Monitoring Form" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
 <table bgcolor="#DEE3E0" border="1" bordercolor="8A9FCD" rules="none"  style="border-collapse:collapse"  width="100%">
	
	<tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Greivance for Existing Scheme</font></td>
	</tr>
	<tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Generic Complaints </font></td>
	</tr>
	
	
  </table>
  <jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
	</table>
	</body>
</form>  
