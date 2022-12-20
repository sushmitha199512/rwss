<%@ include file="/commons/rws_header1.jsp" %>

 
<SCRIPT LANGUAGE="JavaScript">
function chkAll() 
{
 	 for(i=0; i<document.forms[0].elements.length; i++)
	{ 
		 if (document.forms[0].elements[i].type == "checkbox")
		 {
		  document.forms[0].elements[i].checked = true;
		 }
	 }
	 
}
function uncheck()
	{ 
		 for(i=0; i<document.forms[0].elements.length; i++)
			{ 
				 if (document.forms[0].elements[i].type == "checkbox")
				 {
				  document.forms[0].elements[i].checked = false;
				 }
			 }
	}
  
function calme()
{
document.forms[0].submit();
}
function unview()
{
	var status=document.getElementById('districtCode').value;
	var date=document.getElementById('statusDate').value;
	if((status=='')||(date==''))
	{
	 	document.getElementById('s1').disabled=true;
	}
}
function getMandals()
{
document.forms[0].action="/pred/reports/LocationStatus.do";
document.forms[0].submit();
}
function getpanchayats()
{
document.forms[0].action="/pred/reports/LocationStatus.do";
document.forms[0].submit();
}
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>
<body onload="unview()">
<html:form  action="LocationStatus.do?mode=data" enctype="multipart/form-data" >
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Location Status Report" />
	<jsp:param name="TWidth" value="750" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	   width="769" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend>
					<B></B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="1" 
			   bordercolor= "white" style="border-collapse:collapse" width="383">
			   <tr height="51" width="40">
			    
			    <td class="textborder"  >Districts  <font color="#FF6666">*</font>&nbsp;:&nbsp; 
			    <td >
			    <html:select property="districtCode" styleClass="mycombo" style="width:145px"onchange="getMandals()">
				<html:option value="">SELECT...</html:option>
				<html:option value="00">ALL</html:option>
				<html:options collection="CirclesList" name="CirclesList" 
								  property="circleCode" labelProperty="circleName"/>
			    </html:select>
			    </td> 
			    </td>
			    </tr>
			    <tr height="51" width="40">
			     <td class="textborder">Mandals<font color="#FF6666">&nbsp;&nbsp;&nbsp;</font>&nbsp;:&nbsp; 
			    <td>
			    <html:select property="mandalCode" styleClass="mycombo" style="width:145px" onchange="getpanchayats()">
				<html:option value="">SELECT...</html:option>
				<html:options collection="mandals" name="mandals" 
								  property="mandalCode" labelProperty="mandalName"/>
			    </html:select> 
			    </td>
			    </td>
			    </tr>
			    <tr height="51" width="40">
			     <td class="textborder">Panchayats<font color="#FF6666"></font>&nbsp;:&nbsp; 
			    <td>
			    <html:select property="panchayatCode" styleClass="mycombo" style="width:145px">
				<html:option value="">SELECT...</html:option>
				<html:options collection="panchayats" name="panchayats" 
							  property="panchayatCode" labelProperty="panchayatName"/>
			    </html:select> 
			    </td>
			    </td>
			    </tr>
			    <tr height="51" width="40">
			    <td class="textborder">Status Date <font color="#FF6666">*</font>&nbsp;:&nbsp; 
			    <td>
			    <html:select property="statusDate" styleClass="mycombo" style="width:145px" onchange="calme()">
				<html:option value="" >SELECT...</html:option>
				<html:options collection="statusDates" name="statusDates" 
								  property="statusDate" labelProperty="statusDate"/>
			    </html:select> 
			    </td>
			    </td>
			    </tr>
		 </table>
	   </label>
	   </fieldset>
	   </td>
	   
	   <td class="bwborder" >
		<fieldset>
		<legend>
					<B>Habitation Details</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="1" 
			   bordercolor= "white" style="border-collapse:collapse" width="389">
			   <tr >
			     <td align="center"><html:checkbox property="coverageStaus" disabled="true"  /></td> 
			     <td class="textborder">Coverage Status</td>
			   </tr>
			   
			   <logic:iterate name="HabDetails" id="habDet">
			   <tr >
			    <td align="center">
				   <html:multibox property="habDetails">
	               <bean:write name="habDet"/>
	               </html:multibox>
                </td>
               <td class="textborder"><bean:write name="habDet"/></td>
               </tr>
			   </logic:iterate>
			   <tr>  
			   <td class="textborder" colspan="2" ><a href="#1"onClick="chkAll()">Check All</a>
			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			    <a href="#1" onclick="uncheck()">Clear All</a> </td>
			    </tr>
		    </table>
	   </label>
	   </fieldset>
	   </td>
	   </tr>
	   </table>
	   
	   <table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	   width="769" border=1 style="border-collapse:collapse;" >
	    <tr>
		<td class="bwborder" >
		<fieldset>
		<legend>
					<B></B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="0" 
			   bordercolor= "white" style="border-collapse:collapse" width="780">
			   <tr >
			    <td align="center" colspan="2">
			    <html:submit property="s1" value="View Report" />
			    </td>
			   </tr>
		    </table>
	   </label>
	   </fieldset>
	   </td>
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
