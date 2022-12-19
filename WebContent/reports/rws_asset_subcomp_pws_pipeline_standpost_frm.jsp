<TD  valign=top height=20% align="center" width="30%">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Stand Post Sub Component Details</font>
			</td>
			</tr>	
		</table>
<div  style="position:relative;overflow-y:auto;left:0;height:200;width:100%;top:0;">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=100%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
		<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="ASSET_NAME,Asset Name" disabled checked></td><td class = btext>Asset Name
			</td>
		<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch"  id="ck" value="PANCH_NAME,Habitation" disabled checked></td><td class = btext>Habitation
			</td>
		<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SP_NO,'0'),No. of Public SP Existing"></td><td class = btext>No. of Public Stand Posts Existing</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PC_RF,'--'),Rural Feeder"></td><td class = btext>Rural Feeder
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PC_UF,'0'),Urban Feeder"></td><td class = btext>Urban Feeder
			</td> </tr>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PC_HRS,'0'),Hrs of Power Avail Per Day"></td><td class = btext>Hours of Power Availability Per Day
			</td>
			
			
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PC_SUG,'--'),Suggestions"></td><td class = btext>Suggestions
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PC_COST,'0'), Cost"></td><td class = btext>Cost
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HC_NO,'0'),No.of Pvt House Conns  "></td><td class = btext> No.of Private House Connections
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PC_UF,'--'),Urban Feeder"></td>
				<td class = btext>Urban Feeder</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(PC_LV,'Y','Yes','N','No'),'--'),Low Voltage Problems  "></td><td class = btext> Low Voltage Problems
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PC_FEA,'--'),Feas.Of Getting Urban Line"></td><td class = btext>Feasability Of Getting Urban Line  
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PC_DIS,'0'),Distance"></td><td class = btext>Distance  
			</td>

			
	</table>
	</div>
		<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
			<tr>
					<td width="100%" colspan="2" align="center" class = btext nowrap>
					<A HREF="javascript:checkAll('ch','ck')">checkAll Fields</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<A HREF="javascript:clearAll('ch','ck')">clearAll Fields</A>
				</td>
			</tr>	
		</table>


