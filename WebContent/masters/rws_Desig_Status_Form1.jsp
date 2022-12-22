
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
	<tr>
	<td width="100%" align="center" class = btext nowrap>
	<font color="blue">Designation Details</font>
	</td>
	</tr>	
</table>

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=100%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
<tr>

	<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CENSUS_PLAIN_POPU,'0'),nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),CensusPop"></td><td class="btext"> PART TIME</td>
	<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch"  id="ck" value="nvl(CENSUS_SC_POPU,'0'),Census SC Pop"></td><td class="btext">Census SC Population</td>
	<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CENSUS_ST_POPU,'0'),Census ST Pop"></td> <td class="btext">Census ST Population</td>
	<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU,'0'),Census Total Pop"></td><td class="btext">Census Total Population</td>-->
	<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(FLOAT_POP,'0'),nvl(FLOAT_POP_REASONS ,'-'),FloatPop"></td> <td class="btext">CONTRACT APPOINTMENT  </td>
	<!--<tr><td class = btext><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(FLOAT_POP_REASONS ,'-'),Floating Pop Reasons"></td> <td class="btext">Floating Population Reasons</td>-->
    <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(COVERAGE_STATUS ,'-'),CovStatus" checked></td><td class="btext">DAILY WAGE</td>
	<!-- <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="TO_CHAR(STATUS_DATE,'DD-MM-YYYY'),Status As On Date"></td><td class="btext">Status As On Date</td>-->
	<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PLAIN_POPU_COVERED  ,'0'),nvl(SC_POP_COVERED,'0'),nvl(ST_POP_COVERED,'0'),nvl(PLAIN_POPU_COVERED  ,'0')+nvl(SC_POP_COVERED,'0')+nvl(ST_POP_COVERED,'0'),PopCov"></td><td class="btext">ASST. ENGINEER </td>
	<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" checked value="nvl(to_char(UPDATE_DATE,'dd-mm-yyyy'),'-'),updatedate"></td><td class="btext">CHEIF ENGINEER(PR)</td>
	<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(SC_POP_COVERED   ,'0'),SC Pop Covered"></td><td class="btext">SC Population Covered</td>
    <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(ST_POP_COVERED    ,'0'),ST Pop Covered"></td><td class="btext">ST Population Covered</td>
    <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PLAIN_POPU_COVERED+SC_POP_COVERED+ST_POP_COVERED,'0'),Total Pop Covered"></td><td class="btext">ENGINEER IN CHIEF</td>
  	<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(CENSUS_YEAR,'0'),CensusYear"></td><td class="btext">SYSTEM ADMINISTRATOR</td>
    <tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PLAIN_POPU_COVERED  ,'0'),nvl(SC_POP_COVERED,'0'),nvl(ST_POP_COVERED,'0'),nvl(PLAIN_POPU_COVERED  ,'0')+nvl(SC_POP_COVERED,'0')+nvl(ST_POP_COVERED,'0'),PopCov"></td><td class="btext"></td>
 	<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PLAIN_POPU_COVERED  ,'0'),nvl(SC_POP_COVERED,'0'),nvl(ST_POP_COVERED,'0'),nvl(PLAIN_POPU_COVERED  ,'0')+nvl(SC_POP_COVERED,'0')+nvl(ST_POP_COVERED,'0'),PopCov"></td><td class="btext"></td>
 	<tr><td class = btext> <INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(PLAIN_POPU_COVERED  ,'0'),nvl(SC_POP_COVERED,'0'),nvl(ST_POP_COVERED,'0'),nvl(PLAIN_POPU_COVERED  ,'0')+nvl(SC_POP_COVERED,'0')+nvl(ST_POP_COVERED,'0'),PopCov"></td><td class="btext">EXECUTIVE ENGINEER</td>


	</tr>	
</table>
 


