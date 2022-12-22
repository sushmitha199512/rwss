
<c:if test="${requestScope.CpwsSubComponet =='Ohsr'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-OHSR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" scope="request">
							<TR>
							    <td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1">
								<a href="./RvOhsrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					          <tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>
    <% }%>    
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-OHSR-REPORT   
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
<c:if test="${requestScope.CpwsSubComponet =='CpwsMsl'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-OTHERS-MISCELLANEOUS-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" scope="request">
							<TR>
							    <td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1">
								<a href="./CpwsOthersMsl.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					          <tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-OTHERS-MISCELLANEOUS-REPORT   
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
<!--  code added by sridhar for Chlorination -->
 <c:if test="${requestScope.CpwsSubComponet =='CpwsChlorination'}">
 <%int count1;
   count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
  %>
<% if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
  District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
 CPWS-OTHERS-CHLORINATION-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" scope="request">
							<TR>
							    <td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1">
								<a href="./CpwsOthersChlorination.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					          <tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>
  <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-OTHERS-CHLORINATION-REPORT   
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

<!--  code  for OandM-->
<c:if test="${requestScope.CpwsSubComponet =='CpwsOandM'}">

<%System.out.println("fgdsfgd");%>
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td> 
CPWS-OTHERS-O AND M-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" scope="request">
							<TR>
							    <td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1">
								<a href="./CpwsOthersOandM.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					          <tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-OTHERS-O AND M-REPORT   
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

<c:if test="${requestScope.CpwsSubComponet =='Ohbr'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-OHBR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./RvOhbrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%> ">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-OHBR-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="2" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='Glsr'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-GLSR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./RvGlsrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-GLSR-REPORT   
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
<c:if test="${requestScope.CpwsSubComponet =='Glbr'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-GLBR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./RvGlbrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-GLBR-REPORT   
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

<c:if test="${requestScope.PwsSubComponet =='PwsBpt'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsRvBptReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
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
// end 
<c:if test="${requestScope.CpwsSubComponet =='Bpt'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-BPT-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./RvBptReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>

<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-BPT-REPORT   
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
<c:if test="${requestScope.CpwsSubComponet =='cpwsCisterns'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-CISTERNS-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./RvCSTReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>

<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-CISTERNS-REPORT  
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

//start
<c:if test="${requestScope.PwsSubComponet =='PwsGravityMain'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsGravityMainReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
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

// end 
<c:if test="${requestScope.CpwsSubComponet =='GravityMain'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-PIPELINE-GRAVITY MAIN-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PlGravityMainReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-PIPELINE-GRAVITY MAIN-REPORT   
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
<c:if test="${requestScope.CpwsSubComponet =='PumpingMain'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-PIPELINE-PUMPING MAIN-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PlPumpingMainReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-PIPELINE-PUMPING MAIN-REPORT   
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
<c:if test="${requestScope.CpwsSubComponet =='Distribution'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-PIPELINE-DISTRIBUTION-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PlDistributionReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-PIPELINE-DISTRIBUTION-REPORT   
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

<c:if test="${requestScope.CpwsSubComponet =='Ohsr'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-OHSR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" scope="request">
							<TR>
							    <td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1">
								<a href="./RvOhsrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					          <tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>
    <% }%>    
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-OHSR-REPORT   
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
<c:if test="${requestScope.CpwsSubComponet =='CpwsMsl'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-OTHERS-MISCELLANEOUS-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" scope="request">
							<TR>
							    <td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1">
								<a href="./CpwsOthersMsl.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					          <tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-OTHERS-MISCELLANEOUS-REPORT   
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
<!--  code added by sridhar for Chlorination -->
 <c:if test="${requestScope.CpwsSubComponet =='CpwsChlorination'}">
 <%int count1;
   count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
  %>
<% if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
  District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
 CPWS-OTHERS-CHLORINATION-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" scope="request">
							<TR>
							    <td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1">
								<a href="./CpwsOthersChlorination.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					          <tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>
  <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-OTHERS-CHLORINATION-REPORT   
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

<!--  code  for OandM-->
<c:if test="${requestScope.CpwsSubComponet =='CpwsOandM'}">

<%System.out.println("fgdsfgd");%>
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td> 
CPWS-OTHERS-O AND M-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" scope="request">
							<TR>
							    <td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1">
								<a href="./CpwsOthersOandM.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					          <tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-OTHERS-O AND M-REPORT   
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

<c:if test="${requestScope.CpwsSubComponet =='Ohbr'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-OHBR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./RvOhbrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%> ">
								<bean:write name="cpwsReport" property="name"/></a></td>
						        <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-OHBR-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                        <TH >MANDAL NAME</TH>
						<TH>TOTAL  NO.</TH>	
                          </THEAD>
<td align=center colspan="2" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
<c:if test="${requestScope.CpwsSubComponet =='Glsr'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-GLSR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./RvGlsrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>">
								<bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-GLSR-REPORT   
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
<c:if test="${requestScope.CpwsSubComponet =='Glbr'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-GLBR-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./RvGlbrReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-GLBR-REPORT   
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

<c:if test="${requestScope.PwsSubComponet =='PwsBpt'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsRvBptReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
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
// end 
<c:if test="${requestScope.CpwsSubComponet =='Bpt'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-BPT-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./RvBptReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>

<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-BPT-REPORT   
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
<c:if test="${requestScope.CpwsSubComponet =='cpwsCisterns'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-RESERVOIRS-CISTERNS-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./RvCSTReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					         <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>

<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-RESERVOIRS-CISTERNS-REPORT  
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

//start
<c:if test="${requestScope.PwsSubComponet =='PwsGravityMain'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PwsGravityMainReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
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

// end 
<c:if test="${requestScope.CpwsSubComponet =='GravityMain'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-PIPELINE-GRAVITY MAIN-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PlGravityMainReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-PIPELINE-GRAVITY MAIN-REPORT   
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
<c:if test="${requestScope.CpwsSubComponet =='PumpingMain'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-PIPELINE-PUMPING MAIN-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PlPumpingMainReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-PIPELINE-PUMPING MAIN-REPORT   
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
<c:if test="${requestScope.CpwsSubComponet =='Distribution'}">
 <%int count1;
  count1=((java.util.ArrayList)request.getAttribute("Mandals")).size();
%>
<%if(count1>0){ %> 
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
CPWS-PIPELINE-DISTRIBUTION-REPORT  
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
					<logic:iterate id="cpwsReport" name="Mandals" length="<%=Integer.toString(count1-1)%>" 
						scope="request">
							<TR>
							
								<td class="mystyle1"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="mystyle1"><a href="./PlDistributionReport.do?districtCode=<%=dcode %>&mandalCode=<%=((rws_asset_cpws_DrillDownBean)cpwsReport).getMCode()%>"><bean:write name="cpwsReport" property="name"/></a></td>
						       <td class="mystyle1"><bean:write name="cpwsReport" property="total"/></td>	
														
							</TR>
					</logic:iterate>
					<tr>
					          <td class="mystyle1">**</td>
					         <td class="mystyle1">Total</td>
					          <td class="mystyle1"><bean:write name="Mcount1" property="total"scope="request"/></td>
					          </tr>
				</TABLE>
				</td>
</tr>
</table>

 
    <% }%>
<%if(count1==0) {%>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District:<%=session.getAttribute("DistrictName")%>
</td></tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
CPWS-PIPELINE-DISTRIBUTION-REPORT   
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
