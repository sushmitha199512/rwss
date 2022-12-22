<TD  valign=top height=20% align="center" width="30%">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Bore Well Sub Component Details</font>
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
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="NVL(ac.LOCATION,'--'),Location"></td> <td class = btext>Location
			</td>
		<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="NVL(drill_year,'--'),Drill Year"></td> <td class = btext>Drill Year
			</td>
		<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="NVL(diameter,'0'),Diameter"></td><td class = btext>Diameter
			</td>
		<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="NVL(casing,'--'),Casing"></td><td class = btext>Casing
			</td>
		<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "NVL(DECODE(status,'G','Good','B','Bad'),'--'),Status"></td><td class = btext>Status
			</td>
	</tr>
	<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "NVL(DECODE(gen_condition,'G','Good','B','Bad'),'--'),Gen Condition"></td><td class = btext>Gen Condition
			</td>
	</tr>
	<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "NVL(gi_no,'0'),GI No"></td><td class = btext>GI No
			</td>
	</tr>
	<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "NVL(DECODE(painted,'Y','Yes','N','No'),'--'),Painted"></td><td class = btext>Painted
			</td>
	</tr>
	<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "NVL(static_wl,'0'),Static Water Level"></td><td class = btext>Static Water Level
			</td>
	</tr>
	<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "NVL(summer_wl,'0'),Summer Water Level"></td><td class = btext>Summer Water Level
			</td>
	</tr>
	<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "NVL(DECODE(p_cond,'Y','Yes','N','No'),'--'),P condition"></td><td class = btext>P condition
			</td>
	</tr>
	<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="NVL(dry_during,'0'),Dry During"></td><td class = btext>Dry During
			</td>
		<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "NVL(DECODE(service,'D','Drinking','B','Both','A','Animals'),'--'),Service"></td><td class = btext>Service
			</td>
	</tr>
	<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="NVL(ser_no,'0'),Ser No"></td><td class = btext>Ser No
			</td>
			<tr>
			<td>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="NVL(repairs,'--'),Repairs"></td> <td class = btext>Repairs
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