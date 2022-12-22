
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Habitation Details</font>
			</td>
			</tr>	
		</table>

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=100%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
<tr>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(safe_lpcd,'0'),safelpcd"></td><td class="btext">SAFE LPCD</td>
        <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(unsafe_lpcd,'0'),unsafelpcd"></td><td class="btext">UNSAFE LPCD</td>
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CENSUS_PLAIN_POPU,'0'),nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_MINORITY_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0')+nvl(CENSUS_MINORITY_POPU,'0'),CensusPop"></td><td class="btext">Census Population</td>
        <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(WAY_POINT,'0'),nvl(LATITUDE,'0.0'),nvl(LONGITUDE,'0.0'),nvl(ELEVATION,'0.0'),nvl(LANDMARK,'-'),Gis"></td><td class="btext">Gis Information
</td> 
         <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(LWE,'Y','Yes','N','No'),'-'),Lwe"></td><td class="btext">Whether LWE(Yes/No)
</td> 
     <tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CON_PLAIN,'0'),nvl(CON_SC,'0'),nvl(CON_ST,'0'),nvl(CON_MINORITY,'0'),nvl(NO_OF_HOUSECONN_GIVEN,'0'),Houseconn"></td><td class="btext">House Connections
</td> 
<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(IS_ITDA,'Y','Yes','N','No'),'-'),Itda"></td><td class="btext"> Is ITDA(TSP)
</td> 
<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(decode(MINORITY_DOMINATED,'Y','Yes','N','No'),'-'),Minority"></td><td class="btext"> Minority Dominated
</td> 

		
		
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(FLOAT_POP,'0'),nvl(FLOAT_POP_REASONS ,'-'),FloatPop"></td> <td class="btext">Floating Population </td>
		
		<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" checked value="nvl(PREVIOUS_YR_STATUS,'-'),nvl(b.COVERAGE_STATUS,'-'),Status"></td><td class="btext">Coverage Status</td>
		
		 <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PLAIN_POPU_COVERED  ,'0'),nvl(SC_POP_COVERED,'0'),nvl(ST_POP_COVERED,'0'),nvl(MINORITY_POP_COVERED,'0'),nvl(PLAIN_POPU_COVERED,'0')+nvl(SC_POP_COVERED,'0')+nvl(ST_POP_COVERED,'0')+nvl(MINORITY_POP_COVERED,'0'),PopCov"></td><td class="btext">Population Covered</td>
		 <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HOUSEHOLDS_PLAIN,'0'),nvl(HOUSEHOLDS_SC,'0'),nvl(HOUSEHOLDS_ST,'0'),nvl(HOUSEHOLDS_MINORITY,'0'),nvl(HOUSEHOLD_NO,'0'),nvl(NO_OF_CATTLE ,'0'),HouseHolds"></td><td class="btext">No Of HouseHolds & Cattle</td>
		 <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(EXISTING_SOURCES_NO,'0'),nvl(SAFE_SOURCES_NO ,'0'),Existingsource"></td><td class="btext">No Of Existing & Safe Sources</td>
		  <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="decode(NC_SOURCE_TYPE,'','-','1','Spring','2','Dug well','3','Ponds','4','River','5','Stream','6','Distant Govt.Source.(any)'),Nearsource" ></td><td class="btext">Nearest Available Source</td> 
		  <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="decode(SOURCE_DISTANCE,'','-','1','less than 50','2','50-100','3','101-200','4','201-500','5','500-1600','6','Greater than 1600'),SourceDistance" ></td><td class="btext">Distance of availability of Water Supply Point from house hold</td> 
		  <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(HABITATION_TYPE,'-'),nvl(HABITATION_SUB_TYPE,'-'),nvl(HABITATION_CATEGORY ,'-'),Hab"></td><td class="btext">Habitation Type&Subtype&Category</td>
		 <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" checked value="nvl(to_char(b.UPDATE_DATE,'dd-mm-yyyy'),'-'),updatedate"></td><td class="btext">Last Update Date Of Status</td>
		
	</tr>	
</table>
