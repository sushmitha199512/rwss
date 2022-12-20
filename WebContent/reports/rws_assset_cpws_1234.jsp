<c:if test="${requestScope.CpwsSubComponet =='RwcWell'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-RAW WATER COLLECTION WELL-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwRwcWellReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-RAW WATER COLLECTION WELL-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='SsTank'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-SS TANK-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwSsTankReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-SS TANK-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
// start 
<c:if test="${requestScope.PwsSubComponet =='PwsSsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-SS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwSsFilterReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-SS FILTERS-REPORT    
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.PwsSubComponet =='PwsRsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-RS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwRsFilterReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-RS FILTERS-REPORT    
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
// end 
<c:if test="${requestScope.CpwsSubComponet =='SsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-SS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwSsFiltersReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-SS FILTERS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<!--  code added for Micro filters and Ro plants  -->

<c:if test="${requestScope.CpwsSubComponet =='MicroFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-MICRO FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwMicroFiltersReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-MICRO FILTERS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>

<!--  code for  RoPlants  -->

<c:if test="${requestScope.CpwsSubComponet =='RoPlants'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-RO PLANTS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwRoPlantsReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-RO PLANTS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>

<!--  code end  -->
<c:if test="${requestScope.CpwsSubComponet =='RsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-RS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwRsFiltersReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-RS FILTERS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>

// start
<c:if test="${requestScope.PwsSubComponet =='PwsSump'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-SUMP-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwSumpReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-SUMP-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
// end 
<c:if test="${requestScope.CpwsSubComponet =='Sump'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-SUMP-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwSumpReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-SUMP-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.PwsSubComponet =='PwsFootPath'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-FOOT PATH BRIDGE-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="PwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="PwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwFootPathBridgeReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)PwsReport).getMCode()%>"><bean:write name="PwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="PwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-FOOT PATH BRIDGE-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='FootPath'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-FOOT PATH BRIDGE-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwFootPathBridgeReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-FOOT PATH BRIDGE-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
 <c:if test="${requestScope.PwsSubComponet =='PwsWatchMan'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-WATCH MAN QUARTER-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwWatchManReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-WATCH MAN QUARTER-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='WatchMan'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-WATCH MAN QUARTER-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwWatchManReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-WATCH MAN QUARTER-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='PumpHouse'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-PUMP HOUSE-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwPumpHouseReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-PUMP HOUSE-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='RwcWell'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-RAW WATER COLLECTION WELL-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwRwcWellReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-RAW WATER COLLECTION WELL-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='SsTank'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-SS TANK-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwSsTankReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-SS TANK-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
// start 
<c:if test="${requestScope.PwsSubComponet =='PwsSsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-SS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwSsFilterReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-SS FILTERS-REPORT    
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.PwsSubComponet =='PwsRsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-RS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwRsFilterReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-RS FILTERS-REPORT    
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
// end 
<c:if test="${requestScope.CpwsSubComponet =='SsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-SS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwSsFiltersReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-SS FILTERS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<!--  code added for Micro filters and Ro plants  -->

<c:if test="${requestScope.CpwsSubComponet =='MicroFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-MICRO FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwMicroFiltersReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-MICRO FILTERS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>

<!--  code for  RoPlants  -->

<c:if test="${requestScope.CpwsSubComponet =='RoPlants'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-RO PLANTS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwRoPlantsReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-RO PLANTS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>

<!--  code end  -->
<c:if test="${requestScope.CpwsSubComponet =='RsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-RS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwRsFiltersReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-RS FILTERS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>

// start
<c:if test="${requestScope.PwsSubComponet =='PwsSump'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-SUMP-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwSumpReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-SUMP-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
// end 
<c:if test="${requestScope.CpwsSubComponet =='Sump'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-SUMP-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwSumpReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-SUMP-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.PwsSubComponet =='PwsFootPath'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-FOOT PATH BRIDGE-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="PwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="PwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwFootPathBridgeReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)PwsReport).getMCode()%>"><bean:write name="PwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="PwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-FOOT PATH BRIDGE-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='FootPath'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-FOOT PATH BRIDGE-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwFootPathBridgeReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-FOOT PATH BRIDGE-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
 <c:if test="${requestScope.PwsSubComponet =='PwsWatchMan'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-WATCH MAN QUARTER-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwWatchManReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-WATCH MAN QUARTER-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='WatchMan'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-WATCH MAN QUARTER-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwWatchManReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-WATCH MAN QUARTER-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='PumpHouse'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-PUMP HOUSE-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwPumpHouseReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-PUMP HOUSE-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='RwcWell'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-RAW WATER COLLECTION WELL-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwRwcWellReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-RAW WATER COLLECTION WELL-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='SsTank'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-SS TANK-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwSsTankReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-SS TANK-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
// start 
<c:if test="${requestScope.PwsSubComponet =='PwsSsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-SS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwSsFilterReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-SS FILTERS-REPORT    
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.PwsSubComponet =='PwsRsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-RS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwRsFilterReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-RS FILTERS-REPORT    
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
// end 
<c:if test="${requestScope.CpwsSubComponet =='SsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-SS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwSsFiltersReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-SS FILTERS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<!--  code added for Micro filters and Ro plants  -->

<c:if test="${requestScope.CpwsSubComponet =='MicroFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-MICRO FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwMicroFiltersReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-MICRO FILTERS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>

<!--  code for  RoPlants  -->

<c:if test="${requestScope.CpwsSubComponet =='RoPlants'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-RO PLANTS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwRoPlantsReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-RO PLANTS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>

<!--  code end  -->
<c:if test="${requestScope.CpwsSubComponet =='RsFilters'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-RS FILTERS-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwRsFiltersReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-RS FILTERS-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>

// start
<c:if test="${requestScope.PwsSubComponet =='PwsSump'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-SUMP-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwSumpReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-SUMP-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
// end 
<c:if test="${requestScope.CpwsSubComponet =='Sump'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-SUMP-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwSumpReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-SUMP-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.PwsSubComponet =='PwsFootPath'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-FOOT PATH BRIDGE-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="PwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="PwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwFootPathBridgeReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)PwsReport).getMCode()%>"><bean:write name="PwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="PwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-FOOT PATH BRIDGE-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='FootPath'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-FOOT PATH BRIDGE-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwFootPathBridgeReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-FOOT PATH BRIDGE-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
 <c:if test="${requestScope.PwsSubComponet =='PwsWatchMan'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-WATCH MAN QUARTER-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwWatchManReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-WATCH MAN QUARTER-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='WatchMan'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-WATCH MAN QUARTER-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwWatchManReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-WATCH MAN QUARTER-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='PumpHouse'}">
 <%int count2;
  count2=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count2>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-HEADWORKS-PUMP HOUSE-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.NO</TH>
						<TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
					</THEAD>
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count2-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HwPumpHouseReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount2" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count2==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-HEADWORKS-PUMP HOUSE-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="16" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
