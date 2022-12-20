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


legend {
  padding: 0.2em 0.5em;
  border:1px solid green;
  color:green;
  font-size:90%;
  text-align:right;
  }

</style>
<%@ include file="/commons/rws_SpecialHeader.jsp" %>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String userid = user.getUserId();
if(user!=null){
       if(userid!=null && (!userid.equals("admin") && !userid.equals("100000") && !userid.substring(4, 6).equals("EE")  && !userid.substring(4, 6).equals("AO"))){
      response.sendRedirect("../commons/UnAuthorize.jsp");
       }
} 
%>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<%
int count=0;
String query = null;
	int workCount = 1;
	String expWork = (String) session.getAttribute("expWork");
	Statement stmt2 = conn.createStatement();
	Statement stmt3 = conn.createStatement();
Collection cc = new ArrayList();
	Collection c = new ArrayList();
try{
	
	String qq = "select BILL_SL_NO  from rws_bill_bank_bridge_tbl where work_id='"+request.getAttribute("workCode")+"' union select BILL_SL_NO  from rws_bill_bank_bridge_temp_tbl where work_id='"+request.getParameter("workCode")+"' union select BILL_SL_NO  from rws_bill_pao_bridge_temp_tbl where work_id='"+request.getParameter("workCode")+"'";
	ResultSet rs3 = stmt3.executeQuery(qq);
	
	while(rs3.next())
	{
		cc.add(rs3.getString(1)); 

	}

	qq = "select bill_sl_no from rws_work_bill_tbl where work_id='"+request.getAttribute("workCode")+"' and ee_fwd_date is not null and bill_type='A'";
	ResultSet rs2 = stmt2.executeQuery(qq);

	while(rs2.next())
	{
		c.add(rs2.getString(1)); 
	}
}catch(Exception e){
e.printStackTrace();
}
%>
<html>
<head>

</head>
<% 
//onload="fnCal2()"
%>
<body bgcolor="#edf2f8" onload="fnCal2()">
<html:form  action="PartABill.do" enctype="multipart/form-data" >

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

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
		<td class=rptValue colspan=23>
		Bills for the <b>Part A Work : <font color=red><bean:write property="workId" name="PartAForm"/>-<bean:write property="workName" name="PartAForm"/> </b></font>
		</td>
		</tr>
		<tr align="center">
				<td colspan="7" class="btext">Current Bill Details<font color=red>*</font></td>
<td colspan="2" class="btext">Cumulative Bill Details<font color=red>*</font></td>				
<td colspan="4" class="btext">Payment Details<font color=red>*</font></td>				
<td colspan="10" class="btext">Check & Super Check<font color=red>*</font></td>
		</tr>
		<tr align="center">
			<td class="btext">Select</td>
			<td class="btext">S.No.</td>
			<td class="btext">Bill No<font color=red>*</font></td>
            <td class="btext">Item <font color=red>*</font></td>
			<td class="btext">Bill Date<font color=red>*</font></td>
			<td class="btext">EE Fwd Date<font color=red>*</font></td>
			<td class="btext">Bill Amount <BR>(In Rupees)<font color=red>*</font></td>
			<td class="btext">Bill Amount<br>As per Pay Order<br>(In Rupees)<font color=red>*</font></td>				
			<td class="btext">Gross Value   <BR> upto this Bill</td>
			<td class="btext">Gross Value <BR>As per Pay Order  upto this Bill</td>
<!-- 			<td class="btext">Gross Value Paid <BR> upto Previous Bill</td> -->
			<td class="btext">Amount Released<br>(BANK+PAO)</td>
			<td class="btext">Amount Paid<BR>Through Vouchers</td>
			<td class="btext">Amount to be Paid<BR>Through Vouchers<BR>(7-11)</td>
		<td class="btext">Check Measured By DEE<font color=red>*</font></td>
			<td class="btext">M.Book No.s & Page No.s<font color=red>*</font></td>
			<td class="btext">Check Measured Date<font color=red>*</font></td>
				<td class="btext">Super Check <BR> Measured By EE </td>
				<td class="btext">M.Book No.s & Page No.s</td>
				<td class="btext">Super Check <BR> Measured Date </td>
			
				<td class="btext">Super Check <BR> Measured By SE </td>
				<td class="btext">M.Book No.s & Page No.s</td>
				<td class="btext">Super Check <BR> Measured Date </td>
				
				<td class="btext">Pass Order<br></br> Scanned Copy </td>
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
			<td class="btext">11</td>
			<td class="btext">12</td>
			<td class="btext">13</td>
			<td class="btext">14</td>
			<td class="btext">15</td>
			<td class="btext">16</td>
			<td class="btext">17</td>
			<td class="btext">18</td>
			<td class="btext">19</td>
			<td class="btext">20</td>
			<td class="btext">21</td>
			<td class="btext">22</td>
			<td class="btext">23</td>
		</tr>
		<tbody>
		<%
try
{
	int snoo = 1;

%>

		<logic:iterate id="billsList" name="billsList" indexId="ndx">
		  
<bean:define id="billSlNo" scope="request">   
               <nested:write name="billsList" property="billSlNo"/>  
		 </bean:define>   
 
	<tr>
			<%if(userid!=null && (userid.equals("admin") || userid.equals("100000"))) {
			if(cc.contains(billSlNo)){
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
		<nested:hidden name="billsList" property="billSlNo" indexed="true"/>
		<td class=rptValue><input type="text" name="billSlNo" style="width:50px" class="noborder-text-box" readonly="true" value="<%=billSlNo %>"/></td>
		<td>
			<nested:text name="billsList" property="billNo" indexed="true"  styleClass="noborder-text-box" onchange='<%= "compareWithPrevious1(" + ndx + ")" %>' onkeypress="upperOnly()"/>
		</td>
		
<% if(cc.contains(billSlNo)){%>
<td onmouseover="Tip('<b>This Bill Already Forwarded by Your EE-Budget (or) Payment already made</b>',TITLE,'')" onmouseout="UnTip()">
							<logic:present name="itemsList">
							<html:select  name="billsList" disabled="true" property="itemCode" styleClass="mycombo" style="width:150px" indexed="true" 	onchange='<%= "getItemAmount(" + ndx + ")" %>' >
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="itemsList" name="labelValueBean"
										  property="value" labelProperty="label" />
							</html:select>
							
							</logic:present>
</td>
<%} else { %>
<td>
							<logic:present name="itemsList">
							<html:select  name="billsList"  property="itemCode" styleClass="mycombo" style="width:150px" indexed="true" 	onchange='<%= "getItemAmount(" + ndx + ")" %>' >
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="itemsList" name="labelValueBean"
										  property="value" labelProperty="label" />
							</html:select>
							
							</logic:present>
</td>
<%} %>
		<td nowrap>
			<nested:text name="billsList" property="billDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<!--  	 <a href="javascript: showCalendar(document.getElementById('billsList[<%= ndx%>].billDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>  -->
		</td>
		<td nowrap onmouseover="Tip('<b>You can Directly Delete to remove EE Fwd Date</b>',TITLE,'')" onmouseout="UnTip()">
		<%if(userid!=null && (userid.equals("admin") || userid.equals("100000"))) {%>
			<nested:text name="billsList" property="billEEForwardDate" indexed="true" style="width: 60px" styleClass="noborder-text-box"/>
		<%}else{%>
			<nested:text name="billsList" property="billEEForwardDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<%}%>
		</td>	
		<td>
		<nested:text name="billsList" property="billAmount" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" onchange='<%= "compareWithPrevious(" + ndx + ")" %>' onkeyup='<%= "return fnCal1(" + ndx + ")" %>' readonly="true"/></td>

		<td ><nested:text name="billsList" property="billAmountAsPerPayOrder" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)"  onkeyup='<%= "return fnCal1(" + ndx + ")" %>' /></td>

		<td ><nested:text name="billsList" property="grossValueUpToThisBill" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box" readonly="true"/></td>

		<td ><nested:text name="billsList" property="grossValueAsPerPayOrderUpToThisBill" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  readonly="true" /></td>

	

		<td><nested:text name="billsList" property="amountReleased" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  readonly="true" /></td>
		<td><nested:text name="billsList" property="amountPaid" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  readonly="true" /></td>
		<td><nested:text name="billsList" property="amountToBePaid" indexed="true" maxlength="11" style="width: 90px" styleClass="noborder-text-box"  readonly="true" /></td>
		<td>
			<nested:select name="billsList" property="empCode" indexed="true" style="width: 225px" styleClass="noborder-text-box"><!-- onchange='<%= "compareWithPrevious(" + ndx + ")" %>' -->
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="employeesCheckMeasuredBy">
				<html:options collection="employeesCheckMeasuredBy" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td><nested:text name="billsList" property="cmMBookNo" indexed="true" maxlength="50" style="width: 90px" styleClass="noborder-text-box"   /></td>
		<td nowrap><nested:text name="billsList" property="checkMesuaredDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<a href="javascript: showCalendar(document.getElementById('billsList[<%= ndx%>].checkMesuaredDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
		<td>
			<nested:select name="billsList" property="empCodeSuper" indexed="true" style="width: 225px" styleClass="noborder-text-box" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="employeesSuperCheckMeasuredBy">
				<html:options collection="employeesSuperCheckMeasuredBy" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td><nested:text name="billsList" property="scmMBookNo" indexed="true" maxlength="50" style="width: 90px" styleClass="noborder-text-box"   /></td>
		<td nowrap><nested:text name="billsList" property="superCheckMesuaredDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<a href="javascript: showCalendar(document.getElementById('billsList[<%= ndx%>].superCheckMesuaredDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
		<td>
			<nested:select name="billsList" property="superCheckBySE" indexed="true" style="width: 225px" styleClass="noborder-text-box" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="employeesSuperCheckMeasuredBySE">
				<html:options collection="employeesSuperCheckMeasuredBySE" property="value" labelProperty="label" />
				</logic:present>
			</nested:select>
		</td>
		<td><nested:text name="billsList" property="superCheckPgNo" indexed="true" maxlength="50" style="width: 90px" styleClass="noborder-text-box"   /></td>
		<td nowrap><nested:text name="billsList" property="superCheckSEDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true"/>
		<a href="javascript: showCalendar(document.getElementById('billsList[<%= ndx%>].superCheckSEDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
		
		
		<td >
		<nested:equal name="billsList"  property="passOrderScanCopyAvailable"  value="A">
		<nested:equal name="billsList"  property="billSaved"  value="yes">
		<a href="#" onclick='<%= "openFile(" + ndx + ")" %>'>View</a>|<a href="#" onclick='<%= "editFile(" + ndx + ")" %>'>Edit</a> 
		</nested:equal>
		</nested:equal>
		<nested:equal name="billsList"  property="billSaved" value="">
		<html:file name="billsList" property="passOrderScanCopy"   indexed="true" />
		</nested:equal>
		</td>
		
		
		
		</tr>
		</logic:iterate>

<%	
}catch(Exception e){
e.printStackTrace();}
%>
<tr bgcolor="#ffffff">
	<td colspan=23 align=left>
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
	<td colspan=23 align=left>
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
	<td colspan=23 align=left>
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
	<td colspan=23 align=left>
	<input type="button" name="workCount" value="Add New" class="bText" onClick="showDivs1();"/>
	<input type="button" name="workCount" value="Remove" class="bText" onClick="removeBill()"/>
	</td>
</tr>
<tr bgcolor="#ffffff">
	<td colspan=23 align=center>

		<input type="button" name="save" value="Save Bills" class="bText" onClick="saveAllBills()"/>
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



function validateFileExtension(index)
{
	var component = document.getElementById("billsList["+index+"].passOrderScanCopy");
	if(component==null){
      return;
	} 
      var ext=component.value.substring(component.value.lastIndexOf('.')+1);
       
      if(ext =="JPEG" || ext=="JPG" || ext=="jpg")
      {
          return true;
      }
      else
      {
          alert("Upload JPEG Images only");
          return false;
      }
    

}


function validateFileSize(index)
{

	
	var maxSize=1048576;  //1 MB==1048576  bytes

	var component = document.getElementById("billsList["+index+"].passOrderScanCopy");
	if(component==null){

		if(document.getElementById("billsList["+index+"].billDateEE").value==""){
			 alert("Please Upload Passorder Scan Copy");
			   return ;
		}else{
           
            return ;
		}
	}

	if(navigator.appName=="Microsoft Internet Explorer")
   {
		var size="";
	try{
         var oas=new ActiveXObject("Scripting.FileSystemObject");
         var e=oas.getFile(component.value);
          size=e.size;

	}catch(e){
           alert("Please Upload Passorder Scan Copy");
	}
           
   }
   else
   {
      if(component.files[0]!=undefined)
      {
         size = component.files[0].size;
      }
   }
   if(size!=undefined && size>maxSize)
   {
     alert("Pass Order Scan Copy File Size Shoud Not Be Allowed More Than 1 MB");
      component.value="";
      component.style.backgroundColor="red";
      component.style.border="thin solid #000000";
      component.focus();
      return false;
   }
   else
   {
      return true;
   }
}


function editFile(index) {

	var bslno=document.getElementById("billsList["+index+"].billSlNo").value;
	var url="./switch.do?prefix=/works&page=/PartABill.do&mode=editScannedCopy&recIndex="+index;
	document.forms[0].action=url;
	document.forms[0].submit();
	//document.getElementById('passOrderInputDiv').style.display='block';
//document.getElementById("billsList["+index+"].billSaved").value="";

}
function openFile(index){

	var bslno=document.getElementById("billsList["+index+"].billSlNo").value;
	var url="./switch.do?prefix=/works&page=/PartABill.do&mode=showScannedCopy&slNo="+bslno;
	var width = 990;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";

	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
	
	
}





function showDivs()
{
	var wCount = '<%=workCount%>';
	var zeroExistsOrNot = false;
	for(var j=0;j<wCount-1;j++)
	{
		if(document.getElementById("billsList["+j+"].billSlNo").value=="0")
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
				v1 = document.getElementById("billsList["+i+"].billNo").value.toUpperCase();
				v2 = document.getElementById("billsList["+j+"].billNo").value.toUpperCase();
				if(v1==v2)
				{
					alert("Bill No("+v1+") for S.No:"+(i+1)+" Should Not Equals the Bill No("+v2+") for S.No:"+(j+1));
					document.getElementById("billsList["+i+"].billNo").value = '';
					document.getElementById("billsList["+i+"].billNo").focus();
					break;
				}
				var vv1 = document.getElementById("billsList["+i+"].billDate").value;
				var vv2 = document.getElementById("billsList["+j+"].billDate").value;
				if(vv1==vv2)
				{
					alert("Only One Bill Allowed for each Day \n Bill Date("+vv1+") for S.No:"+(i+1)+" Should Not Equals the Bill Date("+vv2+") for S.No:"+(j+1));
					document.getElementById("billsList["+i+"].billDate").value='';
					document.getElementById("billsList["+i+"].billDate").focus();
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
		var v1 = document.getElementById("billsList["+j+"].billDate").value;
		var v2 = document.getElementById("billsList["+i+"].billDate").value;
		if(v1==v2)
		{
			alert("Only One Bill Allowed for each Day \n Bill Date("+v1+") for S.No:"+(i+1)+" Should Not Equals the Bill Date("+v2+") for S.No:"+(j+1));
			document.getElementById("billsList["+j+"].billDate").focus();
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
	var val1 = parseFloat(document.getElementById("billsList["+i+"].billAmount").value);
	var val2 = parseFloat(document.getElementById("billsList["+i+"].billAmountAsPerPayOrder").value);
	var val3 = parseFloat(document.getElementById("billsList["+i+"].grossValueUpToThisBill").value);
	var val4 = parseFloat(document.getElementById("billsList["+i+"].grossValueAsPerPayOrderUpToThisBill").value);
//	var val5 = parseFloat(document.getElementById("billsList["+i+"].grossValuePaid").value);
	//var val6 = parseFloat(document.getElementById("billsList["+i+"].paymentAdmissable").value);

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
		//document.getElementById("billsList["+i+"].grossValueContractor").value = '0';
		document.getElementById("billsList["+i+"].billAmountAsPerPayOrder").value = '0';
	}
	var vall1 = 0;var vall2 = 0;
	for(var j=0;j<wCount-1;j++)
	{
		vall1 += parseFloat(document.getElementById("billsList["+j+"].billAmount").value);
		vall2 += parseFloat(document.getElementById("billsList["+j+"].billAmountAsPerPayOrder").value);
	}
	document.getElementById("billsList["+i+"].grossValueUpToThisBill").value= vall1;
	document.getElementById("billsList["+i+"].grossValueAsPerPayOrderUpToThisBill").value= vall2;
	var vall3 = 0;
	for(var j=0;j<wCount-2;j++)
	{
		vall3 += parseFloat(document.getElementById("billsList["+j+"].billAmountAsPerPayOrder").value);
	}
//	document.getElementById("billsList["+i+"].grossValuePaid").value= vall3;
	//document.getElementById("billsList["+i+"].paymentAdmissable").value=vall2-vall3 ;
document.getElementById("billsList["+i+"].amountToBePaid").value = parseFloat(document.getElementById("billsList["+i+"].billAmount").value)-parseFloat(document.getElementById("billsList["+i+"].amountPaid").value);
}
function fnCal2()
{	
	var wCount = '<%=workCount%>';
	for(var i=0;i<wCount-1;i++)
	{
		var vall1 = 0;var vall2 = 0;
		for(var j=0;j<=i;j++)
		{
			vall1 += parseFloat(document.getElementById("billsList["+j+"].billAmount").value);
			vall2 += parseFloat(document.getElementById("billsList["+j+"].billAmountAsPerPayOrder").value);
		}
		var vall3 = 0;
		for(var j=0;j<i;j++)
		{
			vall3 += parseFloat(document.getElementById("billsList["+j+"].billAmountAsPerPayOrder").value);
		}
		document.getElementById("billsList["+i+"].grossValueUpToThisBill").value= vall1;
		document.getElementById("billsList["+i+"].grossValueAsPerPayOrderUpToThisBill").value= vall2;
//		document.getElementById("billsList["+i+"].grossValuePaid").value= vall3;
	//	document.getElementById("billsList["+i+"].paymentAdmissable").value=vall2-vall3;
		document.getElementById("billsList["+i+"].amountToBePaid").value = parseFloat(document.getElementById("billsList["+i+"].billAmount").value)-parseFloat(document.getElementById("billsList["+i+"].amountPaid").value);
	}
}
function compareWithPrevious(i)
{
	if(document.getElementById("billsList["+i+"].billDate").value=="")
	{
		alert("Please Enter Bill Date");
		document.getElementById("billsList["+i+"].billDate").value = '';
		document.getElementById("billsList["+i+"].grossValueContractor").value = '';
		document.getElementById("billsList["+i+"].billDate").focus();
	}
	else
	{
		if(i>=1)
		{
			var j = i-1;
			dt1=getDateObject(document.getElementById("billsList["+i+"].billDate").value,"/");
			dt2=getDateObject(document.getElementById("billsList["+j+"].billDate").value,"/");
			if(dt1<dt2)
			{
				alert("Bill Date ("+document.getElementById("billsList["+i+"].billDate").value+") for S.No:"+(i+1)+" Should Greater than or Equals to Bill Date("+document.getElementById("billsList["+j+"].billDate").value+") for S.No:"+(j+1));
				document.getElementById("billsList["+i+"].billDate").value = '';
				document.getElementById("billsList["+i+"].grossValueContractor").value = '';
				document.getElementById("billsList["+i+"].billDate").focus();
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
			dt1.setFullYear(2010,2,31);
			dt2=getDateObject(document.forms[0].lastRecDate.value,"/");
			dt2.setFullYear(dt2.getYear(),dt2.getMonth()-1,dt2.getDate()-1);
			if(dt1<=dt2)
			{
				alert("Last Recorded Date Should be in Last Financial Year");
			}
			else
			{
				var url = "./switch.do?prefix=/works&page=/PartABill.do&mode=addNewPrevBill&slNo=0&disabled1=Y&recDate="+document.forms[0].lastRecDate.value+"&workCode="+document.forms[0].workCode.value;
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

function addNewBill11(){

var url = "./switch.do?prefix=/works&page=/PartABill.do&mode=addNewBill";
						document.forms[0].action=url;
						document.forms[0].submit();
}
function getItemAmount(index){

var url = "./switch.do?prefix=/works&page=/PartABill.do&mode=getItemAmount&index="+index;
						document.forms[0].action=url;
						document.forms[0].submit();
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
			dt1.setFullYear(2010,2,31);
			dt2=getDateObject(document.forms[0].billDatee.value,"/");
			dt2.setFullYear(dt2.getYear(),dt2.getMonth()-1,dt2.getDate()-1);
			if(dt1>=dt2)
			{
				alert("Current Finanical Year Bill Date Should be greater than 31.03.2010");
			}
			else
			{
				if(wCount > 1)
				{
					var snos = new Array();
					for(var i=0;i<wCount-1;i++)
					{
						snos[i] = parseInt(document.getElementById("billsList["+i+"].billSlNo").value);
						var status = makeCompulsory(i);
						sllNo = parseInt(document.getElementById("billsList["+i+"].billSlNo").value)+1;
					}
					if(Math.max.apply( Math, snos )==0 || Math.max.apply( Math, snos)==1)
					{	sllNo = "2";}
					else
					{
						sllNo = Math.max.apply( Math, snos )+1;
					}
					if(status == true)
					{
						var url = "./switch.do?prefix=/works&page=/PartABill.do&mode=addNewBill&billNewDate="+document.forms[0].billDatee.value+"&slNo="+sllNo+"&disabled=Y&workCode="+document.forms[0].workCode.value;
						document.forms[0].action=url;
						document.forms[0].submit();
					}
				}
				else
				{
					var url = "./switch.do?prefix=/works&page=/PartABill.do&mode=addNewBill&billNewDate="+document.forms[0].billDatee.value+"&slNo="+wCount+"&disabled=Y&workCode="+document.forms[0].workCode.value;
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
			dt1.setFullYear(2010,2,31);
			dt2=getDateObject(document.forms[0].finalBillDate.value,"/");
			dt2.setFullYear(dt2.getYear(),dt2.getMonth()-1,dt2.getDate()-1);
			if(dt1>=dt2)
			{
				alert("Withheld Bill Date Should be greater than 31.03.2010");
			}
			else
			{
				if(wCount > 1)
				{
					var snos = new Array();
					for(var i=0;i<wCount-1;i++)
					{
						snos[i] = parseInt(document.getElementById("billsList["+i+"].billSlNo").value);
						var status = makeCompulsory(i);
						sllNo = parseInt(document.getElementById("billsList["+i+"].billSlNo").value)+1;
					}
					if(Math.min.apply( Math, snos )==0 || Math.min.apply( Math, snos)==1)
					{	sllNo = "-1";}
					else
					{
						sllNo = Math.min.apply( Math, snos )-1;
					}
					if(status == true)
					{
						var url = "./switch.do?prefix=/works&page=/PartABill.do&mode=addNewFinalBill&billNewDate="+document.forms[0].finalBillDate.value+"&slNo="+sllNo+"&disabled=Y&workCode="+document.forms[0].workCode.value;
						document.forms[0].action=url;
						document.forms[0].submit();
					}
				}
				else
				{
					var url = "./switch.do?prefix=/works&page=/PartABill.do&mode=addNewBill&billNewDate="+document.forms[0].billDatee.value+"&slNo=-1&disabled=Y&workCode="+document.forms[0].workCode.value;
					document.forms[0].action=url;
					document.forms[0].submit();
				}
			}	
	}
}

function validateCheckMeasurement(i){

	
	//alert(document.getElementById("VOUCHER_LIST["+i+"].passOrderScanCopy"));
 if(document.getElementById("billsList["+i+"].billEEForwardDate").value==""){	
	if(document.getElementById("billsList["+i+"].empCode").value=="" || document.getElementById("billsList["+i+"].empCode").value=="0")
	{
		alert("Please Select Check Measuremet By DEE As per Pay Order for S.No:"+(i+1));
		document.getElementById("billsList["+i+"].empCode").focus();
		return false;
	}
	else if(document.getElementById("billsList["+i+"].cmMBookNo").value=="" || document.getElementById("billsList["+i+"].cmMBookNo").value=="0")
	{
		alert("Please Enter MBook NO & Page NO As per Pay Order for S.No:"+(i+1));
		document.getElementById("billsList["+i+"].cmMBookNo").focus();
		return false;
	}
	else if(document.getElementById("billsList["+i+"].checkMesuaredDate").value=="" || document.getElementById("billsList["+i+"].checkMesuaredDate").value=="0")
	{
		alert("Please Select Check Measuremet BY DEE  Date  As per Pay Order for S.No:"+(i+1));
		document.getElementById("billsList["+i+"].checkMesuaredDate").focus();
		return false;
	}
	/*else if(document.getElementById("VOUCHER_LIST["+i+"].empCodeSuper").value=="" || document.getElementById("VOUCHER_LIST["+i+"].empCodeSuper").value=="0")
	{
		alert("Please Select Check Measuremet By EE As per Pay Order for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].empCodeSuper").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].scmMBookNo").value=="" || document.getElementById("VOUCHER_LIST["+i+"].scmMBookNo").value=="0")
	{
		alert("Please Enter MBook NO & Page NO As per Pay Order for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].scmMBookNo").focus();
		return false;
	}
	*/
/*	else if(document.getElementById("VOUCHER_LIST["+i+"].superCheckMesuaredDate").value=="" || document.getElementById("VOUCHER_LIST["+i+"].superCheckMesuaredDate").value=="0")
	{
		alert("Please Select Check Measuremet BY EE  Date  As per Pay Order for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].superCheckMesuaredDate").focus();
		return false;
	}
	*/
 /*	else if(document.getElementById("VOUCHER_LIST["+i+"].superCheckBySE").value=="" || document.getElementById("VOUCHER_LIST["+i+"].superCheckBySE").value=="0")
	{
		alert("Please Select Check Measuremet By SE As per Pay Order for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].superCheckBySE").focus();
		return false;
	}
	else if(document.getElementById("VOUCHER_LIST["+i+"].superCheckPgNo").value=="" || document.getElementById("VOUCHER_LIST["+i+"].superCheckPgNo").value=="0")
	{
		alert("Please Enter MBook NO & Page NO As per Pay Order for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].superCheckPgNo").focus();
		return false;
	}
	/*else if(document.getElementById("VOUCHER_LIST["+i+"].superCheckSEDate").value=="" || document.getElementById("VOUCHER_LIST["+i+"].superCheckSEDate").value=="0")
	{
		alert("Please Select Check Measuremet BY SE  Date  As per Pay Order for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].superCheckSEDate").focus();
		return false;
	}
	*/
	/*else if(document.getElementById("VOUCHER_LIST["+i+"].passOrderScanCopy")!=null && document.getElementById("VOUCHER_LIST["+i+"].passOrderScanCopy").value!=null || document.getElementById("VOUCHER_LIST["+i+"].passOrderScanCopy").value=="")
	{
		alert("Please Select Pass Order Scan Copy for S.No:"+(i+1));
		document.getElementById("VOUCHER_LIST["+i+"].passOrderScanCopy").focus();
		return false;
	}
	*/
	
 }else{
return true;
 }

}




function makeCompulsory(i)
{
	if(document.getElementById("billsList["+i+"].billNo").value=="")
	{
		alert("Please Enetr Bill No for S.No:"+(i+1));
		document.getElementById("billsList["+i+"].billNo").focus();
		return false;
	}
	
        else if(document.getElementById("billsList["+i+"].itemCode").value=="")
	{
		alert("Please Select Item for S.No:"+(i+1));
		document.getElementById("billsList["+i+"].itemCode").focus();
		return false;
	}
else if(document.getElementById("billsList["+i+"].billDate").value=="")
	{
		alert("Please Select Bill Date for S.No:"+(i+1));
		document.getElementById("billsList["+i+"].billDate").focus();
		return false;
	}
	else if(document.getElementById("billsList["+i+"].billAmount").value=="" || document.getElementById("billsList["+i+"].billAmount").value=="0")
	{
		alert("Please Enter Bill Amount for S.No:"+(i+1));
		document.getElementById("billsList["+i+"].billAmount").focus();
		return false;
	}
	else if(document.getElementById("billsList["+i+"].billAmountAsPerPayOrder").value=="" || document.getElementById("billsList["+i+"].billAmountAsPerPayOrder").value=="0")
	{
		alert("Please Enter Bill Amount As per Pay Order for S.No:"+(i+1));
		document.getElementById("billsList["+i+"].billAmountAsPerPayOrder").focus();
		return false;
	}	
	else if(validateCheckMeasurement(i)==false){
		return false;
	}

		/*else if(validateFileSize(i)==false){
		return false;
		}
	*/
		else if(validateFileExtension(i)==false){
        return false;
		} else{
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
			if(value==null || value=='')
			{
				alert("Remarks Mandatory to Delete the Bill");
			}
			else
			{	
				document.forms[0].remarks.value = value;
				document.forms[0].action="./switch.do?prefix=/works&page=/PartABill.do&mode=removeBill&workCode="+document.forms[0].workCode.value;
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
function saveAllBills()
{
	//alert(document.forms[0].workCode.value);
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
							var url = "./switch.do?prefix=/works&page=/PartABill.do&mode=saveBills&workCode="+document.forms[0].workCode.value;
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
							var url = "./switch.do?prefix=/works&page=/PartABill.do&mode=saveBills&workCode="+document.forms[0].workCode.value;
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
<input type=hidden name=workCode value=<%=request.getAttribute("workCode")%>>
<input type=hidden name=remarks>
</html:form>
<%@ include file = "/commons/rws_footer.jsp" %>
<%@ include file = "/commons/rws_alert.jsp" %>
</body>
</html>