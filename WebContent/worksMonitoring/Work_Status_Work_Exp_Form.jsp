	 		<body onload="getAggrigateExpenditure()">
	 		</body>
<script language="javascript">

function expYearChanged(index)
{
var expYear=document.getElementById("WORKEXP_LIST["+index+"].expYear").value;
var expMonth=document.getElementById("WORKEXP_LIST["+index+"].expMonth").value;
var progCode=document.getElementById("WORKEXP_LIST["+index+".progCode").value;
 

var rowCount=getCheckboxRemoveCount();

	if(expYear!="" && expMonth!="" &&progCode!="")
	{
		for(var i=0;i<rowCount;i++)
		{
			if(i!=index)
			{
				//alert(document.getElementById("WORKEXP_LIST["+i+"].expYear").value+"=="+expYear +"&&"+ document.getElementById("WORKEXP_LIST["+i+"].expMonth").value+"=="+expMonth)
				if(document.getElementById("WORKEXP_LIST["+i+"].expYear").value==expYear && document.getElementById("WORKEXP_LIST["+i+"].expMonth").value==expMonth && document.getElementById("WORKEXP_LIST["+i+"].progCode").value==progCode)
				{
					alert("Selection Already Exists");
					document.getElementById("WORKEXP_LIST["+index+"].expYear").value="";
				}
			}
		}
	}
}

function expMonthChanged(index,that)
{
var progCode=document.getElementById("WORKEXP_LIST["+index+"].progCode").value;
var expMonth=document.getElementById("WORKEXP_LIST["+index+"].expMonth").value;
var rowCount=getCheckboxRemoveCount();
var selectionAlreadyExists=false;
	if(that.type=="select-one")
	{
		if(progCode!="" && expMonth!="")
		{
			for(var i=0;i<rowCount;i++)
			{
				if(i!=index)
				{
					if(document.getElementById("WORKEXP_LIST["+i+"].expMonth").value==expMonth && document.getElementById("WORKEXP_LIST["+i+"].progCode").value==progCode)
					{
					//document.getElementById("WORKEXP_LIST["+index+"].expMonth").value="";
					that.value="";
					selectionAlreadyExists=true;
					}
				}
			}
		}
		//if(!selectionAlreadyExists)
			//expMonthChangedSubmit(index);
		return selectionAlreadyExists;
	}
}

function expMonthChangedSubmit(index)
{
//alert("expYear is "+document.getElementById("WORKEXP_LIST["+index+"].expYear").value);
if(document.getElementById("WORKEXP_LIST["+index+"].expYear").value!="" && document.getElementById("WORKEXP_LIST["+index+"].expMonth").value!="")
{
var year=document.getElementById("WORKEXP_LIST["+index+"].expYear").value;
var month=document.getElementById("WORKEXP_LIST["+index+"].expMonth").value
document.forms[0].action="./workStatus.do?workStage=Wexp&mode=expMonthChanged&index="+index+"&year="+year+"&month="+month;
document.forms[0].submit();
}
else if(document.getElementById("WORKEXP_LIST["+index+"].expMonth").value!="")
{
alert("Please Select Year");
document.getElementById("WORKEXP_LIST["+index+"]."+expMonth).value="";
}

}
function addNewExp()
{

document.forms[0].action="/pred/worksMonitoring/workStatus.do?workStage=Wexp&mode=addNew";
document.forms[0].submit();


}
function saveExp1()
{
//getExpDetails1();

document.forms[0].action="./workStatus.do?workStage=Wexp&mode=save";
document.forms[0].submit();
}
function deleteExp()
{
document.forms[0].action="./workStatus.do?workStage=Wexp&mode=delete";
document.forms[0].submit();

}
function removeExp()
{
if(getSelectedCount()>0)
{
document.forms[0].action="./workStatus.do?workStage=Wexp&mode=remove";
document.forms[0].submit();
}
else
{
alert("Please Select atlease one work to Remove");
}
}
function getCheckboxRemoveCount()
{
	var count=0;
		for(i=0; i<document.forms[0].elements.length; i++)
		{
			if(document.forms[0].elements[i].type=="checkbox"&&document.forms[0].elements[i].name=="remove")
			{
			count++;
			}
		}
		//alert("count in checkall is "+count);
		return(count);
}
function getSelectedCount()
{
	var count=0;
		for(i=0; i<document.forms[0].elements.length; i++)
		{
			if(document.forms[0].elements[i].type=="checkbox"&&document.forms[0].elements[i].name=="remove"&&document.forms[0].elements[i].checked)
			{
			count++;
			}
		}
		//alert("count in checkall is "+count);
		return(count);
}
function getExpDetails()
{
	document.forms[0].action="/pred/worksMonitoring/workStatus.do?workStage=Wexp&mode=data";
	document.forms[0].submit();
}
function getExpDetails1()
{
	document.forms[0].action="/pred/worksMonitoring/workStatus.do?workStage=Wexp&mode=sort";
	document.forms[0].submit();
}


</script>
<%java.util.ArrayList status = (java.util.ArrayList)session.getAttribute("disableStatus");
//System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~:"+status.size());
 %>

 <tr>
 <td>
		<fieldset >
		<legend >Expenditure Details (In Rs.Lakhs)</legend>
		<label>
			<table  cellpadding="0" cellspacing="1" 
					    style="border-collapse:collapse" >
			 <%int progCount=-1; %>
			<nested:iterate id="progExp" name="PROGRAMS" indexId="ndx">
			<%progCount++; %>
			<tr>
			<%
			String fyear = (String)request.getAttribute("finYears");
			if(fyear!=null && !fyear.equals(""))
			{
			int a = Integer.parseInt(fyear.substring(0,4));
			a++;
			String fyear1 = ""+a;
			a--;
			a--;
			fyear=a+"-"+fyear.substring(2,4);
			}
			 %>
		 	<td class="mycombo"><b>Expenditure Upto the Last Financial Year(i.e.,<%=fyear%>)(<bean:write name="progExp" property="progName"/>):</b></font> </td>
			<td>
			<%
			//System.out.println("progCount:"+progCount);
			//System.out.println(status.get(progCount));
			if(status.get(progCount).equals("false")){ %>
			 <nested:text property="expUptoPrevYear" name="progExp" indexed="true" onkeyup="extractNumber2(this,10,2,false);getAggrigateExpenditure()" onkeypress="return blockNonNumbers(this, event, true, false)"/>
			<%} else if(status.get(progCount).equals("true")){ %>
			 <nested:text property="expUptoPrevYear" name="progExp" readonly="true" indexed="true" onkeyup="extractNumber2(this,10,2,false);getAggrigateExpenditure()" onkeypress="return blockNonNumbers(this, event, true, false)"/>
			 <%} %>
			<nested:hidden property="workid" name="progExp" indexed="true" />
			<nested:hidden property="progCode" name="progExp" indexed="true" />
			<nested:hidden property="progName" name="progExp" indexed="true" />		
			</td>
			</tr>
			</nested:iterate>
			
						<tr>
			<td class="mycombo"><b>Financial Year:</b></font></td>
			<td>
			   <html:select property="expYears" style="width: 100px" styleClass="noborder-text-box" onchange="getExpDetails()">
					<logic:present name="AllYears">
					<%for(int i=0;i<((java.util.ArrayList)request.getAttribute("AllYears")).size();i++)
					{ 
				 		String val=(String)((java.util.ArrayList)request.getAttribute("AllYears")).get(i);
					%>
					<html:option value="<%= val%>"><%=val%></html:option>
				    <%} %>
					</logic:present>
					</html:select>
				</td>
			</tr>
			
			</table>
			<table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			
			<thead class="gridHeader">
			<html:hidden property="admSanDate"/>
			
			<tr >
			    <th colspan=2></th>
			    <th  colspan=4 align="left">Expenditure During The Selected Financial Year&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  	Expenditure(In Rs.Lakhs)</th>
				<thead class="gridHeader" >
			 	<th>S.NO.</th>
			 	<th>Programme</th>
				<th>Month</th>
			 	<th>Up to the Previous Month</th>
				<th>During The Month</th>
				<th>value of workdone but not paid</th>
				</thead></th>
	 		</tr>
			</thead>
			<tbody>
			<% int workCount = 0;%>
			<logic:present name="expenditureList">
			<nested:iterate id="WORKEXP_LIST" name="expenditureList" indexId="ndx">
			
			<% workCount++; %>
			<tr bgcolor="#ffffff">
				<td width="40px" align="center"><%=workCount %>
				<input type="checkbox" name="remove" value="<%= ndx%>">
				</td>
				<td>
		 		            <nested:select name="WORKEXP_LIST" property="progCode" indexed="true"
									   style="width: 80px" styleClass="noborder-text-box" onchange='<%="getAggrigateExpenditure()"%>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<logic:present name="PROGRAMS">
							<html:options collection="PROGRAMS"  
										  property="progCode" labelProperty="progName" />
						    </logic:present>
							</nested:select>
							<nested:hidden name="WORKEXP_LIST" property="progName" indexed="true" />
		 		</td>
				
				<script language="javascript">
				function checkDate()
				{
			 	 var admDate=document.getElementById('admSanDate').value;
			 	 var values=admDate.split('/');
			 	 //alert(values);
			 	 var admnSancyear=values[2];
				 
				}
				</script>
				<td>
			 	
			 		<nested:select name="WORKEXP_LIST" property="expMonth" indexed="true" 
								   style="width: 100px" styleClass="noborder-text-box" onchange='<%= "javascript:newFunction(\"+ndx+\",this);getExpDetails1()"%>'>
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<%int monthnum=0; %>
						<logic:present name="AllMonths">
						<logic:iterate id="months" name="AllMonths">
						<% monthnum++;%>
						 <html:option value="<%=Integer.toString(monthnum)%>"><bean:write name="months" /></html:option>
						 </logic:iterate>
						 </logic:present>
					</nested:select>
				 				  
				</td>
				<td>
					<nested:text name="WORKEXP_LIST" property="expMonthUp" indexed="true" maxlength="11"
							     style="width: 120px" styleClass="noborder-text-box" 
								onkeyup='<%="javascript:extractNumber2(this,9,2,false);expMonthChanged(\"+ndx+\",this);"%>' onkeypress="return blockNonNumbers(this, event, true, false)"  readonly="true"/>
				</td>
				<td>
					<nested:text name="WORKEXP_LIST" property="expMonthDuring" indexed="true" maxlength="11"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeyup='<%="javascript:extractNumber2(this,9,2,false);getAggrigateExpenditure();"%>' onkeypress="return blockNonNumbers(this, event, true, false)" onchange="calTotExp();reCalExp()"/>
				</td>
				<td>
					<nested:text name="WORKEXP_LIST" property="valueOFWorkDone" indexed="true" maxlength="11"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeyup='<%="javascript:extractNumber2(this,9,2,false);expMonthChanged(\"+ndx+\",this)"%>' onkeypress="return blockNonNumbers(this, event, true, false)" />
				</td>
				 
			</tr>
			</nested:iterate>
		 </logic:present>
			<input type="hidden" name="workCount" value="<%= workCount %>">
			<tr bgcolor="#ffffff">
			<td colspan=10 align=right>
			<input type="button" name="workCount" value="Add New" class="bText" onclick="addNewExp()"/>
			<input type="button" name="workCount" value="Remove" class="bText" onclick="removeExp()"/>
			</td>
			</tr>
			</tbody>
			</table>
			<fieldset>
			<legend >Aggregate Expenditure (In Rs.Lakhs)</legend>
			<label>
			
			<table width="67%" >
			<nested:iterate id="progExp" name="PROGRAMS" indexId="ndx1">
			
			<tr>
		 	<td class="datefont"><b><bean:write name="progExp" property="progName"/></b></td>
			<td >
			<nested:text  name="progExp" property="aggrigateExpenditureForProg"  readonly="true"/>
			</td>
			</tr>
			</nested:iterate>
			<tr border=0>
		 	<td class="textborder"  ><b>Total Expenditure </b></font> </td>
			<td >
			<html:text property="totalExp" readonly="true"/>
			</td>
			</tr>
			</table>
			</label></fieldset>
			<table width="100%">
			<tr>
			<td align="center">
			<input type="button" name="workCount" value="Save" class="bText" onclick="calTotExp();reCalExp();saveExp1()"/>
			<input type="button" name="workCount" value="Delete" class="bText" onclick="deleteExp()"/>
			</td>
			</tr>
			</table>
			
			</label></fieldset>
			
	 		</td></tr>
	 		
	 		
	 		
	 		<script language="javascript">
	 		function getAggrigateExpenditure()
			{
				calTotExp();
				firstMakeEdit();
				for(var i=0;i<=<%=progCount%>;i++)
				{
				var totalExpenditure=0;
				if(document.getElementById("progExp["+i+"].expUptoPrevYear").value!="")
					totalExpenditure=parseFloat(document.getElementById("progExp["+i+"].expUptoPrevYear").value);
				if(document.getElementById("progExps["+i+"].expMonthDuring").value!="")
					totalExpenditure+=parseFloat(document.getElementById("progExps["+i+"].expMonthDuring").value);
				for(var j=0;j<<%=workCount%>;j++)
				{
					if(document.getElementById("WORKEXP_LIST["+j+"].progCode").value==document.getElementById("progExp["+i+"].progCode").value)
					{
						if(document.getElementById("WORKEXP_LIST["+j+"].expMonthDuring").value!="")
						{
							totalExpenditure=totalExpenditure+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].expMonthDuring").value);
							
						}
					}
				}
				if(document.forms[0].aggrigateExpenditureForProg[i])
				document.forms[0].aggrigateExpenditureForProg[i].value=totalExpenditure.toFixed(2);
				else
				document.forms[0].aggrigateExpenditureForProg.value=totalExpenditure.toFixed(2);
				}
				totalExpenditure=0;
				for(var i=0;i<=<%=progCount%>;i++)
				{
					if(document.forms[0].aggrigateExpenditureForProg[i])
					totalExpenditure=totalExpenditure+parseFloat(document.forms[0].aggrigateExpenditureForProg[i].value);
					else
					totalExpenditure=totalExpenditure+parseFloat(document.forms[0].aggrigateExpenditureForProg.value);
					
				
				}
			   document.forms[0].totalExp.value=totalExpenditure.toFixed(2);

			}
	 		function saveExp()
			{
				
				var validationSuccess=true;
				for(var i=0;i<<%=workCount%>;i++)
				{
					if(document.getElementById("WORKEXP_LIST["+i+"].progCode").value=="")
					{
						validationSuccess=false;
						alert("Please Select Programme for Expenditure with S.No "+(i+1));
						return;
					}
					else if(document.getElementById("WORKEXP_LIST["+i+"].expYear").value=="")
					{
						validationSuccess=false;
						alert("Please Select Year for Expenditure with S.No "+(i+1));
						return;
					}
					else if(document.getElementById("WORKEXP_LIST["+i+"].expMonth").value=="")
					{
						validationSuccess=false;
						alert("Please Select Month for Expenditure with S.No "+(i+1));
						return;
					}
					
					
				}
				if(validationSuccess)
				{
				document.forms[0].action="./workStatus.do?workStage=Wexp&mode=save";
				document.forms[0].submit();
				}
			}
			function recalculateAggregateUptoPrevMonth(index,that)
			{
				var selectionExists=expMonthChanged(index,that);
				if(!selectionExists)
				{
					for(var i=1;i<<%=workCount%>;i++)
					{
						
						expYearChanged2(i)
						
					}
				}
				else
					alert("Selection Already Exists");
			}
			
		function expYearChanged2(index)
		{
		//alert(" in change2");
		var expYear=0;
		var expMonth=0;
		var rowCount=0;
		var expYearTmp=0;
		var expMonthTmp=0;
		var expTotal=0;
		var expFirst = parseInt(document.getElementById("WORKEXP_LIST[0].expMonthUp").value);
		progCode=parseInt(document.getElementById("WORKEXP_LIST["+index+"].progCode").value);
		//expYear=parseInt(document.getElementById("WORKEXP_LIST["+index+"].expYear").value);
		expMonth=parseInt(document.getElementById("WORKEXP_LIST["+index+"].expMonth").value);
		//rowCount=getCheckboxRemoveCount();
		
		//alert("first:"+expFirst);
			if(expMonth!="")
			{
				//for(var i=0;i<rowCount;i++)
				for(var i=0;i<<%=workCount%>;i++)
				{
					//expYearTmp=parseInt(document.getElementById("WORKEXP_LIST["+i+"].expYear").value);
					expMonthTmp=parseInt(document.getElementById("WORKEXP_LIST["+i+"].expMonth").value);
					progCodeTmp=parseInt(document.getElementById("WORKEXP_LIST["+i+"].progCode").value);
						//alert("in for");
						if((progCode==progCodeTmp)&& document.getElementById("WORKEXP_LIST["+i+"].expMonthDuring").value!="" )
						{
							//alert("in first if expMonth is "+expMonth+" and expMonthTmp is "+expMonthTmp);
							if(expMonth>3 && ( expMonthTmp<expMonth))
							{
							//alert("in 2nd if");
							expTotal=expTotal+parseFloat(document.getElementById("WORKEXP_LIST["+i+"].expMonthDuring").value);
							}
							//else if(expMonth<4 && (expMonthTmp>3 || (expMonthTmp<4&&expMonthTmp<expMonth)))
							else if(expMonth<4 && expMonthTmp<expMonth)
							{
							//alert("in else if");
							expTotal=expTotal+parseFloat(document.getElementById("WORKEXP_LIST["+i+"].expMonthDuring").value);
							}
							//alert("in first if expTotal="+expTotal);
						
						}
						
				}
				var totEx = (expTotal+expFirst);
				//alert("totex:"+totEx);
				if(isNaN(totEx))
				{
					totEx = '0';
				}
				//alert("totex1:"+totEx);
				document.getElementById("WORKEXP_LIST["+index+"].expMonthUp").value=totEx;
			}
		}
		function newFunction(index,that)
		{	
			var totExp = Number('0');
			var a;
			var totol;
			var selectionExists=expMonthChanged(index,that);
			if(!selectionExists)
			{
				for(var i=0;i<<%=workCount%>;i++)
				{
					expYearChanged2(i)
				}
			}
			else
				alert("Selection Already Exists");
			if(index==0)
			{
				if(that.value==1)
				{
					document.getElementById("WORKEXP_LIST["+index+"].expMonthUp").readOnly=true;
				}
				else
				{
					document.getElementById("WORKEXP_LIST["+index+"].expMonthUp").readOnly=false;
				}
			}
			else
			{
				for(var i=0;i<=index;i++)
				{
					document.getElementById("WORKEXP_LIST["+i+"].expMonthUp").readOnly=true;
				}
			}
			//getExpDetails1();
		}
		function reCalExp()
		{
		//alert("in reCalExp()");
			for(var j=1;j<<%=workCount%>;j++)
				{
					document.getElementById("WORKEXP_LIST["+j+"].expMonthUp").value=(parseFloat(document.getElementById("WORKEXP_LIST["+(j-1)+"].expMonthUp").value)+parseFloat(document.getElementById("WORKEXP_LIST["+(j-1)+"].expMonthDuring").value));
				}
		}
		function firstMakeEdit()
		{
			var count = <%=workCount%>;
			//alert(count);
			if(count==1)
			{
				document.getElementById("WORKEXP_LIST[0].expMonthUp").readOnly=false;
			}
			
		}
		function calTotExp()
		{
			var j = <%=workCount%>;
			var totalExpenditure=0;
			var totExp=0;
			var totExp1=0;
			for(var i=0;i<=<%=progCount%>;i++)
			{
				if(document.getElementById("progExp["+i+"].expUptoPrevYear").value!="")
					totalExpenditure=parseFloat(document.getElementById("progExp["+i+"].expUptoPrevYear").value);
			}
			if(j>0)
			{
				totExp1 = (parseFloat(document.getElementById("WORKEXP_LIST["+(j-1)+"].expMonthUp").value)+parseFloat(document.getElementById("WORKEXP_LIST["+(j-1)+"].expMonthDuring").value));
			}
			if(totExp1>0)
			{
				totExp = parseFloat(totalExpenditure)+parseFloat(totExp1);
							   document.forms[0].totalExp.value=totExp.toFixed(2);
			}
			else
			{	
			   document.forms[0].totalExp.value=totalExpenditure.toFixed(2);
			}
						
		}
	 		</script>
	 		

	 		