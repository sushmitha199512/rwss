
 <%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp"%>
 <SCRIPT LANGUAGE="JavaScript">
 function Print()
 {
 
 window.print();
 }
 </SCRIPT>
 <style>
 .mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
</head>
<body topmargin="0">
<table  width="100%" >
<tr >
<td align="right">
<A href="#1" onClick="Print()">Print</A>
 </td>
 </tr>
 </table>
<c:if test="${sessionScope.SubComponet =='Handpumps'}">
<table style="  border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>
<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%>&nbsp;&nbsp;&nbsp
Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>
<td colspan=20> <font face="Verdana" size="1">HAND PUMPS-SOURCE-BORE WELL-REPORT(I)  </td></tr>
<tr>
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Pump Code</font></td>
	<td align=center><font face="Verdana" size="1">Location</font></td>
	<td align=center><font face="Verdana" size="1">Diameter</font></td>
	<td align=center><font face="Verdana" size="1">Depth(Mts)</font></td>
	<td align=center><font face="Verdana" size="1">Casing(Type) </font></td>
	<td align=center><font face="Verdana" size="1">No of GI Pipes </font></td>
	<td align=center><font face="Verdana" size="1">General Condition </font></td>
	<td align=center><font face="Verdana" size="1">Static Water Level(Mts)</font></td>
	<td align=center><font face="Verdana" size="1">Summer Water Level(Mts) </font></td>
	<td align=center><font face="Verdana" size="1">No Of Hours Serving per day</font></td>
</tr>

    <logic:iterate id="HPReport" name="HandPumpRpt1">
						
							<TR>
								<logic:iterate id="HPREPORTID" name="HPReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="HPREPORTID" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
<table style="  border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>
<td colspan=20> <font face="Verdana" size="1">HAND PUMPS-SOURCE-BORE WELL-REPORT (II)  </td></tr>
<tr>
   	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">No Of Households Served</font></td>
	<td align=center><font face="Verdana" size="1">HP No Painted </font></td>
	<td align=center><font face="Verdana" size="1">Repairs Per Year </font></td>
	<td align=center><font face="Verdana" size="1">Platform Existing</font></td>
	<td align=center><font face="Verdana" size="1">Platform Condition</font></td>
	<td align=center><font face="Verdana" size="1">Drain</font></td>
	<td align=center><font face="Verdana" size="1">Drain Condition</font></td>
	<td align=center><font face="Verdana" size="1">Drain Connected to Side Drains</font></td>
	<td align=center><font face="Verdana" size="1">Leach pit</font></td>
	<td align=center><font face="Verdana" size="1">Hygiene </font></td>
	<!--<td align=center><font face="Verdana" size="1">Avg Time to fill pot of 10 lts capacity(min.)</font></td>-->
	<td align=center><font face="Verdana" size="1">Present Yield (as per Local Enquiry) </font></td>
	<td align=center><font face="Verdana" size="1">Yield(l.p.m)</font></td>
	<td align=center><font face="Verdana" size="1">Water Quality[Safe(Y)/NSS(N)]</font></td>
</tr>

    <logic:iterate id="HPReport" name="HandPumpRpt2">
						
							<TR>
								<logic:iterate id="HPREPORTID" name="HPReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="HPREPORTID" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
</c:if>

</body>
</html>
<%@ include file="/commons/rws_footer.jsp"%>