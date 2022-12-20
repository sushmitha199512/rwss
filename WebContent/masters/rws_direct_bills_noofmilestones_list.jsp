<%@ include file="/commons/rws_SpecialHeader.jsp" %>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<html>
<head>

<%String workId = request.getParameter("workId");%>
</head>
<body bgcolor="#edf2f8">
<html:form  action="bills.do?mode=ExpVoucher" enctype="multipart/form-data"  onsubmit="return validateWorkForm(this)" >
<table border = 0 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=100%>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
		
		<% int workInProgressCount=0;%>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	     border=1 style="border-collapse:collapse;" width="100%">
		<td class="bwborder" >
		<fieldset>
		<legend  >
		<B>Mile Stone Details</B>
		</legend>
		<label>	<label>
			<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			<tr  bgcolor="#8A9FCD">
				<td align="center"><font face=verdana size=1><b>Milestone<br>S.No.</b></font></td>
				<td align="center"><font face=verdana size=1><b>Major Milestone</b></font></td>
				<td align="center"><font face=verdana size=1><b>Mile Stone<br>(Major Component)</b></font></td>
				<td align="center"><font face=verdana size=1><b>Stage <br>(Type of Item)</b></font></td>
				<td align="center"><font face=verdana size=1><b>Component No<br>(No of Items)</b></font></td>
				<td align="center"><font face=verdana size=1><b>Target Date</b></font></td>
				<td align="center"><font face=verdana size=1><b>Quantity to be executed </b></font></td>
				<td align="center"><font face=verdana size=1><b>Component No<br>(Executed)</b></font></td>
				<td align="center"><font face=verdana size=1><b>Achievement Date</b></font></td> 
				<td align="center"><font face=verdana size=1><b>Quantity executed So far</b></font></td>
				<td align="center"><font face=verdana size=1><b>Physical Stage</b></font></td>
			</tr>
			
 			   <% workInProgressCount=0;%>
				<nested:iterate id="WORK" property="mileStones" indexId="ndx">
				<%System.out.println("in side");%>
			 	  <%workInProgressCount++;%>
			 	  <tr bgcolor="#ffffff">
				<td>
 					<nested:text name="WORK" property="mileStoneSno" indexed="true" style="width: 20px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
 					<nested:text name="WORK" property="majorMileStone" indexed="true" style="width: 20px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="mstoneName" indexed="true" style="width: 120px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="mstoneStageName" indexed="true" style="width: 120px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="compInNo" indexed="true" style="width: 30px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="targetDate" indexed="true" style="width: 70px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="perCompInWorkValue" indexed="true" style="width: 80px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="compInNoAch" indexed="true" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" maxlength="5" style="width: 80px" styleClass="noborder-text-box" />
				</td>
				<td nowrap>
					<nested:text name="WORK" property="achievementDate" indexed="true"  maxlength="100" style="width: 80px" styleClass="noborder-text-box" readonly="true"/>
				</td>
				<td>
					<nested:text name="WORK" property="perCompValue" indexed="true" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" maxlength="5" style="width: 80px" styleClass="noborder-text-box" />
				</td>
				<td>
					<nested:text name="WORK" property="budgetInfo" indexed="true" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" maxlength="5" style="width: 80px" styleClass="noborder-text-box" />
				</td>
				<nested:hidden name="WORK"  indexed="true"  property="mstoneCode"/>
				<nested:hidden name="WORK"  indexed="true"  property="mstoneStageCode"/>
				<td>
				
				</td>
				</tr>
				</nested:iterate> 		 
				</table>
				<INPUT type="button" name="voucher" value='Add/Update/Remove Vouchers' class="btext" onClick='openVoucher()'>
				</table>
<jsp:include page="/commons/TableFotter2.jsp">
<jsp:param name="TWidth" value="100%"/>
<jsp:param name="msg" value="Amount Should be in Rupees" />
</jsp:include>
<script>
function openVoucher()
{
	var workName = '<%=request.getParameter("workName")%>';
	var workIdd = '<%=request.getParameter("workId")%>';
	
			var zURL = "./switch.do?prefix=/masters&page=/bills.do&mode=ExpVoucherContractor&workId="+workIdd+"&workName="+workName;
			var popFeatures = "width=995,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=150";
			myWin = window.open(zURL,'habss',popFeatures);
			myWin.focus();
	
}
</script>
</html:form>
<%@ include file = "/commons/rws_footer.jsp" %>
<%@ include file = "/commons/rws_alert.jsp" %>
</body>
</html>