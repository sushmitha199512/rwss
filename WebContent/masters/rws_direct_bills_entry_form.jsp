<style type="text/css">
div.transboxs
{
  width:250px;
  left:10px;
  background-color:#D6DCD9;
  border:1px solid black;
  filter:alpha(opacity=140);
  opacity:1.5;
}
</style>
<%@ include file="/commons/rws_SpecialHeader.jsp" %>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
%>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<%
	String query = null;
	int workCount = 1;
	// session.removeAttribute("aaa");
	Collection cc = new ArrayList();
	
	Collection c = new ArrayList();
	
%>
<html>
<head>

</head>
<body bgcolor="#edf2f8" onload="fnCal2()">
<html:form  action="bills.do?mode=ExpVoucher" enctype="multipart/form-data"  onsubmit="return validateWorkForm(this)" >
<table border = 0 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=100%>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	     border=1 style="border-collapse:collapse;" width="100%">
		<td class="bwborder" >
		<fieldset>
		<legend  >
		<B>Bill Details</B>
		</legend>
		<label>
		<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse" align="center">
   		<tr>
		<td class=rptValue colspan=13>
		Bills for the <b>Work : <font color=red><bean:write property="assetName" name="DirectBillsForm"/> - <bean:write property="newsrcName" name="DirectBillsForm"/></b></font>
		</td>
		</tr>
		<tr align="center">
				<td colspan="7" class="btext">Current Bill Details<font color=red>*</font></td>
<td colspan="2" class="btext">Cumulative Bill Details<font color=red>*</font></td>				
<td colspan="3" class="btext">Payment Details<font color=red>*</font></td>				

		</tr>
		<tr align="center">
			<td class="btext">Select</td>
			<td class="btext">S.No.</td>
			<td class="btext">Bill No<font color=red>*</font></td>
			<td class="btext">Bill Date<font color=red>*</font></td>			
			<td class="btext">Bill Amount <BR>(In Rupees)<font color=red>*</font></td>
			<td class="btext">Bill Amount<br>As per Pay Order<br>(In Rupees)<font color=red>*</font></td>				
			<td class="btext">Gross Value   <BR> upto this Bill</td>
			<td class="btext">Gross Value <BR>As per Pay Order  upto this Bill</td>			
			<td class="btext">Amount Paid<BR>Through Vouchers</td>
			<td class="btext">Amount to be Paid<BR>Through Vouchers<BR>(5)</td>
		</tr>
		<tr align="center">
			<td class="btext">1</td>
			<td class="btext">2</td>
			<td class="btext">3</td>
			<td class="btext">4</td>
			<td class="btext">5</td>
			<td class="btext">6</td>
			<td class="btext">7</td>
			<td class="btext">8</td>
			<td class="btext">9</td>
			<td class="btext">10</td>
			
		</tr>
		<tbody>
		<%
try
{
	int snoo = 1;
%>
	<logic:present name="vouchersList">
		<nested:iterate id="VOUCHER_LIST" name="vouchersList" indexId="ndx">
		<bean:define id="billSlNo" scope="request">   
               <nested:write name="VOUCHER_LIST" property="billSlNo"/>  
		 </bean:define>   

 
	<tr>
			<%if(userid!=null && (userid.equals("admin") || userid.equals("100000"))) {
			if(cc.contains(billSlNo)){
				//System.out.println("in jsp value:::"+billSlNo);
				%>
			<td onmouseover="Tip('<b>This Bill Already Forwarded by Your EE-Budget (or) Payment already made</b>',TITLE,'')" onmouseout="UnTip()">
			<input type="checkbox" disabled name="remove" value="<%= billSlNo%>"></td>
			<%}else{%>
			<td onmouseover="Tip('<b>This Bill can be EDITED/DELETED</b>',TITLE,'')" onmouseout="UnTip()">
			<input type="checkbox" name="remove" value="<%= billSlNo%>"></td>
			<%}
			}else{%>
			<%
			if(cc.contains(billSlNo)){%>
			<td onmouseover="Tip('<b>This Bill Already Forwarded by Your EE-Budget (or) Payment already made</b>',TITLE,'')" onmouseout="UnTip()">
			<input type="checkbox" disabled name="remove" value="<%= billSlNo%>"></td>
			<%}else if(c.contains(billSlNo)){%>
			<td onmouseover="Tip('<b>This Bill Already Forwarded by Your EE</b>',TITLE,'')" onmouseout="UnTip()">
			<input type="checkbox" disabled name="remove" value="<%= billSlNo%>"></td>
			<%}else{%>
			<td onmouseover="Tip('This Bill can be EDITED/DELETED',TITLE,'')" onmouseout="UnTip()">
			<input type="checkbox" name="remove" value="<%= billSlNo%>"></td>
			<%}}%>
		<%workCount++;%>
		<nested:hidden name="VOUCHER_LIST" property="billSlNo" indexed="true"/>
		<td class=rptValue><input type="text" name="billSlNoo" style="width:50px" class="noborder-text-box" readonly="true" value="<%=snoo++%>"/></td>
		<td>
			<nested:text name="VOUCHER_LIST" property="billNo" indexed="true"  styleClass="noborder-text-box" onchange='<%= "compareWithPrevious1(" + ndx + ")" %>' onkeypress="upperOnly()"/>
		</td>
		<td nowrap>
			<nested:text name="VOUCHER_LIST" property="billDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		</td>
			
		<td>
		<nested:text name="VOUCHER_LIST" property="grossValueContractor" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" onchange='<%= "compareWithPrevious(" + ndx + ")" %>' onkeyup='<%= "return fnCal1(" + ndx + ")" %>' readonly="true"/></td>

		<td ><nested:text name="VOUCHER_LIST" property="grossValueAdmissable" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)"  onkeyup='<%= "return fnCal1(" + ndx + ")" %>' /></td>

		<td ><nested:text name="VOUCHER_LIST" property="grossValuePaidTotal" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box" readonly="true"/></td>
		<td ><nested:text name="VOUCHER_LIST" property="grossValueOfBill" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  readonly="true" /></td>
		<td><nested:text name="VOUCHER_LIST" property="billVoucherAmount" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  readonly="true" /></td>
		<td><nested:text name="VOUCHER_LIST" property="paymentInHand" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  readonly="true" /></td>
		
		</tr>
		</nested:iterate>
	</logic:present>
<%	
}catch(Exception e){}
%>
<tr bgcolor="#ffffff">
	<td colspan=13 align=left>
		<Div id="OptionsDiv11" class="transboxs" style="display:none;">
					<p align=center>
					<font face=verdana size=2 color=blue>Please Select Last Recorded Date<BR>in the Last Financial Year</font><BR>
					<input type="text" name="lastRecDate" class="mytext" readonly>
							<a href="javascript: showCalendar(document.forms[0].lastRecDate);"><img src="/pred/resources/images/calendar.gif" border="0" align="absmiddle"></a>
					<br>
					<input type="button" name="aaa" value="Continue>>" onClick="addNewPrevBill()" class="btext">
					<BR>
					<a href="#" onclick="javascript:document.getElementById('OptionsDiv11').style.display='none'">Hide</a>
					</p>
				</Div>
	</td>
</tr>
<tr bgcolor="#ffffff">
	<td colspan=13 align=left>
		<Div id="OptionsDiv111" class="transboxs" style="display:none;">
					<p align=center>
					<font face=verdana size=2 color=blue>Please Select Bill Date</font><BR>
					<input type="text" name="billDatee" class="mytext" readonly>
							<a href="javascript: showCalendar(document.forms[0].billDatee);"><img src="/pred/resources/images/calendar.gif" border="0" align="absmiddle"></a>
					<br>
					<input type="button" name="aaa" value="Continue>>" onClick="addNewBill()" class="btext">
					<BR>
					<a href="#" onclick="javascript:document.getElementById('OptionsDiv111').style.display='none'">Hide</a>
					</p>
				</Div>
	</td>
</tr>
<tr bgcolor="#ffffff">
	<td colspan=13 align=left>
		<Div id="OptionsDiv1111" class="transboxs" style="display:none;">
					<p align=center>
					<font face=verdana size=2 color=blue>Please Select Bill Date</font><BR>
					<input type="text" name="finalBillDate" class="mytext" readonly>
							<a href="javascript: showCalendar(document.forms[0].finalBillDate);"><img src="/pred/resources/images/calendar.gif" border="0" align="absmiddle"></a>
					<br>
					<input type="button" name="aaa" value="Continue>>" onClick="addNewFinalBill()" class="btext">
					<BR>
					<a href="#" onclick="javascript:document.getElementById('OptionsDiv1111').style.display='none'">Hide</a>
					</p>
				</Div>
	</td>
</tr>
<tr bgcolor="#ffffff">
	<td colspan=13 align=left>
	<%if(request.getParameter("disabled1")!=null && !request.getParameter("disabled1").equals("") && request.getParameter("disabled1").equals("Y"))
	{%>
	<input type="button" name="workCount" value="Add Last Fin.Year Bill" class="bText" onClick="showDivs();" disabled="true" title="You can enter one Bill at a time"/>
	<%}else{%>
	<input type="button" name="workCount" value="Add Last Fin.Year Bill" class="bText" onClick="showDivs();"/>
	<%}%>

	<%if(request.getParameter("disabled")!=null && !request.getParameter("disabled").equals("") && request.getParameter("disabled").equals("Y"))
	{%>
	<input type="button" name="workCount" value="Add New" class="bText" onClick="addNewBill();" disabled="true" title="You can enter one Bill at a time"/>
	<input type="button" name="workCount" value="Add Withheld Bill" class="bText" disabled="true" title="You can enter one Bill at a time"/>
	<%}else{%>
	<input type="button" name="workCount" value="Add New" class="bText" onClick="showDivs1();"/>
	<%if(workCount-1>0){%>
	<input type="button" name="workCount" value="Add Withheld Bill" class="bText" onClick="showDivs2();"/>
	<%}else{%>
	<input type="button" name="workCount" value="Add Withheld Bill" disabled="true" class="bText" onClick="showDivs2();"/>
	<%}}%>

	<input type="button" name="workCount" value="Remove" class="bText" onClick="removeBill()"/>
	</td>
</tr>
<tr bgcolor="#ffffff">
	<td colspan=13 align=center>
	<%if(workCount!=1){%>
		<input type="button" name="save" value="Save Bills" class="bText" onClick="saveAllBills()"/>
	<%}
	else
	{
	%>
		<input type="button" name="save" value="Save Bills" class="bText" onClick="saveAllBills()" disabled="true"/>
	<%
	}%>
	</td>
</tr>
</tbody>
</table>
 </label>
</fieldset>
</td></tr>
</table>
<jsp:include page="/commons/TableFotter2.jsp">
<jsp:param name="TWidth" value="100%"/>
<jsp:param name="msg" value="Amount Should be in Rupees" />
</jsp:include>
<script language="JavaScript">
function showDivs()
{
	var wCount = '<%=workCount%>';
	var zeroExistsOrNot = false;
	for(var j=0;j<wCount-1;j++)
	{
		if(document.getElementById("VOUCHER_LIST["+j+"].billSlNo").value=="0")
		{
			zeroExistsOrNot = true;
		}
	}
	if(parseInt(wCount)==1)
	{
		document.getElementById('OptionsDiv11').style.display='block';
	}
	else
	{
		if(zeroExistsOrNot)
			alert("You cannot Add Last Financial Related Bill Again, It Should be Once for a Work");
		else
			alert("You cannot Add Last Financial Related Bill, It Should be the First Entry");
	}
}
function showDivs1()
{
	var wCount = '<%=workCount%>';
	var zeroExistsOrNot = false;
	document.getElementById('OptionsDiv111').style.display='block';
}
function showDivs2()
{
	var wCount = '<%=workCount%>';
	var zeroExistsOrNot = false;
	if(confirm("Are You Sure to Enter Withheld Bill")){
	document.getElementById('OptionsDiv1111').style.display='block';
	}
}
function compareWithPrevious1(i)
{
	if(i>=1)
	{
		var wCount = '<%=workCount%>';
		for(var j=0;j<wCount-1;j++)
		{
			if(i!=j)
			{
				v1 = document.getElementById("VOUCHER_LIST["+i+"].billNo").value.toUpperCase();
				v2 = document.getElementById("VOUCHER_LIST["+j+"].billNo").value.toUpperCase();
				if(v1==v2)
				{
					alert("Bill No("+v1+") for S.No:"+(i+1)+" Should Not Equals the Bill No("+v2+") for S.No:"+(j+1));
					document.getElementById("VOUCHER_LIST["+i+"].billNo").value = '';
					document.getElementById("VOUCHER_LIST["+i+"].billNo").focus();
					break;
				}
				var vv1 = document.getElementById("VOUCHER_LIST["+i+"].billDate").value;
				var vv2 = document.getElementById("VOUCHER_LIST["+j+"].billDate").value;
				if(vv1==vv2)
				{
					alert("Only One Bill Allowed for each Day \n Bill Date("+vv1+") for S.No:"+(i+1)+" Should Not Equals the Bill Date("+vv2+") for S.No:"+(j+1));
					document.getElementById("VOUCHER_LIST["+i+"].billDate").value='';
					document.getElementById("VOUCHER_LIST["+i+"].billDate").focus();
					break;	
				}
			}
		}
	}
}
function compareBillDates()
{
	var wCount = '<%=workCount%>';
	var retVal = '0';
	for(var i=0;i<wCount-1;i++)
	{
		var j = wCount-2;
		var v1 = document.getElementById("VOUCHER_LIST["+j+"].billDate").value;
		var v2 = document.getElementById("VOUCHER_LIST["+i+"].billDate").value;
		if(v1==v2)
		{
			alert("Only One Bill Allowed for each Day \n Bill Date("+v1+") for S.No:"+(i+1)+" Should Not Equals the Bill Date("+v2+") for S.No:"+(j+1));
			document.getElementById("VOUCHER_LIST["+j+"].billDate").focus();
			retVal = 1;
			break;			
		}
	}
	if(retVal=="0")
		return true;
	else if(retVal=="1")
		return false;		
}
function fnCal1(i)
{	
	var wCount = '<%=workCount%>';
	var val1 = parseFloat(document.getElementById("VOUCHER_LIST["+i+"].grossValueContractor").value);
	var val2 = parseFloat(document.getElementById("VOUCHER_LIST["+i+"].grossValueAdmissable").value);
	var val3 = parseFloat(document.getElementById("VOUCHER_LIST["+i+"].grossValuePaidTotal").value);
	var val4 = parseFloat(document.getElementById("VOUCHER_LIST["+i+"].grossValueOfBill").value);
//	var val5 = parseFloat(document.getElementById("VOUCHER_LIST["+i+"].grossValuePaid").value);
	//var val6 = parseFloat(document.getElementById("VOUCHER_LIST["+i+"].paymentAdmissable").value);

	if(isNaN(val1))
	{
		val1 = '0';
	}
	if(isNaN(val2))
	{
		val2 = '0';
	}
	if(val1<val2)
	{
		alert("Gross Value of Admissable upto this Bill Date("+val2+" Rs.) for S.No:"+(i+1)+" Should Not Greater than Gross Value of Contractor upto this Bill Date ("+val1+" Rs.) for S.No:"+(i+1));
		//document.getElementById("VOUCHER_LIST["+i+"].grossValueContractor").value = '0';
		document.getElementById("VOUCHER_LIST["+i+"].grossValueAdmissable").value = '0';
	}
	var vall1 = 0;var vall2 = 0;
	for(var j=0;j<wCount-1;j++)
	{
		vall1 += parseFloat(document.getElementById("VOUCHER_LIST["+j+"].grossValueContractor").value);
		vall2 += parseFloat(document.getElementById("VOUCHER_LIST["+j+"].grossValueAdmissable").value);
	}
	document.getElementById("VOUCHER_LIST["+i+"].grossValuePaidTotal").value= vall1;
	document.getElementById("VOUCHER_LIST["+i+"].grossValueOfBill").value= vall2;
	var vall3 = 0;
	for(var j=0;j<wCount-2;j++)
	{
		vall3 += parseFloat(document.getElementById("VOUCHER_LIST["+j+"].grossValueAdmissable").value);
	}
//	document.getElementById("VOUCHER_LIST["+i+"].grossValuePaid").value= vall3;
	//document.getElementById("VOUCHER_LIST["+i+"].paymentAdmissable").value=vall2-vall3 ;
document.getElementById("VOUCHER_LIST["+i+"].paymentInHand").value = parseFloat(document.getElementById("VOUCHER_LIST["+i+"].grossValueContractor").value)-parseFloat(document.getElementById("VOUCHER_LIST["+i+"].billVoucherAmount").value);
}
function fnCal2()
{	
	var wCount = '<%=workCount%>';
	for(var i=0;i<wCount-1;i++)
	{
		var vall1 = 0;var vall2 = 0;
		for(var j=0;j<=i;j++)
		{
			vall1 += parseFloat(document.getElementById("VOUCHER_LIST["+j+"].grossValueContractor").value);
			vall2 += parseFloat(document.getElementById("VOUCHER_LIST["+j+"].grossValueAdmissable").value);
		}
		var vall3 = 0;
		for(var j=0;j<i;j++)
		{
			vall3 += parseFloat(document.getElementById("VOUCHER_LIST["+j+"].grossValueAdmissable").value);
		}
		document.getElementById("VOUCHER_LIST["+i+"].grossValuePaidTotal").value= vall1;
		document.getElementById("VOUCHER_LIST["+i+"].grossValueOfBill").value= vall2;
//		document.getElementById("VOUCHER_LIST["+i+"].grossValuePaid").value= vall3;
	//	document.getElementById("VOUCHER_LIST["+i+"].paymentAdmissable").value=vall2-vall3;
		document.getElementById("VOUCHER_LIST["+i+"].paymentInHand").value = parseFloat(document.getElementById("VOUCHER_LIST["+i+"].grossValueContractor").value)-parseFloat(document.getElementById("VOUCHER_LIST["+i+"].billVoucherAmount").value);
	}
}
function compareWithPrevious(i)
{
	if(document.getElementById("VOUCHER_LIST["+i+"].billDate").value=="")
	{
		alert("Please Enter Bill Date");
		document.getElementById("VOUCHER_LIST["+i+"].billDate").value = '';
		document.getElementById("VOUCHER_LIST["+i+"].grossValueContractor").value = '';
		document.getElementById("VOUCHER_LIST["+i+"].billDate").focus();
	}
	else
	{
		if(i>=1)
		{
			var j = i-1;
			dt1=getDateObject1(document.getElementById("VOUCHER_LIST["+i+"].billDate").value,"/");
			dt2=getDateObject1(document.getElementById("VOUCHER_LIST["+j+"].billDate").value,"/");
			if(dt1<dt2)
			{
				alert("Bill Date ("+document.getElementById("VOUCHER_LIST["+i+"].billDate").value+") for S.No:"+(i+1)+" Should Greater than or Equals to Bill Date("+document.getElementById("VOUCHER_LIST["+j+"].billDate").value+") for S.No:"+(j+1));
				document.getElementById("VOUCHER_LIST["+i+"].billDate").value = '';
				document.getElementById("VOUCHER_LIST["+i+"].grossValueContractor").value = '';
				document.getElementById("VOUCHER_LIST["+i+"].billDate").focus();
			}
		}
	}
}
function addNewPrevBill()
{
	var wCount = '<%=workCount%>';
	if(document.forms[0].lastRecDate.value==null || document.forms[0].lastRecDate.value=="")
	{
		alert("Please Select Last Recorded Date to Generate Previous Financial Year Bill");
	}
	else
	{
		if(wCount == 1)
		{
			var dt=new Date();
			var dt1=new Date();
			
			dt1.setFullYear(2013,02,31);

			dt2=getDateObject(document.forms[0].lastRecDate.value,"/");
			//dt2.setFullYear(dt2.getYear(),dt2.getMonth(),dt2.getDate());

			if(dt2<=dt1)
			{
				var url = "./switch.do?prefix=/masters&page=/bills.do&mode=addNewPrevBill&slNo=0&disabled1=Y&recDate="+document.forms[0].lastRecDate.value+"&workId="+document.forms[0].workId.value;
				document.forms[0].action=url;
				document.forms[0].submit();	
			}
			else
			{
				alert("Last Recorded Date Should be in Last Financial Year");
				
			}
		}
		else
		{
			alert("Cumulative Bill for Last Financial Year should be the First Bill");
		}
	}
}
function addNewBill()
{
	var wCount = '<%=workCount%>';
	var sllNo = "1";
	if(document.forms[0].billDatee.value==null || document.forms[0].billDatee.value=="")
	{
		alert("Please Select Bill Date to Generate Current Financial Year Bill");
	}
	else
	{
		var dt=new Date();
			var dt1=new Date();
			dt1.setFullYear(2013,2,31);
			dt2=getDateObject(document.forms[0].billDatee.value,"/");
			//dt2.setFullYear(dt2.getYear(),dt2.getMonth()-1,dt2.getDate()-1);
			if(dt1>=dt2)
			{
				alert("Current Finanical Year Bill Date Should be greater than 31.03.2013");
			}
			else
			{
				if(wCount > 1)
				{
					var snos = new Array();
					for(var i=0;i<wCount-1;i++)
					{
						snos[i] = parseInt(document.getElementById("VOUCHER_LIST["+i+"].billSlNo").value);
						var status = makeCompulsory(i);
						sllNo = parseInt(document.getElementById("VOUCHER_LIST["+i+"].billSlNo").value)+1;
					}
					if(Math.max.apply( Math, snos )==0 || Math.max.apply( Math, snos)==1)
					{	sllNo = "2";}
					else
					{
						sllNo = Math.max.apply( Math, snos )+1;
					}
					if(status == true)
					{
						//alert("sllNoL:"+sllNo);
						var url = "./switch.do?prefix=/masters&page=/bills.do&mode=addNewBill&billNewDate="+document.forms[0].billDatee.value+"&slNo="+sllNo+"&disabled=Y&workId="+document.forms[0].workId.value;
						document.forms[0].action=url;
						document.forms[0].submit();
					}
				}
				else
				{
					//alert("=1");
					var url = "./switch.do?prefix=/masters&page=/bills.do&mode=addNewBill&billNewDate="+document.forms[0].billDatee.value+"&slNo="+wCount+"&disabled=Y&workId="+document.forms[0].workId.value;
					document.forms[0].action=url;
					document.forms[0].submit();
				}
			}	
	}
}
function addNewFinalBill()
{
	var wCount = '<%=workCount%>';
	var sllNo = "1";
	if(document.forms[0].finalBillDate.value==null || document.forms[0].finalBillDate.value=="")
	{
		alert("Please Select Bill Date to Generate Withheld Bill");
	}
	else
	{
		var dt=new Date();
			var dt1=new Date();
			dt1.setFullYear(2013,2,31);
			dt2=getDateObject(document.forms[0].finalBillDate.value,"/");
			//dt2.setFullYear(dt2.getYear(),dt2.getMonth()-1,dt2.getDate()-1);
			if(dt1>=dt2)
			{
				alert("Withheld Bill Date Should be greater than 31.03.2013");
			}
			else
			{
				if(wCount > 1)
				{
					var snos = new Array();
					for(var i=0;i<wCount-1;i++)
					{
						snos[i] = parseInt(document.getElementById("VOUCHER_LIST["+i+"].billSlNo").value);
						var status = makeCompulsory(i);
						sllNo = parseInt(document.getElementById("VOUCHER_LIST["+i+"].billSlNo").value)+1;
					}
					if(Math.min.apply( Math, snos )==0 || Math.min.apply( Math, snos)==1)
					{	sllNo = "-1";}
					else
					{
						sllNo = Math.min.apply( Math, snos )-1;
					}
					if(status == true)
					{
						//alert("sllNoL:"+sllNo);
						var url = "./switch.do?prefix=/masters&page=/bills.do&mode=addNewFinalBill&billNewDate="+document.forms[0].finalBillDate.value+"&slNo="+sllNo+"&disabled=Y&workId="+document.forms[0].workId.value;
						document.forms[0].action=url;
						document.forms[0].submit();
					}
				}
				else
				{
					//alert("=1");
					//alert("sllNoL:"+sllNo);
					var url = "./switch.do?prefix=/masters&page=/bills.do&mode=addNewBill&billNewDate="+document.forms[0].billDatee.value+"&slNo=-1&disabled=Y&workId="+document.forms[0].workId.value;
					document.forms[0].action=url;
					document.forms[0].submit();
				}
			}	
	}
}
function makeCompulsory(i)
{
	if(document.getElementById("VOUCHER_LIST["+i+"].billNo").value=="")
	{
		alert("Please Enetr Bill No for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].billNo").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].billDate").value=="")
	{
		alert("Please Select Bill Date for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].billDate").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].grossValueContractor").value=="" || document.getElementById("VOUCHER_LIST["+i+"].grossValueContractor").value=="0")
	{
		alert("Please Enter Bill Amount for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].grossValueContractor").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].grossValueAdmissable").value=="" || document.getElementById("VOUCHER_LIST["+i+"].grossValueAdmissable").value=="0")
	{
		alert("Please Enter Bill Amount As per Pay Order for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].grossValueAdmissable").focus();
		return false;
	}	
	else
	{
			return true;
	}
}
function removeBill()
{
	var wCount = '<%=workCount%>';
	var selectCount = getSelectedCount();
	if(selectCount>0)
	{
		if(selectCount>1)
		{
			alert("You can delete Only one bill At a time");
		}
		else
		{
			var value = prompt('Enter the Reasons to Delete the Bill*','');
			//alert(value);
			if(value==null || value=='')
			{
				alert("Remarks Mandatory to Delete the Bill");
			}
			else
			{	
				document.forms[0].remarks.value = value;
				document.forms[0].action="./switch.do?prefix=/masters&page=/bills.do&mode=removeBill&workId="+document.forms[0].workId.value;
				document.forms[0].submit();
			}
		}
	}
	else
	{
		alert("Please Select Atleast one Bill to Remove");
	}
}
function getSelectedCount()
{
	var count=0;
		for(i=0; i<document.forms[0].elements.length; i++)
		{
			if(document.forms[0].elements[i].type=="checkbox" && document.forms[0].elements[i].name=="remove" && document.forms[0].elements[i].checked)
			{
				count++;
			}
		}
		return(count);
}
function getDateObject(dateString,dateSeperator)
{
	//This function return a date object after accepting 
	//a date string ans dateseparator as arguments
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	var dtObject;
	var d;
	//extract day portion
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	//alert("d - -"+cDate);
	//extract month portion				
	endPos=dateString.indexOf(sepChar,curPos+1);
	cMonth=dateString.substring(curPos+1,endPos);
	//alert("M - - ->"+cMonth);
	//extract year portion				
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	//d = new Date();
	//alert("ssssssss ---"+d);
	dtObject=new Date(cYear,cMonth-1,cDate);
	//alert("f - ->"+dtObject);	
	return dtObject;
}

function getDateObject1(dateString,dateSeperator)
{
	//This function return a date object after accepting 
	//a date string ans dateseparator as arguments
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	var dtObject;
	var d;
	//extract day portion
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	//alert("d - -"+cDate);
	//extract month portion				
	endPos=dateString.indexOf(sepChar,curPos+1);
	cMonth=dateString.substring(curPos+1,endPos);
	//alert("M - - ->"+cMonth);
	//extract year portion				
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	//d = new Date();
	//alert("ssssssss ---"+d);
	dtObject=new Date(cYear,cMonth,cDate);
	//alert("f - ->"+dtObject);	
	return dtObject;
}

function saveAllBills()
{
	var wCount = '<%=workCount%>';
	var totExp = 0;
	if(wCount > 1)
	{
		var selectCount = getSelectedCount();
		if(selectCount>0)
		{
			for(var i=0;i<wCount-1;i++)
			{
				var status = makeCompulsory(i);
			}
			if(status == true)
			{
				if(wCount>2)
				{
					var status1 = true;//compareBillDates();
					if(status1==true)
					{
						if(confirm("The Bill(s) Amount Should be in Rupees \n  Press CANCEL to Confirm otherwise \n Press OK to continue anyway"))
						{
							var url = "./switch.do?prefix=/masters&page=/bills.do&mode=saveBills&workId="+document.forms[0].workId.value;
							document.forms[0].save.disabled=true;
							document.forms[0].save.value='Saving .... Please Wait';
							document.forms[0].action=url;
							document.forms[0].submit();
						}
					}
				}
				else
				{
					if(confirm("The Bill(s) Amount Should be in Rupees \n  Press CANCEL to Confirm otherwise \n Press OK to continue anyway"))
						{
							var url = "./switch.do?prefix=/masters&page=/bills.do&mode=saveBills&workId="+document.forms[0].workId.value;
							document.forms[0].save.disabled=true;
							document.forms[0].save.value='Saving ... Please Wait';
							document.forms[0].action=url;
							document.forms[0].submit();
						}
				}
			}
		}
		else
		{
			alert("Please Select Atleast one Bill to Save");
		}
	}
	else
	{
		alert("Please Enter Atleast One Voucher");
	}
}
</script>
<input type=hidden name=workId value=<%=request.getParameter("workId")%>>
<input type=hidden name=remarks>
</html:form>
<%@ include file = "/commons/rws_footer.jsp" %>
<%@ include file = "/commons/rws_alert.jsp" %>
</body>
</html>