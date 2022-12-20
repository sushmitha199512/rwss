<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">

function initFunc()
{
	
}

</script>
<body onload="initFunc()">
<html:form action="eoatFrm.do">
<tr>
	<td>
	<small>
	
	
	</small>
	</td>
</tr>

<tr>
<td>
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>



<tr>
<td>

<!--  form fields starts from here -->
<logic:iterate id="eoat" name="eoatList">
	
	<table   align=center bgcolor="white" bordercolor= "#8A9FCD"  border="0"   width="100%" >	
  	<tr>
		<td class="clrborder" align="center">
			<font color="#708090"><u><big>E.O.A.T.</big></u></font>
		</td>
	</tr>
  	<tr>
		<td class="clrborder" align="center">
			<font color="#708090" ><u><big>CHECK SLIP FOR EXTENSION OF AGREEMENT TIME</big></u></font>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td >
			<table   align=center bgcolor="white" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
						<tr class="textborder">
					   		<td width="150" class="clrborder">
					   			<font class="clrborder">1. District:</font>
					   		</td>
					   		<td width="150" class="clrborder">
								<font class="textborder"><bean:write name="eoat" property="districtName" /></font>
							</td>
						</tr>
						
						<tr class="textborder">
					   		<td width="150" class="clrborder">
					   			<font class="clrborder">2. Circle:</font>
					   		</td>
					   		<td width="150" class="clrborder">
								<font class="textborder"><%=session.getAttribute("circleOfficeName") %></font>
							</td>
						</tr>
						
						<tr class="textborder">
						<td width="150" class="clrborder">
						<font class="clrborder">3. Division:</font>
						</td>
						<td width="150" class="clrborder">
						<font class="textborder"><%=session.getAttribute("divisionOfficeName") %></font>
						</td>
						</tr>
						
						<tr class="textborder">
						<td width="150" class="clrborder">
						<font class="clrborder">4. Sub Division:</font>
						</td>
						<td width="150" class="clrborder">
						<font class="textborder"><%=session.getAttribute("subDivisionOfficeName") %></font>
						</td>
						</tr>
						<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			5.	Section
					   		</td>
				    		<td>
					   			
					   		</td>
					   	</tr>
						<tr class="textborder">
					   		<td width="150" class="clrborder">
					   			6. Work Identity Number
					   		</td>
					   		<td >
					   			<bean:write name="eoat" property="workId" />
				    		</td>
				    	</tr>
						<tr class="textborder">
					   		<td width="150" class="clrborder">
					   			7. Work Name
					   		</td>
					   		<td >
					   			<bean:write name="eoat" property="workName" />
				    		</td>
				    	</tr>
				    	
						<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			8.	Grant/Scheme
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="typeOfAsset" />	  
							</td>
						</tr>
						<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			9.	Admin. sanction Reference NO & Date
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="adminNo" />-<bean:write name="eoat" property="adminDate" />	  
							</td>
						</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			10. Cost Of Work
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="costOfWork" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			11.	Tech. Approval Date
					   		</td>
				    		<td>
					   			
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			12.	Tech.sanction reference No. & Date
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="tsNo" />-<bean:write name="eoat" property="tsDate" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			13.	Tenders approved by
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="tenderCommittee" />,<bean:write name="eoat" property="competentAuthority" />
					   		</td>
					   	</tr>
					   	
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			14.	Date of Approval
					   		</td>
				    		<td>
					   			
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			15.	Whether Item Rate/Percent Rate
					   		</td>
				    		<td>
					   			
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			16.	Tender Premium
					   		</td>
				    		<td>
					   			
					   		</td>
					   	</tr>
					   	
					   	
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			17.	Contract Value
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="contractValue" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			18.	Name of the Contractor
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="contractName" />
					   		</td>
					   	</tr>
					   		<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			19.	Date of Agreement
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="dateOfAgreement" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			20.	Date of Handover site
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="dateOfHandOverSite" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			21.	Period of Contract
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="periodOfContract" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			21.	Period of Contract
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="periodOfContract" />
					   		</td>
					   	</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			22.	Value of work done up to agreement period
					   		</td>
					   	
				    		<td>
					   			
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			23.	Cost of work completed
					   		</td>
				    		<td>
					   			
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			24.	Value of work done beyond agreement Period
					   		</td>
				    		<td>
					   			
					   		</td>
					   	</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			25. Value of Work to be done
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="valueOfWorkToBeDone" />
					   		</td>
					   	</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			26. Date of completion
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="dateOfCompletion" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			27.	Extension of time give earlier if any
     								Reference No. & authority

					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="dateOfCompletion" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
					   	   <td width="150" class="clrborder">
					   			28. Fine Imposed In Past
					   		</td>
					   		<td width="150">
					   			<bean:write name="eoat" property="fineImposed" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td  width="150" class="clrborder">
					   			29. Fine Recovered In Past
					   		</td>
					   		<td class="textborder">
					   			<bean:write name="eoat" property="fineRecovered" />
					   		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td  width="150" class="clrborder">
					   			30. Reasons,if fine was not already
      							Recovered and name of officers 
     							Responsible

					   		<td  align="left" >
					   			<bean:write name="eoat" property="reasonsForNotRecoveringFine" />-
					   			<bean:write name="eoat" property="officerResponsible1" />,
					   			<bean:write name="eoat" property="officerResponsible2" />,
					   			<bean:write name="eoat" property="officerResponsible3" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
					   		<td width="150" class="clrborder">
					   			31. EOAT now sought upto
					   		</td>
					   		<td>
					   			<bean:write name="eoat" property="costEsclationSought" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		
				    		<td width="150" class="clrborder">
					   			32. No.of days
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="eoatPeriod" />
					   		</td>
					   	</tr>
				    	
				    	
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			33. Exemptions recommended by the SE 
      								Reasons  From  To Days Supporting Information

					   		</td>
				    		<td width="305">
				    			<bean:write name="eoat" property="exemptRecommendedBySE" />-
					   			<bean:write name="eoat" property="seRecommend" />
					   		</td>
					   	</tr>
					   <tr class="textborder">
				    		<td width="150" class="clrborder">
					   			34. Total days of exemption of recommended by the SE
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="totalDaysExemptBySe" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			35.	No.of days to be Penalised(32-33)
					   		</td>
				    		<td>
					   			
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    	
				    		<td width="150" class="clrborder">
					   			36. Rate of Penalty per day as per agreement clause
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="rateOfPenalty" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
					   	
					   		<td width="150" class="clrborder">
					   			37. Total penalty
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="totalPenalty" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			38. Reasons given by Contractor
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="reasonsByContractor" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		
				    		<td colspan="2" width="150" class="clrborder">
					   			40. Recommendations
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="305" class="clrborder">&nbsp;&nbsp;a. AEE/AE</td>
				    		<td><bean:write name="eoat" property="aeeRecommend" /></td>
				    	</tr>
					   	<tr class="textborder">
				    		<td width="305" class="clrborder">&nbsp;&nbsp;b. DEE</td>
				    		<td><bean:write name="eoat" property="deeRecommend" /></td>
				    	</tr>
					   	<tr class="textborder">
				    		<td width="305" class="clrborder">&nbsp;&nbsp;c. EE</td>
				    		<td><bean:write name="eoat" property="eeRecommend" /></td>
				    	</tr>
					   	<tr class="textborder">
				    		<td width="305" class="clrborder">&nbsp;&nbsp;d. SE</td>
				    		<td><bean:write name="eoat" property="seRecommend" /></td>
				    	</tr>
					   	<tr class="textborder">
				    		<td width="305" class="clrborder">&nbsp;&nbsp;e. CE</td>
				    		<td><bean:write name="eoat" property="ceRecommend" /></td>
				    	</tr>
					  
				    	
				    	
				    	</logic:iterate>
</table>


<!--  end of form fields -->
</td>
</tr>
</tbody>
</table>

</td>
</tr>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
