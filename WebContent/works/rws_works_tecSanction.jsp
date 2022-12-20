<!-- Form to dispaly all the fields in technical Sanction -->
<%@ page import="java.util.*"%>
<%
int rowCount=0; 
String syr="";
Calendar cal=new GregorianCalendar();
int yr=cal.get(Calendar.YEAR);
int pyr=yr-1;
int nyr=yr+1;
int month=cal.get(Calendar.MONTH);
if (month<3)
{
syr+=""+pyr+"-"+yr;
pyr=yr-1;
nyr=yr+1;
}
else
{
syr+=""+yr+"-"+nyr;
pyr=yr-1;
nyr=yr+1;
}
String yr1 = pyr+"-"+yr;
String yr2 = (pyr-1)+"-"+(yr-1);
String yr3 = (pyr-2)+"-"+(yr-2);
String yr4 = (pyr-3)+"-"+(yr-3);
%>
<script>
function getMandalsToAddHabs()
{
  var workId=document.forms[0].elements["workId"].value;
  var url="switch.do?prefix=/works&page=/PickHabs.do?workId="+workId+"&revTs=No";
   var prop="top=100,left=0,height=300,width=600,location=1,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
  window.open(url,'',prop);
}
function getMandalsToAddHabsForTsRev()
{
  var workId=document.forms[0].elements["workId"].value;
  var url="switch.do?prefix=/works&page=/PickHabs.do?workId="+workId+"&revTs=Yes";
   var prop="top=100,left=0,height=300,width=600,location=1,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
}
function saveTsDetails()
{
var  status= validateWorkForm(WorkForm);
if(status==false)
      return  false;
else
{ 
 
     var amnt=0;
	   amnt=parseInt( document.forms[0].elements["adminAmnt"].value);
	    var tsAmnt=0;
	   tsAmnt= parseInt(document.forms[0].elements["tsAmnt"].value);
	 
	 if(tsAmnt>amnt)
	 {
	  alert("Technical sanction amount is greater than Admin sanctioned amount");
	 }
	 else
	 {
	   var status=chkDates();
	   if(status)
	   {
	    document.forms[0].elements["tsMode"].value='save';
	    document.forms[0].submit();
	   }
	 }
}
   
}
function updateTsDetails()
{
	
 var  status= validateWorkForm(WorkForm);
 if(status==false)
 return  st;
 else
 {
     var amnt=0;
	  amnt=parseInt(document.forms[0].elements["adminAmnt"].value);
	  var tsAmnt=0;
	   tsAmnt=parseInt(document.forms[0].elements["tsAmnt"].value);
	  
	 if(tsAmnt>amnt)
	 {
	  alert("Technical sanction amount is greater than Admin sanctioned amount");
	 }
	 else
	 {
	   var status=chkDates();
	   if(status)
	   {
	   document.forms[0].elements["tsMode"].value='Update';
	   document.forms[0].submit();
	   }
	 }
 }
}
function delTsDetails()
{
      document.forms[0].elements["tsMode"].value='Delete';
	  document.forms[0].submit();
}
function chkDates()
{
                  var date=document.forms[0].elements["tsDate"].value;
				  var toDate=document.forms[0].elements["cDate"].value;
				  
				  var adminSancDate=document.forms[0].elements["adminDate"].value;
				  var temp=adminSancDate;
				   
				  adminSancDate=adminSancDate.split('/');
				  date=date.split('/');
				  toDate=toDate.split('/');
				   
				  var admn=new Date(adminSancDate[2],adminSancDate[1]-1,adminSancDate[0] );
				  var from=new Date(date[2],date[1]-1,date[0] );
				  var to=new Date(toDate[2],toDate[1]-1,toDate[0] );
				  if(from<admn)
	                {
	                 alert("Technical sanction date must be greater than or equals to "+temp+"(Admin Sanction Date)");
	                 return false;
	                }
				  if(to>=from&&from>=admn)
				   {
				    return true;
				   }
				   else
				   {
				    alert("Technical snaction date must be less  than or equals to Today's Date");
				    return false;
				   }
}

</script>
<html:hidden property="adminDate"/>
<%java.util.Date d=new java.util.Date();
		java.text.SimpleDateFormat format=new java.text.SimpleDateFormat("dd/MM/yyyy"); 
		String currentDate=format.format(d);
		String mbvalue=(String)session.getAttribute("mbvalue");
		%>
<input type="hidden"  name="cDate"    value='<%=currentDate%>'/>
<html:hidden property="tsAccBy"/>
<html:hidden property="adminAmnt"/>
 
<tr>
		<td class="bwborder" >
		<fieldset>
		<legend>
				<B>Technical  Sanction (Amount In Rs.Lakhs)</B>
		</legend>
		<label>
		<table cellpadding="4" cellspacing="4" border="0"    
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;">
	  		<tr class="textborder">
	  		  <td>Techncial Sanction Accorded By: 
	  		  <bean:write name="WorkForm" property="tsAccBy"/>
	  		  <logic:present name="officeName">
	  		  <input type="text" name="disp" value="<%=(String)request.getAttribute("officeName")%>" class="myText" readonly="readonly"/>
	  		  </logic:present>
	  		  <logic:present name="SubDivs">
	  		    <html:select property="subDivCode" style="width:140px" styleClass="mycombo"  >
	             <html:options collection="SubDivs"   property="value" labelProperty="label" />
	             </html:select>
	  		  </logic:present>
	  		  </td>
	 		</tr>
	 		<tr>
	 		<td>
	 		  <table   width="750" bgcolor="#ffffff" cellpadding="0" cellspacing="1" 
					   border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <tr class="clrborder">
					     <td class="clrborder" align="center">S.No.</td>
					      
					     <td class="clrborder" align="center">Tech Sanc Amt</td>
					     <td class="clrborder" align="center">Technical Sanction No.</td>
					     <td class="clrborder" align="center">Technical Sanction Date</td>
					     <td class="clrborder" align="center">SSR Year</td>
					  </tr>
					  <tr class="clrborder">
					      <td class="bwborder" align="center" >
					      1.
					      </td>
					       
						  <td class="clrborder" align="right">
						  <html:text property="tsAmnt"  styleClass="gridtext" maxlength="10" onkeyup="extractNumber2(this,10,2,false)"/>
						  </td>
						  <td class="clrborder" align="left">
						  <html:text property="tsNo"  styleClass="gridtext" maxlength="30"  />
						  </td>
						  <td class="clrborder" align="right">
						  <html:text property="tsDate"  styleClass="gridtext" style="width:80px"/>
							  <a href="javascript: showCalendar(document.WorkForm.tsDate);">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
							  </a>
						  </td>
						   <td class="bwborder" align="center">
					      <html:select property="syr" style="width:125px" styleClass="mycombo">
						  <html:option value="<%=syr%>"><font class="myfontclr1"><%= syr %></html:option>
	                      <html:option value="<%=yr1%>"><font class="myfontclr1"><%=yr1%></html:option>
	                      <html:option value="<%=yr2%>"><font class="myfontclr1"><%=yr2%></html:option>
	                      <html:option value="<%=yr3%>"><font class="myfontclr1"><%=yr3%></html:option>
  	                      <html:option value="<%=yr4%>"><font class="myfontclr1"><%=yr4%></html:option>
	                      </html:select>
						 </td>
					   </tr>
	 		       </table>
	 		 	  </td>
	 		      </tr>
				
				   <% 
					   if(statss.equals("LAB")) {%>
					    <tr  class="textborder">
					   <td ><html:link href="#1" onclick="showTshabDetails()" title="Click me to view the Habitaion Details in  Technical Sanction">
 			                 Total Labs :  
 			                 </html:link>
					    <html:text property="tsHabsBen"  styleClass="mytext" readonly="true" style="width:80px" onclick="showTshabDetails()" title="Click To View Lab Details"/> 
					    <html:button property="mode" styleClass="btext" value="Show Labs" onclick="showTshabDetails()" title="Click To View Habitation Details"/> 
					    </td>
					   </tr>
					     <%} else if(statss.equals("SCHOOLS")) {%>
						 <tr  class="textborder">
					   <td ><html:link href="#1" onclick="showTshabDetails()" title="Click me to view the School Details in  Technical Sanction">
 			                 Total Schools :  
 			                 </html:link>
					    <html:text property="tsHabsBen"  styleClass="mytext" readonly="true" style="width:80px" onclick="showTshabDetails()" title="Click To View School Details"/> 
					    <html:button property="mode" styleClass="btext" value="Show Schools" onclick="showTshabDetails()" title="Click To View School Details"/> 
					    </td>
					   </tr>
					    <%}else if(statss.equals("PUBLIC INSTITUTES")) {%>
						 <tr  class="textborder">
						   <td ><html:link href="#1" onclick="showTshabDetails()" title="Click me to view the Public Institutes Details in  Technical Sanction">
	 			                 Total Public Institutes :  
	 			                 </html:link>
						    <html:text property="tsHabsBen"  styleClass="mytext" readonly="true" style="width:80px" onclick="showTshabDetails()" title="Click To View Public Institutes Details"/> 
						    <html:button property="mode" styleClass="btext" value="Show Public Institutes" onclick="showTshabDetails()" title="Click To View Public Institutes Details"/> 
						    </td>
						   </tr>
						    <%}
					    else if(statss.equals("ANGANWADIS")) {%>
						 <tr  class="textborder">
						   <td ><html:link href="#1" onclick="showTshabDetails()" title="Click me to view the Anganwadi Details in  Technical Sanction">
	 			                 Total Anganwadis :  
	 			                 </html:link>
						    <html:text property="tsHabsBen"  styleClass="mytext" readonly="true" style="width:80px" onclick="showTshabDetails()" title="Click To View Anganwadi Details"/> 
						    <html:button property="mode" styleClass="btext" value="Show Anganwadis" onclick="showTshabDetails()" title="Click To View Anganwadi Details"/> 
						    </td>
						   </tr>
						    <%}else{%>
	 		           <tr  class="textborder">
					   <td ><html:link href="#1" onclick="showTshabDetails()" title="Click me to view the Habitaion Details in  Technical Sanction">
 			                 Total Habitations Benefited :  
 			                 </html:link>
					    <html:text property="tsHabsBen"  styleClass="mytext" readonly="true" style="width:80px" onclick="showTshabDetails()" title="Click To View Habitation Details"/> 
					    
					    <%if(physicalStatuss.equals("Financially Completed") || physicalStatuss.equals("Commissioned") || physicalStatuss.equals("Completed") || !workCancelleddDate.equals(""))
						{
						 %>
					    <logic:notPresent name="REVTSDELTE">
					    <html:button property="mode" styleClass="btext" value="Add/Remove Habs" onclick="getMandalsToAddHabs()" title="Add/Remove Habitations" disabled="true"/> 
					     </logic:notPresent>
					     <%
						}
                      //add/remove habs diable/enable based on milestone and bills
                        else if( mbvalue.equals("Disable"))
						{
						 %>
					    <logic:notPresent name="REVTSDELTE">
					    <html:button property="mode" styleClass="btext" value="Add/Remove Habs" onclick="getMandalsToAddHabs()" title="Add/Remove Habitations" disabled="true"/> 
					     </logic:notPresent>
					     <%
						}
						else
						{ %>
					    <logic:notPresent name="REVTSDELTE">
					    <html:button property="mode" styleClass="btext" value="Add/Remove Habs" onclick="getMandalsToAddHabs()" title="Add/Remove Habitations"  disabled="false"/> 
					     </logic:notPresent>
					     <%} %>
                    
					    <html:button property="mode" styleClass="btext" value="Show Habs" onclick="showTshabDetails()" title="Click To View Habitation Details"/> 
					    </td>
					   </tr>
<%}%>


					   
<%if(!(statss.equals("LAB") || statss.equals("SCHOOLS")|| statss.equals("PUBLIC INSTITUTES")|| statss.equals("ANGANWADIS"))){%>
					    
					   <tr class="textborder">
						      <td colspan="10">
					   		  <fieldset>
							    <legend >
										<B>Population Benefited(AS Per Census)</B>
							    </legend>
							    <label>
						 		<table cellpadding="0" cellspacing="3" border="0"   
							   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
							   <tr class="textborder">
							   <td>Plain: <html:text property="tsPlainPop"  styleClass="mytext"   readonly="true" style="width:80px"  />  
							   Sc: <html:text property="tsScPop"  styleClass="mytext"   readonly="true" style="width:80px"  />  
							   St: <html:text property="tsStPop"  styleClass="mytext"   readonly="true" style="width:80px"  />  
							   Total: <html:text property="tsTotPop"  styleClass="mytext"   readonly="true" style="width:80px"  /> </td>
							   </tr>
						       </table>
						       </label>
						      </fieldset>
						      </td>
		                </tr>
						<%}%>
		                <%if(physicalStatuss.equals("Financially Completed") || physicalStatuss.equals("Commissioned") || physicalStatuss.equals("Completed") || !workCancelleddDate.equals(""))
		                {
		         
		                %>
					   <logic:notPresent name="UPDATE">
					   <input type="hidden" name="EnterRevTec" value="deny"/>
					   <tr  class="textborder">
						   <td align="center">
						    <html:button property="mode" styleClass="btext" value="Save" onclick="saveTsDetails()" disabled="true"/> 
						     <html:reset   styleClass="btext" value="Reset"/> 
						   </td>
					   </tr>
					   </logic:notPresent>
					   <logic:present name="UPDATE">
					     <logic:notPresent name="REVTSDELTE">
					   <input type="hidden" name="EnterRevTec" value="allow"/>
					   <tr  class="textborder">
						   <td align="center">
						    <html:button property="mode" styleClass="btext" value="Update" onclick="updateTsDetails()" disabled="true"/> 
						    <html:button property="mode" styleClass="btext" value="Delete" onclick="delTsDetails()" disabled="true"/>
						    <html:reset   styleClass="btext" value="Reset"  disabled="true"/> 
						   </td>
					   </tr>
					   </logic:notPresent>
					   </logic:present>
					   <%
		                }
		                else{
		                %>
					   <logic:notPresent name="UPDATE">
					   <input type="hidden" name="EnterRevTec" value="deny"/>
					   <tr  class="textborder">
						   <td align="center">
						    <html:button property="mode" styleClass="btext" value="Save" onclick="saveTsDetails()"/> 
						     <html:reset   styleClass="btext" value="Reset"/> 
						   </td>
					   </tr>
					   </logic:notPresent>
					   <logic:present name="UPDATE">
					   <logic:notPresent name="REVTSDELTE">
					   <input type="hidden" name="EnterRevTec" value="allow"/>
					   <tr  class="textborder">
						   <td align="center">
						    <html:button property="mode" styleClass="btext" value="Update" onclick="updateTsDetails()"/> 
						    <html:button property="mode" styleClass="btext" value="Delete" onclick="delTsDetails()"/>
						    <html:reset   styleClass="btext" value="Reset"/> 
						   </td>
					   </tr>
					   </logic:notPresent>
					   </logic:present>
					   <%} %>
	 		</table>
	 		</label>
	 		</fieldset>
		</td>
</tr>
<tr class="bwborder">
<td><a href="#1" onclick="hideRevTec1()" title="To give Revised Technical Approval Click Here"><!-- (+) --></a></td>
</tr>
<!-- Revised technical sanction Details -->
<script>
function hideRev()
 {
 }
function hideRevTec()
{
   
 if(document.forms[0].elements["EnterRevTec"])
 {
	 if(document.forms[0].elements["EnterRevTec"].value=='deny')
	  document.forms[0].elements["RevTec"].style.display='none';
 }
 if(document.forms[0].elements["revTsNo"])
 {
	 if(document.forms[0].elements["revTsNo"].value==' ')
	 document.forms[0].elements["RevTec"].style.display='none';
 }
  
}
function hideRevTec1()
{
 if(document.forms[0].elements["EnterRevTec"].value=='allow')
  document.forms[0].elements["RevTec"].style.display='inline';
  else
    alert("There is no Technical Sanction Details"); 
 if(document.forms[0].elements["EnterRevTec"].value=='deny')
  document.forms[0].elements["RevTec"].style.display='none';
  
   
}
function deleteRevTsSanction(i)
{
if(confirm("Are You Sure You Want To Delete"))
{
	
document.forms[0].elements["revTsSanction["+i+"].revTsNo"].value="";
document.forms[0].elements["revTsSanction["+i+"].revTsAmnt"].value="";
document.forms[0].elements["revTsSanction["+i+"].revTsDate"].value="";
document.forms[0].elements["revTsSanction["+i+"].revSsrYear"].value="";
}
}
function checkTechnicalApprovals(rowCount)
{

	for(var j=0;j<parseInt(rowCount);j++)
	{
		if(document.forms[0].elements["revTsSanction["+j+"].revTsAmnt"].value=="")
			{
				alert("Revised Technical Approval Amt for Revised Technical \napproval with S.No."+(j+1)+" is required");
				return false;
			}
			if(document.forms[0].elements["revTsSanction["+j+"].revTsDate"].value=="")
			{
				alert("Revised Technical Approval Date for Revised Technical \napproval with S.No."+(j+1)+" is required");
				return false;
			}
			if(!(document.forms[0].elements["revTsSanction["+j+"].revTsAmnt"].value >0))
			{
				alert("Revised Technical Approval Amount for Revised Technical \napproval with S.No."+(j+1)+" Should be greater than 0");
				return false;
			}
	}
	return true;
}
	 		       

function saveRevTsDetails(rowCount)
{
	 
	if(checkTechnicalApprovals(rowCount))
	{  
	   	document.forms[0].elements['revTsMode'].value='Save';
		document.forms[0].action="./switch.do?prefix=/works&page=/WorkStatus.do&noOfRevTechnicalApprovals="+rowCount;
		document.forms[0].submit();
	}
}
function addNewRevTsApproval(rowCount)
{
	if(checkTechnicalApprovals(rowCount))
	{
		document.forms[0].elements["revTsMode"].value='addNewRevTsApproval';
		document.forms[0].action="./switch.do?prefix=/works&page=/WorkStatus.do&noOfRevTechnicalApprovals="+rowCount;
		document.forms[0].submit();
	}
}
function delRevTsDetails()
{
document.forms[0].elements["revTsMode"].value='Delete';
document.forms[0].submit();
}

function saveRevTsDetails1()
{ 
var  status= validateRevTsForm();
 if(status==false)
 return  st;
 else
 {
	  var st=validateRevAmnt();
	 if(st==true)
	 {
	   var status=chkDatesForRev();
	   if(status)
	   {
	    document.forms[0].elements["revTsMode"].value='Save';
	    document.forms[0].submit();
	   }
	 }
 }
}
function updateRevTsDetails()
{
var  status= validateRevTsForm();
 if(status==false)
 return  st;
 else
 {
	 var st=validateRevAmnt();
	  
	 if(st==true)
	 {
	   var status=chkDatesForRev();
	   if(status)
	   {
	    document.forms[0].elements["revTsMode"].value='update';
	    document.forms[0].submit();
	   }
	 }
 }
}
function validateRevAmnt()
{

     var amnt=parseInt(document.forms[0].elements["adminAmnt"].value);
	 var tsAmnt=parseInt(document.forms[0].elements["tsAmnt"].value);
	 var revAmnt=parseInt(document.forms[0].elements["revTsAmnt[0]"].value);
	 var tot=amnt-tsAmnt;
	   
	 if(revAmnt>amnt)
	 {
	  alert("Revised Technical sanction Amount is greater than Admin sanctioned amount");
	  return false;
	 }
	 else
	 {
	  return true;
	 }
}
function validateRevTsForm()
{
 
 if(document.forms[0].elements["revTsNo[0]"].value==' ')
 {
  alert("Revised Technical Sanction number is required");
  return false;
 }
 if(document.forms[0].elements["revTsAmnt[0]"].value==' ')
 {
  alert("Revised Technical Sanction Amount is required");
  return false;
 }
 if(document.forms[0].elements["revTsDate[0]"].value==' ')
 {
  alert("Revised Technical Sanction Date is required");
  return false;
 }
 else
 {
 return true;
 }
}
function chkDatesForRev()
{
 
  
                  var date=document.forms[0].elements["revTsDate"].value;
				  var toDate=document.forms[0].elements["cDate"].value;
				  var tsDate=document.forms[0].elements["tsDate"].value;
				  var temp=tsDate;
				   
				  tsDate=tsDate.split('/');
				  date=date.split('/');
				  toDate=toDate.split('/');
				   
				  var tsDate=new Date(tsDate[2],tsDate[1]-1,tsDate[0] );
				  var from=new Date(date[2],date[1]-1,date[0] );
				  var to=new Date(toDate[2],toDate[1]-1,toDate[0] );
				   
				  if(from<tsDate)
	                {
	                 alert("Revised Technical sanction date must be greater than or equals to "+temp+"(Tecnical Sanction Date)");
	                 return false;
	                }
				  if(to>=from&&from>=tsDate)
				   {
				    return true;
				   }
				   else
				   {
				    alert("Revised Technical snaction date must be less  than or equals to Today's Date");
				    return false;
				   }
}
</script>
<tr id="RevTec">
		<td class="bwborder" >
		<fieldset>
		<legend>
				<B>Revised Technical  Approval(Amount In Rs.Lakhs)</B>
		</legend>
		<label>
		<table cellpadding="4" cellspacing="4" border="0" width="750"   
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;">
	  		<tr class="textborder">
	  		  <td>Revised Techncial Approval Accorded By: 
	  		  <bean:write name="WorkForm" property="tsAccBy"/>
	  		  <logic:present name="officeName">
	  		  <input type="text" name="disp" value="<%=(String)request.getAttribute("officeName")%>" class="myText" readonly="true"/>
	  		  </logic:present>
	  		  <logic:present name="SubDivs">
	  		    <html:select property="subDivCode" style="width:140px" styleClass="mycombo"  disabled="true">
	             <html:options collection="SubDivs"   property="value" labelProperty="label" />
	             </html:select>
	  		  </logic:present>
	  		  </td>
	 		</tr>
	 		<tr>
	 		<td>
	 		  <table   width="600" bgcolor="#ffffff" cellpadding="0" cellspacing="1" 
					   border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <tr class="clrborder">
					     <td class="clrborder" align="center">S.No.</td>
				 	     <td class="clrborder" align="center">Revised Technical Approval Amount</td>
					     <td class="clrborder" align="center">Revised Technical Approval No.</td>
					     <td class="clrborder" align="center">Revised Technical Approval Date</td>
					     <td class="clrborder" align="center">SSR Year</td>
					     <td class="clrborder" align="center">Action</td>
				 	  </tr>
					    <logic:present name="RevTs">
					   
					  <%int i=1; int j=0;%>
					  <%rowCount=0; %>
					  <nested:iterate id="revTsSanction" name="RevTs">
				 	  <tr>
				 	  
					  <td class="bwborder" align="center">
					  <%=i++ %>.
					  <%rowCount++; %>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="revTsSanction" property="revTsAmnt" styleClass="gridtext" onkeypress="return decimalsOnly(event)"
						  indexed="true"  />
					  </td> 
					  <td class="bwborder" align="center">
					 	  <nested:text name="revTsSanction" property="revTsNo" maxlength="30" styleClass="gridtext" 
						  indexed="true" />
					  </td>
					  
					  <td class="bwborder" align="center" >
					 	  <nested:text name="revTsSanction" property="revTsDate" styleClass="gridtext" 
						    style="width:80px" indexed="true" readonly="true"/>
						  <a href="javascript: showCalendar(document.forms[0].elements['revTsSanction[<%=j++%>].revTsDate']);">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
						  </a>
					  </td>
					   <td class="bwborder" align="center">
					      <html:select property="revSsrYear" style="width:125px" styleClass="mycombo" onchange="javascript:getSsrYrs()" >
						  <html:option value="<%=syr%>"><font class="myfontclr1"><%= syr %></html:option>
	                      <html:option value="<%=yr1%>"><font class="myfontclr1"><%=yr1%></html:option>
	                      <html:option value="<%=yr2%>"><font class="myfontclr1"><%=yr2%></html:option>
	                      <html:option value="<%=yr3%>"><font class="myfontclr1"><%=yr3%></html:option>
  	                      <html:option value="<%=yr4%>"><font class="myfontclr1"><%=yr4%></html:option>
	                      </html:select>
						 </td>
					  <td class="bwborder" align="center">
					 	  <a href="#1" onclick='deleteRevTsSanction(<%=j-1%>)'>Delete</a>
					  </td>
					  </tr>
					  
					  </nested:iterate>
					  </logic:present>
					  <tr><td colspan="6" align="right" title="Click to add new Revised Technical Approval" bgcolor="#DEE3E0" ><input type="button" class="btext" value="Add New Revised Technical Approval" onclick="addNewRevTsApproval(<%= rowCount %>)"> </td></tr>
					  </table>
	 		       </td>
	 		      </tr>
	 		     <% 
	 		     //System.out.println("in revised:::::"+statss);
	 		       if(statss.equals("LAB")) {}else if(statss.equals("SCHOOLS")){}else if(statss.equals("PUBLIC INSTITUTES")){}else if(statss.equals("ANGANWADIS")){}else{%>
	 		      <tr  class="textborder">
					   <td ><html:link href="#1" onclick="showRevTshabDetails()" title="Click me to view the Habitaion Details in Revised  Technical Sanction">
 			                 Total Habitations Benefited :  
 			                 </html:link>
					    <html:text property="revTsHabsBen"  styleClass="mytext" readonly="true" style="width:80px" onclick="showRevTshabDetails()" title="Click To View Habitation Details"/> 
					    <html:button property="mode" styleClass="btext" value="Add/Remove Habs" onclick="getMandalsToAddHabsForTsRev()" title="Add/Remove Habitations"/> 
					    <html:button property="mode" styleClass="btext" value="Show Habs" onclick="showRevTshabDetails()" title="Click To View Habitation Details"/> 
					    </td>
				  </tr>
				  <%}%>
				  <%if(!(statss.equals("LAB") || statss.equals("SCHOOLS") || statss.equals("PUBLIC INSTITUTES")|| statss.equals("ANGANWADIS"))){%>
				  <tr class="textborder">
						      <td colspan="10">
					   		  <fieldset>
							    <legend >
										<B>Population Benefited(AS Per Census)</B>
							    </legend>
							    <label>
						 		<table cellpadding="0" cellspacing="3" border="0"   
							   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
							   <tr class="textborder">
							   <td>Plain: <html:text property="revTsPlainPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
							   Sc: <html:text property="revTsScPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
							   St: <html:text property="revTsSTPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
							   Total: <html:text property="revTsTotpopu"  styleClass="mytext"   readonly="true" style="width:80px"  /> </td>
							   </tr> 
   						       </table>
						       </label>
						      </fieldset>
						      </td>
		                </tr>
						<%}%>
						 <logic:present name="UPDATE">
		                <%if(physicalStatuss.equals("Financially Completed") || physicalStatuss.equals("Commissioned") || physicalStatuss.equals("Completed") || !workCancelleddDate.equals(""))
		                {
		                %>
						  <tr  class="textborder">
							   <td align="center">
								    <input type=button name="mode"  class="btext" value="Save"  disabled="true" onclick='saveRevTsDetails(<%= rowCount %>)'/> 
								    <logic:present name="REVTSDELTE">
								    <html:button property="mode" styleClass="btext" value="Delete"  disabled="true" onclick="delRevTsDetails()"/> 
								    </logic:present>
								     <html:reset styleClass="btext" value="Reset"  disabled="true"/> 
							  </td>
 						  </tr>
					     <%
		                }
		                else{
		                %>
						  <tr  class="textborder">
							   <td align="center">
								    <input type=button name="mode"  class="btext" value="Save" onclick='saveRevTsDetails(<%= rowCount %>)'/> 
								    <logic:present name="REVTSDELTE">
								    <html:button property="mode" styleClass="btext" value="Delete" onclick="delRevTsDetails()"/> 
								    </logic:present>
								     <html:reset   styleClass="btext" value="Reset"/> 
							  </td>
 						  </tr>
					     <%}%>
				</logic:present>					    
	   	</table>
	  	</label>
	  	</fieldset>
	  	</td>
</tr>
<%@ include file="/commons/rws_alert.jsp"%>