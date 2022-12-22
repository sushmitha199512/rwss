<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>
<script language="JavaScript">

function viewWorks(URL)
{
	alert("link----"+URL);
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}


</script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript">

function fnSave(){
	
	
	var length= document.genericActionForm.resultCount.value;
	
	document.forms[0].elements['sBtn'].value="Saving Please Wait.....";
	document.forms[0].elements['sBtn'].disabled=true;
	//document.forms[0].elements["ccode"]
	
	length= length-1;

	var flag=false;
	for(var k=0;k<length;k++)
	{		
	if(document.forms[0].elements["generic["+k+"].checks"].checked)
	 {
		//alert(21);
		flag=true;
	var comnum=document.forms[0].elements["generic["+k+"].complaintNumber"].value;
	//alert("comnum"+comnum);
   var phonenumber=document.forms[0].elements["generic["+k+"].phoneNumber"].value;
   alert("phonenumber"+phonenumber);
    var actiontaken=document.forms[0].elements["generic["+k+"].actionTaken"].value;
    var sctiondesc=document.forms[0].elements["generic["+k+"].actionDesc"].value;
    var attendedby=document.forms[0].elements["generic["+k+"].attendBy"].value;
    var attendedate=document.forms[0].elements["generic["+k+"].attendedDate"].value; 
    var messentgrevence=document.forms[0].elements["generic["+k+"].mesSentToGrevance"].value;
    var dateofsent=document.forms[0].elements["generic["+k+"].dateOfSent"].value;
    var category=document.forms[0].elements["generic["+k+"].category"].value;
    var complaintDate=document.forms[0].elements["generic["+k+"].complaintDate"].value;
    var remarks=document.forms[0].elements["generic["+k+"].remarks"].value;
    
    if(document.getElementById("generic["+k+"].category").value==""){
		 alert("Please Select Nature of Problem");
		 document.getElementById("generic["+k+"].category").focus();
				 return false;
	 }
   if(document.getElementById("generic["+k+"].actionTaken").value==""){
		 alert("Please Select Action taken");
		 document.getElementById("generic["+k+"].actionTaken").focus();
				 return false;
	 }
   
   if(document.getElementById("generic["+k+"].actionDesc").value==""){
		 alert("Please Select Action Description");
		 document.getElementById("generic["+k+"].actionDesc").focus();
				 return false;
	 }
   if(document.getElementById("generic["+k+"].attendBy").value==""){
		 alert("Please Select Who Attend the Complaint");
		 document.getElementById("generic["+k+"].attendBy").focus();
				 return false;
	 }
   
   if(document.getElementById("generic["+k+"].attendedDate").value==""){
		 alert("Please Select  Attended Date");
		 document.getElementById("generic["+k+"].attendedDate").focus();
				 return false;
	 }
   if(document.getElementById("generic["+k+"].mesSentToGrevance").value==""){
		 alert("Please Select Wheather the Message Sent to Petitioner or Not");
		 document.getElementById("generic["+k+"].mesSentToGrevance").focus();
				 return false;
	 }
	
 
	}	//end if

	}//for loop
	if(!flag){

		 alert("Please Select Check Box For Save The Record");
		 document.forms[0].elements['sBtn'].value="Save";
			document.forms[0].elements['sBtn'].disabled=false;
		 return;
	}
	if(attendedate<complaintDate && dateofsent<complaintDate )
	{
	alert("Attended Date/Date of Message Sent Should Be greater Than or equal to the Complaint given Date");
	}
	
	
	else{
		//alert(123);
		
		
		document.forms[0].action="switch.do?prefix=/complaints&page=/GenericActionTaken.do&mode=Save";	
		
	//	alert("document.forms[0].action"+document.forms[0].action);
		  document.forms[0].submit();
			

	}
	
}

function init()
{
	
	
	district='';
	
	
	
		
		
	
}

function getcomplaintData()
{
	
	var dist=document.getElementById('district').value;
	
var date=document.getElementById('complainDate').value;
	
	
	if(document.getElementById('district').value=='')
			{
		alert("please Select District");
		return false;
			}
	
	
	
	else
		{
	document.forms[0].action="switch.do?prefix=/complaints&page=/GenericActionTaken.do&mode=cmplaintData&district="+dist+"&date="+date;	

	  document.forms[0].submit();
		}
	
}


</script>





<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
System.out.println("loggedUser"+loggedUser);
String circle=loggedUser.substring(1,3);
System.out.println("circle"+circle);
session.setAttribute("circle",circle);
String dcode = request.getParameter("district");
String divcode = request.getParameter("division");
     
System.out.println("dcode"+dcode);
System.out.println("divcode"+divcode);
String dataDate=(String)session.getAttribute("dataDate1");
System.out.println("Session"+dataDate);
Date systemdate= new java.util.Date(System.currentTimeMillis());
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
String transdate=null;
transdate=dateFormat.format(systemdate);
String sourceType=request.getParameter("sourceTypen");
//System.out.println("sourceType"+sourceType);
%>

<body  onload="javascript:init();" >



<html:form  action="GenericActionTaken.do">

<table  border=0   >
<tr><td class=mycborder><font face=verdana size=2>District<font color="red">*</font></font></td>
		<td class="textborder">
		<html:select property="district" styleClass="mycombo" style="width:150px" onchange="javascript:getMandals()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
</td>
<td class=mycborder><font face=verdana size=2>From Date<font color="red">*</font></font></td>
<td>

<html:text   property="complainDate"   styleClass="mytext" style="width:70"     />
				    			   <a href="javascript: showCalendarFuture(document.getElementById('complainDate'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle"></a>
</td>



<td>
<input type=button value="Get Data" onclick="getcomplaintData()">
</td>
</tr>


<jsp:include page="/commons/TableHeader1.jsp">
	<jsp:param name="TableName" value="Grievance Monitoring System-Action Taken Entry" />
	<jsp:param name="TWidth" value="1700" />	
</jsp:include>



		
		
		<table width="800"
		border=1 style="border-collapse: collapse;">
<tr >
	<td class="btext" align="center" >S.No</td>
	 
	<td class="btext" align="center" >District/<br>Mandal/<br>Panchayat/<br>Village</td>
	
	<td class="btext" align="center" >Habitation Code<br>/Habitation Name</td>
	
	<td class="btext" align="center" >Complaint Number</td>	
	<td class="btext" align="center" >Complaint Date</td>
	
	<td class="btext" align="center" >Problem Description</td>
	<td class="btext" align="center" >Complaint Given By/<br>Name/<br>Address/<br>Phone Number</td>
	

	<td class="btext" align="center" >Nature of Problem</td>
	
	<td class="btext" align="center" >Action Taken</td>
	
	<td class="btext" align="center" >Description on Action</td>	
	<td class="btext" align="center" >Attended By</td>
	
	<td class="btext" align="center" >Attended Date</td>	
	<td class="btext" align="center" >Message Sent To Grivance</td>
	<td class="btext" align="center" >Date of Sent</td>	
	<td class="btext" align="center" >Remarks by[HOD]</td>
	<td class="btext" align="center" >Uploaded Grievance</td>		
	<td class="btext" align="center" >Select</td>
	</tr>
	
	
	<%
  int count=1;
%>
	
	<logic:notEmpty name="genericActionForm" property="generic">
	<logic:iterate id="generic" name="genericActionForm" property="generic" indexId="index">
	
	
	
	<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		<td class="rptValue"><%=count++%></td>
		
		
		<td  class="rptValue" >
		<bean:write name="generic" property="dcode" />
		/<br><bean:write name="generic" property="mcode" />
		/<br><bean:write name="generic" property="pcode" />
		/<br><bean:write name="generic" property="vcode" /></td>
		<td  class="rptValue" ><bean:write name="generic" property="panchCode" />
		/<br><bean:write name="generic" property="panchName" /></td>
		
		
		<td  class="rptValue" ><bean:write name="generic" property="complaintNumber" />
		
		<html:hidden property="complaintNumber" name="generic" indexed="true"/>
		<td  class="rptValue" ><bean:write name="generic" property="complaintDate" />
		<html:hidden property="complaintDate" name="generic" indexed="true"/>
		<td  class="rptValue" ><bean:write name="generic" property="prblmDesc" />
		<td  class="rptValue" ><bean:write name="generic" property="complaintGivenBy" />
		/<br><bean:write name="generic" property="name" />
		/<br><bean:write name="generic" property="address" />
		/<br><bean:write name="generic" property="phoneNumber" /></td>
		<html:hidden property="phoneNumber" name="generic" indexed="true"/>
		
		
		<td  align="center" >
			<html:select name="generic" property="category"  indexed="true" styleClass="mycombo"  style="width: 80px" >										
			<html:option value="">Select</html:option>
			<html:option value="DWP[HPs/ BW SourcesDried/LowYield]">DWP[HPs/BW Sources Dried/Low Yield]</html:option>
			<html:option value="DWP[Transportation-Increase of Tankers]">DWP[Transportation-Increase of Tankers]</html:option>
			<html:option value="DWP[CPWSS-Maintenance Problem]">DWP[CPWSS-Maintenance Problem]</html:option>
			<html:option value="DWP[SVS-Maintenance Problem-GP]">DWP[SVS-Maintenance Problem-GP]</html:option>
			<html:option value="DWP[PIPELine damaged/Leakages]">DWP[PIPE Line damaged/Leakages]</html:option>
			<html:option value="DWP[Motor Repairs-GP]">DWP[Motor Repairs-GP]</html:option>
			<html:option value="DWP[Water Quality Problem]">DWP[Water Quality Problem]</html:option>
			<html:option value="DWP[Power problem]">DWP[Power Problem]</html:option>
			<html:option value="New Praposal">New Praposal</html:option>
			<html:option value="Others">Others</html:option>
			 
			
			
					
			</html:select>
		</td>
		<td  align="center" >
			<html:select name="generic" property="actionTaken"  indexed="true" styleClass="mycombo"  style="width: 80px" >										
			<html:option value="">Select</html:option>
			<html:option value="transportation">Transportation</html:option>
			<html:option value="Hiring of Source">Hiring of Source</html:option>
			<html:option value="Flushing/Deepening">Flushing/Deepening</html:option>
			<html:option value="Scheme Repaired">Scheme Repaired</html:option>
			<html:option value="Scheme Repair pending">Scheme Repair Pending</html:option>
			<html:option value="Proposal Stage">Proposal Stage</html:option>
			<html:option value="Scheme Repaired">No DW Problem</html:option>
			</html:select>
		</td><!--
		<html:hidden property="actionTaken" name="generic" indexed="true"/>
		<html:hidden property="actionDesc" name="generic" indexed="true"/>
		<html:hidden property="attendBy" name="generic" indexed="true"/>
		<html:hidden property="attendedDate" name="generic" indexed="true"/>
		<html:hidden property="mesSentToGrevance" name="generic" indexed="true"/>
		<html:hidden property="dateOfSent" name="generic" indexed="true"/>
		--><td>
				<html:textarea name="generic" property="actionDesc" indexed="true" rows="4" cols="20" />	
		</td>
		
		<td>
				<html:textarea name="generic" property="attendBy" indexed="true" rows="4" cols="10" />	
		</td>
		
		<td><html:text name="generic" property="attendedDate"  indexed="true"  onkeypress="return decimalsOnly(event)" style="width: 70px" />
		<a href="javascript:showCalendar(document.getElementById('generic[<%=count-2%>].attendedDate'));">
        
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
		
		
		<td  align="center" >
			<html:select name="generic" property="mesSentToGrevance"  indexed="true" styleClass="mycombo"  style="width: 80px" >										
			<html:option value="">Select</html:option>
			<html:option value="Y">Yes</html:option>
			<html:option value="N">No</html:option>
		
					
			</html:select>
		</td>
				<td><html:text name="generic" property="dateOfSent"  indexed="true"  onkeypress="return decimalsOnly(event)" style="width: 70px" />
		<a href="javascript:showCalendar(document.getElementById('generic[<%=count-2%>].dateOfSent'));">
        
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>	
	
	<td>
				<html:textarea name="generic" property="remarks" indexed="true" rows="3" cols="15" />	
		</td>
		<td>
			<a href="#" onclick="viewWorks('switch.do?prefix=/complaints&page=/GenericActionTaken.do&mode=imageView&conplaintNo=<bean:write name="generic" property="complaintNumber" />')">Grievance View</a>		
		</td>
	<td>			
		<html:checkbox name="generic" property="checks" indexed="true" onclick='<%= "check(" + index + ")" %>' />
		</td>	
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	<%if(count==1)
		{
		%><tr><td colspan="20" align="center" class="btext">No Records</td></tr><%}
		else{%><tr><td colspan="20" align="center"><input type=button value=Save id="sBtn" onClick="fnSave();" class="btext"></td></tr><%}%>
		<input type="hidden" name="resultCount" value="<%=count%>"/>
	</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="1650" />
</jsp:include>


</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

