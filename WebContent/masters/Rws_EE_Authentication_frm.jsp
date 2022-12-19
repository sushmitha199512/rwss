<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp" %>

<%int count = 1;
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	String ad=(String)session.getAttribute("userId");
	System.out.println("user:"+ad);
%>
<head>
<style type="text/css"> 
<!--
.style1 {color: #FF0000;
font-family: verdana;
font-size: 13px;}
-->
</style>

<style type="text/css">
  .checkboxWrapper {
    position: relative;
  }
  .checkboxOverlay {
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
  }
</style>
<script>
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



</script>
</head>

<html:form action="/eeAuthentication.do">
<body onload="checkMe()">
<table width="100%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;</a>

</td></tr>
<tr></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="EE's Digital Signature Information for Approval" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD">
<td align="center">
</td>
</tr>
<tr >
	<td class="btext" align="center" rowspan="2">S.No.</td>
	<td class="btext" align="center" rowspan="2">Circle</td>	  
	<td class="btext" align="center" rowspan="2">Division</td>
	<td class="btext" align="center" rowspan="2">EE PAO Code</td>
	<td class="btext" align="center" rowspan="2">EE Name</td>
	<td class="btext" align="center" colspan="5" >Token Registration Details</td>
	<td class="btext" align="center" rowspan="2">Approved ON</td>
	<td class="btext" align="center" rowspan="2">Approve</td>
		
	</tr>
	<tr>
	
	<td class="btext" align="center">Issuer</td><td class="btext" align="center">Token Holder</td><td class="btext" align="center">Serial NO</td><td class="btext" align="center">Valid From</td><td class="btext" align="center">Valid To</td>
	</tr>
	<nested:iterate id="EELIST" name="eeauthenticationForm" property="eeList"  indexId="ndx">
	<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
		<td class="rptValue"><%=count++%></td>
		<td  class="rptValue" ><bean:write name="EELIST" property="cirlceName" /></td>
		<td  class="rptValue" ><bean:write name="EELIST" property="divName" /></td>
		<nested:hidden name="EELIST" property="eePaoCode"  indexed="true"/>
		<td class="rptValue"><bean:write name="EELIST" property="eePaoCode" /></td>
		<td  class="rptValue" ><bean:write name="EELIST" property="eeName" /></td>
		<td  class="rptValue" ><bean:write name="EELIST" property="issuer" /></td>
		<td  class="rptValue" ><bean:write name="EELIST" property="tokenHolder" /></td>
		<td  class="rptValue" ><bean:write name="EELIST" property="tokenSerailNo" /></td>
		<td  class="rptValue" ><bean:write name="EELIST" property="validFrom" /></td>
		<td  class="rptValue" ><bean:write name="EELIST" property="validTo" /></td>
		<td  class="rptValue" ><bean:write name="EELIST" property="approvedOn" /></td>
		<td  class="rptValue" align="center"><html:checkbox name="EELIST" property="checks"  onclick='<%= "check(" + ndx + ")" %>' indexed="true"/>
		</td>
	</tr>
</nested:iterate>
<%if(count==1)
{
%><tr><td colspan="13" align="center" class="btext">No Records</td></tr><%}
else{%><tr><td colspan="14" align="center"><input type=button value=Save onClick="fnSave();" class="btext"></td></tr><%}%>
<input type="hidden" name="resultCount" value="<%=count%>">

</table>
</body>

<script>
function fnSave(){
var selectedEES='';
    var len=document.eeauthenticationForm.resultCount.value;
	len = len-1;
    var yes=0;    
	for( var i=0;i<len;i++)
	{     
			if(document.getElementById("EELIST["+i+"].checks").checked==true)
			 {
				selectedEES=selectedEES+","+document.getElementById("EELIST["+i+"].eePaoCode").value;
		     }
	}
	 // alert("selected EE's:"+selectedEES);
	  if(selectedEES=="")
	   {
		 alert("Select atleast one check box to save");
       }
	  else{
	
		  if(confirm("Are You Sure To Authenticate The Selected EE(s)")) {
			  document.forms[0].eeids.value = selectedEES;
              document.forms[0].action="switch.do?prefix=/masters&page=/eeAuthentication.do&mode=saveEES";
              document.forms[0].submit();
			}
	  }
}
</script>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>




<input type=hidden name=eeids>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</html:form>

<br>


