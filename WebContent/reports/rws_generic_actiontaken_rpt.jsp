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
   //alert("phonenumber"+phonenumber);
    var actiontaken=document.forms[0].elements["generic["+k+"].actionTaken"].value;
    var sctiondesc=document.forms[0].elements["generic["+k+"].actionDesc"].value;
    var attendedby=document.forms[0].elements["generic["+k+"].attendBy"].value;
    var attendedate=document.forms[0].elements["generic["+k+"].attendedDate"].value; 
    var messentgrevence=document.forms[0].elements["generic["+k+"].mesSentToGrevance"].value;
    var dateofsent=document.forms[0].elements["generic["+k+"].dateOfSent"].value;
    var category=document.forms[0].elements["generic["+k+"].category"].value;
    var complaintDate=document.forms[0].elements["generic["+k+"].complaintDate"].value;
    alert("complaintDate"+complaintDate);
  //  alert("actiontaken"+actiontaken);
  //  alert("sctiondesc"+sctiondesc);
 //   alert("attendedby"+attendedby);
 //   alert("attendedate"+attendedate);
 //   alert("messentgrevence"+messentgrevence);
 //   alert("dateofsent"+dateofsent);
  //  alert("category"+category);
	
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
		alert(123);
		
		
		document.forms[0].action="switch.do?prefix=/reports&page=/GenericActionTaken.do&mode=Save&comnum="+comnum+"&actiontaken="+actiontaken+"&sctiondesc="+sctiondesc+"&attendedby="+attendedby+"&attendedate="+attendedate+"&messentgrevence="+messentgrevence+"&dateofsent="+dateofsent+"&category="+category;	
		
	//	alert("document.forms[0].action"+document.forms[0].action);
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

<body >
<table align="center">
<tr><td><font color=red size=2>District:</font><font face = "italic" size=2 color =#0000FF><bean:write name="RWS_USER" property="circleOfficeName"/></font></td>
</tr>
</table>


<html:form  action="GenericActionTaken.do" method="post">


<jsp:include page="/commons/TableHeader1.jsp">
	<jsp:param name="TableName" value="Generic Action Taken" />
	<jsp:param name="TWidth" value="1700" />	
</jsp:include>



		
		
		<table width="800"
		border=1 style="border-collapse: collapse;">
<tr >
	<td class="btext" align="center" >S.No</td>
	 
	<td class="btext" align="left" >Mandal/<br>Panchayat/<br>Village</td>
	
	<td class="btext" align="left" >Habitation Code<br>/Habitation Name</td>
	
	<td class="btext" align="left" >Complaint Number</td>	
	<td class="btext" align="left" >Complaint Date</td>
	
	<td class="btext" align="left" >Problem Description</td>
	<td class="btext" align="left" >Complaint Given By</td>
	
	<td class="btext" align="left" >Name</td>
	<td class="btext" align="left" >Address</td>
	<td class="btext" align="left" >Phone Number</td>
	<td class="btext" align="left" >Nature of Problem</td>
	
	<td class="btext" align="left" >Action Taken</td>
	
	<td class="btext" align="left" >Description on Action</td>	
	<td class="btext" align="left" >Attended By</td>
	
	<td class="btext" align="left" >Attended Date</td>	
	<td class="btext" align="left" >Message Sent To Grivance</td>
	<td class="btext" align="left" >Date of Sent</td>	
	<td class="btext" align="left" >Select</td>
	</tr>
	
	
	<%
  int count=1;
%>
	
	<logic:notEmpty name="genericActionForm" property="generic">
	<logic:iterate id="generic" name="genericActionForm" property="generic" indexId="index">
	
	
	
	<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		<td class="rptValue"><%=count++%></td>
		
		
		<td  class="rptValue" ><bean:write name="generic" property="mcode" />
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
		
		<td  class="rptValue" ><bean:write name="generic" property="name" />
		<td  class="rptValue" ><bean:write name="generic" property="address" />
		<td  class="rptValue" ><bean:write name="generic" property="phoneNumber" />
		<html:hidden property="phoneNumber" name="generic" indexed="true"/>
		
		
		<td  align="center" >
			<html:select name="generic" property="category"  indexed="true" styleClass="mycombo"  style="width: 80px" >										
			<html:option value="">Select</html:option>
			<html:option value="DWS problem(Transportation)">DWS problem(Transportation)</html:option>
			<html:option value="DWS problem(mtc. of scheme)">DWS problem(mtc. of scheme)</html:option>
			<html:option value="DWS problem (mtc. of HP)">DWS problem (mtc. of HP)</html:option>
			<html:option value="Water Quality problem">Water Quality problem</html:option>
			<html:option value="New proposal">New proposal</html:option>
			<html:option value="Others">Others</html:option>
			
			
			 
			
			
					
			</html:select>
		</td>
		<td  align="center" >
			<html:select name="generic" property="actionTaken"  indexed="true" styleClass="mycombo"  style="width: 80px" >										
			<html:option value="">Select</html:option>
			<html:option value="Repaired">Repaired</html:option>
			<html:option value="Pending">Pending</html:option>
			<html:option value="Not Repairable">Not Repairable</html:option>
					
			</html:select>
		</td><!--
		<html:hidden property="actionTaken" name="generic" indexed="true"/>
		<html:hidden property="actionDesc" name="generic" indexed="true"/>
		<html:hidden property="attendBy" name="generic" indexed="true"/>
		<html:hidden property="attendedDate" name="generic" indexed="true"/>
		<html:hidden property="mesSentToGrevance" name="generic" indexed="true"/>
		<html:hidden property="dateOfSent" name="generic" indexed="true"/>
		--><td>
				<html:textarea name="generic" property="actionDesc" indexed="true" rows="4" cols="15" />	
		</td>
		
		<td>
				<html:textarea name="generic" property="attendBy" indexed="true" rows="4" cols="15" />	
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

