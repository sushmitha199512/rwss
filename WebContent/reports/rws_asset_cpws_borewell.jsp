


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>


 <link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/rwsstyle.css'/>">

<SCRIPT LANGUAGE="JavaScript">
function Print()
{
 //alert("Print this page");
 window.print();
    
}
function GotoPage()
{
  //alert("go");
  var page= document.forms[0].gototextbox.value
  //alert(page)
  page=page-1
  page=page*10
  document.forms[0].action="./SrInfiltrationWellReport.do?pager.offset="+page;
  document.forms[0].submit();
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
<A href="/pred/home.jsp">Home</A>&nbsp;&nbsp;&nbsp;
<A href="./checkList.do" >Back</A>

</td></tr></table>
<c:if test="${requestScope.CpwsSubComponet =='CpwsBoreWell'}">
 <%int count;
  count=((java.util.ArrayList)request.getAttribute("CpwsSourceBorewellReport")).size();
%>
<%if(count>0){ %>
 
<table height="100%">
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District Name:<%=session.getAttribute("DistrictName")%>&nbsp;
Mandal Name:<%=session.getAttribute("MandalName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
 CPWS-SOURCE-BORE WELL-REPORT
</td>
</tr>
<tr>
<td>

               <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.No</TH>
						<TH>Panchayat</TH>
						<TH>Habitation</TH>
						<TH >Source Code </TH>
						<TH>Source Name</TH>
						<TH> Source Type Code </TH>
						<TH>SubSource Type Code</TH>
						<TH>Hab Code </TH>
						<TH>No. of Habitations Covered  </TH>
						<TH>Population Benefited</TH>
						<TH>Seasonal </TH>
						<TH>Present Condition</TH>
						<TH>Water Quality</TH>
						<TH>Static Water Level (lpcd)</TH>
						<TH>Summer Water Level (lpcd)</TH>
						<TH>Yield (lpm)</TH>
						<TH>Distance Near Private Source (kms)</TH>
						<TH>Location   </TH>
						
					</THEAD>
					<logic:iterate id="cpwsReport" name="CpwsSourceBorewellReport"
						scope="request">
							<TR>
								<logic:iterate id="CpwsRwcWellReport" name="cpwsReport" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="CpwsRwcWellReport" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						</logic:iterate>
				</TABLE>
				</td>
</tr>
</table>

<A href="#1" onClick="Print()">Print</A>
 
    <% }%>
<%if(count==0) {%>
<table width="90%"><tr align="center"><td></td></tr></table>
<table>

<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District Name:<%=session.getAttribute("DistrictName")%>&nbsp;
Mandal Name:<%=session.getAttribute("MandalName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td width="974">
 CPWS-SOURCE-BORE WELL-REPORT
</td>
</tr>
<tr>
<td width="974">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
                           <THEAD align=left bgcolor="#8A9FCD" class="textborder" >
                        <TH>S.No</TH>
						<TH>Panchayat</TH>
						<TH>Habitation</TH>
						<TH >Source Code </TH>
						<TH>Source Name</TH>
						<TH> Source Type Code </TH>
						<TH>SubSource Type Code</TH>
						<TH>Hab Code </TH>
						<TH>No. of Habitations Covered  </TH>
						<TH>Population Benefited</TH>
						<TH>Seasonal </TH>
						<TH>Present Condition</TH>
						<TH>Water Quality</TH>
						<TH>Static Water Level (lpcd)</TH>
						<TH>Summer Water Level (lpcd)</TH>
						<TH>Yield (lpm)</TH>
						<TH>Distance Near Private Source (kms)</TH>
						<TH>Location   </TH>
						
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
</BODY>
</html:html>
<%@ include file="/commons/rws_footer.jsp"%>
