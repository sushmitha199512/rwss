<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp" %>

<%int count = 1;
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	String ad=(String)session.getAttribute("userId");
	//System.out.println("user:"+ad);
%>
<head>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
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

<html:form action="/voucherForwardAction.do">
<body onload="checkMe()">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<table width="100%">
<!-- <tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;</a>

</td></tr> -->
<tr></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Voucher Approve For PAO Admissible Amount" />
	<jsp:param name="TWidth" value="1090" />
</jsp:include>

<table   border=1  width="1130" style="border-collapse:collapse"   >

<tr >
	<td class="btext" align="center" rowspan="2">S.No.</td>
	<td class="btext" align="center" rowspan="2">WorkID/<br></br>Work Name</td>
	
	<td class="btext" align="center" colspan="2" >Voucher Check Measurement Details</td>
	<td class="btext" align="center" colspan="2" >Bill Details</td>
	<td class="btext" align="center" rowspan="2">Voucher Amount</td>
	<td class="btext" align="center" rowspan="2">PAO In Admissible <br> Amount</td>
	<td class="btext" align="center" rowspan="2">Select For <br></br> Approve</td>
		
	</tr>
	<tr>
	
	<td class="btext" align="center">Check Measured By / <br></br>Check Measured Date</td><td class="btext" align="center">Super Check Measured By /<br></br>Super Check Measured Date</td>
	<td class="btext" align="center">Bill NO /<br>Bill Sl No </td>
	<td class="btext" align="center">Bill Amount Contractor /<br>Bill Amount Admissible </td>
	
	
	
	</tr>
	<nested:iterate id="vouchersList" name="voucherFWDForm" property="vouchersList"  indexId="ndx">
	<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
		<td class="rptValue"><%=count++%></td>
		<td class="rptValue"><html:hidden name="vouchersList" property="workId" indexed="true"></html:hidden><bean:write name="vouchersList" property="workId" /><br></br>
		<html:text name="vouchersList" property="workName"  style="width:120px" readonly="true" onmouseover="Tip(this.value,TITLE,'Work Name')"  onmouseout="UnTip()" />
		
		</td>
		<td  class="rptValue" ><bean:write name="vouchersList" property="checkMeasuredBy" /><br></br><bean:write name="vouchersList" property="checkMeasuredDate" /></td>
		<td  class="rptValue" ><bean:write name="vouchersList" property="superCheckMeasuredBy" /><br></br><bean:write name="vouchersList" property="superCheckMeasuredDate" /></td>
		<td  class="rptValue"  align="right"><bean:write name="vouchersList" property="billNo" />/<br></br>	<html:hidden name="vouchersList" property="billSlNo" indexed="true"></html:hidden><bean:write name="vouchersList" property="billSlNo" /></td>
		<td  class="rptValue"  align="right"><bean:write name="vouchersList" property="billAmountContractor" />/<br></br><bean:write name="vouchersList" property="billAmountAdmissible" /></td>
		
		
		<td  class="rptValue"  align="right"><bean:write name="vouchersList" property="voucherAmt" /></td>
		<td  class="rptValue" align="right" ><bean:write name="vouchersList" property="paoInAdmissible" /></td>
		<td  class="rptValue" align="center"><html:checkbox name="vouchersList" property="checks"  onclick='<%= "check(" + ndx + ")" %>' indexed="true"/>
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
var selectedVouchers="";
var len=document.forms[0].elements["resultCount"].value;
	len = len-1;
    var yes=0; var flag=false;   
	for( var i=0;i<len;i++)
	{     
		 
			if(document.getElementById("vouchersList["+i+"].checks").checked)
			 { 
				flag=true;
		     }
	}
	  if(!flag)
	   {
		 alert("Select atleast one check box to save");
       }
	  else{
	
		  if(confirm("Are You Sure To Approve the selected Vouchers For PAO Admissible Amount")) {
			 // document.forms[0].selectedRecords.value = selectedVouchers;
              document.forms[0].action="switch.do?prefix=/fundAccounting&page=/voucherForwardAction.do&mode=save";
              document.forms[0].submit();
			}
	  }
}
</script>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="1090"/>
</jsp:include>




<input type=hidden name="selectedRecords" >
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</html:form>

<br>


