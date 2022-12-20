<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<script language="javascript">
function fnPickHabitationsForWorkExpenditure()
{
	
	 
	var coc = document.getElementById("cmbCircle").value;
	var doc = document.getElementById("cmbDivision").value;
	var workID=document.getElementById("cmbWorks").value;
	var soc = "00";
	 
	if(coc == '')
		alert("Please select circle, division and subdivision.");
	else
	if(doc == '')
		alert("Please select division and subdivision.");
	else
	if(soc == '')
		alert("Please select subdivision.");		
	else
	{			
		 
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		var url = "switch.do?prefix=/worksMonitoring&page=/PickHabitation.do&mode=pickhab&workStageComponent=workCompletion"
				+ "&coc="+coc+"&doc="+doc+"&soc="+soc+"&workId="+workID;
				
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
		 
			newWindow = window.open(url,"", properties);
		 
			newWindow.focus();
		 
	}
}
function getMandalsToAddHabs()
{
	if(document.forms[0].workCompActualDtOfComp.value != null && document.forms[0].workCompActualDtOfComp.value != "")
{
	var work=document.getElementById('workId').value;
	  var url="switch.do?prefix=/works&page=/PickCompHabs.do?workId="+work+"&revTs=No";
   var prop="top=100,left=0,height=300,width=600,location=1,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
}
else
{
	alert("Before Add/Remove Habitations, \n First Enter Actual Date Of Completion");
}
}
function validateFrm()
{
	var frm=document.forms[0];
	var validationPassed=true;
	if(frm.workCompActualDtOfComp.value!="" && frm.workCompStartDate.value!="")
	{
			var res=compareDates(frm.workCompActualDtOfComp.value, frm.workCompStartDate.value);
			if(res<0)
			{
				alert("Actual Date Of Completion should be \ngreater than or equal to Start Date("+frm.workCompStartDate.value+")");
				validationPassed=false;
			}
	}
	if(validationPassed)
	{
				if(frm.dateOfComm.value!="" && frm.workCompActualDtOfComp.value!="")
				{
					
					var res=compareDates(frm.dateOfComm.value, frm.workCompActualDtOfComp.value);
					if(res<0)
					{
						alert("Date Of Commissioning should be \ngreater than or equal to Actual Date of Completion("+frm.workCompActualDtOfComp.value+")");
						validationPassed=false;
					}
				}
	}
	if(validationPassed)
	{
		if(frm.dateOfComm.value!="" && frm.workCompActualDtOfComp.value=="")
		{
			if(frm.dateOfComm.value!="" && frm.workCompStartDate.value!="")
			{
				var res=compareDates(frm.dateOfComm.value, frm.workCompStartDate.value);
				if(res<0)
				{
					alert("Date Of Commenssioning should be \ngreater than or equal to Start Date");
					validationPassed=false;
				}
			}
		}
	}
	
	return validationPassed;

}
function saveWorkCompletion()
{
		//if(document.forms[0].workCompStartDate.value == "")
		//{
	//		alert("Please Enter the Work Start Date at Program Schedule Stage");
	//	}
		//else if(document.forms[0].workCompActualDtOfComp.value == "")
		//{
	//		alert("Please Enter the Actual Date Of Completion");
	//	}
		//else
	//	{
			if(validateFrm())
			{
				if(document.forms[0].remarks.value=="")
				{
					alert("Please Enter Physical Stage/Remarks");
				}
				else
				{
					document.forms[0].wcMode.value = 'save';
					document.forms[0].action="/pred/works/WorkStatus.do?mode=save";
					document.forms[0].submit();
				}
			}
		//}
		
}
function deleteWorkCompletion()
{
	if(document.forms[0].workCompActualDtOfComp.value == "")
	{
		alert("Please Enter the Actual Date Of Completion");
	}
	else if(document.forms[0].dateOfComm.value != "")
	{
		alert("Work Already Commissioned! Record Cannot be deleted!!");
	}
	else
	{
		document.forms[0].wcMode.value = 'delete';
		document.forms[0].action="/pred/works/WorkStatus.do?mode=delete";
		document.forms[0].submit();
	}
}
function funcReset()
{
document.forms[0].workCompActualDtOfComp.value="";
document.forms[0].dateOfComm.value="";
}

function imposeMaxLength(Object, MaxLen)
{
  return(Object.value.length <= MaxLen)
}
function showComphabDetails()
{
	   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/WorkStatus.do?mode=compShowHabs&workId="+workId;
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);

}
</script>
<tr>
		<td>
		<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>Work Completion</b></font></legend>
<label>
		 <table>
 		 <tr>
		<td width="180"><font face=verdana size=2><b>Start Date</b></td>
		<td width="160"><html:text  property="workCompStartDate"  readonly="true" /></td>
		<!-- <td><a href="javascript: showCalendar(document.workStatus.shd);">
						<img src="./resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td> -->
		<td width="160"><font face=verdana size=2><b>Stipulated Date Of Completion</b></td>

		<td width="150"><html:text property="workCompStipulatedDtOfComp"  readonly="true" /></td>
		<!-- <td><a href="javascript: showCalendar(document.workStatus.cdproj);">
						<img src="./resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td> -->
		</tr>
		<tr>
		<td width="160"><font face=verdana size=2><b>Probable Date Of Completion</b></td>
		<td width="150"><html:text property="probCompDate"  readonly="true" /></td>
		<!-- <td><a href="javascript: showCalendar(document.workStatus.cdproj);">
						<img src="./resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td> -->
		</tr>
		<tr>
		<td width="180"><font face=verdana size=2><b>Actual Date Of Completion</b></td>
		
		
		<td width="150px" align="left">
					<html:text  property="workCompActualDtOfComp"  maxlength="100"
							     style="width: 110px" 
								 onkeypress="return textOnly()" readonly="true"/>
					<a href="javascript:showCalendar(document.getElementById('workCompActualDtOfComp'))" >
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
				</td>
        <td width="180"><font face=verdana size=2><b>Date of commissioning</b></td>
		<td width="150px" align="left">
					<html:text  property="dateOfComm"  maxlength="100"
							     style="width: 110px" 
								 onkeypress="return textOnly()" readonly="false"/>
					<a href="javascript:showCalendar(document.getElementById('dateOfComm'))" >
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
	    </td>
		</tr>
		<tr>
		<tr>
		<td  ><font face=verdana size=2><b>Habitations Benefited(No)</b></td>
		<td colspan="2" ><html:text property="techHabsBen"  readonly="true"  onclick="showComphabDetails()" title="Click To View Habitation Details"/> 
<%
String habsben = (String)request.getAttribute("benCount"); 
session.setAttribute("abc",habsben);
System.out.println("HabsBen:"+habsben);
if(habsben != null && habsben.equals("1"))
{
%>
		<html:button property="mode" styleClass="btext" value="Add/Remove Habs" onclick="getMandalsToAddHabs()" title="Add/Remove Habitations" disabled="false"/> 
		<html:button property="mode" styleClass="btext" value="Show Habs" onclick="showComphabDetails()" title="Click To View Habitation Details" disabled="false"/> 
<%}
else if(habsben != null && habsben.equals("0"))
{
 %>
		<html:button property="mode" styleClass="btext" value="Add/Remove Habs" onclick="getMandalsToAddHabs()" title="Add/Remove Habitations" disabled="true"/> 
		<html:button property="mode" styleClass="btext" value="Show Habs" onclick="showComphabDetails()" title="Click To View Habitation Details" disabled="true"/> 

<%} %>		<td colspan=3 rowspan=3>
		<!-- code added -->
		<!-- 
		<fieldset>
		<legend><font color=#871D0E face=verdana size=2><b>Population Benefited(AS Per Census)</b></font></legend>
		<label>
		<table >
 		<tr>
 		<td>		
		
		<tr>
		 <td ><font face=verdana size=2><b>Plain</b> </font></td>
		 <td><html:text property="eplainPop" readonly="true"  /> </td>
		</tr>
		<tr>
		 <td><font face=verdana size=2><b>SC</b> &nbsp;&nbsp;</font></td>
		 <td><html:text property="escPop"  readonly="true"  /> </td>
		</tr>
		<tr> 
		 <td><font face=verdana size=2><b>ST</b> &nbsp;&nbsp;</font></td>
	     <td><html:text property="estPop" readonly="true"/></td>
		</tr>
		<tr> 
		 <td><font face=verdana size=2><b>Total</b> &nbsp;&nbsp;</font></td>
	     <td><html:text property="estTotPop" readonly="true"/></td>
		</tr>

 	    </table>
		</label>
		</fieldset>
 -->
		</td>
		</tr>
		<!-- end -->
		</td></tr>
		<!--<tr>
		<td width="160"><font face=verdana size=2><b>Habitation Names</b></td>
		<td width="150"><html:textarea property="techHabNames" style="height:70px;width:180px"/></td>
		</tr>  -->
	<%System.out.println("5"); %>	
		<tr> 
		 <td><font face=verdana size=2><b>Physical Stage/Remarks</b></font><font color="#FF6666">*</font></td>
		 <td><html:textarea rows="4" cols="20" property="remarks" onkeypress="return imposeMaxLength(this,199);"/></td>
	   </tr>		
		<tr>
			<td colspan="4" align="center">
			<input type=button value=Save title="Click here to Save" onclick="saveWorkCompletion()" class="bText"/> 
			<input type=button value=Delete title="Click here to Delete" onclick="deleteWorkCompletion()" class="bText"/> 
			<input type=button value=Reset title="Click here to Reset" onclick="funcReset()" class="bText"/> 

			
			</td>
		</tr>	
			</table>
		</label>
		</fieldset>
		 </td>
		</tr>
 <%@ include file="/commons/rws_alert.jsp"%>