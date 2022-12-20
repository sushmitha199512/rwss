 <%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<script language="javascript">
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
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	dtObject=new Date(cYear,cMonth-1,cDate);	
	return dtObject;
} 

function fnSubmit(mode)
{
	var validateSuccess=true;
	if(mode=='view')
	{
		if(document.forms[0].circleOfficeCode.value=="")
		{
			alert("Please select Circle");
			validateSuccess=false;
		}
		else if(document.forms[0].divisionOfficeCode.value=="")
		{
			alert("Please select Division");
			validateSuccess=false;
		}
		else if(document.forms[0].subDivisionOfficeCode.value=="")
		{
			alert("Please select SubDivision");
			validateSuccess=false;
		}
	}
	if(validateSuccess)
	{
		document.forms[0].action="/pred/works/eoatFrm.do?mode="+mode;
		document.forms[0].submit();
	}
}
function fnview()
{
  if(document.forms[0].circleOfficeCode.value=="")
	{
		alert("Please Select Circle");
	    return false;
	}
	else
	{
		document.forms[0].action="/pred/works/eoatFrm.do?mode=view";
		document.forms[0].submit();
	}
}
function fnSave()
{
    var dt1=getDateObject(document.forms[0].eoatDate.value,"/");
	var dt2=getDateObject(document.forms[0].dateOfCompletion.value,"/");
	
	if(document.forms[0].circleOfficeCode.value=="")
	{
		alert("Please Select Circle");
	    return false;
	}else if(document.forms[0].divisionOfficeCode.value==""){
		alert("Please Select Division");
	    return false;
	}else if(document.forms[0].workCategory.value=="0"){
		alert("Please Select Work Category");
	    return false;
	}else if(document.forms[0].workId.value==""){
		alert("Please Select work Name");
	    return false;
	}else if(document.forms[0].programmeCode.value==""){
		alert("Please Select Programme ");
	    return false;
	}else if(document.forms[0].valueOfWorkDone.value==""){
		alert("Please Provide  Value Of Work Done ");
	    return false;
	}else if(document.forms[0].eoatOrderNo.value==""){
		alert("Please Provide EOAT order No ");
	    return false;
	}else if(document.forms[0].eoatDate.value==""){
		alert("Please Select EOAT Date");
	    return false;
	}else if(dt1< dt2)
	{
		alert(" EOAT Date Must be Greater than Sitpulated Date of Completion");
		document.forms[0].eoatDate.value="";
		return false;
	}
	else if(document.forms[0].costEsclationSought.value==""){
		alert("Please Provide  Cost Escalation Sought");
	    return false;
	}else if(document.forms[0].eoatPeriod.value==""){
		alert("Please Provide  EOAT Period");
	    return false;
	}else if(document.forms[0].officerResponsible1.value==""){
		alert("Please  Select officer Responsible1");
	    return false;
	}	else if(document.forms[0].preparedBy.value==""){
		alert("Please Select Prepared By");
	    return false;
	}else if(document.forms[0].preparedDate.value==""){
		alert("Please Select Prepared On");
	    return false;
	}else
	{
	document.forms[0].action="/pred/works/eoatFrm.do?mode=save";
	document.forms[0].submit();
	}
}

function autocompletion()
{

 for (i=0; i<document.forms.length; i++) {
    document.forms[i].setAttribute("AutoComplete","off");
   }
}
</script>
<body  onload="autocompletion()">
<html:form action="eoatFrm.do">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />


<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead>
<tr><td align="right"><b><small>Amount In Rs Lakhs</small></b></td></tr>
<tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="EOAT Entry Form" />
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
<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"  style="border-collapse:collapse;" width="100%" >	
	<tr>
		<td class="mycborder" colspan="2">
			<fieldset>
				<legend align="left">Office Details</legend>
				<label>
					<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"   width="100%" >	
  						<tr class="textborder">
					   		<td class="textborder">
			<bean:message key="app.circle" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode"   style="width:140px" onchange="javascript: fnSubmit('eoatFrm')" 
							 styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="mytext" style="width:140px"
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
					   		<td class="textborder"><bean:message key="app.division" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder">
		<logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:select property="divisionOfficeCode"  onchange="javascript: fnSubmit('eoatFrm')"
						 styleClass="combo">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:text property="divisionOfficeName" styleClass="mytext" style="width:140px"
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
		<td class="textborder">
		<bean:message key="app.subdivision" />
		</td>
		<td class="textborder">
		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subDivisionOfficeCode" styleClass="combo"  onchange="javascript: fnSubmit('eoatFrm')">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions">
			<html:options collection="subdivisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName" styleClass="mytext" style="width:140px"
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
					   	</tr>
					</table>
				</label>
			</fieldset>
		</td>
	</tr>
   
	<tr>
		<td class="mycborder" colspan="2">
			<fieldset>
				<legend align="left"> Work Details</legend>
				<label>
					<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"   width="100%" >	
                      
 <tr>
	   <td class="textborder" width="150">Work Category<font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		<html:select property="workCategory" styleClass="mycombo" style="width:150px" onchange="javascript:fnSubmit('eoatFrm') " >

		<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
		<html:option value="1"><font class="myfontclr1">PROJECTS</html:option>
		<html:option value="2"><font class="myfontclr1">NORMAL</html:option>
        <html:option value="3"><font class="myfontclr1">DISTRICT LEVEL</html:option> 
		
		</html:select>
		</td>
    
    
  						<tr class="textborder">
					   		<td width="150">
					   			Work Name<font color="#FF6666">*</font>
					   		</td>
					   		<td colspan="3">
					   			<html:hidden property="sno"/>
					   			<html:select  style="width:400" property="workId" styleClass="mycombo" onchange="fnSubmit('workIdChanged')">
									<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
									<logic:notEmpty name="workIdList">
										<html:options collection="workIdList" name="labelValueBean" property="value" labelProperty="label" />
									</logic:notEmpty>
								</html:select>
				    		</td>
				    		<td width="150">
					   			Programme <font color="#FF6666">*</font></td>
					   		</td>
				    		<td>
							
					   			<html:select  property="programmeCode" style="width:125" styleClass="mycombo">
								<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
									<logic:notEmpty name="programmesList">
										<html:options collection="programmesList" name="labelValueBean" property="value" labelProperty="label" />
									</logic:notEmpty>
								</html:select>
							</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150">
					   			Value Of WorkDone <font color="#FF6666">*</font>
					   		</td>
				    		<td>
					   			<html:text property="valueOfWorkDone"   
				    			   styleClass="mytext"  style="width:125" onkeyup="extractNumber2(this,10,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    		</td>
				    		<td width="150">
					   			Cost Of Work(in lakhs) <font color="#FF6666">*</font>
					   		</td>
				    		<td>
					   			<html:text property="costOfWork"   
				    			   styleClass="mytext"  style="width:70px" readonly="true" />
				    		</td>
				    		<td width="150">
					   			Value Of Work Beyond Agreement
					   		</td>
				    		<td>
					   			<html:text property="valueOfWorkBeyondAgreement"   
				    			   styleClass="mytext"  style="width:125" onkeyup="extractNumber2(this,10,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150">
					   			Value of Work to be done
					   		</td>
				    		<td>
					   			<html:text property="valueOfWorkToBeDone"   
				    			   styleClass="mytext"  style="width:125" onkeyup="extractNumber2(this,10,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    		</td>
				    		<td width="150">
					   			Sitpulated Date of completion
					   		</td>
				    		<td>
					   			<html:text property="dateOfCompletion"   
				    			   styleClass="mytext" maxlength="20" style="width:100" readonly="true"/>
				    			  
				    		</td>
					   	</tr>
					</table>
				</label>
			</fieldset>
		</td>
	</tr>
	<tr>
		<td class="mycborder" colspan="2">
			<fieldset>
				<legend align="left"> EOAT Details</legend>
				<label>
					<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"   width="100%" >	
  						<tr class="textborder">
					   		<td width="150">
					   			EOAT Order No<font color="#FF6666">*</font>
					   		</td>
					   		<td>
					   			<html:text property="eoatOrderNo"   
				    			   styleClass="mytext" maxlength="25" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    		<td width="150">
					   			EOAT Date<font color="#FF6666">*</font>
					   		</td>
					   		<td>
					   			<html:text property="eoatDate"   
				    			   styleClass="mytext" maxlength="20" style="width:100" readonly="true" />
				    			   <a href="javascript: showCalendar(document.forms[0].eoatDate);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" 
						  			width="20" border="0" height="17" align="center"></a>
				    		</td>
					   		<td width="150">
					   			Cost Escalation Sought<font color="#FF6666">*</font>
					   		</td>
					   		<td>
					   			<html:text property="costEsclationSought"   
				    			   styleClass="mytext" maxlength="20" style="width:125" onkeyup="extractNumber2(this,10,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);" />
				    		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150">
					   			EOAT Period&nbsp;(days) <font color="#FF6666">*</font>
					   		</td>
				    		<td>
					   			<html:text property="eoatPeriod"   
				    			   styleClass="mytext" maxlength="10" style="width:125" onkeypress="numeralsOnly()"/>
				    		</td>
				    		<td width="150">
					   			EOAT Old Ref No1
					   		</td>
				    		<td>
					   			<html:text property="eoatOldRefNo1"   
				    			   styleClass="mytext" maxlength="22" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    		<td width="150">
					   			EOAT Old Ref Date1
					   		</td>
				    		<td>
					   			<html:text property="eoatOldRefDate1"   
				    			   styleClass="mytext" maxlength="20" style="width:100" readonly="true"/>
				    			   <a href="javascript: showCalendar(document.forms[0].eoatOldRefDate1);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" 
						  			width="20" border="0" height="17" align="center"></a>
				    		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150">
					   			EOAT Old Ref No2
					   		</td>
				    		<td>
					   			<html:text property="eoatOldRefNo2"   
				    			   styleClass="mytext" maxlength="25" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    		<td width="150">
					   			EOAT Old Ref Date2
					   		</td>
				    		<td>
					   			<html:text property="eoatOldRefDate2"   
				    			   styleClass="mytext" maxlength="20" style="width:100" readonly="true"/>
				    			    <a href="javascript: showCalendar(document.forms[0].eoatOldRefDate2);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" 
						  			width="20" border="0" height="17" align="center"></a>
				    		</td>
					   	</tr>
					</table>
				</label>
			</fieldset>
		</td>
	</tr>
	<tr>
		<td class="mycborder" >
			<fieldset>
				<legend align="left">Details Of Fine</legend>
				<label>
					<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"   width="100%" >	
  						<tr class="textborder">
					   		<td width="150">
					   			Fine Imposed
					   		</td>
					   		<td width="150">
					   			<html:text property="fineImposed"   
				    			   styleClass="mytext" maxlength="20" style="width:125" onkeyup="extractNumber2(this,10,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    		</td>
				    		<td  rowspan=2 width="150">
					   			Reasons for not recovering fine
					   		<td rowspan=2 align="left" >
					   			<html:textarea property="reasonsForNotRecoveringFine"   
				    			     onkeyup="TrimTextArea(this,200)" style="width:300;height:48" onkeypress="upperOnly()"/>
				    		</td>
				    		</tr>
				    		<tr class="textborder">
				    		<td >
					   			Fine Recovered
					   		</td>
					   		<td >
					   			<html:text property="fineRecovered"   
				    			   styleClass="mytext" maxlength="20" style="width:125" onkeyup="extractNumber2(this,10,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    		</td>
				    	</tr>
				   </table>
				</label>
			</fieldset>
		</td>
	</tr>
	<tr>
		<td class="mycborder" >
			<fieldset>
				<legend align="left"> Officers Responsible</legend>
				<label>
					<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"   width="100%" >	
  					
				    	<tr class="textborder">
				    		<td width="150">
					   			Officer Responsible1&nbsp;<font color="#FF6666">*</font>
					   		</td>
				    		<td>
					   			<html:select  property="officerResponsible1" style="width:150" styleClass="mycombo">
								<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
								<logic:notEmpty name="officers">
								<html:options collection="officers" name="labelValueBean" property="value" labelProperty="label" />
								</logic:notEmpty>
								</html:select>
				    		</td>
				    		<td width="150">
					   			Officer Responsible2
					   		</td>
				    		<td>
					   			<html:text property="officerResponsible2"   
				    			   styleClass="mytext" maxlength="5" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    		<td width="150">
					   			Officer Responsible3
					   		</td>
				    		<td>
					   			<html:text property="officerResponsible3"   
				    			   styleClass="mytext" maxlength="5" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    	</tr>
			  		</table>
				</label>
			</fieldset>
		</td>
	</tr>
	<tr>
		<td class="mycborder" >
			<fieldset>
				<legend align="left"> Recommenditions</legend>
				<label>
					<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"   width="100%" >	
  						<tr class="textborder">
					   		<td width="150">
					   			AEE Recommend
					   		</td>
				    		<td width="305">
					   			<html:textarea property="aeeRecommend"   
				    			    onkeyup="TrimTextArea(this,100)"  style="width:305;height=35" onkeypress="upperOnly()"/>
				    		</td>
					   		<td width="150">
					   			DEE Recommend
					   		</td>
				    		<td width="305">
					   			<html:textarea property="deeRecommend"   
				    			   onkeyup="TrimTextArea(this,100)"  style="width:305;height=35" onkeypress="upperOnly()"/>
				    		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150">
					   			EE Recommend
					   		</td>
					   		<td width="305">
					   			<html:textarea property="eeRecommend"   
				    			     onkeyup="TrimTextArea(this,100)"  style="width:305;height=35" onkeypress="upperOnly()"/>
				    		</td>
				    		<td width="150">
					   			SE Recommend
					   		</td>
				    		<td width="305">
					   			<html:textarea property="seRecommend"   
				    			    onkeyup="TrimTextArea(this,100)"  style="width:305;height=35" onkeypress="upperOnly()"/>
				    		</td>
				    	</tr>
				    	<tr class="textborder">
					   		<td width="150">
					   			CE Recommend
					   		</td>
					   		<td width="305">
					   			<html:textarea property="ceRecommend"   
				    			   onkeyup="TrimTextArea(this,100)"  style="width:305;height=35" onkeypress="upperOnly()"/>
				    		</td>
				    		
			            </tr>
				   </table>
				</label>
			</fieldset>
		</td>
	</tr>
	<tr>
		<td class="mycborder" colspan="2">
			<fieldset>
				<legend align="left"> Other Details</legend>
				<label>
					<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"   width="100%" >	
  					
				
				    	<tr class="textborder">
				    		<td width="150">
					   			Exemption Recommended by SE
					   		</td>
				    		<td>
					   			<html:text property="exemptRecommendedBySE"   
				    			   maxlength="100" styleClass="mytext" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    		<td width="150">
					   			Total Days Exempted by SE
					   		</td>
				    		<td>
					   			<html:text property="totalDaysExemptBySe"   
				    			   maxlength="100" styleClass="mytext"  style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    		<td width="150">
					   			Rate of penalty
					   		</td>
				    		<td>
					   			<html:text property="rateOfPenalty"   
				    			   styleClass="mytext"  style="width:125" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    		</td>
					   	</tr>
					   	<tr class="textborder">
				    		<td width="150">
					   			Total penalty
					   		</td>
				    		<td>
					   			<html:text property="totalPenalty"   
				    			   styleClass="mytext"  style="width:125" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    		</td>
				    		<td width="150">
					   			Reasons by contractor
					   		</td>
				    		<td>
					   			<html:text property="reasonsByContractor"   
				    			   maxlength="200" styleClass="mytext"  style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    		<td width="150">
					   			Contractor Rep made Upd
					   		</td>
				    		<td>
					   			
					   			<html:text property="contractorRepMadeUpd"   
				    			   styleClass="mytext" maxlength="1" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
					   	</tr>
					<tr class="textborder">
				    		<td width="150">
					   			Agreement copy penalty upd
					   		</td>
				    		<td>
					   			<html:text property="agreementCopyPenaltyUpd"   
				    			   styleClass="mytext" maxlength="1" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    		<td width="150">
					   			Supp document for exemption upd
					   		</td>
				    		<td>
					   			<html:text property="suppDocumentForExempUpd"   
				    			   styleClass="mytext" maxlength="1" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    		
				    		<td width="150">
					   			EOAT Grant Authority
					   		</td>
				    		<td>
					   			<html:text property="eoatGrantAuthority"   
				    			   styleClass="mytext" maxlength="100" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150">
					   			Supplimentary Agreement No
					   		</td>
				    		<td>
					   			<html:text property="suppAgreeNo"   
				    			   styleClass="mytext" maxlength="25" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
					   		<td width="150">
					   			Supplimentary Agreement Date
					   		</td>
				    		<td>
					   			<html:text property="suppAgreeDt"   
				    			   styleClass="mytext" maxlength="20" style="width:100" readonly="true"/>
				    			   <a href="javascript: showCalendar(document.forms[0].suppAgreeDt);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" 
						  			width="20" border="0" height="17" align="center"></a>
				    		</td>
				    		<td width="150">
					   			Prepared By <font color="#FF6666">*</font>
					   		</td>
				    		<td>
					   			<html:text property="preparedBy"   
				    			   styleClass="mytext" maxlength="20" style="width:125" onkeypress="upperOnly()"/>
				    		</td>
				    	</tr>
				    	<tr class="textborder">
				    		<td width="150">
					   			Prepared On <font color="#FF6666">*</font>
					   		</td>
				    		<td>
					   			<html:text property="preparedDate"   
				    			   styleClass="mytext" maxlength="20" style="width:100" readonly="true"/>
				    			   <a href="javascript: showCalendar(document.forms[0].preparedDate);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" 
						  			width="20" border="0" height="17" align="center"></a>
				    		</td>
					   	</tr>
					</table>
				</label>
			</fieldset>
		</td>
	</tr> 
	<tr class="textborder">
	<td colspan="15" align="center">
	<input type="button" class="btext" value="Save" onclick="fnSave()">&nbsp;
	<input type="button" class="btext" value="View" onclick="fnview()">
	</td>
	</tr>
</table>

<!--  end of form fields -->
</td>
</tr>
</tbody>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>