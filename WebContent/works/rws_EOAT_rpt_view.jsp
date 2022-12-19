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
	<font class="clrborder">Circle:</font>&nbsp;<font class="textborder"><%=session.getAttribute("circleOfficeName") %></font>&nbsp;&nbsp;
	<font class="clrborder">Division:</font>&nbsp;<font class="textborder"><%=session.getAttribute("divisionOfficeName") %></font>&nbsp;&nbsp;
	<font class="clrborder">Sub Division:</font>&nbsp;<font class="textborder"><%=session.getAttribute("subDivisionOfficeName") %></font>
	</small>
	</td>
</tr>

<tr>
<td>
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>

<thead>
<tr><td align="right"><b><small>Amount In Rs Lakhs</small></b></td></tr>
<tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="EOAT Report" />
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td></tr></thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>
<tbody>
<tr>
<td>

<!--  form fields starts from here -->
<table   align=center bgcolor="white" bordercolor= "black"  border="1"  style="border-collapse:collapse;" width="100%" >	
<logic:iterate id="eoat" name="eoatList">
	<tr  height="800"><td class="clrborder" style="height:35"><font color="green" size="2pt">EOAT Details for work: </font><font color="black"><bean:write name="eoat" property="workName" /></font>&nbsp;&nbsp;<font color="green" size="2pt">SNo:&nbsp;</font><font color="black"><bean:write name="eoat" property="sno" /></font></td></tr>
	<tr><td>
	
	<table   align=center bgcolor="white" bordercolor= "#8A9FCD"  border="0"   width="100%" >	
  	<tr>
		<td class="clrborder">
			<font color="#708090">Work Details</font>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<table   align=center bgcolor="white" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
						<tr class="textborder">
					   		<td width="150" class="clrborder">
					   			Work Name
					   		</td>
					   		<td colspan="3">
					   			<bean:write name="eoat" property="workName" />
				    		</td>
				    		<td width="150" class="clrborder">
					   			Programme
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="programmeName" />	  
							</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			Value Of WorkDone
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="valueOfWorkDone" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Cost Of Work
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="costOfWork" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Value Of Work Beyond Agreement
					   		</td>
					   	
				    		<td>
					   			<bean:write name="eoat" property="valueOfWorkBeyondAgreement" />
					   		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			Value of Work to be done
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="valueOfWorkToBeDone" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Date of completion
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="dateOfCompletion" />
					   		</td>
					   	</tr>
					   	
					</table>
		</td>
	</tr>
	<tr>
	<td class="clrborder" ><font color="#708090"> EOAT Details</font></td>
	</tr>
	<tr>
		<td class="mycborder" colspan="2">
			<table   align=center bgcolor="white" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
						<tr class="textborder">
					   		<td width="150" class="clrborder">
					   			EOAT Order No
					   		</td>
					   		<td>
					   			<bean:write name="eoat" property="eoatOrderNo" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			EOAT Date
					   		</td>
					   		<td>
					   			<bean:write name="eoat" property="eoatDate" />
					   		</td>
					   		<td width="150" class="clrborder">
					   			Cost Escalation Sought
					   		</td>
					   		<td>
					   			<bean:write name="eoat" property="costEsclationSought" />
					   		</td>
				    		
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			EOAT Period
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="eoatPeriod" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			EOAT Old Ref No1
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="eoatOldRefNo1" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			EOAT Old Ref Date1
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="eoatOldRefDate1" />
					   		</td>
				    		
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			EOAT Old Ref No2
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="eoatOldRefNo2" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			EOAT Old Ref Date2
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="eoatOldRefDate2" />
					   		</td>
					   	</tr>
					   	
					</table>
				</td>
	</tr>
	<tr>
	<td class="clrborder"><font color="#708090">Details Of Fine</font></td>
	</tr>
	<tr>
		<td class="mycborder" >
			<table   align=center bgcolor="white" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
						<tr class="textborder">
					   		<td width="150" class="clrborder">
					   			Fine Imposed
					   		</td>
					   		<td width="150">
					   			<bean:write name="eoat" property="fineImposed" />
					   		</td>
				    		<td  rowspan=2 width="150" class="clrborder">
					   			Reasons for not recovering fine
					   		<td rowspan=2 align="left" >
					   			<bean:write name="eoat" property="reasonsForNotRecoveringFine" />
					   		</td>
				    		</tr>
				    		<tr class="clrborder">
				    		<td >
					   			Fine Recovered
					   		</td>
					   		<td class="textborder">
					   			<bean:write name="eoat" property="fineRecovered" />
					   		</td>
				    		
				    		
				    		
				    	</tr>
				   </table>
				</td>
	</tr>
	<tr>
	<td class="clrborder"><font color="#708090">Officers Responsible</font></td>
	</tr>
	<tr>
		<td class="mycborder" >
			<table   align=center bgcolor="white" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
						<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			Officer Responsible1
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="officerResponsible1" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Officer Responsible2
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="officerResponsible2" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Officer Responsible3
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="officerResponsible3" />
					   		</td>
				    	</tr>
				    	
			  		</table>
				</td>
	</tr>
	<tr>
	<td class="clrborder"><font  color="#708090">Recommenditions</font></td>
	</tr>
	<tr>
		<td class="mycborder" >
			<table   align=center bgcolor="white" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
						<tr class="textborder">
					   		<td width="150" class="clrborder">
					   			AEE Recommend
					   		</td>
				    		<td width="305">
					   			<bean:write name="eoat" property="aeeRecommend" />
					   		</td>
					   		<td width="150" class="clrborder">
					   			DEE Recommend
					   		</td>
				    		<td width="305">
					   			<bean:write name="eoat" property="deeRecommend" />
					   		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			EE Recommend
					   		</td>
					   		<td width="305">
					   			<bean:write name="eoat" property="eeRecommend" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			SE Recommend
					   		</td>
				    		<td width="305">
					   			<bean:write name="eoat" property="seRecommend" />
					   		</td>
				    	</tr>
				    	<tr class="textborder">
					   		<td width="150" class="clrborder">
					   			CE Recommend
					   		</td>
					   		<td width="305">
					   			<bean:write name="eoat" property="ceRecommend" />
					   		</td>
				    		
			            </tr>
				   </table>
				</td>
	</tr>
	<tr>
	<td class="clrborder"><font  color="#708090">Other Details</font></td>
	</tr>
	<tr>
		<td class="mycborder" colspan="2">
			<table   align=center bgcolor="white" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
						<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			Exemption Recommended by SE
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="exemptRecommendedBySE" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Total Days Exempted by SE
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="totalDaysExemptBySe" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Rate of penalty
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="rateOfPenalty" />
					   		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			Total penalty
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="totalPenalty" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Reasons by contractor
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="reasonsByContractor" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Contractor Rep made Upd
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="contractorRepMadeUpd" />
					   		</td>
					   	</tr>
					   	
					<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			Agreement copy penalty upd
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="agreementCopyPenaltyUpd" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Supp document for exemption upd
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="suppDocumentForExempUpd" />
					   		</td>
				    		
				    		<td width="150" class="clrborder">
					   			EOAT Grant Authority
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="eoatGrantAuthority" />
					   		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			Supplimentary Agreement No
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="suppAgreeNo" />
					   		</td>
					   		<td width="150" class="clrborder">
					   			Supplimentary Agreement Date
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="suppAgreeDt" />
					   		</td>
				    		<td width="150" class="clrborder">
					   			Prepared By
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="preparedBy" />
					   		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150" class="clrborder">
					   			Prepared On
					   		</td>
				    		<td>
					   			<bean:write name="eoat" property="preparedDate" />
					   		</td>
					   	</tr>
					   	
					</table>
				</td>
	</tr>
</table>
</td>
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
