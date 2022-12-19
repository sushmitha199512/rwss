<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>



<head>



<title>PAO Bills  EE-Budget</title>
<style>
.diva
{
	width:14px;
	height:14px;
	clip:rect(0,14,14,0);
	overflow:hidden;
}
.spana
{
background-color:red;
position:relative;
top:-3px;
left:-3px;
}
.checka
{
margin:0;
padding:0;
FILTER:progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=50)-moz-opacity:0.1;
}
.mytext
{
	height:20px;
	font-size:11px;
	color:green;
	font-style:bold;
	
}
.thumbnail{
position: relative;
z-index: 0;
}

.thumbnail:hover{
background-color: transparent;
z-index: 60;
}

.thumbnail span{ /*CSS for enlarged image*/
position: absolute;
background-color: lightyellow;
padding: 4px;
left: -1000px;
border: 1px dashed gray;
visibility: hidden;
color: black;
text-decoration: none;
}

.thumbnail span img{ /*CSS for enlarged image*/
border-width: 0;
padding: 2px;
}

.thumbnail:hover span{ /*CSS for enlarged image on hover*/
visibility: visible;
top: -120px;
left: -350px; /*position where enlarged image should offset horizontally */

}
</style>
<script language="javascript">
/* function openFile(workId,bslno)
{
	var URL="./switch.do?prefix=/works&page=/WorkStatus.do&mode=showScannedCopy&slNo="+bslno+"&workId="+workId;
var popFeatures = "width=800,height=550,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
} */
function openFile(index)
{
  var workid=document.forms[0].elements["billsList["+index+"].workId"].value;
  var bslno=document.forms[0].elements["billsList["+index+"].billSlNo"].value;
  var billdates=document.forms[0].elements["billsList["+index+"].billDate"].value;
	var URL="./switch.do?prefix=/works&page=/WorkStatus.do&mode=showScannedCopy&slNo="+bslno+"&workId="+workid+"&billDate="+billdates;
var popFeatures = "width=800,height=550,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
function checkAll()
{
	var count=document.forms[0].elements["resultCount"].value;
	for(i=0;i<count;i++){
		document.forms[0].elements["billsList["+i+"].checks"].checked= true ;
	}
}

function unCheckAll()
{
	var count=document.forms[0].elements["resultCount"].value;
	for(i=0;i<count;i++){
		document.forms[0].elements["billsList["+i+"].checks"].checked= false ;
	}
}
function check(val){
	
	
	
	
}

function viewReport(){
	var url="./masters/rws_bill_selected_to_encbank_rpt.jsp";
	
	
	  var properties="width=648,height=562,toolbar=no,status=yes,menubar=no,location=no,directories=no scrollbars=yes,copyhistory=no,resizable=yes";
	     newWindow1 = window.open(url, "_New", properties);
	
	
	
}
function getBills(){
	
var circle=document.forms[0].elements['circleCode'].value;
var divCode=document.forms[0].elements['divCode'].value;
var year=document.forms[0].elements['yearCode'].value;
var mnth=document.forms[0].elements['monthCode'].value;;

 if(circle=="0"){
        alert("Please Select Circle");
        return false;
 }
 if(divCode=="0"){
     alert("Please Select Division");
     return false;
}
 if(year=="0"){
     alert("Please Select Year");
     return false;
}
 if(mnth=="0"){
     alert("Please Select Month");
     return false;
}

	
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/BANKBillAction.do&mode=billsList";	
	document.forms[0].submit();
}

function getDivisions(){
	
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/BANKBillAction.do&mode=divisions";	
	document.forms[0].submit();
	
}

function fnCalStatePer(val)
{
	
	if(parseFloat(document.forms[0].elements["billsList["+val+"].recomandedGOI"].value)>parseFloat(document.forms[0].elements["billsList["+val+"].recomandedActual"].value))
	{
		document.forms[0].elements["billsList["+val+"].recomandedStatePer"].value = '0';
		document.forms[0].elements["billsList["+val+"].recomandedGOI"].value='0';
		alert("State Amount of Now Recommended Should be in Less than or equal to Actual Amount of Now Recommended");
	}
	else
	{
		var value = ((parseFloat(document.forms[0].elements["billsList["+val+"].recomandedGOI"].value))/(parseFloat(document.forms[0].elements["billsList["+val+"].dueActual"].value)))*100;
		if(value=="" || value == null || isNaN(value))
		{
			document.forms[0].elements["billsList["+val+"].recomandedStatePer"].value = '0';
		}
		else
		{
			document.forms[0].elements["billsList["+val+"].recomandedStatePer"].value  = value;//formatter.format(((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
		}
	}
	fnDisable(val);
}
function fnCalState(val)
{
	
	 
	if(parseInt(document.forms[0].elements["billsList["+val+"].recomandedStatePer"].value)>100)
	{
		document.forms[0].elements["billsList["+val+"].recomandedStatePer"].value = '0';
		document.forms[0].elements["billsList["+val+"].recomandedGOI"].value='0';
		alert("State Percentage Should be in Between 1-100");
	} 
	else
	{
		
		var value = parseFloat(document.forms[0].elements["billsList["+val+"].recomandedActual"].value)*((parseFloat(document.forms[0].elements["billsList["+val+"].recomandedStatePer"].value))/100);
		if(isNaN(value))
		{
			
			document.forms[0].elements["billsList["+val+"].recomandedGOI"].value = '0';
		}
		else
		{
			document.forms[0].elements["billsList["+val+"].recomandedGOI"].value =  Math.round((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
		}
	}
	fnDisable(val);
}	

function fnDisable(val)
{
	
	var length= document.getElementById('resultCount').value;
	for(var i=0;i<length;i++)
	{
		if(val==i)
		{
			if(parseFloat(document.forms[0].elements["billsList["+val+"].recomandedStatePer"].value)>0 || document.forms[0].elements["billsList["+val+"].recomandedStatePer"].value=="0.0")
			{
				document.forms[0].elements["billsList["+k+"].checks"].disabled=false;			
			}
			else
			{
				document.forms[0].elements["billsList["+k+"].checks"].disabled=true;
			}
		}
	}
}
function fnCheckMax(val)
{
	fnCalState(val);
	fnCalCentral(val);
	if((parseFloat(document.forms[0].elements["totc"+val].value))>(parseFloat(document.forms[0].elements["tota"+val].value)))
	{
		document.forms[0].elements["totc"+val].value = '0';
		document.forms[0].elements["statec"+val].value = '0';
		document.forms[0].elements["goic"+val].value = '0';
		alert("Now Recommended Amount Should be Less than or Equal to Bill Amount Due");
	}
	fnDisable(val);
}


function fnSave(){
	
	
	var length=document.forms[0].elements["resultCount"].value;
	
	
	
 var flag=true;
	length= length-1;
	var workList="";
	var selectedCount=0;
	for(var k=0;k<length;k++)
		{		
		if(document.forms[0].elements["billsList["+k+"].checks"].checked)
		 {
			if(parseFloat(document.forms[0].elements["billsList["+k+"].recomandedGOI"].value)=="0.0"){
				
				alert("Record("+(k+1)+") Recommended GOI amount is mandatory.");
				document.forms[0].elements["billsList["+k+"].recomandedGOI"].focus=true;
				return;
			}
			if(parseFloat(document.forms[0].elements["billsList["+k+"].recomandedGOI"].value)>parseFloat(document.forms[0].elements["billsList["+k+"].dueActual"].value)){
				alert("Record("+(k+1)+")     Recommended Bank Amount should not be more than Bill Amount Due in State.");
				document.forms[0].elements["billsList["+k+"].recomandedGOI"].focus=true;
				return;
			}
			workList+=document.forms[0].elements["billsList["+k+"].workId"].value+document.forms[0].elements["billsList["+k+"].billSlNo"].value;
			workList+="@";
			selectedCount+=1;
	     }
		}
	  if(!flag)
	   {
		 alert("Select atleast one check box to save");
     }
	  else{
		   
		  if(confirm("Are You Sure want to Save")) {
			  document.forms[0].elements["selectedRecords"].value = workList;
			 document.forms[0].action="switch.do?prefix=/fundAccounting&page=/BANKBillAction.do&mode=save";//&selectedRecords="+workList;
            document.forms[0].submit();
            
           
			}
		  
		 
	  }
	
	
}
function workPhysicalStatus(workid)
{
		var zURL = "./switch.do?prefix=/fundAccounting&page=/BANKBillAction.do&mode=milestones&workid="+workid;
		var popFeatures = "width=950,height=500,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL,'habs',popFeatures);
		myWin.focus();
	
}
</script>

</head>
<body>
<html:form  action="BANKBillAction.do" method="post"  >

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

			<table  border=0 rules=none style="border-collapse:collapse" align="right" >		
				<tr>
					<td align="right" class="bwborder">
							<a href="<rws:context page='/home.jsp'/>" >My Home</a><a href="#" onclick="window.print()" >&nbsp;&nbsp;<img src="<rws:context page='/images/print_icon.jpg'/>" width="30" height="30"></a>

					</td>
				</tr>
			</table>


		<table align=center>
		<tr  align="center">
			<td class="rptHeading"  align="center">Bank - Payment Due and Releases Entry Form</td>
			<td class="rptHeading"   align="center">
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)</font><b style="font-family: Rupee Foradian;">`</b>
			
			<input type="button"  value="View Selected Bills Division Wise" class="btext" onclick="viewReport()">
			</td>	
		</tr>
		 <tr bgcolor="#E1F0FB">
                
            <td>
              
            </td>  <td>
            </td>  <td>
            </td>
                
				
          </tr>
		</table>
		
<table>

<logic:present name="circles">
					
						<td class="textborder">Circle<span class="mandatory">*</span></td>
						<td class="textborder"><html:select  property="circleCode" 
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getDivisions();">
							<html:option value="0">
								<font class="myfontclr1">Select...</font>
							</html:option>
							<html:options collection="circles" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:present>
					
					<logic:present name="divisions">
					
						<td class="textborder">Division<span class="mandatory">*</span></td>
						<td class="textborder"><html:select  property="divCode" 
							style="width:143px" styleClass="mycombo"
							>
							<html:option value="0">
								<font class="myfontclr1">Select...</font>
							</html:option>
							<html:options collection="divisions" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:present>
					
					<logic:present name="yearsList">
					
						<td class="textborder">Year<span class="mandatory">*</span></td>
						<td class="textborder"><html:select  property="yearCode" 
							style="width:143px" styleClass="mycombo"
							>
							<html:option value="0">
								<font class="myfontclr1">Select...</font>
							</html:option>
							<html:options collection="yearsList" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:present>
					<logic:present name="monthsList">
					
						<td class="textborder">Month<span class="mandatory">*</span></td>
						<td class="textborder"><html:select  property="monthCode" 
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getBills();">
							<html:option value="0">
								<font class="myfontclr1">Select...</font>
							</html:option>
							<html:options collection="monthsList" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:present>
</table>
<div class='container'>
 <h2 id='mynav'></h2>

<table  align=center  style="border-collapse:collapse">
	
<thead class='header'>
			 <tr><td colspan="8" class="rptValue">
				<font color=red>So far Selected Under this District : <b><bean:write name="RwsBankBillActionForm" property="selectedBillCount" /></b> Bills and its Amount <b style="font-family: Rupee Foradian;">`</b> <b><bean:write name="RwsBankBillActionForm" property="soFarProcessAmount" /></b></font>
			  </td><td colspan="2" align="right"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="checkAll()">Check All</a>&nbsp;&nbsp;&nbsp;<a href="#" onclick="unCheckAll()">UnCheck All</a></td></tr>
			 <tr align="center">
				<td class=gridhdbg rowspan="2">Sl. No.</td>
				<!-- <td class=gridhdbg rowspan="2">Circle</td> -->
				<td class=gridhdbg rowspan="2">Division</td>
				<td class=gridhdbg rowspan="2">Work ID/<BR>Work Name</td>
				<td class=gridhdbg rowspan="2">Sanction Amount/<BR>Program/<BR>Sub Program</td>
				<td class=gridhdbg rowspan="2">Bill Sl No.</td>
				<td class=gridhdbg rowspan="2">Bill<BR>No/<BR>Bill Date/<BR>Bill Entered Date/<BR>EE FWD Date</td>
				<td class=gridhdbg rowspan="2">Bill Amt <BR>Contractor/<br>Bill Amt <BR>Admissible <br> BMS Tr. No</td>
				<!-- 
				<td class=gridhdbg rowspan="2" nowrap>Amount So Far Released.<br>Including Current Bill</td>
				 -->
					<td class=gridhdbg colspan="2">Check Measurement By DEE</td>
					<td class=gridhdbg colspan="2">Check Measurement By EE</td>
					<td class=gridhdbg colspan="2">Check Measurement By SE</td>
					<td class=gridhdbg rowspan="2">PassOrder Scan Copy &nbsp;/<br>WIP Image	</td>
					<td class=gridhdbg rowspan="2">% of Physical Completion</td>
			
				<td class=gridhdbg colspan="2">Bill Amount Due</td>
				<td class=gridhdbg colspan="3">Already Paid Bill</td>
				<td class=gridhdbg colspan="2">Now recommended </td>
				<td class=gridhdbg rowspan="2">Select</td>
			</tr>
			<tr align="center">
			<td class=gridhdbg>Name/<br></br> M.Book No.s & Page No.s</td>
					<td class=gridhdbg>Date of Check measurement</td>
					
					<td class=gridhdbg>Name/ <br></br> M.Book No.s & Page No.s</td>
					<td class=gridhdbg>Date of Check measurement</td>
					<td class=gridhdbg>Name / <br></br> M.Book No.s & Page No.s</td>
					<td class=gridhdbg>Date of Check measurement</td>
				<td class=gridhdbg>Actual</td>
				<td class=gridhdbg>GOI</td>
				<!-- 
				<td class=gridhdbg>GOI</td>
				 -->
				<td class=gridhdbg>Actual</td>
				<td class=gridhdbg>State</td>
				<td class=gridhdbg>GOI</td>
				<td class=gridhdbg>Actual</td>
				<td class=gridhdbg>GOI</td>
				<!-- 
				<td class=gridhdbg>GOI</td>
				 -->
			</tr>
			</thead>
			<tbody>
	<%
	 int sno=1,styleCount=0;
	String style="";
	String pCopy="";
	%>
	<logic:notEmpty name="RwsBankBillActionForm" property="billsList">
	
	<logic:iterate id="billsList" name="RwsBankBillActionForm" property="billsList"  indexId="ndx" >
	
	<%
	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	%>
	<logic:equal name="billsList" property="recordStatus" value="Error" >
	<%
	 style="gridbg3";
	%>
	<tr align="left" id='tr<%=sno%>'  onmouseover="Tip('Recommended State Amount should not be more than Bill Amount Due in State.',TITLE,'Error')"  onmouseout="UnTip()">
	</logic:equal>
	<logic:equal name="billsList" property="recordStatus" value="NOError" >
	<tr align="left" id='tr<%=sno%>'  >
	</logic:equal>
	
		<td class=<%=style %> style="text-align: left;" ><%=sno++%></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="divName" /></td>
		<!--  <td class=<%=style %> style="text-align: left;" ><html:hidden name="billsList" property="workId" indexed="true"></html:hidden><bean:write name="billsList" property="workId" /><br><html:text name="billsList" property="workName"  style="font-size:9px;font-weight:bold;width:450px" readonly="true" onmouseover="Tip(this.value,TITLE,'Work Name')"  onmouseout="UnTip()" /></td>-->
		
		 <td class=<%=style %> style="text-align: left;" ><html:hidden name="billsList" property="workId" indexed="true"></html:hidden><bean:write name="billsList" property="workId" /><br><bean:write name="billsList" property="workName"  /></td>
		<td  class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="sanctionAmount" />/<br><bean:write name="billsList" property="programe" />/<br>
		<bean:write name="billsList" property="subPrograme" />
		</td>
		<td  class=<%=style %> style="text-align:center;">
		<bean:write name="billsList" property="billSlNo" />
		</td>
		<td  class=<%=style %> style="text-align:center;" >
		<bean:write name="billsList" property="billNo" />/<br>
		<%-- <bean:write name="billsList" property="billDate" />/<br> --%>
				<html:hidden name="billsList" property="billDate" indexed="true"></html:hidden><bean:write name="billsList" property="billDate"/>/<br>
		
		<bean:write name="billsList" property="billEnterDate" />/<br>
		<bean:write name="billsList" property="eeFwdDate" /><br>
		<html:hidden name="billsList" property="billSlNo" indexed="true"></html:hidden>
		
		</td>
		<td  class=<%=style %> style="text-align: center;" ><bean:write name="billsList" property="billAmtContractor" />/<br>
		<bean:write name="billsList" property="billAmtAdmissible" />/<br><bean:write name="billsList" property="bmsno" />
				</td>
		
		<td  class=<%=style %> style="text-align: center;"><bean:write name="billsList" property="checkMeasuredByDEE" /><br><bean:write name="billsList" property="mbookNoDEE" /></td>
		<td  class=<%=style %> style="text-align: center;"><bean:write name="billsList" property="checkMeasuredDateDEE" /></td>
		
		<td  class=<%=style %> style="text-align: center;"><bean:write name="billsList" property="checkMeasuredByEE" /><br><bean:write name="billsList" property="mbookNoEE" /></td>
		<td  class=<%=style %> style="text-align: center;"><bean:write name="billsList" property="checkMeasuredDateEE" /></td>
		
		<td  class=<%=style %> style="text-align: center;"><bean:write name="billsList" property="checkMeasuredBySE" /><br><bean:write name="billsList" property="mbookNoSE" /></td>
		<td  class=<%=style %> style="text-align: center;"><bean:write name="billsList" property="checkMeasuredDateSE" /></td>
		<td class=<%=style %> style="text-align: left;"  align="center">
		<%-- <%
						    if(pCopy!=null && !pCopy.equals("null")){
						%>
						<input type="button" class="btext" onclick="openFile(<bean:write name="billsList" property="workId" />,<bean:write name="billsList" property="billSlNo" />)" value="View"/>
						<%
						    }else {
						%>
						NA
						<% } %> --%>
						<logic:equal value="Yes" property="passOrderScanCopyAvailable"  name="billsList">
						<input type="button" class="btext" onclick='<%= "openFile(" + ndx + ")" %>' value="View"/>
						</logic:equal>
						<logic:notEqual value="Yes" property="passOrderScanCopyAvailable" name="billsList">
							<p><font style="font-size: 9px">Image not Exist</font>
						</logic:notEqual>
						<br><br>
						<logic:equal value="Yes" property="work_img"  name="billsList">
							<a class="thumbnail" href="#thumb"><img src="reports/works/workImage.jsp?workid=<bean:write name="billsList" property="workId"/>&mode=image1"  width="30px" height="30px" border="0" /><span><img src="reports/works/workImage.jsp?workid=<bean:write name="billsList" property="workId"/>&mode=image1" width="350px" height="230px"/></span></a>
						</logic:equal>
						<logic:notEqual value="Yes" property="work_img" name="billsList">
							<p><font style="font-size: 9px">Image not Exist</font>
						</logic:notEqual>
			</td>
		<td class=<%=style %> style="text-align: right;" >
		<input type="button" value="..." onclick="workPhysicalStatus('<bean:write name="billsList" property="workId"/>')"  onmouseover="Tip(this.value,TITLE,'Click Here To Update Physical Progress')"  onmouseout="UnTip()"/></td>
		<td  class=<%=style %> style="text-align: right;" ><html:text name="billsList" property="dueActual" style="width:60px" readonly="true" styleClass="mytext" indexed="true"  /></td>
		<td  class=<%=style %> style="text-align: right;" ><html:text name="billsList" property="dueGOI" style="width:60px" readonly="true" styleClass="mytext"   /></td>
		
		<!-- 
		<td  class=<%=style %> style="text-align: right;" ><html:text name="billsList" property="dueGOI" style="width:60px" readonly="true" styleClass="mytext"  /></td>
		 -->
		<td  class=<%=style %> style="text-align: right;" ><html:text name="billsList" property="paidActual" style="width:60px" readonly="true" styleClass="mytext"   /></td>
		<td  class=<%=style %> style="text-align: right;" ><html:text name="billsList" property="paidState" style="width:60px" readonly="true" styleClass="mytext"  /></td>
		<td  class=<%=style %> style="text-align: right;" ><html:text name="billsList" property="paidGOI" style="width:60px" readonly="true" styleClass="mytext"  /></td>
		<td  class=<%=style %> style="text-align: right;" ><html:text name="billsList" property="recomandedActual" style="width:60px" styleClass="mytext" indexed="true" /></td>
		<td  class=<%=style %> style="text-align: right;" ><html:text name="billsList" property="recomandedStatePer" style="width:40px" styleClass="mytext" indexed="true" onkeyup='<%= "fnCalState(" + ndx + ")" %>' onchange='<%= "fnCalState(" + ndx + ")" %>' /><html:text styleClass="mytext" name="billsList" property="recomandedGOI" style="width:60px" onkeypress="return numeralsOnly()" onkeyup='<%= "fnCalStatePer(" + ndx + ")" %>' indexed="true"/></td>
		
		<!-- <td  class=<%=style %> style="text-align: right;" ><html:text name="billsList" property="recomandedGOIA" style="width:60px" readonly="true" styleClass="mytext" indexed="true" /><html:text name="billsList" readonly="true" property="recomandedGOI" style="width:60px" styleClass="mytext" indexed="true" /></td>
		 -->
		
		<logic:equal name="billsList" value="-" property="eeFwdDate">
		<td  class=<%=style %> style="text-align: right;" align="center" onmouseover="Tip('EE Not Yet Forwaded',TITLE,'Alert')" onmouseout="UnTip()"><div class="diva"><span class="spana"><html:checkbox disabled="true" name="billsList" property="checks" styleClass="checka" onclick='<%= "check(" + ndx + ")" %>' indexed="true"/> </span></div></td>
		</logic:equal>
		
		<logic:notEqual name="billsList" value="-" property="eeFwdDate">
		<logic:equal name="billsList" value="Y" property="paoFlag">
		<td  class=<%=style %> style="text-align: right;" align="center" onmouseover="Tip('Bill Is Seleted Under PAO Payment.',TITLE,'Alert')" onmouseout="UnTip()"><div class="diva"><span class="spana"><html:checkbox disabled="true" name="billsList" property="checks" styleClass="checka" onclick='<%= "check(" + ndx + ")" %>' indexed="true"/> </span></div></td>
		</logic:equal>
		<logic:notEqual name="billsList" value="Y" property="paoFlag">
		<td  class=<%=style %> style="text-align: right;" align="center" onmouseover="Tip('Select Bill For Save',TITLE,'Alert')" onmouseout="UnTip()"><html:checkbox name="billsList" property="checks"   onclick='<%= "check(" + ndx + ")" %>' indexed="true"/> </td>
		</logic:notEqual>
		</logic:notEqual>
		
		
	</tr>
	
	<%
	styleCount++;
	%>
</logic:iterate>
</logic:notEmpty>
<%if(sno==1)
{
%><tr><td colspan="13" align="center" class="btext">No Records</td></tr><%}
else{%><tr><td colspan="14" align="center"><input type=button value=Save id="sBtn" onClick="fnSave();" class="btext"></td></tr><%}%>
<input type="hidden" name="resultCount" value="<%=sno%>">
<input type="hidden" name="selectedRecords" value="<%=sno%>">
</tbody>
</table>
</div>

</html:form>
</body>
<%@ include file="/commons/rws_alert.jsp"%>
</html>