<tr>
		<td>
		<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>Administrative Sanction (Amount In Rs.Lakhs)</b></font></legend>
<label>
		<table name=disptable border=0>
 		<tr>
		 <td width="180"><font face=verdana size=2><b>Sanctioned Amount</b></td>
		<td width="180"><html:text property="sanAmt"  style="width:80px" readonly="true" /></td>
		<td width="160"><font face=verdana size=2><b>Admin Sanction Date</b></td>
		<td width="180"><html:text property="admSanDate" readonly="true"   /></td>
	 	</tr>
 		<tr>
		<td width="180" rowspan=1><font face=verdana size=2><b>Admin Sanction No</b></td>
		<td width="150"><html:text property="admSanNo" style="width:175px"  readonly="true" /></td>
		<td colspan=2 rowspan=3>
		<!-- code added -->
		<fieldset>
		<legend><font color=#871D0E face=verdana size=2><b>Population Benefited(AS Per Census)</b></font></legend>
		<label>
		<table width="100%">
 		<tr>
 		<td>		
		<tr>
		 <td ><font face=verdana size=2><b>Plain</b> </font></td>
		 <td><html:text property="plainPop" readonly="true"  /> </td>
		</tr>
		<tr>
		 <td><font face=verdana size=2><b>SC</b> &nbsp;&nbsp;</font></td>
		 <td><html:text property="scPop"  readonly="true"  /> </td>
		</tr>
		<tr> 
		 <td><font face=verdana size=2><b>ST</b> &nbsp;&nbsp;</font></td>
	     <td><html:text property="stPop" readonly="true"/></td>
		</tr>
		<tr> 
		 <td><font face=verdana size=2><b>Total</b> &nbsp;&nbsp;</font></td>
	     <td><html:text property="totPop" readonly="true"/></td>
		</tr>
 	    </table>
		</label>
		</fieldset>
		</td>
		</tr>
		<!-- end -->
		</td>
		</tr>
	 	<tr>
		<td  colspan=1>
 		<font face=verdana size=2 ><b>Habitations Benefited(No)</b></td>
		<td  align=left><html:text property="habsBen"  style="width:175px" readonly="true"  /></td>
		</tr>
		<tr>
		<td width="160"><font face=verdana size=2><b>Habitation Names</b></td>
		<td width="150" align=right><html:textarea property="habNames"  style="height:70px;width:175px"   /></td>
		</tr>
	 	</td>
 		</tr>
		<tr>
 	 </tr>
		</table>
		</label>
		</fieldset>
		<tr>
		<td >
		
		</td>
		</tr>
		<script>
		function hiderev()
		{
		 
		}
		function hideAdminRev()
		{
		var revNo=document.getElementById('revAdmSanc').value;
		 	if(revNo=='')
			{
			 document.getElementById('RevisedDetails').style.display='none';
			}
		}
		</script>
		<tr id="RevisedDetails">
		<td>
		<fieldset>
<legend ><font color=#871D0E face=verdana size=2><b>Revised Administrative Sanction (Amount In Rs.Lakhs)</b></font></legend>
<label>
		<table  border=0>
		<tr>
		<td width="180"><font face=verdana size=2><b>Revised Admin Sanction No</b></td>
		<td width="160"><html:text property="revAdmSanc"  style="width:175px"  /></td>
		<td width="180"><font face=verdana size=2><b>Revised Admin Sanction Date</b></td>
		<td width="160"><html:text property="revAdmSancDate"  /></td>
		
		</tr>
		<tr>
		<td width="180"><font face=verdana size=2><b>Revised Sanction Amount</b></td>
		<td width="160"><html:text property="revSanAmt"  style="width:175px" /></td>
		<td width="180"><font face=verdana size=2><b>Habitations Benefited(No)</b></td>
		<td width="160"><html:text property="revHabsBen"    /></td>
		</tr>
		<tr>
	 	<td width="160" height="20px" valign="center"><font face=verdana size=2><b>Habitation Names</b></td>
		<td width="150"  ><html:textarea property="revHabNames" style="height:70px;width:175px"  /></td>
		
		<td colspan=2 rowspan=2>
		<!-- code added -->
		<fieldset>
		<legend><font color=#871D0E face=verdana size=2><b>Population Benefited(AS Per Census)</b></font></legend>
		<label>
		<table width="100%">
 		<tr>
 		<td>		
		<tr>
		 <td ><font face=verdana size=2><b>Plain</b> </font></td>
		 <td><html:text property="raPlainPop" readonly="true"  /> </td>
		</tr>
		<tr>
		 <td><font face=verdana size=2><b>SC</b> &nbsp;&nbsp;</font></td>
		 <td><html:text property="raScPop"  readonly="true"  /> </td>
		</tr>
		<tr> 
		 <td><font face=verdana size=2><b>ST</b> &nbsp;&nbsp;</font></td>
	     <td><html:text property="raStPop" readonly="true"/></td>
		</tr>
		<tr> 
		 <td><font face=verdana size=2><b>Total</b> &nbsp;&nbsp;</font></td>
	     <td><html:text property="raTotPop" readonly="true"/></td>
		</tr>
 	    </table>
		</label>
		</fieldset>
		</td>
		</tr>
		<tr><td height="5px"></td></tr>
		 
		</td>
		
		</tr>
		
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
