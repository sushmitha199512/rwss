<TD  valign=top height=20% align="center" width="30%">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Distribution Sub Component Details</font>
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
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DIS_MAT,'--'),Pipe Meterials"></td><td class = btext>Pipe Meterials
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DIS_CLA,'--'),Pipe Class"></td><td class = btext>Pipe Class 
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DIS_DIA,'0'),Pipe Diameter(mm) "></td><td class = btext>Pipe Diameter
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DIS_LEN,0),Pipe Length"></td><td class = btext>Pipe Length
			</td>
			
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(Decode(DIS_COVE,'N','No', 'Y','Yes'),'--'),Villages Covered "></td><td class = btext>Villages Covered
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DIS_LN,'0'), Total Length Needed "></td><td class = btext> Total Length Needed
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DIS_TLC,0),Total Length Provided"></td><td class = btext>Total Length Provided
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DIS_BN,'0'),Balance Needed"></td>
				<td class = btext>Balance Needed </td>
			
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


