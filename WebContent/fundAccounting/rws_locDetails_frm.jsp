<%
	String work_id = request.getParameter("workId");
	String id_count = request.getParameter("count");
	int len = 0;
	if(work_id != null)
	{	len = work_id.length();}
%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%int count=0; %>
<%int progCount=0; %>
<%int grantedAmtWorkWiseListCount=-1; %>
<head>
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0"> 

</head>
	    
   
<script language="javascript">

var mode;
var remainingAmountToBeAllocatedVar=0;
var broIdAsInDataBase;
var isInNumberFormat=true;
var CLOCRemainingAmount=0;
var newWindow;
function isNull(val){
if(val==null)
return 0;
else 
return val;
}
function fnSelectWorkId(count)
{
	var dname;
	  if(document.getElementById("LOC_DETAILS_LIST["+count+"].district").value!="" )
		{
			dname=document.getElementById("LOC_DETAILS_LIST["+count+"].district").options[document.getElementById("LOC_DETAILS_LIST["+count+"].district").selectedIndex].text;
		}
	if(!document.getElementById("LOC_DETAILS_LIST["+count+"].project").checked)
	{
		alert("Please Select Project for Loc List with S.No "+(count+1));
	}
	
	else
	{
	var locid = document.forms[0].locId.value;
	var workId = document.getElementById("LOC_DETAILS_LIST["+count+"].workId").value;
	var program = document.getElementById("LOC_DETAILS_LIST["+count+"].program").value;
	var subprogram = document.getElementById("LOC_DETAILS_LIST["+count+"].subprogram").value;
	if(program == "" || program == null)
	{
		alert("Please select Program");
	}
	if(subprogram == "" || subprogram == null)
	{
		alert("Please select Sub Program");
	}
	else
	{

		var district=document.getElementById("LOC_DETAILS_LIST["+count+"].district").value;
//		alert(district);
		var url = "switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=workId&count="+count+"&locId="+locid+"&work_id="+workId+"&get=0&district="+district+"&dname="+dname;
		//alert(url);
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
						   + "status=yes,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,"
						   + "resizable=no";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}
	}
	}
}
function fnSelectHOA(count)
{
	var broId = document.forms[0].broId.value;
	var locid = document.forms[0].locId.value;
	var workId = document.getElementById("LOC_DETAILS_LIST["+count+"].workId").value;
	var program = document.getElementById("LOC_DETAILS_LIST["+count+"].program").value;
	var subprogram = document.getElementById("LOC_DETAILS_LIST["+count+"].subprogram").value;
	if(document.getElementById("LOC_DETAILS_LIST["+count+"].district").value== "" || document.getElementById("LOC_DETAILS_LIST["+count+"].district").value== null)
	{
		alert("Please select District");
	}
	else if(program == "" || program == null)
	{
		alert("Please select Program");
	}
	else if(subprogram == "" || subprogram == null)
	{
		alert("Please select Sub Program");
	}
	else
	{
		var district=document.getElementById("LOC_DETAILS_LIST["+count+"].district").value;
		var url = "switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=HOA&count="+count+"&locId="+locid+"&work_id="+workId+"&program="+program+"&subprogram="+subprogram+"&get="+count+"&district="+district+"&broId="+broId;
		//alert(url);
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
						   + "status=yes,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,"
						   + "resizable=no";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}
	}
}
function init()
{

var rowindex='<%=request.getParameter("rowId")%>';

var mode='<%=request.getParameter("mode")%>';

if(mode=='programmeChanged'&&rowindex!=null)
document.getElementById("LOC_DETAILS_LIST["+rowindex+"].workId").value=''; 




<%if(request.getParameter("broId") != null && (request.getParameter("mode") .equals("broIdChangedInEditMode") && request.getParameter("mode") .equals("addNew"))){
%>
	document.forms[0].broReference.value = '<%=request.getParameter("broId")%>';
	<%}%>
	

	


	<%//}
	//else
	//{
	%>
//-- by kiran	document.forms[0].locReference.value = '';
	//ert(document.getElementById("LOC_DETAILS_LIST["+myCount+"].workId").value);
	<%//}%>
    var myValue="";
	myValue = '<%=work_id%>';
	var length = <%=len%>;
	var l = myValue.length;
	var myCount=<%=id_count%>;
	var mode='<%=request.getParameter("mode")%>';

	//alert(myValue);
	if(myValue != 'null'&&myCount!=null){
		document.getElementById("LOC_DETAILS_LIST["+myCount+"].workId").value = myValue;
	}
	else if(myCount!=null)
	{
		document.getElementById("LOC_DETAILS_LIST["+myCount+"].workId").value = '';
		document.getElementById("LOC_DETAILS_LIST["+myCount+"].project").checked= true;
	}
	
	broIdAsInDataBase=document.forms[0].broId.value;
	getAmountRemainingProgrammeWise();
	document.forms[0].remainingAmountToBeAllocated.value=getBroRemainingAmtInclCurrentLoc();
}
function checkForWorks(index)
{
	workId=document.getElementById("LOC_DETAILS_LIST["+index+"].workId").value;
	if(workId!="")
	{
		alert("DeSelect Work Id to select CircleLoc Id");
		document.getElementById("LOC_DETAILS_LIST["+index+"].circleLocId").value="";
	}
}

function checkForProjects(index)
{
	var locId=document.getElementById("LOC_DETAILS_LIST["+index+"].circleLocId").value;
	if(locId!="")
	{
		alert("DeSelect CircleLoc Id to select Work Id");
		document.getElementById("LOC_DETAILS_LIST["+index+"].workId").value="";
	}
}

function checkWithBroAmtRemaining()
{
var locAmount=parseFloat(document.getElementById("locAmount").value);
var broAmount=document.getElementById("remainingAmountToBeAllocated").value;
var broAmount1=parseFloat(document.getElementById("broRemainingAmountToBeAllocated").value);
//alert(locAm);
//alert(broAmount);

if(locAmount>broAmount1){
alert("LOC Amount must be < BroAmount Remaining");
document.getElementById("locAmount").focus();
return false;
}
return true;
}
function getCircleLocIdList()
{

	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=getCircleLocIdList";
	document.forms[0].submit();
}
function getOffices(index)
{
	if(document.getElementById("LOC_DETAILS_LIST["+index+"].district").value=="")
	{
		alert("Please select district");
		document.getElementById("LOC_DETAILS_LIST["+index+"].project").checked = false;
		return false;
	}
	if(document.getElementById("LOC_DETAILS_LIST["+index+"].project"))
	{
		var dcode=document.getElementById("LOC_DETAILS_LIST["+index+"].district").value;
		
		if((document.getElementById("LOC_DETAILS_LIST["+index+"].project").checked)==true)
		{
		//	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=getDivisions&index="+index+"&district="+dcode;
		//	document.forms[0].submit();
		}
		else
		{
		document.getElementById("LOC_DETAILS_LIST["+index+"].workId").value="";
		}
	}
}
function blockNonNumbersNew(that, event, var1, var2)
{
	isInNumberFormat=blockNonNumbers(that, event, var1, var2);
	return isInNumberFormat;
}

function fnBroIdChanged()
{
	//alert(mode);
	if(mode=="nonData")
	{
		document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=broIdChangedInSaveMode";
		document.forms[0].submit();
	}
	else
	{
		//alert("BRO Id cannot be changed in Edit mode");
		//document.forms[0].broId.value=broIdAsInDataBase;
		document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=broIdChangedInEditMode";
		document.forms[0].submit();
	}
}
function programmeChanged(rowId)
{
//alert("hai");
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=programmeChanged&rowId="+rowId;
	document.forms[0].submit();
}
function fnDeleteLoc()
{
	if(document.forms[0].locId.value=="")
		alert("Please select Loc Id");
	else
	{
		if(confirm("Do you want to delete the record"))
		{
		document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=deleteLoc";
		document.forms[0].submit();
		}
	}
}
function fnEdit()
{
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=edit";
	document.forms[0].submit();
}
function fnGetLoc()
{
	var locId=document.forms[0].locId.value;

	if(document.forms[0].broId.value=="")
	{
		alert("Bro Id is mandatoary");
		document.forms[0].locId.value=""
	}
	else
	{
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=edit&locId="+locId;
	document.forms[0].submit();
	}
}
function fnGetLoc1()
{
document.forms[0].locReference.value = document.forms[0].locId.value;
}
function fnAddNewLoc()
{

	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=addNew";
	document.forms[0].submit();
}

function fnSave1()
{
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=update";
	document.forms[0].submit();
}
function fnSave()
{
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=save";
	if(checkForm())
	document.forms[0].submit();
}
function fnView()
{
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=view";
	document.forms[0].submit();
}
function deleteLOCDetails(i)
{
	if(confirm("Do you want to delete the record"))
	{
		document.getElementById("LOC_DETAILS_LIST["+i+"].district").value="";
		document.getElementById("LOC_DETAILS_LIST["+i+"].program").value="";
		document.getElementById("LOC_DETAILS_LIST["+i+"].subprogram").value="";
		document.getElementById("LOC_DETAILS_LIST["+i+"].headOfAccount").value="";
		document.getElementById("LOC_DETAILS_LIST["+i+"].locDate").value="";
		document.getElementById("LOC_DETAILS_LIST["+i+"].locAmount").value="";
		document.getElementById("LOC_DETAILS_LIST["+i+"].office").value="";
		document.getElementById("LOC_DETAILS_LIST["+i+"].place").value="";
		document.getElementById("LOC_DETAILS_LIST["+i+"].paoApaoFlag").value="";
		document.getElementById("LOC_DETAILS_LIST["+i+"].remarks").value="";
		
		document.forms[0].action="switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=deleteFromLocProgList&rowId="+i;
		document.forms[0].submit();
	}
}
function addNewProgrammForLoc(rowCount)
{
	if(document.forms[0].locId.value=="")
	{
		alert("Please select Loc Id");
	}
	else if(document.forms[0].broId.value=="")
	{
		alert("Please select Bro Id");
	}
	else if(document.forms[0].locRelDate.value == "")
	{
		alert("Please Select Loc Rel Date");
	}
	else 
	{
		document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=addNewProgrammeForLoc";
		document.forms[0].submit();
	}
}
function fnDateChange()
{
//alert("hi");
}
</script>
<body onload="init()">
<html:form action="locDetails.do" method="post">
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead><tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="LOC Details Entry Form" />
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td></tr></thead>

<tfoot>
<tr><td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td></tr>
</tfoot>
<tbody>
<tr>
<td>
<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
<tr>
	<td class="mycborder">
	<fieldset>
			<legend>BRO Details (Amount In Rs. Lakhs)</legend>
			<label>
				<table  border=0  width="100%">
				<tr>
					<TD class="textborder">
						BRO Id<font color="#FF6666"></font>
					</TD>
					<TD class="bwborder">
				    	<html:select property="broId" 
									   style="width: 125px" styleClass="noborder-text-box" 
									   onchange='<%= "javascript: fnBroIdChanged()"%>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options  name="BROIdList" />
						</html:select>
					
				    </TD>
				    
				    <TD class="textborder">
				     
						BRO Reference<font color="#FF6666">*</font>
					</TD>
					<TD class="bwborder">
				    	<html:text property="broReference"   
				    			   styleClass="mytext"  style="width:125"  readonly="true"/>
				    </TD>
				    
				    <logic:equal name="RWS_USER" property="officeName" value="Circle Office">
				    <TD class="textborder">
					
						LOC Id<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    <html:select property="locId" 
									   style="width: 125px" styleClass="noborder-text-box" onchange="getCircleLocIdList()">
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options  name="locIdList" />
						</html:select>
					</TD>
					</logic:equal>
				    <TD class="textborder">
				     
						BRO Date<font color="#FF6666">*</font>
					</TD>
					<TD class="bwborder">
				    	<html:text property="brodate"   
				    			   styleClass="mytext"  style="width:125"  readonly="true"/>
				    </TD>
				    <logic:equal name="RWS_USER" property="officeCode" value="100000">
					
				    </tr>
				    <tr>
<TD class="textborder">
				     
						BRO Amount<font color="#FF6666">*</font>
					</TD>
					<TD class="bwborder">
				    	<html:text property="broAmount"   
				    			   styleClass="mytext"  style="width:125" onkeyup="extractNumber2(this,11,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);" readonly="true"/>
				    </TD>
								<TD class="textborder">BRO Amount Allocated <br>
								to Other LOCs<font color="#FF6666">*</font>
								</TD>
								<TD class="bwborder"><html:text
									property="broAmountAlreadyAllocatedForLOCs" styleClass="mytext"
									style="width:125" onkeyup="extractNumber2(this,11,2,false);"
									onkeypress="return blockNonNumbers(this, event, true, false);"
									readonly="true" />
								</TD>
								<TD class="textborder">BRO Amount<br>
								Remaining<br>
								<font
									style="font-family:Verdana; font-weight:normal; font-size:10px">(Excluding
								current LOC)</font><font color="#FF6666">*</font>
								</TD>
								<TD class="bwborder"><html:text
									property="broRemainingAmountToBeAllocated" styleClass="mytext"
									style="width:125" onkeyup="extractNumber2(this,11,2,false);"
									onkeypress="return blockNonNumbers(this, event, true, false);"
									readonly="true" />
								</TD>
					</logic:equal>
				    
				    
				    
				    				</tr>
					</table>
			</label>
		</fieldset>
	
		<fieldset>
			<legend>LOC Details (Amount In Rs. Lakhs)</legend>
			<label>
				<table  border=0  width="100%">
				
				<tr>
					<logic:notEqual name="RWS_USER" property="officeName" value="Circle Office">
				    <TD class="textborder">
					
						LOC Id<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    <%if((session.getAttribute("EAmode")==null)||((String)session.getAttribute("EAmode")).equals("data"))
					{ %>
					<html:select property="locId" 
									   style="width: 125px" styleClass="noborder-text-box" 
									   onchange='<%= "javascript: fnGetLoc()"%>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options  name="locIdList" />
						</html:select>
						<%}else{ %>
				    	<html:text property="locId"   
				    			   styleClass="mytext" maxlength="20" style="width:125" onkeypress="upperOnly()" onchange="fnGetLoc1()"/>
				    	<%} %>
				    </TD>
					</logic:notEqual>
				    
				    <logic:equal name="RWS_USER" property="officeName" value="Circle Office">
				    <TD class="textborder">
					
						Circle LOC Id<font color="#FF6666">*</font>
					</TD>
				     <td>
				     <%if((session.getAttribute("EAmode")==null)||((String)session.getAttribute("EAmode")).equals("data"))
					{ %>
					<html:select property="circleLocId" 
									   style="width: 125px" styleClass="noborder-text-box" 
									   onchange='<%= "javascript: fnGetLoc()"%>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options  name="circleLocIdList" />
						</html:select>
						<%}else{ %>
				    	<html:text property="circleLocId"   
				    			   styleClass="mytext" maxlength="20" style="width:125" onkeypress="upperOnly()"/>
				    	<%} %>
					</td>
				    </logic:equal>
					
				    
				    <TD class="textborder">
				     
						LOC Reference<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="locReference"   
				    			   styleClass="mytext" maxlength="20" style="width:125" onkeypress="upperOnly()"/>
				    </TD>
				    <TD class="textborder">
				     
						LOC Rel Date<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="locRelDate"   
				    			   styleClass="mytext" style="width:100"  readonly="true" />
				    			   <a href="javascript: showCalendar(document.getElementById('locRelDate'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
						  </a>
				    </TD>
				</tr>
				<tr>
					<TD class="textborder">
				     
						LocAmount<font color="#FF6666">*</font>
					</TD>
					<TD class="bwborder">
				    	<html:text property="locAmount"   
				    			   styleClass="mytext"  style="width:125" onkeyup="extractNumber2(this,11,2,false);" onkeypress=" blockNonNumbers(this, event, true, false);" onblur="return checkWithBroAmtRemaining();"/>
				    </TD>
				    <TD class="textborder">
				     
						DWA Authorisation<br>Reference<font color="#FF6666"></font>
					</TD>
					<TD class="bwborder">
				    	<html:text property="dwaAuthorisationReference"   
				    			   styleClass="mytext"  style="width:125" onkeyup="extractNumber2(this,11,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    </TD>
				     <TD class="textborder">
				     
					DWA Authorisation<br>Date<font color="#FF6666"></font>
					</TD>
					 <TD class="bwborder">
				    	<html:text property="dwaAuthorisationDate"   
				    			   styleClass="mytext" style="width:100" onkeypress="upperOnly()" readonly="true"/>
				    			   <a href="javascript: showCalendar(document.getElementById('dwaAuthorisationDate'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
						  </a>
				    </TD>
				</tr>
				<tr>
				<logic:notEqual name="RWS_USER" property="officeCode" value="100000">
					<TD class="textborder">
				     
						Amount allocated for LOC<br><font style="font-family:Verdana; font-weight:normal; font-size:10px"></font>
					</TD>
					<TD class="bwborder">
				    	<html:text property="broRemainingAmountToBeAllocated"   
				    			   styleClass="mytext"  style="width:125" onkeyup="extractNumber2(this,11,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);" readonly="true"/>
				    </TD>
				    
				    </tr>
							
							<tr>
								<logic:present name="grantedAmtProgWiseList" scope="session">
		 						<td colspan="4">
								<fieldset><legend><b>Amount Allocated ProgrammeWise(Amount In Rs. Lakhs)</b></legend> <label>
								<table   width="100%" bgcolor="#ffffff" cellpadding="0" cellspacing="1" 
					  			 border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
				
									<tr class="clrborder">
										<td >Programme Name</td>
										<td>Amount Allocated</td>
										
										<logic:equal name="RWS_USER" property="officeName" value="Circle Office">
										<td>Amount Allocated To <br> Other CircleLOCs</td>
										</logic:equal>
										<td>Remaining Amount <br>After Allocating to Current LOC</td>
									</tr>
									<%progCount=0; %>
									<nested:iterate id="GRANTED_AMT_PROGWISE_LIST"
										name="grantedAmtProgWiseList">
									<%progCount++; %>
										<tr>
											<td class="bwborder" ><bean:write
												name="GRANTED_AMT_PROGWISE_LIST" property="programmeName" />
											<nested:hidden name="GRANTED_AMT_PROGWISE_LIST"
												property="programmeCode" indexed="true"/>
											<nested:hidden name="GRANTED_AMT_PROGWISE_LIST"
												property="programmeName" indexed="true"/></td>
											<td class="bwborder" ><bean:write
												name="GRANTED_AMT_PROGWISE_LIST" property="locAmount" /> <nested:hidden
												name="GRANTED_AMT_PROGWISE_LIST" property="locAmount" indexed="true"/></td>
											<logic:equal name="RWS_USER" property="officeName" value="Circle Office">
										    <td class="bwborder" ><bean:write
												name="GRANTED_AMT_PROGWISE_LIST" property="amountAllocatedToOtherCLOCIds" /> <nested:hidden
												name="GRANTED_AMT_PROGWISE_LIST" property="amountAllocatedToOtherCLOCIds" indexed="true"/></td>
											</logic:equal>
											<logic:notEqual name="RWS_USER" property="officeName" value="Circle Office">
										      <nested:hidden
												name="GRANTED_AMT_PROGWISE_LIST" property="amountAllocatedToOtherCLOCIds" indexed="true"/>
											</logic:notEqual>
											<td class="bwborder" > <nested:text
												name="GRANTED_AMT_PROGWISE_LIST" property="remainingAmountToBeAllocated" styleClass="gridtext" indexed="true" readonly="true"/></td>
										</tr>
									</nested:iterate>
								</table>
								</label></fieldset>
					</td>
					</logic:present>
					
					</logic:notEqual>
	
				
				</tr>
				
				</table>
			</label>
		</fieldset>
		<logic:equal name="RWS_USER" property="officeName" value="Division Office">
		<fieldset>
			<legend>Loc Amount Alloted to Works (Amount In Rs. Lakhs)</legend>
			<label>
				<table   width="50%" bgcolor="#ffffff" cellpadding="0" cellspacing="1" 
					  			 border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
				
					<tr class="clrborder">
									
					<TD >
					
						Work Id<font color="#FF6666">*</font>
					</TD>
					<TD >
					
						Work Name<font color="#FF6666">*</font>
					</TD>
					<TD >
					
						Amount Alloted<font color="#FF6666">*</font>
					</TD>
				</tr>
				
			<logic:present name="grantedAmtWorkWiseList">
			
				<nested:iterate id="GRANTED_AMT_WORKWISE_LIST"
						name="grantedAmtWorkWiseList">
				<tr class="bwborder">
				
					<%grantedAmtWorkWiseListCount++;%>
					<td>
					<nested:hidden
						name="GRANTED_AMT_WORKWISE_LIST" property="broId"
						indexed="true" /> 
					<nested:hidden name="GRANTED_AMT_WORKWISE_LIST"
						property="locId" indexed="true" />
					<bean:write	name="GRANTED_AMT_WORKWISE_LIST" property="workId" /> 
					<nested:hidden
						name="GRANTED_AMT_WORKWISE_LIST" property="workId" indexed="true" />
					</td>
					<td>
					<bean:write	name="GRANTED_AMT_WORKWISE_LIST" property="workName" /> 
					
					</td>
					<td>
					<bean:write	name="GRANTED_AMT_WORKWISE_LIST" property="locAmount" /> 
					<nested:hidden
						name="GRANTED_AMT_WORKWISE_LIST"
						property="locAmount" indexed="true" />
					</td>
				</tr>
				</nested:iterate>
				</logic:present>
			
				</tr>
				</table>
			</label>
		</fieldset>
		</logic:equal>
</td>
</tr>
<!-- BRO Details Begins Here -->
<tr>
	 		<td>
	 		  <div id="locProgDetailsTable" style="HEIGHT:100px; WIDTH:900; OVERFLOW:auto">
	 		  <table   width="100%" bgcolor="#ffffff" cellpadding="0" cellspacing="1" 
					   border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <tr class="clrborder">
					     <td class="clrborder" align="center">S.No.</td>
				 	     <td class="clrborder" align="center">District<font color="black">*</font></td>
					     <td class="clrborder" align="center">Programme<font color="black">*</font></td>
					     <td class="clrborder" align="center">Sub Programme<font color="black">*</font></td>
					     <td class="clrborder" align="center">Head Of Account<font color="black">*</font></td>
					     <td class="clrborder" align="center">LOC Date<font color="black">*</font></td>
					    
					    <logic:equal name="RWS_USER" property="officeName" value="Division Office">
					    <td class="clrborder" align="center">Work Description</td>
						 <td class="clrborder" align="center">Work Name</td>
						 <td class="clrborder" align="center">CricleLoc Id</td>						 
						</logic:equal>
					    <logic:equal name="RWS_USER" property="officeCode" value="100000">
					     <td class="clrborder" align="center">Project</td>
					  	 <td class="clrborder" align="center">Work Description</td>
						 <td class="clrborder" align="center"  nowrap>Work Name</td>

						</logic:equal>					
					     
					     <td class="clrborder" align="center">LOC Amount<font color="black">*</font></td>
					      <td class="clrborder" align="center">Division</td>
   					     <td class="clrborder" align="center">Place</td>
					     <td class="clrborder" align="center">PAO/APAO</td>
					     <td class="clrborder" align="center">Remarks</td>
					     <td class="clrborder" align="center">Action</td>
				 	  </tr>
					  <%count=0; %>
					  <nested:iterate id="LOC_DETAILS_LIST" name="locDetailsList"  >
				 	  <tr>
				 	  <td class="bwborder" align="center">
					  <%= ++count %>
					  </td>
					 <td class="bwborder" align="center">
					
					<logic:equal name="RWS_USER" property="officeCode" value="100000">
					<html:select name="LOC_DETAILS_LIST" style="width:150" property="district" styleClass="mycombo" indexed="true" onchange='<%="programmeChanged("+(count-1)+")" %>'>
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="districtList">
					<html:options collection="districtList" 
								  property="districtCode" labelProperty="districtName" />
					</logic:notEmpty>
					</html:select>
					</logic:equal>
					
					<logic:notEqual name="RWS_USER" property="officeCode" value="100000">
					<nested:text name="LOC_DETAILS_LIST" property="districtName" styleClass="gridtext" 
						    style="width:80px" indexed="true" onkeyup='<%="extractNumber2(this,11,2,false);locAmountChanged("+(count-1)+");getAmountRemainingProgrammeWise();checkRemainingProgAmount("+(count-1)+");" %>'  onkeypress="return blockNonNumbersNew(this, event, true, false)"/>
					<nested:hidden name="LOC_DETAILS_LIST" property="district" indexed="true"/>
					</logic:notEqual>
					
					</td> 
					<td class="bwborder" align="center">
					<html:select name="LOC_DETAILS_LIST" style="width:200" property="program" styleClass="mycombo" indexed="true" onchange='<%="programmeChanged("+(count-1)+")" %>'>
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="programmsList">
					<html:options collection="programmsList" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>
					</html:select>
					 
					  </td> 
					  <td class="bwborder" align="center">
					 <html:select name="LOC_DETAILS_LIST" property="subprogram"   styleClass="combo" indexed="true">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="LOC_DETAILS_LIST" property="subProgrammesList">
		 					  <nested:optionsCollection name="LOC_DETAILS_LIST" property="subProgrammesList" label="label" value="value"/>
						</logic:present>		  
	 				</html:select>
					   </td> 
					  <td class="bwborder" align="center" nowrap>
					 <html:text name="LOC_DETAILS_LIST" property="headOfAccount" style="width:250"  styleClass="mytext" indexed="true" />
					 <input type="button"  value="..." Class="btext" onclick='<%= "fnSelectHOA("+(count-1)+")"%>'/>       
					
					  </td> 
					  <TD class="bwborder" nowrap>
				    	<html:text  name="LOC_DETAILS_LIST" property="locDate"  indexed="true"  
				    			   styleClass="mytext" style="width:100" onkeypress="upperOnly()" readonly="true" />
				    		<a href="javascript: showCalendar(document.getElementById('LOC_DETAILS_LIST[<%=(count-1)%>].locDate'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle">
						  </a>
				    </TD>
					 <logic:equal name="RWS_USER" property="officeCode" value="100000">
					  <TD class="bwborder" align="center">
							<html:checkbox name="LOC_DETAILS_LIST" property="project"  indexed="true" onclick='<%="getOffices("+(count-1)+")" %>'/>
					  </TD>
					  <td>
						 <nested:text name="LOC_DETAILS_LIST" property="workDesc" styleClass="gridtext" 
						    style="width:80px" indexed="true" onkeyup='<%="locAmountChanged("+(count-1)+");getAmountRemainingProgrammeWise();checkRemainingProgAmount("+(count-1)+");" %>'/>
						
						</td>
						<td nowrap>
						
							<nested:text name="LOC_DETAILS_LIST" property="workId" styleClass="gridtext" style="width:100px" readonly="true" indexed="true"/>

								<html:button property="addWorkId1" value="..." styleClass="btext" onclick='<%= "fnSelectWorkId("+(count-1)+")"%>'/>
						</td>
						
						</logic:equal>
						<logic:equal name="RWS_USER" property="officeName" value="Division Office">
					     <td>
						 <nested:text name="LOC_DETAILS_LIST" property="workDescription" styleClass="gridtext" 
						    style="width:80px" indexed="true" onkeyup='<%="extractNumber2(this,11,2,false);locAmountChanged("+(count-1)+");getAmountRemainingProgrammeWise();checkRemainingProgAmount("+(count-1)+");" %>'  onkeypress="return blockNonNumbersNew(this, event, true, false)"/>
						
						</td>
						<td class="bwborder" align="center">
					 	   
						  <nested:select name="LOC_DETAILS_LIST" property="workId" style="width: 125px" styleClass="noborder-text-box" indexed="true" onchange='<%="checkWorkWiseAmount("+(count-1)+");checkForProjects("+(count-1)+")" %>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<logic:present name="LOC_DETAILS_LIST" property="workIdList">
		 					  <nested:optionsCollection name="LOC_DETAILS_LIST" property="workIdList" label="label" value="value"/>
							</logic:present>	
						</nested:select>
					 </td>
					 <td class="bwborder" align="center">
					 	   
						  <nested:select name="LOC_DETAILS_LIST" property="circleLocId" style="width: 125px" styleClass="noborder-text-box" indexed="true" onchange='<%="checkWorkWiseAmount("+(count-1)+");checkForWorks("+(count-1)+")" %>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<logic:present  name="circleLocIdList" scope="session">
		 					  <html:options  name="circleLocIdList" />
							</logic:present>	
						</nested:select>
					 </td>
						
						</logic:equal>
						
					  <td class="bwborder" align="center" >
					 	  <logic:equal name="RWS_USER" property="officeName" value="Division Office">
					      <nested:text name="LOC_DETAILS_LIST" property="locAmount" styleClass="gridtext" 
						    style="width:80px" indexed="true" onkeyup='<%="extractNumber2(this,11,2,false);getAmountRemainingProgrammeWise();locAmountChanged("+(count-1)+");checkRemainingProgAmount("+(count-1)+");checkWorkWiseAmount("+(count-1)+")" %>'  onkeypress="return blockNonNumbersNew(this, event, true, false)"/>
						   </logic:equal>
						   <logic:notEqual name="RWS_USER" property="officeName" value="Division Office">
					       <nested:text name="LOC_DETAILS_LIST" property="locAmount" styleClass="gridtext" 
						    style="width:80px" indexed="true" onkeyup='<%="extractNumber2(this,11,2,false);getAmountRemainingProgrammeWise();locAmountChanged("+(count-1)+");checkRemainingProgAmount("+(count-1)+")" %>'  onkeypress="return blockNonNumbersNew(this, event, true, false)"/>
						  </logic:notEqual>
						</td>
						
						<td class="bwborder" align="center">
						  <nested:select name="LOC_DETAILS_LIST" property="office" style="width: 150px" styleClass="noborder-text-box" indexed="true">
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<logic:present name="LOC_DETAILS_LIST" property="officeList">
							<nested:optionsCollection name="LOC_DETAILS_LIST" property="officeList" label="labelValue" value="value"/>
						</logic:present>
						</nested:select>
					 </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="LOC_DETAILS_LIST" property="place" styleClass="gridtext" style="width:100px"
						  indexed="true" onkeypress="upperOnly()"/>
					  </td>
					     <td class="bwborder" align="center">
			<!-- 	 	  <nested:text name="LOC_DETAILS_LIST" property="paoApaoFlag" styleClass="gridtext" style="width:100px"
						  indexed="true" />-->
					<html:select name="LOC_DETAILS_LIST" style="width:150" property="paoApaoFlag" styleClass="mycombo" indexed="true" >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<nested:optionsCollection name="LOC_DETAILS_LIST" property="paoList"/>
					</html:select>  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="LOC_DETAILS_LIST" property="remarks" styleClass="gridtext" style="width:100px"
						  indexed="true"  maxlength="30" onkeypress="upperOnly()"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <a href="#1"  onclick="deleteLOCDetails(<%=count-1%>)">Delete</a>
					  </td>
					  </tr>
					  
					  </nested:iterate>
						<%if((session.getAttribute("EAmode")==null)||((String)session.getAttribute("EAmode")).equals("data"))
						{ %>
							<%if(count==0){ %>
								<tr><td colspan="20" align="center">No Records</td></tr>
							<%} %>
						<%} %>
					  <tr>
					  <td colspan="20" bgcolor="#DEE3E0">
					  
					  <table rules=none border=0 width="100%">
					  <tr>
					  
					  <TD class="bwborder" valign="top">
				    	<font style="font-family:Verdana; font-weight:normal; font-size:10px">BRO Amount Remaining (Including Current LOC)</font>
				    	<html:text property="remainingAmountToBeAllocated"  
				    			   styleClass="gridtext"  style="width:80;background-color:#DEE3E0;"  onkeyup="extractNumber2(this,11,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);" readonly="true"/>
				    </TD>
					  <td colspan="12" align="right" title="" bgcolor="#DEE3E0" ><input type="button" class="btext" value="Add New" onclick="addNewProgrammForLoc(<%= count %>)"> </td></tr>
					  </tr>
					  </table>
					  
					  
					  </td>
					  </table>
					  </div>
	 		       </td>
	 		      </tr>
	 				

<!-- End of BRO Details -->
<tr>
<td align="center">
<%if((session.getAttribute("EAmode")==null)||((String)session.getAttribute("EAmode")).equals("data"))
{ %>
<input type="button" class="btext" value="Update" onclick="fnSave()">&nbsp;
<input type="button" class="btext" value="Add New" onclick="fnAddNewLoc()">&nbsp;
<input type="button" class="btext" value="Delete" onclick="fnDeleteLoc()">&nbsp;
<script language="javascript">
mode="data";
</script>
<%}else{ %>
<input type="button" class="btext" value="Save" onclick="fnSave()">&nbsp;
<input type="button" class="btext" value="Edit" onclick="fnEdit()">&nbsp;
<script language="javascript">
mode="nonData";
</script>
<%} %>


<input type="button" class="btext" value="View" onclick="fnView()">




</td>

</tr></table>

</td></tr></tbody>
</table>


</html:form>
</body>
<script language="javascript">
function initFunc()
{
<%if(count==0){%>
document.getElementById("locProgDetailsTable").style.height=100;
<%}else{%>
document.getElementById("locProgDetailsTable").style.height=<%=((count*26)+100)%>;
<%}%>
}
var detaildate,locreleasedate;



function checkForm()
{
	
	var validationSucceded=true;
	var locDetSum=0;
	var locAmt=parseFloat(document.getElementById("locAmount").value);
	 locreleasedate  = document.forms[0].locRelDate.value;
	if(document.forms[0].locId.value=="")
	{
		alert("LOC Id is Mandatory");
		document.forms[0].locId.focus();
		validationSucceded = false;
	}
	else if(document.forms[0].broId.value=="")
	{
		alert("BRO Id is Mandatory");
		document.forms[0].broId.focus();
		validationSucceded = false;
	}
	
	<%
//	// System.out.println("count:"+count);
	if(count == 0)
	{%>
		alert("Atleast One Record is Mandatory In LOC List");
		return false;
	<%}%>
	
	var projcheck,workidforloc;
	
	for(var i=0;i<<%=count%>;i++)
	{

	
		if(document.getElementById("LOC_DETAILS_LIST["+i+"].district").value!=""
		||document.getElementById("LOC_DETAILS_LIST["+i+"].program").value!=""
		||document.getElementById("LOC_DETAILS_LIST["+i+"].subprogram").value!=""
		||document.getElementById("LOC_DETAILS_LIST["+i+"].headOfAccount").value!=""
		||document.getElementById("LOC_DETAILS_LIST["+i+"].locDate").value!=""
		||document.getElementById("LOC_DETAILS_LIST["+i+"].office").value!=""
		||document.getElementById("LOC_DETAILS_LIST["+i+"].place").value!=""
		||document.getElementById("LOC_DETAILS_LIST["+i+"].paoApaoFlag").value!=""
		||document.getElementById("LOC_DETAILS_LIST["+i+"].remarks").value!="")
		{
			detaildate=document.getElementById("LOC_DETAILS_LIST["+i+"].locDate").value;
			workidforloc=document.getElementById("LOC_DETAILS_LIST["+i+"].workId").value.length;
			projcheck=document.getElementById("LOC_DETAILS_LIST["+i+"].project").checked;
			
			if(projcheck==true)
			document.getElementById("LOC_DETAILS_LIST["+i+"].project").value="on";
			else
			document.getElementById("LOC_DETAILS_LIST["+i+"].project").value="off";
			if(projcheck==true&&workidforloc<1)
			{
			alert("Please select workid for the Loc List with S.No"+(i+1));
			return false;
			}
			
			
				//if(document.getElementById("LOC_DETAILS_LIST["+i+"].project").checked==true&&document.getElementById("LOC_DETAILS_LIST["+i+"].workId").length<14)
				//==true&&document.getElementById("LOC_DETAILS_LIST["+i+"].workId").length<14){
			//document.getElementById("LOC_DETAILS_LIST["+i+"].workId").value="";
			//}
			if(projcheck==false&&workidforloc>13){
			alert("Please check the project for the Loc List with S.No"+(i+1));
			return false;
			//alert(document.getElementById("LOC_DETAILS_LIST["+i+"].project").value)
			}
			if(document.getElementById("LOC_DETAILS_LIST["+i+"].district").value==""){
				alert("Please Enter value for District For LOC  with S.No "+(i+1));
				document.getElementById("LOC_DETAILS_LIST["+i+"].district").focus();
				return false;
			}		
			else if(document.getElementById("LOC_DETAILS_LIST["+i+"].program").value==""){
				alert("Please Select Programme for Loc List with S.No "+(i+1));
				document.getElementById("LOC_DETAILS_LIST["+i+"].program").focus();
				return false;
			}
			else if(document.getElementById("LOC_DETAILS_LIST["+i+"].subprogram").value==""){
				alert("Please Select Sub Programme for Loc List with S.No "+(i+1));
				document.getElementById("LOC_DETAILS_LIST["+i+"].subprogram").focus();
				return false;
			}
			else if(document.getElementById("LOC_DETAILS_LIST["+i+"].headOfAccount").value==""){
				alert("Please Enter Head Of Account for LOC List with S.No "+(i+1));
				document.getElementById("LOC_DETAILS_LIST["+i+"].headOfAccount").focus();
				return false;
			}
			else if(document.getElementById("LOC_DETAILS_LIST["+i+"].locDate").value==""){
				alert("Please Enter value for Loc Date For LOC  with S.No "+(i+1));
				document.getElementById("LOC_DETAILS_LIST["+i+"].locDate").focus();
				return false;
			}
			else if(checkLocDetailDate(locreleasedate,detaildate)){
				alert("LOC Detail Date Cannot Less Than LOC Release Date");
				document.getElementById("LOC_DETAILS_LIST["+i+"].locDate").focus();
				return false;			
			}
			else if(document.getElementById("LOC_DETAILS_LIST["+i+"].locAmount").value==""){
				alert("Please Enter value for Loc Amount For LOC  with S.No "+(i+1));
				document.getElementById("LOC_DETAILS_LIST["+i+"].locAmount").focus();
				return false;
			}
			locDetSum+=parseFloat(document.getElementById("LOC_DETAILS_LIST["+i+"].locAmount").value);
			
		}	
					
	}
	

	var str1  = document.forms[0].brodate.value;
   var str2  = document.forms[0].locRelDate.value;
   var dt1   = parseInt(str1.substring(0,2),10);
   var mon1  = parseInt(str1.substring(3,5),10);
   var yr1   = parseInt(str1.substring(6,10),10);
   var dt2   = parseInt(str2.substring(0,2),10);
   var mon2  = parseInt(str2.substring(3,5),10);
   var yr2   = parseInt(str2.substring(6,10),10);
   var date1 = new Date(yr1, mon1, dt1);
   var date2 = new Date(yr2, mon2, dt2);

   if(date2 < date1)
   {
		alert("LOC Date Cannot Less Than BRO Issued Date");
		var c = <%=count%>
		validationSucceded=false;
   }  
   else if(locAmt<locDetSum){
	alert("LOC  SUM Should Be Less Than Loc Amount");
	validationSucceded=false;
   }
   
   
	return validationSucceded;
}


function checkLocDetailDate(locreldate,detaildate)
{

   var dt1   = parseInt(locreldate.substring(0,2),10);
   var mon1  = parseInt(locreldate.substring(3,5),10);
   var yr1   = parseInt(locreldate.substring(6,10),10);
   var dt2   = parseInt(detaildate.substring(0,2),10);
   var mon2  = parseInt(detaildate.substring(3,5),10);
   var yr2   = parseInt(detaildate.substring(6,10),10);
   var date1 = new Date(yr1, mon1, dt1);
   var date2 = new Date(yr2, mon2, dt2);
   
   if(date2<date1)
   return true;
   else 
   return false;
}



function locAmountChanged(index)
{
	var locAmount=document.getElementById("LOC_DETAILS_LIST["+index+"].locAmount").value;

var locdetcnt=0,locAmount1=0;
for(locdetcnt=0;locdetcnt<=index;locdetcnt++)
locAmount1+=parseFloat(document.getElementById("LOC_DETAILS_LIST["+locdetcnt+"].locAmount").value);

	var locAmt=document.getElementById("locAmount").value;
	/*if(locAmount1>locAmt){
	alert("Loc Details Amount <= Loc Amount"); 
	document.getElementById("LOC_DETAILS_LIST["+index+"].locAmount").focus();
	}*/
	if(isInNumberFormat)
	{
		remainingAmtIncludingCurrentLoc=getBroRemainingAmtInclCurrentLoc();

		if(remainingAmtIncludingCurrentLoc<0)
		{
			document.getElementById("LOC_DETAILS_LIST["+index+"].locAmount").value="";
		}
		if(!isNaN(getBroRemainingAmtInclCurrentLoc()))
		{
		document.forms[0].remainingAmountToBeAllocated.value=getBroRemainingAmtInclCurrentLoc();
		}
		document.forms[0].remainingAmountToBeAllocated.value=roundNumberToSpefiedDecimal(document.forms[0].remainingAmountToBeAllocated.value,2);
	}
	
}
</script>



<logic:notEqual name="RWS_USER" property="officeName" value="Circle Office">
<script language="javascript">
function getBroRemainingAmtInclCurrentLoc()
{
	var broAmtRemainingExclCurrentLoc=parseFloat(document.forms[0].broRemainingAmountToBeAllocated.value);
	var broAmtRemainingInclCurrentLoc=broAmtRemainingExclCurrentLoc;
	if(document.forms[0].broRemainingAmountToBeAllocated.value!="")
	{
		for(var i=0;i<<%=count%>;i++)
		{
			if(document.getElementById("LOC_DETAILS_LIST["+i+"].locAmount").value!="")
			{
				broAmtRemainingInclCurrentLoc=broAmtRemainingInclCurrentLoc-parseFloat(document.getElementById("LOC_DETAILS_LIST["+i+"].locAmount").value);
			}
			
		}
	}
	else
	{
		return 0;
	}
	return broAmtRemainingInclCurrentLoc;
}
</script>
</logic:notEqual>

<logic:equal name="RWS_USER" property="officeName" value="Circle Office">
<script language="javascript">
function getBroRemainingAmtInclCurrentLoc()
{
	
	return CLOCRemainingAmount;
}
</script>
</logic:equal>

<script language="javascript">
function roundNumberToSpefiedDecimal(numberToBeRounded,rlength) {
//numberField is the filed whose value to be rounded
//rlength is the no of decimal places to which it is to be rounded
	//var rnum = numberField.value;
	var rnum = numberToBeRounded;
	var rlength = 2; // The number of decimal places to round to
	if (rnum > 8191 && rnum < 10485) {
		rnum = rnum-5000;
		var newnumber = Math.round(rnum*Math.pow(10,rlength))/Math.pow(10,rlength);
		newnumber = newnumber+5000;
	} else {
		var newnumber = Math.round(rnum*Math.pow(10,rlength))/Math.pow(10,rlength);
	}
	//numberField.value = newnumber;
	return newnumber;
}


function checkRemainingProgAmount(index)
{
//for checking amt programme wise
	if(isInNumberFormat)
	{
		var locAmt=document.getElementById("LOC_DETAILS_LIST["+index+"].locAmount").value;
		var locProgrammeCode=document.getElementById("LOC_DETAILS_LIST["+index+"].program").value
		var locProgRemainingAmt="";
		if(locAmt=="")
			locAmt="0";
		for(var i=0;i<<%=progCount%>;i++)
		{
			var remainingAmount=parseFloat(document.getElementById("GRANTED_AMT_PROGWISE_LIST["+i+"].locAmount").value);
			var progCode=document.getElementById("GRANTED_AMT_PROGWISE_LIST["+i+"].programmeCode").value
			if(locProgrammeCode==progCode)
			{
				locProgRemainingAmt=document.getElementById("GRANTED_AMT_PROGWISE_LIST["+i+"].remainingAmountToBeAllocated").value;
			}
		}
		if(locProgRemainingAmt=="")
		locProgRemainingAmt="0";
		var locProgRemainingAmtFloatValue=parseFloat(locProgRemainingAmt);
		if(!isNaN(locProgRemainingAmtFloatValue))
		{
			if(locProgRemainingAmtFloatValue<0)
			{
				alert("Ammount exceeds the amount alloted to the program");
				document.getElementById("LOC_DETAILS_LIST["+index+"].locAmount").value="";
				getAmountRemainingProgrammeWise();
				locAmountChanged(index)
			}
		}
	}


}


function getAmountRemainingProgrammeWise()
{

	var programmeCode="";
	CLOCRemainingAmount=0;
	for(var i=0;i<<%=progCount%>;i++)
	{
		if(document.getElementById("GRANTED_AMT_PROGWISE_LIST["+i+"].amountAllocatedToOtherCLOCIds").value=="")
			document.getElementById("GRANTED_AMT_PROGWISE_LIST["+i+"].amountAllocatedToOtherCLOCIds").value="0";
		var remainingAmount=parseFloat(document.getElementById("GRANTED_AMT_PROGWISE_LIST["+i+"].locAmount").value)-parseFloat(document.getElementById("GRANTED_AMT_PROGWISE_LIST["+i+"].amountAllocatedToOtherCLOCIds").value);
		var progCode=document.getElementById("GRANTED_AMT_PROGWISE_LIST["+i+"].programmeCode").value
		for(var j=0;j<<%=count%>;j++)
		{
			
			if(progCode==document.getElementById("LOC_DETAILS_LIST["+j+"].program").value)
			{
				var locAmt=document.getElementById("LOC_DETAILS_LIST["+j+"].locAmount").value;
				if(locAmt=="")
					locAmt="0";
				remainingAmount=remainingAmount-parseFloat(locAmt);
				
			}
		}
		//alert("before "+CLOCRemainingAmount);
		if(!isNaN(remainingAmount))
		{
			document.getElementById("GRANTED_AMT_PROGWISE_LIST["+i+"].remainingAmountToBeAllocated").value=remainingAmount;
			CLOCRemainingAmount=CLOCRemainingAmount+remainingAmount;
		}
		//alert("after "+CLOCRemainingAmount);
	}
}

</script>

<logic:equal name="RWS_USER" property="officeName" value="Division Office">
<script language="javascript">
function checkWorkWiseAmount(index)
{
	//alert("in checkWorkWiseAmount");
	var workId=document.getElementById("LOC_DETAILS_LIST["+index+"].workId").value
	var totalAmountAllotedToWork=0;
	for(var j=0;j<<%=count%>;j++)
	{
		//if(!isNaN(document.getElementById("LOC_DETAILS_LIST["+j+"].workId").value)
		//{
			if(document.getElementById("LOC_DETAILS_LIST["+j+"].locAmount").value!="")
			{
				if(workId==document.getElementById("LOC_DETAILS_LIST["+j+"].workId").value)
					totalAmountAllotedToWork=totalAmountAllotedToWork+parseInt(document.getElementById("LOC_DETAILS_LIST["+j+"].locAmount").value,10);
			}
		//}
	}
	for(var i=0;i<<%=(grantedAmtWorkWiseListCount+1)%>;i++)
	{
		if(workId==document.getElementById("GRANTED_AMT_WORKWISE_LIST["+i+"].workId").value)
		{
			//alert("total amount in this loc="+totalAmountAllotedToWork);
			//alert("total amount alloted="+document.getElementById("GRANTED_AMT_WORKWISE_LIST["+i+"].locAmount").value);
			if(totalAmountAllotedToWork>parseInt(document.getElementById("GRANTED_AMT_WORKWISE_LIST["+i+"].locAmount").value,10))
			{
				alert("Total Amount for this work is greater than alloted. \nAlloted amount is "+document.getElementById("GRANTED_AMT_WORKWISE_LIST["+i+"].locAmount").value);
				document.getElementById("LOC_DETAILS_LIST["+index+"].locAmount").value="";
				//recalculate the values
				locAmountChanged(index);
				getAmountRemainingProgrammeWise();
				checkRemainingProgAmount(index);
			}
		}
	}
	
	

}


</script>
</logic:equal>



<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

