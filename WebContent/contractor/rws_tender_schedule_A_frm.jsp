<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>

<html:javascript formName="tenderScheduleForm"/>


<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/contractor&page=/TenderSchedule.do&mode=data";
	document.forms[0].submit();
}
function viewfun()
{
    document.forms[0].action="switch.do?prefix=/contractor&page=/TenderSchedule.do&mode=View";
	document.forms[0].submit();
}

function showComponents()
{
	document.forms[0].action="switch.do?prefix=/contractor&page=/TenderSchedule.do&mode=components";
	document.forms[0].submit();
}
function func()
{

     var str=document.forms[0].tenderForm.value;
     var workId=document.forms[0].workId.value;
     if(str.substring(str.length-3,str.length)=="xls")
     {
     
    
       url = "switch.do?prefix=/contractor&page=/TenderSchedule.do&mode=dispTender&workId="+workId+"&file="+str;
 	   window.open(url,"","left=0,top=0,scrollbars=1");
     }
     else{ alert("Uplaod xls sheet only");
     return false; 
     }
  }
function showWorkDetails()
{
	var workId=document.tenderScheduleForm.workId.value;
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
          
          return true;
      }  
      else
      {  alert(message);
        return false;
      }   
    } 
   
}
function calculateamount(count)
{
count=count-1;
 var qty = document.forms[0].elements['WORKCOMPONENT_LIST['+count+'].unitRate'].value;
 var cost = document.forms[0].elements['WORKCOMPONENT_LIST['+count+'].quantity'].value;
 
 var amount = cost * qty;
 
document.forms[0].elements['WORKCOMPONENT_LIST['+count+'].amount'].value=amount;
}
//-->
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="TenderSchedule.do" enctype="multipart/form-data" onsubmit="return validateTenderScheduleForm(this)" >
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
			    	<html:select property="assetTypeCode" styleClass="mycombo" 
			    				 style="width:123px" onchange="javascript:getData()">
					<html:option value="">SELECT...</html:option>
					<html:options collection="assetTypes" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</html:select>
				</TD>
				<TD class="textborder" nowrap>
					<bean:message key="app.workId" />
						<font color="#FF6666">*</font>&nbsp;:
				</TD>
			    <TD class="textborder">
			    	<html:select property="workId" styleClass="mycombo" 
			    				 style="width:243px" onchange="javascript:showComponents()">
					<html:option value="">SELECT...</html:option>
					<html:options collection="workIds" name="rwsContractor" 
								  property="workId" labelProperty="workName" />
					</html:select>
					<input type="button" class="btext" value="..." style="width:22px;height:19px" onclick="showWorkDetails()">
				</TD>
			</tr>
		</table>
		</label>
		</fieldset>
		<logic:present name="workDetails">
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
				<nested:iterate id="WORKCOMPONENT_LIST" property="workComps" >
				
				  <% count=count+1; %>
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
					<nested:select name="WORKCOMPONENT_LIST" property="assetSubCompTypeCode" styleClass="mycombo" style="width:153px" indexed="true" >
					<html:option value=""><font class=myfontclr1>SELECT...</html:option>
					<nested:present property="workSubComps"  name="WORKCOMPONENT_LIST">
		          	  <nested:define id="subComps" property="workSubComps" />
      					<html:options collection="subComps"	name="labelValueBean" property="value" labelProperty="label"/>
					    </nested:present>
				</nested:select>
						
					</td>
					
					<td align="right" class="bwborder">
						<nested:text title="qnty"
						             name="WORKCOMPONENT_LIST" 
									 property="quantity" 
									 style="width:90px" 
									 maxlength="9" 
									 styleClass="mytbltext" indexed="true"  onkeypress="return decimalsOnly(event)" onchange='<%="javascript:calculateamount(\"+count+\")"%>'/>
					</td>
					<td align="right" class="bwborder">
						<nested:text title="unit"
						             name="WORKCOMPONENT_LIST" 
									 property="unitRate" 
									 style="width:90px" 
									 maxlength="9" 
									 styleClass="mytbltext" indexed="true"  onkeypress="return decimalsOnly(event)" onchange='<%="javascript:calculateamount(\"+count+\")"%>'/>
					</td>
					<td align="right" class="bwborder">
						<nested:text name="WORKCOMPONENT_LIST" 
									 property="amount" 
									 style="width:90px" 
									 maxlength="11" 
									 styleClass="mytbltext" indexed="true" readonly="true" onkeypress="return decimalsOnly(event)"/>
					</td>
					
					
				</tr>
				</nested:iterate>
					<input type="hidden" name="count" value="<%= count %>">
			</table>
			</label>
			</fieldset>
			</logic:present>
		</td>
		<logic:present name="workDetails">
		<tr><td>
		<table>
	    <tbody class="formTBody">
	    <tr>
		<td class="column1" nowrap>Tender Shedule Form </td>
		<td class="column2" colspan="3">
			<html:file property="tenderForm" styleClass="thin-text-box" onchange="func()"/>
		</td>
	    </tr>
		</tr>
		</table></td>
	    </tr>
	    </logic:present>
	<tr>
		<td align="center">
			<html:submit property="mode" title="Save the Fields"  
						 styleClass="btext" value="Save" onclick="return addfunc()" />
			<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
			<html:button property="mode" title="View the Tender ScheduleA" styleClass="btext" value="View"  onclick="viewfun()"/>						 
				 
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