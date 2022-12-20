<TD  valign=top height=15% align="center" width="30%">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Cisterns Sub Component Details</font>
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
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CIS_NO,'0'),Cistern No"></td><td class = btext>Cistern No
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CIS_LOC,'0'),Location"></td><td class = btext>Location  
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CIS_CAP_LTS,'0'),Capacity (in Lts)"></td><td class = btext>Capacity in Lts
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CIS_COND,'--'),Condition"></td><td class = btext>Condition
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CIS_FILL,'Y','Yes','N','No'),'--'),Fill"></td><td class = btext>Fill
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CIS_MOD_FILL,'--'),Mode of Filling HT"></td><td class = btext>Mode of Filling
			</td>
			
			
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CIS_USE,'Y','Yes','N','No'),'--'),Used"></td><td class = btext>Used
			</td>
			<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CIS_PF,'Y','Yes','N','No'),'--'),Platform"></td><td class = btext >Platform
			</td>
			<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CIS_PF_CON,'G','Good','B','Bad'),'--'),Platform Condition"></td><td class = btext >Platform Condition
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(Decode(CIS_DRAIN,'Y','Yes','N','No'),'--'),Drain"></td>
				<td class = btext>Drain </td>
				<tr>
				<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CIS_TAP,'0'),Taps"></td><td class = btext>Taps
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CIS_TAP_COND,'--'),Tap Condition"></td><td class = btext>Tap Condition
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CIS_HR,'0'),No.of Hours"></td><td class = btext>No.of Hours
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


