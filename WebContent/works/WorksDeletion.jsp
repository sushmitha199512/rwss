<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_admin_authorization_struts.jsp"%>
<%int count = 1;
	nic.watersoft.commons.RwsUser rwsusers=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String rwsuserid = users.getUserId();

String md=request.getParameter("mode");
String md1=request.getParameter("mode1");


%>
<head>

<script>

function getDivisions()
	{
	 
	  document.forms[0].action="switch.do?prefix=/works&page=/worksDelete.do&mode=data&mode1=Divisions";
	  monitoringForm.submit();
	}
function getWorkcategory()
	{
	  document.forms[0].action="switch.do?prefix=/works&page=/worksDelete.do&mode=data&mode1=workcategory";
	  monitoringForm.submit();
	}
function getSubDivisions()
	{
	
		document.forms[0].action="switch.do?prefix=/works&page=/worksDelete.do&mode=data";
		monitoringForm.submit();
	}
function getProgramme()
{

	document.forms[0].action="switch.do?prefix=/works&page=/worksDelete.do&mode=data&mode1=programmes";
	monitoringForm.submit();
	
}
function getSubProgramme()
{
	
	document.forms[0].action="switch.do?prefix=/works&page=/worksDelete.do&mode=data&mode1=subprogrammes";
	monitoringForm.submit();
	
}
function getWorks1()
{
	
	document.forms[0].action="switch.do?prefix=/works&page=/worksDelete.do&mode=data&mode1=getworks";
	monitoringForm.submit();
	
}

function getCancelWorks()
{
     	    
	  if(document.forms[0].circleCode.value==''){
	  alert("Please Select Circle Code");
		return false;
      }
	  else if(document.forms[0].cmbDivision.value==''){
	  alert("Please Select Division Code");
		return false;
      }
	 else if(document.forms[0].workCat.value==''){
	  alert("Please Select WorkCategory ");
		return false;
      } else if(document.forms[0].plan[0].checked==false && document.forms[0].plan[1].checked==false){
	  alert("Please Check Plan / Non Plan ");
		return false;
   	  } 
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/worksDelete.do&mode=data&mode1=getCancelWorks";
		document.forms[0].submit();		
		}

}

function getWorks()
	{
	   
	   	    
	  if(document.forms[0].circleCode.value==''){
	  alert("Please Select Circle Code");
		return false;
	  }
	  else if(document.forms[0].cmbDivision.value==''){
	  alert("Please Select Division Code");
		return false;
	  }
	 else if(document.forms[0].workCat.value==''){
	  alert("Please Select WorkCategory ");
		return false;
	  } else if(document.forms[0].plan[0].checked==false && document.forms[0].plan[1].checked==false){
	  alert("Please Check Plan / Non Plan ");
		return false;
	  } 
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/worksDelete.do&mode=data&mode1=getWorks";
		document.forms[0].submit();		
		}
	}
function fnchkdelete(){

     var len=document.monitoringForm.elements.length;
	
      var yes=0;
      
      for( var i=1;i<len;i++)
	  {       
        if(document.monitoringForm.elements[i].name.substring(0,5)=="check")
         
			if(document.monitoringForm.elements[i].checked == false)
		    { 
		       yes=1; 
		      
		     }
		    else if(document.monitoringForm.elements[i].checked==true)
		        { 
		      
		        yes=0;
		        break; 
		        }
		 
      }

	  if(yes==1)
	   {
		 alert("TO lete WORKS SELECT CHECK BOXES");
		
       }
	  else if(yes==0){
	
		  var val=confirm("Are You Sure To lete The Checked Work(S)");
		  if(val){
		  document.forms[0].action="switch.do?prefix=/works&page=/worksDelete.do&mode=data&mode1=DeleteWorks";
          document.forms[0].submit();
	}
          
}
}
function checkMe()
 {
    
 if(document.forms[0].plan[0].checked)
 {
	
 }
 else if(document.forms[0].plan[1].checked)
 {
 }
 else
 {
 document.forms[0].plan[0].checked=true;
 document.forms[0].wrktype[0].checked=true;
 }
 }
 function fnShowHabs(workid)
{
	var workId=workid.name;
	var url = "switch.do?prefix=/works&page=/worksDelete.do&mode=showHabs&workID="+workId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
</script>
</head>

<html:form action="worksDelete.do">
<body onload="checkMe()">
<table width="100%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Works For Deletion" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Office Details</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2" border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tbody class="formTBody">
	  
		<tr class="textborder">	
   <%String cirfi=(String)session.getAttribute("fixcircle");
	  String usercode=RWS_USER.getCircleOfficeCode();
      String username=RWS_USER.getCircleOfficeName();
      String divusercode=RWS_USER.getDivisionOfficeCode();
      String divusername=RWS_USER.getDivisionOfficeName();
      String subusercode=RWS_USER.getSubdivisionOfficeCode();
      java.util.Date systemdate= new java.util.Date(System.currentTimeMillis());
	
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
	    String transdate=null;
	  transdate=dateFormat.format(systemdate);
	  
 		
		%>
	    
	<logic:present name="circles">
		 	<logic:notPresent name="fixcircle">
				<td class="textborder" >Circle<span class="mandatory">*</span></td>
				<td class="textborder">
		        <html:select property="circleCode" style="width:143px" styleClass="mycombo" onchange="javascript:getDivisions();" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="circles"   property="value" labelProperty="label" />
	             </html:select>
				</td>
			</logic:notPresent>
		    <logic:present name="fixcircle">
		    
			<td class="textborder">Circle<span class="mandatory">*</span></td>
				 <logic:present name="RWS_USER" property="circleOfficeName">
				 <html:hidden property="circleCode"/>
			 	<td class="textborder">
				<html:text property="circleOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext" style="width:100px"/>
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			</logic:present>
			</logic:present>
			<%if(divusercode.equals("0")){%>
		  <td ><bean:message key="app.division" /><span class="mandatory">*</span></td>
		   <td ><html:select property="cmbDivision" style="width:183px" styleClass="mycombo" onchange="Javascript:getWorkcategory();" >
			<html:option value="">Select...</html:option>
			<logic:present name="divisions"> 
			<html:options collection="divisions" name="division" property="value" labelProperty="label" />
			</logic:present>
      
			</html:select>

		</td>
          <%} else{%>
		  <td ><bean:message key="app.division" /><span class="mandatory">*</span></td>
		   <td ><html:select property="cmbDivision" style="width:183px" styleClass="mycombo" onchange="Javascript:getWorkcategory();" >
		   <html:option value='<%=divusercode%>'><%=divusername%></html:option>
           </html:select>
          <%} %>

		 <tr>
		<td class="textborder" colspan="4" nowrap>
		<html:radio property="plan" value="1" onclick="checkMe();getProgramme();"/>Plan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:radio property="plan" value="2" onclick="checkMe();getProgramme();"/>Non Plan
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <html:radio property="wrktype" value="1" onclick="JavaScript:getProgramme();">MainScheme</html:radio>
        <html:radio property="wrktype" value="2" onclick="JavaScript:getProgramme();">Augmentation</html:radio>
        <html:radio property="wrktype" value="3" onclick="JavaScript:getProgramme();">Maintenance</html:radio>
		</td>
		<td class="textborder" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Work Category<span class="mandatory">*</span></td>
		<td>
		<html:select property="workCat" style="width:143px" styleClass="mycombo" onchange="getProgramme();">
		<html:option value="">Select...</html:option>
		<logic:present name="workCategory">
		<html:options collection="workCategory" property="value" labelProperty="label"/> 
		</logic:present>
		</html:select>
		</td>
		</tr>
	
	<tr>
	<td>Programme</td>
        <td>
		     <html:select property="program" style="width:183px" styleClass="mycombo" onchange="JavaScript:getSubProgramme();">
			<html:option value="">Select...</html:option>
			<logic:present name="programmes"> 
			<html:options collection="programmes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td>
	    <td>SubProgramme</td>
        <td>
		     <html:select property="subprogram" style="width:183px" styleClass="mycombo" onchange="JavaScript:getWorks1();">
			<html:option value="">Select...</html:option>
			<logic:present name="subprogrammes"> 
			<html:options collection="subprogrammes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td>
	  <%if(!subusercode.equals("00")){ %>
			<td  ><input type=submit name=GetData value=GetRegularWorks onClick="return getWorks();" disabled></td> 
			<td  ><input type=submit name=GetData value=GetCancelWorks onClick="return getCancelWorks();" disabled ></td> 
			<%} else if(subusercode.equals("00")){%>
			<td  ><input type=submit name=GetData value=GetRegularWorks  onClick="return getWorks();" ></td> 
			<td  ><input type=submit name=GetData value=GetCancelWorks onClick="return getCancelWorks();" ></td> 
			<%} %>
		
	 </tr>
		</table>
		</label>
		</fieldset>
				
				</td>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="10"><B><font color="#FFFFFF">Works For Deletion</B></td>
<td align="center">
</td>
</tr>
<tr >
	<td class="clrborder" align="center">S.No.</td>
	<td class="clrborder" align="center">Work Name</td>	  
	<td class="clrborder" align="center">Work ID</td>
	<td class="clrborder" align="center">Program Name</td>
	<td class="clrborder" align="center">SubProgram Name</td>
	<td class="clrborder" align="center">Sanction No</td>
	<td class="clrborder" align="center">Sanction date</td>
	<td class="clrborder" align="center">Sanction&nbsp;Amount<br>(in lakhs)</td>
	<td class="clrborder" align="center">No of Habitations</td>
	<%if(md1!=null && !md1.equals("") && md1.equals("getCancelWorks")){%>
	<td class="clrborder" align="center">Work Cancel Date</td>
	<%}%>
	<td class="clrborder" align="center">Check</td>
	</tr>
	
	
<nested:iterate id="WORKS_DELETES" property="worksforDelete" indexId="ndx">
<tr align="left" >
<td class="bwborder"><%=count++%></td>

<td class="bwborder"><bean:write name="WORKS_DELETES" property="workname" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="workid" /></td>
<td class="bwborder"><bean:write name="WORKS_DELETES" property="progName" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="subprogName" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="sanctionno" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="sanctiondt" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="sanctionamount" /></td>
<td  class="bwborder" align="right" ><bean:write name="WORKS_DELETES" property="noofhabs" />
		&nbsp;<input type="button" value="..." title="Show Selected Habs"  class="btext" 
			name="<bean:write name="WORKS_DELETES" property="workid" />" onclick="javascript:fnShowHabs(this)">
	</td>
<%if(md1!=null && !md1.equals("") && md1.equals("getCancelWorks")){%>
<td class="bwborder" align=center><bean:write name="WORKS_DELETES" property="wrkCanDate" /></td>
<%}%>
<td class="bwborder" align=center><input type=checkbox name=check<%=count%> value='<bean:write name="WORKS_DELETES" property="workid" />' ></td>

</tr>
</nested:iterate>

<%if(count==1)
{ %>
<tr><td colspan="11" align="center" class="btext">No Records</td></tr>
<%}
	else
	{
		if(subusercode.equals("00"))
		{
		%>
			<tr><td colspan="11" align="center" ><input type=button value=lete onClick="fnchkdelete();" ></td></tr>
		<%
		}
		else 
		{
	%>
			<tr><td colspan="11" align="center" ><input type=button value=lete onClick="fnchkdelete();" disabled></td></tr>
		<%
		}
	}
%>
<input type="hidden" name="resultCount" value="<%=count%>">
<html:hidden property="deldate" value='<%=transdate%>'/>
</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>