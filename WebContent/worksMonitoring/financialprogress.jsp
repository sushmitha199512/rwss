<%@		taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@		taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@		taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@		taglib uri="/WEB-INF/jstl-core" prefix="c" %>


<html>	
<head>
 <%@ page import="java.util.Date" %>
<%! Date date= new Date(); %>
   <%! int day=date.getDate(); %>  	
   <%! long month=date.getMonth(); %>  
   <%! long year = date.getYear(); %> 
<script>
	
function ppdelete()
{
	//alert("PPPPPPPP");
	

	document.financialForm.cmdDel.value="2";
	document.financialForm.action="/pred/worksMonitoring/InsertFinancialProgress.do";
	document.financialForm.submit();
}
function winClose()
{
	location.href="/Pred/main.jsp";
}
function main()
{
	window.location="main.jsp";
}
</script>





	<title>WATERSOFT</title>

	<link rel="stylesheet" type="text/css" href="resources/style/style.css">
		<link rel="stylesheet" type="text/css" href="resources/style/menu.css">
		

	</head>
	<html:messages id="error">
<%=error%><br>
</html:messages>
		<body>
<html:form action="InsertFinancialProgress"  onsubmit="return validateFinancialForm(this)">

<center>
<span class = "mainHeading">WATERSOFT</span><br>
<span class = "mainHeading">Panchayat Raj & Engineering Department, Rural Water Supply Sector</span> <br>
<span class = "mainHeading">Government of Andhra Pradesh</span>


</center>
	
<center>

	<table cellpadding="0" cellspacing="0" align="center">
		<tr height="95%">
			<td>
	<table cellpadding="0" cellspacing="0" width="750" align="center">
		<tr>
			<td>
	
	<!-- <table cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="resources/images/top_left_b.gif"></td>
			<td background="resources/images/top_center_b.gif" width="100%" class="heading" valign="middle" align="center" class id ="mainheading">Physical Progress Entry Form</td>
			<td><img src="resources/images/top_right_b.gif"></td>
		</tr>
	</table> -->
	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_t_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=723>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#000000" face=verdana size=2><B><center>Financial Progress Entry Form</center></B><font></td>
	    <td align=right><IMG SRC="/pred/resources/images/icon_help.gif" WIDTH="12" HEIGHT="12" >&nbsp;
		<IMG SRC="/pred/resources/images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_t_right1.gif" ALT=""></TD>
</TABLE>

	<table width="100%" bgcolor=#edf2f8 cellpadding="2" cellspacing="2" border="1" bordercolor="#364d67" rules="none" style="border-collapse:collapse">
	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.circle" />
		<td class=label><font color="#000000" face=verdana size=2><B>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=(String)request.getAttribute("circleName")%></td>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.division" />
		<td class=label><font color="#000000" face=verdana size=2><B>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=(String)request.getAttribute("divisionName")%></td>
		
		<td></td>
	
	</tr>
	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.subdivision" />
		<td class=label><font color="#000000" face=verdana size=2><B>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=(String)request.getAttribute("subdivisionName")%></td>
		
	
		<!-- <td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.assettype" />
		<td class=label><font color="#000000" face=verdana size=2><B>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=(String)request.getAttribute("assetName")%></td> -->
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.month"/>
		<td class=label><font color="#000000" face=verdana size=2><B>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=(String)request.getAttribute("monthName")%></td>
		
	</tr>
	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.year" />
		<td class=label><font color="#000000" face=verdana size=2><B>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=request.getParameter("cmbYear")%></td>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.programme" />
		<td class=label><font color="#000000" face=verdana size=2><B>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=session.getAttribute("programmeName")%></td>
	</tr>

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.subprogramme" />
		<td class=label><font color="#000000" face=verdana size=2><B>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=session.getAttribute("subprogrammeName")%></td>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.entereddate" />
		<td class=label><font color="#000000" face=verdana size=2><B>:</td>
		<!-- <td><html:text property="enteredDate" styleClass="btext" /></td> -->
		<td class=label><font color="#000000" face=verdana size=2><B><%=(String)session.getAttribute("date")%></td>

	</tr>
	
	<tr>
		  <td colspan="6"><hr size="1" color="#525e6e"></td>
		</tr> 

	<!-- <tr>
		<td class=label><bean:message key="app.progress.enteredby" />
		<td class=label>:</td>
		<td><html:text property="enteredBy" styleClass="btext" maxlength="5"/></td>

		

	</tr> -->
	<!-- <tr>
		  <td colspan="2"class=label >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upto the Month&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;During the Month</td>	
		</tr>  -->
		 <tr>
		 
		 <td class=label></td>
		 <td class=label></td>
		  <td class=label ><font color="#000000" face=verdana size=2><B>&nbsp;&nbsp;&nbsp;&nbsp;Upto the Month</b></td>
		  <td class=label ><font color="#000000" face=verdana size=2><B>&nbsp;During the Month</b></td>
		</tr>
		 	  
		<tr>
		  <td colspan="6"><hr size="1" color="#525e6e"></td>
		</tr> 
		

	<tr>
		<td class=label align=left><font color="#000000" face=verdana size=2><B><bean:message key="app.finance.releasesuptothemonth" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="relUptoMon" styleClass="btext" /></td>
		
		<!-- <td class=label><bean:message key="app.progress.noproposaldurmon" />
		<td class=label></td> -->
		<td ><html:text property="relDurMon" styleClass="btext" /></td>

	</tr>

	

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.finance.expenditureuptothemonth" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="expUptoMon" styleClass="btext" /></td>

		<!-- <td class=label><bean:message key="app.progress.proposalcostdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="expDurMon" styleClass="btext" /></td>

	</tr>

	<tr>
		  <td colspan="6"><hr size="1" color="#525e6e"></td>
		</tr> 

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.finance.budgetprovisionamt" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="bgtProvisionAmt" styleClass="btext" /></td>

		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.finance.workloadunits" /></b>
		
		<td class=label></td> 
		<td class=label>:&nbsp;<html:text property="workLoadUnits" styleClass="btext" /></td>

	</tr>

	

	<tr>
		  <td colspan="6"><hr size="1" color="#525e6e"></td>
		</tr> 
	
		<TR>
		<TD align=center  colspan=6><html:submit />
		<INPUT class id ="buttonfont" id=button1 type=button value=Exit name=button1 onClick="main()">
		<%
		
		int mno=Integer.parseInt((String)session.getAttribute("ppNumber"));
		System.out.println("number"+mno);
		if (mno==1)
		{
			
		%>
			<html:hidden property="cmdDel" />
		 <INPUT class id ="buttonfont" id=button2 type=button value=Delete name=button2 onClick="ppdelete()"> 
		<%}%>
		</TD>

		</TR>
		</table>
		<tr><td>  
		<!-- <table cellpadding="0" cellspacing="0" width="100%">
		<tr>	

			<td><img src="resources/images/bottom_left.gif"></td>
			<td background="resources/images/bottom_center.gif" width="100%" class="heading" valign="middle"	align="center"></td>
			<td><img src="resources/images/bottom_right.gif"></td>
		</tr>
	</table> -->
	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_b_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=723>
	 <!--  <FONT  style="font-size:9pt" color="#000000"><font color="#FF6666" >*</font>&nbsp;Data mandatory</FONT></td> -->
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_b_right1.gif" ALT=""></TD>
</TABLE>
	</td>
	</tr>
	</table>
	</td></tr></table>

	</html:form>

