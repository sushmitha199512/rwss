<%@ include file="/commons/rws_header1.jsp" %>

<%@include file="/commons/rws_header4.jsp" %>

<script>
  function fngo()
  {
	  
	  
	
	   if(document.forms[0].work[0].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do&mode=get2&special=reset";
	  }
	  
	
	   else if(document.forms[0].work[1].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/ComplaintNogeneric.do&mode=get2&special=reset";
	  }
	  

  }
</script>
<html>
<form method="post">
<body>

<table align=center>
<tr><td></td><td align=right><a href="javascript:history.go(-1)">Back</a></td>
</tr>
</table>


<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" >
	<tr><td class="mycborder">
<jsp:include page="/commons/TableHeaderComplaints.jsp">
		<jsp:param name="TableName" value="Grievance Monitoring&nbsp;System&nbsp;&nbsp;&nbsp;" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
 <table bgcolor="#DEE3E0" border="1" bordercolor="8A9FCD" rules="none"  style="border-collapse:collapse"  width="100%">

	<!-- <tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Generic Grievance Entry</font></td>
	</tr> -->
	
	
	<tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Know your Status of  Generic Grievance </font></td>
	</tr>







	
  </table>
  <jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
	</table>
	</body>
</form>  
