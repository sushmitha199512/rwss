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
	

	document.physicalForm.cmdDel.value="2";
	document.physicalForm.action="/pred/worksMonitoring/InsertPhysicalProgress.do";
	document.physicalForm.submit();
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


	<html:javascript formName="/InsertPhysicalProgress" />



	<title>WATERSOFT</title>

	<link rel="stylesheet" type="text/css" href="resources/style/style.css">
		<link rel="stylesheet" type="text/css" href="resources/style/menu.css">
		

	</head>
	<html:messages id="error">
<%=error%><br>
</html:messages>
		<body>
<html:form action="InsertPhysicalProgress"  onsubmit="return validatePhysicalForm(this)">

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
	</table>   -->
	 <TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD" >
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_t_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=723>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#000000" face=verdana size=2><B><center>Physical Progress Entry Form</center></B><font></td>
	    <td align=right><IMG SRC="/pred/resources/images/icon_help.gif" WIDTH="12" HEIGHT="12" >&nbsp;
		<IMG SRC="/pred/resources/images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_t_right1.gif" ALT=""></TD>
</TABLE>  
<table width="100%" bgcolor=#edf2f8 cellpadding="2" cellspacing="2" border="1" bordercolor="#364d67" rules="none" style="border-collapse:collapse">
	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.circle" /></b>
		<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
		<td class=label>:</td> 
		<td class=label><font color="#000000" face=verdana size=2><B><%=(String)request.getAttribute("circleName")%></td></b>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.division" /></b>
		 <td class=label>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=(String)request.getAttribute("divisionName")%></b></td> 
		<td></td>
	
	</tr>
	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.subdivision" /></b>
		<td class=label>:</td>
		 <td class=label><font color="#000000" face=verdana size=2><B><%=(String)request.getAttribute("subdivisionName")%></b></td> 
		
	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.assettype" /></b>
		<td class=label>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=(String)request.getAttribute("assetName")%></b></td>
	
	</tr>
	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.month"/></b>
		<td class=label>:</td>
		 <td class=label><font color="#000000" face=verdana size=2><B><%=(String)request.getAttribute("monthName")%></b></td> 

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.common.year" /></b>
		<td class=label>:</td>
		<td class=label><font color="#000000" face=verdana size=2><B><%=request.getParameter("cmbYear")%></b></td>
	</tr>
	
	<tr>

	<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.entereddate" />
		<td class=label>:</td>
		<!-- <td><html:text property="enteredDate" styleClass="btext" /></td> -->
		 <td class=label><font color="#000000" face=verdana size=2><B><%=(String)session.getAttribute("date")%></b></td>
		
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
		  <td class=label><font color="#000000" face=verdana size=2><B>&nbsp;&nbsp;&nbsp;&nbsp;Upto the Month</b></td>
		  <td class=label ><font color="#000000" face=verdana size=2><B>&nbsp;During the Month</b></td>
		</tr>
		<tr>
		  <td colspan="6"><hr size="1" color="#525e6e"></td>
		</tr> 
		<!--  <td><strong><font face=verdena size=3 color=#CC0000>Proposals</font></strong></td> -->
		 <td class=label><font color=#871D0E face=verdana size=2>PROPOSALS</td></font>
		 
		
	<tr>
		<!-- <td class=label align=left><bean:message key="app.progress.noproposaluptomon" /> -->
		<td class=label align=left><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.noproposaluptomon" /></B>
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="noPrpUptoMon" styleClass="btext" maxlength="2"/></td>
		
		<!-- <td class=label><bean:message key="app.progress.noproposaldurmon" />
		<td class=label></td> -->
		<td ><html:text property="noPrpDurMon" styleClass="btext" maxlength="2"/></td>

	</tr>

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.proposalcostuptomon" /></B>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="prpCostUptoMon" styleClass="btext" /></td>

		<!-- <td class=label><bean:message key="app.progress.proposalcostdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="prpCostDurMon" styleClass="btext" /></td>

	</tr>

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.noproposalclruptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="noPrpClrUptoMon" styleClass="btext" maxlength="2"/></td>

		<!-- <td class=label><bean:message key="app.progress.noproposalclrdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="noPrpClrDurMon" styleClass="btext" maxlength="2"/></td>
	</tr>

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.proposalcostclruptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="prpCostClrUptoMon" styleClass="btext" /></td>

		<!-- <td class=label><bean:message key="app.progress.proposalcostclrdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="prpCostClrDurMon" styleClass="btext" /></td>
	</tr>
	
	
	<!-- <td><strong><font face=verdena size=3 color=#CC0000>New Works</font></strong></td> -->
	 <td class=label ><font color=#871D0E face=verdana size=2>NEW WORKS</td><td colspan="5"><hr size="1" color="#525e6e"></td>  
		

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.nonewworkssancuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="noNewWorkSanUptoMon" styleClass="btext" maxlength="2"/></td>

		<!-- <td class=label><bean:message key="app.progress.nonewworkssancdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="noNewWorkSandurMon" styleClass="btext" maxlength="2"/></td>
	</tr>

	<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.nonewworksinproguptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="noNewWorksProgUptoMon" styleClass="btext" maxlength="2"/></td>

		<!-- <td class=label><bean:message key="app.progress.nonewworksinprogdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="noNewWorksProgDurMon" styleClass="btext" maxlength="2"/></td>

		
	</tr>
	
	<!-- <td><strong><font face=verdena size=3 color=#CC0000>Augmented Works</font></strong></td> -->
	<td class=label ><font color=#871D0E face=verdana size=2>AUGMENTED WORKS</td><td colspan="5"><hr size="1" color="#525e6e"></td> 
		
	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.noaugworkssancuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="noAugWorkSanUptoMon" styleClass="btext" maxlength="2"/></td>

		<!-- <td class=label><bean:message key="app.progress.noaugworkssancdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="noAugWorkSandurMon" styleClass="btext" maxlength="2"/></td>
	</tr>

	<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.noaugworksinproguptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="noAugWorksProgUptoMon" styleClass="btext" maxlength="2"/></td>

		<!-- <td class=label><bean:message key="app.progress.noaugworksinprogdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="noAugWorksProgDurMon" styleClass="btext" maxlength="2"/></td>

		
	</tr>
	
<!-- 	<td><strong><font face=verdena size=3 color=#CC0000>&nbsp;Cost&Expenditure</font></strong></td> -->
	<td class=label ><font color=#871D0E face=verdana size=2>COST&EXPENDITURE</td><td colspan="5"><hr size="1" color="#525e6e"></td> 
		
<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.worktendercostuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="workTenderCostUptoMon" styleClass="btext" /></td>

		<!-- <td class=label><bean:message key="app.progress.worktendercostdurmon" />
		<td class=label>:</td> -->
		<td ><html:text property="workTenderCostDurMon" styleClass="btext" /></td>

		
	</tr>
			


	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.perphyprogress" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="perPhyProgress" styleClass="btext" /></td>

		<!-- <td class=label><bean:message key="app.progress.perofoverallexp" />
		<td class=label>:</td> -->
		<td><html:text property="perOfOverallExp" styleClass="btext" /></td>
	</tr>
	
	<!-- <td><strong><font face=verdena size=3 color=#CC0000>&nbsp;Other Works</font></strong></td> -->
	<td class=label ><font color=#871D0E face=verdana size=2>OTHER WORKS</td><td colspan="5"><hr size="1" color="#525e6e"></td> 
		

		<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.costofspoverworksuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="costSpoverWorksUptoMon" styleClass="btext" /></td>

		<!-- <td class=label><bean:message key="app.progress.costofspoverworksdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="costSpoverWorksDurMon" styleClass="btext" /></td>

		
	</tr>
<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.costofongoworksuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="costOngoWorksUptoMon" styleClass="btext" /></td>

		<!-- <td class=label><bean:message key="app.progress.costofongoworksdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="costOngoWorksDurMon" styleClass="btext" /></td>
	</tr>

	<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.totexpinlakhsuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="totExpinLakhsUptoMon" styleClass="btext" /></td>

		<!-- <td class=label><bean:message key="app.progress.totexpinlakhsdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="totExpinLakhsDurMon" styleClass="btext" /></td>

		
	</tr>

	<!-- <td><strong><font face=verdena size=3 color=#CC0000>&nbsp;Total Works</font></strong></td> -->
	<td class=label ><font color=#871D0E face=verdana size=2>TOTAL WORKS</td><td colspan="5"><hr size="1" color="#525e6e"></td> 
		

<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.totalworkvalclearuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="totWorkValClrUptoMon" styleClass="btext" /></td>

		<!-- <td class=label><bean:message key="app.progress.totalworkvalcleardurmon" />
		<td class=label>:</td> -->
		<td><html:text property="totWorkValClrDurMon" styleClass="btext" /></td>

		
	</tr>


<tr>


		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.totnoworkscompuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="totWorksCompUptoMon" styleClass="btext" maxlength="3"/></td>

		<!-- <td class=label><bean:message key="app.progress.totnoworkscompdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="totWorksCompDurMon" styleClass="btext" maxlength="3"/></td>

		
	</tr>

<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.totnoworksgrduptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="totWorksGrdUptoMon" styleClass="btext" maxlength="3"/></td>

		<!-- <td class=label><bean:message key="app.progress.totnoworksgrddurmon" />
		<td class=label>:</td> -->
		<td><html:text property="totWorksGrdDurMon" styleClass="btext" maxlength="3"/></td>

		
	</tr>


<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.totofworksadmsancuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="totWorksAdmsanUptoMon" styleClass="btext" maxlength="3"/></td>

		<!-- <td class=label><bean:message key="app.progress.totnoworksadmsandurmon" />
		<td class=label>:</td> -->
		<td><html:text property="totWorksAdmsanDurMon" styleClass="btext" maxlength="3"/></td>

		
	</tr>


<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.totofworkstechsancuptomon" />
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="totWorksTechsanUptoMon" styleClass="btext" maxlength="3"/></td></b>

		<!-- <td class=label><bean:message key="app.progress.totofworkstechsancdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="totWorksTechsanDurMon" styleClass="btext" maxlength="3"/></td>

		
	</tr>

	<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.totofworkscompuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="totofWorksCompUptoMon" styleClass="btext" maxlength="3"/></td>

		<!-- <td class=label><bean:message key="app.progress.totofworkscompdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="totofWorksCompDurMon" styleClass="btext" maxlength="3"/></td>

		
	</tr>
	<!-- <td><strong><font face=verdena size=3 color=#CC0000>&nbsp;Habitations</font></strong></td> -->
	<td class=label ><font color=#871D0E face=verdana size=2>HABITATIONS</td><td colspan="5"><hr size="1" color="#525e6e"></td>  
		

		<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.noofpchabscovuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="noPCHabsCovUptoMon" styleClass="btext" maxlength="5"/></td>

		<!-- <td class=label><bean:message key="app.progress.noofpchabscovdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="noPCHabsCovDurMon" styleClass="btext" maxlength="5"/></td>

		
	</tr>
<tr>

		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.noofNSShabscovuptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="noNSSHabsCovUptoMon" styleClass="btext" maxlength="5"/></td>

		<!-- <td class=label><bean:message key="app.progress.noofNSShabscovdurmon" />
		<td class=label>:</td> -->
		<td><html:text property="noNSSHabsCovDurMon" styleClass="btext" maxlength="5"/></td>

		
	</tr>


<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.noofpchabstaruptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="noPCHabsTarUptoMon" styleClass="btext" maxlength="5"/></td>

		<!-- <td class=label><bean:message key="app.progress.noofpchabstardurmon" />
		<td class=label>:</td> -->
		<td><html:text property="noPCHabsTarDurMon" styleClass="btext" maxlength="5"/></td>
	</tr>


<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.progress.noofNSShabstaruptomon" /></b>
		
		<td class=label></td>
		<td class=label>:&nbsp;<html:text property="noNSSHabsTarUptoMon" styleClass="btext" maxlength="5"/></td>

		<!-- <td class=label><bean:message key="app.progress.noofNSShabstardurmon" />
		<td class=label>:</td> -->
		<td><html:text property="noNSSHabsTarDurMon" styleClass="btext" maxlength="5"/></td>
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

