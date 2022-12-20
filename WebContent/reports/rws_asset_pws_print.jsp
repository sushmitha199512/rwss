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
 
<c:if test="${sessionScope.PwsSubComponet =='Ohsr'}">
<table style="  border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>
  

<tr>

<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%>&nbsp;&nbsp;&nbsp
Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>
<td colspan=20> <font face="Verdana" size="1">PWS-RESERVOIRS-OHSR-REPORT </td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">OHSR Code</font></td>
	<td align=center><font face="Verdana" size="1">No&nbsp;of&nbsp;Habitations&nbsp;Linked</font></td>
	<td align=center><font face="Verdana" size="1">OHSR Location</font></td>
	<td align=center><font face="Verdana" size="1">OHSR Capacity In Lts</font></td>
	<td align=center><font face="Verdana" size="1">No.Of Fillings</font></td>
	<td align=center><font face="Verdana" size="1">OHSR Staging(Mts)</font></td>
	<td align=center><font face="Verdana" size="1">Water Quality</font></td>
	 <!-- commented by pranavi on 23-04-09 -->
 	<!--<td align=center><font face="Verdana" size="1">Lowest Water Level(LWL)</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">Maximum Water Level(MWL)</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">OHSR Fill In Hrs</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">OHSR Empty In Hrs</font></td>-->
	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsOhsrReport1" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsOhsrReport1" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.PwsSubComponet =='Ohbr'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black"   width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%>&nbsp;&nbsp;&nbsp;
   Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>
<td colspan=20> <font face="Verdana" size="1">PWS-RESERVOIRS-OHBR-REPORT </td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">HBR Code </font></td>
	<td align=center><font face="Verdana" size="1">HBR Location </font></td>
	<td align=center><font face="Verdana" size="1">HBR Capacity In Lts </font></td>
	<td align=center><font face="Verdana" size="1">HBR Staging(Mts) </font></td>
	 <!-- commented by pranavi on 23-04-09 -->
	<!--<td align=center><font face="Verdana" size="1">Lowest Water Level(LWL)</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">Maximum Water Level(MWL) </font></td>-->
	<!--<td align=center><font face="Verdana" size="1">OHBR Fill In Hrs.</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">OHBR Empty In Hrs</font></td>-->

	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsOhbrReport1" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsOhbrReport1" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>

<c:if test="${sessionScope.PwsSubComponet =='Glsr'}">
<table style="border-collapse: collapse; border: normal;" border=1  bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>
<td colspan=20> <font face="Verdana" size="1">PWS-RESERVOIRS-GLSR-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">GLSR Code  </font></td>
	<td align=center><font face="Verdana" size="1">Habitation Linkages </font></td>
	<td align=center><font face="Verdana" size="1">GLSR Location</font></td>
	<td align=center><font face="Verdana" size="1">GLSR Capacity In Lts  </font></td>
	<td align=center><font face="Verdana" size="1">No.Of Fillings</font></td>
	<td align=center><font face="Verdana" size="1">Water Quality</font></td>
	 <!-- commented by pranavi on 23-04-09 -->
	<!--<td align=center><font face="Verdana" size="1">Lowest Water Level(MWL) </font></td>-->
	<!--<td align=center><font face="Verdana" size="1">Maximum Water Level(MWL) </font></td>-->
	<!--<td align=center><font face="Verdana" size="1">GLSR Fill In Hrs</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">GLSR Empty In Hrs</font></td>-->

	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsGlsrReport1" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsGlsrReport1" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>


<c:if test="${sessionScope.PwsSubComponet =='Glbr'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black"  width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-RESERVOIRS-GLBR-REPORT</td></tr>
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

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsGlbrReport1" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsGlbrReport1" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>
<c:if test="${sessionScope.PwsSubComponet =='Bpt'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-RESERVOIRS-BPT-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">BPT Code  </font></td>
	<td align=center><font face="Verdana" size="1">Location  </font></td>
	
	<td align=center><font face="Verdana" size="1">BPT Capacity in Lts</font></td>
	<td align=center><font face="Verdana" size="1">BPT Staging(Mts) </font></td>
 	<!-- Commented by pranavi on 23-04-09 -->
 	<!--<td align=center><font face="Verdana" size="1">Maximum Water Level(Mts)</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">Minimum Water Level(Mts)</font></td>-->
 </tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsBptReport1" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsBptReport1" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr> 
</c:if>
<c:if test="${sessionScope.PwsSubComponet =='Cisterns'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-RESERVOIRS-CISTERNS-REPORT</td></tr>
<tr>
    <td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Cistern Code </font></td>
	
	<td align=center><font face="Verdana" size="1">Location</font></td>
	<td align=center><font face="Verdana" size="1">Capacity in Lts </font></td>
	
	<td align=center><font face="Verdana" size="1">Cistern Platform   </font></td>
	<td align=center><font face="Verdana" size="1"> Platform Existing </font></td>
	 
	<td align=center><font face="Verdana" size="1">Platform Condition </font></td>
	<td align=center><font face="Verdana" size="1">Drain Provided </font></td>
	<td align=center><font face="Verdana" size="1">Water Quality </font></td>
	
	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsCSTReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsCSTReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr> 
</c:if>

<c:if test="${sessionScope.PwsSubComponet =='RwcWell'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-RWC WELL-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Raw Water Collection Well Code</font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<td align=center><font face="Verdana" size="1">Capacity </font></td>
	<!-- commented by pranavi on 22-04-09 -->
	<!--<td align=center><font face="Verdana" size="1">Type Of Flooring</font></td>-->
	</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsRwcWellReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsRwcWellReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.PwsSubComponet =='SsTank'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-SS TANK-REPORT</td></tr>
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
	

	<!-- commented by pranavi on 22-04-09 -->
	<!--<td align=center><font face="Verdana" size="1">Type Of Power Connection  </font></td>-->
	<!--<td align=center><font face="Verdana" size="1">No Of Hours Availability Of Power Per Day </font></td>-->
	
	
	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsSsTankReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsSsTankReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>


<c:if test="${sessionScope.PwsSubComponet =='SsFilter'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-SS FILTERS-REPORT</td></tr>
<tr>
                    
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">WTP Code</font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<td align=center><font face="Verdana" size="1">Capacity In MLD </font></td>
	<td align=center><font face="Verdana" size="1">No of Units </font></td>
	<td align=center><font face="Verdana" size="1">No of Hours Usage</font></td>
 	<td align=center><font face="Verdana" size="1">Size of Units(LBH in M)</font></td>
	<td align=center><font face="Verdana" size="1">No of Stand By Units </font></td>
	<td align=center><font face="Verdana" size="1">Frequency Of Sand Scrapping</font></td>
 	
	<td align=center><font face="Verdana" size="1">General Performance  </font></td>
	
	<td align=center><font face="Verdana" size="1">Extension Scope </font></td>
	<td align=center><font face="Verdana" size="1">Sedmentation Tank </font></td>
	<td align=center><font face="Verdana" size="1">Horizontal Roughing Filter </font></td>
	<td align=center><font face="Verdana" size="1">Horizontal Roughing Filter </font></td>
	
 	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsSsFiltersReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsSsFiltersReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.PwsSubComponet =='RsFilter'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-RS FILTERS-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">WTP Code </font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<td align=center><font face="Verdana" size="1">Capacity In MLD </font></td>
	<td align=center><font face="Verdana" size="1">No of Units </font></td>
	<td align=center><font face="Verdana" size="1">No of Hours Usage </font></td>
 	<td align=center><font face="Verdana" size="1">Size of Units(LBH in M)</font></td>
	<td align=center><font face="Verdana" size="1">No of Stand By Units </font></td>
	<td align=center><font face="Verdana" size="1">Frequency Of Sand Wash </font></td>
	<td align=center><font face="Verdana" size="1">Clarifloculator  </font></td>
	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsRsFiltersReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsRsFiltersReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.PwsSubComponet =='Sump'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-SUMP-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Sump Code </font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<td align=center><font face="Verdana" size="1">Diameter/Length </font></td>
	<td align=center><font face="Verdana" size="1">Sump Depth </font></td>
	<td align=center><font face="Verdana" size="1">Capacity of Sump(ltrs)</font></td>
	<!--<td align=center><font face="Verdana" size="1">No.of Hours Required for filling  </font></td>-->
	<!--<td align=center><font face="Verdana" size="1">No.of Hours Required to empty </font></td>-->
	<td align=center><font face="Verdana" size="1">Sump Condition</font></td>
	
	
	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsSumpReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsSumpReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.PwsSubComponet =='FootPathBridge'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-FOOT PATH BRIDGE-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Bridge Code </font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>

	<!--<td align=center><font face="Verdana" size="1">Bridge Type </font></td>-->
	<!--<td align=center><font face="Verdana" size="1">Bridge Length</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">Bridge Width </font></td>-->
	
	<!--<td align=center><font face="Verdana" size="1">Bridge Walk Way Width </font></td>-->
	<!--<td align=center><font face="Verdana" size="1">Bridge Span Length</font></td>-->	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsFootPathBridgeReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsFootPathBridgeReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>


<c:if test="${sessionScope.PwsSubComponet =='PumpHouse'}">
<table style="border-collapse: collapse; border: normal;"border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-PUMP HOUSE-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Pump House Code  </font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<td align=center><font face="Verdana" size="1">Pump House Area(Sq.Mts)</font></td>
	<!--<td align=center><font face="Verdana" size="1">Pump House Height </font></td>-->
	
	
	
	
	
	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsPumpHouseReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsPumpHouseReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.PwsSubComponet =='WatchMan'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-WATCH MAN QUARTER-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">WatchMan Quarter Code   </font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<!-- commented by pranavi on 23-04-09 -->
	<!--<td align=center><font face="Verdana" size="1">WatchMan Quarter Type</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">WatchMan Quarter Area</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">No.Of Quarters</font></td>-->
	
	
	
	
	
	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsWatchManReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsWatchManReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.PwsSubComponet =='CwcWell'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-CLEAR WATER COLLECTION WELL-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Clear Water Collection Well Code  </font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<td align=center><font face="Verdana" size="1">Capacity(in lts)</font></td>
	
	
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsCwcWellReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsCwcWellReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>

<c:if test="${sessionScope.PwsSubComponet =='MicroFilter'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-MICRO FILTER-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">WTP Code </font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<td align=center><font face="Verdana" size="1">Capacity In MLD </font></td>
	<td align=center><font face="Verdana" size="1">No of Units </font></td>
	<td align=center><font face="Verdana" size="1">No of Hours Usage </font></td>
 	<td align=center><font face="Verdana" size="1">Size of Units(LBH in M)</font></td>
	<td align=center><font face="Verdana" size="1">No of Stand By Units </font></td>
	<td align=center><font face="Verdana" size="1">Shelter Existence </font></td>
	<td align=center><font face="Verdana" size="1">General Performance </font></td>
	<td align=center><font face="Verdana" size="1">Extension Scope </font></td>
	<td align=center><font face="Verdana" size="1">Sedimentation Tank</font></td>
	<td align=center><font face="Verdana" size="1">Horizontal Roughing Filter</font></td>
	<td align=center><font face="Verdana" size="1">Vertical Roughing Filter</font></td>
	
		
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsMicroFiltersReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsMicroFiltersReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>
 
</c:if>
<c:if test="${sessionScope.PwsSubComponet =='RoPlants'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-HEADWORKS-RO PLANTS-REPORT</td></tr>
<tr>
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">WTP Code </font></td>
	<td align=center><font face="Verdana" size="1">Location </font></td>
	<td align=center><font face="Verdana" size="1">Capacity </font></td>
	<td align=center><font face="Verdana" size="1">No of Units </font></td>
	<td align=center><font face="Verdana" size="1">No of Hours Usage </font></td>
 	
	<td align=center><font face="Verdana" size="1">No of Stand By Units </font></td>
	<td align=center><font face="Verdana" size="1">Raw Water Storage Tank Existing</font></td>
	<td align=center><font face="Verdana" size="1">Product Water Storage Tank Existing </font></td>
	<td align=center><font face="Verdana" size="1">Shelter Existing  </font></td>
	
</tr>
 
<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsRoPlantsReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsRoPlantsReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
	
	
	

<c:if test="${sessionScope.PwsSubComponet =='GrravityMain'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-PIPELINE-GRAVITY MAIN-REPORT</td></tr>
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
	<td align=center><font face="Verdana" size="1">No of Pipes  </font></td> 
	<td align=center><font face="Verdana" size="1">No of Zero Velocity Valves</font></td> 
	<td align=center><font face="Verdana" size="1">No of Air Cushion Valves </font></td> 
	<td align=center><font face="Verdana" size="1">Non Return Valve</font></td> 
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsGMReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsGMReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.PwsSubComponet =='Distribution'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-PIPELINE-DISTRIBUTION-REPORT</td></tr>
<tr>
  
	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Distribution Code</font></td>
	
	<td align=center><font face="Verdana" size="1">No of Pipes Required </font></td>
	<td align=center><font face="Verdana" size="1">No. Of Air Valves</font></td>
	<td align=center><font face="Verdana" size="1">Total Length Needed(Mts)</font></td>
	<td align=center><font face="Verdana" size="1">No. Of Sluice Valves</font></td>
	<td align=center><font face="Verdana" size="1">Total Length Provided(Mts)</font></td>
	<td align=center><font face="Verdana" size="1">No. Of Scour Valves</font></td>	
	<td align=center><font face="Verdana" size="1">Full Villages Covered </font></td>	
	<td align=center><font face="Verdana" size="1"> No. Of Private House Connections</font></td>	
	<td align=center><font face="Verdana" size="1">Balance Needed in Mts </font></td>	
	<td align=center><font face="Verdana" size="1">No.Of Stand Posts </font></td>		
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsDBReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsDBReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.PwsSubComponet =='PumpingMain'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=20> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=20> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=20> <font face="Verdana" size="1">PWS-PIPELINE-PUMPING MAIN-REPORT</td></tr>
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
	<td align=center><font face="Verdana" size="1">Air Cushion Valve </font></td>
	<td align=center><font face="Verdana" size="1">Non Return Valve </font></td>
	 
	 
</tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsPMReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsPMReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.PwsSubComponet =='pwspumpsets'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">PWS-PUMPING-PUMP SETS-REPORT</td></tr>
<tr>
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<!-- commented by pranavi on 24-04-09 -->
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
	<!--<td align=center><font face="Verdana" size="1">Control Pannel  </font></td>-->

	<td align=center><font face="Verdana" size="1">Hours Of Power Availability  </font></td>
	<!--<td align=center><font face="Verdana" size="1">App. Cost Of Urban Feeder Rs.(in Lakhs) </font></td>-->
	<!--<td align=center><font face="Verdana" size="1">Feasibility Of getting Urban Line  </font></td>-->
	<!--<td align=center><font face="Verdana" size="1">Distance From Where Urban Line Can Be Had  </font></td>-->
	<td align=center><font face="Verdana" size="1">Low Voltage Problems  </font></td>
	<td align=center><font face="Verdana" size="1">Remarks   </font></td>
	<td align=center><font face="Verdana" size="1">Feeder</td>
	<td align=center><font face="Verdana" size="1">Generator Existing</td>
	
  </tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsPumpSetReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsPumpSetReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.PwsSubComponet =='Surface'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">PWS-SOURCE-SURFACE SOURCE -REPORT</td></tr>
<tr>
  
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
  	<td align=center><font face="Verdana" size="1">Source Code</font></td>
  	<td align=center><font face="Verdana" size="1">Source Type</font></td>
  	<td align=center><font face="Verdana" size="1">Sub Source Type</font></td>
	<td align=center><font face="Verdana" size="1">Source Name</font></td>
	<td align=center><font face="Verdana" size="1">Location</font></td>
	<td align=center><font face="Verdana" size="1">Source Condition   </font></td>
	<td align=center><font face="Verdana" size="1">Static Water Level  </font></td>
	<td align=center><font face="Verdana" size="1">Yield  </font></td>
	<td align=center><font face="Verdana" size="1">Alternative Water Source   </font></td>
	<td align=center><font face="Verdana" size="1">Water Quality  </font></td>
 
	 
  </tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsPumpSetReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsPumpSetReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.PwsSubComponet =='subSurface'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">PWS-SOURCE-SUB SURFACE SOURCE -REPORT</td></tr>
<tr>
  
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
  	<td align=center><font face="Verdana" size="1">Source Code</font></td>
	<td align=center><font face="Verdana" size="1">Source Type</font></td>
  	<td align=center><font face="Verdana" size="1">Sub Source Type</font></td>
	<td align=center><font face="Verdana" size="1">Location</font></td>
	<!-- commented by pranavi on 22-04-09 -->
	<!--<td align=center><font face="Verdana" size="1">No. of Habitations Covered</font></td>-->
	<!--<td align=center><font face="Verdana" size="1">Population Benefited</font></td>-->
	
	<td align=center><font face="Verdana" size="1">Source Condition </font></td>
	<td align=center><font face="Verdana" size="1">Static&nbsp;Water&nbsp;Level&nbsp;From&nbsp;Ground(Avg)(in Mts)</font></td>
	<!--<td align=center><font face="Verdana" size="1">Summer Water Level</font></td>-->
   <td align=center><font face="Verdana" size="1">Yield  </font></td>
   <!--<td align=center><font face="Verdana" size="1"> Source Diameter(mm)</font></td>-->
	<td align=center><font face="Verdana" size="1">Source Depth(mts)</font></td>
	<td align=center><font face="Verdana" size="1">Alternative Water Source</font></td>
	<td align=center><font face="Verdana" size="1">Water Quality  </font></td>
 
  </tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsPumpSetReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsPumpSetReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.PwsSubComponet =='Mislaneous'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">PWS-SOURCE-MISCELLANEOUS-REPORT</td></tr>
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

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsMislaneReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsMislaneReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>

<c:if test="${sessionScope.PwsSubComponet =='Chlorination'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">CPWS-OTHERS-CHLORINATION-REPORT</td></tr>
<tr>
  
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Chlorination Code</font></td>
	<td align=center><font face="Verdana" size="1">Chlorination Location </font></td>
	<td align=center><font face="Verdana" size="1">Working or Not</font></td>
	<td align=center><font face="Verdana" size="1">Bleaching Powder</font></td>
	<td align=center><font face="Verdana" size="1">Liquid Chlorine</font></td>
	<td align=center><font face="Verdana" size="1">Gas Chlorine</font></td>
	<td align=center><font face="Verdana" size="1">Online Dosage</font></td>
	
	<td align=center><font face="Verdana" size="1">Remarks</font></td>
	
   
 
  </tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsChlorinationReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsChlorinationReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
<c:if test="${sessionScope.PwsSubComponet =='OandM'}">
<table style="border-collapse: collapse; border: normal;" border=1 bordercolor="black" width="400px" align=center>

<tr>
<td colspan=30> <font face="Verdana" size="1">District Name:<%=session.getAttribute("DistrictName")%></td></tr>
<td colspan=30> <font face="Verdana" size="1">Mandal Name:<%=session.getAttribute("MandalName")%> </td></tr>

<td colspan=30> <font face="Verdana" size="1">CPWS-SOURCE-O AND M-REPORT</td></tr>
<tr>
  
  	<td align=center><font face="Verdana" size="1">SNo</font></td>
	<td align=center><font face="Verdana" size="1">Panchayat</font></td>
	<td align=center><font face="Verdana" size="1">Habitation </font></td>
	<td align=center><font face="Verdana" size="1">Asset Name</font></td>
	<td align=center><font face="Verdana" size="1">Agency</font></td>
	<td align=center><font face="Verdana" size="1">Power Cost</font></td>
	<td align=center><font face="Verdana" size="1">Consumables</font></td>
	<td align=center><font face="Verdana" size="1">Wages & Others</font></td>
	<td align=center><font face="Verdana" size="1">Total Cost of MTC</font></td>
	<td align=center><font face="Verdana" size="1">Source of Finding</font></td>
	<td align=center><font face="Verdana" size="1">Traiff/Month</font></td>
	
	<td align=center><font face="Verdana" size="1">Total Collection/Anum</font></td>
  </tr>

<logic:iterate id="cpwsReport" name="PwsReport">
						
							<TR>
								<logic:iterate id="CpwsOandMReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsOandMReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
</table>
</td></tr>

</c:if>
</body>
</html>
<%@ include file="/commons/rws_footer.jsp"%>