<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%String saveDone = (String)request.getAttribute("saveDone");%>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
<script language="javascript">
function chekComm()
{
	if(document.forms[0].workCompActualDtOfComp.value=="")
	{
		alert("Work Not Yet Completed - So, You cannot Handover");
		document.forms[0].priYesOrNo.value='';
	}
}
function enterStandPostsAndHouseConns()
{
	var sd = '<%=saveDone%>';
	if(sd=="Y")
	{
		var workId = document.forms[0].elements["workId"].value;
		var workName = document.forms[0].elements["workId"].options[document.forms[0].elements["workId"].selectedIndex].text
		var width = 788;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		document.forms[0].wcMode.value = 'enterStandPostsAndHouseConns';
		url = "/pred/works/WorkStatus.do?mode=enterStandPostsAndHouseConns&workId="+workId+"&workName="+workName;
				
		var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=yes,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes";
	 	newWindow1 = window.open(url,"", properties);
	 	newWindow1.focus();
	}
	else if(sd=="N")
	{
		alert("You cannot enter the details before Entering the Work Completion Details");
	}

}
function fnPickHabitationsForWorkExpenditure()
{
	
	 
	var coc = document.forms[0].elements["cmbCircle"].value;
	var doc = document.forms[0].elements["cmbDivision"].value;
	var workID=document.forms[0].elements["cmbWorks"].value;
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
	endPos=dateString.indexOf(sepChar,curPos+1);			
    cMonth=dateString.substring(curPos+1,endPos);

	//extract year portion				
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	
	//Create Date Object
	dtObject=new Date(cYear,cMonth-1,cDate);	
	return dtObject;
}
function getMandalsToAddHabs()
{
//if(document.forms[0].workCompActualDtOfComp.value != null && document.forms[0].workCompActualDtOfComp.value != "")
//{
	var work=document.forms[0].elements["workId"].value;
	  var url="switch.do?prefix=/works&page=/PickCompHabs.do?workId="+work+"&revTs=No";
   var prop="top=100,left=0,height=300,width=600,location=1,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
//}
}
function validateFrm()
{
	var frm=document.forms[0];
	var validationPassed=true;
	if(frm.workCompActualDtOfComp.value!="" && frm.workCompStartDate.value!="")
	{
			dt1=getDateObject(document.forms[0].cDate.value,"/");
			
			dt2=getDateObject(document.forms[0].workCompActualDtOfComp.value,"/");
			if(dt1 < dt2){
				validationPassed=false;
				alert("Actual Date Of Completion should not be \ngreater than to Current Date("+frm.cDate.value+")");
			}
			else
		{
			var res=compareDates(frm.workCompActualDtOfComp.value, frm.workCompStartDate.value);
			if(res<0)
			{
					alert("Actual Date Of Completion should be \ngreater than or equal to Start Date("+frm.workCompStartDate.value+")");
				validationPassed=false;
			}
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
		if(document.forms[0].workCompStartDate.value == "")
		{
			alert("Please Enter the Work Start Date at Program Schedule Stage");
		}
		else if(document.forms[0].workCompActualDtOfComp.value == "" &&  document.forms[0].partialDateOfCompletion.value == "" )
		{
		alert("Please Enter the Actual Date Of Completion or Partial Coverage Date");
		}
		else
		{
			if(validateFrm())
			{
				 if(document.forms[0].workCompFinDtOfComp.value != "")
				 {
					if(document.forms[0].dateOfComm.value!="" || document.forms[0].dateOfComm.value=="")
					{
						dt1=getDateObject(document.forms[0].workCompActualDtOfComp.value,"/");
						dt2=getDateObject(document.forms[0].workCompFinDtOfComp.value,"/");
						if(dt1>dt2)
						{
							alert("Financial Date of Completion should not be \nless than Actual Date Of Completion("+document.forms[0].workCompActualDtOfComp.value+")");
						}
						else
						{
							if(confirm("Are You sure the ----Habitations Benefited---- is Updated as per Work Completion")){
							document.forms[0].wcMode.value = 'save';
							document.forms[0].action="/pred/works/WorkStatus.do?mode=save";
							document.forms[0].submit();
							}
						}
					}
					else
					{
						alert("Please Enter Date Of Commission");
					}
				 }
				 else
				 {
					 if(confirm("Are You sure the ----Habitations Benefited---- is Updated as per Work Completion")) {
						document.forms[0].wcMode.value = 'save';
						document.forms[0].action="/pred/works/WorkStatus.do?mode=save";
						document.forms[0].submit();
					 }
				}
			}
		}
}
function saveRemarksOnly()
{
	if(document.forms[0].remarks.value!="")
	{
		var url = "/pred/works/WorkStatus.do?mode=saveCompletionRemarks&workId="+document.forms[0].elements["workId"].value+"&remarks="+document.forms[0].remarks.value;
		ajaxFunction(url,document.forms[0].elements["mydivid"]);
	}
	else
	{
		alert("Please Enter the Remarks");	
	}
}
function ajaxFunction(URL,divobj)
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
				alert(xmlHttp.responseText);
				document.forms[0].elements["loads"].style.display='none';
				document.forms[0].elements["convert"].style.display='block';
			  }
			  else{
				  document.forms[0].elements["convert"].style.display='none';
				  document.forms[0].elements["loads"].style.display='block';
			  }
			}
			xmlHttp.open("GET",URL,true);
			xmlHttp.send(null);  
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
	   var workId=document.forms[0].elements["workId"].value;
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
		 <table width="800">
 		 <tr>
			<td width="256"><font face=verdana size=2><b>Start Date</b></td>
			<td width="83"><html:text  property="workCompStartDate"  readonly="true" /></td>
			<td width="277"><font face=verdana size=2><b>Stipulated Completion Date </b></td>
			<td width="159"><html:text property="workCompStipulatedDtOfComp"  readonly="true" /></td>
		</tr>
		<tr>
			<td width="256"><font face=verdana size=2><b>Probable Date Of Completion</b></td>
			<td width="83"><html:text property="probCompDate"  readonly="true" /></td>
<td width="256"><font face=verdana size=2><b>Coverage Date(Partial Coverage )<font color="#FF6666">*</font></b></td>
<td align="left">
        
					<html:text  property="partialDateOfCompletion"  maxlength="100"
							     style="width: 110px" 
								 onkeypress="return textOnly()" readonly="true"/>
<a href="javascript:showCalendar(document.forms[0].elements['partialDateOfCompletion'])" >
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">

					
		  </td>
		</tr>
		<tr>
		<td width="256"><font face=verdana size=2><b>Actual Date Of Completion<font color="#FF6666">*</font></b></td>
    	<td align="left">
        
		<%if(userid.equals("100000")){%>
					<html:text  property="workCompActualDtOfComp"  maxlength="100"
							     style="width: 110px" 
								 onkeypress="return textOnly()" />

<%} else {%>
				<html:text  property="workCompActualDtOfComp"  maxlength="100"
							     style="width: 110px" 
								 onkeypress="return textOnly()" readonly="true"/>

<%} %>
					<a href="javascript:showCalendar(document.forms[0].elements['workCompActualDtOfComp'])" >
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
		  </td>
        <td width="277"><font face=verdana size=2><b>Date of Commissioning</b></td>
		<td align="left">
		<%//System.out.println("dccccccccccc::"+userid);
		if(userid.equals("100000")){%>
		<html:text  property="dateOfComm"  maxlength="100" style="width: 110px"  onkeypress="return textOnly()" readonly="false"/>
<%}else{%>
	    <html:text  property="dateOfComm"  maxlength="100" style="width: 110px"  onkeypress="return textOnly()" readonly="true"/>
 <%}%>
					<a href="javascript:showCalendar(document.forms[0].elements['dateOfComm'])" >
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
	    </td>
		</tr>
		<tr>
		<td width="256"><font face=verdana size=2><b>Financial Date of Completion</b></td>
		<td>
		<%if(userid.equals("admin") || userid.equals("100000")){%>
		<html:text  property="workCompFinDtOfComp"  maxlength="100" style="width: 110px" onkeypress="return textOnly()" readonly="false"/>
		<%}else
		{
			%>
		<html:text  property="workCompFinDtOfComp"  maxlength="100" style="width: 110px" onkeypress="return textOnly()" readonly="true"/>
			<%
		}%>
			<a href="javascript:showCalendar(document.forms[0].elements['workCompFinDtOfComp'])"><img src="/pred/resources/images/calendar.gif" border="0" align="absmiddle"></td>
			<td width="256"><font face=verdana size=2><b>Handover to PRI</b></td>
		<td>
		<html:select  property="priYesOrNo" style="width: 110px" styleClass="myCombo" onchange="chekComm()">
		<html:option value="">-Select-</html:option>
		<html:option value="Y">Yes</html:option>
		<html:option value="N">No</html:option>
		</html:select >
		</td>
		</tr>
		<tr>
		  <%String code=(String)session.getAttribute("scode");
				//System.out.println("code in completion :"+code);%>
				<%  if(statss.equals("LAB")) {%>
				 <tr>
		         <td  ><font face=verdana size=2><b>Total Labs</b></td>
		         <td colspan="4" ><html:text property="techHabsBen"  readonly="true"  onclick="showComphabDetails()" title="Click To View Lab Details"/> 
				 <html:button property="mode" styleClass="btext" value="Show Labs" onclick="showComphabDetails()" title="Click To View Lab Details" disabled="false"/> 
				 </td></tr>
			  <%} else if(statss.equals("SCHOOLS")) {%>
				 <tr>
		         <td  ><font face=verdana size=2><b>Total Schools</b></td>
		         <td colspan="4" ><html:text property="techHabsBen"  readonly="true"  onclick="showComphabDetails()" title="Click To View School Details"/> 
				 <html:button property="mode" styleClass="btext" value="Show Schools" onclick="showComphabDetails()" title="Click To View School Details" disabled="false"/> 
				 </td></tr>
			 <%} else if(statss.equals("PUBLIC INSTITUTES")) {%>
			 <tr>
	         <td  ><font face=verdana size=2><b>Total Public Institutes</b></td>
	         <td colspan="4" ><html:text property="techHabsBen"  readonly="true"  onclick="showComphabDetails()" title="Click To View Public Institutes Details"/> 
			 <html:button property="mode" styleClass="btext" value="Show Public Institutes" onclick="showComphabDetails()" title="Click To View Public Institutes Details" disabled="false"/> 
			 </td></tr>
			  <%} else if(statss.equals("ANGANWADIS")) {%>
			 <tr>
	         <td  ><font face=verdana size=2><b>Total Anganwadis</b></td>
	         <td colspan="4" ><html:text property="techHabsBen"  readonly="true"  onclick="showComphabDetails()" title="Click To View Anganwadi Details"/> 
			 <html:button property="mode" styleClass="btext" value="Show Anganwadis" onclick="showComphabDetails()" title="Click To View Anganwadi Details" disabled="false"/> 
			 </td></tr>
		 <%}
			  else{%>
		<tr>
		<td  ><font face=verdana size=2><b>Habitations Benefited(No)</b></td>
		<td colspan="4" ><html:text property="techHabsBen"  readonly="true"  onclick="showComphabDetails()" title="Click To View Habitation Details"/> 
<%
String habsben = (String)request.getAttribute("benCount"); 
session.setAttribute("abc",habsben);
if(physicalStatuss!=null && physicalStatuss.equals("Financially Completed") || physicalStatuss.equals("Commissioned") || !workCancelleddDate.equals(""))
{
%>
			<html:button property="mode" styleClass="btext" value="Add/Remove Habs" onclick="getMandalsToAddHabs()" title="Add/Remove Habitations" disabled="true"/> 
			<html:button property="mode" styleClass="btext" value="Show Habs" onclick="showComphabDetails()" title="Click To View Habitation Details" disabled="false"/> 
<%
}
else
{
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
			<html:button property="mode" styleClass="btext" value="Show Habs" onclick="showComphabDetails()" title="Click To View Habitation Details" disabled="false"/> 
	
	<%}
} %>
	<td width="0" colspan=3 rowspan=3>
	</td>
	</tr>
<%}%>

	


	   <tr> 
		 <td>&nbsp;</td>
	   </tr>
		<%if(physicalStatuss!=null && physicalStatuss.equals("Financially Completed") || !workCancelleddDate.equals(""))
	    {
	    	if(userid.equals("admin") || userid.equals("100000"))
			{
		%>
			<tr>
				<td colspan="4" align="center">
					<input type=button value=Save title="Click here to Save" onclick="saveWorkCompletion()" class="bText"/> 
					<input type=button value=Delete title="Click here to Delete" onclick="deleteWorkCompletion()" class="bText"/> 
					<input type=button value=Reset title="Click here to Reset" onclick="funcReset()" class="bText"/> 
				</td>
			</tr>	
		<%
			}
			else
			{
			%>
			<tr>
				<td colspan="4" align="center">
					<input type=button value=Save title="Click here to Save" onclick="saveWorkCompletion()" class="bText" disabled/> 
					<input type=button value=Delete title="Click here to Delete" onclick="deleteWorkCompletion()" class="bText" disabled/> 
					<input type=button value=Reset title="Click here to Reset" onclick="funcReset()" class="bText" disabled/> 
				</td>
			</tr>	
		<%
			}
		}
		else
		{
		if(session.getAttribute("groundingStatus")!=null && session.getAttribute("groundingStatus").equals("yes"))
			{
		%>
			<tr>
				<td colspan="4" align="center">
					<input type=button value=Save title="Click here to Save" onclick="saveWorkCompletion()" class="bText"/> 
					<input type=button value=Delete title="Click here to Delete" onclick="deleteWorkCompletion()" class="bText"/> 
					<input type=button value=Reset title="Click here to Reset" onclick="funcReset()" class="bText"/> 
				</td>
			</tr>	
		<%
			}
			else
			{
			%>
			<tr>
				<td colspan="4" align="center">
					<input type=button value=Save title="Click here to Save" onclick="saveWorkCompletion()" class="bText" disabled/> 
					<input type=button value=Delete title="Click here to Delete" onclick="deleteWorkCompletion()" class="bText" disabled/> 
					<input type=button value=Reset title="Click here to Reset" onclick="funcReset()" class="bText" disabled/> 
				</td>
			</tr>	
		<%
			}
		%>
		
		<%} %>
		 <tr> 
		 <td colspan=4><font face=verdana size=2 color=red>Note:***Even If Work is not Completed - You may enter Remarks (or) Physical Stage of the Work</td>
	   </tr>
		<tr> 
		 <td><font face=verdana size=2><b>Physical Stage/Remarks<font color="#FF6666">*</font></b></td>
		 <td><html:textarea rows="4" cols="20" property="remarks" onkeypress="return imposeMaxLength(this,199);"/></td>
		 <td colspan="2" align=left>
			 <div id="convert" style="position:relative;overflow-y:auto;left:10;height:20;width:270;top:1;display:block">
		 	&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value="Save Remarks Only" title="Click here to Save Remarks Only" onclick="saveRemarksOnly()" class="bText"/> 
		 	</div>
		 	<div id="loads" style="position:relative;overflow-y:auto;left:10;height:20;width:270;top:5;display:none">&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/loader-3.gif"/></div>
		 </td>
	   </tr>
		<tr> 
		 <td colspan=4><font face=verdana size=2 color=red>Note:***If Work is Completed - You may enter Stand Posts and Household Connections for Benefited Habitations</td>
	   </tr>
		<% if(statss!=null && !(statss.equals("LAB") || statss.equals("SCHOOLS"))){%>
		<tr> 
		 <td colspan="4" align=center>
			<input type=button value="Add House Connections (FHTC) details/ Coverage of habitation" title="Click here to Enter House Conn. and individual tap conn for Benefited Habitations" onclick="enterStandPostsAndHouseConns()" class="bText"/> 
		 </td>
	   </tr>
       <%} %>
	   </table>
		</label>
		</fieldset>
		 </td>
		</tr>
<%java.util.Date d=new java.util.Date();
		java.text.SimpleDateFormat format=new java.text.SimpleDateFormat("dd/MM/yyyy"); 
		String currentDate=format.format(d);%>
<input type="hidden"  name="cDate"    value='<%=currentDate%>'/>		
 <%@ include file="/commons/rws_alert.jsp"%>
<!--  alter table rws_work_completion_tbl add house_conn number(4);
 alter table rws_work_completion_tbl add stand_posts number(4) -->