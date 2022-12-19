
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=20>Program Wise <font color="white"><%=catName%> Works </font>Abstract Report for the Financial Year(<%=session.getAttribute("financialyr")%>)</td>	
	</tr>
	
	<% 
	//System.out.println("in label drill:"+session.getAttribute("drill"));
	if(session.getAttribute("drill").equals("null") || session.getAttribute("drill").equals("0"))
	{
		//System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="btext" colspan=20  >Program: All &nbsp; &nbsp;<font color="red"><%=planName%></font> WORKS&nbsp; &nbsp;</td>
	</tr>	
	<%}else if(session.getAttribute("drill").equals("11"))
	{
		//System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="btext" colspan=20>Program: <font color="red"><%=session.getAttribute("districtName")%></font> &nbsp; &nbsp;<font color="red"><%=planName%></font> WORKS</td>
	</tr>	
	<%}
else if(session.getAttribute("drill").equals("1"))
	{
		//System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="btext" colspan=20>District: <%=session.getAttribute("districtName")%> &nbsp; &nbsp;<font color="red"><%=planName%></font> WORKS</td>
	</tr>	
	<%}
else if(session.getAttribute("drill").equals("2"))
	{
		//System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="btext" colspan=20  >District: <%=session.getAttribute("districtName")%> &nbsp; &nbsp;Division: <%=session.getAttribute("divname")%>&nbsp;&nbsp;<font color="red"><%=planName%></font> WORKS</td>
	</tr>	<%}%>

	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
	<%	if(session.getAttribute("drill").equals("null") || session.getAttribute("drill").equals("0"))
	{
		%>
		<td class=btext rowspan = 2>Program</td>
	<%}
		else if(session.getAttribute("drill").equals("11"))
	{%>
	<td class=btext rowspan = 2>District</td>
	<%}
	else if(session.getAttribute("drill").equals("1"))
	{%>
	<td class=btext rowspan = 2>Division</td>
	<%}
	else if(session.getAttribute("drill").equals("2"))
	{%>
	<td class=btext rowspan = 2>Sub Division</td>
	<%}
	%>
	<td colspan=3 class=btext align="center">No.of Works</td>
	<td rowspan=2 colspan=1 class=btext align="center">Habs Sanctioned</td>
	<td colspan=3 class=btext align="center">Est.Cost</td>
	
	<td rowspan=2 colspan=1 class=btext align="center">Exp. Upto Last Fin. Year</td>
	<!--<td rowspan=2 colspan=1 class=btext align="center">Exp.during month(i.e.,March'2009)</td>-->
	<td rowspan=2 colspan=1 class=btext align="center">Exp. During The Year</td>	
	<td rowspan=2 colspan=1 class=btext align="center">Total Exp.</td>	
	<td rowspan=2 colspan=1 class=btext align="center">Technically Sanctioned</td>	
	<td rowspan=2 colspan=1 class=btext align="center">Grounded</td>
	<td rowspan=2 colspan=1 class=btext align="center">Completed</td>	
	<td rowspan=2 colspan=1 class=btext align="center">Habs Sanctioned</td>	
	<td rowspan=2 colspan=1 class=btext align="center">Habs Covered</td>	
	</tr>
	
	<tr>
	<td rowspan=1 colspan=1 class=btext align="center">Spill</td>	
	<td rowspan=1 colspan=1 class=btext align="center">New</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Total</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Spill</td>
	<td rowspan=1 colspan=1 class=btext align="center">New</td>		
	<td rowspan=1 colspan=1 class=btext align="center">Total</td>


	</tr>
	

	