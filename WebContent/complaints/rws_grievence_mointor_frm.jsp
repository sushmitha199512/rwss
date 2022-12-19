<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script>
  function fngo()
  {
	  
	  if(document.forms[0].work[0].checked)
	  {
	  document.location.href="switch.do?prefix=/proposals&page=/citizenrep.do&mode=data&mode1=";
	  }
	  else if(document.forms[0].work[1].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/Complaints.do&mode=data&special=reset";
	  }
	  else if(document.forms[0].work[2].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/Complaintstatus.do&mode=get2&special=reset";
	  }
	   else if(document.forms[0].work[3].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/Complaintstatusgeneric.do&mode=get2&special=reset";
	  }
	  else if(document.forms[0].work[4].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/Complaintattended.do&mode=get2&special=reset";
	  }
	  else if(document.forms[0].work[5].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/Complaintattendedgeneric.do&mode=get2&special=reset";
	  }
	  else if(document.forms[0].work[6].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/TotalComplaints.do&mode=get2&special=reset";
	  }
	  else if(document.forms[0].work[7].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/TotalComplaintsgeneric.do&mode=get2&special=reset";
	  }
	  else if(document.forms[0].work[8].checked)
	  {
	  document.location.href="switch.do?prefix=/complaints&page=/ComplaintNo.do&mode=get2";
	  }
    

  }
</script>
<html>
<form method="get">
<body>
<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" >
	<tr><td class="mycborder">
<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Grievance Monitoring System" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
 <table bgcolor="#DEE3E0" border="1" bordercolor="8A9FCD" rules="none"  style="border-collapse:collapse"  width="100%">
	<tr>
	<td class="rptvalue"><input type="radio" name="work" onclick="fngo()">Requisition for New Scheme</td>
	</tr>
	<tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Greivance Entry ( For Existing Assets )</font></td>
	</tr>
	<tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Grievance Status for Existing Assets </font></td>
	</tr>
	<tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Generic Grievance Status  </font></td>
	</tr>
	<tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Grievance Attended ( Existing Assets )</font></td>
	</tr>
	<tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Generic Grievance Attended ( Generic )</font></td>
	</tr>
	<tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Grievance Report ( For Existing Assets )</font></td>
	</tr>
	<tr>
	<td  class="rptvalue"><input type="radio" name="work" onclick="fngo()"><font face="verdana">Generic Grievance Report</font></td>
	</tr>
	
	

	
  </table>
  <jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
	</table>
	</body>
</form>  
