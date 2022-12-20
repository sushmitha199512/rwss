<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ page import="java.util.*;"%>
<% int sno = 1;
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
  var workId=document.getElementById('workId').value;
  var url="switch.do?prefix=/works&page=/PickHabs.do?workId="+workId+"&revTs=No";
   var prop="top=100,left=0,height=300,width=600,location=1,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
  window.open(url,'',prop);
}
function showTshabDetails()
{
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/WorkStatus.do?mode=tsHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
}
function fnGetItems(index)
{
   var url = "switch.do?prefix=/estimates&page=/TsMileStone.do&mode=data&mode1=items&index="+index;
	document.forms[0].action = url;
	document.forms[0].submit();
}
function fnGetdata(val)
{
  	//alert("val:"+val);
	document.forms[0].mode1.value=val;  
	document.forms[0].action = "switch.do?prefix=/estimates&page=/TsMileStone.do&mode=data";
	document.forms[0].submit();
}
</script>

<html:form action="/TsMileStone.do?">
<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead>
<tr>
	<td>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="Technical Estimate - Preparation" />
			<jsp:param name="TWidth" value="100%" />
		</jsp:include>
	</td>
</tr>
</thead>

<tfoot>
<tr>
	<td>
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="100%" />
		</jsp:include>
	</td>
</tr>
</tfoot>
<tbody class="formTbody">
<tr>
<td>
<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.rwsOffices" /></legend>
	<label>
	<table>
	<tbody class="formTBody">
	<tr>
		<td class="column1"><bean:message key="app.headoffice" /></td>
		<td class="column2">
			<logic:equal name="RWS_USER" property="headOfficeCode" value="0">
				<html:select property="headOfficeCode" onchange="javascript: fnGetdata()"
							 styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="headOffices" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
					<html:text property="headOfficeName" styleClass="text-box" 
							name="RWS_USER" readonly="true"/>
					<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notEqual>
		</td>
		<td class="column3"><bean:message key="app.circle" /></td>
		<td class="column4">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode" onchange="javascript: fnGetdata('divisions')" 
							 styleClass="combo">
					<html:option value="00"><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="thin-text-box" 
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
	</tr>
	<tr>
		<td class="column1"><bean:message key="app.division" /></td>
		<td class="column2">
		<logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:select property="divisionOfficeCode" onchange="javascript: fnGetdata('subdivisions')"
						 styleClass="combo">
			<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:text property="divisionOfficeName" styleClass="thin-text-box" 
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
		<td class="column3"><bean:message key="app.subdivision" /></td>
		<td class="column4">
		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="0">
			<html:select property="subdivisionOfficeCode" styleClass="combo"
						 onchange="javascript: fnGetdata('asttypes')">
			<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions">
			<html:options collection="subdivisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName" styleClass="thin-text-box" 
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
	</tr>
	</tbody> 
	</table>
	</label>
	</fieldset>
</td>
</tr>
<tr>
<td>
	<fieldset>
	<label>
	<table>
	<tbody  class="formTBody">
	<tr>
		<td class="column1">Work Category<span class="mandatory">*</span></td>
		<td class="column2">
	
		<html:select property="assetType"
				onchange="javascript: fnGetdata('works')" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<logic:notEmpty name="assetTypes">
				<html:options collection="assetTypes" name="labelValueBean"
					property="value" labelProperty="label" />
					</logic:notEmpty>
					</html:select>
			
		</td>
		<td class="column3"></td>
		<td class="column4"></td>
	 </tr>
	 <tr>	
		<td class="column1">Work<span class="mandatory">*</span></td>
		<td colspan="3">
		
		<html:select property="workId" style="width:500px"  onchange="javascript: fnGetdata('getMiles')" >
		<html:option value="">SELECT...</html:option>
		<logic:notEmpty name="workIds">
		<html:options collection="workIds" name="labelValueBean"
			property="value" labelProperty="label" />
			</logic:notEmpty>
		</html:select>
		
		</td>
	</tr>
	</tbody>
	</table>
</td>
</tr>
<logic:present name="Milestones">
<%if(request.getParameter("mode1")!=null && (request.getParameter("mode1").equals("getMiles") || request.getParameter("mode1").equals("items") || request.getParameter("mode1").equals("save") || request.getParameter("mode1").equals("remove"))) {%>
<tr><td><!--Technical Sanction Code-->
<table>
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
	  		  <bean:write name="TsMileStoneFrm" property="tsAccBy"/>
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
						  <html:text property="tsNo"  styleClass="gridtext" maxlength="30" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" />
						  </td>
						  <td class="clrborder" align="right">
						  <html:text property="tsDate"  styleClass="gridtext" style="width:80px" readonly="true"/>
							  <a href="javascript: showCalendar(document.TsMileStoneFrm.tsDate);">
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
	 		 	  </td></tr>
				  <tr  class="textborder">
					   <td ><html:link href="#1" onclick="showTshabDetails()" title="Click me to view the Habitaion Details in  Technical Sanction">
 			                 Total Habitations Benefited :  
 			                 </html:link>
					    <html:text property="tsHabsBen"  styleClass="mytext" readonly="true" style="width:80px" onclick="showTshabDetails()" title="Click To View Habitation Details"/> 
					    <logic:notPresent name="REVTSDELTE">
					    <html:button property="mode" styleClass="btext" value="Add/Remove Habs" onclick="getMandalsToAddHabs()" title="Add/Remove Habitations" disabled="false"/> 
					     </logic:notPresent>
					    <html:button property="mode" styleClass="btext" value="Show Habs" onclick="showTshabDetails()" title="Click To View Habitation Details"/> 
					    </td>
					   </tr>
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
</table>
<%}%>
</label>
</fieldset>
<tr>
		<td class="bwborder" >
		<fieldset>
		<legend>
				<B>Items</B>
		</legend>
		<label>
<table cellpadding="4" cellspacing="4" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;">
	  		 <tr class="textborder">
	  		 <td>	  		   
	  		 <table width="500" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			<thead class="gridHeader">
			<tr align=center>
				<th>Sl.No</th>
				<th><bean:message key="app.select" /></th>
				<th>Component</th>
				<th>Item<span class="mandatory">*</span></th>
				<th>Qty</th>
				<th>Units<span class="mandatory">*</span></th>
				<th>Amount<span class="mandatory">*</span></th>
			</thead>
			<tbody>
			 <nested:iterate id="MILES"  name="Milestones" indexId="ndx" scope="session">
			 <tr  bgcolor="#ffffff">
			 <td class="rptValue" width="20px" align="center"><%=sno%>
			 <nested:hidden name="MILES" property="mileStoneSno" indexed="true"/></td>
			 <td width="40px" align="center">
				<input type="checkbox" name="check" value="<%= ndx%>">
			 </td>
			 <td class="rptValue">
				<nested:select name="MILES" property="mileStone" indexed="true" style="width:200px" styleClass="noborder-text-box" onchange='<%= "javascript: fnGetItems(\"+ndx+\")"%>'>
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="MILESTONES">
							<nested:options collection="MILESTONES"  name="rws_works_WorkStatus_bean" 
								  property="mileStone" labelProperty="mileStoneName" />
						</logic:present>
			</nested:select>

				</td>
 			 <td  width="300px" class="rptvalue">
			 <nested:select name="MILES" property="item" indexed="true"  
								   style="width: 180px" styleClass="noborder-text-box">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						    <logic:notEmpty name="MILES" property="stages">
							<nested:optionsCollection name="MILES" property="stages" label="stageName" value="stage"/>
						</logic:notEmpty>
					</nested:select>
			 </td>
					<td width="50px">
					<nested:text name="MILES" property="qtyts" indexed="true" styleClass="noborder-text-box" style="width:50px" maxlength="6" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)"/>
					</td>
					<td width="50px"><nested:text name="MILES" property="unitsts" indexed="true" styleClass="noborder-text-box" style="width:50px" maxlength="6" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)"/></td>
					<td width="50px"><nested:text name="MILES" property="amountts" indexed="true" styleClass="noborder-text-box" style="width:50px" maxlength="6" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)"/></td>
					<%sno++;%>
			 </tr>
			 </nested:iterate>
			 
			</table>
      
		<table>
			<tr>
	  		 <td align="center" >
	  		 <html:button property="mode" styleClass="btext" value="Add Item" 
	  		 onclick="fnAddNew2() " title="Click to add a new Item"/>&nbsp;&nbsp;
			 <html:button property="mode" styleClass="btext" value="Remove Item" 
	  		 onclick="fnRemove() " title="Click to Remove Item"/>	  		  
			</td>
	  		 </tr>
			 </table>
		
		</td>
		</tr></table>
		</label>
		</fieldset>
		<tr>
		<td align="center"> <input type=button name="savework<%=sno%>" title="Save the Fields"  Class="btext" value="Save" onclick="fnSave(<%=sno%>)"/></td>
		</tr>
</logic:present>
<script language="javascript">
function fnAddNew2()
{
		var val = '<%=sno%>';
		document.forms[0].action = "switch.do?prefix=/estimates&page=/TsMileStone.do&mode=addNew&sno="+val;
	    document.forms[0].submit();
}
function unique(arrayName)
{
    var newArray=new Array();
    label:for(var i=0; i<arrayName.length;i++ )
    {  
        for(var j=0; j<newArray.length;j++ )
        {
            if(newArray[j]==arrayName[i]) 
                continue label;
        }
        newArray[newArray.length] = arrayName[i];
    }
    return newArray;
}
function fnAddNew()
{
    var wCount = '<%=sno%>';
	var val = '0';
	if(wCount!=0)
	{
		for(var i=0;i<wCount;i++)
		{
			var status =true; 
				//makeCompulsory(i);
			//if(status==false){break;}
		}
		if(status==true)
		{
			val = document.getElementById("MILES["+(wCount-1)+"].majorMileStone").value;
			var newArray=new Array();
			for(i=0;i<wCount;i++)
			{		
				newArray[i] = document.getElementById("MILES["+i+"].majorMileStone").value;
			}
			var newArray1 = unique(newArray);
			for(i=0;i<newArray1.length;i++)
			{		
				val = newArray1[i];
			}
			val++;
			
			document.forms[0].action = "switch.do?prefix=/estimates&page=/TsMileStone.do&mode=addNew&majorCode="+val;
	        document.forms[0].submit();
		}
	}
	else
	{
		val++;
		document.forms[0].action = "switch.do?prefix=/estimates&page=/TsMileStone.do&mode=addNew&majorCode="+val;
	    document.forms[0].submit();
	}

    
 }

function fnAddNew1()
{
	var wCount = '<%=sno%>';
	
	if(wCount==0)
	{
		alert("Please Add Items");
	}
	else
	{
		for(var i=0;i<wCount;i++)
		{
			//var status = makeCompulsory(i);
			//if(status==false){break;}
			var status=true;
		}
			if(status==true)
			{
				var newArray=new Array();
				for(i=0;i<wCount;i++)
				{		
					newArray[i] = document.getElementById("MILES["+i+"].majorMileStone").value;
				}
				var newArray1 = unique(newArray);
				document.forms[0].majorNo.options.length = 0; 
			   	var combo = document.getElementById("majorNo");  
			   	var optn = document.createElement("OPTION");
				optn.text = "-Select-";
				optn.value = "";
				combo.add(optn);
				for(i=0;i<newArray1.length;i++)
				{
					optn = document.createElement("OPTION");
					optn.text = newArray1[i];
					optn.value = newArray1[i];
					combo.add(optn);
				}
				document.getElementById('OptionsDiv1').style.display='block';
			}
	}
}
function fnSave(index)
{
   var wCount = '<%=sno%>';
	if(wCount==1)
	{
		alert("Please Add Item(s)");
	}
	else
	{
		var adminAmnt = document.getElementById('adminAmnt').value;
		var tsAmnt = document.getElementById('tsAmnt').value;
		if(parseFloat(adminAmnt)<parseFloat(tsAmnt))
		{
			alert("Technical Sanction Amount:("+tsAmnt+") Lakhs Should be less than or equal to Admin. Sanction Amount:("+adminAmnt+") Lakhs");
		}
		else 
		{
			var adminSancDate = document.getElementById('adminDate').value;
			var tsDate = document.getElementById('tsDate').value;
			if(document.getElementById('tsNo').value=="")
			{
				alert("Please Enter Technical Sanction No.");
				document.getElementById('tsNo').focus();
			}
			else if(tsDate=="")
			{
				alert("Please Enter Technical Sanction Date");
				document.getElementById('tsDate').focus();
			}
			else if(getDateObject(adminSancDate,"/") <= getDateObject(tsDate,"/"))
			{
					for(var i=0;i<wCount-1;i++)
					{
						var status = makeCompulsory(i);
						if(status==false){break;}
					}
					if(status==false){}
					else
					{
						document.forms[0].action = "switch.do?prefix=/estimates&page=/TsMileStone.do&mode=data&mode1=save";
						document.forms[0].submit(); 
					}
			}
			else
			{
				alert("Technical Sanction Date:("+tsDate+") Should be Greater than or equal to Admin. Sanction Date:("+adminSancDate+")");
			}
		}
	}
}
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
function fnRemove()
{
	var wCount = '<%=(sno-1)%>';
	var selectCount=0;
	for(i=0; i<document.forms[0].elements.length; i++)
	{
		if(document.forms[0].elements[i].type=="checkbox" && document.forms[0].elements[i].name=="check" && document.forms[0].elements[i].checked)
		{
			selectCount++;
		}
	}
   	var url = "switch.do?prefix=/estimates&page=/TsMileStone.do&mode=data&mode1=remove";
	document.forms[0].action = url;
	if(selectCount>0)
	{
		if(parseInt(selectCount)==parseInt(wCount))
		{
			alert("You Cannot Remove All the Items");
		}
		else
		{
			document.forms[0].submit();
		}
	}
	else
	{
		alert("Please Select Atleast one Item to Remove");
	}
}
function makeCompulsory(i)
{
	if(document.getElementById("MILES["+i+"].mileStone").value=="")
	{
		alert("Please Select Component for S.No:"+(i+1));
		document.getElementById("MILES["+i+"].mileStone").focus();
		return false;
	}
	else if(document.getElementById("MILES["+i+"].item").value=="")
	{
		alert("Please Select Item for S.No:"+(i+1));
		document.getElementById("MILES["+i+"].item").focus();
		return false;
	}
	else if(document.getElementById("MILES["+i+"].qtyts").value=="")
	{
		alert("Please Enter Quantity for S.No:"+(i+1));
		document.getElementById("MILES["+i+"].qtyts").focus();
		return false;
	}
	else if(document.getElementById("MILES["+i+"].unitsts").value=="")
	{
		alert("Please Enter Units for S.No:"+(i+1));
		document.getElementById("MILES["+i+"].unitsts").focus();
		return false;
	}
	else if(document.getElementById("MILES["+i+"].amountts").value=="")
	{
		alert("Please Enter Amount for S.No:"+(i+1));
		document.getElementById("MILES["+i+"].amountts").focus();
		return false;
	}
	else
	{
		return true;
	}
}
</script>
<html:hidden property="mode1"/>
<html:hidden property="adminDate"/>
<html:hidden property="adminAmnt"/>
<input type="hidden" name="sno" value="<%=sno%>"> 
<html:hidden property="tsAccBy"/>
<%@ include file="/commons/rws_alert.jsp"%> 
</html:form>
