 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
 <%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>
 <SCRIPT LANGUAGE="JavaScript">

function closeWin()
{
window.close();
}
function backCal(){
    history.back(1);
}
</script>
<html:html>
<HEAD>
<TITLE></TITLE>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
</HEAD>
<BODY>
<table  width="100%" >
<tr >
<td align="right">
  <A href="#" onclick="closeWin()" >Close</A>&nbsp;&nbsp;&nbsp;
  <A href="#" onclick="backCal()" >Back</A>&nbsp;&nbsp;&nbsp;
 <A href="./rws_asset_pws_print.jsp" target="_Parent" >Print</A>&nbsp;&nbsp;&nbsp;
 
<c:if test="${requestScope.PwsSubComponet=='PwsPumpsetReport'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("PwsPumpSetReport")).size();
%>
<%if(count>0){ %>
<A href="./rws_asset_cpws_xls.jsp?Report=<%session.setAttribute("PwsReport",request.getAttribute("PwsPumpSetReport"));%>
                          <%session.setAttribute("PwsSubComponet","pwspumpsets");%>" 
 target="_new">Excel</A>
</td></tr></table>
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District Name:<%=session.getAttribute("DistrictName")%>&nbsp;
Mandal Name:<%=session.getAttribute("MandalName")%>
</td>
</tr>

<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PWS-SOURCE-PUMPSET-REPORT  
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.No</TH>
						<TH >Panchayat</TH>
						<TH>Habitation</TH>
						<TH>Asset Name</TH>
						<TH>Pump Code   </TH>
						<TH>Location</TH>
						 <TH>Pump Make  </TH>
						<TH>Pump Type   </TH>
						<TH>Pump Capacity </TH>
						<TH>Year Of Commissioning</TH>
						<TH>Hours Running Per Day</TH>
						<TH>Usage  </TH>
						<TH>Designed Head   </TH>
						<TH>Designed LPM   </TH>
						<TH>Control Pannel   </TH>
						<TH>Feeder   </TH>
						<TH>Hours Of Power Availability    </TH>
						<TH>Feasibility Of getting Urban Line  </TH>
						<TH>App. Cost Of Urban Feeder Rs.(in Lakhs)    </TH>
						<TH>Distance From Where Urban Line Can Be Had    </TH>
						<TH>Low Voltage Problems   </TH>
						<TH>Remarks</TH>
					</THEAD>
					<logic:iterate id="cpwsReport" name="PwsMislaneReport"
						scope="request">
						
							<TR>
								<logic:iterate id="PwsMislaneReport" name="cpwsReport" 
									           offset="offset">
									<TD class="mystyle1"><bean:write name="PwsMislaneReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>	
					</logic:iterate>
				</TABLE>
				</td>
 </tr>
</table>
 
    <% }%>
<%if(count==0) {%>
</td></tr></table>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District Name:<%=session.getAttribute("DistrictName")%>&nbsp;
Mandal Name:<%=session.getAttribute("MandalName")%>
</td>
</tr>

<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
PWS-SOURCE-PUMPSET-REPORT   
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder">
                           	<TH>S.No</TH>
                           <TH >Panchayat</TH>
						<TH>Habitation</TH>
						<TH>Asset Name</TH>
						<TH>Pump Code   </TH>
						<TH>Location</TH>
						 <TH>Pump Make  </TH>
						<TH>Pump Type   </TH>
						<TH>Pump Capacity </TH>
						<TH>Year Of Commissioning</TH>
						<TH>Hours Running Per Day</TH>
						<TH>Usage  </TH>
						<TH>Designed Head   </TH>
						<TH>Designed LPM   </TH>
						<TH>Control Pannel   </TH>
						<TH>Feeder   </TH>
						<TH>Hours Of Power Availability    </TH>
						<TH>Feasibility Of getting Urban Line  </TH>
						<TH>App. Cost Of Urban Feeder Rs.(in Lakhs)    </TH>
						<TH>Distance From Where Urban Line Can Be Had    </TH>
						<TH>Low Voltage Problems   </TH>
						<TH>Remarks</TH>
                          </THEAD>
<td align=center colspan="12" class="textborder">
No Records
</td>
</table>
</td>
</tr>
</table>
<%} %>
</c:if>
 </BODY>
</html:html>
<%@ include file="/commons/rws_footer.jsp"%>

