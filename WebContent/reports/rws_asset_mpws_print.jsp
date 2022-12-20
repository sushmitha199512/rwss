
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
<c:if test="${sessionScope.MpwsSubComponet =='Ohsr'}">
<table style="  border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>
  

<tr>

<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%>&nbsp;&nbsp;&nbsp
Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>
<td colspan=20> <font face="Verdana" size="1">MPWS-RESERVOIRS-OHSR-REPORT </td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Habitation Linkage</font></td>
	<td align=center><font face="Verdana" size="1">OHSR Code</font></td>
	<td align=center><font face="Verdana" size="1">OHSR Location</font></td>
	<td align=center><font face="Verdana" size="1">OHSR Capacity In Lts</font></td>
	<td align=center><font face="Verdana" size="1">No.Of Fillings</font></td>
	<td align=center><font face="Verdana" size="1">OHSR Staging(Mts)</font></td>
	<td align=center><font face="Verdana" size="1">Water Quality</font></td>
	<!-- <td align=center><font face="Verdana" size="1">Lowest Water Level(LWL)</font></td>
	<td align=center><font face="Verdana" size="1">Maximum Water Level(MWL)</font></td>
	<td align=center><font face="Verdana" size="1">OHSR Fill In Hrs</font></td>
	<td align=center><font face="Verdana" size="1">OHSR Empty In Hrs</font></td>-->
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsOhsrReport1" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsOhsrReport1" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.MpwsSubComponet =='Ohbr'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black"   width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%>&nbsp;&nbsp;&nbsp;
   Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>
<td colspan=20> <font face="Verdana" size="1">MPWS-RESERVOIRS-OHBR-REPORT </td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">HBR Code </font></td>
	<td align=center><font face="Verdana" size="1">HBR Location </font></td>
	<td align=center><font face="Verdana" size="1">HBR Capacity In Lts </font></td>
	<td align=center><font face="Verdana" size="1">HBR Staging(Mts) </font></td>
	
	
	<!-- <td align=center><font face="Verdana" size="1">Lowest Water Level(LWL)</font></td>
	<td align=center><font face="Verdana" size="1">Maximum Water Level(MWL) </font></td>
	<td align=center><font face="Verdana" size="1">OHBR Fill In Hrs.</font></td>
	<td align=center><font face="Verdana" size="1">OHBR Empty In Hrs</font></td> -->

	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsOhbrReport1" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsOhbrReport1" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>

<c:if test="${sessionScope.MpwsSubComponet =='Glsr'}">
<table style="border-collapse: collapse; border: normal;" border=1  bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>
<td colspan=20> <font face="Verdana" size="1">MPWS-RESERVOIRS-GLSR-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">GLSR Code  </font></td>
	<td align=center><font face="Verdana" size="1">GLSR Location</font></td>
	<td align=center><font face="Verdana" size="1">GLSR Capacity In Lts  </font></td>
	<td align=center><font face="Verdana" size="1">No.Of Fillings</font></td>
	<td align=center><font face="Verdana" size="1">GLSR Staging(Mts)</font></td>
	<td align=center><font face="Verdana" size="1">Water Quality </font></td>
	

	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsGlsrReport1" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsGlsrReport1" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>


<c:if test="${sessionScope.MpwsSubComponet =='Glbr'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black"  width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-RESERVOIRS-GLBR-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">GLBR Code  </font></td>
	<td align=center><font face="Verdana" size="1">GLBR Location</font></td>
	<td align=center><font face="Verdana" size="1">GLBR Capacity In Lts  </font></td>
	
	<td align=center><font face="Verdana" size="1">Lowest Water Level(MWL) </font></td>
	<td align=center><font face="Verdana" size="1">Maximum Water Level(MWL) </font></td>
	<td align=center><font face="Verdana" size="1">GLBR Fill In Hrs</font></td>
	<td align=center><font face="Verdana" size="1">GLBR Empty In Hrs</font></td>

	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsGlbrReport1" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsGlbrReport1" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>
<c:if test="${sessionScope.MpwsSubComponet =='Bpt'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-RESERVOIRS-BPT-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">BPT Code</font></td>
	<td align=center><font face="Verdana" size="1">Location</font></td>
	<td align=center><font face="Verdana" size="1">BPT Capacity in Lts</font></td>
	<td align=center><font face="Verdana" size="1">BPT Staging(Mts) </font></td>
	
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsBptReport1" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsBptReport1" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr> 
</c:if>
<c:if test="${sessionScope.MpwsSubComponet =='Cisterns'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-RESERVOIRS-CISTERNS-REPORT</td></tr>
<tr>
    <td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Cistern Code </font></td>
	<td align=center><font face="Verdana" size="1">Location</font></td>
	<td align=center><font face="Verdana" size="1">Capacity in Lts </font></td>
	
	
	<td align=center><font face="Verdana" size="1">No Of Fillings/Day </font></td>
	 <td align=center><font face="Verdana" size="1">Platform Existing  </font></td>
	<td align=center><font face="Verdana" size="1">Platform Condition </font></td>
	<td align=center><font face="Verdana" size="1">Drain Provided </font></td>
    <td align=center><font face="Verdana" size="1">Water Quality </font></td>
    
	
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsCSTReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsCSTReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr> 
</c:if>

<c:if test="${sessionScope.MpwsSubComponet =='RwcWell'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-RWC WELL-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Raw Water Collection Well Code</font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<td align=center><font face="Verdana" size="1">Capacity </font></td>
	
	<!-- <td align=center><font face="Verdana" size="1">Type Of Flooring</font></td> -->
	
	
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsRwcWellReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsRwcWellReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.MpwsSubComponet =='SsTank'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-SS TANK-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">SS Tank Code</font></td>
	<td align=center><font face="Verdana" size="1">SS Tank Size(LBD)</font></td>
	<td align=center><font face="Verdana" size="1">Depth</font></td>
	<td align=center><font face="Verdana" size="1">No Of Days Storage</font></td>
	<td align=center><font face="Verdana" size="1">No Of Mcum </font></td>
	<td align=center><font face="Verdana" size="1">Fed By </font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<!-- <td align=center><font face="Verdana" size="1">Type Of Power Connection  </font></td>
	<td align=center><font face="Verdana" size="1">No Of Hours Availability Of Power Per Day </font></td>-->
	
	
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsSsTankReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsSsTankReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>


<c:if test="${sessionScope.MpwsSubComponet =='SsFilter'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-SS FILTERS-REPORT</td></tr>
<tr>
                                      
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">WTP Code</font></td>
	 <td align=center><font face="Verdana" size="1">Location </font></td> -->
	<td align=center><font face="Verdana" size="1">Capacity In MLD </font></td>
	<td align=center><font face="Verdana" size="1">No of Hours Of Usage </font></td>
	<td align=center><font face="Verdana" size="1">No of Units </font></td>
 	<td align=center><font face="Verdana" size="1">Size of Units(LBH in M)</font></td>
	<td align=center><font face="Verdana" size="1">No of Stand By Units </font></td>
 	<td align=center><font face="Verdana" size="1">Frequency Of Sand Wash </font></td>
	<td align=center><font face="Verdana" size="1">General Performance  </font></td>
	
	<td align=center><font face="Verdana" size="1">Extension Scope </font></td>
	<td align=center><font face="Verdana" size="1">Sedimentation Tank </font></td>
	<td align=center><font face="Verdana" size="1">Horizontal Roughing Filter </font></td>
	<td align=center><font face="Verdana" size="1">Vertical Roughing Filter </font></td>
	
	
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsSsFiltersReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsSsFiltersReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.MpwsSubComponet =='RsFilter'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-RS FILTERS-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">WTP Code </font></td>
	<!-- <td align=center><font face="Verdana" size="1">Type of WTP </font></td> -->
	<td align=center><font face="Verdana" size="1">Capacity In MLD </font></td>
	<td align=center><font face="Verdana" size="1">No of Units </font></td>
 	<td align=center><font face="Verdana" size="1">Size of Units(LBH in M)</font></td>
	<td align=center><font face="Verdana" size="1">No of Stand By Units </font></td>
	<td align=center><font face="Verdana" size="1">Frequency Of Sand Wash </font></td>
	<td align=center><font face="Verdana" size="1">General Performance  </font></td>
	
	<td align=center><font face="Verdana" size="1">Extension Scope </font></td>
	<td align=center><font face="Verdana" size="1">Clarifloculator </font></td>
	
	
	
      
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsRsFiltersReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsRsFiltersReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.MpwsSubComponet =='Sump'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-SUMP-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Sump Code </font></td>
	<td align=center><font face="Verdana" size="1">Sump Location </font></td>
	<td align=center><font face="Verdana" size="1">Diameter Length </font></td>
	<td align=center><font face="Verdana" size="1">Sump Depth </font></td>
	<td align=center><font face="Verdana" size="1">Capacity of Sump(ltrs)</font></td>
	<td align=center><font face="Verdana" size="1">Sump Condition</font></td>
	
	
	
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsSumpReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsSumpReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.MpwsSubComponet =='FootPathBridge'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-FOOT PATH BRIDGE-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Bridge Code </font></td>
	<td align=center><font face="Verdana" size="1">Bridge Location </font></td>
	<!-- <td align=center><font face="Verdana" size="1">Bridge Length</font></td>
	<td align=center><font face="Verdana" size="1">Bridge Width </font></td>
	
	<td align=center><font face="Verdana" size="1">Bridge Walk Way Width </font></td>
	<td align=center><font face="Verdana" size="1">Bridge Span Length</font></td> -->
	
	
	
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsFootPathBridgeReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsFootPathBridgeReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>


<c:if test="${sessionScope.MpwsSubComponet =='PumpHouse'}">
<table style="border-collapse: collapse; border: normal;"border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-PUMP HOUSE-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Pump House Code  </font></td>
	<td align=center><font face="Verdana" size="1">Pump House Location</font></td>
	 <td align=center><font face="Verdana" size="1"> Area</font></td>
	<!--<td align=center><font face="Verdana" size="1">Pump House Height </font></td> -->
	
	
	
	
	
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsPumpHouseReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsPumpHouseReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.MpwsSubComponet =='WatchMan'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-WATCH MAN QUARTER-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">WatchMan Quarter Code   </font></td>
	<td align=center><font face="Verdana" size="1">WatchMan Quarter Location</font></td>
	
	
	<!-- <td align=center><font face="Verdana" size="1">WatchMan Quarter Area</font></td>
	<td align=center><font face="Verdana" size="1">No.Of Quarters</font></td> -->
	
	
	
	
	
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsWatchManReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsWatchManReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.MpwsSubComponet =='CwcWell'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-CLEAR WATER COLLECTION WELL-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Clear Water Collection Well Code  </font></td>
	<td align=center><font face="Verdana" size="1">Location</font></td>
	<td align=center><font face="Verdana" size="1">Capacity</font></td>
	
	
	
	
	
	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsCwcWellReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsCwcWellReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>

<c:if test="${sessionScope.MpwsSubComponet=='MicroFilter'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-MICRO FILTER-REPORT</td></tr>


<tr>
	<td align=center><font face="Verdana" size="1">S.No</font></td>
     <td align=center><font face="Verdana" size="1">Panchayat</font></td>
	 <td align=center><font face="Verdana" size="1">Habitation</font></td>
	 <td align=center><font face="Verdana" size="1">Asset Name</font></td>
     <td align=center><font face="Verdana" size="1"> WTP Code </font></td>
     <td align=center><font face="Verdana" size="1">Location </font></td>
     <td align=center><font face="Verdana" size="1">Capacity In MLD </font></td>
     <td align=center><font face="Verdana" size="1">No Of Hours Usage </font></td>
     <td align=center><font face="Verdana" size="1">  No of Units </font></td>
     <td align=center><font face="Verdana" size="1"> Size of Units(LBH in M) </font></td>
     <td align=center><font face="Verdana" size="1">No of Stand By Units </font></td>
     <td align=center><font face="Verdana" size="1">Shelter Existing </font></td>
     <td align=center><font face="Verdana" size="1"> General Performance  </font></td>
     <td align=center><font face="Verdana" size="1">  Extension Scope </font></td>
      <td align=center><font face="Verdana" size="1">Sedimentation Tank  </font></td>
       <td align=center><font face="Verdana" size="1">Horizontal Roughing Filter </font></td>
        <td align=center><font face="Verdana" size="1">Vertical Roughing Filter </font></td>
 	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsMicroFiltersReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsMicroFiltersReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>    


<c:if test="${sessionScope.MpwsSubComponet=='RoPlants'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-HEADWORKS-RO PLANTS-REPORT</td></tr>


<tr>
	<td align=center><font face="Verdana" size="1">S.No</font></td>
     <td align=center><font face="Verdana" size="1">Panchayat</font></td>
	 <td align=center><font face="Verdana" size="1">Habitation</font></td>
	 <td align=center><font face="Verdana" size="1">Asset Name</font></td>
     <td align=center><font face="Verdana" size="1"> WTP Code </font></td>
     <td align=center><font face="Verdana" size="1"> Location </font></td>
     <td align=center><font face="Verdana" size="1">Capacity </font></td>
     <td align=center><font face="Verdana" size="1">  No of Units </font></td>
     <td align=center><font face="Verdana" size="1"> No of Hours Usage </font></td>
     <td align=center><font face="Verdana" size="1">No of Stand By Units </font></td>
     <td align=center><font face="Verdana" size="1">Raw Water Storage Tank Existing  </font></td>
     <td align=center><font face="Verdana" size="1">Product Water Storage Tank Existing  </font></td>
     <td align=center><font face="Verdana" size="1"> Shelter Existing </font></td>
    
 	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsRoPlantsReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsRoPlantsReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>                                 
                                    

<c:if test="${sessionScope.MpwsSubComponet =='GravityMain'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-PIPELINE-GRAVITY MAIN-REPORT</td></tr>
<tr>
 	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Gravity Main Code  </font></td>
	<td align=center><font face="Verdana" size="1"> Length(mts)</font></td> 
	<td align=center><font face="Verdana" size="1">No Of Air Valves </font></td> 
	<td align=center><font face="Verdana" size="1">No Of Scour Valves </font></td> 
	<td align=center><font face="Verdana" size="1">No Of Reflux Valves </font></td> 
	<td align=center><font face="Verdana" size="1"> No Of Sluice Valves</font></td> 
	<td align=center><font face="Verdana" size="1">No of Pipes </font></td> 
	<td align=center><font face="Verdana" size="1">No Of Zero Velocity Valves </font></td> 
	<td align=center><font face="Verdana" size="1">No Of Non Return Valves </font></td> 
    <td align=center><font face="Verdana" size="1">No Of Air Cushion Values </font></td> 
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsGMReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsGMReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.MpwsSubComponet =='Distribution'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-PIPELINE-DISTRIBUTION-REPORT</td></tr>
<tr>
  
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Distribution Code</font></td>
	<td align=center><font face="Verdana" size="1">No. Of Pipes</font></td>
	<td align=center><font face="Verdana" size="1">No. Of Air Valves</font></td>
	<td align=center><font face="Verdana" size="1">Total Length Needed</font></td>
	<td align=center><font face="Verdana" size="1">No. Of Sluice Valves</font></td>
	<td align=center><font face="Verdana" size="1">Total Length Provided</font></td>
	<td align=center><font face="Verdana" size="1">No. Of Scour Valves</font></td>	
	<td align=center><font face="Verdana" size="1">Full Villages Covered </font></td>	
	<td align=center><font face="Verdana" size="1"> No. Of Private House Connections</font></td>	
	<td align=center><font face="Verdana" size="1">Balance Needed in Mts </font></td>	
	<td align=center><font face="Verdana" size="1">No.Of Stand Posts </font></td>	
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsDBReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsDBReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.MpwsSubComponet =='PumpingMain'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">MPWS-PIPELINE-PUMPING MAIN -REPORT</td></tr>
<tr>
  
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Pumping Main Code </font></td>
	
	<td align=center><font face="Verdana" size="1">No.of Air Valves  </font></td>
	<td align=center><font face="Verdana" size="1">No.of Scour Valves </font></td>
	<td align=center><font face="Verdana" size="1"> No.of Reflux Valves</font></td>
	<td align=center><font face="Verdana" size="1">No.of Sluice Valves </font></td>
	<td align=center><font face="Verdana" size="1">No of Pipes Required </font></td>
	<td align=center><font face="Verdana" size="1"> Zero Velocity Valve</font></td>
	<td align=center><font face="Verdana" size="1">Air Cusion Valve </font></td>
	<td align=center><font face="Verdana" size="1">Non Return Valve </font></td>
	 
	 
</tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsPMReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsPMReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.MpwsSubComponet =='Pumpset'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">MPWS-SOURCE-PUMP SETS-REPORT</td></tr>
<tr>
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td> 
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
  	<td align=center><font face="Verdana" size="1">Pump Code</font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<td align=center><font face="Verdana" size="1"> Pump Make </font></td>
	<td align=center><font face="Verdana" size="1">Pump Type </font></td>
	<td align=center><font face="Verdana" size="1">Pump Capacity </font></td>
	<td align=center><font face="Verdana" size="1">Year Of Commissioning</font></td>
	<td align=center><font face="Verdana" size="1">Hours Running Per Day </font></td>
	<td align=center><font face="Verdana" size="1">Usage </font></td>
	<td align=center><font face="Verdana" size="1">Designed Head  </font></td>
	<td align=center><font face="Verdana" size="1">Designed LPM </font></td>
	<!-- <td align=center><font face="Verdana" size="1">Control Pannel  </font></td> -->
	
	<td align=center><font face="Verdana" size="1">Hours Of Power Availability  </font></td>
	<!-- <td align=center><font face="Verdana" size="1">App. Cost Of Urban Feeder Rs.(in Lakhs) </font></td>
	<td align=center><font face="Verdana" size="1">Feasibility Of getting Urban Line  </font></td>
	<td align=center><font face="Verdana" size="1">Distance From Where Urban Line Can Be Had  </font></td> -->
	<td align=center><font face="Verdana" size="1">Low Voltage Problems  </font></td>
	<td align=center><font face="Verdana" size="1">Remarks   </font></td>
			<td align=center><font face="Verdana" size="1">Feeder</td>
	<td align=center><font face="Verdana" size="1">Generator Existing</td>
	

  </tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsPumpSetReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsPumpSetReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.MpwsSubComponet =='Surface'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">MPWS-SOURCE-SURFACE SOURCE -REPORT</td></tr>
<tr>
  
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
  	<td align=center><font face="Verdana" size="1">Source Code</font></td>
  	<td align=center><font face="Verdana" size="1">Source Type</font></td>
  	<td align=center><font face="Verdana" size="1">Sub Source Type</font></td>
	<td align=center><font face="Verdana" size="1">Source Name</font></td>
	<td align=center><font face="Verdana" size="1">Tapping Point </font></td>
	<!-- <td align=center><font face="Verdana" size="1">No. of Habitations Covered  </font></td>
	<td align=center><font face="Verdana" size="1">Population Benefited   </font></td>
	<td align=center><font face="Verdana" size="1">Seasonal  </font></td>  -->
	<td align=center><font face="Verdana" size="1">Source Condition   </font></td>
	<td align=center><font face="Verdana" size="1">Static Water Level  </font></td>
	
	<td align=center><font face="Verdana" size="1">Yield  </font></td>
	<td align=center><font face="Verdana" size="1">Alternative Water Source   </font></td>
	<td align=center><font face="Verdana" size="1">Water Quality  </font></td>
 
	 
  </tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsPumpSetReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsPumpSetReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.MpwsSubComponet =='subSurface'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">MPWS-SOURCE-SUB SURFACE SOURCE -REPORT</td></tr>
<tr>
  
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
  	<td align=center><font face="Verdana" size="1">Source Code</font></td>
	<td align=center><font face="Verdana" size="1">Source Type</font></td>
  	<td align=center><font face="Verdana" size="1">Sub Source Type</font></td>
	 <td align=center><font face="Verdana" size="1">Location</font></td>
	<!--<td align=center><font face="Verdana" size="1">No. of Habitations Covered</font></td>
	<td align=center><font face="Verdana" size="1">Population Benefited</font></td>
	<td align=center><font face="Verdana" size="1">Seasonal</font></td> -->
	<td align=center><font face="Verdana" size="1">Source Condition </font></td>
	<td align=center><font face="Verdana" size="1">Static Water Level</font></td>
	
   <td align=center><font face="Verdana" size="1">Yield  </font></td>
   
	<td align=center><font face="Verdana" size="1">Source Depth(mts)</font></td>
	<td align=center><font face="Verdana" size="1">Alternative Water Source</font></td>
	<td align=center><font face="Verdana" size="1">Water Quality  </font></td>
 
  </tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsPumpSetReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsPumpSetReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.MpwsSubComponet =='Mislaneous'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">MPWS-SOURCE-MISCELLANEOUS-REPORT</td></tr>
<tr>
  
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Component Name</font></td>
	<td align=center><font face="Verdana" size="1">Component Code</font></td>
	<td align=center><font face="Verdana" size="1">Component Location</font></td>
	<td align=center><font face="Verdana" size="1">Remarks</font></td>
  </tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsMislaneReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsMislaneReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.MpwsSubComponet =='Chlorination'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">MPWS-SOURCE-CHLORINATION-REPORT</td></tr>
<tr>
  
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Chlorination Code</font></td>
	<td align=center><font face="Verdana" size="1">Chlorination Location</font></td>
	<td align=center><font face="Verdana" size="1">Working Or Not </font></td>
	<td align=center><font face="Verdana" size="1">Bleaching Powder</font></td>
	<td align=center><font face="Verdana" size="1">Liquid Chlorine</font></td>
	<td align=center><font face="Verdana" size="1">Gas Chlorine</font></td>
	<td align=center><font face="Verdana" size="1">Online Dosage</font></td>
	<td align=center><font face="Verdana" size="1">Remarks</font></td>
  </tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsChlorinationReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsChlorinationReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.MpwsSubComponet =='OandM'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">MPWS-SOURCE-O AND M-REPORT</td></tr>
<tr>
  
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Agency </font></td>
	<td align=center><font face="Verdana" size="1">Power Cost</font></td>
	<td align=center><font face="Verdana" size="1">Consumables </font></td>
	<td align=center><font face="Verdana" size="1">Wages & Others</font></td>
	<td align=center><font face="Verdana" size="1">Total Cost of MTC</font></td>
	<td align=center><font face="Verdana" size="1">Source of Finding </font></td>
	<td align=center><font face="Verdana" size="1">No of House Connections</font></td>
	<td align=center><font face="Verdana" size="1">Traiff/Month</font></td>
	<td align=center><font face="Verdana" size="1">Total Collection/Anum</font></td>
	   
  </tr>

<logic:iterate id="mpwsReport" name="MpwsReport">
						
							<TR>
								<logic:iterate id="MpwsOandMReport" name="mpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="MpwsOandMReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

</body>
</html>
<%@ include file="/commons/rws_footer.jsp"%>