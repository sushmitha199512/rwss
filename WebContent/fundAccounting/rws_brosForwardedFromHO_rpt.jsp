<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<%@ page import="nic.watersoft.fundAccounting.Rws_BroDetailsBean"%>
<%@ page import="nic.watersoft.fundAccounting.Rws_BroProgDetailsBean"%>
<%@ page import="nic.watersoft.fundAccounting.Rws_LocDetailsBean"%>
<%@ page import="nic.watersoft.fundAccounting.Rws_LocProgDetailsBean"%>


<script language="javascript">
function getLocDetails(broId)
{
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/broDetailsList.do&mode=getLocList&broId="+broId;
	document.forms[0].submit();
}
</script>

<%@ include file="/commons/rws_header2.jsp"%>
<html:form action="broDetailsList.do">
</html:form>
<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Bro Details List" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
</td>
</tr>
</thead>

<tfoot summary="Page footer with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody bgcolor="#DEE3E0">
<tr>
<td>
	<fieldset>
	<legend>List Of BRO's</legend>
	<label>
<%
 int sno=0;
   java.util.ArrayList list1=(java.util.ArrayList)request.getAttribute("broList");
  //System.out.println("list1 size:"+list1.size());
  
  java.util.ArrayList list2=(java.util.ArrayList)list1.get(0);
  java.util.ArrayList list3=(java.util.ArrayList)list1.get(1);
  java.util.ArrayList list4=(java.util.ArrayList)list1.get(2);
  java.util.ArrayList list5=(java.util.ArrayList)list1.get(3);
  //System.out.println("list2 size:"+list2.size());
  //System.out.println("list3 size:"+list3.size());
  //System.out.println("list4 size:"+list4.size());
   //System.out.println("list5 size:"+list5.size());

	%>
	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
	
	<tbody class="label">
	<%for(int i=0;i<list2.size();i++) {
		  Rws_BroDetailsBean broDetails=(Rws_BroDetailsBean)list2.get(i);
		%>
	<tr bgcolor="white">
		<td class=btext>&nbsp;
		 <%=++sno%>.&nbsp;&nbsp;
		<b>BRO ID:</b><%=broDetails.getBro_id()%>&nbsp;&nbsp;
		<b>BRO Reference: </b><%=broDetails.getBro_reference()%>&nbsp;&nbsp;
		<b>Financial Year:</b><%=broDetails.getBro_financialYear()%>	&nbsp;&nbsp;
		<b>Budget Estimate:</b><%=broDetails.getBro_budgetEstimate()%>	&nbsp;&nbsp;	
		<b>Sanction Amount:</b><%=broDetails.getBro_sanctionAmount()%>&nbsp;&nbsp;
		<b>BRO Amount:</b><%=broDetails.getBro_amount() %>&nbsp;&nbsp;		
		
	    <table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
		
		
		<tr><td class=rptValue>Sl.No</td>
				<td class=rptValue>Program</td>
				<td class=rptValue>SubProgram</td>
				<td class=rptValue>Head Of Account</td>
				<td class=rptValue>Budget Estimate</td>
				<td class=rptValue>Center/State</td>
				
		</tr>
		<tr>
		
		<%int count=0;
			for(int j=0;j<list3.size();j++) {
			
		Rws_BroProgDetailsBean	broProgDetails=(Rws_BroProgDetailsBean)list3.get(j);
			if(broDetails.getBro_id().equals(broProgDetails.getBroId()))
			{%>
			 <tr>
			 <td class=rptValue><font size=1 face=verdana><%=++count%></font></td>
			 <td class=rptValue><font size=1 face=verdana><%=broProgDetails.getProgrammeName()%></font></td>
			<td class=rptValue><font size=1 face=verdana><%=broProgDetails.getSubprogrammeName()%></font></td>
			<td class=rptValue><font size=1 face=verdana><%=broProgDetails.getHeadOfAccountName()%></font></td>
			<td class=rptValue><font size=1 face=verdana><%=broProgDetails.getBudgetEstimate()%></font></td>
			<%if(broProgDetails.getSelects().equals("C")){%>
			<td class=rptValue><font size=1 face=verdana>Center</font></td>
			<%}else if(broProgDetails.getSelects().equals("S")) {%>
				<td class=rptValue><font size=1 face=verdana>State</font></td>
			<%}else {%>
			<td class=rptValue><font size=1 face=verdana>-</font></td>
			<%}%>
			
			<tr>
			<%}%>
       
		<%}%>
		<tr><td colspan=7>&nbsp;</td></tr>
		<%int lcount=0;
			for (int k=0;k<list4.size();k++) {
			
			 Rws_LocDetailsBean locDetails=(Rws_LocDetailsBean)list4.get(k);
		//	System.out.println("broid:"+locDetails.getBroId());
			 if(broDetails.getBro_id().equals(locDetails.getBroId()))
			{%>
			<tr>
			 <td class=rptValue colspan=10><%=++lcount%>.</font>&nbsp;
			<b>Loc Id:</b><%=locDetails.getLocId()%></font>&nbsp;&nbsp;
			 <b>Loc Reference:</b><%=locDetails.getLocReference()%></font>&nbsp;&nbsp;
			  <b>Loc Date:</b><%=locDetails.getLocRelDate()%></font>&nbsp;&nbsp;
			  <b>Loc Amount:</b><%=locDetails.getLocAmount()%></font></td>&nbsp;&nbsp;
		
		 <table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
		
		
		<tr><td class=rptValue>Sl.No</td>
				<td class=rptValue>District</td>
		        <td class=rptValue>Program</td>
				<td class=rptValue>SubProgram</td>
				<td class=rptValue>Head Of Account</td>
				<td class=rptValue>Loc Date</td>
				<td class=rptValue>Loc Amount</td>
				
				
		</tr>
		<tr>
		<%int prcount=0,vbcount=0;
			for (int l=0;l<list5.size();l++) {
			
		  Rws_LocProgDetailsBean locProgDetails=(Rws_LocProgDetailsBean)list5.get(l);
		 // System.out.println("1111111111:"+locDetails.getLocId() + locDetails.getBroId());
		  //System.out.println("2222222222:"+locProgDetails.getLocId() + locProgDetails.getBroId());
		//if(locDetails.getLocId().equals(locProgDetails.getLocId()) && locDetails.getBroId().equals(locProgDetails.getBroId()) ) {
		 if((locDetails.getLocId() + locDetails.getBroId()).equals(locProgDetails.getLocId() + locProgDetails.getBroId())){
			//System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$:"+ ++vbcount);
			 if(locProgDetails.getBroId().equals(locDetails.getBroId())){
			%>
			
		<td class=rptValue><font size=1 face=verdana><%=++prcount%></font></td>
		<td class=rptValue><font size=1 face=verdana><%=locProgDetails.getDistrictName()%></font></td>
		<td class=rptValue><font size=1 face=verdana><%=locProgDetails.getProgramName()%></font></td>
		<td class=rptValue><font size=1 face=verdana><%=locProgDetails.getSubprogramName()%></font></td>
		<td class=rptValue><font size=1 face=verdana><%=locProgDetails.getHeadOfAccount()%></font></td>
		<td class=rptValue><font size=1 face=verdana><%=locProgDetails.getLocDate()%></font></td>
		<td class=rptValue align="right"><font size=1 face=verdana ><%=locProgDetails.getLocAmount()%></font></td>
		
		</tr>
		
		<%}}}%>
			  
		<%}%>
		</tbody>
	   <tfoot>
	<%}%>
		</tfoot><br>
	</table><br>
	<%}%>
	</label>
	</fieldset>
</td>
</tr>
</tbody>

</table>
<%@ include file="/commons/rws_tooltip.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>