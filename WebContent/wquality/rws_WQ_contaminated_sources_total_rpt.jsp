<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<html:html>

<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
<script language="JavaScript">


function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}



</script>






<%


int count=1;
/* String dname=request.getParameter("dname");
String year=request.getParameter("financialYear");
String[] ar=year.split("/");
String yearStart=ar[0];
String yearEnd=ar[1];
String financialYear=ar[2];
String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
		System.out.println("dcode*********"+dcode);
		
} */

 %>
<html:form action="/contaminatedHabs.do">
<html:hidden property="init" value="false"/>
<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>

<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >District:&nbsp;<%=session.getAttribute("dname") %>(<%=session.getAttribute("financialYear") %>)&nbsp;&nbsp; </td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
<td class=gridhdbg ><b>District</b></td>
<td class=gridhdbg ><b>Mandal </b></td>
<td class=gridhdbg ><b>Panchayat </b></td>
<td class=gridhdbg><b>Village </b></td>
<td class=gridhdbg><b>Hab Name </b></td>
<td class=gridhdbg><b>Hab Code </b></td>
<td class=gridhdbg><b>Source Name </b></td>
<td class=gridhdbg><b>Source Code </b></td>
<td class=gridhdbg><b>&nbsp;&nbsp;&nbsp;Prepared&nbsp;On&nbsp; </b></td>
<td class=gridhdbg><b>&nbsp;&nbsp;TDS&nbsp; </b></td>
<td class=gridhdbg><b>Fluoride </b></td>
<td class=gridhdbg><b>Iron </b></td>
<td class=gridhdbg><b>Salinity </b></td>
<td class=gridhdbg><b>Nitrate </b></td>




  </tr>


	<%

	int styleCount=0;
	String style="";
	
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
	
	
%>
<logic:iterate id="contaminatedSourcesView" name="contaminatedSourcesView">
<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="districtName" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="mandal" /></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="panchayat" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="village" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="habName" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="habCode" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="sourceName" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="sourceCode" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="preparedOn" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="tds1" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="floride1" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="iron1" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="selinity1" /></td>
<td class="<%=style %>" style="text-align: left;" align="right"><bean:write name="contaminatedSourcesView" property="nitrate1" /></td>
</tr>
</logic:iterate>
	
</table>
</html:form>
</html:html>
