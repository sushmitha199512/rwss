<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--
function openWindow(fileName)
{
	var code=contractorForm.contractorCode.value;
	url = 'switch.do?prefix=/masters&page=/construct.jsp';
var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=no,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	//window.open(url,"", "width=400,height=150,menubar=yes,left=300,top=200,scrollbars=1");
window.open(url,"", properties);
}
function eoatWin()
{

var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=no,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";

	var code=contractorForm.contractorCode.value;
	
	url = 'switch.do?prefix=/masters&page=/Eoat_Det.jsp?code='+code;
	window.open(url,"",properties);
}
function getDateObject(dateString,dateSeperator)
{
	
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	endPos=dateString.indexOf(sepChar,curPos+1);
	cMonth=dateString.substring(curPos+1,endPos);
    // alert("cMonth:"+cMonth);
	//extract year portion				
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	// alert("cYear:"+cYear);
	//Create Date Object
	dtObject=new Date(cYear,cMonth-1,cDate);	
	// alert(dtObject);
	return dtObject;
} 
function fnprojectsexecuted()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=projexecuted";
document.forms[0].submit;

}

function fnprojectcompletedintime()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=projcompletedintime";
document.forms[0].submit;

}
function fnprojectslast()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=projlast";
document.forms[0].submit;
}
function fnprojectsinhand()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=projinhand";
document.forms[0].submit;

}
function validateFormm()
{   
	var firstname=document.forms[0].firstName.value;
	var panno =document.forms[0].panNo.value;
	var voterid=document.forms[0].voterId.value;
	var contractorRegno =document.forms[0].contractorRegno.value;
    var val=document.forms[0].email.value;
	var pattern = /^[a-zA-Z0-9\_\.]+\@[a-zA-Z\.]+\.([a-z]{2,4})$/;
	var dt1=getDateObject(document.forms[0].registrationDate.value,"/");
	var dt2=getDateObject(document.forms[0].validFrom.value,"/");
    var dt3= getDateObject(document.forms[0].validTo.value,"/");
	//alert("rdate:"+dt1);
	//alert("vTo:"+dt3); 
   // alert(dt1 < dt2);
	if(firstname ==null || firstname == "")
	{ 
		alert("Please Enter FirstName");
		document.forms[0].firstName.focus();
		return false;
	}
	else if(panno=="" && voterid =="" && contractorRegno=="")
	{
		alert("Please Provide any one of the Below \n PanNo (or) Regn No. (or) VoterId")
		return false;				  
	}
	else if(panno!="" || voterid !="" || contractorRegno !="")
	{
		if(panno!="" && panno.length!=10)
		{
			alert("Please Provide Valid Pan NO");
			document.forms[0].panNo.focus();
			return false;
		}
		if(voterid!="" && voterid.length!=10)
		{
			alert("Please Provide Valid Voter ID");
			document.forms[0].voterId.focus();
			return false;
		}
		if(contractorRegno!="" && contractorRegno.length!=4)
		{
			alert("Please Provide Valid Contractor Registraion No.");
			document.forms[0].contractorRegno.focus();
			return false;
		}
    }
	if(document.forms[0].email.value!="")
	{
		if(!eMailCheck(document.forms[0].email.value))
		{
			document.forms[0].email.value = '';
			return false;
		}
	}
   if(dt1 > dt2)
   {
     alert(" Valid From date must be greater than or equal to Registration date"); 
     return false;
   }
   if(dt3 < dt2 ) 
	{
	  alert(" Valid To Date must be greater than or equal to Valid From date"); 
	  return false;
	}
   	else
	{
      //alert("submission");
		return true;
	}
  }

//-->
</script>

<html:form action="/Contractor.do?mode=edit">

<table width="100%" bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><B><font color="#FFFFFF">Contractor Progress Report</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
	
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" ><tr>
<td class="mycborder">

<table cellpadding="0" border="0"  bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
<tr >
	<td class="textborder" >&nbsp;Contractor Code:</td>
	<td><html:text property="contractorCode" value="<%=(String)request.getAttribute(\"code\")%>" size="5" tabindex="1" readonly="true"  styleClass="noborder-text-box"/>
	</td>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<td class="textborder">Name/FirmName:</td>
	<td><html:text property="firstName" size="35" tabindex="0" readonly="true" styleClass="noborder-text-box"  /></td>
<td class="textborder">Voter Id:</td>
<td><html:text property="voterId" size="25" tabindex="0"  readonly="true" styleClass="noborder-text-box" /></td>
<td class="textborder">Pan No:</td>
<td><html:text property="panNo" size="15" tabindex="0"  readonly="true"  styleClass="noborder-text-box"/></td>
<table  border=1 style="border-collapse:collapse" bordercolor= "#8A9FCD" width=100%>
<tr>
<td>
<table cellpadding="0" cellspacing="2" >
	<td class="textborder">Projects Executed:</td>
	<td><html:text property="projectsExecuted"  readonly="true" styleClass="noborder-text-box" tabindex="22" size="5" /></tr>
		<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
     <tr >
 <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
		
         <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">District</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">WorkId</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">WorkName</FONT></td>
		<td  class=mycborder align=center>
        <FONT class=myfontclr><font color="#993366">Administrative Sanction Number</FONT></td>
		<td  class=mycborder align=center>
        <FONT class=myfontclr><font color="#993366">Administrative Sanction Date</FONT></td>
		<td  class=mycborder align=center>
        <FONT class=myfontclr><font color="#993366">Sanctioned Amount (<b style="font-family: Rupee Foradian;">`</b>. In Lakhs)</FONT></td>
        <td  class=mycborder align=center>
        <FONT class=myfontclr><font color="#993366">Agreement Value<BR>( <b style="font-family: Rupee Foradian;">`</b>. In Rs ) </FONT></td>
		<td  class=mycborder align=center>
        <FONT class=myfontclr><font color="#993366">Work Commencement Date</FONT></td>
         <td  class=mycborder align=center>
        <FONT class=myfontclr><font color="#993366">Stipulated Date of Completion</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Date of Completion</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Work Entrustment </FONT></td>
		<td  class=mycborder align=center>
		</tr>
<%
try
{
java.util.Collection b = (java.util.ArrayList)request.getAttribute("projectsexecuted"); 
System.out.println("B size"+b.size());
if(b.size() > 0)
{
 int count=0; 
System.out.println("Complaints"); %>
<logic:iterate id="PROJECTSLIST" name="projectsexecuted">
<%System.out.println("Complaints2"); %>
<% count+=1; %>

<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dname" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="workId" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="workName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="adminNo" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="adminDate" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="sancAmount" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="agreeValue" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dateofCommencement" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="stipulateddateofCompletion" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dateofCompletion" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="tenderNomination" /></FONT>
</td>
</tr>
</logic:iterate>
<%} 
else 
{
%>
<tr>
<td colspan=10 align=center>No Records</td>
</tr>
<%
}}
catch(Exception e)
{
System.out.println("Exception"+e);
}

%>
</table>
</tr>
<tr>
	<td class="textborder">Projects Completed in Time:
	<html:text property="projectsCompletedInTime"  readonly="true" styleClass="noborder-text-box" tabindex="23" size="5" /></TD>
	</tr>
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr >
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
<td  class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">District</FONT></td>

	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">WorkId</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">WorkName</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Administrative Sanction Number</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Administrative Sanction Date</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sanctioned Amount (<b style="font-family: Rupee Foradian;">`</b>. In Lakhs)</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Agreement Value<br> ( <b style="font-family: Rupee Foradian;">`</b>. In Rs )</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Date of Commencement</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Stipulated Date of Completion</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Date of Completion</FONT></td>
	<td  class=mycborder align=center>
	</tr>

<%
try
{
java.util.Collection b = (java.util.ArrayList)request.getAttribute("projectsexecutedintime"); 
System.out.println("B size"+b.size());
if(b.size() > 0)
{
 int count=0; 
System.out.println("Complaints"); %>
<logic:iterate id="PROJECTSLIST" name="projectsexecutedintime">
<%System.out.println("Complaints2"); %>
<% count+=1; %>

<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>

<td  class=bwborder align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dname" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="workId" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="workName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="adminNo" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="adminDate" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="sancAmount" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="agreeValue" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dateofCommencement" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="stipulateddateofCompletion" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dateofCompletion" /></FONT>
</td>
</tr>
</logic:iterate>
<%} 
else 
{
%>
<tr>
<td colspan=10 align=center>No Records</td>
</tr>
<%
}}
catch(Exception e)
{
System.out.println("Exception"+e);
}
%>

</table>
</tr>
<tr >
	<td class="textborder">Projects Completed in Last Five Years:
	<html:text property="projectsCompletedLastYear" readonly="true" styleClass="noborder-text-box" tabindex="24" size="5" /></TD>
	</tr>
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr >
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
	
<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">District</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">WorkId</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">WorkName</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Administrative Sanction Number</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Administrative Sanction Date</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sanctioned Amount (<b style="font-family: Rupee Foradian;">`</b>. In Lakhs)</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Agreement Value<BR>( <b style="font-family: Rupee Foradian;">`</b>. In Rs )</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Work Commencement Date</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Stipulated Date of Completion</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Date of Completion</FONT></td>
	<td  class=mycborder align=center>
	
		</tr>
<%
try
{
java.util.Collection b = (java.util.ArrayList)request.getAttribute("projectlastfive"); 
System.out.println("B size"+b.size());
if(b.size() > 0)
{
 int count=0; 
System.out.println("Complaints"); %>
<logic:iterate id="PROJECTSLIST" name="projectlastfive">
<%System.out.println("Complaints2"); %>
<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>

<td  class=bwborder align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dname" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="workId" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="workName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="adminNo" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="adminDate" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="sancAmount" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="agreeValue" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dateofCommencement" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="stipulateddateofCompletion" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dateofCompletion" /></FONT>
</td>
</tr>
</logic:iterate>
<%} 
else 
{
%>
<tr>
<td colspan=10 align=center>No Records</td>
</tr>
<%
}}
catch(Exception e)
{
System.out.println("Exception"+e);
}

%>

</table>
</tr>
<tr>
	<td class="textborder">Projects in Hand:
	<html:text property="projectsInhand" readonly="true" styleClass="noborder-text-box" tabindex="26" size="5" /></td>
	</tr>
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
	<tr >    <td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">District</FONT></td>
<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">WorkId</FONT></td>
		
<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">WorkName</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Administrative Sanction Number</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Administrative Sanction Date</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sanctioned Amount (<b style="font-family: Rupee Foradian;">`</b>. In Lakhs)</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Agreement Value <br>( <b style="font-family: Rupee Foradian;">`</b>.In Rs )</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Work Commencement Date</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Stipulated Date of Completion</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Date of Completion</FONT></td>
	<td  class=mycborder align=center>
	</tr>
<%
try
{
java.util.Collection b = (java.util.ArrayList)request.getAttribute("projectsinhand"); 
System.out.println("B size"+b.size());
if(b.size() > 0)
{
 int count=0; 
System.out.println("Complaints"); %>
<logic:iterate id="PROJECTSLIST" name="projectsinhand">
<%System.out.println("Complaints2"); %>
<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>

<td  class=bwborder align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dname" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="workId" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="workName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="adminNo" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="adminDate" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="sancAmount" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="agreeValue" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dateofCommencement" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="stipulateddateofCompletion" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="PROJECTSLIST" property="dateofCompletion" /></FONT>
</td>
</tr>

</logic:iterate>
<%} 
else 
{
%>
<tr>
<td colspan=10 align=center>No Records</td>
</tr>
<%
}}
catch(Exception e)
{
System.out.println("Exception"+e);
}

%>

</table>
</tr>
</table>



 
</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
