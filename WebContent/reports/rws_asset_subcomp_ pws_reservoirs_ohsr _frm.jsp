<TD  valign=top height=20% align="center" width="30%">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">OHSR Sub Component Details</font>
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
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OHSR_NO,'0'),OHSR No"></td><td class = btext>OHSR No
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OHSR_CAP_LTS,'0'),OHSR Capacity (in Lts)"></td><td class = btext>Capacity  
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OHSR_MADE,'--'),Type"></td><td class = btext>Type
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OHSR_HT,'0'),OHSR HT"></td><td class = btext>OHSR HT
			</td>
			
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OHSR_COND,'--'),Condition"></td><td class = btext>Condition
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OHSR_FILL_HRS,'0'),Fill (in Hrs)  "></td><td class = btext>Fill In Hrs
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OHSR_EMPTY,0),Empty (in Hrs)"></td><td class = btext>Empty In Hrs
			</td>
			<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(Decode(OHSR_HYG,'G','Good','B','Bad'),'--'),Hygiene"></td>
				<td class = btext>Hygiene </td>
				<tr>
			<td >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DECODE(OHSR_FEN,'Y','Yes','N','No'),'--'),Fencing"></td>
				<td class = btext>Fencing </td>
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


