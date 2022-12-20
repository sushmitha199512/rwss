<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>


<LINK rel=stylesheet type=text/css href="/pred/resources/style/tablecss.css">
<script language="javascript">


function fnSave()
{
	if(confirm("Are you Confirm to Transfer Amount to Contractor ?"))
	{
		document.getElementById('fnSavve').value="Forwarding Wait...";
		document.forms[0].action="switch.do?prefix=/masters&page=/transferAmount.do?mode=save";
		document.forms[0].submit();
	}
}
function toggleColor(that)
{
if(that.style.color=="blue")
that.style.color="red";
else if(that.style.color=="red")
that.style.color="blue"

}

function readDSToken(){

	
	document.getElementById('content').style.display='block';
	
	var signdatabase64 = document.SmartCardReaderApplet.readCertificate();
	
	document.forms[0].certificate.value=signdatabase64;
	document.getElementById('content').style.display='none';
	document.forms[0].action="switch.do?prefix=/masters&page=/transferAmount.do?mode=verifyToken";
	document.forms[0].submit();
	
	
}



</script>
<html:form action="/transferAmount.do" method="post">
<html:hidden property="certificate"></html:hidden>
<div style="display:none">
<APPLET  code="nic.rws.verify.SmartCardReaderApplet.class"  NAME="SmartCardReaderApplet" archive="<rws:context page='/applet/SmartCardReaderApplet.jar'/>" width=500 height=500 MAYSCRIPT>  
  </APPLET>  
  </div>
  <div id="content" style="display:none" ><img src=<rws:context page='/images/processing.gif'/> alt="Loading Wait..." title="Loading Wait..."></div>


<table  id="rounded-corner"   >
<caption><font color="green"><b>Payment Dues-Forward to Bank (Contractor Wise)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font>&nbsp;&nbsp;&nbsp;<font color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Amount Displayed is in Rupees)</font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<rws:context page='/home.jsp'/>"> Home</a><b><font color="blue"></font></b></caption>
<thead>
    <tr><td colspan="9"><b><font color="red">*</font>Source Bank:</b>:<html:select property="sourceBankIfscCode"
							style="width:560px" styleClass="mycombo"
							>
							<html:option value=" ">
								<font class="myfontclr1">Select... </font>
							</html:option>
							<html:options collection="sourceBankDetails" property="value"
								labelProperty="label" />
						</html:select></td><td colspan="3"><b><font color="red">*</font>Available Grant:</b><html:text property="availableGrant"  readonly="true"></html:text></td></tr>
<tr>
    <th  scope="col" class="rounded-company"  align=left>Sl.No
	
	<th  class="rounded-foot-left" align=center>Transaction ID</th>
	<th  class="rounded-foot-left" align=center>Circle</th>
	<th  class="rounded-foot-left" align=center>Division</th>
	<th  class="rounded-foot-left" align=center>Contractor Name</th>
	<th  class="rounded-foot-left" align=center>Bank Name</th>
	<th  class="rounded-foot-left" align=center>Branch Name</th>
	<th  class="rounded-foot-left" align=center>IFSC Code</th>
	<th  class="rounded-foot-left" align=center>Account No</th>
	<th  class="rounded-foot-left" align=center>Central Share</th>
	<th  class="rounded-foot-left" align=center>Payment Type</th>
	<th  scope="col" class="rounded-q4">Remarks</th>
</tr>
</thead>
 <tfoot>
    	<tr>
        	<td colspan="11" class="rounded-foot-left"><em><font color="red"><b><bean:message key="app.nrdwprelatedfin"/>


        	


        	</b></font><BR>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
 <tbody>
<% int count=0;%>
<nested:iterate id="amtRecord" name="contractorTransfer" property="transfersList" indexId="index">
<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td   ><%=count %></td>

<td   class="bwborder" align=left>
<bean:write name="amtRecord" property="ftrNo" /></td>
<td   class="bwborder" align=left>
<bean:write name="amtRecord" property="circle" /></td>
<td  class="bwborder" align=left>
<bean:write name="amtRecord" property="division" /></td>
<td  class="bwborder" align=left>
<bean:write name="amtRecord" property="contractorName" /></td>




<td class="rptValue">&nbsp;<bean:write name="amtRecord" property="contractorBankName" /></td>
<td class="rptValue"  align=left>

<bean:write name="amtRecord" property="contractorBranchName" /></td>
<td  class="rptValue" align=left>
<bean:write name="amtRecord" property="contractorIFSCCode" /></td>

<td  class="rptValue" align=left>
<bean:write name="amtRecord" property="contractorACCNO" /></td>


<td  class="rptValue" align=left>
<bean:write name="amtRecord" property="transferAmount" /></td>
<td  class="rptValue" align=left>
<bean:write name="amtRecord" property="txType" /></td>
<td  class="rptValue" align=left>
<nested:textarea  indexed="true" name="amtRecord" property="remarks" ></nested:textarea></td>
</tr>
</nested:iterate>

<%
  if(count==0){
%>

<tr align="left"  onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  colspan="11" align="center" class="rounded-foot-left" > No Records</td>
</tr>
<%  } %>

<%if(count>=1){%>
		<tr>
			<td align="center" colspan="12">
			
			<logic:equal property="isSourcebankRegister" name="contractorTransfer"  value="no">
			<input type=button name="dsRead" value="Verify Sign" onclick="readDSToken()" disabled="true" class="btext">&nbsp;&nbsp;
			</logic:equal>
			<logic:equal property="isSourcebankRegister" name="contractorTransfer"  value="yes">
			<input type=button name="dsRead" value="Verify Sign" onclick="readDSToken()"  class="btext">&nbsp;&nbsp;
			</logic:equal>
			
				<input type=button name=getValues value="Close" onclick="fnClose()" class="btext">&nbsp;&nbsp;
			<logic:equal property="isDsValide" value="yes" name="contractorTransfer">
				<input type=button name=getValues value="Forward to Bank" onclick="fnSave()"  id=fnSavve class="btext">
				</logic:equal>
				<logic:equal property="isDsValide" value="no" name="contractorTransfer">
				<input type=button name=getValues value="Forward to Bank" onclick="fnSave()" disabled="true" id=fnSavve class="btext">
				</logic:equal>
			</td>
		</tr>
		<%}%>

</tbody>
</table>
<logic:equal property="isSourcebankRegister" name="contractorTransfer"  value="no">
<div><font color="red"><b>Error Message:</b>Source Bank Not Yet Register.</font></div>
</logic:equal>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

