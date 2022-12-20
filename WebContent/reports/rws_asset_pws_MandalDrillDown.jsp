 
 <c:if test="${requestScope.PwsSubComponet =='PwsMsl'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-OTHERS-MISCELLANEOUS-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" scope="request">
							<TR>
							    <td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1">
								<a href="./PwsOthersMsl.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					          <tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-OTHERS-MISCELLANEOUS-REPORT   
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
 
 <c:if test="${requestScope.PwsSubComponet =='PwsBpt'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-RESERVOIRS-BPT-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsRvBptReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>

<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-RESERVOIRS-BPT-REPORT   
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
 

<c:if test="${requestScope.PwsSubComponet =='PwsGravityMain'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-PIPELINE-GRAVITY MAIN-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsGravityMainReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-PIPELINE-GRAVITY MAIN-REPORT   
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

 
<c:if test="${requestScope.PwsSubComponet =='PwsSsFilters'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwSsFilterReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
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
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwRsFilterReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
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
 

<c:if test="${requestScope.PwsSubComponet =='PwsSump'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwSumpReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
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
 

<c:if test="${requestScope.PwsSubComponet =='PwsFootPath'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
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
					<logic:iterate id="PwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="PwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwFootPathBridgeReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)PwsReport).getMCode()%>"><bean:write name="PwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="PwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
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
 
 <c:if test="${requestScope.PwsSubComponet =='PwsWatchMan'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwWatchManReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
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
 

<c:if test="${requestScope.PwsSubComponet =='PwsCwcWell'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-COOL WATER COLLECTION WELL-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwCwcWellReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-PUMP HOUSE-REPORT   
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
  
<c:if test="${requestScope.PwsSubComponet =='PwsGlsr'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-RESERVOIRS-GLSR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsGlsrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-RESERVOIRS-GLSR-REPORT     
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

<c:if test="${requestScope.PwsSubComponet =='PwsGlbr'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-RESERVOIRS-GLbR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsGlbrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-RESERVOIRS-GLbR-REPORT     
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
<c:if test="${requestScope.PwsSubComponet =='PwsOhsr'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-RESERVOIRS-OHSR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsohsrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-RESERVOIRS-OHSR-REPORT  
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

<c:if test="${requestScope.PwsSubComponet =='PwsOhbr'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-RESERVOIRS-OHSR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsohbrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-RESERVOIRS-OHSR-REPORT  
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

<c:if test="${requestScope.PwsSubComponet =='Cisterns'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-RESERVOIRS-CISTERNS-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsCisternsReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-RESERVOIRS-CISTERNS-REPORT    
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


<c:if test="${requestScope.PwsSubComponet =='PwsPumpDetails'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>1){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-PUMP SETS-PUMP DEYAILS-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsPumpsetReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==1) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-PUMP SETS-PUMP DEYAILS-REPORT    
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


<c:if test="${requestScope.PwsSubComponet =='PwsPumpHouse'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>1){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEAD WORKS-PUMP HOUSE-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsPumpHouseReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==1) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEAD WORKS-PUMP HOUSE-REPORT    
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


<c:if test="${requestScope.PwsSubComponet =='PwsCapacitors'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-PUMP SETS-CAPACITORS-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsCapacitorsReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-PUMP SETS-CAPACITORS-REPORT    
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

<c:if test="${requestScope.PwsSubComponet =='PwsStandPosts'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-PIPELINE-STAND POSTS-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsPipelineStandpostsReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>&subComp=PWS_PIPELINE_STAND_POSTS"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-PIPELINE-STAND POSTS-REPORT    
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


<c:if test="${requestScope.PwsSubComponet =='PwsPumpingMain'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-PIPELINE-PUMPING MAIN-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsPipelinePumpingmainReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-PIPELINE-PUMPING MAIN-REPORT    
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


<c:if test="${requestScope.PwsSubComponet =='PwsDistribution'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-PIPELINE-DISTRIBUTION-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsPipelineDistributionReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>&subComp=PWS_PIPELINE_DISTRIBUTION"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-PIPELINE-DISTRIBUTION-REPORT   
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


<c:if test="${requestScope.PwsSubComponet =='PwsRwcWell'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEADWORKS-RWC WELL-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwRwcWellReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>&subComp=PWS_SOURCE_INTAKE_WELL"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEADWORKS-RWC WELL-REPORT 
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
 
<c:if test="${requestScope.PwsSubComponet =='HandPumpsBore'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HAND PUMPS- BORE WELL-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./HandpumpsBorewellReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>&subComp=PWS_HANDPUMPS_BORE_WELL"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HAND PUMPS- BORE WELL-REPORT  
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


<c:if test="${requestScope.PwsSubComponet =='PwsSsTank'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-HEAD WORKS-SS TANK-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsHwSsTankReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1"><bean:write name="Mcount" property="sno" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="name" scope="request"/></td>
					          <td class="mystyle1"><bean:write name="Mcount" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-HEAD WORKS-SS TANK-REPORT   
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
  
