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
<head>
 <html:javascript formName="WorkForm"/>
</head>
<body bgcolor="#edf2f8">
<html:form  action="WorkStatus.do?mode=ExpVoucher" enctype="multipart/form-data"  onsubmit="return validateWorkForm(this)" >
<table border = 0 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=100%>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Work Expenditures VS Vouchers Details" />
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
		<td class=rptValue colspan=18>
		Vouchers for the <b>Workkkkkkkkkkkkk</b> : <font color=red><bean:write property="assetName" name="WorkForm"/> - <bean:write property="newsrcName" name="WorkForm"/></font> and its <b>Expenditure:</b> <font color=red><bean:write property="habsCode" name="WorkForm"/>(In Lakhs)</font>
		</td>
		</tr>
		<tr>
			<thead class="gridHeader" >
			 	<th>Select</th>
				<th>S.No.</th>
				<th>Program<font color=red>*</font></th>
				<th>Contractor<font color=red>*</font></th>
				<th>Fund Distribution<font color=red>*</font></th>
				<th>M Book No<font color=red>*</font></th>
				<th>Recorded By<font color=red>*</font></th>
				<th>Recorded Date<font color=red>*</font></th>
				<th>Check Measured By<font color=red>*</font></th>
				<th>Check Measured Date<font color=red>*</font></th>
				<th>Super Check <BR> Measured By</th>
				<th>Super Check <BR> Measured Date</th>
			 	<th>Voucher No<font color=red>*</font></th>
				<th>Voucher Date<font color=red>*</font></th>
				<th>Voucher Amount<font color=red>*</font></th>
			 	<th>Cheque No<font color=red>*</font></th>
				<th>Cheque Date<font color=red>*</font></th>
				<th>Remarks</th>
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
			<nested:select name="VOUCHER_LIST" property="progCode" indexed="true" style="width: 105px" styleClass="noborder-text-box" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="programs">
				<html:options collection="programs" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td>
			<nested:select name="VOUCHER_LIST" property="contCode" indexed="true" style="width: 135px" styleClass="noborder-text-box" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="contractors">
				<html:options collection="contractors" property="value" labelProperty="label" />
				</logic:present>
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
			<nested:select name="VOUCHER_LIST" property="empCodeRecorded" indexed="true" style="width: 185px" styleClass="noborder-text-box" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="employeesRecBy">
				<html:options collection="employeesRecBy" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td nowrap  onmouseover="Tip('Please Enter Vouchers in Recorded Date Order',TITLE,'')" onmouseout="UnTip()"><nested:text name="VOUCHER_LIST" property="recordedDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<a href="javascript: showCalendar(document.getElementById('VOUCHER_LIST[<%= ndx%>].recordedDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"  onmouseover="Tip('Please Enter Vouchers in Recorded Date Order',TITLE,'')" onmouseout="UnTip()"></a></td>
		<td>
			<nested:select name="VOUCHER_LIST" property="empCode" indexed="true" style="width: 185px" styleClass="noborder-text-box" onchange='<%= "compareWithPrevious(" + ndx + ")" %>'>
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="employeesCheckMeasuredBy">
				<html:options collection="employeesCheckMeasuredBy" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td nowrap><nested:text name="VOUCHER_LIST" property="checkMesuaredDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<a href="javascript: showCalendar(document.getElementById('VOUCHER_LIST[<%= ndx%>].checkMesuaredDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
		<td>
			<nested:select name="VOUCHER_LIST" property="empCodeSuper" indexed="true" style="width: 185px" styleClass="noborder-text-box" >
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
		<td onmouseover="Tip('Voucher Amount Should be in Rupees',TITLE,'')" onmouseout="UnTip()"><nested:text name="VOUCHER_LIST" property="voucherAmount" indexed="true" maxlength="11" style="width: 120px" styleClass="noborder-text-box"  onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" /></td>
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
	<td colspan=18 align=left>
	<input type="button" name="workCount" value="Add New" class="bText" onclick="addNewVoucher()"/>
	<input type="button" name="workCount" value="Remove" class="bText" onclick="removeVoucher()"/>
	</td>
</tr>
<tr bgcolor="#ffffff">
	<td colspan=18 align=center>
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
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="100%"/>
</jsp:include>
<script language="JavaScript">
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
				}
			}
		}
	}
}
function compareExp(i)
{
	var wCount = '<%=workCount%>';
	var totExp = 0;
	for(var j=0;j<wCount-1;j++)
	{
		if(isNaN(document.getElementById("VOUCHER_LIST["+j+"].voucherAmount").value) || document.getElementById("VOUCHER_LIST["+j+"].voucherAmount").value=="")
		{
			exp = 0;
		}
		else
		{
			exp = document.getElementById("VOUCHER_LIST["+j+"].voucherAmount").value;
			exp = (parseFloat(exp))/100000;
		}
		totExp = totExp + parseFloat(exp);
	}
	totExp = Math.round((parseFloat(totExp))*Math.pow(10,2))/Math.pow(10,2)
	var expWorks = '<%=expWork%>';
	if(parseFloat(expWorks)<parseFloat(totExp))
	{
		alert("Total Voucher(s) Amount: "+totExp+" Lakhs  Should Not Exceed the Actual Work Expenditure: "+expWorks+" Lakhs");
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
			var url = "./switch.do?prefix=/works&page=/WorkStatus.do&mode=addnewVoucher";
			document.forms[0].action=url;
			document.forms[0].submit();
		}
	}
	else
	{
		//alert("=1");
		var url = "./switch.do?prefix=/works&page=/WorkStatus.do&mode=addnewVoucher";
		document.forms[0].action=url;
		document.forms[0].submit();
	}
}
function makeCompulsory(i)
{
	if(document.getElementById("VOUCHER_LIST["+i+"].progCode").value=="")
	{
		alert("Please Select Program for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].progCode").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].contCode").value=="")
	{
		alert("Please Select Contractor for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].contCode").focus();
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
		alert("Please Select Cheque Date for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].chequeDate").focus();
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
	else if(dt3>dt4)
	{
		alert("Cheque Date("+document.getElementById("VOUCHER_LIST["+i+"].chequeDate").value+") for S.No:"+(i+1)+" Should be greater than or Equal to Voucher  Date("+document.getElementById("VOUCHER_LIST["+i+"].voucherDate").value+") for S.No:"+(i+1));
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
				document.forms[0].action="./switch.do?prefix=/works&page=/WorkStatus.do&mode=removeVoucher";
				document.forms[0].submit();
			}
		}
		else
		{
			document.forms[0].action="./switch.do?prefix=/works&page=/WorkStatus.do&mode=removeVoucher";
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
function saveAllVouchers()
{
	var wCount = '<%=workCount%>';
	var totExp = 0;
	if(wCount > 1)
	{
		for(var i=0;i<wCount-1;i++)
		{
			var status = makeCompulsory(i);
			if(status==true)
			{
				var statuss = compareAllDates1(i);
			}
			totExp = totExp + parseFloat(document.getElementById("VOUCHER_LIST["+i+"].voucherAmount").value)/100000;
		}
		if(status == true && statuss == true)
		{
			//var expWorks = '<%=expWork%>';
			//if(parseFloat(expWorks)<parseFloat(totExp))
			//{
			//	alert("Total Voucher(s) Amount: "+totExp+" Lakhs  Should not Exceed the Work Expenditure: "+expWorks+" Lakhs");
		//	}
		//	else
		//	{
				if(confirm("The Voucher(s) Amount Should be in Rupees \n  Press CANCEL to Confirm otherwise \n Press OK to continue anyway"))
				{
					var url = "./switch.do?prefix=/works&page=/WorkStatus.do&mode=saveVouchers";
					document.forms[0].action=url;
					document.forms[0].submit();
				}
			//}
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
</p>
</html:form>
<%@ include file = "/commons/rws_footer.jsp" %>
<%@ include file = "/commons/rws_alert.jsp" %>
</body>
</html>