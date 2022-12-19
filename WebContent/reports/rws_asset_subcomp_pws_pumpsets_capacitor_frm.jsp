<TD  valign=top height=20% align="center" width="30%">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Capacitor Sub Component Details</font>
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
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_EXES,'Y','Yes','N','No'),'--'),Capacitor Existing"></td><td class = btext>Capacitor Existing
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_COND,'W','Working','Not Working'),'--'),Condition"></td><td class = btext>Condition
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_CAP,'P','Providing','N','Not Providing'),'--'),Capacitors"></td><td class = btext>Capacitors
			</td>
			
			
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_CAP_CON,'W','Working','Not Working'),'--'),Connected Capcitors"></td><td class = btext>Connected Capcitors
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_MS,'Y', 'Yes', 'N','No'),'--'), Main Switch"></td><td class = btext> Main Switch
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_PL,'Y','Yes','N','No'),'--'),Pilot lamps"></td><td class = btext>Pilot lamps
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_CUT,'Y','Yes','N','No'),'--'),Cutouts"></td>
				<td class = btext>Cutouts	</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_PP,'Y','Yes','N','No'),'--'),Phasing preventor"></td><td class = btext> Phasing preventor
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_VM,'Y','Yes','N','No'),'--'),Volt Meter "></td><td class = btext>Volt Meter 
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_AM,'Y','Yes','N','No'),'--'), Ammeter"></td><td class = btext> Ammeter   
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_STA,'Y','Yes','N','No'),'--'), Starter"></td><td class = btext> Starter   
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CP_MS1,'--'), MS/Wooden Cary Box    "></td><td class = btext> MS/Wooden Cary Box       
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(CP_SB,'P','Providing','N','Not Providing'),'--'),Earthing to S.B "></td>
				<td class = btext> Earthing to S.B    
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


