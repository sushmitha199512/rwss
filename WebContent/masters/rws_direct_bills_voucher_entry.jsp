<style type="text/css">
div.transboxss
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
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<%
	String query = null;
	int workCount = 1;
	String expWork = (String) session.getAttribute("expWork");
%>
<html>

<body bgcolor="#edf2f8">
<html:form  action="bills.do?mode=ExpVoucher" enctype="multipart/form-data"  onsubmit="return validateWorkForm(this)" >
<input type="hidden" name="workId" value='<bean:write property="assetName" name="DirectBillsForm"/>'>
<table border = 0 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=100%>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Direct Vouchers Details" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	     border=1 style="border-collapse:collapse;" width="100%">
		<td class="bwborder" >
		<fieldset>
		<legend  >
		<B>Voucher Details</B>
		</legend>
		<label>
		<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse" align="center">
   		<tr>
		<td class=rptValue colspan=22>
		Vouchers for the <b>Work ID</b> : <font color=red><bean:write property="assetName" name="DirectBillsForm"/> </font>
		 and <b>Work Name: <font color=red><bean:write property="newsrcName" name="DirectBillsForm"/></font>
		</td>
		</tr>
		<tr>
			<thead class="gridHeader" >
			 	<th>Select</th>
				<th>S.No.</th>
				<th>Bills<font color=red>*</font></th>
				<th>Payment Admissable <BR> fot this Bill</th>
				
				<th>Program<font color=red>*</font></th>
				<th>Contractor<font color=red>*</font></th>
				<th>Fund Distribution<font color=red>*</font></th>
				<th>M Book No<font color=red>*</font></th>
				<th>Recorded By<font color=red>*</font></th>
				<th>Recorded Date<font color=red>*</font></th>
				<th>Check Measured By<font color=red>*</font></th>
				<th>Check Measured Date<font color=red>*</font></th>
				<th>Super Check <BR> Measured By<font color=red>*</font></th>
				<th>Super Check <BR> Measured Date<font color=red>*</font></th>
			 	<th>Voucher No<font color=red>*</font></th>
				<th>Voucher Date<font color=red>*</font></th>
				<th>Voucher Amount<BR>(In Rupees)<font color=red>*</font></th>
			 	<th>Cheque No<font color=red>*</font></th>
				<th>Cheque Date<font color=red>*</font></th>
				<th>Remarks<font color=red>*</font></th>
		</thead>
		</tr>
		<tbody>
		<%
try
{
%>
	<logic:present name="vouchersList">
		<nested:iterate id="VOUCHER_LIST" name="vouchersList" indexId="ndx">
		
	<tr>
		
		<td><input type="checkbox" name="remove" value="<%= ndx%>"></td>
		
		<td class=rptValue><%= workCount++%></td>
		
		<td>
			<nested:select name="VOUCHER_LIST" property="billSlNo" indexed="true" style="width: 105px" styleClass="noborder-text-box" onchange='<%= "getBillInfo(" + ndx + ")" %>' >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="bills">
				<html:options collection="bills" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td nowrap >
		<div id="load<%= workCount-2%>" align="center" style="display:none"><img src="<%=request.getContextPath()%>/images/loading.gif"/></div>
		<nested:text name="VOUCHER_LIST" property="paymentAdmissable" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/></td>
		
		<td>
			<nested:select name="VOUCHER_LIST" property="progCode" indexed="true" style="width: 105px" styleClass="noborder-text-box" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="programs">
				<html:options collection="programs" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td>
			<nested:select name="VOUCHER_LIST" property="contCode" indexed="true" style="width: 135px" styleClass="noborder-text-box" >
			<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="contractors">
				<html:options collection="contractors" property="value" labelProperty="label" />
				</logic:present>
			<html:option value="other">Other Contractor</html:option>
			</nested:select>
		</td>
		<td>
			<nested:select name="VOUCHER_LIST" property="budgetInfo" indexed="true" style="width: 105px" styleClass="noborder-text-box" >
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<html:option value="GF">General Fund</html:option>
				<html:option value="SCP">SCP</html:option>
				<html:option value="TSP">TSP</html:option>				
			</nested:select>
		</td>
		
		<td nowrap ><nested:text name="VOUCHER_LIST" property="sno" indexed="true" style="width: 120px" styleClass="noborder-text-box" maxlength="28"/></td>
		<td>
			<nested:select name="VOUCHER_LIST" property="empCodeRecorded" indexed="true" style="width: 225px" styleClass="noborder-text-box" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="employeesRecBy">
				<html:options collection="employeesRecBy" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td nowrap  onmouseover="Tip('Please Enter Vouchers in Recorded Date Order',TITLE,'')" onmouseout="UnTip()"><nested:text name="VOUCHER_LIST" property="recordedDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<a href="javascript: showCalendar(document.getElementById('VOUCHER_LIST[<%= ndx%>].recordedDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"  onmouseover="Tip('Please Enter Vouchers in Recorded Date Order',TITLE,'')" onmouseout="UnTip()"></a></td>
		<td>
			<nested:select name="VOUCHER_LIST" property="empCode" indexed="true" style="width: 225px" styleClass="noborder-text-box"><!-- onchange='<%= "compareWithPrevious(" + ndx + ")" %>' -->
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="employeesCheckMeasuredBy">
				<html:options collection="employeesCheckMeasuredBy" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td nowrap><nested:text name="VOUCHER_LIST" property="checkMesuaredDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<a href="javascript: showCalendar(document.getElementById('VOUCHER_LIST[<%= ndx%>].checkMesuaredDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
		<td>
			<nested:select name="VOUCHER_LIST" property="empCodeSuper" indexed="true" style="width: 225px" styleClass="noborder-text-box" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="employeesSuperCheckMeasuredBy">
				<html:options collection="employeesSuperCheckMeasuredBy" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td nowrap><nested:text name="VOUCHER_LIST" property="superCheckMesuaredDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<a href="javascript: showCalendar(document.getElementById('VOUCHER_LIST[<%= ndx%>].superCheckMesuaredDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>

		<td onmouseover="Tip('Voucher Number Should Be Unique for Each Work',TITLE,'')" onmouseout="UnTip()"><nested:text name="VOUCHER_LIST" property="voucherNo" indexed="true" maxlength="28" style="width: 120px" styleClass="noborder-text-box" onchange='<%= "compareWithPrevious1(" + ndx + ")" %>'/></td>
		<td nowrap><nested:text name="VOUCHER_LIST" property="voucherDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<a href="javascript: showCalendar(document.getElementById('VOUCHER_LIST[<%= ndx%>].voucherDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
		
		<td onmouseover="Tip('Voucher Amount Should be in Rupees',TITLE,'')" onmouseout="UnTip()"><nested:text name="VOUCHER_LIST" property="voucherAmount" indexed="true" maxlength="11" style="width: 120px" styleClass="noborder-text-box" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" onblur='<%= "compareBillAmt(" + ndx + ")" %>' onchange='<%= "compareBillAmt(" + ndx + ")" %>'/></td><!-- onkeyup='<%= "compareExp(" + ndx + ")" %>' onchange='<%= "compareExp(" + ndx + ")" %>' -->
		
		<td><nested:text name="VOUCHER_LIST" property="chequeNo" indexed="true" maxlength="28" style="width: 120px" styleClass="noborder-text-box"/></td>
		<td nowrap><nested:text name="VOUCHER_LIST" property="chequeDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<a href="javascript: showCalendar(document.getElementById('VOUCHER_LIST[<%= ndx%>].chequeDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
		<td><nested:textarea name="VOUCHER_LIST" property="checkMesuaredRemarks" indexed="true" cols="5" style="width: 120px" styleClass="noborder-text-box"/></td>
	</tr>
		</nested:iterate>
	</logic:present>
<%	
}catch(Exception e){}
%>
<tr bgcolor="#ffffff">
	<td colspan=13 align=left>
		<Div id="OptionsDiv111" class="transboxss" style="display:none;">
					<p align=center>
					<font face=verdana size=2 color=blue>Please Select Last Voucher Date<BR>in the Last Financial Year</font><BR>
					<input type="text" name="lastRecDate" class="mytext" readonly>
							<a href="javascript: showCalendar(document.forms[0].lastRecDate);"><img src="/pred/resources/images/calendar.gif" border="0" align="absmiddle"></a>
					<br>
					<input type="button" name="aaa" value="Continue>>" onClick="addNewPrevVoucher()" class="btext">
					<BR>
					<a href="#" onclick="javascript:document.getElementById('OptionsDiv111').style.display='none'">Hide</a>
					</p>
				</Div>
	</td>
</tr>
<tr bgcolor="#ffffff">
	<td colspan=22 align=left>
	<%if(request.getParameter("disabled1")!=null && !request.getParameter("disabled1").equals("") && request.getParameter("disabled1").equals("Y"))
	{%>
	<input type="button" name="workCount" value="Add Last Fin.Year Voucher" class="bText" onClick="showDivs();" disabled="true" title="You can enter one Bill at a time"/>
	<%}else{%>
	<input type="button" name="workCount" value="Add Last Fin.Year Voucher" class="bText" onClick="showDivs();"/>
	<%}%>
	<%if(request.getParameter("disabled")!=null && !request.getParameter("disabled").equals("") && request.getParameter("disabled").equals("Y"))
	{%>
	<input type="button" name="workCount" value="Add New" class="bText" onclick="addNewVoucher();" disabled="true" title="You can enter one Voucher at a time"/>
	<%}else{%>
	<input type="button" name="workCount" value="Add New" class="bText" onclick="addNewVoucher();"/>
	<%}%>
	<input type="button" name="workCount" value="Remove" class="bText" onclick="removeVoucher()"/>
	</td>
</tr>
<tr bgcolor="#ffffff">
	<td colspan=22 align=right>
	<%if(workCount!=1){%>
		<input type="button" name="save" value="Save Vouchers" class="bText" onclick="saveAllVouchers()"/>
	<%}
	else
	{
	%>
		<input type="button" name="save" value="Save Vouchers" class="bText" onclick="saveAllVouchers()" disabled="true"/>
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
		document.getElementById('OptionsDiv111').style.display='block';
	}
	else
	{
		if(zeroExistsOrNot)
			alert("You cannot Add Last Financial Related Voucher Again, It Should be Once for a Work");
		else
			alert("You cannot Add Last Financial Related Voucher, It Should be the First Entry");
	}
}
function getBillInfo(i)
{
	//alert(i);
	var billNo = document.getElementById("VOUCHER_LIST["+i+"].billSlNo").value;
	//alert(billNo);
	var url="/pred/masters/getDirectBillDetails.jsp?workId="+document.forms[0].workId.value+"&bill="+billNo;
	//alert(url + "-------" + i);
	ajaxFunction(url,i);
}
function ajaxFunction(URL,i)
{ 
	if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
	var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function()
	{
	  if(xmlHttp.readyState==4)
	  {
		//alert(xmlHttp.responseText);
		document.getElementById('load'+i).style.display='none';
		var mytool_array=xmlHttp.responseText.split("/");
		//alert(mytool_array[0]);
		//alert(mytool_array[1]);
		document.getElementById("VOUCHER_LIST["+i+"].paymentAdmissable").value = mytool_array[0];
		document.getElementById("VOUCHER_LIST["+i+"].billVoucherAmount").value = mytool_array[1];
	  }
	  else{
		  document.getElementById('load'+i).style.display='block';
	  }
	}
	xmlHttp.open("POST",URL,true);
	xmlHttp.send(null);  
}
function compareWithPrevious(i)
{
	if(i>=1)
	{
		var j = i-1;
		dt1=getDateObject(document.getElementById("VOUCHER_LIST["+i+"].recordedDate").value,"/");
		dt2=getDateObject(document.getElementById("VOUCHER_LIST["+j+"].recordedDate").value,"/");
	//	alert(dt1);
	//	alert(dt2);
		if(dt1<dt2)
		{
			alert("Recorded Date("+document.getElementById("VOUCHER_LIST["+i+"].recordedDate").value+") for S.No:"+(i+1)+" Should Greater than or Equals to Recorded Date("+document.getElementById("VOUCHER_LIST["+j+"].recordedDate").value+") for S.No:"+(j+1));
			document.getElementById("VOUCHER_LIST["+i+"].recordedDate").value = '';
			document.getElementById("VOUCHER_LIST["+i+"].empCode").value = '';
			document.getElementById("VOUCHER_LIST["+i+"].recordedDate").focus();
		}
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
				v1 = document.getElementById("VOUCHER_LIST["+i+"].voucherNo").value;
				v2 = document.getElementById("VOUCHER_LIST["+j+"].voucherNo").value;
				if(v1==v2)
				{
					alert("Voucher No("+v1+") for S.No:"+(i+1)+" Should Not Equals the Voucher No("+v2+") for S.No:"+(j+1));
					document.getElementById("VOUCHER_LIST["+i+"].voucherNo").value = '';
					document.getElementById("VOUCHER_LIST["+i+"].voucherNo").focus();
					break;
				}
			}
		}
	}
}
function compareBillAmt(i)
{
	
	var wCount = '<%=workCount%>';
	var totExp = 0;
	if(isNaN(document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").value) || document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").value=="")
	{
		exp = 0;
	}
	else
	{
		exp = document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").value;
	}
	totExp = parseFloat(exp);
	var expWorks = parseFloat(document.getElementById("VOUCHER_LIST["+i+"].paymentAdmissable").value);
	if(parseFloat(expWorks)==parseFloat(totExp))
	{
	}
	if((parseFloat(expWorks)>parseFloat(totExp)) && totExp!=""){
		alert("Voucher Amount: "+totExp+" Rs.  Not Match the Balance Amount of Bill: "+expWorks+" Rs.");
		document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").value = '';
		document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").focus();	
	}
	if(parseFloat(expWorks)<parseFloat(totExp) ){
		alert("Voucher Amount: "+totExp+" Rs.  Should nobe Execed Balance Amount of Bill: "+expWorks+" Rs.");
		document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").value = '';
		document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").focus();
	}
}
function addNewVoucher()
{
	var wCount = '<%=workCount%>';
	if(wCount > 1)
	{
		for(var i=0;i<wCount-1;i++)
		{
			var status = makeCompulsory(i);
			if(status==true)
			{
				var statuss = compareAllDates1(i);
			}
		}
		if(status == true && statuss == true)
		{
			var url = "./switch.do?prefix=/masters&page=/bills.do&mode=addnewVoucherContract&disabled=Y";
			document.forms[0].action=url;
			document.forms[0].submit();
		}
	}
	else
	{
		//alert("=1");
		var url = "./switch.do?prefix=/masters&page=/bills.do&mode=addnewVoucherContract&disabled=Y";
		document.forms[0].action=url;
		document.forms[0].submit();
	}
}
function addNewPrevVoucher()
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
			dt1.setFullYear(2013,2,31);
			dt2=getDateObject1(document.forms[0].lastRecDate.value,"/");
			//dt2.setFullYear(dt2.getYear(),dt2.getMonth()-1,dt2.getDate()-1);
			if(dt1<=dt2)
			{
				alert("Last Recorded Date Should be in Last Financial Year");
			}
			else
			{
				var url = "./switch.do?prefix=/masters&page=/bills.do&mode=addnewVoucherPrevContract&disabled1=Y&recDate="+document.forms[0].lastRecDate.value;
				document.forms[0].action=url;
				document.forms[0].submit();
			}
		}
		else
		{
			alert("Cumulative Bill for Last Financial Year should be the First Bill");
		}
	}
}
function makeCompulsory(i)
{
	
	if(document.getElementById("VOUCHER_LIST["+i+"].billSlNo").value=="")
	{
		alert("Please Select Bill for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].billSlNo").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].progCode").value=="")
	{
		alert("Please Select Program for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].progCode").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].contCode").value=="0")
	{
		alert("Please Select Contractor for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].contCode").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].budgetInfo").value=="")
	{
		alert("Please Select Fund Distribution for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].budgetInfo").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].sno").value=="")
	{
		alert("Please Enter MBook No for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].sno").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].empCodeRecorded").value=="")
	{
		alert("Please Select Recorded By for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].empCodeRecorded").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].recordedDate").value=="")
	{
		alert("Please Select Recorded Date for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].recordedDate").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].empCode").value=="")
	{
		alert("Please Select Check Measured By for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].empCode").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].checkMesuaredDate").value=="")
	{
		alert("Please Select Check Mesuared Date for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].checkMesuaredDate").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].empCodeSuper").value=="")
	{
		alert("Please Enter Super Check Measured By for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].empCodeSuper").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].superCheckMesuaredDate").value=="")
	{
		alert("Please Enter Super Check Measured Date for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].superCheckMesuaredDate").focus();
		return false;
	}
	
	else if(document.getElementById("VOUCHER_LIST["+i+"].voucherNo").value=="")
	{
		alert("Please Enter Voucher No for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].voucherNo").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].voucherDate").value=="")
	{
		alert("Please Select Voucher Date for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].voucherDate").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").value=="")
	{
		alert("Please Enter Voucher Amount for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].chequeNo").value=="")
	{
		alert("Please Enter Cheque No for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].chequeNo").focus();
		return false;
	}
	
	else if(document.getElementById("VOUCHER_LIST["+i+"].chequeDate").value=="")
	{
		alert("Please Enter Check Date for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].chequeDate").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].checkMesuaredRemarks").value=="")
	{
		alert("Please Enter Remarks for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].checkMesuaredRemarks").focus();
		return false;
	}
	
	else
	{
		return true;
	}
}
function compareAllDates(i,j)
{
	alert(i+"-"+j);
	dt1=getDateObject(document.getElementById("VOUCHER_LIST["+i+"].voucherDate").value,"/");
	dt2=getDateObject(document.getElementById("VOUCHER_LIST["+j+"].voucherDate").value,"/");

	dt3=getDateObject(document.getElementById("VOUCHER_LIST["+i+"].chequeDate").value,"/");
	dt4=getDateObject(document.getElementById("VOUCHER_LIST["+j+"].chequeDate").value,"/");

	if(dt1>dt2)
	{
		alert("Voucher Date("+document.getElementById("VOUCHER_LIST["+j+"].voucherDate").value+") for S.No:"+(j+1)+" Should Not Less than Voucher Date("+document.getElementById("VOUCHER_LIST["+i+"].voucherDate").value+") for S.No:"+(i+1));
		return false;
	}
	/*else if(dt3>dt4)
	{
		alert("Cheque Date("+document.getElementById("VOUCHER_LIST["+j+"].chequeDate").value+") for S.No:"+(j+1)+" Should Not Less than Cheque Date("+document.getElementById("VOUCHER_LIST["+i+"].chequeDate").value+") for S.No:"+(i+1));
		return false;
	}*/
	else
	{
		return true;
	}
}
function compareAllDates1(i)
{
	//alert("compareAllDates1:"+i);
	dt1 = getDateObject(document.getElementById("VOUCHER_LIST["+i+"].recordedDate").value,"/");
	dt2 = getDateObject(document.getElementById("VOUCHER_LIST["+i+"].checkMesuaredDate").value,"/");
	dt3 = getDateObject(document.getElementById("VOUCHER_LIST["+i+"].voucherDate").value,"/");
	dt4 = getDateObject(document.getElementById("VOUCHER_LIST["+i+"].chequeDate").value,"/");
	dt5=getDateObject(document.getElementById("VOUCHER_LIST["+i+"].superCheckMesuaredDate").value,"/");

	if(dt1>dt2)
	{
		alert("Check Measurement Date("+document.getElementById("VOUCHER_LIST["+i+"].checkMesuaredDate").value+") for S.No:"+(i+1)+" Should be greater than or Equal to Recorded  Date("+document.getElementById("VOUCHER_LIST["+i+"].recordedDate").value+") for S.No:"+(i+1));
		return false;
	}
	else if(dt2>dt3)
	{
		alert("Voucher Date("+document.getElementById("VOUCHER_LIST["+i+"].voucherDate").value+") for S.No:"+(i+1)+" Should be greater than or Equal to Check Measurement Date  Date("+document.getElementById("VOUCHER_LIST["+i+"].checkMesuaredDate").value+") for S.No:"+(i+1));
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].superCheckMesuaredDate").value!="")
	{
		if(dt2>dt5)
		{
			alert("Super Check Measurement Date ("+document.getElementById("VOUCHER_LIST["+i+"].superCheckMesuaredDate").value+") for S.No:"+(i+1)+" Should be greater than or Equal to Check Measurement  Date("+document.getElementById("VOUCHER_LIST["+i+"].checkMesuaredDate").value+") for S.No:"+(i+1));
			return false;
		}
		else
		{
			return true;
		}
	}
	else
	{
		return true;
	}
}
function removeVoucher()
{
	var wCount = '<%=workCount%>';
	var selectCount = getSelectedCount();
	if(selectCount>0)
	{
		if(parseInt(selectCount)==parseInt(wCount)-1)
		{
			if(confirm("Are You Sure to Remove All the Voucher(s)"))
			{
				document.forms[0].action="./switch.do?prefix=/masters&page=/bills.do&mode=removeVoucherContract";
				document.forms[0].submit();
			}
		}
		else
		{
			document.forms[0].action="./switch.do?prefix=/masters&page=/bills.do&mode=removeVoucherContract";
			document.forms[0].submit();
		}
	}
	else
	{
		alert("Please Select Atleast one Voucher to Remove");
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

	//extract day portion
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	
	//extract month portion				
	endPos=dateString.indexOf(sepChar,curPos+1);			cMonth=dateString.substring(curPos+1,endPos);

	//extract year portion				
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	
	//Create Date Object
	dtObject=new Date(cYear,cMonth,cDate);	
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

	//extract day portion
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	
	//extract month portion				
	endPos=dateString.indexOf(sepChar,curPos+1);			cMonth=dateString.substring(curPos+1,endPos);

	//extract year portion				
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	
	//Create Date Object
	dtObject=new Date(cYear,cMonth-1,cDate);	
	return dtObject;
}


function saveAllVouchers()
{
	var wCount = '<%=workCount%>';
	var totExp = 0;
	var billSlNo='';
	if(wCount > 1)
	{
		for(var i=0;i<wCount-1;i++)
		{
			billSlNo= document.getElementById("VOUCHER_LIST["+i+"].billSlNo").value;
			//alert(billSlNo);
			var status = makeCompulsory(i);
			if(status==true)
			{
				var statuss = compareAllDates1(i);
			}
			//alert(document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").value);
			totExp = totExp + parseFloat(document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").value);
		}
		if(status == true && statuss == true)
		{
			if(confirm("The Voucher(s) Amount Should be in Rupees \n  Press CANCEL to Confirm otherwise \n Press OK to continue anyway"))
			{
				var url = "./switch.do?prefix=/masters&page=/bills.do&mode=saveVouchersContract&billSlNo="+billSlNo;
				document.forms[0].save.disabled=true;
				document.forms[0].save.value='Saving .... Please Wait';
				document.forms[0].action=url;
				document.forms[0].submit();
			}
		}
	}
	else
	{
		alert("Please Enter Atleast One Voucher");
	}
}
</script>
<p align="left">
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;Note****: 
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. Vouchers Should Enter in Chronological Order By Recorded Date
</font>
<BR>
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. Recorded By List Contains </font><font face=verdana size=2 color=blue>"AE,AEE,DEE"</font><font face=verdana size=2 color=red> Employess in that District 
</font>
<BR>
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. Check Measured By List Contains </font><font face=verdana size=2 color=blue>"DEE,EE"</font><font face=verdana size=2 color=red> Employess in that District 
</font>
<BR>
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. Super Check Measured By List Contains </font><font face=verdana size=2 color=blue>"EE and Above"</font><font face=verdana size=2 color=red> Employess in that District 
</font>
<BR>
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5. Voucher Amount Should be in Rupees 
</font>
</p>
</html:form>
<%@ include file = "/commons/rws_footer.jsp" %>
<%@ include file = "/commons/rws_alert.jsp" %>
</body>
</html>