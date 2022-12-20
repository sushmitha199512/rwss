<% int workInProgressCount=0;%>
<tr>
		<td>
		<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>Work in Progress</b></font></legend>
<label>
		 <table cellpadding="4" cellspacing="4" border="0"    
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;">
		 
 	<tr>
		<td width="190" valign="bottom"><font face=verdana size=2><b>SubDivision Assigned to</b></td>
		<td width="150" valign="bottom"><html:select property="subDivAssign" style="width:183px"  styleClass="noborder-text-box" >
		<logic:present name="subDivisions">
	 	<html:options collection="subDivisions"  name="labelValueBean" 
								property="value" labelProperty="label"/>	</logic:present>
	 		</html:select></td>
	 		
	 		
		
		
		<td rowspan=3>
		<fieldset>
		<legend><font color=#871D0E face=verdana size=2><b>Engineers Assigned to</b></font></legend>
		<label>
		<table>			
		<tr><td width="150">1.&nbsp;<html:text property="engineerAssign"  styleClass="mytext" /></td>
		<td width="150">2.&nbsp;<html:text property="engineerAssign1"  styleClass="mytext" /></td></tr>
		<tr><td width="150">3.&nbsp;<html:text property="engineerAssign2"  styleClass="mytext" /></td>
		<td width="150">4.&nbsp;<html:text property="engineerAssign3"  styleClass="mytext" /></td></tr>
		</tr>
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		<tr>
		<td width="180" valign="top"><font face=verdana size=2><b>Work Start Date</b></td>
			
		<td width="190" valign="top"><html:text property="workGndDate" style="width:145" styleClass="mytext" />
			<a href="javascript: showCalendar(document.monitoringForm.workGndDate);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
			</a>
		</td>
		</tr>
		
		</table>
		</label>
		</fieldset>
		 </td>
		</tr> 
		<tr>
	<td>
<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>Work MileStones</b></legend>

	<label>
			<table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			<!-- <thead class="gridHeader"> -->
			<tr  bgcolor="#8A9FCD">
				<td align="center"><font size=1><b>S.No.</font></b></td>
				<td align="center"><font size=1><b>Milestone</font></b></td>
				<td align="center"><font size=1><b>Stage</font></b></td>
				<td align="center"><font face=verdana size=1><b>Target Date</td>
				 <td align="center"><font face=verdana size=1><b>Achievement Date</td> 
				<td align="center"><font face=verdana size=1><b>%completed</td>
			 
			</tr>
			
 			   <% workInProgressCount=0;%>
				<nested:iterate id="WORK" property="mileStones" indexId="ndx">
			 	  <%workInProgressCount++;%>
			 	  <tr bgcolor="#ffffff">
				<td>
				<font face=verdana size=2>
				<%=workInProgressCount %>
				</font>
				</td>
				<td>
					<nested:text name="WORK" property="mstoneName"  indexed="true"  maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()" readonly="true"/>
				</td>
				<td>
					<nested:text name="WORK" property="mstoneStageName" indexed="true"  maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()"  readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="targetDate" indexed="true"  maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()"  readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="achievementDate" indexed="true"  maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" />
				<a href="javascript:showCalendar(document.getElementById('WORK[<%=workInProgressCount-1%>].achievementDate'));">
		             <IMG SRC="<rws:context page='/images/calendar.gif'/>"   border="0" height="17" ></a>
				</td>
				 
				<td>
					<nested:text name="WORK" property="percentComp"  maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()"  readonly="true" />
				</td>
				<nested:hidden name="WORK"  indexed="true"  property="mstoneCode"/>
				<nested:hidden name="WORK"  indexed="true"  property="mstoneStageCode"/>
				 
				</tr>
				</nested:iterate>
		 		 <html:hidden property="revflag"/>
		 		 <html:hidden property="agreeDate"/>
					<tr> 
					 <td colspan=10 align="center"> 
		 			<input type="button" name="text1" value="Save" class="bText" onclick="saveProgramschedule()"/>
		 			<input type="button" name="text1" value="Delete" class="bText" onclick="deleteProgramschedule()"/>
	 		</td>
			</tr>
				</table>
				</label>
				
			</fieldset>
			
			 </td> 
			</tr>
			
		 <script language="javascript">
		function validateWorkInProgressForm()
		{
		var frm=document.forms[0];
		var startDate=frm.workGndDate.value;
		var validationPassed=true;
			for(var i=0;i<<%=workInProgressCount%>&&validationPassed;i++)
			{
				var achievementDate=document.getElementById("WORK["+i+"].achievementDate").value;
				if(startDate!="" && achievementDate!="")
				{
					var res=compareDates(achievementDate, startDate);
					if(res<0)
					{
						alert("Achievement Date for MileStone with S.No."+(i+1)+"\nshould be greater than or equal to Start Date");
						validationPassed=false;
					}
						
				}
			}
		return validationPassed;
		}
		
		function saveProgramschedule()
		{
			dt1=getDateObject(document.forms[0].agreeDate.value,"/");
			dt2=getDateObject(document.forms[0].workGndDate.value,"/");
			if(dt1>dt2)
				alert("Work Start Date should be greater than or equal Agreement Date("+document.forms[0].agreeDate.value+")");
			else
			{
				var validationPassed=validateWorkInProgressForm();
				if(validationPassed)
				{	
					document.monitoringForm.revflag.value="saveWip";
					document.monitoringForm.submit();
				}
			}
		}
		function deleteProgramschedule()
		{
			document.monitoringForm.revflag.value="deleteWip";
			document.monitoringForm.submit();
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
		 </script>