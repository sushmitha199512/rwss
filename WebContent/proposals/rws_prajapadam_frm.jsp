  <%@ include file="/commons/rws_prajapatham_header1.jsp" %>
 
  <SCRIPT LANGUAGE="JavaScript">
   
 function addNewProg()
 {
 var url="switch.do?prefix=/proposals&page=/prajapadam.do?mode=viewAddProgPage";
 window.open(url,'',"top=200,left=300,height=200,width=600,location=0,scrollbars=1,directories=0,resizable=0"); 
 } 
 function addNewSubProg()
 {
  var url="switch.do?prefix=/masters&page=/SubProgramme.do&mode=data";
  window.open(url,'',"top=200,left=300,height=200,width=600,location=0,scrollbars=1,directories=0,resizable=0"); 
  }  
 function getMandals()
 {
 var dist=document.getElementById('districtCode').value;
 
 document.forms[0].action="switch.do?prefix=/proposals&page=/prajapadam.do?mode=man";
 document.forms[0].submit();
 
 }
 
 function getSubPrograms()
 {
   document.forms[0].action="switch.do?prefix=/proposals&page=/prajapadam.do?mode=prog";
 document.forms[0].submit();
 }
 function getHabs()
 {
  document.forms[0].action="switch.do?prefix=/proposals&page=/prajapadam.do?mode=habs";
  document.forms[0].submit();
 }
 function getCons()
 {
 document.forms[0].action="switch.do?prefix=/proposals&page=/prajapadam.do?mode=cons";
  document.forms[0].submit();
 }
 function hideTxtBx()
 {
document.forms[0].sanctionAt[1].checked=true;
var value= document.getElementById('others').checked;
 
if(value==true)
{ 
  document.getElementById('hideMe').style.display='inline'; 
 }
 if(value==false)
{
 document.getElementById('othersValue').value='';
 document.getElementById('hideMe').style.display='none';
}
}
function  saveFrm()
{
document.forms[0].action="switch.do?prefix=/proposals&page=/prajapadam.do?mode=save";
}
function getViewDetails()
{
var dist=document.getElementById('districtCode').value;
 
var man=document.getElementById('mandalCode').value;
var hab=document.getElementById('habCode').value;
if(dist!=''&& man!='')
{
document.forms[0].action="switch.do?prefix=/proposals&page=/prajapadam.do?mode=view";
document.forms[0].submit();
}
var message='';
if(dist=='')
{
  message=message+"District";
}
  if(man=='')
  {
   message=message+"-Mandal";
  }
    
  
 
if(message!='')
{
alert(" select "+message);
}
}
</SCRIPT>
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
 
<html:javascript formName="Prajapadam"/>
<%@ include file="/commons/rws_prajapatham_header2.jsp" %>
<body  onload="hideTxtBx()">
<html:form  action="prajapadam.do?mode=data" enctype="multipart/form-data" onsubmit="return validatePrajapadam(this)"  >
<jsp:include page="/commons/rws_praja_tableHeader.jsp">
	<jsp:param name="TableName" value="Prajapatham Works Monitoring 2007" />
	<jsp:param name="TWidth" value="730" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	   width="760" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B>Office Details</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="0" width="760" 
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
		   </td>
		   </tr>
	 	<tr>
		  <td class="bwborder" >
		      <fieldset>
		<legend  >
				<B>Prajapatham Details</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="0" width="760 " 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
		<tr>
		 <td>	   
			<tr class="mycombo"> 
			<td class="textborder">District:</td>
			<logic:notPresent name="RWS_USER" property="circleOfficeName">
			<td class="textborder">
			           <html:select property="districtCode" styleClass="combo"
									 onchange="javascript: getMandals()">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="districts" name="labelValueBean"
										  property="districtCode" labelProperty="districtName" />
						</html:select>
			</td>
			</logic:notPresent>
			<logic:present name="RWS_USER" property="circleOfficeName">
			<td><html:hidden property="districtCode"/>
			<html:text property="circleOfficeName" name="RWS_USER"  
						   readonly="true"    />
		    </td>
		    </logic:present>
			<td class="textborder">Mandal:</td>
			<td >      <html:select property="mandalCode" styleClass="combo"
									 onchange="javascript: getHabs()">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="mandals">
							<html:options collection="mandals" name="labelValueBean"
										  property="mandalCode" labelProperty="mandalName" />
					    </logic:present>					  
						</html:select></td>
			<td class="textborder">Habitation :</td>
			<td ><html:select property="habCode" styleClass="combo"
									 onchange="javascript: getCons()">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="Habitations">
							<html:options collection="Habitations" name="labelValueBean"
										  property="habCode" labelProperty="habName" />
					    </logic:present>					  
						</html:select></td>
			</tr>
			<tr>
		 	<td class="textborder">Constituency Name:</td>
			<td ><html:text property="conCode" readonly="true"/></td>
			<td class="textborder" >Status As On &nbsp;&nbsp;&nbsp;&nbsp;:<font size=0>(1-4-2006)</font></td>
			<td ><html:text property="statusAsOn" readonly="true"/></td>
			 
			</tr>
		  </td>
		</tr>
		</table>
		</label>
		</fieldset>
		</td>
		</tr> 
		
		<tr>
		  <td class="bwborder" >
		 <fieldset>
		<legend  >
				<B>Existing Water Facilities </B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="0" width="760 " 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
		<tr>
		 <td class="textborder"  colspan=8><html:checkbox property="cpws"/> 
			 CPWS 
			 <html:checkbox property="pws"/> 
			 PWS 
			  <html:checkbox property="directPump"/> 
			 Direct Pumping 
			 <html:checkbox property="boreWells"/> 
			 Bore Wells 
	 		 <html:checkbox property="others" onclick="hideTxtBx()"/> 
			 Others &nbsp; 
			  <td class="textborder" id="hideMe"> if  Others Specify <html:text property="othersValue" maxlength="30"size="30"/>  </td>
		  </td>
		 </tr>
		 </table>
		 </label>
		 </fieldset>
		 </td>
		 </tr>
		 
		 <tr>
		  <td class="bwborder" >
		      <fieldset>
		<legend  >
				<B>Work  Details</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="0" width="760 " 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
		<tr>
		 <td>
		 
		  <tr class="textborder" >
		 	<td  >Name of the Work :</td>
			<td> <html:text property="workName" maxlength="50" size="93"/> </td>
		  </tr>
		 </table> 
		 <table cellpadding="0" cellspacing="0" border="0" width="760 " 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	     <tr class="textborder">		
			<td >Estiamted Cost :<br><font color="#990000"   size=1>(Rs.in Lakhs)</font></br></td>
			 <td class="textborder"><html:text property="estCost"/>  
			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Asset Type: 
			<td> <html:select property="typeOfAssetCode" styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="TypeOFAsset">
							<html:options collection="TypeOFAsset" name="labelValueBean"
										  property="value" labelProperty="label" />
					    </logic:present>					  
	 					</html:select></td>
	 	 </tr> 
	 	 <tr class="textborder">
		    <td >Programme :</td>
			<td> 
			           <html:select property="programme" styleClass="combo"
									 onchange="javascript: getSubPrograms()">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="programs" name="labelValueBean"
										  property="value" labelProperty="label" />
						</html:select> <html:button property="mode" styleClass="btext" value="..." onclick="addNewProg()"/> 
	  		    &nbsp;&nbsp;&nbsp; Sub Programme : 
			<td>    <html:select property="subProgramme" styleClass="combo">
						<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="subPrograms">
							<html:options collection="subPrograms" name="labelValueBean"
										  property="value" labelProperty="label" />
						</logic:present>
						</html:select> <html:button property="mode" styleClass="btext" value="..." onclick="addNewSubProg()"/></td>
	 	 </table>
		
		 <fieldset>
		 <legend>
				<B> Sanctioning Authority </B>
		</legend>
		<label>
		<table>
	 	 <tr class="textborder">
		 <td> <html:radio property="sanctionAt" value="S"  title="Select to sanction at state" onclick="getRad()"/>State</td>
		 <td> <html:radio property="sanctionAt" value="D"  title="Select to sanction at district"/>District</td>
		</tr>
		</tr>
		     <tr class="textborder">
	 	 	    <td >Admin Sanction Reference No.  : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td> <html:text property="adminSancRefNo"/></td>  
	     
			 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Admin Sanction Date : </td>
			<td> <html:text property="adminSancDate"   /><a href="javascript:showCalendar(document.forms[0].adminSancDate);">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
			   </td>
		</tr>
		</table>
		</label>
		</fieldset> 
		
     	<table>
		 <tr class="textborder">
		     <td >Date Of Grounding:</td>
			<td> <html:text property="dateOfGrounding"  /><a href="javascript:showCalendar(document.forms[0].dateOfGrounding);">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
			  
	 		 &nbsp;&nbsp;&nbsp;&nbsp;  Date Of Completion : 
			<td> <html:text property="dateOfComple"  />
			 <a href="javascript:showCalendar(document.forms[0].dateOfComple);">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
			  </td>
	    </tr>
	    <tr class="textborder"  >
		     <td >Expenditure Up To Previous Month :<br><font color="#990000"size=1>(Rs.in Lakhs)</font></br></td>
			 <td> <html:text property="expendetureUpTotheMonth"  /> </td>
		</tr>
		 <tr class="textborder">
		     <td >Expenditure During The Month:<br><font color="#990000" size=1>(Rs.in Lakhs)</font></br></td>
			 <td> <html:text property="expendetureDuringMon"  /> 
			  
			  </td>
		</tr>
		<tr class="textborder">  
			 <td> Value Of Work Done But Not Paid:<br><font color="#990000" size=1>(Rs.in Lakhs)</font></br></td>
			 <td > <html:text property="expendetureToBeIncurred"    /> </td>
		</tr> 
		
		<tr class="textborder">
	  	     <td >Physical Stage  of work :</td>
			 <td class="textborder"> <html:select  property="physycalStageOFWork" style="width:100px" styleClass="combo" >
			      <html:option value="STARTED">SELECT..</html:option>
			      <html:option value="STARTED">STARTED</html:option>
			      <html:option value="NOT">NOT STARTED</html:option>
			      <html:option value="PROGRESS">PROGRESS</html:option>
			      <html:option value="COMPLETED">COMPLETED</html:option>
			 </html:select>
			  </td>
		</tr>
		<tr class="textborder" colspan=2>
		     <td >Remarks :</td>
			<td colspan=2> <html:text property="remarks" maxlength="100" size="75"/> </td>
	 	 </tr>
		 </td>
		</tr>
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		<tr>
		<td align="center">
		<html:submit property="mode" styleClass="btext" onclick="saveFrm()">Save</html:submit>
		<html:reset   styleClass="btext">Reset</html:reset>
	    <html:button property="mode" styleClass="btext" onclick="getViewDetails()">View</html:button>
		</td>
		</tr>
		 
		
 </table>		
<jsp:include page="/commons/TableFotter.jsp">
		
<jsp:param name="TWidth" value="730"/>
</jsp:include>

</html:form><!-- -->
</body>
<%java.util.Date d=new java.util.Date();
		java.text.SimpleDateFormat format=new java.text.SimpleDateFormat("dd/MM/yyyy"); 
		String currentDate=format.format(d);%>
		<input type="hidden"  name="cDate"    value='<%=currentDate%>'/>
		<script>
		function saveFrm()
		{   
		          var date=document.getElementById('adminSancDate').value;
				  var toDate=document.getElementById('cDate').value;
			 	  
				  date=date.split('/');
				  toDate=toDate.split('/');
				   
				 
				  var from=new Date(date[2],date[1]-1,date[0] );
				  var to=new Date(toDate[2],toDate[1]-1,toDate[0] );
			 	    
				   if(to>=from )
				   {
				         
	                    document.forms[0].action="switch.do?prefix=/proposals&page=/prajapadam.do?mode=save"; 
	                    document.forms[0].submit();
	                }
	                 else
	                {
	                 alert("Admin snaction date must be less  than or equals to Today's Date");
	                }
	 	}
	    </script>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%> 
