<style type="text/css">
div#tbl-container2 {
width: 840px;
height: 430px;
overflow: scroll;
}

div#tbl-container2 table th {
text-align:center;
width: 100px;
}
</style>
<c:set var="adminAmnt" value="${WorkForm.samount}" scope="request"/>
<%String adminAmnt = (String)request.getAttribute("adminAmnt");
long sancAmt = (new Double(Double.parseDouble(adminAmnt)*100000)).longValue();
%>
<c:set var="revAdminAmnt" value="${WorkForm.revAdminAmnt}" scope="request"/>
<%String revAdminAmnt = (String)request.getAttribute("revAdminAmnt");
long revSancAmnt = 0;
if(revAdminAmnt!=null && (!revAdminAmnt.equals("") && !revAdminAmnt.equals("0")))
{
	revSancAmnt  = (new Double(Double.parseDouble(revAdminAmnt)*100000)).longValue();
	sancAmt = revSancAmnt;
}
//System.out.println("revSancAmnt"+revSancAmnt);

long billRaisedAmt = 0;
if(request.getAttribute("billRaisedAmt")!=null && !request.getAttribute("billRaisedAmt").equals(""))
billRaisedAmt = Long.parseLong((String)request.getAttribute("billRaisedAmt"));

//added by swapna on 4-11-2011 for checking the achievement amount
long billContractorAmt = 0;
if(request.getAttribute("billContractorAmt")!=null && !request.getAttribute("billContractorAmt").equals(""))
billContractorAmt = Long.parseLong((String)request.getAttribute("billContractorAmt"));
//


////Added By anu for Refund Amount,PartAamount,NetBillAmount on 09042015/////

long refundAmount = 0,spillamount=0;
if(request.getAttribute("refundAmount")!=null && !request.getAttribute("refundAmount").equals(""))
refundAmount = Long.parseLong(request.getAttribute("refundAmount").toString());
//System.out.println("refundAmount in workstatus jspp"+refundAmount);




long partAamount=Long.parseLong(request.getAttribute("partAamount").toString());
//System.out.println("partAamount"+partAamount);


if(request.getAttribute("spillamount")!=null && !request.getAttribute("spillamount").equals(""))
	spillamount = Long.parseLong(request.getAttribute("spillamount").toString());


System.out.println("spillamount"+spillamount);


long netbillamount=(billRaisedAmt+partAamount)-(refundAmount+spillamount);

//System.out.println("netbillamount in jsp"+netbillamount);


long billrisedsofar=billContractorAmt+partAamount;
/////////Completed///////////////

%> 
<% int workInProgressCount=0;%>
<tr>
		<td>
		<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>Work in Progress</b></font></legend>
<label>
		 <table cellpadding="4" cellspacing="4" border="0"    
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;">
		 
 	<tr>
		<td width="190" valign="bottom"><font face=verdana size=2><b>SubDivision Assigned to</b></td>
		<td width="150" valign="bottom"><html:select property="subDivAssign" style="width:183px"  styleClass="noborder-text-box" >
		<logic:present name="subDivisions">
	 	<html:options collection="subDivisions"  name="labelValueBean" 
								property="value" labelProperty="label"/>	</logic:present>
	 		</html:select></td>
		<td rowspan=3>
		<fieldset>
		<legend><font color=#871D0E face=verdana size=2><b>Engineers Assigned to</b></font></legend>
		<label>
		<table>			
		<tr>
		<td>1.&nbsp;<html:select property="engineerAssign" style="width: 400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr><tr>
		<td>2.&nbsp;<html:select property="engineerAssign1" style="width: 400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr>
		<tr>
		<td>3.&nbsp;<html:select property="engineerAssign2" style="width:400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr><tr>
		<td>4.&nbsp;<html:select property="engineerAssign3" style="width: 400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr>
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		<tr>
		<td width="180" valign="top"><font face=verdana size=2><b>Work Start Date</b><font color="#FF6666">*</font></td>
		<td width="190" valign="top"><html:text property="workGndDate" style="width:145" styleClass="mytext" />
		<a href="javascript: showCalendar(document.forms[0].workGndDate);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
			</a>
		</td>
		</tr>
		<tr class="textborder">
		<%
			if(revAdminAmnt==null || (revAdminAmnt!=null && (revAdminAmnt.equals("") || revAdminAmnt.equals("0")))){%>
			<td>Total Estimate Cost:</td>
	  		<td><font face=verdana size=2 color=red><%=sancAmt%> Rs.</td>
			
			<%}
			else
			{%><td>Total Estimate Cost:(Revised)</td>
	  		<td><font face=verdana size=2 color=red><%=revSancAmnt%> Rs.</td>
			<%}%>
			</tr>

<tr class="textborder">
<td>Part-A Sanction Amount:</td>
	  		<td> <html:text property="partASanAMount" readonly="true"></html:text><font color="red" face="verdana">*(In Rupees)</font></td>
	  		<td>Physical Status: <select name="pstatus" ><option value="0">0%</option><option value="0">0-25%</option><option value="0">25-50%</option><option value="0">50-75%</option>
	  		<option value="0">75-100%</option>
	  		<option value="100">100%</option>
	  		</select></td>
	  			
</tr>
			<tr class="textborder">
				<td>Bills Raised So far:</td>
				<td><font face=verdana size=2 color=red><%=billrisedsofar%> Rs.</td>
		<!-- Added by Anu For Refund Amount,netBill Amount -->	
				<td>Refund Amount:&nbsp;&nbsp;<font face=verdana size=2 color=red><%=refundAmount%> Rs.</td>			
			</tr>
			
			
				<tr class="textborder">
				<td>Net Bill Amount:</td>
				<td><font face=verdana size=2 color=red><%=netbillamount%> Rs.</td>	
				
				
				<td>Spill Refund Amount:&nbsp;
				<font face=verdana size=2 color=red><%=spillamount%> Rs.</td>	
			</tr>
			
			<!-- Completed -->
			
			
			 <!-- <tr class="textborder">
				<td>Acheivement So far:</td>
				<td id="totAch"></td>			
			</tr> 

	<tr class="textborder">
				<td>Yet To be Raised:</td>
				<td id="totBal"></td>			
			</tr>  -->



		</table>
		</label>
		</fieldset>
		 </td>
		</tr> 
		<tr>
	<td>
<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>Work MileStones</b></legend>
	<label>
	<div id="tbl-container2">
			<table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			<!-- <thead class="gridHeader"> -->
			<tr>
				<td colspan="6" align="center"><font face=verdana size=2><b>MileStone(s) Details</td>
				<td colspan="4" align="center"><font face=verdana size=2><b>Target Details</td>
				<td colspan="6" align="center"><font face=verdana size=2><b>Achievement Details</td>
			</tr>
			<tr  bgcolor="#8A9FCD">
				<td align="center"><font face=verdana size=1><b>Mile<BR>Stone<br>S.No.</b></font></td>
				<td align="center"><font face=verdana size=1><b>Type<BR>Of<BR>Contractor</b></font></td>
				<td align="center"><font face=verdana size=1><b>Major <BR>Mile<BR>Stone</b></font></td>
				<td align="center"><font face=verdana size=1><b>Mile Stone<br>(Major Component)</b></font></td>
				<td align="center"><font face=verdana size=1><b>Stage <br>(Type of Item)</b></font></td>
				<td align="center"><font face=verdana size=1><b>No of Items/<BR>Compo<BR>nents</b></font></td>
				<td align="center"><font face=verdana size=1><b>Target<BR> Date</b></font></td>
				<td align="center"><font face=verdana size=1><b>Revised<BR>Target<BR> Date</b></font></td>
				<td align="center"><font face=verdana size=1><b>Agreement value of the<BR>Item to be executed <BR>in the Mile stone<BR>(in Rs.)</b></font></td>
				<td align="center"><font face=verdana size=1><b>Agreement value of the<BR>Item to be executed <BR>in the Mile stone<BR>(in %)</b></font></td>
				<td align="center"><font face=verdana size=1><b>Quantity <BR>executed <font color="white" face=verdana>SO FAR</font><font face=verdana size=1><b> i.e <BR>No of Items<BR>/Length in Mts etc.,</font><span class="mandatory">*</span></th>
				<td align="center"><font face=verdana size=1><b>Achievement Date<span class="mandatory">*</span></b></font></td> 
				<td align="center"><font face=verdana size=1><b>Value of Work <br>Done of the item<span class="mandatory">*</span><BR><font color="white" face=verdana>*(In Rupees)</font></td>
				<td align="center"><font face=verdana size=1><b>Value of Work <br>Done of the item<BR> in (%)<BR></td>
				<td align="center"><font face=verdana size=1><b>Status<span class="mandatory">*</span></b></font></td>
				<td align="center"><font face=verdana size=1><b>Remarks</b></font></td>
				<!-- <td align="center"><font face=verdana size=1><b>Vouchers</b></font></td> -->
			</tr>
			
 			   <% workInProgressCount=0;%>
				<nested:iterate id="WORK" property="mileStones" indexId="ndx">
			 	  <%workInProgressCount++;%>
			 	  <tr bgcolor="#ffffff">
				<td>
 					<nested:text name="WORK" property="mileStoneSno" indexed="true" style="width: 20px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
 					<nested:text name="WORK" property="typeOfContractor" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
 					<nested:text name="WORK" property="majorMileStone" indexed="true" style="width: 20px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="mstoneName" indexed="true" style="width: 80px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="mstoneStageName" indexed="true" style="width: 80px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="compInNo" indexed="true" style="width: 30px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="targetDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
 					<nested:text name="WORK" property="eoatTargetDate" indexed="true" style="width: 60px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="perCompInWorkValue" indexed="true" style="width:70px" styleClass="noborder-text-box" readonly="true" />
				</td>
				<td>
					<nested:text name="WORK" property="perCompInWork" indexed="true" style="width:45px" styleClass="noborder-text-box" readonly="true" />
				</td>

					<nested:equal  name="WORK" property="mileStoneProgress" value="4">	
					<td>
						<nested:text name="WORK" property="compInNoAch" indexed="true" style="width: 70px"  onkeypress="return numeralsOnly()" maxlength="6" styleClass="noborder-text-box" readonly="true"/>
					</td>
					<td nowrap>
						<nested:text name="WORK" property="achievementDate" indexed="true"  style="width: 57px" styleClass="noborder-text-box" readonly="true"/>
					</td>
					<td>
						<nested:text name="WORK" property="perCompValue" indexed="true" 
									 style="width: 60px;" styleClass="noborder-text-box" readonly="true"/>
					</td>
					<td>
						<nested:text name="WORK" property="percentComp" indexed="true" style="width: 40px" styleClass="noborder-text-box" readonly="true"/>
					</td>
					<td nowrap>
						<logic:equal name="RWS_USER" property="userId" value="100000">
							<nested:select name="WORK" property="mileStoneProgress" indexed="true" style="width: 100px" styleClass="noborder-text-box">
								<html:option value="1">Not Started</html:option>
								<html:option value="2">In Progress</html:option>
								<html:option value="3">Phy. Completed</html:option>
								<html:option value="4">Fin. Completed</html:option>
						</nested:select>
						</logic:equal>
						<logic:notEqual name="RWS_USER" property="userId" value="100000">
							<nested:hidden name="WORK" property="mileStoneProgress" indexed="true" value="4"/>
							<font face=verdana size=1px>Fin. Completed</font>
						</logic:notEqual>
					</td>
				</nested:equal >
				<nested:notEqual  name="WORK" property="mileStoneProgress" value="4">
					<td>
						<nested:text name="WORK" property="compInNoAch" indexed="true" style="width: 70px"  onkeypress="return numeralsOnly()" maxlength="6" styleClass="noborder-text-box"/>
					</td>
					<td nowrap>
						<nested:text name="WORK" property="achievementDate" indexed="true"  style="width: 57px" styleClass="noborder-text-box" readonly="false"/>
					<a href="javascript:showCalendar(document.forms[0].elements['WORK[<%=workInProgressCount-1%>].achievementDate']);">
						 <IMG SRC="<rws:context page='/images/calendar.gif'/>"   border="0" height="17" ></a>
					</td>
					<td>
						<nested:text name="WORK" property="perCompValue" indexed="true" 
									 style="width: 60px;" styleClass="noborder-text-box" maxlength="15"  onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" onkeyup='<%= "javascript: calPer("+ndx+")"%>'/>
					</td>
					<td>
						<nested:text name="WORK" property="percentComp" indexed="true" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" maxlength="5" style="width: 40px" styleClass="noborder-text-box" readonly="true"/>
					</td>
					<td>
						<nested:select name="WORK" property="mileStoneProgress" indexed="true" style="width: 100px" styleClass="noborder-text-box">
							<html:option value="1">Not Started</html:option>
							<html:option value="2">In Progress</html:option>
							<html:option value="3">Phy. Completed</html:option>
							<html:option value="4">Fin. Completed</html:option>
						</nested:select>
					</td>
				</nested:notEqual >
				<td>
					<nested:textarea name="WORK" property="mileRemarks" indexed="true" style="width: 80px"  cols="5" styleClass="noborder-text-box" />
				</td>
				<nested:hidden name="WORK"  indexed="true"  property="mstoneCode"/>
				<nested:hidden name="WORK"  indexed="true"  property="mstoneStageCode"/>
				</tr>
				</nested:iterate>
				</table>
				</div>
				</label>
				
			</fieldset>
			
			 </td> 
			</tr>
		 		 <html:hidden property="revflag"/>
		 		 <html:hidden property="agreeDate"/>
				 <html:hidden property="tsDate"/>
				 <%java.util.Date d=new java.util.Date();
		java.text.SimpleDateFormat format=new java.text.SimpleDateFormat("dd/MM/yyyy"); 
		String currentDate=format.format(d);%>
		<input type="hidden"  name="cDate"    value='<%=currentDate%>'/>
		<tr> 
		<td colspan=16 align="center"> 
		<%
		if((physicalStatuss.equals("Financially Completed")|| !workCancelleddDate.equals("")) && (session.getAttribute("contractorStatus")!=null && session.getAttribute("contractorStatus").equals("yes")))
        {
		%>
		 			<input type="button" name="text1" value="Save" class="bText" onclick="saveProgramschedule()" disabled/>
		 			<input type="button" name="text1" value="Delete" class="bText" onclick="deleteProgramschedule()" disabled/>
		<%
		}
		else
		{
			if(request.getAttribute("openStatus")!=null && request.getAttribute("openStatus")!="" && request.getAttribute("openStatus").equals("N"))
	        {
		%>
 			<input type="button" name="text1" value="Save" class="bText" onclick="saveProgramschedule()" disabled/>
 			<input type="button" name="text1" value="Delete" class="bText" onclick="deleteProgramschedule()" />
		<%
	        }
			else{
				%>
	 			<input type="button" name="text1" value="Save" class="bText" onclick="saveProgramschedule()"/>
	 			<input type="button" name="text1" value="Delete" class="bText" onclick="deleteProgramschedule()"/>
			<%
			}
		}
		%>
		</td>
		</tr>
		<tr align=center><td colspan=16 align="center"> <INPUT type="button" name="voucher" value='View All Vouchers' class="btext" onClick='openVoucher(<bean:write name="WorkForm" property="workId"/>)'></td></tr>
				
		 <script language="javascript">
		function validateWorkInProgressForm()
		{
		var frm=document.forms[0];
		var startDate=frm.workGndDate.value;
		var validationPassed=true;
      // alert("In");
			var totAch = 0;
			var sancAmt = '<%=sancAmt%>';
			//alert("sancAmt"+sancAmt);
			for(var j=0;j<<%=workInProgressCount%>;j++)
			{
				totAch = totAch + parseFloat(document.forms[0].elements["WORK["+j+"].perCompValue"].value);
				//alert("totAch"+totAch);
			}

var partASanAMount=document.forms[0].elements["partASanAMount"].value;
//alert("partASanAMount"+partASanAMount);

var value1=parseFloat(sancAmt)-parseFloat(partASanAMount);
     if(parseFloat(totAch)>value1){
		alert("Total Acheivement Amount Should not exceed to (Sanction + Part A Sanction)");
validationPassed=false;
return;
        }

			for(var i=0;i<<%=workInProgressCount%>&&validationPassed;i++)
			{
				if(validationPassed==false)
				{
					break;
				}
				var achievementDate=document.forms[0].elements["WORK["+i+"].achievementDate"].value;
				var typeOfContractor=document.forms[0].elements["WORK["+i+"].typeOfContractor"].value;
				var targetDate=document.forms[0].elements["WORK["+i+"].targetDate"].value;

				if(startDate!="" && achievementDate!="" && typeOfContractor!="Spill Over")
				{
					var res=compareDates(achievementDate, startDate);
					var res1 = compareDates(achievementDate, targetDate);
					var val = document.forms[0].elements["WORK["+i+"].mileStoneSno"].value;
					if(res<0)
					{
						alert("Achievement Date for MileStone with S.No."+val+"\nshould be greater than or equal to Start Date");
						validationPassed=false;
					}
					else if(document.forms[0].elements["WORK["+i+"].perCompValue"].value=="")
					{
						alert("Please Enter % Achieved in MileStone with S.No."+val);
						document.forms[0].elements["WORK["+i+"].perCompValue"].focus();
						validationPassed=false;
					}
					
				}
				
				
				if(document.forms[0].elements["WORK["+i+"].percentComp"].value!="" || document.forms[0].elements["WORK["+i+"].achievementDate"].value!="")
				{
					if(document.forms[0].elements["WORK["+i+"].mileStoneProgress"].value=="")
					{
						alert("Please Select Status for Sl.No."+document.forms[0].elements["WORK["+i+"].mileStoneSno"].value);
						validationPassed=false;
					}
					else if(document.forms[0].elements["WORK["+i+"].mileStoneProgress"].value=="1")
					{
						alert("You cannot Select Status 'NOT STARTED' for Sl.No."+document.forms[0].elements["WORK["+i+"].mileStoneSno"].value);
						validationPassed=false;
					}
				}
			}
          
			         
		return validationPassed;
		}
		
		function saveProgramschedule()
		{
			//alert("sss");
  			if(document.forms[0].workGndDate.value=="")
			{
				alert("Enter Work Start Date");
			}
			else
			{
			
				dt1=getDateObject(document.forms[0].cDate.value,"/");
				dt2=getDateObject(document.forms[0].workGndDate.value,"/");
				if(dt1<dt2){
					validationPassed=false;
					alert("Actual Date Of Completion should not be \ngreater than to Current Date("+document.forms[0].cDate.value+")");
				}
				else
				{
					dt1=getDateObject(document.forms[0].tsDate.value,"/");
					dt2=getDateObject(document.forms[0].workGndDate.value,"/");
					if(dt1>dt2)
						alert("Work Start Date should be greater than or equal Technical Sanction Date("+document.forms[0].tsDate.value+")");
					else
					{
						
						var validationPassed=validateWorkInProgressForm();
						
						if(validationPassed)
						{	
							if(checkExcess()){
								
							var url = "switch.do?prefix=/works&page=/WorkStatus.do&psMode=save&revflag=saveWip";
							document.forms[0].action = url;
							document.forms[0].submit();
							}
						}	
					}
				}
			}
		}
		function deleteProgramschedule()
		{
			document.forms[0].psMode.value="delete";		
			document.forms[0].revflag.value="deleteWip";
			document.forms[0].submit();
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
			dtObject=new Date(cYear,cMonth,cDate);	
			return dtObject;
		}
		function openVoucher(workId)
		{
			var zURL = "./reports/rws_work_voucher_issued_rpt.jsp?workid="+document.forms[0].elements["workId"].value;
			var popFeatures = "width=695,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
			myWin = window.open(zURL,'habs',popFeatures);
			myWin.focus();
		}
		function checkExcess()
		{
			
			var totAch = 0;
		
			for(var j=0;j<<%=workInProgressCount%>;j++)
			{
				if(document.forms[0].elements["WORK["+j+"].perCompValue"].value!=""){
					totAch = totAch + parseFloat(document.forms[0].elements["WORK["+j+"].perCompValue"].value);}
				
			}
			
			if(isNaN(totAch))totAch=0;
			
			//document.getElementById("totAch").innerHTML = "<font face=verdana size=2 color=red>"+totAch+" Rs.";
			
			//alert("ttooooooooooo22222@@@@@"+document.getElementById("totAch").innerHTML);
			var sancAmt = '<%=sancAmt%>';
			
			//document.getElementById("totBal").innerHTML = "<font face=verdana size=2 color=red>"+(parseFloat(sancAmt)-parseFloat(totAch))+" Rs.";
			
			//alert("ttoooooooooooooo33333333333"+document.getElementById("totBal").innerHTML);
			var billRaisedAmt = '<%=billRaisedAmt%>';
			//alert(billRaisedAmt);alert(totAch);alert(sancAmt);
			///Added By Anu on net bill Amount////
             var netbillamount='<%=netbillamount%>';
            
             var partASanAMount=document.forms[0].elements["partASanAMount"].value;
            // alert("netbillamount"+netbillamount);
            // alert("partASanAMount"+partASanAMount);
            // alert("totAch"+totAch);
       
         var totpartA=(parseFloat(totAch)+parseFloat(partASanAMount));
         
        // alert("totparta"+totpartA);
		//	if(parseFloat(billRaisedAmt)>parseFloat(totAch)) ////comented By Anu for Checking Tot Acheivement with Net Bill AMount
			if(parseFloat(netbillamount)>parseFloat(totpartA))
			{
				alert("Total Achievement of all Items(Rs."+totpartA+") should be Greater than or equal to  Total Bill Raised Amount(Rs."+netbillamount+")");
			return false;
			}
				//added by swapna on 4-11-2011 for checking achievement amount//commented on 29-12-2011
			var billContractorAmt = '<%=billContractorAmt%>';
			
			///Added By Anu on net bill Amount on 09042015////
            var netbillamount='<%=netbillamount%>';
           
			
         ////////
		//	if(parseFloat(totAch)<parseFloat(billContractorAmt)) ////comented By Anu for Checking Tot Acheivement with Net Bill AMount
			if(parseFloat(totpartA)<parseFloat(netbillamount))
			{
			alert("Total Achievement+partAamount of all Items(Rs."+totpartA+") should not be Less than Total Bill Raised Achievement Amount(Rs."+netbillamount+")");
		return false;
			}
			//
			if(parseFloat(sancAmt)<parseFloat(totpartA))
			{
				alert("Total Achievement of all Items(Rs."+totpartA+") should be Less than or equal to  Total Estimate Cost(Rs."+sancAmt+")");
				return false;
			}
			return true;
		}
		function calPer(i)
		{
			//if(checkExcess())
			//{
				var value = document.forms[0].elements["WORK["+i+"].perCompValue"].value;
				var finVal = parseFloat(parseFloat(parseFloat(value)/parseFloat(sancAmt))*100);
				if(isNaN(finVal))finVal = 0;
				document.forms[0].elements["WORK["+i+"].percentComp"].value = finVal.toFixed(4);
			//}
		}
			var totAch = 0;
			var sancAmt = '<%=sancAmt%>';
			for(var j=0;j<<%=workInProgressCount%>;j++)
			{
				totAch = totAch + parseFloat(document.forms[0].elements["WORK["+j+"].perCompValue"].value);
			}
			//alert(totAch);
			if(isNaN(totAch))totAch=0;
			document.forms[0].elements["totAch"].innerHTML = "<font face=verdana size=2 color=red>"+totAch+" Rs.";
            var partASanAMount=document.forms[0].elements["partASanAMount"].value;
			document.forms[0].elements["totBal"].innerHTML = "<font face=verdana size=2 color=red>"+(parseFloat(sancAmt)-(parseFloat(totAch)+parseFloat(partASanAMount)))+" Rs.";
</script>
<%@ include file="/commons/rws_alert.jsp"%>