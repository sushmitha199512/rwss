<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%

int count = 0;
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();

String md=request.getParameter("mode");
String md1=request.getParameter("mode1");



%>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
<style>
.btext2
{
	border-width:1;
	border-color:#000000;
	color:#660099;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}
.btext1
{
	text-transform:uppercase;
	color:green;
	
}
.btext3
{
	
	color:red;
font-weight:bold;
	
}
</style>
<STYLE>
fieldset { border:1px solid green }
legend {
  padding: 0.2em 0.5em;
  border:1px solid green;
  color:green;
  font-size:90%;
  text-align:right;
  }
.tstyle {

	background: transparent url('images/bg.jpg') no-repeat;
	color : #747862;
	height:20px;
	border:0;
	padding:4px 8px;
	margin-bottom:0px;
}


</STYLE>

<script  language="javascript" >



function getDivisions()
	{

	 document.forms[0].action="switch.do?prefix=/masters&page=/WorkContractorBind.do&mode=data&mode1=Divisions";
		document.forms[0].submit();
	
	}
function getWorkcategory()
	{
	  document.forms[0].action="switch.do?prefix=/masters&page=/WorkContractorBind.do&mode=data&mode1=workcategory";
	  monitoringForm.submit();
	}
function getSubDivisions()
	{
	
		document.forms[0].action="switch.do?prefix=/masters&page=/WorkReleases.do&mode=data";
		monitoringForm.submit();
	}


function getWorks()
{
	
	document.forms[0].action="switch.do?prefix=/masters&page=/WorkContractorBind.do&mode=data&mode1=getworks";
	document.forms[0].submit();
	
}
function getYears()
{
	
	document.forms[0].action="switch.do?prefix=/masters&page=/WorkContractorBind.do&mode=data&mode1=getYears";
	document.forms[0].submit();
	
}
function getPrograms()
{
	
	document.forms[0].action="switch.do?prefix=/masters&page=/WorkContractorBind.do&mode=data&mode1=getPrograms";
	document.forms[0].submit();
	
}



function getWorkDetails()
{
	if(document.forms[0].elements["workIdList"].value==""){
		alert("Please Enter  Work Id.");
		return false;
		}
	document.forms[0].action="switch.do?prefix=/masters&page=/WorkContractorBind.do&mode=data&mode1=workdetails";
	document.forms[0].submit();
	
}


function addNew(){
	document.getElementById('allc').style.display='block';
	
	
}

function fnSave()
{

if(document.forms[0].elements["workIdList"].value==""){
alert("Please Select Work.");
return false;
}

if(document.forms[0].elements["ccode"].value==" "){
alert("Please Select Contractor");
return false;
}

 document.forms[0].action="switch.do?prefix=/masters&page=/WorkContractorBind.do&mode=data&mode1=save";
        document.forms[0].submit();
}

function fnDelete(code){

   if(confirm("Are you confirm to delete contractor ("+code +")  Details")){
	document.forms[0].action="switch.do?prefix=/masters&page=/WorkContractorBind.do&mode=data&mode1=delete&contractor="+code;
    document.forms[0].submit();
   }

}


</script>

</head>



<html:form action="WorkContractorBind.do">


<body>
<table>
<tr><td align="right">
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>


</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Contractor Work Bind Form " />
	<jsp:param name="TWidth" value="930" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD"  rules="none" width="1000" border=1 style="border-collapse:collapse;" >

<table   bgcolor="ffffe0" width="960" bordercolor= "#8A9FCD" >
<tr><td>
	<fieldset>
		<legend><b>Office Details</b></legend>
	
			<table  width="960" border=0 style="border-collapse:collapse;" >
<tr>
			<td class="btext2" align="right">Enter Work ID<font color="red"><b>*</b></font></td><td>&nbsp;&nbsp;&nbsp;<html:text property="workIdList" size="20" maxlength="14"   />&nbsp;&nbsp;&nbsp;<input type="button" onclick="getWorkDetails()" value="Get Details"></input></td>	

<td class="btext2">Circle:<html:text property="circle"  readonly="true"></html:text></td><td class="btext2">Division:<html:text property="division" readonly="true"></html:text></td>
</tr>

</table>
	</fieldset>
</td>
</tr>
<tr>
<td>
<fieldset >
   	<legend  ><B>Work Details</B></legend>
	<table width="900" border=0 style="border-collapse:collapse;">
			<tr>
			
			<td class="btext2" align="right">Work ID</td><td><html:text property="workid" size="20" maxlength="20"  disabled="true" /></td>

			<td class="btext2" align="right">Work Name</td><td colspan="3"><html:text property="workName" size="80"  disabled="true" /></td>
</tr>
<tr>
			<td class="btext2" align="right">Program</td><td><html:text property="program" size="20"  disabled="true" /></td>
			<td class="btext2" align="right">SubProgram</td><td><html:text property="subProgName" size="20"  disabled="true" /></td>
			<td class="btext2" align="right">Sanction Date</td><td><html:text property="sanctionedDate" size="20"  disabled="true" /></td></tr>
<tr>
			<td class="btext2" align="right">Sanction&nbsp;Amount<td><html:text property="sanctionedAmount" size="20"  disabled="true" /></td></td>
<td class="btext2" align="right">MileStone&nbsp;Amount</td><td><html:text property="mileStoneAmount"  size="20"  disabled="true" /></td>
</tr>
			
		</table>
	</fieldset>
</td>
</tr>
<td>
<fieldset >
   	<legend  ><B>Contractor Details</B></legend>
	<table width="900" border=1 style="border-collapse:collapse;" >
	
	
	
	
<tr >
    <td  class="btext" align=left>Sl.No</td>
	
	<td  class="btext" align="left">Contractor Name</td>
	<td  class="btext" align="left">Contractor Code</td>
	<td  class="btext" align="left">Bank Name</td>
	<td  class="btext" align="left">Branch Name</td>
	<td  class="btext" align="left">IFSC Code</td>
	<td  class="btext" align="left">Account Number</td>
	<td  class="btext" align="left">Delete</td>
	</tr>


<logic:iterate id="contractRec" name="workconrtactbind" property="contractorList" indexId="index">

<logic:equal  name="contractRec"  property="primaryContractor" value="yes" >
<% count=count+1;%>
<tr align="left" id='tr<%=count%>' style="color: white; background: orange;"   onmouseover="this.style.background='green'" onmouseout="this.style.background='orange'" >
</logic:equal>
<logic:equal  name="contractRec"  property="primaryContractor" value="">
<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
</logic:equal>

<td   ><%=count %></td>

<td   class="rptValue" align="left">
<bean:write name="contractRec" property="contractorName"  /></td>
<td  class="rptValue" align="left">
<bean:write name="contractRec" property="contractorCode" /></td>
<td  class="rptValue" align="left">
<bean:write name="contractRec" property="bankName" /></td>




<td class="rptValue" align="left">&nbsp;<bean:write name="contractRec" property="branchName"/></td>
<td class="rptValue"  align="left">
<bean:write name="contractRec" property="ifscCode" /></td>

<td class="rptValue"  align="left">
<bean:write name="contractRec" property="accountNo" /></td>

<logic:equal  name="contractRec"  property="primaryContractor" value="" >

<td class="rptValue"  align="right">
<IMG SRC="<rws:context page='/images/delete.jpg'/>" WIDTH="20" HEIGHT="20" onclick="fnDelete('<bean:write name="contractRec" property="contractorCode" />')" style="cursor:hand" >
</td>
</logic:equal>
<logic:equal  name="contractRec"  property="primaryContractor" value="yes" >
<td></td>
</logic:equal>
	</tr>
	</logic:iterate>
		
	
<tr>
	<td colspan="2" align="left">
	<input type="button"  class="btext2" value="Add New" onclick="return addNew()"/>
	 </td>
	 </tr>
			
		</table>
		
		
	 
	 <div style="display:none" id="allc">
	 <table>
	 <logic:present name="allContractorsList">
						<td class="btext2" >Select Contractor</td>`
						<td class="btext2" ><html:select property="ccode"
							style="width:460px" styleClass="mycombo">
							<html:option value=" ">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="allContractorsList" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present>
				
				<td><input type="button"  class="btext2" value="Save" onclick="return fnSave()"/></td>
</table>
</div>
	</fieldset>
</td>
</tr>


</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="930"/>
</jsp:include>


<%@ include file="/commons/rws_footer.jsp"%>
</table>
</body>
</html:form>
<%
 if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess)
	</script>
<%
 } %>