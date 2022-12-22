<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>

<html:javascript formName="tenderAppForm"/>


<SCRIPT LANGUAGE="JavaScript">
function focusto()
{
document.tenderAppForm.tenderIdNo.focus();
}
function save()
{
document.forms[0].action="/pred/contractor/TenderApplication.do?mode=save";
document.forms[0].submit();
}
function viewfun()
{
alert("view");
document.forms[0].action="/pred/contractor/TenderApplication.do?mode=view";
document.forms[0].submit();

}
function addres1clear()
{
 if(document.getElementById('hid1').value=='enter')
 {

 document.getElementById('contractorAdd1').value='';
 document.getElementById('hid1').value='';
 }
}
function addres2clear()
{
 if(document.getElementById('hid2').value=='enter')
 {

 document.getElementById('contractorAdd2').value='';
 document.getElementById('hid2').value='';
 }
}
function addres3clear()
{
 if(document.getElementById('hid3').value=='enter')
 {

 document.getElementById('contractorAdd3').value='';
 document.getElementById('hid3').value='';
 }
}
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>
<body onload="focusto()">
<html:form  action="TenderApplication.do?mode=data" enctype="multipart/form-data" onsubmit="return validateTenderAppForm(this)">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Tender Application" />
	<jsp:param name="TWidth" value="750" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	   width="780" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B>Office Details</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="0" width="780" 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr>
			<logic:present name="RWS_USER" property="headOfficeName">
				<td class="textborder">Head&nbsp;Office&nbsp;:</td>
				<td class="textborder">
				<html:text property="headOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext" style="width:100px"/>
				<html:hidden property="headOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			<logic:present name="RWS_USER" property="circleOfficeName">
				<td class="textborder">Circle&nbsp;:</td>
				<td class="textborder">
				<html:text property="circleOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext" style="width:100px"/>
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			<logic:present name="RWS_USER" property="divisionOfficeName">
				<td class="textborder">Division&nbsp;:</td>
				<td class="textborder">
				<html:text property="divisionOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext"  style="width:100px"/>
				<html:hidden property="divisionOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			<logic:present name="RWS_USER" property="subdivisionOfficeName">
				<td class="textborder">Subdivision&nbsp;:</td>
				<td class="textborder">
				<html:text property="subdivisionOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext" style="width:100px"/>
				<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			</tr>
		</table>
		</label>
		</fieldset>
		
		<fieldset>
		<legend>
					<B>Application Details</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="0" 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse" width="780">
			   <tr >
			   <td class="textborder">Tender Id Number <font color="#FF6666">*</font>&nbsp;:&nbsp;</td>
			    <td>	
			    <html:select property="tenderIdNo" styleClass="mycombo" style="width:145px">
				<html:option value="">SELECT...</html:option>
				<html:options collection="tenderId" name="tenderIds" 
								  property="tenderIdNo" labelProperty="tenderIdNo"/>
				</html:select>  
		       </td>
			   <td class="textborder">Tender Application Number<font color="#FF6666">*</font>&nbsp;:&nbsp;</td>	   
		       <td><html:text  maxlength="4"property="tenderApplNo"/></td>
	           </tr>	 
	           <tr >
			   <td class="textborder">Contractor Reg Number<font color="#FF6666">*</font>&nbsp;:&nbsp;</td>	   
		       <td><html:text maxlength="10"property="contractorRegNo"/></td>
			   <td class="textborder">Cheque Number<font color="#FF6666">*</font>&nbsp;:&nbsp;</td>	   
		       <td><html:text maxlength="10"property="chequeNo"/></td>
		       </tr>	 
	           <tr >
			   <td class="textborder">Cheque Date<font color="#FF6666">*</font>&nbsp;:&nbsp;</td>	   
		       <td><html:text property="chequeDate"/> 
		       <a href="javascript:showCalendar(document.tenderAppForm.chequeDate);">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
			   </td>
		       
			   <td class="textborder">Bank Name<font color="#FF6666">*</font>&nbsp;:&nbsp;</td>	   
		       <td><html:text maxlength="20" property="bank"/></td>
		       </tr>	 
	           <tr >
		        <td class="textborder">Branch<font color="#FF6666">*</font>&nbsp;:&nbsp;</td>	   
		       <td><html:text maxlength="30" property="branch"/></td>
			   <td class="textborder">Contractor Name <font color="#FF6666">*</font>&nbsp;:&nbsp;</td>	   
		       <td><html:text  maxlength="30" property="contractorName"/></td>
		       </tr>	 
	           <tr >
		       <td class="textborder">Tender Amount <font color="#FF6666">*</font>&nbsp;:&nbsp;</td>	   
		       <td><html:text maxlength="10" property="tenderAmount"/></td>
			   <td class="textborder">Contractor Address<font color="#FF6666">*</font>&nbsp;:&nbsp;</td>	   
		       <td><html:text maxlength="20" property="contractorAdd1" onfocus="addres1clear()" /></td>
			        <input type="hidden" name="hid1" value="enter" />
			   </tr>	 
	           <tr>
	           <td></td><td></td><td></td>
		       <td><html:text   maxlength="20" property="contractorAdd2" onfocus="addres2clear()" /></td>
		             <input type="hidden" name="hid2" value="enter"/>
		        </tr>
		        <tr>    
		         <td></td><td></td><td></td> 
		       <td><html:text  maxlength="20" property="contractorAdd3" onfocus="addres3clear()" /></td>
		        <input type="hidden" name="hid3" value="enter"/>
		            
	           </tr>	
	           
	                      
	   </table>
	   </label>
	   </fieldset>
	   	   <tr>
		    <td align="center">
			<html:submit property="mode" title="Save the Fields"  
						 styleClass="btext" value="Save" onclick="save()" />
			<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
			<html:button property="mode" title="View Details" styleClass="btext" value="View" onclick="viewfun()"/>						 
				 
	    	<bean:define id="userId" name="RWS_USER" property="userId" />
			<html:hidden property="preparedBy" value="<%=(String)userId%>"/>
			<html:hidden property="preparedOn" 
						 value="<%=sdf.format(new java.util.Date())%>"/>
		    </td>
	    </tr>
</table>
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="750"/>
</jsp:include>

</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
