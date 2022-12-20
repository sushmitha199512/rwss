<script language="javascript">
function mstoneChanged(index)
{

	document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?mode=mstoneChanged&index="+index;
	document.monitoringForm.submit();

}
function removeMileStones()
{

	document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?mode=remove";
	document.monitoringForm.submit();

}
function saveMileStones()
{
    var tenderID=document.getElementById('tenderNoteId').value;
	if(tenderID!='')
    {
	  document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?mode=save";
	  document.monitoringForm.submit();
	 }
	 else
	 {
	  alert("Enter Tender Id number");
	 }

}
</script>
<tr>
		<td>
		<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>Contractor Management (Amount In Rs.Lakhs)</b></font></legend>
<label>
		 <table border=0>
		
			
			
		<tr>
		<td width="120"><font face=verdana size=2><b>Tender Notification Id</b></td>
		<td width="180"><html:text property="tenderNoteId"  maxlength="100" /></td>
		<td width="120"><font face=verdana size=2><b>Tender Cost</b></td>
		<td width="180"><html:text property="tenderCost"  onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)"  /></td>
		</tr> 
		<tr>
		<td width="120"><font face=verdana size=2><b>Contractor/Firm Name</b></td>
		<td width="150"><html:text property="cfName" maxlength="100" onkeypress="return textOnly()" /></td>
		<td width="120"><font face=verdana size=2><b>Tender Accepted Date</b></td>
		<td width="150"><html:text property="tenderAccDate"  style="width:105px" readonly="true"/>
		<a href="javascript: showCalendar(document.monitoringForm.tenderAccDate);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
		</tr>
		<tr>
		<td width="120"><font face=verdana size=2><b>LOA Issued on Date</b></td>
		<td width="150"><html:text property="loa"  style="width:105px" readonly="true"/>
								 <a href="javascript: showCalendar(document.monitoringForm.loa);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a>
		</td>
		<td width="120"><font face=verdana size=2><b>Tender Percentage</b></td>
		<td width="120"><html:text property="tenderPer" style="width:105px"/></td>
		</tr>
		<tr>
		<td  colspan=4 nowrap><font color=#871D0E face=verdana size=2><b>Tender Approved By:</b></td>
		</tr>
		<tr>
		<td> 
		<input type=radio name="tenderCommittee" onclick="setRadioVal1()"/> 
		 <font face=verdana size=2><b>Tender Committee</b> </font></td>
		<td> <input type=radio name="compAuthority" onclick="setRadioVal2()"/> 
		 <font face=verdana size=2><b>Competent Authority</b></td>
		<script>
		function setRadioVal1()
		{
		 
		 document.getElementById('compAuthority').checked=false;
		  
	 	}
	 	function setRadioVal2()
		{
	 	 document.getElementById('tenderCommittee').checked=false;
	 	   
	 	}
		</script>

		</tr>
		
			<td class=label width="180"><font color=#871D0E face=verdana size=2><b>Agreement Details</b></td></font>
			<tr>
			<td width="120"><font face=verdana size=2><b>Agreement Reference No</b></td>
		<td width="160"><html:text property="agreeRefNo" maxlength="20" onkeypress="return textOnly()" /></td>
		
		<td width="150"><font face=verdana size=2><b>Agreement Date</b></td>
		<td width="150"><html:text property="agreeDate"  style="width:105px" readonly="true"/>
		<a href="javascript: showCalendar(document.monitoringForm.agreeDate);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
		</tr> 
		<tr>
		<td width="120"><font face=verdana size=2><b>Agreement Duration in months</b></td>
		<td width="150"><html:text property="agreeDur"  maxlength="2" onkeypress="return numeralsOnly()" /></td>
		<td width="120"><font face=verdana size=2><b>Agreement Value(Rs.In laks)</b></td>
		<td width="160"><html:text property="agreeVal" onkeyup="extractNumber2(this,11,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)"   /></td>
		
		
		</tr> 
			<tr>
		<td width="120"><font face=verdana size=2><b>Site Handingover Date</b></td>
		<td width="160"><html:text property="siteHandDate"  style="width:105px" readonly="true"/>
								 <a href="javascript: showCalendar(document.getElementById('siteHandDate'));">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
		<td width="120"><font face=verdana size=2><b>Stipulated Date Of Completion</b></td>
		<td width="150"><html:text property="workCompDate"  style="width:105px" readonly="true"/>
		<a href="javascript: showCalendar(document.monitoringForm.workCompDate);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
		</tr> 
		<tr>
		 <!-- 
		 <td width="120"><font face=verdana size=2><b>Agreement Authority</b></td>
		 <td width="160"><html:text property="compAuthority"   /></td>
		 -->
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
			<td align="center"><font size=1><b>SlNo</font></b></td>
				<td align="center"><font size=1><b>MileStone</font></b></td>
				<td align="center"><font size=1><b>Stage</font></b></td>
				<td align="center"><font face=verdana size=1><b>Target Date</td>
				<!-- <td><font face=verdana size=1><b>Achieved Date</td> -->
				<td align="center"><font face=verdana size=1><b>%completed</td>
				
			</tr>
			<% int workCount = 0;%>
			<%try{ %>
			<nested:iterate id="CONTMGT_MILESTONES_LIST" property="mileStones" indexId="ndx"> 
			<% workCount++; %>
			 <tr bgcolor="#ffffff">
				<td width="90px" align="center">
					<%=workCount%>.<input type="checkbox" name="remove" value="<%= ndx%>">
				</td>
				
				  <td width="90px" align="center">
					  
						<nested:select name="CONTMGT_MILESTONES_LIST" property="mstone" indexed="true"
									   style="width: 110px" styleClass="noborder-text-box" 
									   onchange='<%= "javascript: mstoneChanged(\" + ndx +\")"%>' >
							<html:option value="">Select...</html:option>
							<nested:options collection="mileStone" name="labelValueBean" 
										  property="mstoneCode" labelProperty="mstoneName" />
										  
						</nested:select>
					
				</td>
				<td width="160px" align="center">
				<nested:select name="CONTMGT_MILESTONES_LIST" property="stages" indexed="true"
									   style="width: 160px" styleClass="noborder-text-box" >
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<logic:present name="stage">
							
							<nested:optionsCollection property="mileStoneStagesList" name="CONTMGT_MILESTONES_LIST" label="label" value="value" />
							
							
							</logic:present>
						</nested:select> 
						</td>
				<td width="200px" align="center">
					<nested:text name="CONTMGT_MILESTONES_LIST" property="targetDate" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()" readonly="true"/>
					<a href="javascript:showCalendar(document.getElementById('CONTMGT_MILESTONES_LIST[<%=ndx%>].targetDate'))" >
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
				</td>
				<td width="120px" align="center">
					<nested:text name="CONTMGT_MILESTONES_LIST" property="percentComp" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								onkeyup="extractNumber2(this,5,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)"  />
				</td> 
			 	 </tr> 
				</nested:iterate> 
				<%}catch(Exception e){System.out.println("Exception s "+e);} %>
				<tr bgcolor="#ffffff">
				<td colspan="10" align="right"> <input type=button value=AddNew onclick="addNew()" class="bText"/> 
				 <input type=button value="Remove" onclick="removeMileStones()" class="bText"/></td>
				</tr>
				 </table>
				 </label>
				 </fieldset>
				 </td>
				 </tr>
				 
		 
			
				 <tr>
		 	<td align="center" >
			<html:hidden property="revflag" />
			<%
			//int cnt = 0;
			String revchkcount = (String)request.getAttribute("revchkcount");
			request.setAttribute("revchkcount",revchkcount);
			if (revchkcount == null)
			revchkcount = "";
			 
			  if (revchkcount.equals("0"))
			  {
			  // cnt = Integer.parseInt(count);
			   
			   %>
			
		<!-- <input type=button value=Save onclick="sinsert(this)" class="bText"/> -->
		<input type=button value=Save onclick="saveMileStones()" class="bText"/> 
		<%
		}
			if (!revchkcount.equals("0") && !revchkcount.equals(""))
			{
				 
		 %>
		  <!-- <input type=button value=Save onclick="supdate(this)" class="bText"/> -->
		  <input type=button value=Save onclick="saveMileStones()" class="bText"/> 
		 <% }%>
		  
		<html:hidden property="revdel" />
		 <input type=button value=Delete onclick="sfndelete()" class="bText"/> 
		 
		  </td></tr> </table>
			
