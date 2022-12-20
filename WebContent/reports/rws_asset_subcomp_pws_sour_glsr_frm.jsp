<TD  valign=top height=20% align="center" width="30%">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">GLSR Sub Component Details</font>
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
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(GLSR_NO,'0'),GLSR NO"></td><td class = btext>GLSR No 
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(GLSR_LOC,'--'),Location"></td><td class = btext>Location
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(GLSR_CAP_LTS,0),Capacity (Lts)"></td><td class = btext>Capacity
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(GLSR_MADE,0),Made"></td><td class = btext>Made
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(GLSR_COND,'--'),Condition"></td><td class = btext>Condition
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(GLSR_FILL_HRS,0),Filling Hrs"></td><td class = btext>Filling Hrs
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(GLSR_EMPTY_HRS,0),Empty Hrs"></td><td class = btext>Empty Hrs
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(GLSR_DRA_COND,'N','No','Y','Yes'),'--'),Drain Condition"></td><td class = btext>Drain Condition
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DECODE(GLSR_HYG,'G','Good','B','Bad'),'--'),Hygiene"></td><td class = btext>Hygiene
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


