<script language="javascript">
function fncheckslippage(){
//alert("in the fncheckslippage");
document.forms[0].ch[17].checked=true;
}
function fnchk(){
if(document.forms[0].ch[18].checked){
//alert("in the fnchk");
document.forms[0].ch[17].checked=true;
}
}
</script>

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Water Details</font>
			</td>
			</tr>	
		</table>

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=100%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
<tr>     
<%--         <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HPS_NO,'0'),nvl(HPS_OTH_SUPPLY,'0'),HandPumps"></td><td class="btext">HandPumps</td>
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HPS_OTH_SUPPLY  ,'0'),HandPumps Water Supply"></td><td class="btext">HandPumps Water Supply</td>-->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PWS_NO,'0'),nvl(PWS_SUPPLY,'0'),PWS"></td><td class="btext">PWS</td>
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PWS_SUPPLY,'0'),PWS Water Supply "></td><td class="btext">PWS Water Supply </td>-->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(MPWS_NO,'0'),nvl(MPWS_SUPPLY,'0'),MPWS"></td><td class="btext">MPWS</td>
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(MPWS_SUPPLY,'0'),MPWS Water Supply"></td><td class="btext">MPWS Water Supply </td>-->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CPWS_NO,'0'),nvl(CPWS_SUPPLY,'0'),CPWS"></td><td class="btext">CPWS</td>
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CPWS_SUPPLY,'0'),CPWS Water Supply"></td><td class="btext">CPWS Water Supply</td>-->--%> 
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DIRECT_PUMPING_NO,'0'),nvl(DIRECT_PUMPING_SUPPLY ,'0'),EXTENSION"></td><td class="btext">Extension Of Scheme</td>
		
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HPS_NO,'0'),nvl(HPS_OTH_SUPPLY,'0'),HandPumps"></td><td class="btext">HandPumps(safe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PWS_NO,'0'),nvl(PWS_SUPPLY,'0'),PWS"></td><td class="btext">PWS(Safe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(MPWS_NO,'0'),nvl(MPWS_SUPPLY,'0'),MPWS"></td><td class="btext">MPWS(Safe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CPWS_NO,'0'),nvl(CPWS_SUPPLY,'0'),CPWS"></td><td class="btext">CPWS(Safe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OTHERS_NO_SAFE,'0'),nvl(OTHERS_SUPPLY_SAFE,'0'),OTHERS"></td><td class="btext">OTHERS(Safe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HPS_OTH_SUPPLY,'0')+nvl(PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(cpws_supply,'0')+nvl(OTHERS_SUPPLY_SAFE,'0'),Total"></td><td class="btext">Total Water Supply(Safe) </td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HPS_NO_UNSAFE,'0'),nvl(HPS_OTH_SUPPLY_UNSAFE,'0'),HandPumps(unsafe)"></td><td class="btext">HandPumps(Unsafe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PWS_UNSAFE_NO,'0'),nvl(PWS_UNSAFE_SUPPLY,'0'),PWS(unsafe)"></td><td class="btext">PWS(Unsafe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(MPWS_UNSAFE_NO,'0'),nvl(MPWS_UNSAFE_SUPPLY,'0'),MPWS(unsafe)"></td><td class="btext">MPWS(Unsafe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OWS_NO,'0'),nvl(OWS_OTH_SUPPLY ,'0'),OPENWELLS"></td><td class="btext">OpenWells(Unsafe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PONDS_NO,'0'),nvl(PONDS_OTH_SUPPLY ,'0'),PONDS"></td><td class="btext">Ponds(Unsafe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SHP_NO,'0'),nvl(SHP_DK_SUPPLY,'0'),SHALLOWPUMPS"></td><td class="btext">Shallow HandPumps(Unsafe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OTHERS_NO,'0'),nvl(OTHERS_SUPPLY ,'0'),OTHERS"></td><td class="btext">OTHERS(Unsafe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HPS_OTH_SUPPLY_UNSAFE,'0')+nvl(PWS_UNSAFE_SUPPLY,'0')+nvl(MPWS_UNSAFE_SUPPLY,'0')+nvl(OWS_OTH_SUPPLY,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl(OTHERS_SUPPLY,'0'),Total(unsafe)"></td><td class="btext">Total Water Supply(Unsafe) </td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(EXIST_WATER_LEVEL,'0'),Existing"></td><td class="btext">LPCD</td>
<%--	<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OWS_NO,'0'),nvl(OWS_OTH_SUPPLY ,'0'),OPENWELLS"></td><td class="btext">OpenWells</td>
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OWS_OTH_SUPPLY ,'0'),OPENWELLS Water Supply"></td><td class="btext">OpenWells Water Supply </td>-->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PONDS_NO,'0'),nvl(PONDS_OTH_SUPPLY,'0'),PONDS"></td><td class="btext">Ponds</td>
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PONDS_OTH_SUPPLY ,'0'),PONDS Water Supply"></td><td class="btext">Ponds Water Supply </td>-->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SHP_NO,'0'),nvl(SHP_DK_SUPPLY,'0'),SHALLOWPUMPS"></td><td class="btext">Shallow HandPumps</td>
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SHP_DK_SUPPLY,'0'),SHALLOWPUMPS Water Supply"></td><td class="btext">Shallow HandPumps Water Supply </td>-->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OTHERS_NO,'0'),nvl(OTHERS_SUPPLY,'0'),OTHERS"></td><td class="btext">Others</td>
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OTHERS_SUPPLY ,'0'),OTHERS Water Supply"></td><td class="btext">OTHERS Water Supply </td>-->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="(nvl(nvl(HPS_OTH_SUPPLY,'0')+ nvl(PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')),'0'),Total"></td><td class="btext">Total Water Supply</td>--%> 
<!-- 	<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="round((nvl(HPS_OTH_SUPPLY,'0')+ nvl (PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')+nvl (DIRECT_PUMPING_SUPPLY ,'0')+nvl (OWS_OTH_SUPPLY ,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl (OTHERS_SUPPLY,'0'))/((nvl (CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl (CENSUS_ST_POPU,'0')+nvl (FLOAT_POP,'0')+.0001)*POWER(1.01,(TO_CHAR(STATUS_DATE,'YYYY')-nvl(CENSUS_YEAR,'2001')))),2),Existing"></td><td class="btext">Existing Water Level</td> 
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(EXIST_WATER_LEVEL,'-'),Existing"></td><td class="btext">Existing Water Level</td>-->
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="COVERAGE_STATUS,Coverage Status" checked></td><td class="btext">Coverage Status On Date</td>-->
		<!-- <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(NEAR_SURFACE_SOURCE,'0'),nvl(NEAR_GROUND_SOURCE,'0'),SurfaceSource"></td><td class="btext">Distance from Source </td>-->
		<!-- <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(EXISTING_SOURCES_NO,'0'),nvl(SAFE_SOURCES_NO ,'0'),Sources"></td><td class="btext">No Of Existing & Safe Sources</td>-->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(QUALITY_AFFECTED,'-'),Qualityeffect"></td><td class="btext">Quality Affected</td>	
				<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" checked value="nvl(PREVIOUS_YR_STATUS,'-'),nvl(b.COVERAGE_STATUS,'-'),Status" onClick="fnchk()"></td><td class="btext">Coverage Status</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="decode(nvl(SLIPPAGE_CODE,'0'),'0033','Increase in population-Migration','0035','Drying up of sources','0036','Due to Water Quality problems','0037','Poor Operation and Maintenance','0038','Seasonal slippage (Temporary)','0039','Less Supply (at PWS delivery points)','0043','Age of systems','0045','Shortage of electricity','0','-'),slippage" onClick="fncheckslippage()"></td><td class="btext">Reason For Slippage</td>			
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(NEAR_GROUND_SOURCE,'0'),Nearest Ground Source (in Kms)"></td><td class="btext">Distance from Nearest Ground  Source</td>--> 
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PROPOSED_FC_YEAR ,'-'),nvl(PROPOSED_FC_EST_AMT ,'0'),Proposed"></td><td class="btext">Proposed FC Status</td>
		<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" checked value="nvl(to_char(b.UPDATE_DATE,'dd-mm-yyyy'),'-'),updatedate"></td><td class="btext">Last Update Date Of Status</td>
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PROPOSED_FC_EST_AMT ,'0'),Proposed FC Amount"></td><td class="btext">Proposed FC Estimated Amt</td>--> 
	</tr>	
</table>


<!-- 
<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HPS_OTH_SUPPLY,'0')+nvl(PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')+nvl(DIRECT_PUMPING_SUPPLY ,'0')+nvl(OWS_OTH_SUPPLY ,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl(OTHERS_SUPPLY ,'0'),Total"></td><td class="btext">Total Water Supply </td>
<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="round((nvl(HPS_OTH_SUPPLY,'0')+ nvl (PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')+nvl (DIRECT_PUMPING_SUPPLY ,'0')+nvl (OWS_OTH_SUPPLY ,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl (OTHERS_SUPPLY,'0'))/((nvl (CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl (CENSUS_ST_POPU,'0')+nvl (FLOAT_POP,'0')+.0001)*POWER(1.01,(TO_CHAR(STATUS_DATE,'YYYY')-nvl(CENSUS_YEAR,'2001')))),2),Existing"></td><td class="btext">Existing Water Level</td>
-->


