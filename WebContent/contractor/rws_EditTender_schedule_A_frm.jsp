<%@ include file="/commons/rws_header1.jsp" %>

<html:javascript formName="tenderScheduleForm"/>


<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/contractor&page=/TenderSchedule.do&mode=data";
	document.forms[0].submit();
}
function showComponents()
{
	document.forms[0].action="switch.do?prefix=/contractor&page=/TenderSchedule.do&mode=components";
	document.forms[0].submit();
}
function showWorkDetails()
{
	var workId=document.tenderScheduleForm.workId.value;
    workId=workId.substring(0,workId.indexOf("-"));
 	if(workId==""){
	 alert("Please Select the Work Id");
	} 
	else{ 
	 url = "switch.do?prefix=/contractor&page=/TenderSchedule.do&mode=workDetails&workId="+workId;
	 window.open(url,"","width=500,height=200,left=280,top=100,scrollbars=1");
	}
}

function addfunc()
{  
    if(document.tenderScheduleForm.workId.value !=""){
      var count = document.getElementById("count").value;
 	  var message ="";
	  for(var i=0; i<count; i++)
	  { 
	    if(document.getElementById("WORKCOMPONENT_LIST["+i+"].assetSubCompTypeCode").value=="")
	       message=message + "Sub Component "+(i+1)+" is required\n";
        if(document.getElementById("WORKCOMPONENT_LIST["+i+"].quantity").value=="")
	       message=message + "Quantity "+(i+1)+" is required\n";
	    if(document.getElementById("WORKCOMPONENT_LIST["+i+"].unitRate").value=="")
	       message=message + "Unit Rate "+(i+1)+" is required\n";
	  }
      if(message=="")
      {
     	  document.forms[0].action="switch.do?prefix=/contractor&page=/TenderSchedule.do&mode=edit";
  		  document.forms[0].submit();
          return true;
      }  
      else
      { alert(message);
        return false;
      }   
    } 
   
}

//-->
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="TenderSchedule.do"  >
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Tender Schedule - A Form" />
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
		<legend  >
					<B>Work Details</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="0" width="780" 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr>
				<TD class="textborder" nowrap>
					<bean:message key="app.assetTypeCode" />
						<font color="#FF6666">*</font>&nbsp;:
				</TD>
			    <TD class="textborder">
			    	<html:text property="assetTypeCode" styleClass="mytext" 
			    				 style="width:123px" readonly="true" />
 				</TD>
				<TD class="textborder" nowrap>
					<bean:message key="app.workId" />
						<font color="#FF6666">*</font>&nbsp;:
				</TD>
			    <TD class="textborder">
			       	<html:text property="workId" styleClass="mytext" 
			    				 style="width:243px" readonly="true"/>
    				 <input type="button" class="btext" value="..." style="width:22px;height:18px" onclick="showWorkDetails()">
					 
				</TD>
			</tr>
		</table>
		</label>
		</fieldset>
		 
		<fieldset>
		<legend >
			<B>Work Component Details</B>
		</legend>
		<label>
			<table width="780" bgcolor="#ffffff" cellpadding="0" cellspacing="0" 
				   border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
				<tr>
					<td class="clrborder" align="center">Work Component</td>
					<td class="clrborder" align="center">Sub Component</td>
					<td class="clrborder" align="center">Quantity</td>
					<td class="clrborder" align="center">Unit Rate</td>
					<td class="clrborder" align="center">Amount</td>
				</tr>
				<% int count=0; %>
				
				 <nested:iterate id="WORKCOMPONENT_LIST" property="workComps">
				
				  <% count=count+1; 
				  

				  %>
				  
				<tr >	
					<td class="bwborder" align="center">
						<nested:hidden name="WORKCOMPONENT_LIST" 
									 property="assetComponent" 
									 indexed="true" />
						<nested:text name="WORKCOMPONENT_LIST" 
									 property="assetComponentCode" 
									 styleClass="mytbltext" 
									 indexed="true" readonly="true"/>
					</td> 
					<td class="bwborder" >
					
					<nested:select name="WORKCOMPONENT_LIST" property="assetSubCompTypeCode" styleClass="mycombo" style="width:153px" indexed="true" " >
					<html:option value=""><font class=myfontclr1>SELECT..</html:option>
					<logic:present name="WORKCOMPONENT_LIST" property="workSubComps">
                   <%			  //System.out.println("near combo box");%>
                   </logic:present>
					<nested:present property="workSubComps"  name="WORKCOMPONENT_LIST">
		          	  <nested:define id="subComps" property="workSubComps" />
      					<html:options collection="subComps"	name="labelValueBean" property="value" labelProperty="label"/>
					    </nested:present>
				</nested:select>
						
					</td>
					
					<td align="right" class="bwborder">
						<nested:text name="WORKCOMPONENT_LIST" 
									 property="quantity" 
									 style="width:90px" 
									 maxlength="9" 
									 styleClass="mytbltext" indexed="true"  onkeypress="return decimalsOnly(event)"/>
					</td>
					<td align="right" class="bwborder">
						<nested:text name="WORKCOMPONENT_LIST" 
									 property="unitRate" 
									 style="width:90px" 
									 maxlength="9" 
									 styleClass="mytbltext" indexed="true" onkeypress="return decimalsOnly(event)"/>
					</td>
					<td align="right" class="bwborder">
						<nested:text name="WORKCOMPONENT_LIST" 
									 property="amount" 
									 style="width:90px" 
									 maxlength="11" 
									 styleClass="mytbltext" indexed="true" readonly="true" />
					</td>
				</tr>
				</nested:iterate>
					<input type="hidden" name="count" value="<%= count %>">
			</table>
			</label>
			</fieldset>
			 
		</td>
	<tr>
		<td align="center">
			<html:button  property="mode" title="Save the Fields"  
						 styleClass="btext" value="Save" onclick="return addfunc()" />
			<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
			 
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
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>