<%@ include file="/commons/rws_header1.jsp"%>

<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>

<script language="JavaScript">
function fnShowHabs(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=showHabs&proposalId="+proposalId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
</script>
<%@ include file="/commons/rws_header2.jsp"%>

<table width="75%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/proposals&page=/Workwise.do&mode=circles">Back</a> 
	</td>
</tr>	
</thead>
<tbody>
<tr>
 <td class="reportTitle" align="center">WORK WISE REPORT UNDER RWS-PROJECTS</td>
</tr>
</tbody>
</table>
<table width="75%" align="center" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead class="reportHead">
<tr>
	<th width="3"><bean:message key="app.sno"/></th>
	 
	 <th colspan="2">Description</th>
	 
	<th>Ref</th>
	 
 
 </tr>
</thead>
<tbody class="reportBody">
<% int sno=1;%>
<c:forEach items="${workwiserpt}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
<tr>
	<td>
	<%=sno++ %></td>
	<td><b>Name of the Work</b></td>
	<td width="300" ><b><c:out value="${item.proposalName}"/></b></td>
	 <td>As per AdminiStrative</td>
</tr>	 
 
<tr>
	<td>
	<%=sno++ %></td>
	<td>Estimated Cost(Rs in Lakhs)</td>
	<td align="left"  >
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1" value="${item.estimateCost}" />
	 </td>
	 <td>As per AdminiStrative</td>
</tr>

<tr>
	<td>
	<%=sno++ %></td>
	<td>AdminiStrative Sanctioned Amount(Rs in Lakhs)</td>
	<td align="left" >
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1" value="${item.sanctionedAmount}" />
	</td>
	 <td>As per AdminiStrative</td>
	  
</tr>			 
<tr>
	<td>
	<%=sno++ %></td>
	<td>Grant/Programme</td>
	<td><c:out value="${item.programmeName}" /></td>
	 <td>As per AdminiStrative</td>
	 
</tr>	
<tr>
	<td>
	<%=sno++ %></td>
	<td>No. of Constituencies</td>
     <td><c:out value="${item.noOfConst}" /></td>
	 <td> </td>
	  
</tr>	
<tr>
	<td>
	<%=sno++ %></td>
	<td>No. of Mandals</td>
     <td><c:out value="${item.mandalsCout}" /></td>
	 <td> </td>
	 
</tr>	

<tr>
	<td>
	<%=sno++ %></td>
	<td>No. of Villages</td>
	<td><c:out value="${item.villagesCount}" /></td> 
	 <td> </td>
	 
</tr>	
<tr>
	<td>
	<%=sno++ %></td>
	<td>No. of Habitations sanctioned</td>
	  <td align="left" nowrap><c:out value="${item.noOfHabs}" /> </td>
	 <td>As per AdminiStrative</td>
	  
</tr>	

<tr>
	<td>a</td>
	<td>QA Habs</td>
	  <td align="left" nowrap><c:out value="${item.qaAdmHabs}" /> </td>
	 <td> </td>
	  
</tr>	
<tr>
	<td>i</td>
	<td>Flouride</td>
	  <td align="left" nowrap><c:out value="${item.admFlouride}" /> </td>
	 <td> </td>
	  
</tr>	
<tr>
	<td>ii</td>
	<td>Brackish</td>
	  <td align="left" nowrap><c:out value="${item.admBrackish}" /> </td>
	 <td> </td>
	  
</tr>	 	 
 <tr>
	<td>b</td>
	<td>NC</td>
	  <td align="left" nowrap><c:out value="${item.ncCountAdm}" /> </td>
	 <td> </td>
	  
</tr>
<tr>
	<td>c</td>
	<td>PC1</td>
	  <td align="left" nowrap><c:out value="${item.pc1CountAdm}" /> </td>
	 <td> </td>
	 
</tr>
<tr>
	<td>d</td>
	<td>PC2</td>
	  <td align="left" nowrap><c:out value="${item.pc2CountAdm}" /> </td>
	 <td> </td>
	  
</tr>
<tr>
	<td>e</td>
	<td>PC3</td>
	  <td align="left" nowrap><c:out value="${item.pc3CountAdm}" /> </td>
	 <td> </td>
	  
</tr>
<tr>
	<td>f</td>
	<td>PC4</td>
	  <td align="left" nowrap><c:out value="${item.pc4CountAdm}" /> </td>
	 <td> </td>
	  
</tr>
<tr>
	<td>g</td>
	<td>FC</td>
	  <td align="left" nowrap><c:out value="${item.fcCountAdm}" /> </td>
	 <td> </td>
	  
</tr>

<tr>
	<td><%=sno++ %></td>
	<td>No.of Habitations Sanctioned</td>
	  <td align="left" nowrap><c:out value="${item.noOfTechHabs}" /> </td>
	 <td>As per Technical Sanction </td>
	 
</tr>

<tr>
	<td>a</td>
	<td>QA Habs</td>
	  <td align="left" nowrap><c:out value="${item.qaTecHabs}" /> </td>
	 <td> </td>
	  
</tr>	
<tr>
	<td>i</td>
	<td>Flouride</td>
	  <td align="left" nowrap><c:out value="${item.tecFlouride}" /> </td>
	 <td> </td>
	  
</tr>	
<tr>
	<td>ii</td>
	<td>Brackish</td>
	  <td align="left" nowrap><c:out value="${item.tecBrackish}" /> </td>
	 <td> </td>
	  
</tr>


<tr>
	<td>b</td>
	<td>NC</td>
	  <td align="left" nowrap><c:out value="${item.ncCountTec}" /> </td>
	 <td>  </td>
	  
</tr>
<tr>
	<td>c</td>
	<td>PC1</td>
	  <td align="left" nowrap><c:out value="${item.pc1CountTec}" /> </td>
	 <td>  </td>
	  
</tr>
<tr>
	<td>d</td>
	<td>PC2</td>
	  <td align="left" nowrap><c:out value="${item.pc2CountTec}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>e</td>
	<td>PC3</td>
	  <td align="left" nowrap><c:out value="${item.pc3CountTec}" /> </td>
	 <td>  </td>
	  
</tr>
<tr>
	<td>f</td>
	<td>PC4</td>
	  <td align="left" nowrap><c:out value="${item.pc4CountTec}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>g</td>
	<td>FC</td>
	  <td align="left" nowrap><c:out value="${item.fcCountTec}" /> </td>
	 <td>  </td>
	 
</tr>

<tr>
	<td><%=sno++ %></td>
	<td>Technical Sanction Amount(Rs in Lakhs)</td>
	  <td align="left" nowrap> 
	  <fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
					  	  value="${item.tsAmount}" /></td>
	 <td>  </td>
	 
</tr>
</c:forEach>
</tbody>
</table>
<br>


<!-- HEADER included

<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
<!-- Page header starts here-->
<!-- <tr height="1%">
	<td class="pageHeading" align="center">
		 <bean:message key="app.title1" /> 
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading1" align="center">
		<bean:message key="app.heading1" />
		
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		<bean:message key="app.heading1" />
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;
	</td>
</tr>
<tr height="1%">
	<td >
	<table width="100%" class="userDetails" cellpadding="0" cellspacing="0">
	<tr>
	<td >&nbsp;&nbsp;&nbsp;&nbsp;<b>
		Welcome, <bean:write name="RWS_USER" property="userId" />
				[ <c:out value="${sessionScope.RWS_USER.officeName} User" /> ]
				</b>
				
		</td>
		<td align="right"><b>
				<%=sdf.format(new java.util.Date())%>&nbsp;&nbsp;&nbsp;&nbsp;
       </b></td>
		</tr>
		</table>
	</td>
	
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;
	</td>
</tr>

<!-- Page content starts here -->
<tr height="93%">
	<td align="center">
 
<table width="75%" align="center" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead class="reportHead">
<tr>
	<th width="3"><bean:message key="app.sno"/></th>
	 
	 <th colspan="2">Description</th>
	 
	<th>Ref</th>
	 
 
 </tr>
</thead>
<tbody class="reportBody">
 
<c:forEach items="${workwiserpt}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
<tr>
	<td><%=sno++ %></td>
	<td>Revised Admin Sanction Amount (Rs in Lakhs)</td>
	  <td align="left" width="250"> 
	  <fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
					  	  value="${item.revSanctionedAmount}" />
	  </td>
	 <td> </td>
	 
</tr>
<tr>
	<td><%=sno++ %></td>
	<td>No.of Habitations Sanctioned</td>
	  <td align="left" nowrap><c:out value="${item.noOfRevhHabs}" /> </td>
	 <td>As per Revised Sanction </td>
	 
</tr>

<tr>
	<td>a</td>
	<td>QA Habs</td>
	  <td align="left" nowrap><c:out value="${item.qaRevHabs}" /> </td>
	 <td> </td>
	  
</tr>	
<tr>
	<td>i</td>
	<td>Flouride</td>
	  <td align="left" nowrap><c:out value="${item.revFlouride}" /> </td>
	 <td> </td>
	  
</tr>	
<tr>
	<td>ii</td>
	<td>Brackish</td>
	  <td align="left" nowrap><c:out value="${item.revBrackish}" /> </td>
	 <td> </td>
	  
</tr>

<tr>
	<td>b</td>
	<td>NC</td>
	  <td align="left" nowrap><c:out value="${item.ncCountRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>c</td>
	<td>PC1</td>
	  <td align="left" nowrap><c:out value="${item.pc1CountRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>d</td>
	<td>PC2</td>
	  <td align="left" nowrap><c:out value="${item.pc2CountRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>e</td>
	<td>PC3</td>
	  <td align="left" nowrap><c:out value="${item.pc3CountRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>f</td>
	<td>PC4</td>
	  <td align="left" nowrap><c:out value="${item.pc4CountRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>g</td>
	<td>FC</td>
	  <td align="left" nowrap><c:out value="${item.fcCountRev}" /> </td>
	 <td>  </td>
	 
</tr>

<tr>
	<td><%=sno++ %></td>
	<td>Revised Technical Sanction Amount(Rs in Lakhs)</td>
	  <td align="left" nowrap> 
	  <fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
					  	  value="${item.tsRevAmount}" /></td>
	 <td> As per Revised Tecnical Sanction </td>
	 
</tr>
<tr>
	<td><%=sno++ %></td>
	<td>No. of Habitations sanctioned under RTS</td>
	  <td align="left" nowrap> <c:out value="${item.noOfRevTeHabs}" /> </td>
	 <td> As per Revised Tecnical Sanction </td>
	 
</tr>
<tr>
	<td>a</td>
	<td>QA Habs</td>
	  <td align="left" nowrap><c:out value="${item.qaRevTecHabs}" /> </td>
	 <td> </td>
	  
</tr>	
<tr>
	<td>i</td>
	<td>Flouride</td>
	  <td align="left" nowrap><c:out value="${item.revTecFlouride}" /> </td>
	 <td> </td>
	  
</tr>	
<tr>
	<td>ii</td>
	<td>Brackish</td>
	  <td align="left" nowrap><c:out value="${item. revTecBrackish}" /> </td>
	 <td> </td>
	  
</tr>

<tr>
	<td>b</td>
	<td>NC</td>
	  <td align="left" nowrap><c:out value="${item.ncCountTeRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>c</td>
	<td>PC1</td>
	  <td align="left" nowrap><c:out value="${item.pc1CountTeRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>d</td>
	<td>PC2</td>
	  <td align="left" nowrap><c:out value="${item.pc2CountTeRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>e</td>
	<td>PC3</td>
	  <td align="left" nowrap><c:out value="${item.pc3CountTeRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>f</td>
	<td>PC4</td>
	  <td align="left" nowrap><c:out value="${item.pc4CountTeRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td>g</td>
	<td>FC</td>
	  <td align="left" nowrap><c:out value="${item.fcCountTeRev}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td><%=sno++ %></td>
	<td>Tender Type</td>
	  <td align="left" nowrap><c:out value="${item.tenderTyp}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td><%=sno++ %></td>
	<td>Tender Notice Date</td>
	  <td align="left" nowrap><c:out value="${item.tenderIssDate}" /> </td>
	 <td>  </td>
	  
</tr>
<tr>
<td><%=sno++ %></td>
<td>Tender Notice Published in</td>
<td></td>
 
</tr>
<tr>
	<td>a</td>
	<td>English Newspaper </td>
	  <td align="left" nowrap><c:out value="${item.tenEngPaper}" /> </td>
	 <td>  </td>
 
</tr>
<tr>
	<td>b </td>
	<td>Telugu Newspaper</td>
	  <td align="left" nowrap><c:out value="${item.tenTelPaper}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td><%=sno++ %></td>
	<td>Tenders received on</td>
	  <td align="left" nowrap><c:out value="${item.tenRecievedOn}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
<td><%=sno++ %></td>
<td>Tender approved by</td>
<td></td>
 
</tr>
<tr>
	<td> a</td>
	<td>Tender Committee</td>
	  <td align="left" nowrap><c:out value="${item.tenCommitte}" /> </td>
	 <td>  </td>
 
</tr>
<tr>
	<td>b </td>
	<td>Copmetant authority</td>
	  <td align="left" nowrap><c:out value="${item.tenCompeAu}" /> </td>
	 <td>  </td>
	 
</tr>
 
<tr>
	<td><%=sno++ %></td>
	<td>Tender approved on</td>
	  <td align="left" nowrap><c:out value="${item.tenAppvOn}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td><%=sno++ %></td>
	<td>LOA issued on</td>
	  <td align="left" nowrap><c:out value="${item.tenLoaIssOn}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td><%=sno++ %></td>
	<td>Agreement concluded on</td>
	  <td align="left" nowrap><c:out value="${item.tenAggrDate}" /> </td>
	 <td>  </td>
	 
</tr>
<tr>
	<td><%=sno++ %></td>
	<td>Agency/Contractor Name and address</td>
      <td>
	     <c:out value="${item.tenConName}" /><br>
	     <c:out value="${item.tenconAdd1}" /><br>
         <c:out value="${item.tenconAdd2}" /><br>
         <c:out value="${item.tenconAdd3}" /><br>
      </td>
	 <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Site Habitation</td>
    <td><c:out value="${item.habName}"/></td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Source Code</td>
    <td><c:out value="${item.sourceCode}"/></td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Source Name</td>
    <td><c:out value="${item.sourceName}" /></td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Source Site Handing Over Date</td>
    <td><c:out value="${item.siteHandingOverDate}" /></td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>SubDivision Assigned to</td>
    <td><c:out value="${item.assignedSubdivision}" /></td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Engineers Assigned to</td>
    <td><c:out value="${item.assignedEngg1}" /><br>
        <c:out value="${item.assignedEngg2}" /><br>
        <c:out value="${item.assignedEngg3}" /><br>
        <c:out value="${item.assignedEngg4}" /><br>
    </td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Work Start Date</td>
    <td><c:out value="${item.workStartDate}" /></td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Programme Wise Expenditure Upto Prev. Yr.</td>
    <td>
    <c:set var="names" value="${item.expUptoPreYear}"/>
    <c:forTokens items="${names}" delims="," var="tempMessage">
    <c:out value="${tempMessage}" /> <br/>
    </c:forTokens>
    </td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Year-Month</td>
    <td>
    <c:set var="names" value="${item.yearMonth}"/>
    <c:forTokens items="${names}" delims="," var="tempMessage">
    <c:out value="${tempMessage}" /> <br/>
    </c:forTokens>
    </td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Programme Wise(Expenditure)
    </td>
    <td>
    <c:set var="names" value="${item.programWiseExp}"/>
    <c:forTokens items="${names}" delims="," var="tempMessage">
    <c:out value="${tempMessage}" /> <br/>
    </c:forTokens>
    </td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Total Expenditure</td>
    <td><c:out value="${item.totExpenditure}"/></td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Actual Date Of Completion</td>
    <td><c:out value="${item.dateOfCompletion}" /></td>
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Date of commissioning</td>
    <td><c:out value="${item.dateOfCommmisioning}" /></td>
    
    <td></td>
</tr>
<tr>
    <td><%= sno++ %></td>
    <td>Remarks</td>
    <td><c:out value="${item.remarks}" /></td>
    <td></td>
</tr>
</c:forEach>
</tbody>
</table>
<br>
<center>
<%@ include file="/commons/rws_footer.jsp"%>
</center>
 

 