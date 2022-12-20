<!--<% String gg="(select nvl(sum(RELEASES_DUR_MON),'0') from RWS_MON_FIN_PHY_PROGRESS_TBL WHERE dcode='"+rDist+"' AND FIN_YEAR='"+fromDate+"' and getFinancialMonth(month)<getFinancialMonth('"+Month+"') and t1.programme_code=programme_code)";%>-->

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
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(t3.OP_BAL,'0'),nvl(RELEASES_DUR_MON,'0'),(select nvl(sum(RELEASES_DUR_MON),'0') from RWS_MON_FIN_PHY_PROGRESS_TBL WHERE dcode='<%=rDist%>' and FIN_YEAR='<%=fromDate%>'and getFinancialMonth(month)<getFinancialMonth('<%=Month%>') and t1.programme_code=programme_code),nvl(t3.OP_BAL,'0')+nvl(RELEASES_DUR_MON,'0')+(select nvl(sum(RELEASES_DUR_MON),'0') from RWS_MON_FIN_PHY_PROGRESS_TBL WHERE dcode='<%=rDist%>' and FIN_YEAR='<%=fromDate%>'and getFinancialMonth(month)<getFinancialMonth('<%=Month%>') and t1.programme_code=programme_code),OPBAL" ></td><td class="btext">Opening Balance(OB)+Releases</td>
		<tr><td><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(EXPENDITURE_DUR_THE_MONTH,'0'),(select nvl(sum(EXPENDITURE_DUR_THE_MONTH),'0') from RWS_MON_FIN_PHY_PROGRESS_TBL WHERE dcode='<%=rDist%>' and FIN_YEAR='<%=fromDate%>'and getFinancialMonth(month)<getFinancialMonth('<%=Month%>') and t1.programme_code=programme_code),EXPENDITURE" ></td> <td class="btext">Expenditure During The Month</td>

		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SPILL_WORKS_NO,'0'),nvl(SPILL_BAL_COST,'0'),nvl(COMMITMENT,'0'),nvl(SPILL_BAL_HABS,'0'),nvl(SPILL_BAL_IP_PH1_HABS,'0'),SPILLS" ></td> <td class="btext">SpillOver Works</td>
		
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(NEW_NO,'0'),nvl(NEW_COST,'0'),nvl(TOTAL_HABS,'0'),nvl(NEW_IP_PH1_HABS,'0'),nvl(NEW_IP_PH2_HABS,'0'),NEW" ></td><td class="btext">New Works Sanctioned</td>
		
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SPILL_WORKS_NO,'0')+nvl(NEW_NO,'0'),nvl(SPILL_BAL_COST,'0')+nvl(NEW_COST,'0'),nvl(SPILL_BAL_HABS,'0')+nvl(TOTAL_HABS,'0'),nvl(SPILL_BAL_IP_PH1_HABS,'0')+nvl(NEW_IP_PH1_HABS,'0')+nvl(NEW_IP_PH2_HABS,'0'),TOTWRKS" ></td> <td class="btext">Total Works</td>
		
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PROGRESS_ENTRUSTED,'0'),nvl(PROGRESS_GROUNDED,'0'),PROGRESS"></td><td class="btext">Progress </td>
		
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(WORKS_COMP,'0'),nvl(COVERED_HABS,'0'),nvl(COVERED_IP_PH1_HABS,'0'),nvl(COVERED_IP_PH2_HABS,'0'),COMPLETED">
		</td><td class="btext">Completed</td>
		
	</tr>	
</table>
