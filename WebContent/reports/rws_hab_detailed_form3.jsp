<script language="javascript">

//alert("kkkkkkkkkkkkkkkkk");

function fncheckslippage(){
//alert("in the fncheckslippage");
document.forms[0].ch[24].checked=true;
}
function fnchk(){
if(document.forms[0].ch[26].checked){
//alert("in the fnchk");
document.forms[0].ch[24].checked=true;
}
}
</script>
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Population/WaterSupply Details</font>
			</td>
			</tr>	
		</table>
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=100%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
<tr>
<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(safe_lpcd,'0'),safelpcd"></td><td class="btext">SAFE LPCD</td>
        <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(unsafe_lpcd,'0'),unsafelpcd"></td><td class="btext">UNSAFE LPCD</td>
		
<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CENSUS_PLAIN_POPU,'0'),nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_MINORITY_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0')+nvl(CENSUS_MINORITY_POPU,'0'),CensusPop"></td><td class="btext">Census Population</td>
       		

		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(FLOAT_POP,'0'),nvl(FLOAT_POP_REASONS ,'-'),FloatPop"></td> <td class="btext">Floating Population </td>
		<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PLAIN_POPU_COVERED  ,'0'),nvl(SC_POP_COVERED,'0'),nvl(ST_POP_COVERED,'0'),nvl(MINORITY_POP_COVERED,'0'),nvl(PLAIN_POPU_COVERED,'0')+nvl(SC_POP_COVERED,'0')+nvl(ST_POP_COVERED,'0')+nvl(MINORITY_POP_COVERED,'0'),PopCov"></td><td class="btext">Population Covered</td>
         <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HOUSEHOLDS_PLAIN,'0'),nvl(HOUSEHOLDS_SC,'0'),nvl(HOUSEHOLDS_ST,'0'),nvl(HOUSEHOLDS_MINORITY,'0'),nvl(HOUSEHOLD_NO,'0'),nvl(NO_OF_CATTLE ,'0'),HouseHolds"></td><td class="btext">No Of HouseHolds & Cattle</td> 
         <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(safe_lpcd,'0'),safelpcd"></td><td class="btext">SAFE LPCD</td>
        <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(unsafe_lpcd,'0'),unsafelpcd"></td><td class="btext">UNSAFE LPCD</td>



<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(WAY_POINT,'0'),nvl(LATITUDE,'0.0'),nvl(LONGITUDE,'0.0'),nvl(ELEVATION,'0.0'),nvl(LANDMARK,'-'),Gis"></td><td class="btext">Gis Information
</td> 
      
      <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CON_PLAIN,'0'),nvl(CON_SC,'0'),nvl(CON_ST,'0'),nvl(CON_MINORITY,'0'),nvl(NO_OF_HOUSECONN_GIVEN,'0'),Houseconn"></td><td class="btext">House Connections
</td>  
<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(IS_ITDA,'Y','Yes','N','No'),'-'),Itda"></td><td class="btext"> Is ITDA(TSP)
</td> 
<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(MINORITY_DOMINATED,'Y','Yes','N','No'),'-'),Minority"></td><td class="btext"> Minority Dominated
</td> 
<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(LWE,'Y','Yes','N','No'),'-'),Lwe"></td><td class="btext">Whether LWE(Yes/No)


		
		<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(EXISTING_SOURCES_NO,'0'),nvl(SAFE_SOURCES_NO ,'0'),Existingsource"></td><td class="btext">No Of Existing & Safe Sources</td>
		<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="decode(NC_SOURCE_TYPE,'','-','1','Spring','2','Dug well','3','Ponds','4','River','5','Stream','6','Distant Govt.Source.(any)'),Nearsource" ></td><td class="btext">Nearest Available Source</td>
		<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="decode(SOURCE_DISTANCE,'','-','1','less than 50','2','50-100','3','101-200','4','201-500','5','500-1600','6','Greater than 1600'),SourceDistance" ></td><td class="btext">Distance of availability of Water Supply Point from house hold</td> 
		<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HABITATION_TYPE,'-'),nvl(HABITATION_SUB_TYPE,'-'),nvl(HABITATION_CATEGORY ,'-'),Hab"></td><td class="btext">Habitation Type&Subtype&Category</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" checked value="nvl(to_char(b.UPDATE_DATE,'dd-mm-yyyy'),'-'),updatedate"></td><td class="btext">Last Update Date Of Status</td>
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
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(OTHERS_NO,'0'),nvl(OTHERS_SUPPLY ,'0'),OTHERS(unsafe)"></td><td class="btext">OTHERS(Unsafe)</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HPS_OTH_SUPPLY_UNSAFE,'0')+nvl(PWS_UNSAFE_SUPPLY,'0')+nvl(MPWS_UNSAFE_SUPPLY,'0')+nvl(OWS_OTH_SUPPLY,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl(OTHERS_SUPPLY,'0'),Total(unsafe)"></td><td class="btext">Total Water Supply(Unsafe) </td>
				<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(EXIST_WATER_LEVEL,'0'),Existing"></td><td class="btext">LPCD</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" checked value="nvl(PREVIOUS_YR_STATUS,'-'),nvl(b.COVERAGE_STATUS,'-'),Status" onClick="fnchk()"></td><td class="btext">Coverage Status</td>
		<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(NEAR_SURFACE_SOURCE,'0'),nvl(NEAR_GROUND_SOURCE,'0'),SurfaceSource"></td><td class="btext">Distance from Source </td>-->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(QUALITY_AFFECTED,'-'),Qualityeffect"></td><td class="btext">Quality Affected</td>		
		<!--  slippage codes are from table RWS_SLIPPAGE_REASON_TBL , if slippage code is added/modified in table then the changes should be modified/added in this code also-->
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="decode(nvl(SLIPPAGE_CODE,'0'),'0033','Increase in population-Migration','0035','Drying up of sources','0036','Due to Water Quality problems','0037','Poor Operation and Maintenance','0038','Seasonal slippage (Temporary)','0039','Less Supply (at PWS delivery points)','0043','Age of systems','0045','Shortage of electricity','0','-'),slippage" onClick="fncheckslippage()"></td><td class="btext">Reason For Slippage</td>			
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PROPOSED_FC_YEAR ,'-'),nvl(PROPOSED_FC_EST_AMT,'0'),Proposed"></td><td class="btext">Proposed FC Status</td> 
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE WHEN p.P_INST_CODE='02' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='02' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='02' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='02' then P_INST_NOTWORKING_NO end),'0'),Temples"></td><td class="btext">Temples</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE WHEN p.P_INST_CODE='03' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='03' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='03' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='03' then P_INST_NOTWORKING_NO end),'0'),PrimaryHealthCentre"></td><td class="btext">Primary Health Centres </td>
  	    <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE WHEN p.P_INST_CODE='04' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='04' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='04' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='04' then P_INST_NOTWORKING_NO end),'0'),AnganwadiCentres"></td><td class="btext">Anganwadi Centres</td>
  	    <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE WHEN p.P_INST_CODE='05' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='05' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='05' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='05' then P_INST_NOTWORKING_NO end),'0'),Libraries"></td><td class="btext">Libraries</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE when p.P_INST_CODE='06' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='06' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='06' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='06' then P_INST_NOTWORKING_NO end),'0'),CommunityHalls"></td><td class="btext">Community Halls</td>
	    <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE WHEN p.P_INST_CODE='01' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='01' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='01' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='01' then P_INST_NOTWORKING_NO end),'0'),PrimarySchool"></td><td class="btext">Primary Schools</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE when p.P_INST_CODE='07' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='07' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='07' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='07' then P_INST_NOTWORKING_NO end),'0'),U.PSchools"></td><td class="btext">U.P Schools</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE when p.P_INST_CODE='08' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='08' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='08' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='08' then P_INST_NOTWORKING_NO end),'0'),HighSchools"></td><td class="btext">High Schools</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE when p.P_INST_CODE='09' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='09' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='09' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='09' then P_INST_NOTWORKING_NO end),'0'),B.CHostels"></td><td class="btext">B.C Hostels </td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE when p.P_INST_CODE='10' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='10' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='10' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='10' then P_INST_NOTWORKING_NO end),'0'),S.CHostels"></td><td class="btext">S.C Hostels </td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE when p.P_INST_CODE='11' then p_inst_no end),'0'),nvl(sum(CASE when p.P_INST_CODE='11' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='11' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='11' then P_INST_NOTWORKING_NO end),'0'),S.THostels"></td><td class="btext">S.T Hostels</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(sum(CASE WHEN   p.P_INST_CODE='01' then p_inst_no end),'0') + nvl(sum(CASE WHEN p.P_INST_CODE='02' then p_inst_no end),'0')+ nvl(sum(CASE WHEN   p.P_INST_CODE='03' then p_inst_no end),'0')+nvl(sum(CASE WHEN   p.P_INST_CODE='04' then p_inst_no end),'0')+ nvl(sum(CASE WHEN p.P_INST_CODE='05' then p_inst_no end),'0')+ nvl(sum(CASE when p.P_INST_CODE='06' then p_inst_no end),'0')+ nvl(sum(CASE when p.P_INST_CODE='07' then p_inst_no end),'0')+ nvl(sum(CASE when p.P_INST_CODE='08' then p_inst_no end),'0')+ nvl(sum(CASE when p.P_INST_CODE='09' then p_inst_no end),'0')+ nvl(sum(CASE when p.P_INST_CODE='10' then p_inst_no end),'0')+ nvl(sum(CASE when p.P_INST_CODE='11' then p_inst_no end),'0'),nvl(sum(CASE WHEN   p.P_INST_CODE='01' then p_inst_covered end),'0') + nvl(sum(CASE WHEN p.P_INST_CODE='02' then p_inst_covered end),'0')+ nvl(sum(CASE WHEN  p.P_INST_CODE='03' then p_inst_covered end),'0')+nvl(sum(CASE WHEN p.P_INST_CODE='04' then p_inst_covered end),'0')+ nvl(sum(CASE WHEN   p.P_INST_CODE='05' then p_inst_covered end),'0')+ nvl(sum(CASE when p.P_INST_CODE='06' then p_inst_covered end),'0')+ nvl(sum(CASE when p.P_INST_CODE='07' then p_inst_covered end),'0')+ nvl(sum(CASE when p.P_INST_CODE='08' then p_inst_covered end),'0')+ nvl(sum(CASE when p.P_INST_CODE='09' then p_inst_covered end),'0')+ nvl(sum(CASE when p.P_INST_CODE='10' then p_inst_covered end),'0')+ nvl(sum(CASE when p.P_INST_CODE='11' then p_inst_covered end),'0'),nvl(sum(CASE when p.P_INST_CODE='02' then P_INST_WORKING end),'0')+nvl(sum(CASE when p.P_INST_CODE='03' then P_INST_WORKING end),'0')+nvl(sum(CASE when p.P_INST_CODE='04' then P_INST_WORKING end),'0')+nvl(sum(CASE when p.P_INST_CODE='05' then P_INST_WORKING end),'0')+nvl(sum(CASE when p.P_INST_CODE='06' then P_INST_WORKING end),'0')+nvl(sum(CASE when p.P_INST_CODE='01' then P_INST_WORKING end),'0')+nvl(sum(CASE when p.P_INST_CODE='07' then P_INST_WORKING end),'0')+nvl(sum(CASE when p.P_INST_CODE='08' then P_INST_WORKING end),'0')+nvl(sum(CASE when p.P_INST_CODE='09' then P_INST_WORKING end),'0')+nvl(sum(CASE when p.P_INST_CODE='10' then P_INST_WORKING end),'0')+nvl(sum(CASE when p.P_INST_CODE='11' then P_INST_WORKING end),'0'),nvl(sum(CASE when p.P_INST_CODE='02' then P_INST_NOTWORKING_NO end),'0')+nvl(sum(CASE when p.P_INST_CODE='03' then P_INST_NOTWORKING_NO end),'0')+nvl(sum(CASE when p.P_INST_CODE='04' then P_INST_NOTWORKING_NO end),'0')+nvl(sum(CASE when p.P_INST_CODE='05' then P_INST_NOTWORKING_NO end),'0')+nvl(sum(CASE when p.P_INST_CODE='06' then P_INST_NOTWORKING_NO end),'0')+nvl(sum(CASE when p.P_INST_CODE='01' then P_INST_NOTWORKING_NO end),'0')+nvl(sum(CASE when p.P_INST_CODE='07' then P_INST_NOTWORKING_NO end),'0')+nvl(sum(CASE when p.P_INST_CODE='08' then P_INST_NOTWORKING_NO end),'0')+nvl(sum(CASE when p.P_INST_CODE='09' then P_INST_NOTWORKING_NO end),'0')+nvl(sum(CASE when p.P_INST_CODE='10' then P_INST_NOTWORKING_NO end),'0')+nvl(sum(CASE when p.P_INST_CODE='11' then P_INST_NOTWORKING_NO end),'0'),TotalNo"></td><td class="btext">Total Institutes</td> 
		
</td> 
				<!--	<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="round((nvl(HPS_OTH_SUPPLY,'0')+ nvl (PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')+nvl (OWS_OTH_SUPPLY ,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl (OTHERS_SUPPLY,'0'))/((nvl (CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl (CENSUS_ST_POPU,'0')+nvl (FLOAT_POP,'0')+.0001)*POWER(1.02,6)),2),Existing"></td><td class="btext">Existing Water Level</td>-->
	</tr>	
</table>