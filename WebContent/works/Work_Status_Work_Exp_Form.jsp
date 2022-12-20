<%int progCount=-1; 
String month = (String)request.getAttribute("month");
String monthNo = (String)request.getAttribute("monthNo");
String cYear = (String)request.getAttribute("cYear");
//System.out.println("Month No:"+monthNo);
String adminCost = (String)request.getAttribute("adminCost");
//System.out.println("adminCost:"+adminCost);
int valButNotPaidCount = 0;
%>
<script language="javascript">
function getExpDetails()
{
	document.forms[0].weMode.value = "data";
	document.forms[0].action="/pred/works/WorkStatus.do";
	document.forms[0].submit();
}
</script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
 <body onload="valueButNotPaidOnload()">
<tr><td>
<img src="/pred/images/icoTip.gif" width="20" height="20" align="right" onmouseover="Tip('Expenditure Carried from Vouchers automatically',TITLE,'Note:')" onmouseout="UnTip()">
</td></tr>
 <tr>
 <td>
		<fieldset >
		<legend >Expenditure Details (In Rs.Lakhs)</legend>
		<label>
			<table  cellpadding="0" cellspacing="1" 
					    style="border-collapse:collapse">
			<logic:present name="PROGRAMS">
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
				<nested:text property="expUptoPrevYear" name="progExp" indexed="true" readonly="true" onkeyup="extractNumber2(this,10,2,false);getAggrigateExpenditure2()" onkeypress="return blockNonNumbers(this, event, true, false)" onmouseover="Tip('Select Previous Finanical Year then enter the expenditure details!!',TITLE,'')" onmouseout="UnTip()"/>
				<nested:hidden property="workid" name="progExp" indexed="true" />
				<nested:hidden property="progCode" name="progExp" indexed="true" />
				<nested:hidden property="progName" name="progExp" indexed="true" />		
				</td>
				</tr>
				</nested:iterate>
			</logic:present>
			
			
						<tr>
			<td class="mycombo"><b>Financial Year:(Financial Years Based on Year of Grounding)</b></font></td>
			<td>
			   <html:select property="expYears" style="width: 100px" styleClass="noborder-text-box" onchange="getExpDetails()">
					<logic:present name="AllYears">
					<%
					if(((java.util.ArrayList)request.getAttribute("AllYears")).size()>0)
					{
						for(int i=0;i<((java.util.ArrayList)request.getAttribute("AllYears")).size();i++)
					{ 
				 		String val=(String)((java.util.ArrayList)request.getAttribute("AllYears")).get(i);
					%>
					<html:option value="<%= val%>"><%=val%></html:option>
				    <%} 
					}
					%>
					</logic:present>
					</html:select>
					
				</td>
			</tr>
			
			</table>
			<table width="550" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse" align="center">
			
			<thead class="gridHeader">
			<html:hidden property="admSanDate"/>
			<tr >
			    <th colspan=2></th>
			    <th  colspan=4 align="center">Expenditure During The Selected Financial Year<BR>
			  	Expenditure shown in Lakhs</th>
				<thead class="gridHeader" >
			 	<th>S.NO.</th>
			 	<th>Programme</th>
				<th>Month</th>
			 	<th>Up to the Previous Month</th>
				<th>During The Month</th>
				<!-- <th>value of workdone but not paid</th> -->
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
									   style="width: 150px" styleClass="noborder-text-box">
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
			 	 var admDate=document.forms[0].elements["admSanDate"].value;
			 	 var values=admDate.split('/');
			 	 //alert(values);
			 	 var admnSancyear=values[2];
				 
				}
				</script>
				<td>
			 	
			 		<nested:select name="WORKEXP_LIST" property="expMonth" indexed="true" 
								   style="width: 100px" styleClass="noborder-text-box" disabled="true"> 
						<!-- onchange='<%= "javascript:expYearChanged2(\"+ndx+\");newFunction(\"+ndx+\",this)"%>' -->
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
								onkeyup='<%="javascript:extractNumber2(this,9,2,false);recalculateAggregateUptoPrevMonth(\"+ndx+\",this);getAggrigateExpenditure2()"%>' onkeypress="return blockNonNumbers(this, event, true, false)" readonly="true"/>
				</td>
				<td>
					<nested:text name="WORKEXP_LIST" property="expMonthDuring" indexed="true" maxlength="11"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeyup='<%="javascript:extractNumber2(this,9,2,false);getAggrigateExpenditure2();recalculateAggregateUptoPrevMonth(\"+ndx+\",this)"%>' onkeypress="return blockNonNumbers(this, event, true, false)" />
				</td>
	 
			</tr>
			</nested:iterate>
		 </logic:present>
			<input type="hidden" name="workCount" value="<%= workCount %>">
			<!-- <tr bgcolor="#ffffff">
			<td colspan=10 align=right>
			<input type="button" name="workCount" value="Add New" class="bText" onclick="addNewExp()" disabled/>
			<input type="button" name="workCount" value="Remove" class="bText" onclick="removeExp()" disabled/>
			</td>
			</tr> -->
			</tbody>
			</table>
			<fieldset>
			<legend >Aggregate Expenditure (In Rs.Lakhs)</legend>
			<label>
			
			<table width="67%" >
			<logic:present name="PROGRAMS">
				<nested:iterate id="progExp" name="PROGRAMS" indexId="ndx1">
				
				<tr>
			 	<td class="datefont"><b><bean:write name="progExp" property="progName"/></b></td>
				<td >
				<html:text property="aggrigateExpenditureForProg"  readonly="true"/>
				</td>
				</tr>
				</nested:iterate>
			</logic:present>
			<tr border=0>
		 	<td class="textborder"  ><b>Total Expenditure </b></font> </td>
			<td >
			<html:text property="totalExp" readonly="true"/>
			</td>
			</tr>

			<logic:present name="valueBut">
				<nested:iterate id="valButNotPaid" name="valueBut" indexId="ndx1">
				<%valButNotPaidCount++;%>
				<tr>
			 	<td class="datefont"><b>Value of Work Done But Not Paid( <bean:write name="valButNotPaid" property="progName"/>)</b></td>
				<td >
				<html:text property="valueOFWorkDoneButnotPaid" name="valButNotPaid" onkeyup="extractNumber2(this,9,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)" />
				</td>
				</tr>
				</nested:iterate>
			</logic:present>

			
			</table>
			</label></fieldset>
						
	 		</td></tr>
<%@ include file="/commons/rws_alert.jsp"%>	 			 		