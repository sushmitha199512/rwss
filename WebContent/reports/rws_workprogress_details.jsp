<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Works Progress Details</font>
			</td>
			</tr>	
		</table>

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=100%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
<tr>
		
		<!-- <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(COMPONENT,'--'),Component"></td><td class="btext">Component</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DEPTH,'0'),Depth"></td><td class="btext">Depth</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(YEILD,'0'),Yeild"></td><td class="btext">Yeild</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PLATFORM,'0'),Platform"></td><td class="btext">Platform</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(QUALITY,'--'),Quality"></td><td class="btext">Quality</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(Portable,'--'),Portable "></td><td class="btext">Portable</td> -->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(OP_BAL),'0'),OP_BAL"></td><td class="btext">Opening Balance(OB)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch"  id="ck" value="nvl(SUM(Releases),'0'),Releases"></td><td class="btext">Releases</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch"  id="ck" value="nvl(sum(OP_BAL+Releases),'0'),Total"></td><td class="btext">Total OB+Releases</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(EXPENDITURE_DUR_THE_MONTH),'0'),EXPENDITURE_DUR_THE_MONTH"></td> <td class="btext">Expenditure During The Month</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(SPILL_WORKS_NO),'0'),SPILL_WORKS_NO"></td> <td class="btext">No Of SpillOver Works</td>
		
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(SPILL_BAL_COST),'0'),SPILL_BAL_COST"></td><td class="btext">Spill Works Balanced Cost</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(SPILL_BAL_HABS),'0'),SPILL_BAL_HABS"></td><td class="btext">Balanced Habitations</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(SUM(SPILL_BAL_IP_PH1_HABS),'0'),SPILL_BAL_IP_PH1_HABS"></td><td class="btext">Balanced IP PH-1 Habs</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(NEW_NO),'0'),NEW_NO"></td><td class="btext">No Of New Works</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch"  id="ck" value="nvl(SUM(NEW_COST),'0'),NEW_COST"></td><td class="btext">New Works Cost</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(TOTAL_HABS),'0'),TOTAL_HABS"></td> <td class="btext">Total Habitations</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(NEW_IP_PH1_HABS),'0'),NEW_IP_PH1_HABS"></td> <td class="btext">New IP PH-1 Habs</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(NEW_IP_PH2_HABS),'0'),NEW_IP_PH2_HABS"></td> <td class="btext">New IP PH-2 Habs</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(SPILL_WORKS_NO+NEW_NO),'0'),TOTWRKS"></td> <td class="btext">Total Works</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(SPILL_BAL_COST+NEW_COST),'0'),TOTCOST"></td> <td class="btext">Total Cost of the Works</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(SPILL_BAL_HABS+TOTAL_HABS),'0'),HABITATIONS"></td> <td class="btext">Total Works Habitations</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(SPILL_BAL_IP_PH1_HABS+NEW_IP_PH1_HABS+NEW_IP_PH2_HABS),'0'),IPHABS"></td> <td class="btext">Total Works IP Habitations</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(PROGRESS_ENTRUSTED),'0'),PROGRESS_ENTRUSTED"></td><td class="btext">Progress Entrusted</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(PROGRESS_GROUNDED),'0'),PROGRESS_GROUNDED"></td><td class="btext">Progress Grounded</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(SUM(WORKS_COMP),'0'),WORKS_COMP"></td><td class="btext">Completed Works</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(SUM(COVERED_HABS),'0'),COVERED_HABS"></td><td class="btext">Covered Habitations</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(COVERED_IP_PH1_HABS),'0'),COVERED_IP_PH1_HABS"></td><td class="btext">Covered IP PH-1 Habs</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SUM(COVERED_IP_PH2_HABS),'0'),COVERED_IP_PH2_HABS"></td><td class="btext">Covered IP PH-2 Habs</td>
		
	</tr>	
</table>
